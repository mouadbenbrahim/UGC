trigger AccountBeforeInsert on Account (before insert) {
    Boolean canTrigger = PAD.canTrigger('AP01_AccountBeforeInsert');
    system.debug('--#### canTrigger AP01_AccountBeforeInsert = ' + canTrigger + ', Force By Pass = '+!PAD.ApexForcedBypass.contains('AP01_AccountBeforeInsert')) ; 

    if (canTrigger) {
        // appel de  la classe APEX pour l'envoie des donnees vers le RCU UGC
        system.debug( '--#### trigger Account before insert'); 
        AP01_Account.processTriggerBeforeInsert(Trigger.new);    
    }   
}