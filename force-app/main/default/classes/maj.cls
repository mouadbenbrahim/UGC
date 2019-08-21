global class maj implements Database.Batchable<sObject>, Database.Stateful {

    global Database.QueryLocator start(Database.BatchableContext BC){
	
    string query = 'select id, NbFacebook__c, NbTwitter__c, NbCritizr__c from case where NbFacebook__c = null';
    	return Database.getQueryLocator(query); 
    }  

    global void execute(Database.BatchableContext BC, List<sObject> scope){

        System.debug('Execute method start');
        List<Case> l = (List<Case>)scope;
		For(Case cs : l){
  		cs.NbFacebook__c = 0;
  		cs.NbTwitter__c = 0;
 		cs.NbCritizr__c = 0; 
		}
		update l;
     
    }
    
    global void finish(Database.BatchableContext BC){
    	System.debug('number of fails');

    }
    
}