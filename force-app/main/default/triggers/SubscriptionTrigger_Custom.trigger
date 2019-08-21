trigger SubscriptionTrigger_Custom on Zuora__Subscription__c (after insert) {

    Boolean canTrigger = PAD.canTrigger('SubscriptionTrigger_Custom');

    if (canTrigger) {
        system.debug( '##MNE SubscriptionTrigger_Custom trigger Begin'); 
        SM_Subscription.SubscriptionAfterInsert(Trigger.new);    
    }  

}