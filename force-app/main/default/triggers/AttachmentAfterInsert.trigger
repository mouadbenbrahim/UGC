trigger AttachmentAfterInsert on Attachment (after insert) {

    if (PAD.canTrigger('AttachmentAfterInsert')) {
        system.debug( '##MNE AttachmentAfterInsert Begin'); 
        AP03_Attachment.processTriggerAfterInsert(Trigger.new); 
        system.debug( '##MNE AttachmentAfterInsert End'); 
    }   


}