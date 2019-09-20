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
        	executeGesteCommercialCDD(ddeId);
        }
    }
    
    
    public static void executeGesteCommercialCDD(Id ddeId) {
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