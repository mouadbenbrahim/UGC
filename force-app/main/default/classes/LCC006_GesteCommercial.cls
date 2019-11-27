public without sharing class LCC006_GesteCommercial {
    
    public static Case dem;
    public static Zuora__Subscription__c sub;
    public static Account acc;
    public static ProcessLog__c pLog;
    public static zc_GETSubscriptionTypeWithSuccess subZdoc;
    public static zc_ProxyGetPaymentMethod pm;
    public static String prodRatePlanChargeReferenceGesteCommercialCDI = 'REMMONT';
    public static String prodRatePlanChargeReferenceGesteCommercialCDD = 'REMMENS';
    
    public static void executeGesteCommercial(Id ddeId, Boolean fromOnglet) {
        system.debug('##MNE LCC006_GesteCommercial executeGesteCommercial ddeId >> '+ddeId);
        
        if(!fromOnglet){
            dem = SM_Demande.getDemande(ddeId);
        }
        pLog = new ProcessLog__c(Process__c = 'executeGesteCommercial', Account__c = dem.AccountId, SubscriptionName__c = dem.SubscriptionZName__c, Case__c = ddeId);
        
        //sub = SM_Subscription.getSubscription(dem.Subscription__c);
        sub = SM_Subscription.getActiveSubscriptionByNameORAccId(dem.SubscriptionZName__c, dem.AccountId);
        acc = SM_Account.getAccount(dem.AccountId);

        verif(fromOnglet);
        
        if (sub.TypeContrat__c == 'CDI') {
            executeGesteCommercialCDI2(ddeId);
        }
        else {
            executeGesteCommercialCDD3(ddeId);
        }
        
        if(!fromOnglet){
            Id zDocId = SM_Hermes.addZdocData(new Map<String,Object>{'ZSUB' => subZdoc,'ZPM' => pm,'ACC' => acc});           
            dem.ZDocData__c = zDocId;       
            dem.Status = 'Fermee';       
            update dem;  
            SM_SDoc.makeSdocJobs(new list<Case>{dem});
        }
    }
        

    public static void executeGesteCommercialCDD3(Id ddeId) {
        String zuoraSubId = sub.Zuora__External_Id__c;
        String zEntityId = WS001_CallZuora.getZuoraEntityId(acc.CodePays__c);
        String entite = (acc.CodePays__c == '033') ? 'France' : 'Belgique';
        Integer currentTerm = Integer.valueOf(sub.Zuora__CurrentTerm__c.split(' ').get(0));
        Integer nbDeMoisRemise = Integer.valueOf(dem.NombreDeMoisRemise__c);
        String rpcReference = prodRatePlanChargeReferenceGesteCommercialCDD;
        String accessToken = WS001_CallZuora.access_token;
        String currentTermPeriodType = sub.Zuora__CurrentTermPeriodType__c;
        Integer newCurrentTerm;

        if(CurrentTermPeriodType == 'Day'){
            Date endDate    = Date.valueOf(sub.Zuora__TermEndDate__c);
            Date newEndDate = endDate.addMonths(nbDeMoisRemise);
            newCurrentTerm = currentTerm + endDate.daysBetween(newEndDate);
        }else { //Months
            newCurrentTerm = currentTerm + nbDeMoisRemise;
        }

        list<ProdRatePlanCharge__c> listProdRatePlanCharge = new list<ProdRatePlanCharge__c>([SELECT ReferenceCIC__c, zid__c, ProdRatePlan__r.zid__c 
        FROM ProdRatePlanCharge__c WHERE ReferenceCIC__c = :rpcReference and Entite__c = :entite]);        
        
        if(listProdRatePlanCharge.size() == 0){
            throw new RTException(RTExceptionCode.ERREUR_GESTCO_CDD_PRODUIT_ABSENT,pLog);           
        }

        String rpId = listProdRatePlanCharge.get(0).ProdRatePlan__r.zid__c;
        String rpcId = listProdRatePlanCharge.get(0).zid__c;

        // instantiate AmendRequest Instance
        zc_ProxyActionAmendRequest actionAmend = new zc_ProxyActionAmendRequest();
        zc_AmendRequest req1 = new zc_AmendRequest();        
        zc_AmendRequestPreviewOptions previewOptions = new zc_AmendRequestPreviewOptions();
        zc_AmendRequestAmendOptions amendOptions = new zc_AmendRequestAmendOptions();
        zc_Amendment amend1 = new zc_Amendment(); //Term and condition
        zc_Amendment amend2 = new zc_Amendment(); //Add product
        previewOptions.enablePreviewMode=false;
        amendOptions.generateInvoice=true;
        // c1.amendOptions.processPayments=false;
        zc_InvoiceProcessingOptions invPrc = new zc_InvoiceProcessingOptions();
        invPrc.invoiceDate=Date.today();
        invPrc.invoiceTargetDate=sub.Zuora__TermEndDate__c;
        amendOptions.invoiceProcessingOptions = invPrc;
        //Term and condition
        amend1.contractEffectiveDate=Date.today();
        amend1.name='GestCo CDD: update term and condition';
        amend1.status='Completed';
        amend1.subscriptionId=sub.Zuora__External_Id__c;
        amend1.r_type='TermsAndConditions';
        amend1.description='GestCo CDD: update term and condition'; 
        amend1.currentTerm=newCurrentTerm;
        // Add remise
        amend2.contractEffectiveDate=sub.Zuora__TermEndDate__c;        
        amend2.name='GestCo CDD: Ajour remise';
        amend2.status='Completed';
        amend2.subscriptionId=sub.Zuora__External_Id__c;
        amend2.r_type='NewProduct';
        amend2.description='GestCo CDD: Ajour remise';           
        zc_AmendmentRatePlanData ratePlanData = new zc_AmendmentRatePlanData();
        zc_RatePlan ratePlan = new zc_RatePlan();
        ratePlan.productRatePlanId=rpId;                
        ratePlanData.ratePlan = ratePlan;
        zc_RatePlanChargeDataInRatePlanData rpcChargeData = new zc_RatePlanChargeDataInRatePlanData();
        zc_RatePlanChargeInRatePlanChargeData rpcCharge = new zc_RatePlanChargeInRatePlanChargeData();
        rpcChargeData.ratePlanCharge = rpcCharge;        
        // rpcCharge.endDateCondition = 'FixedPeriod';
        rpcCharge.upToPeriods = nbDeMoisRemise;
        // rpcCharge.upToPeriodsType = 'Billing Periods';        
        rpcCharge.productRatePlanChargeId = rpcId;                
        ratePlanData.ratePlanChargeData.add(rpcChargeData);
        //ratePlanData.ratePlanChargeData.add(ratePlanChargeData);
        amend2.ratePlanData = ratePlanData;
        req1.amendments.add(amend1);
        req1.amendments.add(amend2);
        req1.previewOptions = previewOptions;
        req1.amendOptions = amendOptions;
        actionAmend.requests.add(req1);

        //Call WS
        zc_ProxyActionAmendResponse repObj = zc_Api.actionAmendPOST(accessToken, zEntityId, actionAmend, RTExceptionCode.ERREUR_GESTCO_APPLICATION_CDD, pLog);
       
        String currentSubId=repObj.results.get(0).subscriptionId; //Get last subId
    
        //Update de la souscription avec la date de fin de contrat
        //Mise à jour ancienne valeur codefin et date fin.
        zc_ProxyActionupdateRequest objUpdateReq = new zc_ProxyActionupdateRequest();
        objUpdateReq.r_type = 'Subscription';
        zc_ZObjectUpdate zObj = new zc_ZObjectUpdate();
        zObj.id = currentSubId;
                    
        zObj.dateFinContrat = sub.DateFinContrat__c.addMonths(nbDeMoisRemise); // c les valeur du contrat initial
        objUpdateReq.objects.add(zObj);
        System.debug(JSON.serialize(objUpdateReq,true));   

        //Call WS Subscription update
        zc_ProxySaveResult objUpdateRes = zc_Api.actionUpdatePOST(accessToken, zEntityId, objUpdateReq, RTExceptionCode.ERREUR_GESTCO_APPLICATION_CDD, pLog);
        
        
        //Debut call out pour ZDOC
        // Get Zuora Data (subscription)
        subZdoc = zc_Api.subscriptionGET(accessToken, zEntityId, currentSubId, RTExceptionCode.ERREUR_ACQUISIT_GET_ZSUBSCRIPTION, pLog);
        
        // Get Zuora Data (Account)
        zc_ProxyGetAccount zacc = zc_Api.objectAccountGET(accessToken, zEntityId, sub.Zuora__CustomerAccount__r.Zuora__Zuora_Id__c, RTExceptionCode.ERREUR_ACQUISIT_GET_ACCOUNT, pLog);
        String payMethodId = zacc.defaultPaymentMethodId;
        
        // Get Zuora Data (PaymentMethod)
        pm = zc_Api.objectPaymentMethodGET(accessToken, zEntityId, payMethodId, RTExceptionCode.ERREUR_ACQUISIT_GET_PAYMENTMETHOD, pLog);
        //Fin call out pour ZDOC

    }

    public static void executeGesteCommercialCDI2(Id ddeId) {
        String zuoraSubId = sub.Zuora__External_Id__c;
        String zEntityId = WS001_CallZuora.getZuoraEntityId(acc.CodePays__c);
        String entite = (acc.CodePays__c == '033') ? 'France' : 'Belgique';
        String rpcReference = prodRatePlanChargeReferenceGesteCommercialCDI;
        String accessToken = WS001_CallZuora.access_token;

        String moisDebutRemise = dem.Mois_de_d_but_remise__c;
        Double montantRemise = dem.MontantRemise__c;
        Integer nbDeMoisRemise = Integer.valueOf(dem.NombreDeMoisRemise__c);
        Date dateDebutRemise = SM_Demande.getRemiseDate(Integer.valueOf(moisDebutRemise),sub.Zuora__ContractEffectiveDate__c);
        String pallier = dem.Pallier__c;

        System.debug('##ECH LCC006_GesteCommercial executeGesteCommercialCDI2 sub.Zuora__ContractEffectiveDate__c :'+sub.Zuora__ContractEffectiveDate__c);
        System.debug('##ECH LCC006_GesteCommercial executeGesteCommercialCDI2 dateDebutRemise :'+dateDebutRemise);

        list<ProdRatePlanCharge__c> listProdRatePlanCharge = new list<ProdRatePlanCharge__c>([SELECT ReferenceCIC__c, zid__c, ProdRatePlan__r.zid__c 
        FROM ProdRatePlanCharge__c WHERE ReferenceCIC__c = :rpcReference and Entite__c = :entite]);        
        
        if(listProdRatePlanCharge.size() == 0){
            throw new RTException(RTExceptionCode.ERREUR_GESTCO_CDD_PRODUIT_ABSENT,pLog);           
        }

        String rpId = listProdRatePlanCharge.get(0).ProdRatePlan__r.zid__c;
        String rpcId = listProdRatePlanCharge.get(0).zid__c;

        // instantiate AmendRequest Instance
        zc_ProxyActionAmendRequest actionAmend = new zc_ProxyActionAmendRequest();
        zc_AmendRequest req1 = new zc_AmendRequest();        
        zc_AmendRequestPreviewOptions previewOptions = new zc_AmendRequestPreviewOptions();
        zc_AmendRequestAmendOptions amendOptions = new zc_AmendRequestAmendOptions();
        zc_Amendment amend1 = new zc_Amendment(); //Add product
        previewOptions.enablePreviewMode=false;
        amendOptions.generateInvoice=false;

        // Add remise
        if(dem.DateDemande__c>sub.Zuora__ContractEffectiveDate__c)
        amend1.contractEffectiveDate=dem.DateDemande__c;
        else
        amend1.contractEffectiveDate=sub.Zuora__ContractEffectiveDate__c;         
        
        amend1.name='Geste Commercial';
        amend1.status='Completed';
        amend1.subscriptionId=sub.Zuora__External_Id__c;
        amend1.r_type='NewProduct';
        amend1.description='Geste Commercial description';    

        zc_AmendmentRatePlanData ratePlanData = new zc_AmendmentRatePlanData();
        zc_RatePlan ratePlan = new zc_RatePlan();
        ratePlan.productRatePlanId=rpId;                
        ratePlanData.ratePlan = ratePlan;
        zc_RatePlanChargeDataInRatePlanData rpcChargeData = new zc_RatePlanChargeDataInRatePlanData();
        zc_RatePlanChargeInRatePlanChargeData rpcCharge = new zc_RatePlanChargeInRatePlanChargeData();
        rpcChargeData.ratePlanCharge = rpcCharge;        
        // rpcCharge.endDateCondition = 'FixedPeriod';
        rpcCharge.discountAmount = montantRemise;
        rpcCharge.triggerEvent = 'SpecificDate';
        rpcCharge.triggerDate = dateDebutRemise;
        rpcCharge.upToPeriods = nbDeMoisRemise;
        // rpcCharge.upToPeriodsType = 'Billing Periods';        
        rpcCharge.productRatePlanChargeId = rpcId;                
        ratePlanData.ratePlanChargeData.add(rpcChargeData);
        //ratePlanData.ratePlanChargeData.add(ratePlanChargeData);
        amend1.ratePlanData = ratePlanData;
        req1.amendments.add(amend1);
        req1.previewOptions = previewOptions;
        req1.amendOptions = amendOptions;
        actionAmend.requests.add(req1);

        //Call WS
        zc_ProxyActionAmendResponse repObj = zc_Api.actionAmendPOST(accessToken, zEntityId, actionAmend, RTExceptionCode.ERREUR_GESTCO_APPLICATION_CDD, pLog);
        String currentSubId=repObj.results.get(0).subscriptionId; //Get last subId
        
        
        //Debut call out pour ZDOC
        // Get Zuora Data (subscription)
        subZdoc = zc_Api.subscriptionGET(accessToken, zEntityId, currentSubId, RTExceptionCode.ERREUR_ACQUISIT_GET_ZSUBSCRIPTION, pLog);
        
        // Get Zuora Data (Account)
        zc_ProxyGetAccount zacc = zc_Api.objectAccountGET(accessToken, zEntityId, sub.Zuora__CustomerAccount__r.Zuora__Zuora_Id__c, RTExceptionCode.ERREUR_ACQUISIT_GET_ACCOUNT, pLog);
        String payMethodId = zacc.defaultPaymentMethodId;
        
        // Get Zuora Data (PaymentMethod)
        pm = zc_Api.objectPaymentMethodGET(accessToken, zEntityId, payMethodId, RTExceptionCode.ERREUR_ACQUISIT_GET_PAYMENTMETHOD, pLog);
        //Fin call out pour ZDOC
    }


    private static void verif(Boolean fromOnglet) {
        
        if (sub == null) {
            throw new RTException(RTExceptionCode.ERREUR_GESTCO_CONTRAT_ABSENT_DDE,pLog);
        } 

        if (!fromOnglet && dem.Status == SM_Demande.getStatus('Fermee')) {
            throw new MyException('Cette demande a deja ete traite'); 
        }

        if (!fromOnglet && dem.SousMotif__c == null) {
            throw new MyException('Sous-Motif obligatoire');
        }

        //Check Souscription Status
        if (sub.Zuora__Status__c != 'Active') {
            throw new MyException('L abonnement n est pas actif');
        }
        
        String moisDebutRemise = dem.Mois_de_d_but_remise__c;
        Double montantRemise = dem.MontantRemise__c;
        Integer nbDeMoisRemise = Integer.valueOf(dem.NombreDeMoisRemise__c);
        String pallier = dem.Pallier__c;
        
        if (sub.TypeContrat__c == 'CDI') {
            if((String.isBlank(moisDebutRemise) && montantRemise == null && nbDeMoisRemise == null && String.isBlank(pallier))
            || (String.isNotBlank(moisDebutRemise) && montantRemise != null && nbDeMoisRemise != null && String.isNotBlank(pallier))
            || ((String.isBlank(moisDebutRemise) || montantRemise == null || nbDeMoisRemise == null) && String.isBlank(pallier))
            || ((String.isNotBlank(moisDebutRemise) || montantRemise != null || nbDeMoisRemise != null) && String.isNotBlank(pallier)) ){
                throw new MyException('Merci de renseigner les champ : \n -Montant remise\n -Mois de début remise\n -Nombre de mois remise\n\nOU\n\n-Pallier');
            }
        }
        else {
            if(nbDeMoisRemise == null){
                throw new MyException('Merci de renseigner le champ : Nombre de mois remise');
            }
        }
    }
    
    
    @AuraEnabled
    public static WRPInt ongletExecuteGesteCommercial(Case caseRecord, Id caseId) {
        System.debug('##MNE LCC006_GesteCommercial ongletExecuteGesteCommercial caseRecord >> '+caseRecord);
        System.debug('##MNE LCC006_GesteCommercial ongletExecuteGesteCommercial caseId >> '+caseId);
        
        WRPInt rep = new WRPInt();  
        
        try{
            //Case c = [SELECT Id, AccountId, DateDemande__c FROM Case WHERE Id = :caseId LIMIT 1];
            Case c = SM_Demande.getDemande(caseId);
            Id accId = c.AccountId;
            
            String moisDebutRemise = caseRecord.Mois_de_d_but_remise__c;
            Double montantRemise = caseRecord.MontantRemise__c;
            Integer nbDeMoisRemise = Integer.valueOf(caseRecord.NombreDeMoisRemise__c);
            String pallier = caseRecord.Pallier__c; 
            String dateDemandeTMP = String.valueOf(c.DateDemande__c);
            
            //creataion du nouveau case
            Id gesteCoRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Gestes commerciaux').getRecordTypeId();
            Case cTMP = new Case();
            cTMP.Mois_de_d_but_remise__c = moisDebutRemise;
            cTMP.MontantRemise__c = montantRemise;
            cTMP.NombreDeMoisRemise__c = nbDeMoisRemise;
            cTMP.Pallier__c = pallier;
            cTMP.AccountId = accId;
            cTMP.RecordTypeId = gesteCoRecordTypeId;
            cTMP.Famille__c = '7- Finance';
            cTMP.Motif__c = '06- Gestes commerciaux';
            cTMP.SubscriptionZName__c = c.SubscriptionZName__c; 
            
            dem = cTMP;
            
            executeGesteCommercial(caseId, true);
            Id zDocId = SM_Hermes.addZdocData(new Map<String,Object>{'ZSUB' => subZdoc,'ZPM' => pm});
            dem.ZDocData__c = zDocId;       
            dem.Status = 'Fermee';       
            insert dem;  
            SM_SDoc.makeSdocJobs(new list<Case>{dem});
             
            rep.caseIdToRedirect = dem.Id;
            rep.accountIdToRedirect = accId;
            
            //WRPInt rep = executeGesteCommercial(caseId, accId, moisDebutRemise, montantRemise, nbDeMoisRemise, pallier, dateDemandeTMP);
            //if(!rep.showMessage){
                /*//creataion du nouveau case
                Id gesteCoRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Gestes commerciaux').getRecordTypeId();
                Case cTMP = new Case();
                cTMP.Mois_de_d_but_remise__c = moisDebutRemise;
                cTMP.MontantRemise__c = montantRemise;
                cTMP.NombreDeMoisRemise__c = nbDeMoisRemise;
                cTMP.Pallier__c = pallier;
                cTMP.AccountId = accId;
                cTMP.RecordTypeId = gesteCoRecordTypeId;
                cTMP.Famille__c = '7- Finance';
                cTMP.Motif__c = '06- Gestes commerciaux';
                cTMP.SubscriptionZName__c = c.SubscriptionZName__c;*/
                //insert cTMP;     
                //rep.caseIdToRedirect = cTMP.Id;
                //rep.accountIdToRedirect = accId;
            //}
            
        } catch(Exception e){
            rep.showMessage = true;
            rep.messageToDisplay = e.getMessage();
            return rep;
        }
        return rep;
    }
    
    public without sharing class WRPInt {
        @AuraEnabled public Boolean showMessage                         { get; set; }
        @AuraEnabled public String  messageToDisplay                    { get; set; }
        @AuraEnabled public Id  caseIdToRedirect                        { get; set; }
        @AuraEnabled public Id  accountIdToRedirect                     { get; set; }
        
        public WRPInt() {
            this.showMessage            = false;
            this.messageToDisplay       = '';
            this.caseIdToRedirect       = null;
            this.accountIdToRedirect    = null;
        }
    }
    
    /*
    @AuraEnabled 
    public static WRPInt executeGesteCommercial(Id caseId, Id accId, String moisDebutRemise, Double montantRemise, Integer nbDeMoisRemise, String pallier, String dateDemandeTMP){
        Date dateDemande = Date.valueOf(dateDemandeTMP);
        system.debug('##MNE LCC006_GesteCommercial executeGesteCommercial caseId >> '+caseId);
        system.debug('##MNE LCC006_GesteCommercial executeGesteCommercial accId >> '+accId);
        system.debug('##MNE LCC006_GesteCommercial executeGesteCommercial moisDebutRemise >> '+moisDebutRemise);
        system.debug('##MNE LCC006_GesteCommercial executeGesteCommercial montantRemise >> '+montantRemise);
        system.debug('##MNE LCC006_GesteCommercial executeGesteCommercial nbDeMoisRemise >> '+nbDeMoisRemise);
        system.debug('##MNE LCC006_GesteCommercial executeGesteCommercial pallier >> '+pallier);
        system.debug('##MNE LCC006_GesteCommercial executeGesteCommercial dateDemande >> '+dateDemande);
        
        WRPInt rep = new WRPInt();  
        
        if((String.isBlank(moisDebutRemise) && montantRemise == null && nbDeMoisRemise == null && String.isBlank(pallier))
        || (String.isNotBlank(moisDebutRemise) && montantRemise != null && nbDeMoisRemise != null && String.isNotBlank(pallier))
        || ((String.isBlank(moisDebutRemise) || montantRemise == null || nbDeMoisRemise == null) && String.isBlank(pallier))
        || ((String.isNotBlank(moisDebutRemise) || montantRemise != null || nbDeMoisRemise != null) && String.isNotBlank(pallier)) ){
            rep.showMessage = true;
            rep.messageToDisplay = 'Merci de renseigner les champ : \n -Montant remise\n -Mois de début remise\n -Nombre de mois remise\n\nOU\n\n-Pallier';
            return rep;
        }
        
        list<Zuora__Subscription__c> listSub = new list<Zuora__Subscription__c>([SELECT Zuora__External_Id__c, Zuora__Account__r.ProduitUGC__c, Zuora__Account__r.CodePays__c, TypeContrat__c FROM Zuora__Subscription__c WHERE Zuora__Account__c =:accId AND Zuora__Status__c = 'Active' ORDER BY CreatedDate DESC NULLS FIRST LIMIT 1]);
        
        if(listSub.size() == 0){
            rep.showMessage = true;
            rep.messageToDisplay = 'Pas de souscription trouvée.';
            return rep;
        }
        
        String zuoraSubId = listSub.get(0).Zuora__External_Id__c;
        String zEntityId = WS001_CallZuora.getZuoraEntityId(listSub.get(0).Zuora__Account__r.CodePays__c);
        String ProductRatePlanId;
        String ProductRatePlanChargeId;
        
        try{
            
            //MNE TODO => 
            //modifier le call zuora pour prendre en compte le pallier (c a d soit montant sur plusieur mois sois pallier sur moi apres la date de la demande)
            String prefixe = '';
            if(listSub.get(0).Zuora__Account__r.CodePays__c == '033'){
                prefixe = 'FR';
            }else if(listSub.get(0).Zuora__Account__r.CodePays__c == '032'){
                prefixe = 'BE';
            }
            String productRatePlanReference = prefixe + SM001_GesteCommercial.prodRatePlanChargeReferenceGesteCommercialCDI;
            list<ProdRatePlanCharge__c> listProdRatePlanCharge = new list<ProdRatePlanCharge__c>([SELECT Reference__c, zid__c, ProdRatePlan__r.zid__c FROM ProdRatePlanCharge__c WHERE Reference__c = :productRatePlanReference]);
            if(listProdRatePlanCharge.size() == 0){
                system.debug('##MNE LCC006_GesteCommercial executeGesteCommercial Pas de Product Rate Plan Charge trouvée pour le geste commercial');
                rep.showMessage = true;
                rep.messageToDisplay = 'Pas de Product Rate Plan Charge trouvée pour le geste commercial.';
                return rep;
            }
            
            ProdRatePlanCharge__c prodRatePlanCharge = listProdRatePlanCharge.get(0);
            ProductRatePlanId = prodRatePlanCharge.ProdRatePlan__r.zid__c;
            ProductRatePlanChargeId = prodRatePlanCharge.zid__c;
            
            String inBody = SM001_GesteCommercial.getBodyGC (zuoraSubId, ProductRatePlanId, ProductRatePlanChargeId, montantRemise, nbDeMoisRemise, dateDemande, moisDebutRemise);
            
            //String repWS = SM001_GesteCommercial.sendRequest(zuoraSubId, ProductRatePlanId, ProductRatePlanChargeId, montantRemise, nbDeMoisRemise, dateDemande, moisDebutRemise);
            String repWS = SM001_GesteCommercial.sendAmendRequest(inBody, zEntityId);
            
            SM001_GesteCommercial.Resultat resApex =   (SM001_GesteCommercial.Resultat)System.JSON.deserialize(repWS, SM001_GesteCommercial.Resultat.class);
            System.debug('##MNE LCC006_GesteCommercial executeGesteCommercial resJsonOriginal >> '+repWS);
            System.debug('##MNE LCC006_GesteCommercial executeGesteCommercial resApex >> '+resApex);
            
            Boolean success = true;
            String messageError = '';
            if(resApex != null && resApex.results != null  && resApex.results.size() > 0){
                for(SM001_GesteCommercial.Result r : resApex.results){
                    if(!r.Success){
                        rep.showMessage = true;
                        if(r.Errors != null && r.Errors.size() > 0){
                            rep.messageToDisplay = r.Errors.get(0).Message;
                            break;
                        }
                    }
                }
            }

        } catch(Exception e){
            rep.showMessage = true;
            rep.messageToDisplay = e.getMessage();
            system.debug('##MNE inser KO');
            return rep;
        }
        system.debug('##MNE LCC006_GesteCommercial executeGesteCommercial rep >> '+rep);
        return rep;
    }*/
    
    private class MyException extends Exception {
    }

}