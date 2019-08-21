@isTest public class DataExtension_Account_Test {
    
    @isTest public static void testDataExtensionAccount(){
                       
        account client1 = new account();
        client1.recordTypeId =  Schema.SObjectType.Account.getRecordTypeInfosByName().get('Compte personnel').getRecordTypeId();
        //client1.segmentation__c='1';
        client1.lastname = 'test1';
        client1.PersonEmail = 'test1@test1.com';
        PAD.ApexForcedBypass.add ('AP01_AccountAfterInsert'); 
        PAD.ApexForcedBypass.add ('AP01_AccountAfterUpdate');
        PAD.ApexForcedBypass.add ('AP01_AccountBeforeInsert'); 
        PAD.ApexForcedBypass.add ('AP01_AccountBeforeUpdate');
        insert client1;
        
        MC_Campaign__c campaign = new MC_Campaign__c();
        campaign.Contact__c = client1.PersonContactId;
        insert campaign;
        
        DataExtension_Account objTest = new DataExtension_Account();   
        Database.executeBatch(objTest);
        
    }
}