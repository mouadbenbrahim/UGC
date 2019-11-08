global with sharing class Schedule_SubscriptionRenewEmail implements Schedulable {
 	
    global void execute(SchedulableContext SC) {

        Integer BatchSize = 100;
       
        Batch_SubscriptionRenewEmail batch = new Batch_SubscriptionRenewEmail();
        Database.executeBatch(batch,BatchSize);
    }
    
}