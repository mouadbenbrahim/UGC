trigger AccountBeforeUpdate on Account (before update) {
    
    Boolean canTrigger = PAD.canTrigger('AP01_AccountBeforeUpdate');
	system.debug('--#### canTrigger AP01_AccountBeforeUpdate = '+ canTrigger +', Force By Pass = '+!PAD.ApexForcedBypass.contains('AP01_AccountBeforeUpdate')) ; 

	if (canTrigger) {
    	// appel de  la classe APEX pour l'envoie des donnees vers le RCU UGC
        system.debug('--#### trigger Account Before update : appel de  la classe APEX pour envoie des donnees vers le RCU UGC'); 
        AP01_Account.processTriggerBeforeUpdate(Trigger.oldMap, Trigger.newMap);    
	} 
}