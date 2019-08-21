trigger CaseAfterUpdate on Case (after update) {
    system.debug('--#### canTrigger AP02_CaseAfterUpdate = '+PAD.canTrigger('AP02_CaseAfterUpdate')+', Force By Pass = '+!PAD.ApexForcedBypass.contains('AP02_CaseAfterUpdate')) ; 

    if (PAD.canTrigger('AP02_CaseAfterUpdate') ) {
        // appel de  la classe APEX pour maj le case avec les information de l'objet custom contacts
        system.debug('--#### trigger Case after update : appel de  la classe APEX pour maj de données sur case'); 
        AP02_Case.processTriggerAfterUpdate(Trigger.oldMap, Trigger.newMap);  
     }
}