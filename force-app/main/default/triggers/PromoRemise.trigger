trigger PromoRemise on PromoRemise__c (before insert, before update, after insert, after update) {

switch on Trigger.operationType  {
    when BEFORE_INSERT {

        // Trigger.new
        
    }
    when BEFORE_UPDATE {
        // Trigger.new
        // Trigger.old
        // Trigger.oldMap 
        // Trigger.newMap
        
    }
    when AFTER_INSERT {
        // Trigger.newMap       
        
    }
    when AFTER_UPDATE {
        // Trigger.old
        // Trigger.newMap
        // Trigger.oldMap 
        
        
    }
    when else {
        
    }
}


}