global class MailBatch implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts{

    Double failedUpdates{get; set;}

    global Database.QueryLocator start(Database.BatchableContext BC){
        System.debug('Start method calling');
		String query = 'Select id from Account where PersonEmail = null';	
        System.debug('Start  calling');
    	return Database.getQueryLocator(query); 
    }

	global void execute(Database.BatchableContext BC, List<sObject> scope){		
        System.debug('Execute method start');
        List<Account> accounts = (List<Account>)scope;
        Set<Id> accId = new Set<Id>();
   
        for(Account myAccount : accounts){
          accId.add(myAccount.Id);    	
		}
        
        System.debug('account size='+accounts.size());
         List<Case> cases = [Select Id from Case where AccountId in:accId];
		delete cases;
        
        delete[Select id from FeedItem where ParentId in:accId];
	 	Database.delete(accounts, false);
		
        
        
	}
   
      global MailBatch(){
        failedUpdates = 0;
    }   
    

    global void finish(Database.BatchableContext BC){
    	System.debug('number of fails');
        System.debug(failedUpdates);
        
    }
    
    
    
}