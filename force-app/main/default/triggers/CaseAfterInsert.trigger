trigger CaseAfterInsert on Case (after insert) {
    
    if (PAD.canTrigger('AP02_CaseAfterInsert') ) {
        // appel de  la classe APEX pour maj le case avec les information de l'objet custom contacts
        system.debug('--#### trigger Case after insert : appel de  la classe APEX AP02_Case'); 
        AP02_Case.processTriggerAfterInsert(Trigger.new);   
     }
}