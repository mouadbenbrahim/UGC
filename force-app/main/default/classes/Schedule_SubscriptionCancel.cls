global with sharing class Schedule_SubscriptionCancel implements  Schedulable {

    global void execute(SchedulableContext SC) {
        Date dateFinContrat = null;
        String subNumber = null;

        Batch_SubscriptionCancel batch = new Batch_SubscriptionCancel(dateFinContrat,subNumber);
        Database.executeBatch(batch,1);
    }
}