public without sharing class SM003_Retention {
    
    public static void retention(String caseId){
        System.debug('##MNE SM003_Retention retention caseId >> ' + caseId);
        
        if(caseId == null){
            throw new MyException('No Id Case found for Retention');
        }
        Case c = [SELECT Id, Status, DateDemande__c, AccountId, Offre_de_r_tention__c, Mois_de_d_but_remise__c, Raison_de_d_sabonnement__c, Type_de_d_sabonnement__c, R_sultat_R_tention__c, Date_fin_engagement__c, Subscription__c 
                    FROM Case WHERE Id =:caseId].get(0);
        
        if((c.Offre_de_r_tention__c == null   || c.Offre_de_r_tention__c == '')
        || (c.Raison_de_d_sabonnement__c == null   || c.Raison_de_d_sabonnement__c == '')
        || (c.R_sultat_R_tention__c == null || c.R_sultat_R_tention__c == '') ){
            System.debug('##MNE SM003_Retention retention field empty >> "Offre de rétention", "Raison de désabonnement" et "Résultat Rétention"');
            throw new MyException('Merci de renseigner les champ : "Offre de rétention", "Raison de désabonnement" et "Résultat Rétention"');
        }
        
        if(c.Offre_de_r_tention__c == 'Hausse tarifaire'){
        	System.debug('##MNE SM003_Retention retention Offre de rétention "Hausse tarifaire" choisi');
            throw new MyException('Poduit non fonctionnel : "Hausse tarifaire"');
        }
        
        if(c.R_sultat_R_tention__c != null && (c.R_sultat_R_tention__c == 'Refuse sans desabonnement' || c.R_sultat_R_tention__c == 'Client indécis') ){
            c.Status = 'EnCours';
            update c;
            System.debug('##MNE SM003_Retention retention case closed EnCours');
            return;
        } else if(c.R_sultat_R_tention__c != null && c.R_sultat_R_tention__c == 'Accepté'){
            System.debug('##MNE SM003_Retention retention go to rentention in zuora');
            executeRetention(c);
            c.Status = 'EnCours';
            update c;
        } else if(c.R_sultat_R_tention__c != null && c.R_sultat_R_tention__c == 'Refuse avec desabonnement'){
            System.debug('##MNE SM003_Retention retention go to desabonnement');
            SM_Desabonnement.desabonner(c.Id,false);
            c.Status = 'EnCours';
            update c;
        }
    }
    
    public static void executeRetention(Case c){
        system.debug('##MNE SM003_Retention executeRetention case >> '+c);

        Boolean hasRemiseRetention = false;
        Integer moisDebutRemise;
        Date dateDebutRemise, newContractStartDate;
        String rpId, rpcId;        
        
        //mois obligatoir si l'offre proposé != Points fidélité && != Hausse tarifaire
        if( (c.Mois_de_d_but_remise__c == null || c.Mois_de_d_but_remise__c == '') 
        &&  (c.Offre_de_r_tention__c != 'Points fidélité' && c.Offre_de_r_tention__c != 'Hausse tarifaire') ){
            system.debug('##MNE SM003_Retention executeRetention field empty >> "Mois de début remise"');
            throw new MyException('Merci de renseigner le champ : "Mois de début remise"');
        }
        
        Id accId = c.AccountId;
        Zuora__Subscription__c sub = SM_Subscription.getSubscription(c.Subscription__c);
        
        if(sub.TypeContrat__c == 'CDD'){
            system.debug('##MNE SM003_Retention executeRetention Pas possible pour CDD.');
            throw new MyException('La rétention n\'est pas possible pour un utilisateur en CDD.');
        }
        
        String zuoraSubId = sub.Zuora__External_Id__c;
        String zEntityId = WS001_CallZuora.getZuoraEntityId(sub.Zuora__Account__r.CodePays__c);        
        list<SM001_GesteCommercial.Amendment> listAmendment = new list<SM001_GesteCommercial.Amendment>();
        
        // determiner si application de remise + produit remise
        if(c.Offre_de_r_tention__c != 'Points fidélité'){        	
            String entite = (sub.Zuora__Account__r.CodePays__c == '033') ? 'France' : 'Belgique';
            String rpcReference = c.Offre_de_r_tention__c;
            list<ProdRatePlanCharge__c> listProdRatePlanCharge = new list<ProdRatePlanCharge__c>([SELECT ReferenceCIC__c, zid__c, ProdRatePlan__r.zid__c 
            FROM ProdRatePlanCharge__c WHERE ReferenceCIC__c = :rpcReference and Entite__c = :entite]);        
        
            if(listProdRatePlanCharge.size() == 0){                
                throw new RTException(RTExceptionCode.ERREUR_RETENTION_PRODUIT_ABSENT);			
		    }            
            
            rpId = listProdRatePlanCharge.get(0).ProdRatePlan__r.zid__c;
		    rpcId = listProdRatePlanCharge.get(0).zid__c;
            moisDebutRemise = Integer.valueOf(c.Mois_de_d_but_remise__c);
            dateDebutRemise = SM_Demande.getRemiseDate(moisDebutRemise);
            
            hasRemiseRetention = true;
        }
                

        if(sub.Zuora__TermSettingType__c == 'EVERGREEN'){
    	 	newContractStartDate = Util.finMois(Date.today()).addDays(1); // premier jour du mois suivant
        }else if (sub.Zuora__TermSettingType__c == 'TERMED'){
    	 	newContractStartDate = sub.Zuora__TermEndDate__c;
        }


        // instantiate AmendRequest Instance
        zc_ProxyActionAmendRequest actionAmend = new zc_ProxyActionAmendRequest();
        zc_AmendRequest req1 = new zc_AmendRequest();        
        zc_AmendRequestPreviewOptions previewOptions = new zc_AmendRequestPreviewOptions();
        zc_AmendRequestAmendOptions amendOptions = new zc_AmendRequestAmendOptions();
        zc_Amendment amend1 = new zc_Amendment(); //Term and condition
        zc_Amendment amend2 = new zc_Amendment(); //Add product
        previewOptions.enablePreviewMode=false;
        amendOptions.generateInvoice=false;
        amendOptions.processPayments=false;
        //zc_InvoiceProcessingOptions invPrc = new zc_InvoiceProcessingOptions();
        //invPrc.invoiceDate=Date.today();
        //invPrc.invoiceTargetDate=sub.Zuora__TermEndDate__c;
        //amendOptions.invoiceProcessingOptions = invPrc;

        //Term and condition
        amend1.contractEffectiveDate=newContractStartDate;
        amend1.name='Offre de retention : Renouvellement';
        amend1.status='Completed';
        amend1.subscriptionId=zuoraSubId;
        amend1.r_type='TermsAndConditions';
        amend1.description='offre de retention description'; 
        amend1.termType = 'TERMED';
        amend1.currentTerm = 12;
        amend1.currentTermPeriodType = 'Month';
        amend1.renewalSetting = 'RENEW_TO_EVERGREEN';                
        //amend1.currentTerm=newCurrentTerm;
        amend1.termStartDate=newContractStartDate; //TODO
        req1.amendments.add(amend1);
        
        // Add remise Retention
        if (hasRemiseRetention){
        //ajout amend remise
            amend2.contractEffectiveDate=dateDebutRemise;        
            amend2.name='Offre de retention : Remise';
            amend2.status='Completed';
            amend2.subscriptionId=zuoraSubId;
            amend2.r_type='NewProduct';
            amend2.description='offre de retention description';                                   
            zc_AmendmentRatePlanData ratePlanData = new zc_AmendmentRatePlanData();
            zc_RatePlan ratePlan = new zc_RatePlan();
            ratePlan.productRatePlanId=rpId;                
            ratePlanData.ratePlan = ratePlan;
            zc_RatePlanChargeDataInRatePlanData rpcChargeData = new zc_RatePlanChargeDataInRatePlanData();
            zc_RatePlanChargeInRatePlanChargeData rpcCharge = new zc_RatePlanChargeInRatePlanChargeData();
            rpcChargeData.ratePlanCharge = rpcCharge;        
            //rpcCharge.endDateCondition = 'FixedPeriod';
            //rpcCharge.discountAmount = 55;//TODO
            //rpcCharge.triggerEvent = 'SpecificDate';
            //rpcCharge.triggerDate = dateDebutRemise; //TODO        
            //rpcCharge.upToPeriods = 55; //TODO
            //rpcCharge.upToPeriodsType = 'Billing Periods';        
            rpcCharge.productRatePlanChargeId = rpcId;                
            ratePlanData.ratePlanChargeData.add(rpcChargeData);
            //ratePlanData.ratePlanChargeData.add(ratePlanChargeData);
            amend2.ratePlanData = ratePlanData; 
            req1.amendments.add(amend2);
        }           
        
        req1.previewOptions = previewOptions;
        req1.amendOptions = amendOptions;
        actionAmend.requests.add(req1);


        //Call WS
        String accessToken = WS001_CallZuora.access_token;
        String repWS = WS001_CallZuora.sendRequest2(accessToken, '/v1/action/amend', zEntityId, 'POST', actionAmend, zc_AmendRequest.class, zc_AmendResult.class, null);

        // Check resultat WS
        ZUC_Parser par = new ZUC_Parser(ZUC_Parser.MAP_NO_SWAP);
        repWS = par.serializeWithMapping2(repWS,'zc_ProxyActionAmendResponse'); //rename members
        zc_ProxyActionAmendResponse repObj = (zc_ProxyActionAmendResponse)JSON.deserialize(repWS, zc_ProxyActionAmendResponse.class);

        Boolean success = true;
        String messageError = '';
        if(repObj != null && repObj.results != null  && repObj.results.size() > 0){
            for(zc_AmendResult r : repObj.results){
                if(!r.success){
                    if(r.errors != null && r.errors.size() > 0){
                        throw new RTException(String.valueOf(new RTException(RTExceptionCode.ERREUR_RETENTION_APPLICATION)) + r.errors.get(0).message);
                    }
                }
            }
        }                
        
     }
     
    private class MyException extends Exception {
    }

}