trigger AttachmentAfterInsert on Attachment (after insert) {
    Boolean canTrigger = PAD.canTrigger('AttachmentAfterInsert');
    system.debug('--#### canTrigger AttachmentAfterInsert = ' + canTrigger + ', Force By Pass = '+!PAD.ApexForcedBypass.contains('AttachmentAfterInsert')) ; 

    if (canTrigger) {
        system.debug( '##MNE AttachmentAfterInsert Begin'); 
        AP03_Attachment.processTriggerAfterInsert(Trigger.new); 
        system.debug( '##MNE AttachmentAfterInsert End'); 
    }   


}