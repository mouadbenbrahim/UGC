trigger Case_Trigger on Case (before insert, after insert, before update, after update) {

    if (Trigger.isInsert) {
        if (Trigger.isBefore) {
            if (PAD.canTrigger('AP02_CaseBeforeInsert') ) {
                system.debug('##MNE trigger Case before insert : appel de  la classe apex AP02_Case'); 
                AP02_Case.processTriggerBeforeInsert(Trigger.new);    
            }
        }   
        if (Trigger.isAfter) {
            if (PAD.canTrigger('AP02_CaseAfterInsert') ) {
                system.debug('##MNE trigger Case after insert : appel de  la classe apex AP02_Case'); 
                AP02_Case.processTriggerAfterInsert(Trigger.new);    
            }
        }    
    }
    else if (Trigger.isUpdate) {
        if (Trigger.isBefore) {
            if (PAD.canTrigger('AP02_CaseBeforeUpdate') ) {
                system.debug('##MNE trigger Case before update : appel de  la classe apex AP02_Case'); 
                AP02_Case.processTriggerBeforeUpdate(Trigger.oldMap, Trigger.newMap);   
            }
        }
        if (Trigger.isAfter) {
            if (PAD.canTrigger('AP02_CaseAfterUpdate') ) {
                system.debug('##MNE trigger Case after update : appel de  la classe apex AP02_Case'); 
                AP02_Case.processTriggerAfterUpdate(Trigger.oldMap, Trigger.newMap);   
            }
        }               
    }       
}