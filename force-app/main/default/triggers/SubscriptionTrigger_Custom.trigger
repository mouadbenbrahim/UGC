trigger SubscriptionTrigger_Custom on Zuora__Subscription__c (after insert, before update, before insert) {

    if (PAD.canTrigger('SubscriptionTrigger_Custom')) {
        if (Trigger.isInsert) {
            if (Trigger.isAfter) {
                /*if (PAD.canTrigger('SubscriptionTrigger_CustomAfterInsert') ) {
                    system.debug('##MNE trigger Subscription after insert : appel de  la classe APEX SM_Subscription'); 
                    SM_Subscription.SubscriptionAfterInsert(Trigger.new);    
                }*/
            } 
            if (Trigger.isBefore) {
                if (PAD.canTrigger('SubscriptionTrigger_CustomBeforeInsert') ) {
                    system.debug('##MNE trigger Subscription before insert : appel de  la classe APEX SM_Subscription'); 
                    SM_Subscription.SubscriptionBeforeInsert(Trigger.new);    
                }
            }   
        }
        else if (Trigger.isUpdate) {
        	if (Trigger.isAfter) {
        		//after update
        	}
            if (Trigger.isBefore) {
                if (PAD.canTrigger('SubscriptionTrigger_CustomBeforeUpdate') ) {
                    system.debug('##MNE trigger Subscription before update : appel de  la classe APEX SM_Subscription'); 
                    SM_Subscription.SubscriptionBeforeUpdate(Trigger.oldMap, Trigger.new);   
                }
            } 
        }
    }
}