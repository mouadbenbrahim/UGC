public with sharing class SM_Acquisition {
//TODO prendre en compte si code X sur un contrat existant et abo en stand , il faut tagger la souscription pour quel soit resilier plus tard par SC ou en automatique.
// il faut recevoir un code d'Hermes si ce cas se presente, ce code doit etre communique par les autorisation a Hermes et redescendre vers SF.
//TODO le premier du mois en Stand CDI : il faut encaisser juste les FD, la mensualite se fait par le payment run, donc payement partiel sur une partie de la facture genere.ApexPages
    
    public static String accessToken, zEntityId;

    public SM_Acquisition() {

    }

    public static Map<String,Object> acquisition(WSZ.SubOpeIn acqIn, Boolean isPreview){
        
        String invoiceFileUrl,payMethodId,paymentId,caseId,invoiceId,fileImpId, zDocId;
        Boolean compteBloque = false;
        Boolean rembourser = false;
        String intituleOffreFR,intituleOffreNL;
        Map<String,Object> returnObj = new Map<String,Object>();
        WSZ.Preview previewOut = new WSZ.Preview();
        WSZ.SubOpeOut acqOut = new WSZ.SubOpeOut();
        List<String> sDocjobIds = new List<String>{'idjob1','idjob2'};
        zc_ZObjectUpdate zObj;
        

        //Decimal abonnement=0,montantInitial=0,fraisAdhesion=0,fraisAdhesionRemise=0,fraisAdhesionApresRemise=0,prorata=0;
        Date dateJourDebutContrat = Date.newinstance(acqIn.dateDebutContrat.year(), acqIn.dateDebutContrat.month(), acqIn.dateDebutContrat.day()); 
        String acqInStr = JSON.serialize(acqIn);
        ProcessLog__c pLog = new ProcessLog__c(Process__c = 'acquisition', Account__c = acqIn.accountSFID, Message__c = acqInStr);
        String produit = acqIn.produit; // acqIn.produit.get(0);
        String typeContrat = (produit.contains('CDI')?'CDI':'CDD');
        Boolean isFutur = (acqIn.dateDebutContrat <= Datetime.now())?false:true;

        //###### get subOffres ######
        // WSZ.SubProduct subOffre = SM_Offre.getSubOffres(new WSZ.SubOffreIn(acqIn.dateDebutContrat, acqIn.lieu, acqIn.agent, acqIn.coupon,acqIn.accountSFID, 'acquisition', produit)).get(0);
        // List<zc_AmendmentRatePlanData> subOffreRatePlans = SM_Offre.convertRatePlan(subOffre.subscribeToRatePlans);

        //###### get subOffres ######
        Map<String,Object> offreProxyOut = SM_Offre.getOffreProxy(acqIn.dateDebutContrat, acqIn.lieu, acqIn.agent, acqIn.coupon, acqIn.accountSFID, 'acquisition', produit);
        WSZ.SubProduct subOffre = (WSZ.SubProduct)offreProxyOut.get('offre');
        List<zc_AmendmentRatePlanData> subOffreRatePlans = (List<zc_AmendmentRatePlanData>)offreProxyOut.get('offreRatePlans');
        if (subOffre == null || subOffreRatePlans == null) throw new RTException(RTExceptionCode.ERREUR_DESABO_COUPON_ABOTIER,pLog);

        
        //###### get AccountData ######
        Account porteur = SM_Account.getAccountData(acqIn.accountSFID);
        Account payeur = SM_Account.getAccountData(acqIn.payeurSFID);
        
        // check:
        if (acqIn.codeOffreCo != null && acqIn.codeOffreCo != subOffre.CodeOffreCo) {
            throw new RTException(RTExceptionCode.ERREUR_DESABO_COUPON_ABOTIER,pLog);
        }

        //token/entity
        accessToken = WS001_CallZuora.access_token;
        zEntityId = WS001_CallZuora.getZuoraEntityId(porteur.CodePays__c);  

        //###### Subscribe ######
        Map<String,Object> customSub = new Map<String,Object>{'IsB2B'=>subOffre.IsB2B, 'isPreview'=>isPreview, 'codeOffreCo'=>subOffre.CodeOffreCo};
        //customSub.put('IsB2B', subOffre.IsB2B);
        SM_Subscribe.SubscribeIn subIn = SM_Subscribe.mapToSubscribeIn(acqIn);
        zc_ProxyActionsubscribeRequest subscribeReq = SM_Subscribe.subscribe(subIn, isPreview, porteur, payeur, subOffreRatePlans, customSub);
        zc_ProxySubscribeResult subRes = zc_Api.actionSubscribePOST(accessToken, zEntityId, subscribeReq, RTExceptionCode.ERREUR_IMPAYE_REGLER_APPLICATION_FRAIS, pLog);

        if (isPreview){          
            previewOut = SM_Subscribe.parsePreview(subRes, offreProxyOut);
            previewOut.dateDebutContrat = dateJourDebutContrat;
            zc_SubscribeRequestSubscriptionDataSub subDataSub = subscribeReq.subscribes.get(0).subscriptionData.subscription;
            if (subDataSub.termType == 'TERMED'){
                if (subDataSub.initialTermPeriodType == 'Month' ) previewOut.dateFinContrat = subDataSub.termStartDate.addMonths(subDataSub.initialTerm).addDays(-1);             
            }else if (subDataSub.termType == 'EVERGREEN') {
                previewOut.dateFinContrat = null;
            }

        }else {
        String accountZID = subRes.results.get(0).accountId;
        invoiceId = subRes.results.get(0).invoiceId;
        String subscriptionZID = subRes.results.get(0).subscriptionId;
        String subscriptionName = subRes.results.get(0).subscriptionNumber;

        // TODO: OK: Update Account DefPaymentMethodId (car ne fonctionne pas avec action/subscribe)
        zc_ProxyActionupdateRequest accUpdateReq = new zc_ProxyActionupdateRequest();
        if ((acqIn.mandateId == null || acqIn.iban == null) && typeContrat == 'CDD') {
            payMethodId = SM_Hermes.getExtPaymentMethodId(subOffre.IsB2B, acqIn.paiement.methodePaiement, porteur.CodePays__c);
            accUpdateReq.r_type = 'Account';
            zObj = new zc_ZObjectUpdate();
            zObj.id = accountZID;
            zObj.defaultPaymentMethodId = payMethodId;
            accUpdateReq.objects.add(zObj);
            zc_Api.actionUpdatePOST(accessToken, zEntityId, accUpdateReq, RTExceptionCode.ERREUR_IMPAYE_REGLER_UPDATE_ACCOUNT,pLog); 
        }
        

        //###### get invoice ######
        zc_ProxyGetInvoice invRes = zc_Api.objectInvoiceGET(accessToken, zEntityId, invoiceId, RTExceptionCode.ERREUR_IMPAYE_REGLER_APPLICATION_FRAIS, pLog);
        Double invAmount = invRes.amount;

        //###### get invoice File ######
        // zc_GETInvoiceFilesResponse invFileRes = zc_Api.invoicesFilesGET(accessToken, zEntityId, invoiceId, RTExceptionCode.ERREUR_IMPAYE_REGLER_APPLICATION_FRAIS, pLog);
        // if (invFileRes.invoiceFiles.size() > 0 ) invoiceFileUrl = invFileRes.invoiceFiles.get(0).pdfFileUrl;

        //###### Creation paiement Zuora ######
        Map<String,String> retPayment;
        if (acqIn.paiement.refPaiement != null || subOffre.IsB2B == true) { //External
            //if (acqIn.paiement.montant != invAmount) throw new RTException(RTExceptionCode.ERREUR_DESABO_COUPON_ABOTIER,pLog);
            retPayment = execPayment(invoiceId, accountZID, invAmount, acqIn.paiement.montant, acqIn.paiement.refPaiement, acqIn.paiement.methodePaiement, acqIn.lieu, acqIn.agent, acqIn.paiement.dateVirement);
        }else { //Electronic
            retPayment = execPayment(invoiceId, accountZID, invAmount, null, null, null, null, null, null);    
        }
        //payMethodId = retPayment.get('payMethodId'); //ce n'est pas le paymentmethodid du compte mai celui du paiement, il faut verifier, on le recuperer dans la partie CRM.
        paymentId = retPayment.get('paymentId');


        //###### Get Zuora Data (subscription) ######
        zc_GETSubscriptionTypeWithSuccess sub = zc_Api.subscriptionGET(accessToken, zEntityId, subscriptionZID, RTExceptionCode.ERREUR_ACQUISIT_GET_ZSUBSCRIPTION,pLog);

        //###### Get Zuora Data (Account) ######
        zc_ProxyGetAccount zacc = zc_Api.objectAccountGET(accessToken, zEntityId, accountZID, RTExceptionCode.ERREUR_ACQUISIT_GET_ACCOUNT,pLog);
        payMethodId = zacc.defaultPaymentMethodId;
 
        //###### Get Zuora Data (PaymentMethod) ######
        zc_ProxyGetPaymentMethod pm = zc_Api.objectPaymentMethodGET(accessToken, zEntityId, payMethodId, RTExceptionCode.ERREUR_ACQUISIT_GET_PAYMENTMETHOD,pLog);

        //###### insert zdocdata subscription ######
        zDocId = SM_Hermes.addZdocData(new Map<String,Object>{'ZSUB' => sub,'ZPM' => pm,'ACC' => porteur});

        //###### insert case ######
        String sousMotif = SM_Hermes.lieuToSousMotif(acqIn.lieu);
        String motif = SM_Hermes.lieuToMotif(acqIn.lieu, subOffre.IsB2B);
        String origin = SM_Hermes.lieuToOrigin(acqIn.lieu);
        String commentairesInternes = 'Prise d\'abonnement - ' + acqIn.produit + ' - ' + subOffre.HermesIntituleOffre;
        Case c = SM_Hermes.newCase(zDocId, subscriptionName, porteur.PersonContactId, origin, '0- Souscription', motif, sousMotif, 'Fermee', 
        acqIn.lieu, commentairesInternes, acqIn.accountSFID,null,null,null,acqIn.agent);
        caseId = c.Id;

        //###### generate sDoc ######
        List<Case> cs = [SELECT Id,AccountId,TECHIdStatut__c FROM Case WHERE Id=:caseId];
        SM_SDoc.makeSdocJobs(cs);

        //###### insert Fil impression ######
        //List<Carte__c> cartes = [Select Id from Carte__c where Name = 'numeroCarte']; //TODO voir si numero est cree a l impression et fournit par hermes.
        //Id carteId = (cartes.size() > 0)?cartes.get(0).Id:null;
        ZDocData__c zDoc = [Select Id, Payeur__r.FirstName, Payeur__r.LastName from ZDocData__c where Id = :zDocId];
        fileImpId = SM_FileImpression.createFileImpressionCarte(null, (Id)acqIn.accountSFID, null, (ID)caseId, subscriptionName, sub.CodeOffrePrincipale, zDoc.Payeur__r.FirstName, zDoc.Payeur__r.LastName);

        //###### consomme coupon ######
        if (acqIn.coupon != null) SM_Coupon.consommer(acqIn.coupon,dateJourDebutContrat);

        //RETURN
        acqOut = new WSZ.SubOpeOut(acqIn.accountSFID, accountZID, subscriptionZID, subscriptionName, compteBloque,invoiceFileUrl, rembourser,
        paymentId, caseId, payMethodId, invoiceId, fileImpId, sDocjobIds);

        // return acqOut;
        } //if else !isPreview

        if (isPreview) {
            returnObj.put('preview', previewOut);
        }else {
            returnObj.put('acquisition', acqOut);
        }

        return returnObj;
    }

     public static Map<String,String> execPayment(String invoiceId, String accountZID, Double invAmount, Double montant, String refPaiement, String methodePaiement, String lieu, String agent, Date  dateVirement) {

        Map<String,String> ret = new Map<String,String>{'paymentId'=>null,'payMethodId'=>null};
        zc_CreatePaymentType paymentReq = SM_Payment.paymentReq(invoiceId, accountZID, invAmount, montant, refPaiement, methodePaiement, lieu, agent, dateVirement);
        //###### Call WS Payment ######   
        zc_GETARPaymentType paymentRes = zc_Api.paymentsPOST2(accessToken, zEntityId, paymentReq, RTExceptionCode.ERREUR_IMPAYE_REGLER_APPLICATION_PAYMENT,new ProcessLog__c());
        ret.put('payMethodId',paymentRes.paymentMethodId);
        ret.put('paymentId',paymentRes.id);
        return ret;

    }

}