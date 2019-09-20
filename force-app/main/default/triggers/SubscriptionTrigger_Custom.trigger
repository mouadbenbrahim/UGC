trigger SubscriptionTrigger_Custom on Zuora__Subscription__c (after insert) {

    Boolean canTrigger = PAD.canTrigger('SubscriptionTrigger_Custom');

    if (canTrigger) {
        system.debug( '##MNE SubscriptionTrigger_Custom trigger Begin'); 
        SM_Subscription.SubscriptionAfterInsert(Trigger.new);    
    }  

}

/*
trigger SubscriptionTrigger_Custom on Zuora__Subscription__c (after insert, before update, before insert) {
	system.debug('##MNE canTrigger SubscriptionTrigger_Custom = '+PAD.canTrigger('SubscriptionTrigger_Custom')+', Force By Pass = '+!PAD.ApexForcedBypass.contains('SubscriptionTrigger_Custom')) ;
	system.debug('##MNE canTrigger SubscriptionTrigger_Custom = '+PAD.canTrigger('SubscriptionTrigger_CustomAfterInsert')+', Force By Pass = '+!PAD.ApexForcedBypass.contains('SubscriptionTrigger_CustomAfterInsert')) ;
	system.debug('##MNE canTrigger SubscriptionTrigger_Custom = '+PAD.canTrigger('SubscriptionTrigger_CustomBeforeInsert')+', Force By Pass = '+!PAD.ApexForcedBypass.contains('SubscriptionTrigger_CustomBeforeInsert')) ;
	system.debug('##MNE canTrigger SubscriptionTrigger_Custom = '+PAD.canTrigger('SubscriptionTrigger_CustomBeforeUpdate')+', Force By Pass = '+!PAD.ApexForcedBypass.contains('SubscriptionTrigger_CustomBeforeUpdate')) ;


	Boolean canTrigger = PAD.canTrigger('SubscriptionTrigger_Custom');

    if (canTrigger) {
    	
	    if (Trigger.isInsert) {
	        if (Trigger.isAfter) {
	            if (PAD.canTrigger('SubscriptionTrigger_CustomAfterInsert') ) {
	                system.debug('##MNE trigger Subscription after insert : appel de  la classe APEX SM_Subscription'); 
	                SM_Subscription.SubscriptionAfterInsert(Trigger.new);    
	            }
	        } 
	        if (Trigger.isBefore) {
	            if (PAD.canTrigger('SubscriptionTrigger_CustomBeforeInsert') ) {
	                system.debug('##MNE trigger Subscription before insert : appel de  la classe APEX SM_Subscription'); 
	                SM_Subscription.SubscriptionBeforeInsert(Trigger.new);    
	            }
	        }   
	            
	    }
	    else if (Trigger.isUpdate) {
	        if (Trigger.isBefore) {
	            if (PAD.canTrigger('SubscriptionTrigger_CustomBeforeUpdate') ) {
	                system.debug('##MNE trigger Subscription before update : appel de  la classe APEX SM_Subscription'); 
	                SM_Invoice.SubscriptionBeforeUpdate(Trigger.oldMap, Trigger.new);   
	            }
	            
	        } 
	    }
	    
    }
}
*/