Public class DataExtension_Batch implements Database.Batchable<sObject>,Database.AllowsCallouts,Database.Stateful
{
    Public boolean more{get;set;}
    Public String reqId{get;set;}
    
    public DataExtension_Batch(boolean moreParam, String reqID2)
    {
        more = moreParam;
        reqId = reqID2;
    }
    public Iterable<SObject> start(Database.BatchableContext BC)
    {
        System.debug('###START DataExtension_Batch###');
        DataExtensionManager deManager = new DataExtensionManager();
                               
        List<MC_Campaign__c> mcCampaignList = deManager.getMCCampaignRecords(label.MC_DataExtensionName,label.MC_DataExtensionColumns,more,reqId);    
        more = deManager.moreData;
        system.debug('More In start'+more);
        reqId = deManager.requestIDMore ;
        deManager = null;
        return mcCampaignList;
    }
    
    public void execute(Database.BatchableContext BC, List<MC_Campaign__c> scope)
    {
        system.debug('###EXECUTE DATAEXTENSION_BATCH### '+ scope.size());
        system.debug('More in execute' + more);
        try
        {
            if(scope.size() > 0)
            {
                upsert scope ExternalKey__c;
                scope = null;
            }
        }
        catch(Exception e)
        {
            System.debug('###ERROR### '+e.getMessage());
        }
    } 
    
    public void finish(Database.BatchableContext BC)
    {
        system.debug('More in finish' + more);
        if(!more)
        {
            System.debug('###END DATAEXTENSION_Batch###');
            DataExtension_Account batch = new DataExtension_Account();
            Database.ExecuteBatch(batch);
        }
        else
        {
            DataExtension_Batch batch = new DataExtension_Batch(more,ReqId);
            Database.ExecuteBatch(batch ,Integer.valueOf(label.MC_BatchSize));
        }
    }
}