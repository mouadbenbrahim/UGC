@isTest
public class DataExtensionManagerTest{
    // Utility method that can be called by Apex tests to create price book entries.
    static testmethod void readFromDataExtension() {       
        
        DataExtensionManager manager = new DataExtensionManager();
        
        manager.getMCCampaignRecords(label.MC_DataExtensionName,label.MC_DataExtensionColumns,false,null);
        
    }
}