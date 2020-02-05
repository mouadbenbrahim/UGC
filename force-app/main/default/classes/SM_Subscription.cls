public without sharing class SM_Subscription {
	
    public static Zuora__Subscription__c getSubscription(Id subId) {
    	system.debug('##MNE SM_Subscription getSubscription subId >> '+subId);
        Zuora__Subscription__c subscription = [
                SELECT  Id,Name,TypeContrat__c,CodeFinContrat__c,Tech_AvecRembouesement__c,DateFinContrat__c,Marche__c,Tech_DetteFraisGestion__c,
						Tech_DetteNonEchue__c,Tech_DetteTargetDate__c,Zuora__SubscriptionNumber__c,Zuora__Status__c,Zuora__CancelledDate__c,
						Zuora__TermEndDate__c,Zuora__SubscriptionEndDate__c,Zuora__TermStartDate__c,Zuora__SubscriptionStartDate__c,Zuora__ContractEffectiveDate__c,
						Zuora__NextChargeDate__c,Zuora__NextRenewalDate__c,Zuora__PreviousSubscriptionId__c,Zuora__External_Id__c,Zuora__CurrentTermPeriodType__c,
						Zuora__CurrentTerm__c,Zuora__TermSettingType__c,Zuora__Zuora_Id__c,Zuora__Account__r.Id,Zuora__Account__r.CodePays__c,Zuora__Account__r.PersonContactId,
						Zuora__CustomerAccount__r.Zuora__Balance__c,Zuora__CustomerAccount__r.Zuora__Zuora_Id__c, Zuora__CustomerAccount__r.Zuora__External_Id__c
                FROM Zuora__Subscription__c
                WHERE Id = :subId
        ];
       return subscription;
    }


    public static Zuora__Subscription__c getSubscriptionByZID(String subZId) {
        //TODO: dans le cas ou la demande doit traiter une souscription non active ou ex. client qui a plusieurs subscriptions (doublons à traiter)
        //il faut songer à lier la demande à la souscription automatiquement à la création (si une seul active) et prevoir un lookup pour
        // laisser le CC selection une souscription si l'action doit se faire sur une souscription autre que celle renvoyé par getActiveSub..
        System.debug('##MBEN:setSub');
        List<Zuora__Subscription__c> subscriptions = [
                SELECT  Id,Name,TypeContrat__c,CodeFinContrat__c,Tech_AvecRembouesement__c,DateFinContrat__c,Marche__c,Tech_DetteFraisGestion__c,
						Tech_DetteNonEchue__c,Tech_DetteTargetDate__c,Zuora__SubscriptionNumber__c,Zuora__Status__c,Zuora__CancelledDate__c,
						Zuora__TermEndDate__c,Zuora__SubscriptionEndDate__c,Zuora__TermStartDate__c,Zuora__SubscriptionStartDate__c,Zuora__ContractEffectiveDate__c,
						Zuora__NextChargeDate__c,Zuora__NextRenewalDate__c,Zuora__PreviousSubscriptionId__c,Zuora__External_Id__c,Zuora__CurrentTermPeriodType__c,
						Zuora__CurrentTerm__c,Zuora__TermSettingType__c,Zuora__Zuora_Id__c,Zuora__Account__r.Id,Zuora__Account__r.CodePays__c,Zuora__Account__r.PersonContactId,
						Zuora__CustomerAccount__r.Zuora__Balance__c,Zuora__CustomerAccount__r.Zuora__Zuora_Id__c, Zuora__CustomerAccount__r.Zuora__External_Id__c
                FROM Zuora__Subscription__c
                WHERE Zuora__External_Id__c = :subZId
        ];
        if (subscriptions.size() == 0){
            return null;
        }else if (subscriptions.size() == 1){
            return subscriptions.get(0);
        }else {
            return null;
        }
    }
    
    
    public static WRPRep getActiveSubscriptionId(Id accId) {
    	system.debug('##MNE SM_Subscription getActiveSubscriptionId accId >> '+accId);
        Date d1 = Date.today();
        List<Zuora__Subscription__c> subscriptions = [
                SELECT  Id,Name,TypeContrat__c,CodeFinContrat__c,Tech_AvecRembouesement__c,DateFinContrat__c,Marche__c,Tech_DetteFraisGestion__c,
						Tech_DetteNonEchue__c,Tech_DetteTargetDate__c,Zuora__SubscriptionNumber__c,Zuora__Status__c,Zuora__CancelledDate__c,
						Zuora__TermEndDate__c,Zuora__SubscriptionEndDate__c,Zuora__TermStartDate__c,Zuora__SubscriptionStartDate__c,Zuora__ContractEffectiveDate__c,
						Zuora__NextChargeDate__c,Zuora__NextRenewalDate__c,Zuora__PreviousSubscriptionId__c,Zuora__External_Id__c,Zuora__CurrentTermPeriodType__c,
						Zuora__CurrentTerm__c,Zuora__TermSettingType__c,Zuora__Zuora_Id__c,Zuora__Account__r.Id,Zuora__Account__r.CodePays__c,Zuora__Account__r.PersonContactId,
						Zuora__CustomerAccount__r.Zuora__Balance__c,Zuora__CustomerAccount__r.Zuora__Zuora_Id__c, Zuora__CustomerAccount__r.Zuora__External_Id__c
                FROM Zuora__Subscription__c
                WHERE Zuora__Account__r.Id = :accId
                AND ( Zuora__SubscriptionEndDate__c > :d1 OR Zuora__SubscriptionEndDate__c = NULL )
                ORDER BY CreatedDate DESC
        ];
        
		system.debug('##MNE SM_Subscription getActiveSubscriptionId subscriptions >> '+subscriptions);
        if (subscriptions.isEmpty()) {
            return null;
        } else {
            return new WRPRep(subscriptions[0].Id, subscriptions[0].Zuora__External_Id__c, subscriptions[0].Name);
        }
    }
    
    //Non utilisé
    public static list<Zuora__Subscription__c> getActiveSubscriptionBySetAccId(set<Id> setAccId) {
    	system.debug('##MNE SM_Subscription getActiveSubscriptionBySetAccId setAccId >> '+setAccId);
        Date d1 = Date.today();
        list<Zuora__Subscription__c> listSub = new list<Zuora__Subscription__c>([
                SELECT  Id,Name,TypeContrat__c,CodeFinContrat__c,Tech_AvecRembouesement__c,DateFinContrat__c,Marche__c,Tech_DetteFraisGestion__c,
						Tech_DetteNonEchue__c,Tech_DetteTargetDate__c,Zuora__SubscriptionNumber__c,Zuora__Status__c,Zuora__CancelledDate__c,
						Zuora__TermEndDate__c,Zuora__SubscriptionEndDate__c,Zuora__TermStartDate__c,Zuora__SubscriptionStartDate__c,Zuora__ContractEffectiveDate__c,
						Zuora__NextChargeDate__c,Zuora__NextRenewalDate__c,Zuora__PreviousSubscriptionId__c,Zuora__External_Id__c,Zuora__CurrentTermPeriodType__c,
						Zuora__CurrentTerm__c,Zuora__TermSettingType__c,Zuora__Zuora_Id__c,Zuora__Account__r.Id,Zuora__Account__r.CodePays__c,Zuora__Account__r.PersonContactId,
						Zuora__CustomerAccount__r.Zuora__Balance__c,Zuora__CustomerAccount__r.Zuora__Zuora_Id__c, Zuora__CustomerAccount__r.Zuora__External_Id__c
                FROM Zuora__Subscription__c
                WHERE Zuora__Account__r.Id IN :setAccId
                AND ( Zuora__SubscriptionEndDate__c > :d1 OR Zuora__SubscriptionEndDate__c = NULL )
                ORDER BY CreatedDate DESC
        ]);
		system.debug('##MNE SM_Subscription getActiveSubscriptionBySetAccId listSub >> '+listSub);
        return listSub;
    }
    
    //Non utilisé
    public static list<Zuora__Subscription__c> getSubscriptionBySetName(set<String> setName) {
    	system.debug('##MNE SM_Subscription getSubscriptionBySetName setName >> '+setName);
        list<Zuora__Subscription__c> listSub = new list<Zuora__Subscription__c>([
                SELECT  Id,Name,TypeContrat__c,CodeFinContrat__c,Tech_AvecRembouesement__c,DateFinContrat__c,Marche__c,Tech_DetteFraisGestion__c,
						Tech_DetteNonEchue__c,Tech_DetteTargetDate__c,Zuora__SubscriptionNumber__c,Zuora__Status__c,Zuora__CancelledDate__c,
						Zuora__TermEndDate__c,Zuora__SubscriptionEndDate__c,Zuora__TermStartDate__c,Zuora__SubscriptionStartDate__c,Zuora__ContractEffectiveDate__c,
						Zuora__NextChargeDate__c,Zuora__NextRenewalDate__c,Zuora__PreviousSubscriptionId__c,Zuora__External_Id__c,Zuora__CurrentTermPeriodType__c,
						Zuora__CurrentTerm__c,Zuora__TermSettingType__c,Zuora__Zuora_Id__c,Zuora__Account__r.Id,Zuora__Account__r.CodePays__c,Zuora__Account__r.PersonContactId,
						Zuora__CustomerAccount__r.Zuora__Balance__c,Zuora__CustomerAccount__r.Zuora__Zuora_Id__c, Zuora__CustomerAccount__r.Zuora__External_Id__c,
                        Zuora__RenewalTerm__c,Zuora__RenewalTermPeriodType__c
                FROM Zuora__Subscription__c
                WHERE Zuora__SubscriptionNumber__c IN :setName
                ORDER BY CreatedDate DESC
        ]);
		system.debug('##MNE SM_Subscription getSubscriptionBySetName listSub >> '+listSub);
        return listSub;
    }
    
    /* ECG 04/02/2020 Old version
    public static list<Zuora__Subscription__c> getActiveSubscriptionBySetNameORSetAccId(set<String> setName, set<Id> setAccId) {
    	system.debug('##MNE SM_Subscription getActiveSubscriptionBySetAccIdAndSetName setName >> '+setName);
    	system.debug('##MNE SM_Subscription getActiveSubscriptionBySetAccIdAndSetName setAccId >> '+setAccId);
        Date d1 = Date.today();
        list<Zuora__Subscription__c> listSub = new list<Zuora__Subscription__c>([
                SELECT  Id,Name,TypeContrat__c,CodeFinContrat__c,Tech_AvecRembouesement__c,DateFinContrat__c,Marche__c,Tech_DetteFraisGestion__c,
						Tech_DetteNonEchue__c,Tech_DetteTargetDate__c,Zuora__SubscriptionNumber__c,Zuora__Status__c,Zuora__CancelledDate__c,
						Zuora__TermEndDate__c,Zuora__SubscriptionEndDate__c,Zuora__TermStartDate__c,Zuora__SubscriptionStartDate__c,Zuora__ContractEffectiveDate__c,
						Zuora__NextChargeDate__c,Zuora__NextRenewalDate__c,Zuora__PreviousSubscriptionId__c,Zuora__External_Id__c,Zuora__CurrentTermPeriodType__c,
						Zuora__CurrentTerm__c,Zuora__TermSettingType__c,Zuora__Zuora_Id__c,Zuora__Account__r.Id,Zuora__Account__r.CodePays__c,Zuora__Account__r.PersonContactId,
						Zuora__CustomerAccount__r.Zuora__Balance__c,Zuora__CustomerAccount__r.Zuora__Zuora_Id__c, Zuora__CustomerAccount__r.Zuora__External_Id__c
                FROM Zuora__Subscription__c
                WHERE Zuora__SubscriptionNumber__c IN :setName
				OR (Zuora__Account__r.Id IN :setAccId AND (Zuora__SubscriptionEndDate__c > :d1 OR Zuora__SubscriptionEndDate__c = NULL))
                ORDER BY CreatedDate DESC
        ]);
		system.debug('##MNE SM_Subscription getActiveSubscriptionBySetAccIdAndSetName listSub >> '+listSub);
        return listSub;
    }*/

    /* ECG 04/02/2020 New version with all subscriptions */
    public static list<Zuora__Subscription__c> getActiveSubscriptionBySetNameORSetAccId(set<String> setName, set<Id> setAccId) {
    	system.debug('##MNE SM_Subscription getActiveSubscriptionBySetAccIdAndSetName setName >> '+setName);
    	system.debug('##MNE SM_Subscription getActiveSubscriptionBySetAccIdAndSetName setAccId >> '+setAccId);
        Date d1 = Date.today();
        list<Zuora__Subscription__c> listSub = new list<Zuora__Subscription__c>([
                SELECT  Id,Name,TypeContrat__c,CodeFinContrat__c,Tech_AvecRembouesement__c,DateFinContrat__c,Marche__c,Tech_DetteFraisGestion__c,
						Tech_DetteNonEchue__c,Tech_DetteTargetDate__c,Zuora__SubscriptionNumber__c,Zuora__Status__c,Zuora__CancelledDate__c,
						Zuora__TermEndDate__c,Zuora__SubscriptionEndDate__c,Zuora__TermStartDate__c,Zuora__SubscriptionStartDate__c,Zuora__ContractEffectiveDate__c,
						Zuora__NextChargeDate__c,Zuora__NextRenewalDate__c,Zuora__PreviousSubscriptionId__c,Zuora__External_Id__c,Zuora__CurrentTermPeriodType__c,
						Zuora__CurrentTerm__c,Zuora__TermSettingType__c,Zuora__Zuora_Id__c,Zuora__Account__r.Id,Zuora__Account__r.CodePays__c,Zuora__Account__r.PersonContactId,
						Zuora__CustomerAccount__r.Zuora__Balance__c,Zuora__CustomerAccount__r.Zuora__Zuora_Id__c, Zuora__CustomerAccount__r.Zuora__External_Id__c
                FROM Zuora__Subscription__c
                WHERE Zuora__SubscriptionNumber__c IN :setName
				OR (Zuora__Account__r.Id IN :setAccId )
                ORDER BY CreatedDate DESC 
        ]);
		system.debug('##MNE SM_Subscription getActiveSubscriptionBySetAccIdAndSetName listSub >> '+listSub);
        return listSub;
    }
    
    
    public static Zuora__Subscription__c getActiveSubscriptionByNameORAccId(String subName, Id accId) {
    	system.debug('##MNE SM_Subscription getActiveSubscriptionByNameORAccId subName >> '+subName);
    	system.debug('##MNE SM_Subscription getActiveSubscriptionByNameORAccId accId >> '+accId);
		list<Zuora__Subscription__c> listSub = null;
		if(String.isNotEmpty(subName)){
			listSub = SM_Subscription.getSubscriptionBySetName(new set<String>{subName});
		} else if(accId != null){
			listSub = SM_Subscription.getActiveSubscriptionBySetAccId(new set<Id>{accId});
		} else {
			return null;
		}
		
		if(listSub.size() != 1){
			return null;
		}
		system.debug('##MNE SM_Subscription getActiveSubscriptionByNameORAccId listSub.get(0) >> '+listSub.get(0));
		return listSub.get(0);
	}
    

    // method updateWS
    // public static WSZ.SubOut updateSub(String subId, Object sub, String zEntityId) {
    //     System.debug('##MBEN: updateWS');
    //     String endpoint = '/v1/object/subscription/' + subId;
    //     String method = 'PUT';
    //     String wsIn = '';
    //     String wsOut = '';
    //     String accessToken = WS001_CallZuora.access_token;
    //     wsIn = Util.serializeSobject(sub);
    //     System.debug('##MBEN7: |' + wsIn + '|');
    //     wsOut = WS001_CallZuora.sendRequest(accessToken, endpoint, zEntityId, method, wsIn,'type1', null);
    //     return (WSZ.SubOut) JSON.deserializeStrict(wsOut, WSZ.SubOut.class);
    // }
   
    
    // method deleteWS: Annuler un desabonnement
    // public static WSZ.SubOut deleteSub(String subId, String zEntityId) {
    //     String endpoint = '/v1/object/subscription/' + subId;
    //     String method = 'DELETE';
    //     String wsIn = null;
    //     String wsOut = '';
    //     String accessToken = WS001_CallZuora.access_token;

    //     wsOut = WS001_CallZuora.sendRequest(accessToken, endpoint, zEntityId, method, wsIn, 'type1', null);
    //     return (WSZ.SubOut) JSON.deserializeStrict(wsOut, WSZ.SubOut.class);
    // }
    
    
    public without sharing class WRPRep {
        public Id subscriptionId            { get; set; }
        public String zuoraSubscriptionId   { get; set; }
        public String subscriptionName   { get; set; }
        
        public WRPRep(Id subscriptionId, String zuoraSubscriptionId, String subscriptionName) {
            this.subscriptionId         = subscriptionId;
            this.zuoraSubscriptionId    = zuoraSubscriptionId;
            this.subscriptionName    	= subscriptionName;
        }
    }
    
    public static list<WSZ.DeleteOut> deleteZObject(list<String> listZObjectId, String zObjectName, String zEntityId) {
        String endpoint = '/v1/action/delete';
        String method = 'POST';
        String wsIn = '';
        String wsOut = '';
        String accessToken = WS001_CallZuora.access_token;
        
        WSZ.DeleteIn wsInObj = new WSZ.DeleteIn(listZObjectId, zObjectName);
		wsIn = (String) JSON.serialize(wsInObj);
		wsIn = wsIn.replace('typeX','type');
		
		system.debug('##MNE SM_Subscription deleteZObject wsIn >> '+wsIn);
		
        wsOut = WS001_CallZuora.sendRequest(accessToken, endpoint, zEntityId, method, wsIn, 'type1', null);
        
        system.debug('##MNE SM_Subscription deleteZObject wsOut >> '+wsOut);
        
        return (list<WSZ.DeleteOut>) JSON.deserializeStrict(wsOut, list<WSZ.DeleteOut>.class);   
    }


    // method updateWS zuora using Action/update input: list of sub ids and fields to update.
    // update key: Zuora__Zuora_Id__c
    public static List<WSZ.SubOut> updateSub2(List<Zuora__Subscription__c> subs, String zEntityId) {
        System.debug('##MBEN: updateWS');
        String endpoint = '/v1/action/update';
        String method = 'POST';
        String wsIn = '';
        String wsOut = '';
        WSZ.WRPOauthLogin tokObj = WS001_CallZuora.access_token2;

        WSZ.SubUpdateIn subUpdateIn = new WSZ.SubUpdateIn(subs);
        wsIn = (String) JSON.serialize(subUpdateIn);
        wsIn = wsIn.replace('Zuora__Zuora_Id__c','Id');
        System.debug('##MBEN7: |' + wsIn + '|');
        wsOut = WS001_CallZuora.sendRequest(tokObj.access_token, endpoint, zEntityId, method, wsIn,'type1',null);
        WS001_CallZuora.update_token2(tokObj);
        return (List<WSZ.SubOut>) JSON.deserializeStrict(wsOut, List<WSZ.SubOut>.class);
    }
    
    
    //##MNE 18/09/2019
    public static void SubscriptionBeforeInsert (List<Zuora__Subscription__c> listSubscriptions)  {   
    	system.debug('##MNE SM_Subscription SubscriptionBeforeInsert listSubscriptions >> '+listSubscriptions);
    	if(listSubscriptions != null && listSubscriptions.size() > 0){
    		checkPayeurSubscription(null, listSubscriptions);
            updateCancelCaseId(null, listSubscriptions);
            updateOffreLookup(null, listSubscriptions);
    	}
    }
    
    //##MNE 18/09/2019
    public static void SubscriptionBeforeUpdate (map<Id, Zuora__Subscription__c> mapOldSubscriptions, List<Zuora__Subscription__c> listSubscriptions)  { 
    	system.debug('##MNE SM_Subscription SubscriptionBeforeUpdate mapOldSubscriptions >> '+mapOldSubscriptions); 
    	system.debug('##MNE SM_Subscription SubscriptionBeforeUpdate listSubscriptions >> '+listSubscriptions);
    	if(listSubscriptions != null && listSubscriptions.size() > 0){
    		checkPayeurSubscription(mapOldSubscriptions, listSubscriptions);
            updateCancelCaseId(mapOldSubscriptions, listSubscriptions);
            //updateOffreLookup(mapOldSubscriptions, listSubscriptions);
    	} 
    }
    
    //##MNE 18/09/2019
    public static void checkPayeurSubscription (map<Id, Zuora__Subscription__c> mapOldSubscriptions, List<Zuora__Subscription__c> listSubscriptions)  {
    	system.debug('##MNE SM_Subscription checkPayeurSubscription mapOldSubscriptions >> '+mapOldSubscriptions); 
    	system.debug('##MNE SM_Subscription checkPayeurSubscription listSubscriptions >> '+listSubscriptions);

    	if(listSubscriptions == null || listSubscriptions.size() == 0){
    		return;
    	} 
    	map<Id, Account> mapAccountToUpdateById = new map<Id, Account>();
    	set<Id> setAccountId = new set<Id>();
    	for(Zuora__Subscription__c sub : listSubscriptions){
    		Account acc = null;
    		if(sub.Zuora__Account__c != null){
    			setAccountId.add(sub.Zuora__Account__c);
    			acc = new Account(Id = sub.Zuora__Account__c);
    		}
    		
    		Zuora__Subscription__c oldSub = null;
    		if(mapOldSubscriptions != null && mapOldSubscriptions.containsKey(sub.Id)){
    			oldSub = mapOldSubscriptions.get(sub.Id);
    		}
    		
    		if(oldSub == null && sub.PayeurCRMID__c != sub.Zuora__Account__c){
				sub.Payeur__c = sub.PayeurCRMID__c;
				if(acc != null){
					acc.Payeur__c = sub.PayeurCRMID__c;
					mapAccountToUpdateById.put(acc.Id, acc);
				}
			}
			else if(oldSub != null ){
				if(oldSub.PayeurCRMID__c != sub.PayeurCRMID__c) {
					if(sub.PayeurCRMID__c == sub.Zuora__Account__c){
						if(acc != null){
							acc.Payeur__c = null;
							mapAccountToUpdateById.put(acc.Id, acc);
						}
					}
					else if(sub.PayeurCRMID__c != sub.Zuora__Account__c ) {
						sub.Payeur__c = sub.PayeurCRMID__c;
						if(acc != null){
							acc.Payeur__c = sub.PayeurCRMID__c;
							mapAccountToUpdateById.put(acc.Id, acc);
						}
					}
				}
			}
    	}
    	
    	if(setAccountId.size() > 0){
    		list<Account> accountToUpdate = new list<Account>();
	    	map<Id, Account> mapAccountById = new map<Id, Account>([SELECT Id FROM Account WHERE Id  IN :setAccountId]);
	    	set<Id> setAccountIdFromMap = mapAccountById.keySet();
	    	
	    	if(setAccountIdFromMap != null && setAccountIdFromMap.size() > 0){
		    	for(Id accId : setAccountIdFromMap){
		    		if(mapAccountToUpdateById.containsKey(accId)){
		    			accountToUpdate.add(mapAccountToUpdateById.get(accId));
		    		}
		    	}
		    	system.debug('##MNE SM_Subscription checkPayeurSubscription accountToUpdate >> '+accountToUpdate);
		    	if(accountToUpdate.size() > 0){
		    		update accountToUpdate;
		    	} 
    		}
    	}
    }

    /**
     * updateCancelCaseId ; met a jour dans sub.cancelCase__c depuis sub.cancelCaseId__c (contient CaseExtId du case)
     * @param  mapOldSubscriptions mapOldSubscriptions description
     * @param  listSubscriptions   listSubscriptions description
     */
    public static void updateCancelCaseId (map<Id, Zuora__Subscription__c> mapOldSubscriptions, List<Zuora__Subscription__c> listSubscriptions)  {
    	
        if(listSubscriptions == null || listSubscriptions.size() == 0){
    		return;
    	} 

        //Map<Id,Zuora__Subscription__c> subToUpdate = new Map<Id,Zuora__Subscription__c>();
        Map<Id,String> subToUpdate = new Map<Id,String>(); //subId, CaseExtId__c

        for(Zuora__Subscription__c sub : listSubscriptions){
            if (mapOldSubscriptions != null && mapOldSubscriptions.get(sub.Id).CancelCaseID__c != sub.CancelCaseID__c){
                //sub.CancelCase__r = new Case(CaseExtId__c=sub.CancelCaseID__c); // KO on constitue une map separe pour un SQOL sur le set.
                subToUpdate.put(sub.Id, sub.CancelCaseID__c); 
            }else if (mapOldSubscriptions == null && sub.CancelCaseID__c != null){
                subToUpdate.put(sub.Id, sub.CancelCaseID__c);
            }
        }

        if (subToUpdate != null && subToUpdate.size() > 0){
            Set<String> sofCaseExtId = Util.mapValToSet(subToUpdate);
            Map<String,Id> cases = new Map<String,Id>();
            for(Case c : [Select Id, CaseExtId__c from Case where CaseExtId__c in :sofCaseExtId]){
                cases.put(c.CaseExtId__c, c.Id);
            }

            for(Zuora__Subscription__c sub : listSubscriptions){
                if (subToUpdate.containsKey(sub.Id)){
                    String caseExtId = subToUpdate.get(sub.Id);
                    if (cases.containsKey(caseExtId)){ // au cas ou on recupere un extid depuis sub et qui n existe pas dans case
                        sub.CancelCase__c = cases.get(caseExtId);
                    }
                }
            }
        }

    }

    public static void updateOffreLookup (map<Id, Zuora__Subscription__c> mapOldSubscriptions, List<Zuora__Subscription__c> listSubscriptions)  {
    	
        if(listSubscriptions == null || listSubscriptions.size() == 0){
    		return;
    	} 

        Map<Id,Zuora__Subscription__c> subToUpdate = new Map<Id,Zuora__Subscription__c>(); //subId, CaseExtId__c
        Set<String> offreRefs = new Set<String>(); //subId, CaseExtId__c

        for(Zuora__Subscription__c sub : listSubscriptions){
            if ((mapOldSubscriptions != null && mapOldSubscriptions.get(sub.Id).CodeOffreCo__c != sub.CodeOffreCo__c) || (mapOldSubscriptions == null && sub.CodeOffreCo__c != null)) { 
                System.debug('MBEN:sub.CodeOffreCo__c:'+sub.CodeOffreCo__c);
                List<String> codeOffreCo = sub.CodeOffreCo__c.split('-');
                if (codeOffreCo.get(0) != null) {
                    subToUpdate.put(sub.Id,sub);
                    offreRefs.add(codeOffreCo.get(0));
                }
                if (codeOffreCo.size() > 1 && codeOffreCo.get(1) != null) {
                    //subToUpdate.put(sub.Id,sub);
                    offreRefs.add(codeOffreCo.get(1));
                }                
            }
        }
        System.debug('MBEN:offreRefs:'+offreRefs);
        System.debug('MBEN:subToUpdate:'+subToUpdate);
        

        Map<String,Offre__c> offs = new Map<String,Offre__c>(); // = new Map<Id,Offre__c>([Select Reference__c from Offre__c where Reference__c in :offreRefs]);
        if (offreRefs.size() > 0) {
            for(Offre__c ref: [Select Id,Reference__c from Offre__c where Reference__c in :offreRefs]){
                offs.put(ref.Reference__c, ref); //ca suppose que Reference__c est unique
            }
            System.debug('MBEN:offs'+offs);
        }

        for(Id key : subToUpdate.keySet()){
                List<String> codeOffreCo = subToUpdate.get(key).CodeOffreCo__c.split('-');
                if (codeOffreCo.get(0) != null && offs.containsKey(codeOffreCo.get(0))) {
                    System.debug('MBEN:codeOffreCo.get(0)'+codeOffreCo.get(0));
                    // subToUpdate.get(key).Offre1__r = new Offre__c(Reference__c=codeOffreCo.get(0)); // KO ne fonctionne pas
                    subToUpdate.get(key).Offre1__c=offs.get(codeOffreCo.get(0)).Id;
                }
                if (codeOffreCo.size() > 1 && codeOffreCo.get(1) != null && offs.containsKey(codeOffreCo.get(1))) {
                    // subToUpdate.get(key).Offre2__r = new Offre__c(Reference__c=codeOffreCo.get(1)); // KO ne fonctionne pas
                    subToUpdate.get(key).Offre2__c=offs.get(codeOffreCo.get(1)).Id;
                }                
        }
    }
    
    public static WSZ.ContratFileOut getContratFile(WSZ.ContratFileIn wsIn){

        WSZ.ContratFileOut contratFileOut = new WSZ.ContratFileOut();
        String wsInStr = JSON.serialize(wsIn);
        ProcessLog__c pLog = new ProcessLog__c(Process__c = 'contratfile', Account__c = wsIn.accountSFID, SubscriptionName__c = wsIn.subscriptionName, Message__c = wsInStr);

        contratFileOut.subscriptionName = wsIn.subscriptionName;
        if (wsIn.subscriptionNameAvenir != null) contratFileOut.subscriptionNameAvenir = wsIn.subscriptionNameAvenir;
        contratFileOut.accountSFID = wsIn.accountSFID;
        //contratFileOut.accountZID = wsIn.accountZID;

        // contrat file actuel
        List<Case> cases= [Select Id, Attachment_Id_Contrat__c from Case where AccountId = :wsIn.accountSFID AND SubscriptionZName__c = :wsIn.subscriptionName 
        AND Attachment_Id_Contrat__c != null order by CreatedDate DESC limit 1];

        if (cases.size() == 0){
            throw new RTException(RTExceptionCode.ERREUR_CONTRATFILE_CASE_NONTROUVE,pLog); 
        }

        List<Attachment> atts = [Select Id, Body from Attachment where Id = :cases.get(0).Attachment_Id_Contrat__c];
        if (atts.size() == 0){
            throw new RTException(RTExceptionCode.ERREUR_CONTRATFILE_ATTACHMENT_NONTROUVE,pLog); 
        }        

        String contratBody = EncodingUtil.base64Encode(atts.get(0).Body);
        contratFileOut.contratFile = contratBody;

        // contrat file a venir
        if (wsIn.subscriptionNameAvenir != null){
            List<Case> cases2 = [Select Id, Attachment_Id_Contrat__c from Case where AccountId = :wsIn.accountSFID AND SubscriptionZName__c = :wsIn.subscriptionNameAvenir 
            AND Attachment_Id_Contrat__c != null order by CreatedDate DESC limit 1];

            if (cases2.size() > 0){
                List<Attachment> att2s = [Select Id, Body from Attachment where Id = :cases.get(0).Attachment_Id_Contrat__c];
                if (att2s.size() == 0){
                    throw new RTException(RTExceptionCode.ERREUR_DESABO_DATE_FINCONTRAT_OBLIGATOIRE,pLog); 
                }else {   
                    String contratBody2 = EncodingUtil.base64Encode(att2s.get(0).Body);
                    contratFileOut.contratFileAvenir = contratBody2; 
                } 
            }

        }
        return contratFileOut;
    }
}
	/*//Non utilisé
    public static Zuora__Subscription__c getSubscriptionByName(String name) {
        //TODO: dans le cas ou la demande doit traiter une souscription non active ou ex. client qui a plusieurs subscriptions (doublons à traiter)
        //il faut songer à lier la demande à la souscription automatiquement à la création (si une seul active) et prevoir un lookup pour
        // laisser le CC selection une souscription si l'action doit se faire sur une souscription autre que celle renvoyé par getActiveSub..
        System.debug('##MBEN:setSub');
        Zuora__Subscription__c subscription = [
                SELECT  Id,Name,TypeContrat__c,CodeFinContrat__c,Tech_AvecRembouesement__c,DateFinContrat__c,Marche__c,Tech_DetteFraisGestion__c,
						Tech_DetteNonEchue__c,Tech_DetteTargetDate__c,Zuora__SubscriptionNumber__c,Zuora__Status__c,Zuora__CancelledDate__c,
						Zuora__TermEndDate__c,Zuora__SubscriptionEndDate__c,Zuora__TermStartDate__c,Zuora__SubscriptionStartDate__c,Zuora__ContractEffectiveDate__c,
						Zuora__NextChargeDate__c,Zuora__NextRenewalDate__c,Zuora__PreviousSubscriptionId__c,Zuora__External_Id__c,Zuora__CurrentTermPeriodType__c,
						Zuora__CurrentTerm__c,Zuora__TermSettingType__c,Zuora__Zuora_Id__c,Zuora__Account__r.Id,Zuora__Account__r.CodePays__c,Zuora__Account__r.PersonContactId,
						Zuora__CustomerAccount__r.Zuora__Balance__c,Zuora__CustomerAccount__r.Zuora__Zuora_Id__c
                FROM Zuora__Subscription__c
                WHERE Zuora__SubscriptionNumber__c = :name
        ];
        return subscription;
    }*/
    
    /*//non utiliser
    public static list<Zuora__Subscription__c> getActiveSubscriptionBySetNameORSetZSubIdORSetAccId(set<String> setName, set<String> setZSubId, set<Id> setAccId) {
    	system.debug('##MNE SM_Subscription getActiveSubscriptionBySetNameORSetZSubIdORSetAccId setName >> '+setName);
    	system.debug('##MNE SM_Subscription getActiveSubscriptionBySetNameORSetZSubIdORSetAccId setZSubId >> '+setZSubId);
    	system.debug('##MNE SM_Subscription getActiveSubscriptionBySetNameORSetZSubIdORSetAccId setAccId >> '+setAccId);
        Date d1 = Date.today();
        list<Zuora__Subscription__c> listSub = new list<Zuora__Subscription__c>([
                SELECT  Id,Name,TypeContrat__c,CodeFinContrat__c,Tech_AvecRembouesement__c,DateFinContrat__c,Marche__c,Tech_DetteFraisGestion__c,
						Tech_DetteNonEchue__c,Tech_DetteTargetDate__c,Zuora__SubscriptionNumber__c,Zuora__Status__c,Zuora__CancelledDate__c,
						Zuora__TermEndDate__c,Zuora__SubscriptionEndDate__c,Zuora__TermStartDate__c,Zuora__SubscriptionStartDate__c,Zuora__ContractEffectiveDate__c,
						Zuora__NextChargeDate__c,Zuora__NextRenewalDate__c,Zuora__PreviousSubscriptionId__c,Zuora__External_Id__c,Zuora__CurrentTermPeriodType__c,
						Zuora__CurrentTerm__c,Zuora__TermSettingType__c,Zuora__Zuora_Id__c,Zuora__Account__r.Id,Zuora__Account__r.CodePays__c,Zuora__Account__r.PersonContactId,
						Zuora__CustomerAccount__r.Zuora__Balance__c,Zuora__CustomerAccount__r.Zuora__Zuora_Id__c
                FROM Zuora__Subscription__c
                WHERE Zuora__SubscriptionNumber__c IN :setName
				OR Zuora__External_Id__c IN :setZSubId
				OR (Zuora__Account__r.Id = :setAccId AND (Zuora__SubscriptionEndDate__c > :d1 OR Zuora__SubscriptionEndDate__c = NULL))
                ORDER BY CreatedDate DESC
        ]);
		system.debug('##MNE SM_Subscription getActiveSubscriptionBySetNameORSetZSubIdORSetAccId listSub >> '+listSub);
        return listSub;
    }*/
    
	//Non Utiliser
    // method : recupere le contrat actif du client
    // TODO Cette methode peut evoluer pour filtrer le dernier contrat parmis plusieurs ou se baser sur subscription end date
    /*public static Id getLastActiveSubscriptionId(Id accId) {
        Date d1 = Date.today();
        List<Zuora__Subscription__c> subscriptions = [
                SELECT  Id,Name,TypeContrat__c,CodeFinContrat__c,Tech_AvecRembouesement__c,DateFinContrat__c,Marche__c,Tech_DetteFraisGestion__c,
						Tech_DetteNonEchue__c,Tech_DetteTargetDate__c,Zuora__SubscriptionNumber__c,Zuora__Status__c,Zuora__CancelledDate__c,
						Zuora__TermEndDate__c,Zuora__SubscriptionEndDate__c,Zuora__TermStartDate__c,Zuora__SubscriptionStartDate__c,Zuora__ContractEffectiveDate__c,
						Zuora__NextChargeDate__c,Zuora__NextRenewalDate__c,Zuora__PreviousSubscriptionId__c,Zuora__External_Id__c,Zuora__CurrentTermPeriodType__c,
						Zuora__CurrentTerm__c,Zuora__TermSettingType__c,Zuora__Zuora_Id__c,Zuora__Account__r.Id,Zuora__Account__r.CodePays__c,Zuora__Account__r.PersonContactId,
						Zuora__CustomerAccount__r.Zuora__Balance__c,Zuora__CustomerAccount__r.Zuora__Zuora_Id__c
                FROM Zuora__Subscription__c
                WHERE Zuora__Account__r.Id = :accId
                //AND Zuora__Status__c = 'Active' AND Zuora__SubscriptionEndDate__c > :d1 ORDER BY CreatedDate DESC LIMIT 1];
                AND Zuora__SubscriptionEndDate__c > :d1
                ORDER BY CreatedDate DESC
                LIMIT 1
        ];
        if (subscriptions.isEmpty()) {
            return null;
        } else {
            return subscriptions[0].Id;
        }
    }*/

	/*//non utliser
	public static Date getLastChargedDate(String subZID) {
	    List<AggregateResult> gResult= [SELECT  MAX(Zuora__ChargedThroughDate__c) maxDate  FROM Zuora__SubscriptionProductCharge__c
	                WHERE Zuora__Subscription__r.Zuora__External_Id__c=:subZID AND Zuora__IsLastSegment__c='true'];
	    return (Date)gResult[0].get('maxDate');
    }*/
    
    //##MNE 24/09/2018 dev after 'note de Mouadh'
    //##MNE commenter a la suite refonte synchro, on ne met plus a jour l'id de la sub sur les case apres un amend
    /*public static void SubscriptionAfterInsert (List<Zuora__Subscription__c> listSubscriptions)  {   
        system.debug('##MNE SM_Subscription SubscriptionAfterInsert listSubscriptions >> '+listSubscriptions);
        map<String, Zuora__Subscription__c> mapSubscriptionByZuoraPreviousSubscriptionId = new map<String, Zuora__Subscription__c>();
        for(Zuora__Subscription__c sub : listSubscriptions){
            if(String.isNotBlank(sub.Name)){
                mapSubscriptionByZuoraPreviousSubscriptionId.put(sub.Name, sub);
            }
        }
        list<Case> listCasesToProcess = new list<Case>([Select Id, SubscriptionZName__c, Subscription__c FROM Case WHERE SubscriptionZName__c IN :mapSubscriptionByZuoraPreviousSubscriptionId.keySet()]);
        list<Case> listCasesToUpdated = new list<Case>();
        //list<File_Impression__c> listFIToProcess = new list<File_Impression__c>([Select Id, SubscriptionZName__c, Subscription__c FROM File_Impression__c WHERE SubscriptionZName__c IN :mapSubscriptionByZuoraPreviousSubscriptionId.keySet()]);
        //list<File_Impression__c> listFIToUpdated = new list<File_Impression__c>();
        for(Case c : listCasesToProcess){
            if(String.isNotBlank(c.SubscriptionZName__c) && mapSubscriptionByZuoraPreviousSubscriptionId.containsKey(c.SubscriptionZName__c)){
                c.Subscription__c    = mapSubscriptionByZuoraPreviousSubscriptionId.get(c.SubscriptionZName__c).Id;
                c.SubscriptionZName__c = mapSubscriptionByZuoraPreviousSubscriptionId.get(c.SubscriptionZName__c).Name; 
                listCasesToUpdated.add(c);
            }   
        }
        if(listCasesToUpdated.size() > 0){
            update listCasesToUpdated;
        }
        //for(File_Impression__c fi : listFIToProcess){
        //    if(String.isNotBlank(fi.SubscriptionZName__c) && mapSubscriptionByZuoraPreviousSubscriptionId.containsKey(fi.SubscriptionZName__c)){
        //        fi.Subscription__c    = mapSubscriptionByZuoraPreviousSubscriptionId.get(fi.SubscriptionZName__c).Id;
        //        fi.SubscriptionZName__c = mapSubscriptionByZuoraPreviousSubscriptionId.get(fi.SubscriptionZName__c).Name; 
        //        listFIToUpdated.add(fi);
        //    }   
        //}
        //if(listFIToUpdated.size() > 0){
        //    update listFIToUpdated;
        //}
    }*/

    /*public static Zuora__Subscription__c getSubByPaymentId(String paymentId){
        String invoiceId = SM_Payment.getPaymentPart(paymentId).paymentParts[0].invoiceId;
        String subName = SM_Invoice.getInvoiceItems(invoiceId).invoiceItems[0].subscriptionName;
        return getSubscriptionByName(subName);
    }*/
    
	/*//non utiliser
    public static void syncCancelCaseId (map<Id, Zuora__Subscription__c> mapOldSubscriptions, List<Zuora__Subscription__c> listSubscriptions)  {
            //TODO   Sync du CancelCaseID et CancelCase__c
    }*/