public class LCC001_ChooseRTCase {
    
    public without sharing class WRPInit {
        @AuraEnabled public Map<String,List<String>> objResults 	{ get; set; }
        @AuraEnabled public Case caseRecord 						{ get; set; }
        
		public WRPInit() {
            this.objResults 		= null;
            this.caseRecord 		= new Case();
        }
	}
    
	@AuraEnabled  
    public static Id createRecord(Id recordId, string valueFamille , string valueMotif , string valueOrigin){
        system.debug('##MNE LCC001_ChooseRTCase createRecord recordId >> '+ recordId);
        system.debug('##MNE LCC001_ChooseRTCase createRecord valueFamille >> '+valueFamille);
        system.debug('##MNE LCC001_ChooseRTCase createRecord valueMotif >> '+ valueMotif);
        system.debug('##MNE LCC001_ChooseRTCase createRecord valueOrigin >> '+ valueOrigin);

        if(recordId.getSObjectType() == Schema.Case.SObjectType) {
        	Case cse = [SELECT accountId FROM Case WHERE id = :recordId];
        	recordId = cse.accountId;
        }
        Contact contact = [SELECT id FROM Contact WHERE accountId = :recordId];

        // TODO Assign subscriptionId  only for spécific(Famille,Motif) not for all cases.
        //Id subId = SM_Subscription.getActiveSubscriptionId(recordId);
        SM_Subscription.WRPRep repIds = SM_Subscription.getActiveSubscriptionId(recordId);
		
        system.debug('##MNE repIds >> '+repIds);

        Case c = new Case();
        c.Famille__c = valueFamille;
        c.Motif__c   = valueMotif;
        c.Origin     = valueOrigin;
        c.AccountId	 = recordId;
        c.ContactId  = contact.Id;
        c.Subscription__c = repIds == null ? null : repIds.subscriptionId;
        c.SubscriptionZName__c = repIds == null ? null : repIds.subscriptionName;
        insert c;

        return c.Id;
    }
    
    
	@AuraEnabled  
    public static Id updateRecord(Id recordId, string valueFamille , string valueMotif){
        system.debug('##MNE LCC001_ChooseRTCase updateRecord recordId >> '+ recordId);
        system.debug('##MNE LCC001_ChooseRTCase updateRecord valueFamille >> '+valueFamille);
        system.debug('##MNE LCC001_ChooseRTCase updateRecord valueMotif >> '+ valueMotif);

        Case c = new Case();
		c.Id = recordId;        
        c.Famille__c = valueFamille;
        c.Motif__c   = valueMotif;
        update c;

        return c.Id;
    }
    
	@AuraEnabled  
    public static WRPInit getDependentOptionsImpl(string objApiName , string contrfieldApiName , string depfieldApiName){
        system.debug('##MNE LCC001_ChooseRTCase getDependentOptionsImpl objApiName >> '+objApiName);
        system.debug('##MNE LCC001_ChooseRTCase getDependentOptionsImpl contrfieldApiName >> '+ contrfieldApiName);
        system.debug('##MNE LCC001_ChooseRTCase getDependentOptionsImpl depfieldApiName >> '+ depfieldApiName);
        
        WRPInit rep = new WRPInit();
        String objectName = objApiName.toLowerCase();
        String controllingField = contrfieldApiName.toLowerCase();
        String dependentField = depfieldApiName.toLowerCase();
        
        Map<String,List<String>> objResults = new Map<String,List<String>>();
        Map<String,Schema.SObjectType> objGlobalMap = Schema.getGlobalDescribe();
         
        if (!Schema.getGlobalDescribe().containsKey(objectName)){
            system.debug('##MNE LCC001_ChooseRTCase getDependentOptionsImpl OBJNAME NOT FOUND >> '+objectName);
            rep.objResults = null;
        	return rep;
         }
        
        Schema.SObjectType objType = Schema.getGlobalDescribe().get(objectName);
        if (objType==null){
            rep.objResults = objResults;
        	return rep;
        }
        
        Bitset bitSetObj = new Bitset();
        Map<String, Schema.SObjectField> objFieldMap = objType.getDescribe().fields.getMap();

        if (!objFieldMap.containsKey(controllingField) || !objFieldMap.containsKey(dependentField)){
            system.debug('##MNE LCC001_ChooseRTCase getDependentOptionsImpl FIELD NOT FOUND >> '+ controllingField + ' OR ' + dependentField);
            rep.objResults = objResults;
        	return rep;
        }
        
        List<Schema.PicklistEntry> contrEntries = objFieldMap.get(controllingField).getDescribe().getPicklistValues();
        List<Schema.PicklistEntry> depEntries = objFieldMap.get(dependentField).getDescribe().getPicklistValues();
         objFieldMap = null;
        List<Integer> controllingIndexes = new List<Integer>();
        for(Integer contrIndex=0; contrIndex<contrEntries.size(); contrIndex++){            
            Schema.PicklistEntry ctrlentry = contrEntries[contrIndex];
            //String label = ctrlentry.getLabel();   
            String label = ctrlentry.getValue();
            objResults.put(label,new List<String>());
            controllingIndexes.add(contrIndex);
        }
        List<Schema.PicklistEntry> objEntries = new List<Schema.PicklistEntry>();
        List<PicklistEntryWrapper> objJsonEntries = new List<PicklistEntryWrapper>();
        for(Integer dependentIndex=0; dependentIndex<depEntries.size(); dependentIndex++){            
               Schema.PicklistEntry depentry = depEntries[dependentIndex];
               objEntries.add(depentry);
        } 
        objJsonEntries = (List<PicklistEntryWrapper>)JSON.deserialize(JSON.serialize(objEntries), List<PicklistEntryWrapper>.class);
        List<Integer> indexes;
        for (PicklistEntryWrapper objJson : objJsonEntries){
            if (objJson.validFor==null || objJson.validFor==''){
                continue;
            }
            indexes = bitSetObj.testBits(objJson.validFor,controllingIndexes);
            for (Integer idx : indexes){                
                //String contrLabel = contrEntries[idx].getLabel();
                String contrLabel = contrEntries[idx].getValue();
                objResults.get(contrLabel).add(objJson.label);
            }
        }
        objEntries = null;
        objJsonEntries = null;
        system.debug('##MNE LCC001_ChooseRTCase getDependentOptionsImpl objResults >> '+ objResults);
        rep.objResults = objResults;
        return rep;
    }

}