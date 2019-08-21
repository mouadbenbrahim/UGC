trigger AccountAfterInsert on Account ( after insert) {
	
	Boolean canTrigger = PAD.canTrigger('AP01_AccountAfterInsert');
    system.debug('--#### canTrigger AP01_AccountAfterInsert = ' + canTrigger + ', Force By Pass = '+!PAD.ApexForcedBypass.contains('AP01_AccountAfterInsert')) ; 

    if (canTrigger) {
        // appel de  la classe APEX pour l'envoie des donnees vers le RCU UGC
        system.debug( '--#### trigger Account after insert : appel de  la classe APEX pour envoie des donnees vers le RCU UGC'); 
        AP01_Account.processTriggerAfterInsert(Trigger.new);    
    }   
}