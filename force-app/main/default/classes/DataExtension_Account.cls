Public class DataExtension_Account implements Database.Batchable<sObject>,Database.AllowsCallouts,Database.Stateful
{

    
    public DataExtension_Account()
    {
    }
    
    public Iterable<SObject> start(Database.BatchableContext BC)
    {
        return [SELECT Contact__r.AccountId, Id FROM MC_Campaign__c WHERE Account__c = null];
    }
    
    public void execute(Database.BatchableContext BC, List<SObject> scope)
    {
        List<MC_Campaign__c> mcCampaignList = new list<MC_Campaign__c>();
        for(Integer i=0;i < scope.size(); i++)
        {
            MC_Campaign__c scopeCampaign = (MC_Campaign__c)scope.get(i);
            MC_Campaign__c campaign = new MC_Campaign__c();
            campaign.Id = scopeCampaign.Id;
            campaign.Account__c = scopeCampaign.Contact__r.AccountId;
            mcCampaignList.add(campaign);
        }
        update mcCampaignList;
    } 
    
    public void finish(Database.BatchableContext BC)
    {
    }
}