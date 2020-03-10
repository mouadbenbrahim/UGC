public without sharing class SMQ_TrackOperation implements Queueable {
    
    private BillingOperation__c ope;

    public SMQ_TrackOperation(String action, Datetime dateOperation, String operation, String zOperation, String amendId, String subId, String subName) {
        
        this.ope = new BillingOperation__c(Action__c = action, DateOperation__c = dateOperation, Operation__c=operation, Zoperation__c = zOperation, 
        AmendZID__c= amendId, SubscriptionZID__c = subId, SubscriptionName__c = subName);
    }

    public void execute(QueueableContext ctx){
        
        insert ope;

    }
}