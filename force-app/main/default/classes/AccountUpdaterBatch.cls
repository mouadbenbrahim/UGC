global class AccountUpdaterBatch implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts{

    Double failedUpdates{get; set;}
    
    global AccountUpdaterBatch(){
        failedUpdates = 0;
    } 

    global Database.QueryLocator start(Database.BatchableContext BC){
        System.debug('Start method calling');
        //DescribeSObjectResult describeResult = Account.getSObjectType().getDescribe();    
        //List<String> fieldNames = new List<String>( describeResult.fields.getMap().keySet() );    
        //String query = ' SELECT ' + String.join( fieldNames, ',' ) +    ' FROM ' +describeResult.getName() +'  WHERE CliStatutRCU__c LIKE \'%anonyme%\''; 
        String query = ' SELECT Id, Tech_IdMonCompte__c FROM Account WHERE CliStatutRCU__c LIKE \'%anonyme%\'';  
        system.debug('##MNE AccountUpdaterBatch start query >> '+query);
        return Database.getQueryLocator(query); 
    }

    global void execute(Database.BatchableContext BC, List<sObject> scope){  
        system.debug('##MNE AccountUpdaterBatch execute scope >> '+scope);   
        List<Account> accounts = (List<Account>)scope;
        system.debug('##MNE AccountUpdaterBatch execute scope size >> '+accounts.size()); 
        
        SM002_Anonymisation.accountAnonymisation(accounts, SM002_Anonymisation.AnonymisationType.ALL);
        
    }

    global void finish(Database.BatchableContext BC){
        system.debug('##MNE AccountUpdaterBatch finish NumberOfFails [deprecated] >> '+failedUpdates);
    }
}