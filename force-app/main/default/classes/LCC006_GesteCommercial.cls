public without sharing class LCC006_GesteCommercial {
	
	public static Case dem;
    public static Zuora__Subscription__c sub;
    public static Account acc;
    
    public static void executeGesteCommercial(Id ddeId) {
    	system.debug('##MNE LCC006_GesteCommercial executeGesteCommercial ddeId >> '+ddeId);
    	dem = SM_Demande.getDemande(ddeId);

        if (dem.Subscription__c == null) {
            throw new MyException('Abonnement absent de la demande: pas dabo, plusieurs ou inactif');
        } 
        
        sub = SM_Subscription.getSubscription(dem.Subscription__c);

        acc = SM_Account.getAccount(dem.AccountId);

        verif();
        
        if (sub.TypeContrat__c == 'CDI') {
        	executeGesteCommercialCDI(ddeId);
        }
        else {
        	executeGesteCommercialCDD3(ddeId);
        }
    }
        
    public static void executeGesteCommercialCDD2(Id ddeId) {
        String zuoraSubId = sub.Zuora__External_Id__c;
		String zEntityId = WS001_CallZuora.getZuoraEntityId(acc.CodePays__c);
		String rpId;
		String rpcId;
        String entite = (acc.CodePays__c == '033') ? 'France' : 'Belgique';
        Integer currentTerm = Integer.valueOf(sub.Zuora__CurrentTerm__c.split(' ').get(0));
        Integer nbDeMoisRemise = Integer.valueOf(dem.NombreDeMoisRemise__c);
        String rpcReference = SM001_GesteCommercial.prodRatePlanChargeReferenceGesteCommercialCDD;
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
            system.debug(RTExceptionCode.ERREUR_GESTCO_CDD_PRODUIT_ABSENT);            
            throw new RTException(RTExceptionCode.ERREUR_GESTCO_CDD_PRODUIT_ABSENT);			
		}

		rpId = listProdRatePlanCharge.get(0).ProdRatePlan__r.zid__c;
		rpcId = listProdRatePlanCharge.get(0).zid__c;

        // instantiate AmendRequest Instance
        ZUC.ActionAmendRequest actionAmend = new ZUC.ActionAmendRequest();
        ZUC.AmendRequest req1 = new ZUC.AmendRequest();        
        ZUC.AmendRequestPreviewOptions previewOptions = new ZUC.AmendRequestPreviewOptions();
        ZUC.AmendRequestAmendOptions amendOptions = new ZUC.AmendRequestAmendOptions();
        ZUC.Amendment amend1 = new ZUC.Amendment(); //Term and condition
        ZUC.Amendment amend2 = new ZUC.Amendment(); //Add product
        previewOptions.enablePreviewMode=false;
        amendOptions.generateInvoice=true;
        // c1.amendOptions.processPayments=false;
        ZUC.InvoiceProcessingOptions invPrc = new ZUC.InvoiceProcessingOptions();
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
        ZUC.AmendmentRatePlanData ratePlanData = new ZUC.AmendmentRatePlanData();
        ZUC.RatePlan ratePlan = new ZUC.RatePlan();
        ratePlan.productRatePlanId=rpId;                
        ratePlanData.ratePlan = ratePlan;
        ZUC.RatePlanChargeDataInRatePlanData rpcChargeData = new ZUC.RatePlanChargeDataInRatePlanData();
        ZUC.RatePlanChargeInRatePlanChargeData rpcCharge = new ZUC.RatePlanChargeInRatePlanChargeData();
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
        String repWS = WS001_CallZuora.sendRequest2(accessToken, '/v1/action/amend', zEntityId, 'POST', actionAmend, ZUC.AmendRequest.class, ZUC.AmendResult.class, null);

        // Check resultat WS
        ZUC_Parser par = new ZUC_Parser(ZUC_Parser.MAP_NO_SWAP);
        repWS = par.serializeWithMapping2(repWS,'ZUC.ActionAmendResult'); //rename members
        ZUC.ActionAmendResult repObj = (ZUC.ActionAmendResult)JSON.deserialize(repWS, ZUC.ActionAmendResult.class);

        Boolean success = true;
        String messageError = '';
        if(repObj != null && repObj.results != null  && repObj.results.size() > 0){
            for(ZUC.AmendResult r : repObj.results){
                if(!r.success){
                    if(r.errors != null && r.errors.size() > 0){
                        throw new RTException(RTExceptionCode.ERREUR_GESTCO_APPLICATION_CDD + r.errors.get(0).message);
                    }
                }
            }
        }        
    }

