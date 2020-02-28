public without sharing class SMQ_TrackOperation implements Queueable {
    
    private BillingOperation__c ope;

    public SMQ_TrackOperation(String action, Datetime dateOperation, String operation, String zOperation, String amendId, String subId, String subName, String codePays) {
        
        String pays;

        if (Util.BELGIQUE.contains(codePays)) {
            pays = 'Belgique';
        } else if (Util.FRANCE.contains(codePays)){
            pays = 'France';
        } else {
            //TODO : throw new MyException('Attribut Code Pays obligatoire sur le Compte');
        }

        this.ope = new BillingOperation__c(Action__c = action, DateOperation__c = dateOperation, Operation__c=operation, Zoperation__c = zOperation, 
        AmendZID__c= amendId, SubscriptionZID__c = subId, SubscriptionName__c = subName, Pays__c=pays);
    }

    public void execute(QueueableContext ctx){
        
        insert ope;

    }
}