global class Batch002_AnonymisationAfterThreeYears implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts{

    Double failedUpdates{get; set;}
    
    global Batch002_AnonymisationAfterThreeYears (){
        failedUpdates = 0;
    } 

    global Database.QueryLocator start(Database.BatchableContext BC){
        Date now = Date.today();
        Date trhee = now.addYears(-3);
        String trheeStr = String.valueOf(trhee);
        system.debug('##MNE trheeStr >> '+trheeStr);
        
        String query = ' SELECT Id, Tech_IdMonCompte__c FROM Account WHERE Id IN (SELECT Zuora__Account__c FROM Zuora__Subscription__c WHERE Zuora__SubscriptionEndDate__c <= '+trheeStr+') AND Id NOT IN (SELECT Zuora__Account__c FROM Zuora__Subscription__c WHERE Zuora__SubscriptionEndDate__c >= '+trheeStr+')';  
        system.debug('##MNE Batch002_AnonymisationAfterThreeYears start query >> '+query);
        return Database.getQueryLocator(query); 
    }

    global void execute(Database.BatchableContext BC, List<sObject> scope){  
        system.debug('##MNE Batch002_AnonymisationAfterThreeYears execute scope >> '+scope);   
        List<Account> accounts = (List<Account>)scope;
        system.debug('##MNE Batch002_AnonymisationAfterThreeYears execute scope size >> '+accounts.size()); 
        
        SM002_Anonymisation.accountAnonymisation(accounts, SM002_Anonymisation.AnonymisationType.ONLY_ZUORA);
        
        
    }

    global void finish(Database.BatchableContext BC){
        system.debug('##MNE Batch002_AnonymisationAfterThreeYears finish NumberOfFails [deprecated] >> '+failedUpdates);
    }


}