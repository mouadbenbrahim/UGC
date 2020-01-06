public with sharing class SM_Acquisition {
    public SM_Acquisition() {

    }

    public static WSZ.AcquisitionOut acquisition(WSZ.AcquisitionIn acqIn){

        
        String invoiceFileUrl;
        String acqInStr = JSON.serialize(acqIn);
        //Account acc = SM_Account.getAccount(hermesIn.accountId);
        ProcessLog__c pLog = new ProcessLog__c(Process__c = 'acquisition', Account__c = acqIn.accountSFID, Message__c = acqInStr);

        Boolean isPreview = false;
        Boolean compteBloque = false;
        Boolean rembourser = false;


        String intituleOffreFR,intituleOffreNL;
        //Decimal abonnement=0,montantInitial=0,fraisAdhesion=0,fraisAdhesionRemise=0,fraisAdhesionApresRemise=0,prorata=0;

        String produit = acqIn.produit.get(0);
        String typeContrat = (produit.contains('CDI')?'CDI':'CDD');
        Boolean isFutur = (acqIn.dateDebutContrat == Date.today())?false:true;

        //###### get subOffres ######
        WSZ.SubProduct subOffre = SM_Offre.getSubOffres(new WSZ.SubOffreIn(acqIn.dateDebutContrat, acqIn.lieu, acqIn.agent, acqIn.coupon,acqIn.accountSFID, 'acquisition', produit)).get(0);
        List<zc_AmendmentRatePlanData> subOffreRatePlans = SM_Offre.convertRatePlan(subOffre.subscribeToRatePlans);
        System.debug('MBEN:subOffreRatePlanConverted' + JSON.serialize(subOffreRatePlans));
        
        //###### get AccountData ######
        Account porteur = SM_Account.getAccountData(acqIn.accountSFID);
        Account payeur = SM_Account.getAccountData(acqIn.payeurSFID);
        
        // check:
        if (acqIn.codeOffreCo != null && acqIn.codeOffreCo != subOffre.CodeOffreCo) {
            throw new RTException(RTExceptionCode.ERREUR_DESABO_COUPON_ABOTIER,new ProcessLog__c());
        }

        //token/entity
        String accessToken = WS001_CallZuora.access_token;
        String zEntityId = WS001_CallZuora.getZuoraEntityId('033');  

        //###### subscribe ######
        Map<String,Object> customSub = new Map<String,Object>{'IsB2B'=>subOffre.IsB2B, 'isPreview'=>isPreview, 'codeOffreCo'=>subOffre.CodeOffreCo};
        //customSub.put('IsB2B', subOffre.IsB2B);
        SM_Subscribe.SubscribeIn subIn = SM_Subscribe.mapToSubscribeIn(acqIn);
        zc_ProxyActionsubscribeRequest subscribeReq = SM_Subscribe.subscribe(subIn, isPreview, porteur, payeur, subOffreRatePlans, customSub);
        
        //###### Call Zuora actionSubscribe ######
        zc_ProxySubscribeResult subRes = zc_Api.actionSubscribePOST(accessToken, zEntityId, subscribeReq, RTExceptionCode.ERREUR_IMPAYE_REGLER_APPLICATION_FRAIS, new ProcessLog__c());
        System.debug('MBEN:resObj: ' + JSON.serialize(subRes,true));
        String accountZID = subRes.results.get(0).accountId;
        String invoiceId = subRes.results.get(0).invoiceId;
        String subscriptionZID = subRes.results.get(0).subscriptionId;
        String subscriptionName = subRes.results.get(0).subscriptionNumber;

        //###### get invoice ######
        zc_ProxyGetInvoice invRes = zc_Api.objectInvoiceGET(accessToken, zEntityId, invoiceId, RTExceptionCode.ERREUR_IMPAYE_REGLER_APPLICATION_FRAIS, new ProcessLog__c());
        Double invAmount = invRes.amount;

        //###### get invoice File ######
        zc_GETInvoiceFilesResponse invFileRes = zc_Api.invoicesFilesGET(accessToken, zEntityId, invoiceId, RTExceptionCode.ERREUR_IMPAYE_REGLER_APPLICATION_FRAIS, new ProcessLog__c());
        if (invFileRes.invoiceFiles.size() > 0 ) invoiceFileUrl = invFileRes.invoiceFiles.get(0).pdfFileUrl;

        //###### Creation paiement Zuora ######
         WSZ.Paiement paymentIn;
         zc_CreatePaymentType paymentReq;
        if (acqIn.paiement != null || subOffre.IsB2B == true) {
            if (acqIn.paiement.montant != invAmount) throw new RTException(RTExceptionCode.ERREUR_DESABO_COUPON_ABOTIER,new ProcessLog__c());
            paymentIn = new WSZ.Paiement(acqIn.paiement.montant, acqIn.paiement.refPaiement, acqIn.paiement.methodePaiement, acqIn.paiement.lieu, acqIn.paiement.agent, acqIn.paiement.dateVirement);
            paymentReq = SM_Payment.createExtPayment(invoiceId, accountZID, paymentIn);
        }else {
            paymentIn = new WSZ.Paiement(invAmount, null, null, null, null, null);
            paymentReq = SM_Payment.createElecPayment(invoiceId, accountZID, paymentIn);
        }

   
        //###### Call WS Payment ######   
        zc_GETARPaymentType paymentRes = zc_Api.paymentsPOST2(accessToken, zEntityId, paymentReq, RTExceptionCode.ERREUR_IMPAYE_REGLER_APPLICATION_PAYMENT,new ProcessLog__c());
        String payMethodId = paymentRes.paymentMethodId;
   
        //return resObj;

        //###### Get Zuora Data (subscription) ######
        zc_GETSubscriptionTypeWithSuccess sub = zc_Api.subscriptionGET(accessToken, zEntityId, subscriptionZID, RTExceptionCode.ERREUR_ACQUISIT_GET_ZSUBSCRIPTION,pLog);

        //###### Get Zuora Data (Account) ######
        //zc_ProxyGetAccount zacc = zc_Api.objectAccountGET(accessToken, zEntityId, accountZID, RTExceptionCode.ERREUR_ACQUISIT_GET_ACCOUNT,pLog);
        //String payMethodId = zacc.defaultPaymentMethodId;
 
        //###### Get Zuora Data (PaymentMethod) ######
        zc_ProxyGetPaymentMethod pm = zc_Api.objectPaymentMethodGET(accessToken, zEntityId, payMethodId, RTExceptionCode.ERREUR_ACQUISIT_GET_PAYMENTMETHOD,pLog);

        //###### insert zdocdata subscription ######
        Id zDocId = SM_Hermes.addZdocData(new Map<String,Object>{'ZSUB' => sub,'ZPM' => pm,'ACC' => porteur});

        //###### insert case ######
        String sousMotif = SM_Hermes.lieuToSousMotif(acqIn.lieu);
        String motif = SM_Hermes.lieuToMotif(acqIn.lieu, subOffre.IsB2B);
        String origin = SM_Hermes.lieuToOrigin(acqIn.lieu);
        String commentairesInternes = 'Prise d\'abonnement - ' + acqIn.produit.get(0) + ' - ' + subOffre.HermesIntituleOffre;
        Case c = SM_Hermes.newCase(zDocId, subscriptionName, porteur.PersonContactId, origin, '0- Souscription', motif, sousMotif, 'Fermee', 
        acqIn.lieu, commentairesInternes, acqIn.accountSFID,null,null,null);
        Id caseId = c.Id;

        //###### generate sDoc ######
        List<Case> cs = [SELECT Id,AccountId,TECHIdStatut__c FROM Case WHERE Id=:caseId];
        SM_SDoc.makeSdocJobs(cs);

        //###### insert Fil impression ######
        List<Carte__c> cartes = [Select Id from Carte__c where Name = 'numeroCarte']; //TODO voir si numero est cree a l impression et fournit par hermes.
        Id carteId = (cartes.size() > 0)?cartes.get(0).Id:null;
        ZDocData__c zDoc = [Select Id, Payeur__r.FirstName, Payeur__r.LastName from ZDocData__c where Id = :zDocId];
        SM_FileImpression.createFileImpressionCarte(null, (Id)acqIn.accountSFID, carteId, caseId, subscriptionName, sub.CodeOffrePrincipale, zDoc.Payeur__r.FirstName, zDoc.Payeur__r.LastName);

        //RETURN
        WSZ.AcquisitionOut acqOut = new WSZ.AcquisitionOut(
        acqIn.accountSFID, accountZID, acqIn.accountRCUID, subscriptionZID, subscriptionName, compteBloque,invoiceFileUrl, rembourser);

        return acqOut;
    }

}