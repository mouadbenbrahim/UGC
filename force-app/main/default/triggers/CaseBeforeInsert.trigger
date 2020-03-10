trigger CaseBeforeInsert on Case (before insert) {

    if (PAD.canTrigger('AP02_CaseBeforeInsert') ) {
        // appel de  la classe APEX pour maj le case avec les information de l'objet custom contacts
        system.debug('--#### trigger Case before insert : appel de  la classe APEX AP02_Case'); 
        AP02_Case.processTriggerBeforeInsert(Trigger.new);  
     }
       
}