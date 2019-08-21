public class SDAddToMassMerge {
    private ApexPages.StandardSetController stdSetController;
    
    public SDAddToMassMerge(ApexPages.StandardSetController sscOther) {
        stdSetController = sscOther;
    }

    public String objectName {get;set;}

    public Boolean showHeader {get;set;}

    public void setShowHeaderFalse() {
        showHeader = false;
    }
    
    public PageReference createMassMergeJobs() {
        List<SDOC__SDJob__c> addToMassMerge = new List<SDOC__SDJob__c>();
        for (sObject selectedRecord : stdSetController.getSelected()) {
            SDOC__SDJob__c massMergeJob = new SDOC__SDJob__c(
                SDOC__Oid__c = String.valueOf(selectedRecord.get('Id')),
                SDOC__runAs__c = UserInfo.getUserName(),
                SDOC__Status__c = 'Selected',
                SDOC__type__c = 'Bulk Job - List View',
                SDOC__objAPIName__c = objectName
            );
            addToMassMerge.add(massMergeJob);
        }
        insert addToMassMerge;

        Integer batchSize = Database.countQuery(
            'SELECT COUNT() FROM SDOC__SDJob__c WHERE ownerid=\'' 
            + String.valueOf(UserInfo.getUserId()) + '\''
        );

        if (showHeader == null) { 
            showHeader = true;
        }

        PageReference massMergePage = new PageReference(
            URL.getSalesforceBaseURL().toExternalForm()
            + '/apex/SDOC__SDJobContact'
            + '?numRecordsAdded=' + String.valueOf(addToMassMerge.size()) 
            + '&batchSize=' + batchSize
            + '&objectName=' + objectName
            + '&showHeader=' + showHeader
            + '&tab=2'
        ) ;
        return massMergePage;
    }
}