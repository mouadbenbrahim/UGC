global class mailBatchMak implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts{
    Double failedUpdates{get; set;}

    global Database.QueryLocator start(Database.BatchableContext BC){
        System.debug('Start method calling');
		String query = 'Select Email from contact where Email = null';	
        System.debug('Start  calling');
    	return Database.getQueryLocator(query); 
    }

	global void execute(Database.BatchableContext BC, List<sObject> scope){		
        System.debug('Execute method start');
        List<Contact> con = (List<Contact>)scope;
        System.debug(con.size());
        
        Set<Id> accId = new Set<Id>();
   
        for(Contact myCon : con){
          accId.add(myCon.Id);    	
		}
        List<Case> cases = [Select Id from Case where ContactId in:accId];
		
        delete cases;
        
	 	Database.delete(con, false); 
	}
   
      global mailBatchMak(){
        failedUpdates = 0;
    }   
    

    global void finish(Database.BatchableContext BC){
    	System.debug('number of fails');
        System.debug(failedUpdates);
        
    }
    
    
    
}