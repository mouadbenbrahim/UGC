@IsTest()
public class Test_delete_campaign {
     static testmethod void TestDelcampaign() {

         MC_Campaign__c camp = new MC_Campaign__c();
         camp.Send_Date__c = Date.newInstance(2018, 10, 4);
  
          insert camp; 
         //Inserer l'account dans la BD
         TestHttpCalloutMock mock = new TestHttpCalloutMock();
    	 Test.setMock(HttpCalloutMock.class, mock);
     
         Test.setCreatedDate(camp.Id, Date.newInstance(2018, 4, 4));
         Test.startTest();
         
         system.debug('nb start');
         DeleteCampaignBatch batch = new DeleteCampaignBatch();
         Database.executeBatch(batch);
        
         scheduleDeleteCampagne sh1 = new scheduleDeleteCampagne();
   
         String sch = '0 0 23 * * ?';
		 system.schedule('Test Territory Check', sch, sh1);
       
         Test.stopTest();
         // Vérifier que les champs du account en question sont mis à blanc
        
    
         
      	 List<MC_Campaign__c> nb = [SELECT CreatedDate from MC_Campaign__c  where CreatedDate < LAST_N_DAYS:90]; 
         system.debug('nb ='+nb);
         System.assertEquals(0, nb.size());


         
    }
    
   
}