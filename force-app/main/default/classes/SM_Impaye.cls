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
public without sharing class SM_Impaye {

    public static String zEntityId,currentSubId;
    public static String accessToken,codePays;
    public static ProcessLog__c pLog;
    public final static Set<String> DETTETECH_NAME = new Set<String>{'Dette technique','Reprise'};
    public static Zuora__Subscription__c sub;
    public static Boolean subRecancelled = false;
    public enum opeEnum {Souscription,Migration,Renouvellement,Desabonnement,Resiliation,Retractation,FinContrat,PassageU26}

    public SM_Impaye() {

    }

    public static WSZ.ImpayeOut getImpaye(String accountID, String subZID){ //accountId: Zuora, subZID: Zuora


        WSZ.ImpayeOut impayeOut = new WSZ.ImpayeOut();
        Boolean firstInvoice = true;

        pLog = new ProcessLog__c(Process__c = 'getImpaye', AccountZID__c = accountID, SubscriptionZID__c = subZID);


        Zuora__Subscription__c sub = SM_Subscription.getSubscriptionByZID(subZID);
        if (sub == null ) {
            //ProcessLog__c pLog2 = new ProcessLog__c(Process__c = 'getImpaye', AccountZID__c = accountID, SubscriptionZID__c = subZID);
            //insert pLog2;
            //RTException rte = new RTException(RTExceptionCode.ERREUR_IMPAYE_GET_SOUSCRITPION_NON_TROUVE,pLog);
            throw new RTException(RTExceptionCode.ERREUR_IMPAYE_GET_SOUSCRITPION_NON_TROUVE,pLog);
            //throw new RTException(RTExceptionCode.ERREUR_IMPAYE_GET_SOUSCRITPION_NON_TROUVE);
        }

        if(sub.Zuora__CustomerAccount__r.Zuora__External_Id__c != accountID){
            throw new RTException(RTExceptionCode.ERREUR_IMPAYE_GET_ACCOUNT_NON_TROUVE2,pLog);
        }

        // Get Dette echue : Invoices       
        // List<Zuora__ZInvoice__c> invoices = [select Zuora__External_Id__c, Name, Zuora__InvoiceDate__c, Zuora__Balance2__c, Zuora__TotalAmount__c,
        // Tech_CompteurRejet__c,Tech_CodeRejet__c,Tech_DateRejet__c
        // FROM Zuora__ZInvoice__c 
        // WHERE Zuora__Balance2__c > 0 AND Zuora__BillingAccount__r.Zuora__External_Id__c = :accountID order by Name];
        // //AND Tech_CompteurRejet__c != null
        List<Zuora__ZInvoice__c> invoices = SM_Invoice.getInvoiceImpaye(accountID);
            
        impayeOut.accountId = accountID;
        impayeOut.subscriptionId = sub.Zuora__External_Id__c;
        impayeOut.subscriptionName = sub.Name;
        impayeOut.montantDetteEchue = 0;
        impayeOut.montantDetteNonEchue = 0;
        impayeOut.montantFrais = 0;
        impayeOut.hasImpaye = true;

        if (invoices.size() > 0){
            for(Zuora__ZInvoice__c inv : invoices){
                WSZ.DetteEchue detteEchue = new WSZ.DetteEchue(inv.Zuora__External_Id__c,  inv.Zuora__InvoiceDate__c, (Double)inv.Zuora__Balance2__c, (Double)inv.Zuora__TotalAmount__c);
                impayeOut.detteEchues.add(detteEchue);
                
                if (firstInvoice) {  //prendre la date de la premiere facture impayés si plusieurs factures
                    impayeOut.dateDetteEchue = inv.Zuora__InvoiceDate__c;                    
                    firstInvoice = false;
                }                
                impayeOut.montantDetteEchue = (Decimal)impayeOut.montantDetteEchue + inv.Zuora__Balance2__c;
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
        
        String repWS,messageError,oriCodeFinContrat,invoiceId;
        Boolean success;        
        Boolean subActivated = false;
        
        Boolean hasDetteEchue = false;
        Boolean hasFraisGestion = false;
        Boolean hasDetteNonEchue = false;
        Date oriDateFinContrat,dateDebutFG,invTargetDate,dateFacture;
        Date targetDate = null;
        ZUC_Parser par;
        List<String> detteEchueIds = new List<String>();
        zc_ProxyActionupdateRequest objUpdateReq;
        zc_ProxySaveResult objUpdateRes;
        zc_ZObjectUpdate zObj;      

        // String zEntityId = WS001_CallZuora.getZuoraEntityId(acc.CodePays__c);
        String accountID = impayeRegIn.accountId;
        String subZID = impayeRegIn.subscriptionId;        
        Double montantPaye = impayeRegIn.montantPaye;
        currentSubId = subZID;
        accessToken = WS001_CallZuora.access_token;
        
        String impayeRegInStr = JSON.serialize(impayeRegIn);
        pLog = new ProcessLog__c(Process__c = 'reglerImpaye', AccountZID__c = accountID, SubscriptionZID__c = subZID, Message__c = impayeRegInStr);
        
        
        Zuora__Subscription__c sub = SM_Subscription.getSubscriptionByZID(subZID);
        if (sub == null ) {
            throw new RTException(RTExceptionCode.ERREUR_IMPAYE_REGLER_SOUSCRITPION_NON_TROUVE,pLog);
        }

        codePays = sub.Zuora__Account__r.CodePays__c;
        String contactId = sub.Zuora__Account__r.PersonContactId;
        String accountSID = sub.Zuora__Account__r.Id;
        zEntityId = WS001_CallZuora.getZuoraEntityId(codePays);
        String pmMethodId =  Utils.getUgcGenericParam('Zuora_PM_'+impayeRegIn.methodPaiement,codePays).ParamValue__c;
        
        
        if (!String.isEmpty(sub.Tech_DetteTargetDate__c)){
            targetDate = Date.valueOf(sub.Tech_DetteTargetDate__c);
        }


        WSZ.ImpayeOut impayeOut = new WSZ.ImpayeOut();
        // Boolean firstInvoice = true;
        
        impayeOut = getImpaye(accountID, subZID);
        if (!impayeOut.hasImpaye){
            throw new RTException(RTExceptionCode.ERREUR_IMPAYE_REGLER_PAS_DE_DETTE,pLog);
        }

        hasFraisGestion = (impayeOut.montantFrais != 0)?true:false;
        hasDetteEchue = (impayeOut.montantDetteEchue != 0)?true:false;



        Double montantAregler = (Decimal)impayeOut.montantFrais + (Decimal)impayeOut.montantDetteNonEchue + (Decimal)impayeOut.montantDetteEchue;
        System.debug('montantAregler: '+montantAregler);

        if (montantAregler != montantPaye){
            throw new RTException(RTExceptionCode.ERREUR_IMPAYE_REGLER_PROBLEM_MONTANT,pLog);
        }

        if (sub.Zuora__Status__c == 'Active' && targetDate != null && Date.today() >= targetDate){
            throw new RTException(RTExceptionCode.ERREUR_IMPAYE_REGLER_TARGETDATE_STATUSCONTRAT,pLog);
        }

        if (sub.DateFinContrat__c != null && sub.Zuora__CancelledDate__c != null && sub.Zuora__CancelledDate__c != sub.DateFinContrat__c.addDays(1)) {
            throw new RTException(RTExceptionCode.ERREUR_IMPAYE_REGLER_INCOHERENCE_DATEFIN,pLog);
        }

        if (sub.Zuora__Status__c == 'Cancelled' && sub.DateFinContrat__c == null) {
            throw new RTException(RTExceptionCode.ERREUR_IMPAYE_REGLER_INCOHERENCE_DATEFIN,pLog); //TODO un autre code
        }


        // Sauvegarder les customvalues et proprietes de la dernier souscription
            // Zuora API SUBSRIPTION CRUD: get Sub Actuel Sub et n-1 Sub + compare les deux objets + stocker les differences dans un objet, pour les remettre apres.

        // Reactivation du subsctription si est cancelled (pour pouvoir ajouter la charge des FG)
        if (sub.Zuora__Status__c == 'Cancelled'){            
            
            //TODO get amend informations before delete (ex: operation, amendid,subid) à inserer dans le trackoperation.
            zc_GETAmendmentType amendRes = zc_Api.amendSubscriptionGET(accessToken, zEntityId, subZID, RTExceptionCode.ERREUR_IMPAYE_REGLER_PROBLEM_PREVIEW, pLog);
            //zc_ProxyGetAmendment amendRes2 = zc_Api.objectAmendGET(accessToken, zEntityId, amendRes.id, RTExceptionCode.ERREUR_IMPAYE_REGLER_PROBLEM_PREVIEW, pLog);            
            
            //delete sub
            zc_SaveResult res = zc_Api.objectSubscriptionDELETE(accessToken, zEntityId, subZID, RTExceptionCode.ERREUR_IMPAYE_REGLER_DELETE_SUB, pLog);
            subActivated = true;
            currentSubId = sub.Zuora__PreviousSubscriptionId__c;

            //TODO TRACKING AMEND            
            //SM_Hermes.trackOperation('SUPPRESSION', Datetime.now(), 'Reactivation', 'DeleteCancel', amendRes.id, subZID, sub.Name);
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
            zc_BillingPreviewResult previewRes = zc_Api.opeBillingPreviewPOST(accessToken, zEntityId, previewReq, RTExceptionCode.ERREUR_IMPAYE_REGLER_PROBLEM_PREVIEW, pLog);

            System.debug('MBEN: repWS: ' + repWS);

            
            Decimal tvaZuora = Decimal.valueOf(Utils.getUgcGenericParam('TVA Zuora',codePays).ParamValue__c); 

            for (zc_POSTBillingPreviewInvoiceItem invoice : previewRes.invoiceItems){
                Decimal chargeAmountTTC = (Decimal.valueOf(invoice.chargeAmount) * 100 * (1+(tvaZuora/100)));
                chargeAmountTTC = chargeAmountTTC.round();
                chargeAmountTTC = (chargeAmountTTC / 100);
                montantPreview = (Decimal)montantPreview + chargeAmountTTC;
            }

            System.debug('MBEN montantPreview: ' + montantPreview); 

        }
        
        hasDetteNonEchue = (montantPreview != 0)?true:false;

        System.debug('MBEN ERREUR_IMPAYE_REGLER_MONTANT_DNE montantPreview: ' + montantPreview);
        System.debug('MBEN ERREUR_IMPAYE_REGLER_MONTANT_DNE: impayeOut.montantDetteNonEchue' + impayeOut.montantDetteNonEchue);
        if (montantPreview != impayeOut.montantDetteNonEchue){
            // il faut remettre le cancel si applicable avec le try/catch
            throw new RTException(RTExceptionCode.ERREUR_IMPAYE_REGLER_MONTANT_DNE,pLog);
        }

        if (((Decimal)montantPreview + (Decimal)impayeOut.montantFrais + (Decimal)impayeOut.montantDetteEchue) != montantPaye){
                // il faut remettre le cancel si applicable avec le try/catch
            throw new RTException(RTExceptionCode.ERREUR_OFFRE_CYCLE_FERME,pLog);                
        }


        // Ajout Frais de gestion avec bill target date

        if (hasFraisGestion){
        String entite = (codePays == '033') ? 'France' : 'Belgique';
        String rpcReference = 'FRAISREACT';
        list<ProdRatePlanCharge__c> listProdRatePlanCharge = new list<ProdRatePlanCharge__c>([SELECT ReferenceCIC__c, zid__c, ProdRatePlan__r.zid__c 
        FROM ProdRatePlanCharge__c WHERE ReferenceCIC__c = :rpcReference and Entite__c = :entite]);        
    
        if(listProdRatePlanCharge.size() == 0){                
            throw new RTException(RTExceptionCode.ERREUR_IMPAYE_REGLER_PRODUIT_ABSENT,pLog);			
        }            
        
        String rpId = listProdRatePlanCharge.get(0).ProdRatePlan__r.zid__c;
        String rpcId = listProdRatePlanCharge.get(0).zid__c;
        //moisDebutRemise = Integer.valueOf(c.Mois_de_d_but_remise__c);
        //dateDebutFG = SM_Demande.getRemiseDate(moisDebutRemise);

        if (!hasDetteNonEchue){
            if (subActivated) {
                invTargetDate = sub.DateFinContrat__c;
                dateDebutFG = sub.DateFinContrat__c;

            }else {
                invTargetDate = Date.today();
                dateDebutFG = Date.today();
            }
        }else {
            if (subActivated) {
                invTargetDate = targetDate.addDays(-1);
                dateDebutFG = sub.DateFinContrat__c;
            }else {
                invTargetDate = targetDate.addDays(-1);
                dateDebutFG = sub.DateFinContrat__c;
            }
        }
        dateFacture = Date.today();
        
        //invTargetDate=(targetDate == null)?Date.today():targetDate.addDays(-1); //inclure ou pas la DNE
        //dateDebutFG=(Date.today() < targetDate || targetDate == null)?Date.today():targetDate.addDays(-1);
        
        // instantiate AmendRequest Instance
        zc_ProxyActionAmendRequest actionAmend = new zc_ProxyActionAmendRequest();
        zc_AmendRequest req1 = new zc_AmendRequest();        
        zc_AmendRequestPreviewOptions previewOptions = new zc_AmendRequestPreviewOptions();
        zc_AmendRequestAmendOptions amendOptions = new zc_AmendRequestAmendOptions();
        zc_Amendment amend1 = new zc_Amendment(); //Add product
        // zc_Amendment amend1 = new zc_Amendment(); 
        previewOptions.enablePreviewMode=false;
        amendOptions.generateInvoice = true;
        amendOptions.processPayments = false;
        zc_InvoiceProcessingOptions invPrc = new zc_InvoiceProcessingOptions();
        invPrc.invoiceDate=dateFacture;
        invPrc.invoiceTargetDate=invTargetDate;
        amendOptions.invoiceProcessingOptions = invPrc;

        //Ajout FG: avec ou sans DNE
        amend1.contractEffectiveDate = dateDebutFG;        
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
        zc_ProxyActionAmendResponse amendRes = zc_Api.actionAmendPOST(accessToken, zEntityId, actionAmend, RTExceptionCode.ERREUR_IMPAYE_REGLER_APPLICATION_FRAIS,pLog);
        currentSubId = amendRes.results.get(0).subscriptionId; //Get last subId
        invoiceId = amendRes.results.get(0).invoiceId;

        } //hasFG

        // Generate Account Billing
        if(!hasFraisGestion && hasDetteNonEchue){
            dateFacture = Date.today();
            invTargetDate=targetDate.addDays(-1);
            zc_PostGenerateBillingDocumentType billReq = new zc_PostGenerateBillingDocumentType();
            billReq.autoPost =true;
            billReq.autoRenew = true;
            billReq.effectiveDate = dateFacture;
            billReq.subscriptionIds.add(currentSubId);
            billReq.targetDate =  invTargetDate;
            zc_GenerateBillingDocumentResponseT billResp = zc_Api.accBillDocGeneratePOST(accessToken, zEntityId, billReq, accountID, RTExceptionCode.ERREUR_IMPAYE_REGLER_APPLICATION_BILL_DNE,pLog);
            System.debug(JSON.serialize(billResp));
            invoiceId = billResp.invoices.get(0).id;
        }

        // Creation paiement Zuora
        zc_CreatePaymentType payment = new zc_CreatePaymentType();
        payment.accountId = accountID;
        payment.amount = montantPaye;
        payment.currency2 = 'EUR';
        payment.r_type = zc_CreatePaymentType.RTypeEnum.External;
        payment.paymentMethodId = pmMethodId;
        payment.effectiveDate = Date.today();
        payment.referenceId = impayeRegIn.referenceId;
        payment.methodePaiement = impayeRegIn.methodPaiement;
        payment.lieu = impayeRegIn.lieu;
        payment.agent = impayeRegIn.agent;
        if (impayeRegIn.methodPaiement == 'VIR') {payment.dateVirement = impayeRegIn.dateVirement;}
        zc_PaymentInvoiceApplicationCreateR invoice1 = new zc_PaymentInvoiceApplicationCreateR(); // Invoice Amend : FG + DNE
        if(hasFraisGestion || hasDetteNonEchue){
            invoice1.amount = (Decimal)montantPreview + (Decimal)impayeOut.montantFrais; //TODO champ obligatoire, soit on requette invoice dans zuora, ou bien on utitilise les donnes deja calcules
            invoice1.invoiceId = invoiceId;
            payment.invoices.add(invoice1);
        }

        if (impayeOut.detteEchues.size() > 0){
            for (WSZ.DetteEchue dte : impayeOut.detteEchues){
                zc_PaymentInvoiceApplicationCreateR invoice = new zc_PaymentInvoiceApplicationCreateR();
                invoice.invoiceId = dte.invoiceId;
                invoice.amount = dte.invoiceTotalAmount;
                payment.invoices.add(invoice);
                detteEchueIds.add(dte.invoiceId); //utilise dans la mise a jour des factures;
            }
        }

        String dtechInvoiceId = detteTechInvoiceId(detteEchueIds); //dette technique invoice Id

        //Call WS Payment
        zc_GETARPaymentType paymentRes = zc_Api.paymentsPOST(accessToken, zEntityId, payment, RTExceptionCode.ERREUR_IMPAYE_REGLER_APPLICATION_PAYMENT,pLog);


        // Cancel Subscription si applicable
        if (subActivated) { //contrat initial au status Cancel
            if (targetDate == null) {
                // 2 cas: 
                if (dtechInvoiceId != null){ // DetteEchue de type dettetechnique Bilendi : => Cancel
                    cancelSub(sub);
                }else { // Pas de dette echue bilendi: => ne rien faire
                    // on laisse le contrat actif
                }
            }else if (targetDate < Date.today() ){
                //Cancel Contract
                cancelSub(sub);
                //TODO Update previous subscription values
            }else { // targetDate > Today
                // On laisse le contrat actif
            }
        }else { //contrat initial actif            
               // continue: contrat initial actif.
            }
        

        //Mise a jour subscription: (si contrat reactive/Actif): remettre tous les champs
        objUpdateReq = new zc_ProxyActionupdateRequest();
        objUpdateReq.r_type = 'Subscription';            
        zObj = new zc_ZObjectUpdate();
        zObj.id = currentSubId;
        if (hasFraisGestion) {zObj.fieldsToNull.add('Tech_DetteFraisGestion__c');}
        if (hasDetteNonEchue) {zObj.fieldsToNull.add('Tech_DetteNonEchue__c');zObj.fieldsToNull.add('Tech_DetteTargetDate__c');}

        if (subActivated && subRecancelled) { //contrat initial au status Cancel, active puis recancelle: Cancel->Active->Cancel
            //Mise à jour ancienne valeur codefin et date fin.
            zObj.codeFinContrat = sub.CodeFinContrat__c; // c les valeur du contrat initial
            zObj.dateFinContrat = sub.DateFinContrat__c; // c les valeur du contrat initial
        }else if (subActivated && !subRecancelled) { // Cancel->Active
            zObj.fieldsToNull.add('CodeFinContrat__c');
            zObj.fieldsToNull.add('DateFinContrat__c');
        }else if(!subActivated){ // Active
            zObj.fieldsToNull.add('CodeFinContrat__c');
            zObj.fieldsToNull.add('DateFinContrat__c');
        }        

        objUpdateReq.objects.add(zObj);
        System.debug(JSON.serialize(objUpdateReq,true));   
        //Call WS invoice update
        zc_Api.actionUpdatePOST(accessToken, zEntityId, objUpdateReq, RTExceptionCode.ERREUR_IMPAYE_REGLER_UPDATE_SUBSCRIPTION,pLog);



        //Mise a jour Account       
        objUpdateReq = new zc_ProxyActionupdateRequest();
        objUpdateReq.r_type = 'Account';
        zObj = new zc_ZObjectUpdate();
        zObj.id = accountID;
        zObj.batch = (subRecancelled)?'Batch8':'Batch1';
        objUpdateReq.objects.add(zObj);
        System.debug(JSON.serialize(objUpdateReq,true));

        //Call WS Account update
        zc_Api.actionUpdatePOST(accessToken, zEntityId, objUpdateReq, RTExceptionCode.ERREUR_IMPAYE_REGLER_UPDATE_ACCOUNT,pLog);


        //Mise a jour invoice        
        if (detteEchueIds.size() > 0) {
            //List<Zuora__ZInvoice__c> invoices2 = SM_Invoice.getInvoiceByIds(detteEchueIds);                        
            objUpdateReq = new zc_ProxyActionupdateRequest();
            objUpdateReq.r_type = 'Invoice';                 
            for (Zuora__ZInvoice__c inv2 : SM_Invoice.getInvoiceByIds(detteEchueIds) ){
                if (inv2.Tech_CompteurRejet__c != null && Integer.valueOf(inv2.Tech_CompteurRejet__c) > 0 ){  // pour isoler juste les factures de rejet
                    zObj = new zc_ZObjectUpdate();
                    zObj.id = inv2.Zuora__External_Id__c;
                    zObj.tech_FlagRejetPaye = 'true';
                    objUpdateReq.objects.add(zObj);
                }
            }

            if (dtechInvoiceId != null){ //flag dette technique
                zObj = new zc_ZObjectUpdate();
                zObj.id = dtechInvoiceId;
                zObj.tech_FlagRejetPaye = 'true';
                objUpdateReq.objects.add(zObj);                
            }

            // if (objUpdateReq.objects.size() == 0 ){
            //     throw new RTException(RTExceptionCode.ERREUR_IMPAYE_REGLER_UPDATE_INVOICE2,pLog);
            // }
            System.debug(JSON.serialize(objUpdateReq,true));

            zc_Api.actionUpdatePOST(accessToken, zEntityId, objUpdateReq, RTExceptionCode.ERREUR_IMPAYE_REGLER_UPDATE_INVOICE,pLog);
        }
        
        // Create Case ??
        Id caseId = createImpayeCase(accountSID, contactId, codePays, montantPaye);

        WSZ.ImpayeReglerOut impayeRegOut = new WSZ.ImpayeReglerOut(accountID, currentSubId, paymentRes.amount, impayeRegIn.referenceId, paymentRes.id);

        return impayeRegOut;

    }

    private static Id createImpayeCase(String accountSID, String contactId, String codePays, Double montantPaye){
        
        Id impayeRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Impayé').getRecordTypeId();
        Case c = new Case();
        c.RecordTypeId = impayeRecordTypeId;
        c.AccountId = accountSID;
        c.Famille__c = '7- Finance';
        c.Motif__c = '02- Impaye';
        c.SousMotif__c = 'A- Action';
        c.CommentairesInternes__c = 'Règlement d\'impayé ' + String.valueOf(montantPaye);
        //c.Payment__c = paymentId;
        c.Origin = 'Selfcare';
        c.Status = 'Fermee';
        c.Reglementdimpaye__c = montantPaye;
        // c.DemandeRemboursement__c = (codePays=='032')?'UGCUnlimited':'UGCIllimité';
        c.ContactId = contactId;
        insert c;
        return c.Id;
    }

    public static String detteTechInvoiceId(List<String> invoiceIds){
        String r = null;
        for(String invoiceId:invoiceIds){
            zc_GETInvoiceItemsResponse resObj = zc_Api.invoicesItemsGET(accessToken, zEntityId, invoiceId, RTExceptionCode.ERREUR_DESABO_COUPON_ABOTIER, pLog);
            for(zc_InvoiceItem inv:resObj.invoiceItems){
                if (DETTETECH_NAME.contains(inv.chargeName)){
                    r = invoiceId;
                }
                System.debug('MBEN:'+inv.chargeName);
            }
        }
        
        return r;

    }

    public static void cancelSub(Zuora__Subscription__c sub2){
        zc_POSTSubscriptionCancellationType reqObj = new zc_POSTSubscriptionCancellationType();
        reqObj.cancellationEffectiveDate = sub2.Zuora__CancelledDate__c;
        reqObj.targetDate = sub2.Zuora__CancelledDate__c;
        reqObj.runBilling = false;
        reqObj.cancellationPolicy = 'SpecificDate';
        zc_POSTSubscriptionCancellationResp rCancel = zc_Api.subscriptionCancelPUT(accessToken, zEntityId, reqObj, currentSubId, RTExceptionCode.ERREUR_IMPAYE_REGLER_APPLICATION_CANCEL, pLog);
        currentSubId = rCancel.subscriptionId;
        subRecancelled = true;
        //TODO TRACKING AMEND
        //zc_GETAmendmentType amend = zc_Api.amendSubscriptionGET(accessToken, zEntityId, currentSubId, RTExceptionCode.ERREUR_IMPAYE_REGLER_APPLICATION_CANCEL, pLog);        
        //SM_Hermes.trackOperation('AJOUT', Datetime.now(), 'Resiliation', 'Cancel', amend.id, currentSubId, sub2.Name);

    }

 
}