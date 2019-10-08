trigger CaseBeforeUpdate on Case (before update) {

	// ne pas decommenter cette ligne !!!
    //system.debug('--#### canTrigger AP02_CaseBeforeUpdate = '+PAD.canTrigger('AP02_CaseBeforeUpdate')+', Force By Pass = '+!PAD.ApexForcedBypass.contains('AP02_CaseBeforeUpdate')) ; 

    if (PAD.canTrigger('AP02_CaseBeforeUpdate') ) {
        // appel de  la classe APEX pour maj le case avec les information de l'objet custom contacts
        system.debug('--#### trigger Case before update : appel de  la classe APEX pour maj de données sur case'); 
        AP02_Case.processTriggerBeforeUpdate(Trigger.oldMap, Trigger.newMap);  
     }
       

}