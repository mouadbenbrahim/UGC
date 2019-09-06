public with sharing class SM_Subscription {
/// -2
    //Member variables
    public Zuora__Subscription__c sub;
    //public static String zEntityId = '8adce421-63ec-c07b-0163-f45782667179'; // France
    // String zEntityId = '8adce421-63ec-c07b-0163-f457db12717e'; // Belgique
/// dc 1

    // Constructors
    public SM_Subscription() {
        sub = new Zuora__Subscription__c();
    }


    public static Zuora__Subscription__c getSubscription(Id subId) {
        //TODO: dans le cas ou la demande doit traiter une souscription non active ou ex. client qui a plusieurs subscriptions (doublons à traiter)
        //il faut songer à lier la demande à la souscription automatiquement à la création (si une seul active) et prevoir un lookup pour
        // laisser le CC selection une souscription si l'action doit se faire sur une souscription autre que celle renvoyé par getActiveSub..


        System.debug('##MBEN:setSub');
        Zuora__Subscription__c subscription = [
                SELECT Id, Name, Zuora__Zuora_Id__c, Zuora__Account__r.Id, Zuora__Account__r.Name,
                        Zuora__SubscriptionNumber__c,Zuora__Status__c,
                        Zuora__CancelledDate__c,Zuora__TermEndDate__c,Zuora__SubscriptionEndDate__c,
                        Zuora__TermStartDate__c,Zuora__SubscriptionStartDate__c,Zuora__ContractEffectiveDate__c,Zuora__NextChargeDate__c,
                        TypeContrat__c, CodeFinContrat__c, Zuora__NextRenewalDate__c,
                        Zuora__CustomerAccount__r.Zuora__Zuora_Id__c, Zuora__PreviousSubscriptionId__c, Tech_AvecRembouesement__c,
                        Zuora__CustomerAccount__r.Zuora__Balance__c, 
                        Zuora__External_Id__c, Zuora__Account__r.CodePays__c, Zuora__CurrentTermPeriodType__c, Zuora__CurrentTerm__c
                FROM Zuora__Subscription__c
                WHERE Id = :subId
        ];

       return subscription;
    }

    public static Zuora__Subscription__c getSubscriptionByName(String name) {
        //TODO: dans le cas ou la demande doit traiter une souscription non active ou ex. client qui a plusieurs subscriptions (doublons à traiter)
        //il faut songer à lier la demande à la souscription automatiquement à la création (si une seul active) et prevoir un lookup pour
        // laisser le CC selection une souscription si l'action doit se faire sur une souscription autre que celle renvoyé par getActiveSub..


        System.debug('##MBEN:setSub');
        Zuora__Subscription__c subscription = [
                SELECT Id, Name, Zuora__Zuora_Id__c, Zuora__Account__r.Id, Zuora__Account__r.Name,
                        Zuora__SubscriptionNumber__c,Zuora__Status__c,
                        Zuora__CancelledDate__c,Zuora__TermEndDate__c,Zuora__SubscriptionEndDate__c,
                        Zuora__TermStartDate__c,Zuora__SubscriptionStartDate__c,Zuora__ContractEffectiveDate__c,Zuora__NextChargeDate__c,
                        TypeContrat__c, CodeFinContrat__c
                FROM Zuora__Subscription__c
                WHERE Name = :name
        ];

        return subscription;
    }

    // method updateWS
    public static WSZ.SubOut updateSub(String subId, Zuora__Subscription__c sub, String zEntityId) {

        System.debug('##MBEN: updateWS');
        //String endpoint = 'https://rest.sandbox.eu.zuora.com/v1/object/subscription/' + subId;
        String endpoint = '/v1/object/subscription/' + subId;
        String method = 'PUT';
        String wsIn = '';
        String wsOut = '';

        // Retrieve Zuora token
        String accessToken = WS001_CallZuora.access_token;

        wsIn = (String) JSON.serialize(sub);
        System.debug('##MBEN7: |' + wsIn + '|');
        wsOut = WS001_CallZuora.sendRequest(accessToken, endpoint, zEntityId, method, wsIn,'type1', '211.0');
        return (WSZ.SubOut) JSON.deserializeStrict(wsOut, WSZ.SubOut.class);
    }


    // method : recupere le contrat actif du client
    // TODO Cette methode peut evoluer pour filtrer le dernier contrat parmis plusieurs ou se baser sur subscription end date
    public static Id getLastActiveSubscriptionId(Id accId) {
        Date d1 = Date.today();
        List<Zuora__Subscription__c> subscriptions = [
                SELECT Id
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
    }

    public static WRPRep getActiveSubscriptionId(Id accId) {
        Date d1 = Date.today();
        List<Zuora__Subscription__c> subscriptions = [
                SELECT Id, Zuora__Zuora_Id__c, Name
                FROM Zuora__Subscription__c
                WHERE Zuora__Account__r.Id = :accId
                //AND Zuora__Status__c = 'Active' AND Zuora__SubscriptionEndDate__c > :d1 ORDER BY CreatedDate DESC LIMIT 1];
                AND ( Zuora__SubscriptionEndDate__c > :d1 OR Zuora__SubscriptionEndDate__c = NULL )
                ORDER BY CreatedDate DESC
        ];

        //if (subscriptions.isEmpty() || subscriptions.size() > 1) {
        if (subscriptions.isEmpty()) {
            return null;
        } else {
            //return subscriptions[0].Id;
            return new WRPRep(subscriptions[0].Id, subscriptions[0].Zuora__Zuora_Id__c, subscriptions[0].Name);
        }
    }


    // method cancelWS
    public static WSZ.SubCancelOut cancelSub(String cancellationEffectiveDate, String policy, String subId, Boolean runBilling, String targetDate, String zEntityId) {
        System.debug('##MBEN: cancelWS');
        system.debug('##MNE SM_Subscription cancelSub cancellationEffectiveDate >> '+cancellationEffectiveDate);
        system.debug('##MNE SM_Subscription cancelSub policy >> '+policy);
        system.debug('##MNE SM_Subscription cancelSub subId >> '+subId);
        system.debug('##MNE SM_Subscription cancelSub runBilling >> '+runBilling);
        system.debug('##MNE SM_Subscription cancelSub targetDate >> '+targetDate);
        
        String endpoint = '/v1/subscriptions/' + subId + '/cancel';
        String method = 'PUT';
        String wsIn = '';
        String wsOut = '';

        // Retrieve Zuora token
        String accessToken = WS001_CallZuora.access_token;

        // Call WS
        WSZ.SubCancelIn wsInObj = new WSZ.SubCancelIn();
        if(policy == 'EndOfLastInvoicePeriod'){
        	wsInObj.cancellationPolicy = policy;
        } else {
        	wsInObj.cancellationEffectiveDate = cancellationEffectiveDate;
	        wsInObj.cancellationPolicy = policy;
	        wsInObj.runBilling = runBilling;
        }
         wsInObj.targetDate = targetDate;
        
        System.debug('##MBEN6: |' + wsInObj.cancellationEffectiveDate + '|' + wsInObj.cancellationPolicy);
        wsIn = (String) JSON.serialize(wsInObj);
        /*wsIn = wsIn.replace('xcollect','collect'); // resoud pb mot reserve
        if(runBilling == false || targetDate == null){
            wsIn = wsIn.replace('"collect":null,','');
            wsIn = wsIn.replace('"collect":null','');
            wsIn = wsIn.replace('"targetDate":null,','');
            wsIn = wsIn.replace('"targetDate":null','');
            wsIn = wsIn.replace('"runBilling":null,','');
            wsIn = wsIn.replace('"runBilling":null','');
        }*/
        System.debug('##MBEN7: |' + wsIn + '|');
        wsOut = WS001_CallZuora.sendRequest(accessToken, endpoint, zEntityId, method, wsIn, 'type1', '211.0');
        return (WSZ.SubCancelOut) JSON.deserializeStrict(wsOut, WSZ.SubCancelOut.class);
    }


	public static Date getLastChargedDate(String subZID) {
	    List<AggregateResult> gResult= [SELECT  MAX(Zuora__ChargedThroughDate__c) maxDate  FROM Zuora__SubscriptionProductCharge__c
	                WHERE Zuora__Subscription__r.Zuora__External_Id__c=:subZID AND Zuora__IsLastSegment__c='true'];
	    return (Date)gResult[0].get('maxDate');
    }


// method deleteWS: Annuler un desabonnement
    public static WSZ.SubOut deleteSub(String subId, String zEntityId) {
        //String endpoint = 'https://rest.sandbox.eu.zuora.com/v1/object/subscription/' + subId;
        String endpoint = '/v1/object/subscription/' + subId;
        String method = 'DELETE';
        String wsIn = null;
        String wsOut = '';

        // Retrieve Zuora token
        String accessToken = WS001_CallZuora.access_token;

        wsOut = WS001_CallZuora.sendRequest(accessToken, endpoint, zEntityId, method, wsIn, 'type1', null);
        return (WSZ.SubOut) JSON.deserializeStrict(wsOut, WSZ.SubOut.class);
    }
    
    
    //##MNE 24/09/2018 dev after 'note de Mouadh'
    public static void SubscriptionAfterInsert (List<Zuora__Subscription__c> listSubscriptions)  {   
        system.debug('##MNE SM_Subscription SubscriptionAfterInsert listSubscriptions >> '+listSubscriptions);
        
        map<String, Zuora__Subscription__c> mapSubscriptionByZuoraPreviousSubscriptionId = new map<String, Zuora__Subscription__c>();
        
        for(Zuora__Subscription__c sub : listSubscriptions){
            //if(String.isNotBlank(sub.Zuora__PreviousSubscriptionId__c)){
            if(String.isNotBlank(sub.Name)){
                //mapSubscriptionByZuoraPreviousSubscriptionId.put(sub.Zuora__PreviousSubscriptionId__c, sub);
                mapSubscriptionByZuoraPreviousSubscriptionId.put(sub.Name, sub);
            }
        }
        
        list<Case> listCasesToProcess = new list<Case>([Select Id, SubscriptionZID__c, Subscription__c FROM Case WHERE SubscriptionZID__c IN :mapSubscriptionByZuoraPreviousSubscriptionId.keySet()]);
        list<Case> listCasesToUpdated = new list<Case>();
        
        list<File_Impression__c> listFIToProcess = new list<File_Impression__c>([Select Id, SubscriptionZID__c, Subscription__c FROM File_Impression__c WHERE SubscriptionZID__c IN :mapSubscriptionByZuoraPreviousSubscriptionId.keySet()]);
        list<File_Impression__c> listFIToUpdated = new list<File_Impression__c>();
        
        for(Case c : listCasesToProcess){
            if(String.isNotBlank(c.SubscriptionZID__c) && mapSubscriptionByZuoraPreviousSubscriptionId.containsKey(c.SubscriptionZID__c)){
                c.Subscription__c    = mapSubscriptionByZuoraPreviousSubscriptionId.get(c.SubscriptionZID__c).Id;
                c.SubscriptionZID__c = mapSubscriptionByZuoraPreviousSubscriptionId.get(c.SubscriptionZID__c).Name; 
                listCasesToUpdated.add(c);
            }   
        }
        if(listCasesToUpdated.size() > 0){
            update listCasesToUpdated;
        }
        
        for(File_Impression__c fi : listFIToProcess){
            if(String.isNotBlank(fi.SubscriptionZID__c) && mapSubscriptionByZuoraPreviousSubscriptionId.containsKey(fi.SubscriptionZID__c)){
                fi.Subscription__c    = mapSubscriptionByZuoraPreviousSubscriptionId.get(fi.SubscriptionZID__c).Id;
                fi.SubscriptionZID__c = mapSubscriptionByZuoraPreviousSubscriptionId.get(fi.SubscriptionZID__c).Name; 
                listFIToUpdated.add(fi);
            }   
        }
        if(listFIToUpdated.size() > 0){
            update listFIToUpdated;
        }
    }
    
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

        // Retrieve Zuora token
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
        //String endpoint = 'https://rest.sandbox.eu.zuora.com/v1/object/subscription/' + subId;
        String endpoint = '/v1/action/update';
        String method = 'POST';
        String wsIn = '';
        String wsOut = '';

        // Retrieve Zuora token
        WSZ.WRPOauthLogin tokObj = WS001_CallZuora.access_token2;

        WSZ.SubUpdateIn subUpdateIn = new WSZ.SubUpdateIn(subs);
        wsIn = (String) JSON.serialize(subUpdateIn);
        wsIn = wsIn.replace('Zuora__Zuora_Id__c','Id');
        System.debug('##MBEN7: |' + wsIn + '|');
        wsOut = WS001_CallZuora.sendRequest(tokObj.access_token, endpoint, zEntityId, method, wsIn,'type1',null);
        WS001_CallZuora.update_token2(tokObj);
        return (List<WSZ.SubOut>) JSON.deserializeStrict(wsOut, List<WSZ.SubOut>.class);
    }


    /*public static Zuora__Subscription__c getSubByPaymentId(String paymentId){

        String invoiceId = SM_Payment.getPaymentPart(paymentId).paymentParts[0].invoiceId;
        String subName = SM_Invoice.getInvoiceItems(invoiceId).invoiceItems[0].subscriptionName;
        return getSubscriptionByName(subName);

    }*/

}