trigger AccountAfterUpdate on Account ( after update) {
	
    Boolean canTrigger = PAD.canTrigger('AP01_AccountAfterUpdate');
	system.debug('--#### canTrigger AP01_AccountAfterUpdate = '+ canTrigger +', Force By Pass = '+!PAD.ApexForcedBypass.contains('AP01_AccountAfterUpdate')) ; 

	if (canTrigger) {
    	// appel de  la classe APEX pour l'envoie des donnees vers le RCU UGC
        system.debug('--#### trigger Account after update : appel de  la classe APEX pour envoie des donnees vers le RCU UGC'); 
        AP01_Account.processTriggerAfterUpdate(Trigger.oldMap, Trigger.newMap);    
	}
}