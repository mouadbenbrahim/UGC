trigger InvoiceTriggerCustom on Zuora__ZInvoice__c (after insert, after update) {
    system.debug('##MNE canTrigger InvoiceTriggerCustomAfterInsert = '+PAD.canTrigger('InvoiceTriggerCustomAfterInsert')+', Force By Pass = '+!PAD.ApexForcedBypass.contains('InvoiceTriggerCustomAfterInsert')) ;
    system.debug('##MNE canTrigger InvoiceTriggerCustomAfterUpdate = '+PAD.canTrigger('InvoiceTriggerCustomAfterUpdate')+', Force By Pass = '+!PAD.ApexForcedBypass.contains('InvoiceTriggerCustomAfterUpdate')) ;
    
    if (Trigger.isInsert) {
        if (Trigger.isAfter) {
            if (PAD.canTrigger('InvoiceTriggerCustomAfterInsert') ) {
                system.debug('##MNE trigger Invoice after insert : appel de  la classe APEX SM_Invoice'); 
                SM_Invoice.processTriggerAfter(null, Trigger.new);   
            }
        }        
    }
    else if (Trigger.isUpdate) {
        if (Trigger.isAfter) {
            if (PAD.canTrigger('InvoiceTriggerCustomAfterUpdate') ) {
                system.debug('##MNE trigger Invoice after update: appel de  la classe APEX SM_Invoice'); 
                SM_Invoice.processTriggerAfter(Trigger.oldMap, Trigger.new);   
            }
            
        } 
    }

}