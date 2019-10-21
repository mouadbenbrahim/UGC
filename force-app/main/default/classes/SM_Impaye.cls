/**
 * @File Name          : SM_Impaye.cls
 * @Description        : 
 * @Author             : mouad
 * @Group              : 
 * @Last Modified By   : mouad
 * @Last Modified On   : 09/09/2019 à 05:37:02
 * @Modification Log   : 
 * Ver       Date            Author                 Modification
 * 1.0    06/09/2019   mouad     Initial Version
**/
public with sharing class SM_Impaye {
    public SM_Impaye() {

    }

    public static WSZ.ImpayeOut getImpaye(String accountID, String subZID){ //accountId: Zuora, subZID: Zuora


        WSZ.ImpayeOut impayeOut = new WSZ.ImpayeOut();
        Boolean firstInvoice = true;

        Zuora__Subscription__c sub = SM_Subscription.getSubscriptionByZID(subZID);
        if (sub == null ) {
            throw new RTException(RTExceptionCode.ERREUR_IMPAYE_GET_SOUSCRITPION_NON_TROUVE);
        }

        // Get Dette echue : Invoices       
        // List<Zuora__ZInvoice__c> invoices = [select Zuora__Zuora_Id__c, Name, Zuora__InvoiceDate__c, Zuora__Balance2__c, Zuora__TotalAmount__c,
        // Tech_CompteurRejet__c,Tech_CodeRejet__c,Tech_DateRejet__c
        // FROM Zuora__ZInvoice__c 
        // WHERE Zuora__Balance2__c > 0 AND Zuora__BillingAccount__r.Zuora__Zuora_Id__c = :accountID order by Name];
        // //AND Tech_CompteurRejet__c != null
        List<Zuora__ZInvoice__c> invoices = SM_Invoice.getInvoiceImpaye(accountID);
            
        impayeOut.accountId = accountID;
        impayeOut.subscriptionId = sub.Zuora__Zuora_Id__c;
        impayeOut.subscriptionName = sub.Name;
        impayeOut.montantDetteEchue = 0;
        impayeOut.montantDetteNonEchue = 0;
        impayeOut.montantFrais = 0;
        impayeOut.hasImpaye = true;

        if (invoices.size() > 0){
            for(Zuora__ZInvoice__c inv : invoices){
                WSZ.DetteEchue detteEchue = new WSZ.DetteEchue(inv.Zuora__Zuora_Id__c,  inv.Zuora__InvoiceDate__c, (Double)inv.Zuora__Balance2__c, (Double)inv.Zuora__TotalAmount__c);
                impayeOut.detteEchues.add(detteEchue);
                
                if (firstInvoice) {  //prendre la date de la premiere facture impayés si plusieurs factures
                    impayeOut.dateDetteEchue = inv.Zuora__InvoiceDate__c;                    
                    firstInvoice = false;
                }                
                impayeOut.montantDetteEchue = impayeOut.montantDetteEchue + inv.Zuora__Balance2__c;
                // nbrInvoices = nbrInvoices + 1;
            }            
        }

        // Get Frais de gestion
        if (sub.Tech_DetteFraisGestion__c != null) {
            impayeOut.montantFrais = Decimal.valueOf(sub.Tech_DetteFraisGestion__c);
        }

        // Get Dette Non echue
        if (sub.Tech_DetteNonEchue__c != null) { //remplacer par un calcul via la preview
            impayeOut.montantDetteNonEchue = Decimal.valueOf(sub.Tech_DetteNonEchue__c);
        }

        if (impayeOut.montantDetteEchue==0 && impayeOut.montantDetteNonEchue ==0 && impayeOut.montantFrais == 0) {
            impayeOut.hasImpaye = false;
        }

        return impayeOut;
        
    }


    public static WSZ.ImpayeReglerOut reglerImpaye(WSZ.ImpayeReglerIn impayeRegIn){ //accountId: Zuora, subZID: Zuora
        
        String repWS;
        ZUC_Parser par;
        Boolean success;
        String messageError;
        List<String> detteEchueIds = new List<String>();
        zc_ProxyActionupdateRequest objUpdateReq;
        zc_ProxySaveResult objUpdateRes;
        zc_ZObjectUpdate zObj;
        Boolean subActivated = false;
        Boolean subRecancelled = false;
        Date targetDate = null;
        String oriCodeFinContrat;
        Date oriDateFinContrat;
      

        // String zEntityId = WS001_CallZuora.getZuoraEntityId(acc.CodePays__c);
        String accountID = impayeRegIn.accountId;
        String subZID = impayeRegIn.subscriptionId;        
        Double montantPaye = impayeRegIn.montantPaye;

        

        String currentSubId = subZID;
        
        String accessToken = WS001_CallZuora.access_token;
        


        Zuora__Subscription__c sub = SM_Subscription.getSubscriptionByZID(subZID);
        if (sub == null ) {
            throw new RTException(RTExceptionCode.ERREUR_IMPAYE_REGLER_SOUSCRITPION_NON_TROUVE);
        }

        String codePays = sub.Zuora__Account__r.CodePays__c;
        String zEntityId = WS001_CallZuora.getZuoraEntityId(codePays);
        String pmMethodId =  Utils.getUgcGenericParam('Zuora_PM_'+impayeRegIn.methodPaiement,codePays).ParamValue__c;
        
        if (!String.isEmpty(sub.Tech_DetteTargetDate__c)){
            targetDate = Date.valueOf(sub.Tech_DetteTargetDate__c);
        }


        WSZ.ImpayeOut impayeOut = new WSZ.ImpayeOut();
        // Boolean firstInvoice = true;
        
        impayeOut = getImpaye(accountID, subZID);
        if (!impayeOut.hasImpaye){
            throw new RTException(RTExceptionCode.ERREUR_IMPAYE_REGLER_PAS_DE_DETTE);
        }

        Double montantAregler = impayeOut.montantFrais + impayeOut.montantDetteNonEchue + impayeOut.montantDetteEchue;
        System.debug('montantAregler: '+montantAregler);

        if (montantAregler != montantPaye){
            throw new RTException(RTExceptionCode.ERREUR_IMPAYE_REGLER_PROBLEM_MONTANT);
        }

        if (sub.Zuora__Status__c == 'Active' && targetDate != null && Date.today() >= targetDate){
            throw new RTException(RTExceptionCode.ERREUR_IMPAYE_REGLER_TARGETDATE_STATUSCONTRAT);
        }

        if (sub.DateFinContrat__c != null && sub.Zuora__CancelledDate__c != null && sub.Zuora__CancelledDate__c != sub.DateFinContrat__c.addDays(1)) {
            throw new RTException(RTExceptionCode.ERREUR_IMPAYE_REGLER_INCOHERENCE_DATEFIN);
        }


        // Sauvegarder les customvalues et proprietes de la dernier souscription
            // Zuora API SUBSRIPTION CRUD: get Sub Actuel Sub et n-1 Sub + compare les deux objets + stocker les differences dans un objet, pour les remettre apres.

        // Reactivation du subsctription si est cancelled (pour pouvoir ajouter la charge des FG)
        if (sub.Zuora__Status__c == 'Cancelled'){            
            WSZ.SubOut res = SM_Subscription.deleteSub(subZID, zEntityId);
            if (res.Success == false){
                throw new RTException(RTExceptionCode.ERREUR_IMPAYE_REGLER_DELETE_SUB);
            }
            subActivated = true;
            currentSubId = sub.Zuora__PreviousSubscriptionId__c;
        }

        Double montantPreview = 0; //dette non echue
        if (targetDate != null){
            // Preview: FG + TargetDate et comparer les montants preview et montantpaye: si montant <> : Cancel subscription si etait cancele initialement + throw erreur
            // Preview Dette non echue
            zc_PostBillingPreviewParam previewReq = new zc_PostBillingPreviewParam();
            previewReq.accountId = accountID;
            previewReq.assumeRenewal = 'All';
            //prev.chargeTypeToExclude = '';
            previewReq.includingEvergreenSubscription = true;
            previewReq.targetDate = targetDate.addDays(-1);

            //Call WS Preview
            repWS = WS001_CallZuora.sendRequest2(accessToken, '/v1/operations/billing-preview', zEntityId, 'POST', previewReq, zc_PostBillingPreviewParam.class, zc_BillingPreviewResult.class, null);

            // Check resultat WS Preview
            par = new ZUC_Parser(ZUC_Parser.MAP_NO_SWAP);
            repWS = par.serializeWithMapping2(repWS,'zc_BillingPreviewResult'); //rename members
            zc_BillingPreviewResult previewRes = (zc_BillingPreviewResult)JSON.deserialize(repWS, zc_BillingPreviewResult.class);

            success = true;
            messageError = '';
            if(previewRes != null && previewRes.success != null){
                if(!previewRes.success){                
                    throw new RTException(String.valueOf(new RTException(RTExceptionCode.ERREUR_IMPAYE_REGLER_PROBLEM_PREVIEW))+repWS);   
                }            
            }

            System.debug('MBEN: repWS: ' + repWS);

            
            Decimal tvaZuora = Decimal.valueOf(Utils.getUgcGenericParam('TVA Zuora',codePays).ParamValue__c); 

            for (zc_POSTBillingPreviewInvoiceItem invoice : previewRes.invoiceItems){
                Decimal chargeAmountTTC = (Decimal.valueOf(invoice.chargeAmount) * 100 * (1+(tvaZuora/100)));
                chargeAmountTTC = chargeAmountTTC.round();
                chargeAmountTTC = (chargeAmountTTC / 100);
                montantPreview = montantPreview + chargeAmountTTC;
            }

            System.debug('MBEN montantPreview: ' + montantPreview); 

        }

        System.debug('MBEN ERREUR_IMPAYE_REGLER_MONTANT_DNE montantPreview: ' + montantPreview);
        System.debug('MBEN ERREUR_IMPAYE_REGLER_MONTANT_DNE: impayeOut.montantDetteNonEchue' + impayeOut.montantDetteNonEchue);
        if (montantPreview != impayeOut.montantDetteNonEchue){
            // il faut remettre le cancel si applicable avec le try/catch
            throw new RTException(RTExceptionCode.ERREUR_IMPAYE_REGLER_MONTANT_DNE);
        }

        if ((montantPreview + impayeOut.montantFrais + impayeOut.montantDetteEchue) != montantPaye){
                // il faut remettre le cancel si applicable avec le try/catch
            throw new RTException(RTExceptionCode.ERREUR_OFFRE_CYCLE_FERME);                
        }


        // Ajout Frais de gestion avec bill target date

        String entite = (codePays == '033') ? 'France' : 'Belgique';
        String rpcReference = 'FRAISREACT';
        list<ProdRatePlanCharge__c> listProdRatePlanCharge = new list<ProdRatePlanCharge__c>([SELECT ReferenceCIC__c, zid__c, ProdRatePlan__r.zid__c 
        FROM ProdRatePlanCharge__c WHERE ReferenceCIC__c = :rpcReference and Entite__c = :entite]);        
    
        if(listProdRatePlanCharge.size() == 0){                
            throw new RTException(RTExceptionCode.ERREUR_IMPAYE_REGLER_PRODUIT_ABSENT);			
        }            
        
        String rpId = listProdRatePlanCharge.get(0).ProdRatePlan__r.zid__c;
        String rpcId = listProdRatePlanCharge.get(0).zid__c;
        //moisDebutRemise = Integer.valueOf(c.Mois_de_d_but_remise__c);
        //dateDebutRemise = SM_Demande.getRemiseDate(moisDebutRemise);

        Date dateDebutRemise;        
        Date invTargetDate;

        invTargetDate=(targetDate == null)?Date.today():targetDate.addDays(-1);
        dateDebutRemise=(Date.today() < targetDate || targetDate == null)?Date.today():targetDate.addDays(-1);

        // if(Date.today() <= targetDate || targetDate == null ){
        //     dateDebutRemise = Date.today();
        // }else {
        //     dateDebutRemise = targetDate;
        // }

        
        // instantiate AmendRequest Instance
        zc_ProxyActionAmendRequest actionAmend = new zc_ProxyActionAmendRequest();
        zc_AmendRequest req1 = new zc_AmendRequest();        
        zc_AmendRequestPreviewOptions previewOptions = new zc_AmendRequestPreviewOptions();
        zc_AmendRequestAmendOptions amendOptions = new zc_AmendRequestAmendOptions();
        zc_Amendment amend1 = new zc_Amendment(); //Add product
        // zc_Amendment amend1 = new zc_Amendment(); 
        previewOptions.enablePreviewMode=false;
        amendOptions.generateInvoice=true;
        amendOptions.processPayments=false;
        zc_InvoiceProcessingOptions invPrc = new zc_InvoiceProcessingOptions();
        invPrc.invoiceDate=Date.today();
        invPrc.invoiceTargetDate=invTargetDate;
        amendOptions.invoiceProcessingOptions = invPrc;

        //Ajout FG: 
        // meme s'il n y a pas de FG on fait cet amend avec montant a 0 pour pouvoir facturer la DNE
        amend1.contractEffectiveDate=dateDebutRemise;        
        amend1.name='Frais de gestion';
        amend1.status='Completed';
        amend1.subscriptionId=currentSubId;
        amend1.r_type='NewProduct';
        amend1.description='Reglement impaye Frais de gestion';                                   
        zc_AmendmentRatePlanData ratePlanData = new zc_AmendmentRatePlanData();
        zc_RatePlan ratePlan = new zc_RatePlan();
        ratePlan.productRatePlanId=rpId;                
        ratePlanData.ratePlan = ratePlan;
        zc_RatePlanChargeDataInRatePlanData rpcChargeData = new zc_RatePlanChargeDataInRatePlanData();
        zc_RatePlanChargeInRatePlanChargeData rpcCharge = new zc_RatePlanChargeInRatePlanChargeData();
        rpcChargeData.ratePlanCharge = rpcCharge;        
        rpcCharge.price = impayeOut.montantFrais;        
        rpcCharge.productRatePlanChargeId = rpcId;                
        ratePlanData.ratePlanChargeData.add(rpcChargeData);
        amend1.ratePlanData = ratePlanData; 
        req1.amendments.add(amend1);

        req1.previewOptions = previewOptions;
        req1.amendOptions = amendOptions;
        actionAmend.requests.add(req1);


        //Call WS Ajout FG
        // String accessToken = WS001_CallZuora.access_token;
        repWS = WS001_CallZuora.sendRequest2(accessToken, '/v1/action/amend', zEntityId, 'POST', actionAmend, zc_AmendRequest.class, zc_AmendResult.class, null);

        // Check resultat WS
        par = new ZUC_Parser(ZUC_Parser.MAP_NO_SWAP);
        repWS = par.serializeWithMapping2(repWS,'zc_ProxyActionAmendResponse'); //rename members
        zc_ProxyActionAmendResponse amendRes = (zc_ProxyActionAmendResponse)JSON.deserialize(repWS, zc_ProxyActionAmendResponse.class);

        success = true;
        messageError = '';
        if(amendRes != null && amendRes.results != null  && amendRes.results.size() > 0){
            for(zc_AmendResult r : amendRes.results){
                if(!r.success){
                    if(r.errors != null && r.errors.size() > 0){
                        throw new RTException(String.valueOf(new RTException(RTExceptionCode.ERREUR_IMPAYE_REGLER_APPLICATION_FRAIS)) + r.errors.get(0).message);
                    }
                }
            }
        }  

        currentSubId=amendRes.results.get(0).subscriptionId; //Get last subId


        // Creation paiement Zuora
        zc_CreatePaymentType payment = new zc_CreatePaymentType();
        payment.accountId = accountID;
        payment.amount = montantPaye;
        payment.currency2 = 'EUR';
        payment.r_type = zc_CreatePaymentType.RTypeEnum.External;
        payment.paymentMethodId = pmMethodId; //TODO
        payment.effectiveDate = Date.today();
        payment.referenceId = impayeRegIn.referenceId; //TODO
        // TODO payment.MethodePaiement__c = ;
        // TODO payment.Lieu__c =;
        // TODO payment.Agent__c = ;
        zc_PaymentInvoiceApplicationCreateR invoice1 = new zc_PaymentInvoiceApplicationCreateR(); // Invoice Amend : FG + DNE
        invoice1.amount = montantPreview + impayeOut.montantFrais; //TODO champ obligatoire, soit on requette invoice dans zuora, ou bien on utitilise les donnes deja calcules
        invoice1.invoiceId = amendRes.results.get(0).invoiceId;
        payment.invoices.add(invoice1);

        if (impayeOut.detteEchues.size() > 0){
            for (WSZ.DetteEchue dte : impayeOut.detteEchues){
                zc_PaymentInvoiceApplicationCreateR invoice = new zc_PaymentInvoiceApplicationCreateR();
                invoice.invoiceId = dte.invoiceId;
                invoice.amount = dte.invoiceTotalAmount;
                payment.invoices.add(invoice);
                detteEchueIds.add(dte.invoiceId); //utilise dans la mise a jour des factures;
            }
        }

        //Call WS Payment
        repWS = WS001_CallZuora.sendRequest2(accessToken, '/v1/payments', zEntityId, 'POST', payment, zc_CreatePaymentType.class, zc_GETARPaymentType.class, null);

        // Check resultat WS Payment:      //TODO traiter la class retour quand c est une erreur
        Map<String,Object> mapRes = (Map<String,Object>)JSON.deserializeUntyped(repWS);
        if (mapRes.containsKey('success') && mapRes.containsKey('processId') && mapRes.containsKey('reasons')){
            throw new RTException(String.valueOf(new RTException(RTExceptionCode.ERREUR_IMPAYE_REGLER_APPLICATION_PAYMENT)) + repWS);
        }

        par = new ZUC_Parser(ZUC_Parser.MAP_NO_SWAP);
        repWS = par.serializeWithMapping2(repWS,'zc_GETARPaymentType'); //rename members
        zc_GETARPaymentType paymentRes = (zc_GETARPaymentType)JSON.deserialize(repWS, zc_GETARPaymentType.class);

        success = true;
        messageError = '';
        if(paymentRes != null && paymentRes.success != null){
            if(!paymentRes.success){                
                throw new RTException(String.valueOf(new RTException(RTExceptionCode.ERREUR_IMPAYE_REGLER_APPLICATION_PAYMENT))+ repWS);   
            }            
        }

        /*
                {
        "success" : false,
        "processId" : "F9700ABE3E8CECEC",
        "reasons" : [ {
            "code" : 53810021,
            "message" : "Invalid parameter(s): 'r_type,currency2'."
        } ]
        }
        */


        // Cancel Subscription si applicable
        if (subActivated) { //contrat initial au status Cancel
            if (targetDate != null && Date.today() >= targetDate ){
                //Cancel Contract
                WSZ.SubCancelOut rCancel = SM_Subscription.cancelSub(Util.zDate(sub.Zuora__CancelledDate__c), 'SpecificDate', currentSubId, false, Util.zDate(sub.Zuora__CancelledDate__c), zEntityId);
                currentSubId = rCancel.subscriptionId;
                subRecancelled = true;
                //Update previous subscription values
            }else {
                // le contrat continue car il a ete active
            }
        }else { //contrat initial actif            
            if (targetDate != null && Date.today() >= targetDate){
                throw new RTException(RTExceptionCode.ERREUR_IMPAYE_REGLER_TARGETDATE_STATUSCONTRAT);
            }else {
                // le contrat continue car il est deja active
            }
        }

        //Mise a jour subscription: (si contrat reactive/Actif): remettre tous les champs
        if (subRecancelled) { //contrat initial au status Cancel, active puis recancelle:
            //Mise à jour ancienne valeur codefin et date fin.
            objUpdateReq = new zc_ProxyActionupdateRequest();
            objUpdateReq.r_type = 'Subscription';
            zObj = new zc_ZObjectUpdate();
            zObj.id = currentSubId;
            zObj.codeFinContrat = sub.CodeFinContrat__c; // c les valeur du contrat initial
            zObj.dateFinContrat = sub.DateFinContrat__c; // c les valeur du contrat initial
            objUpdateReq.objects.add(zObj);
            System.debug(JSON.serialize(objUpdateReq,true));   

            //Call WS invoice update
            repWS = WS001_CallZuora.sendRequest2(accessToken, '/v1/action/update', zEntityId, 'POST', objUpdateReq, zc_ProxyActionupdateRequest.class, zc_ProxySaveResult.class, null);

            par = new ZUC_Parser(ZUC_Parser.MAP_NO_SWAP);
            repWS = '{"results":'+repWS+'}';
            repWS = par.serializeWithMapping2(repWS,'zc_ProxySaveResult'); //rename members
            objUpdateRes = (zc_ProxySaveResult)JSON.deserialize(repWS, zc_ProxySaveResult.class);

            success = true;
            messageError = '';
            if(objUpdateRes != null && objUpdateRes.results.size() > 0){
                if(!objUpdateRes.results.get(0).success){                                    
                    throw new RTException(String.valueOf(new RTException(RTExceptionCode.ERREUR_IMPAYE_REGLER_UPDATE_SUBSCRIPTION))+ repWS);             
                }            
            }
        }else {
            //ne rien faire: contrat 
            
        }        



        //Mise a jour Account        
        objUpdateReq = new zc_ProxyActionupdateRequest();
        objUpdateReq.r_type = 'Account';
        zObj = new zc_ZObjectUpdate();
        zObj.id = accountID;
        zObj.batch = 'Batch8'; //TODO conditions a ajouter
        objUpdateReq.objects.add(zObj);
        System.debug(JSON.serialize(objUpdateReq,true));


        //Call WS Account update
        repWS = WS001_CallZuora.sendRequest2(accessToken, '/v1/action/update', zEntityId, 'POST', objUpdateReq, zc_ProxyActionupdateRequest.class, zc_ProxySaveResult.class, null);

        // Pas besoin de class erreur: la meme class: zc_SaveResult traite OK et KO

        par = new ZUC_Parser(ZUC_Parser.MAP_NO_SWAP);
        repWS = '{"results":'+repWS+'}';
        repWS = par.serializeWithMapping2(repWS,'zc_ProxySaveResult'); //rename members
        objUpdateRes = (zc_ProxySaveResult)JSON.deserialize(repWS, zc_ProxySaveResult.class);

        success = true;
        messageError = '';
        if(objUpdateRes != null && objUpdateRes.results.size() > 0){
            if(!objUpdateRes.results.get(0).success){                                
                throw new RTException(String.valueOf(new RTException(RTExceptionCode.ERREUR_IMPAYE_REGLER_UPDATE_ACCOUNT))+ repWS);             
            }            
        }


        
        //Mise a jour invoice        
        if (detteEchueIds.size() > 0) {
            //List<Zuora__ZInvoice__c> invoices2 = SM_Invoice.getInvoiceByIds(detteEchueIds);                        
            for (Zuora__ZInvoice__c inv2 : SM_Invoice.getInvoiceByIds(detteEchueIds) ){
                if (Integer.valueOf(inv2.Tech_CompteurRejet__c) > 0 ){  // pour isoler juste les factures 
                    zObj = new zc_ZObjectUpdate();
                    zObj.id = inv2.Zuora__External_Id__c;
                    zObj.tech_FlagRejetPaye = 'true';
                }
            }

            objUpdateReq = new zc_ProxyActionupdateRequest();
            objUpdateReq.r_type = 'Invoice';                     
            objUpdateReq.objects.add(zObj);
            System.debug(JSON.serialize(objUpdateReq,true));
        }
        
        //Call WS invoice update
        repWS = WS001_CallZuora.sendRequest2(accessToken, '/v1/action/update', zEntityId, 'POST', objUpdateReq, zc_ProxyActionupdateRequest.class, zc_ProxySaveResult.class, null);

        par = new ZUC_Parser(ZUC_Parser.MAP_NO_SWAP);
        repWS = '{"results":'+repWS+'}';
        repWS = par.serializeWithMapping2(repWS,'zc_ProxySaveResult'); //rename members
        objUpdateRes = (zc_ProxySaveResult)JSON.deserialize(repWS, zc_ProxySaveResult.class);

        success = true;
        messageError = '';
        if(objUpdateRes != null && objUpdateRes.results.size() > 0){
            if(!objUpdateRes.results.get(0).success){                
                throw new RTException(String.valueOf(new RTException(RTExceptionCode.ERREUR_IMPAYE_REGLER_UPDATE_INVOICE))+ repWS);             
            }            
        }

        // Create Case ??

        // return null;

        WSZ.ImpayeReglerOut impayeRegOut = new WSZ.ImpayeReglerOut(accountID, currentSubId, paymentRes.amount, impayeRegIn.referenceId, paymentRes.id);

        return impayeRegOut;

    }

}