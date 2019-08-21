global class DeleteCampaignBatch  implements Database.Batchable<sObject>, Database.Stateful {


	global Database.QueryLocator start(Database.BatchableContext BC){
        date d = date.today();

	 System.debug('Start method calling');
		String query = 'SELECT CreatedDate from MC_Campaign__c  where CreatedDate < LAST_N_DAYS:90';	
        System.debug('Start  calling');
    	return Database.getQueryLocator(query); 
    }    
    
    
    
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){

        System.debug('Execute method start');
        List<MC_Campaign__c> camp = (List<MC_Campaign__c>)scope;
    	System.debug('Number of accounts');
        System.debug('account size='+camp.size());
        delete camp;
        
    }
    
    global void finish(Database.BatchableContext BC){
    	System.debug('number of fails');

    }
}