public static void executeGesteCommercialCDD3(Id ddeId) {
        String zuoraSubId = sub.Zuora__External_Id__c;
		String zEntityId = WS001_CallZuora.getZuoraEntityId(acc.CodePays__c);
		String rpId;
		String rpcId;
        String entite = (acc.CodePays__c == '033') ? 'France' : 'Belgique';
        Integer currentTerm = Integer.valueOf(sub.Zuora__CurrentTerm__c.split(' ').get(0));
        Integer nbDeMoisRemise = Integer.valueOf(dem.NombreDeMoisRemise__c);
        String rpcReference = SM001_GesteCommercial.prodRatePlanChargeReferenceGesteCommercialCDD;
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
            system.debug(RTExceptionCode.ERREUR_GESTCO_CDD_PRODUIT_ABSENT);            
            throw new RTException(RTExceptionCode.ERREUR_GESTCO_CDD_PRODUIT_ABSENT);			
		}

		rpId = listProdRatePlanCharge.get(0).ProdRatePlan__r.zid__c;
		rpcId = listProdRatePlanCharge.get(0).zid__c;

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
                        throw new RTException(String.valueOf(new RTException(RTExceptionCode.ERREUR_GESTCO_APPLICATION_CDD)) + r.errors.get(0).message);
                    }
                }
            }
        }
    	
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

            //Call WS invoice update
            repWS = WS001_CallZuora.sendRequest2(accessToken, '/v1/action/update', zEntityId, 'POST', objUpdateReq, zc_ProxyActionupdateRequest.class, zc_ProxySaveResult.class, null);

            par = new ZUC_Parser(ZUC_Parser.MAP_NO_SWAP);
            repWS = '{"results":'+repWS+'}';
            repWS = par.serializeWithMapping2(repWS,'zc_ProxySaveResult'); //rename members
            zc_ProxySaveResult objUpdateRes = (zc_ProxySaveResult)JSON.deserialize(repWS, zc_ProxySaveResult.class);

            success = true;
            messageError = '';
            if(objUpdateRes != null && objUpdateRes.results.size() > 0){
                if(!objUpdateRes.results.get(0).success){                                    
                    throw new RTException(String.valueOf(new RTException(RTExceptionCode.ERREUR_GESTCO_APPLICATION_CDD))+ repWS);             
                }            
            }
    }

    public static void executeGesteCommercialCDD(Id ddeId) { //non utilise
        system.debug('##MNE LCC006_GesteCommercial executeGesteCommercialCDD BEGIN');
        String zuoraSubId = sub.Zuora__External_Id__c;
		String zEntityId = WS001_CallZuora.getZuoraEntityId(acc.CodePays__c);
		String ProductRatePlanId;
		String ProductRatePlanChargeId;
			
		String prefixe = '';
		if(acc.CodePays__c == '033'){
			prefixe = 'FR';
		}else if(acc.CodePays__c == '032'){
			prefixe = 'BE';
		}
		String productRatePlanReference = prefixe + SM001_GesteCommercial.prodRatePlanChargeReferenceGesteCommercialCDD;
		list<ProdRatePlanCharge__c> listProdRatePlanCharge = new list<ProdRatePlanCharge__c>([SELECT Reference__c, zid__c, ProdRatePlan__r.zid__c FROM ProdRatePlanCharge__c WHERE Reference__c = :productRatePlanReference]);
		if(listProdRatePlanCharge.size() == 0){
			system.debug('##MNE LCC006_GesteCommercial executeGesteCommercial Pas de Product Rate Plan Charge trouvée pour le geste commercial');
            throw new MyException('Pas de Product Rate Plan Charge trouvée pour le geste commercial.');
		}

        
        ProdRatePlanCharge__c prodRatePlanCharge = listProdRatePlanCharge.get(0);
		ProductRatePlanId = prodRatePlanCharge.ProdRatePlan__r.zid__c;
		ProductRatePlanChargeId = prodRatePlanCharge.zid__c;
		list<SM001_GesteCommercial.Amendment> listAmendment = new list<SM001_GesteCommercial.Amendment>();
        
        //Redmine MNE 18/09/2019 ticket n°699
        //Date dateDebutRemise = sub.Zuora__SubscriptionStartDate__c;
        Date dateDebutRemise = sub.Zuora__TermEndDate__c;
        system.debug('##MNE LCC006_GesteCommercial executeGesteCommercialCDD dateDebutRemise >> '+dateDebutRemise);
        
        //add product mois gratuit
        SM001_GesteCommercial.Amendment addPr = new SM001_GesteCommercial.Amendment(zuoraSubId, ProductRatePlanId, ProductRatePlanChargeId, dateDebutRemise);
        addPr.Name = 'Geste Commercial CDD mois offert';
        addPr.Description = 'Geste Commercial CDD mois offert';
        listAmendment.add(addPr);
        
        //Renew
        Integer nbDeMoisRemise = Integer.valueOf(dem.NombreDeMoisRemise__c);
        Date contractEffectiveDate = Date.today();
        Integer currentTerm = Integer.valueOf(sub.Zuora__CurrentTerm__c.split(' ').get(0));
        String currentTermPeriodType = sub.Zuora__CurrentTermPeriodType__c;
        Integer newCurrentTerm;
        
        if(CurrentTermPeriodType == 'Day'){
        	Date startDate  = Date.valueOf(sub.Zuora__TermStartDate__c);
			Date endDate    = startDate.addDays(currentTerm);
			Date newEndDate = endDate.addMonths(nbDeMoisRemise);
			newCurrentTerm = startDate.daysBetween(newEndDate);
        }
        else {
        	newCurrentTerm = currentTerm + nbDeMoisRemise;
        }
        SM001_GesteCommercial.Amendment renew = new SM001_GesteCommercial.Amendment(zuoraSubId, contractEffectiveDate, newCurrentTerm);
        listAmendment.add(0,renew);
        
        SM001_GesteCommercial.Body res = new SM001_GesteCommercial.Body();
    	res.requests.get(0).Amendments = listAmendment;
    	String inBody = JSON.serialize(res);
        inBody = inBody.replace('null','""');
        System.debug('##MNE LCC006_GesteCommercial executeGesteCommercialCDD inBody >> '+inBody);
        
        String repWS = SM001_GesteCommercial.sendAmendRequest(inBody, zEntityId);
        System.debug('##MNE LCC006_GesteCommercial executeGesteCommercialCDD repWS >> '+repWS);
        
        SM001_GesteCommercial.Resultat resApex =   (SM001_GesteCommercial.Resultat)System.JSON.deserialize(repWS, SM001_GesteCommercial.Resultat.class);
        System.debug('##MNE LCC006_GesteCommercial executeGesteCommercialCDD resApex >> '+resApex);
        
        Boolean success = true;
        String messageError = '';
        if(resApex != null && resApex.results != null  && resApex.results.size() > 0){
            for(SM001_GesteCommercial.Result r : resApex.results){
                if(!r.Success){
                    if(r.Errors != null && r.Errors.size() > 0){
                        throw new MyException(r.Errors.get(0).Message);
                    }
                }
            }
        }
        
        

        /*for(SM001_GesteCommercial.Amendment amend : listAmendment){
        	SM001_GesteCommercial.Body res = new SM001_GesteCommercial.Body();
        	res.requests.get(0).Amendments.add(amend);
        	String inBody = JSON.serialize(res);
	        inBody = inBody.replace('null','""');
	        System.debug('##MNE LCC006_GesteCommercial executeGesteCommercialCDD inBody >> '+inBody);
	        
	        String repWS = SM001_GesteCommercial.sendAmendRequest(inBody, zEntityId);
	        System.debug('##MNE LCC006_GesteCommercial executeGesteCommercialCDD repWS >> '+repWS);
	        
	        SM001_GesteCommercial.Resultat resApex =   (SM001_GesteCommercial.Resultat)System.JSON.deserialize(repWS, SM001_GesteCommercial.Resultat.class);
	        System.debug('##MNE LCC006_GesteCommercial executeGesteCommercialCDD resApex >> '+resApex);
	        
	        Boolean success = true;
	        String messageError = '';
	        if(resApex != null && resApex.results != null  && resApex.results.size() > 0){
	            for(SM001_GesteCommercial.Result r : resApex.results){
	                if(!r.Success){
	                    if(r.Errors != null && r.Errors.size() > 0){
	                        throw new MyException(r.Errors.get(0).Message);
	                    }
	                }
	            }
	        }
        }*/
    }
	
	
	public static void executeGesteCommercialCDI(Id ddeId) {
		system.debug('##MNE LCC006_GesteCommercial executeGesteCommercialCDI BEGIN');
        
        String zuoraSubId = sub.Zuora__External_Id__c;
		String zEntityId = WS001_CallZuora.getZuoraEntityId(acc.CodePays__c);
		String ProductRatePlanId;
		String ProductRatePlanChargeId;
			
		//MNE TODO => 
		//modifier le call zuora pour prendre en compte le pallier (c a d soit montant sur plusieur mois sois pallier sur moi apres la date de la demande)
		//dinamiser ZUora entity Id, aujourd'hui que sur France (en dure)
		String prefixe = '';
		if(acc.CodePays__c == '033'){
			prefixe = 'FR';
		}else if(acc.CodePays__c == '032'){
			prefixe = 'BE';
		}
		String productRatePlanReference = prefixe + SM001_GesteCommercial.prodRatePlanChargeReferenceGesteCommercialCDI;
		list<ProdRatePlanCharge__c> listProdRatePlanCharge = new list<ProdRatePlanCharge__c>([SELECT Reference__c, zid__c, ProdRatePlan__r.zid__c FROM ProdRatePlanCharge__c WHERE Reference__c = :productRatePlanReference]);
		if(listProdRatePlanCharge.size() == 0){
			system.debug('##MNE LCC006_GesteCommercial executeGesteCommercialCDI Pas de Product Rate Plan Charge trouvée pour le geste commercial');
            throw new MyException('Pas de Product Rate Plan Charge trouvée pour le geste commercial.');
		}
		
		ProdRatePlanCharge__c prodRatePlanCharge = listProdRatePlanCharge.get(0);
		ProductRatePlanId = prodRatePlanCharge.ProdRatePlan__r.zid__c;
		ProductRatePlanChargeId = prodRatePlanCharge.zid__c;
		
		String moisDebutRemise = dem.Mois_de_d_but_remise__c;
        Double montantRemise = dem.MontantRemise__c;
        Integer nbDeMoisRemise = Integer.valueOf(dem.NombreDeMoisRemise__c);
        String pallier = dem.Pallier__c;
		
		String inBody = SM001_GesteCommercial.getBodyGC (zuoraSubId, ProductRatePlanId, ProductRatePlanChargeId, montantRemise, nbDeMoisRemise, dem.DateDemande__c, moisDebutRemise);
		
        //String repWS = SM001_GesteCommercial.sendRequest(zuoraSubId, ProductRatePlanId, ProductRatePlanChargeId, montantRemise, nbDeMoisRemise, dateDemande, moisDebutRemise);
        String repWS = SM001_GesteCommercial.sendAmendRequest(inBody, zEntityId);
        
        
        SM001_GesteCommercial.Resultat resApex =   (SM001_GesteCommercial.Resultat)System.JSON.deserialize(repWS, SM001_GesteCommercial.Resultat.class);
        System.debug('##MNE LCC006_GesteCommercial executeGesteCommercialCDI resJsonOriginal >> '+repWS);
        System.debug('##MNE LCC006_GesteCommercial executeGesteCommercialCDI resApex >> '+resApex);
        
        Boolean success = true;
        String messageError = '';
        if(resApex != null && resApex.results != null  && resApex.results.size() > 0){
        	for(SM001_GesteCommercial.Result r : resApex.results){
        		if(!r.Success){
        			if(r.Errors != null && r.Errors.size() > 0){
        				throw new MyException(r.Errors.get(0).Message);
        			}
        		}
        	}
        }
	}
	
	private static void verif() {

        if (dem.Status == SM_Demande.getStatus('Fermee')) {
            throw new MyException('Cette demande a deja ete traite'); 
        }

        if (dem.SousMotif__c == null) {
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
			//dinamiser ZUora entity Id, aujourd'hui que sur France (en dure)
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
        
    }
    
    @AuraEnabled
    public static WRPInt ongletExecuteGesteCommercial(Case caseRecord, Id caseId) {
        System.debug('##MNE LCC006_GesteCommercial ongletExecuteGesteCommercial caseRecord >> '+caseRecord);
        System.debug('##MNE LCC006_GesteCommercial ongletExecuteGesteCommercial caseId >> '+caseId);
        
        Case c = [SELECT Id, AccountId, DateDemande__c FROM Case WHERE Id = :caseId LIMIT 1];
        Id accId = c.AccountId;
        
        String moisDebutRemise = caseRecord.Mois_de_d_but_remise__c;
        Double montantRemise = caseRecord.MontantRemise__c;
        Integer nbDeMoisRemise = Integer.valueOf(caseRecord.NombreDeMoisRemise__c);
        String pallier = caseRecord.Pallier__c; 
        String dateDemandeTMP = String.valueOf(c.DateDemande__c);
        
        WRPInt rep = executeGesteCommercial(caseId, accId, moisDebutRemise, montantRemise, nbDeMoisRemise, pallier, dateDemandeTMP);
        if(!rep.showMessage){
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
            insert cTMP;     
            rep.caseIdToRedirect = cTMP.Id;
            rep.accountIdToRedirect = accId;
        }
        return rep;
    }
    
    public without sharing class WRPInt {
        @AuraEnabled public Boolean showMessage                         { get; set; }
        @AuraEnabled public String  messageToDisplay                    { get; set; }
        @AuraEnabled public Id  caseIdToRedirect                    	{ get; set; }
        @AuraEnabled public Id  accountIdToRedirect                    	{ get; set; }
        
        public WRPInt() {
            this.showMessage            = false;
            this.messageToDisplay       = '';
            this.caseIdToRedirect       = null;
            this.accountIdToRedirect    = null;
        }
    }
    
    private class MyException extends Exception {
    }

}