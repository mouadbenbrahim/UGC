public without sharing class SM_ChangeBanque{
	
	public static WSZ.ChangeBanqueOut changebanque(WSZ.ChangeBanqueIn wsIn){
		system.debug('##MNE SM_ChangeBanque ChangeBanqueOut wsIn >> '+wsIn);
        
        WSZ.ChangeBanqueOut wsOut  = new WSZ.ChangeBanqueOut();
        String wsInStr = JSON.serialize(wsIn);
		ProcessLog__c pLog = new ProcessLog__c(Process__c = 'changebanque', Account__c = wsIn.accountSFID, SubscriptionName__c = wsIn.subscriptionName, Message__c = wsInStr);
		
		system.debug('##MNE SM_ChangeBanque ChangeBanqueOut wsIn.accountSFID >> '+wsIn.accountSFID);
		system.debug('##MNE SM_ChangeBanque ChangeBanqueOut wsIn.payeurSFID >> '+wsIn.payeurSFID);
		system.debug('##MNE SM_ChangeBanque ChangeBanqueOut wsIn.mandateId >> '+wsIn.mandateId);
		system.debug('##MNE SM_ChangeBanque ChangeBanqueOut wsIn.iban >> '+wsIn.iban);
		system.debug('##MNE SM_ChangeBanque ChangeBanqueOut wsIn.subscriptionName >> '+wsIn.subscriptionName);
		system.debug('##MNE SM_ChangeBanque ChangeBanqueOut wsIn.lieu >> '+wsIn.lieu);
		system.debug('##MNE SM_ChangeBanque ChangeBanqueOut wsIn.agent >> '+wsIn.agent);
		
        
		
		if(wsIn == null){
			throw new RTException(RTExceptionCode.ERREUR_CHANGEBANQUE_WSIN_MANQUANT, pLog);
		}
		if(String.isBlank(wsIn.accountSFID)){
			throw new RTException(RTExceptionCode.ERREUR_CHANGEBANQUE_WSIN_ACCOUNTSFID_MANQUANT, pLog);
		}
		if(String.isBlank(wsIn.payeurSFID)){
			throw new RTException(RTExceptionCode.ERREUR_CHANGEBANQUE_WSIN_PAYEURSFID_MANQUANT, pLog);
		}
		if(String.isBlank(wsIn.mandateId)){
			throw new RTException(RTExceptionCode.ERREUR_CHANGEBANQUE_WSIN_MANDATEID_MANQUANT, pLog);
		}
		if(String.isBlank(wsIn.iban)){
			throw new RTException(RTExceptionCode.ERREUR_CHANGEBANQUE_WSIN_iIBAN_MANQUANT, pLog);
		}
		if(String.isBlank(wsIn.subscriptionName)){
			throw new RTException(RTExceptionCode.ERREUR_CHANGEBANQUE_WSIN_SUBSCRIPTIONNAME_MANQUANT, pLog);
		}
		/*if(String.isBlank(wsIn.lieu)){
			throw new RTException(RTExceptionCode.ERREUR_CHANGEBANQUE_WSIN_LIEU_MANQUANT, pLog);
		}*/
        
        Boolean isJustChangeMandate = false;
        //get sub
        list<Zuora__Subscription__c> listSub = SM_Subscription.getSubscriptionBySetName(new Set<String>{wsIn.subscriptionName});
        if(listSub.size() == 0){
        	throw new RTException(RTExceptionCode.ERREUR_CHANGEBANQUE_SUB_NON_TROUVE, pLog);
        }
        Zuora__Subscription__c sub = listSub.get(0);
        system.debug('##MNE SM_ChangeBanque ChangeBanqueOut sub >> '+sub);
        if(wsIn.payeurSFID == sub.PayeurCRMID__c){
        	isJustChangeMandate = true;
        }
        
        system.debug('##MNE SM_ChangeBanque ChangeBanqueOut isJustChangeMandate >> '+isJustChangeMandate);
        
        //get billing account
		List<Zuora__CustomerAccount__c> listBillingAccounts = new List<Zuora__CustomerAccount__c>([SELECT Id, Zuora__External_Id__c FROM Zuora__CustomerAccount__c WHERE Zuora__Account__c = :wsIn.accountSFID]);
		if(listBillingAccounts.size() == 0){
        	throw new RTException(RTExceptionCode.ERREUR_CHANGEBANQUE_BILL_ACC_NON_TROUVE, pLog);
        }
		String accountZID = listBillingAccounts.get(0).Zuora__External_Id__c;
		system.debug('##MNE SM_ChangeBanque ChangeBanqueOut accountZID >> '+accountZID);
		
		//get account 
		//TO DO : changer la methode SM_Account.getAccountData pour retourner null si id incorrect
		Account porteur = SM_Account.getAccountData(wsIn.accountSFID);
		system.debug('##MNE SM_ChangeBanque ChangeBanqueOut porteur >> '+porteur);
		if(porteur == null){
			throw new RTException(RTExceptionCode.ERREUR_CHANGEBANQUE_PORTEUR_NON_TROUVE, pLog); 
		}
		
		Account payeur = SM_Account.getAccountData(wsIn.payeurSFID);
		system.debug('##MNE SM_ChangeBanque ChangeBanqueOut payeur >> '+payeur);
		if(payeur == null){
			throw new RTException(RTExceptionCode.ERREUR_CHANGEBANQUE_PAYEUR_NON_TROUVE, pLog);
		}
		
		
		String accessToken = WS001_CallZuora.access_token;
        String zEntityId = WS001_CallZuora.getZuoraEntityId(porteur.CodePays__c);  
        
		//1 - Ajout/Changement de payeur
		//2 - Modification IBAN
		//Création zPaymentMethod (1 & 2)
		system.debug('##MNE SM_ChangeBanque ChangeBanqueOut Création zPaymentMethod (1 & 2) BEGIN');
		zc_ProxyCreatePaymentMethod reqObj = SM_Payment.paymentMethodElec(accountZID, wsIn.iban, wsIn.mandateId, payeur);
		zc_ProxyCreateOrModifyResponse resObj = zc_Api.objectPaymentMethodPOST(accessToken, zEntityId, reqObj, RTExceptionCode.ERREUR_CHANGEBANQUE_CREATION_ZPAYMENT_METHOD, pLog);
		String elecPayMethodId = resObj.id;
		system.debug('##MNE SM_ChangeBanque ChangeBanqueOut Création zPaymentMethod (1 & 2) END');
		
		//Maj zCompte (1 & 2)
		system.debug('##MNE SM_ChangeBanque ChangeBanqueOut Maj zCompte (1 & 2) BEGIN');
		zc_ProxyActionupdateRequest accUpdateReq = new zc_ProxyActionupdateRequest();
		accUpdateReq.r_type = 'Account';
		zc_ZObjectUpdate zObj = new zc_ZObjectUpdate();
		zObj.id = accountZID;
		zObj.autoPay = true;
		if(sub.TypeContrat__c == 'CDD'){
			zObj.autoPay = false;
		}
		zObj.defaultPaymentMethodId = elecPayMethodId;
		accUpdateReq.objects.add(zObj);
		zc_Api.actionUpdatePOST(accessToken, zEntityId, accUpdateReq, RTExceptionCode.ERREUR_CHANGEBANQUE_UPDATE_ZCOMPTE,pLog);  
		system.debug('##MNE SM_ChangeBanque ChangeBanqueOut Maj zCompte (1 & 2) END');
		
		if(!isJustChangeMandate){ //cas Ajout/Changement de payeur
			//Maj zContact (1)
			system.debug('##MNE SM_ChangeBanque ChangeBanqueOut Maj zContact (1) BEGIN');
			zc_PUTAccountType reqObj2 = new zc_PUTAccountType();
			reqObj2.billToContact = new zc_PUTAccountTypeBillToContact();
			reqObj2.billToContact.address1 = payeur.NoVoie__c + ' ' + payeur.TypeVoie__c + ' ' + payeur.NomVoie__c;
			reqObj2.billToContact.city = payeur.Ville__r.Name;
			reqObj2.billToContact.country = payeur.Ville__r.Pays__c;
			reqObj2.billToContact.firstName = payeur.FirstName;
			reqObj2.billToContact.lastName = payeur.LastName;
			reqObj2.billToContact.zipCode = payeur.Ville__r.CodePostal__c;
			reqObj2.billToContact.personalEmail = payeur.PersonEmail;  	
			zc_CommonResponseType billToUpdResp = zc_Api.accountPUT(accessToken, zEntityId, accountZID, reqObj2, RTExceptionCode.ERREUR_CHANGEBANQUE_UPDATE_ZCONTACT, pLog);
			system.debug('##MNE SM_ChangeBanque ChangeBanqueOut Maj zContact (1) END');
			
			//Maj zSouscription (1)
			system.debug('##MNE SM_ChangeBanque ChangeBanqueOut Maj zSouscription (1) BEGIN');
			zc_ProxyActionupdateRequest subUpdReq = new zc_ProxyActionupdateRequest();
			subUpdReq.r_type = 'Subscription';
			zObj = new zc_ZObjectUpdate();
			zObj.id = sub.Zuora__External_Id__c;
			zObj.methodePaiement = 'PRE';
			zObj.payeurCRMID = wsIn.payeurSFID;
			subUpdReq.objects.add(zObj);
			zc_Api.actionUpdatePOST(accessToken, zEntityId, subUpdReq, RTExceptionCode.ERREUR_CHANGEBANQUE_UPDATE_ZSUBSCRIPTION, pLog);
			system.debug('##MNE SM_ChangeBanque ChangeBanqueOut Maj zSouscription (1) END');
		}
        
        
        //create sfdc (1 & 2)
        system.debug('##MNE SM_ChangeBanque ChangeBanqueOut create sfdc (1 & 2) BEGIN');
        // Get Zuora Data (subscription)
        zc_GETSubscriptionTypeWithSuccess zSub = zc_Api.subscriptionGET(accessToken, zEntityId, sub.Zuora__External_Id__c, RTExceptionCode.EERREUR_CHANGEBANQUE_GET_ZSUBSCRIPTION,pLog);

        // Get Zuora Data (Account)
        zc_ProxyGetAccount zacc = zc_Api.objectAccountGET(accessToken, zEntityId, accountZID, RTExceptionCode.EERREUR_CHANGEBANQUE_GET_ACCOUNT,pLog);
		String payMethodId = zacc.defaultPaymentMethodId;

        // Get Zuora Data (PaymentMethod)
        zc_ProxyGetPaymentMethod pm = zc_Api.objectPaymentMethodGET(accessToken, zEntityId, payMethodId, RTExceptionCode.ERREUR_CHANGEBANQUE_GET_PAYMENTMETHOD,pLog);

        // insert zdocdata subscription
        //Id zDocId = SM_Hermes.addZdocData(new Map<String,Object>{'ZSUB' => sub,'ZPM' => pm,'ACC' => porteur});
        Id zDocId = SM_Hermes.addZdocData(new Map<String,Object>{'ZSUB' => zSub,'ZPM' => pm,'ACC' => porteur});
        
        // insert case
        String sousMotif = SM_Hermes.lieuToSousMotif(wsIn.lieu);
        String origin = SM_Hermes.lieuToOrigin(wsIn.lieu);
        String commentairesInternes = isJustChangeMandate ? 'Changement de mandat' : 'Changement de payeur';
        Case c = SM_Hermes.newCase(zDocId, wsIn.subscriptionName, porteur.PersonContactId, origin, '7- Finance', '05- Changement coordonnees bancaires', sousMotif, 
        				 		   'Fermee', wsIn.lieu, commentairesInternes, wsIn.accountSFID, null, null, null, wsIn.agent);
        Id caseId = c.Id;
		
        // generate sDoc 
        List<Case> cs = [SELECT Id,AccountId,TECHIdStatut__c FROM Case WHERE Id=:caseId];
        SM_SDoc.makeSdocJobs(cs);
        system.debug('##MNE SM_ChangeBanque ChangeBanqueOut create sfdc (1 & 2) END');
        
		wsOut = new WSZ.ChangeBanqueOut(wsIn.accountSFID, accountZID, sub.Zuora__External_Id__c, wsIn.subscriptionName, caseId, wsIn.refGuid);
		return wsOut;
    }
}