global class Batch_SubscriptionRenewEmail implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts{
	

    global Database.QueryLocator start(Database.BatchableContext BC) {
        
        System.debug('##ECH Start of SubscriptionRenewEmail batch' );
        
		Integer renewDays = Integer.valueOf(Utils.getUgcGenericParam('Subscription Renewal Days','FR').ParamValue__c);
        
        Date renewDate = Date.today().addDays(renewDays);

        System.debug('##ECH Batch_SubscriptionRenewEmail renewDate:'+renewDate );

        return Database.getQueryLocator(
            'SELECT ID,Name, Zuora__Account__c,Zuora__Account__r.PersonContactId ' +
            'FROM Zuora__Subscription__c ' + 
            'Where Date_de_fin_de_contrat__c = :renewDate ' +
            'AND CodeFinContrat__c = null ' +
            'AND TypeContrat__c = \'CDD\' ');
        
        
    }
    
    global void execute(Database.BatchableContext BC, List<Zuora__Subscription__c> scope) {
        System.debug('##ECH Batch_SubscriptionRenewEmail scope size: '+ scope.size());
        Id remboursementRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Réabonnement').getRecordTypeId();
        List<Case> CaseToAdd = new List<Case>();
        
        for (Zuora__Subscription__c sub: scope){
            try {
            	System.debug('##ECH Batch_SubscriptionRenewEmail New Case: '+ sub.Name);
                Case c = new Case();
                c.RecordTypeId = remboursementRecordTypeId;
                c.AccountId = sub.Zuora__Account__c;
                c.ContactId = sub.Zuora__Account__r.PersonContactId;
                c.Subscription__c = sub.Id;
                c.Famille__c = '1- Vie de l\'abonnement';
        		c.Motif__c = '07- Reabonnement';
                c.SousMotif__c = 'C - Communication';
            	c.Origin = 'Interne';             
                CaseToAdd.add(c);
            }
            catch(Exception e) {      
        		System.debug('##ECH Batch_SubscriptionRenewEmail Exception: '+ String.valueOf(e));
        	}
			finally{
                                
            } 

        }
        
        if(CaseToAdd.size()>0)
            insert CaseToAdd;
        
    }
    
    global void finish(Database.BatchableContext BC) {
        System.debug('##ECH End of SubscriptionRenewEmail batch' );
    }
}