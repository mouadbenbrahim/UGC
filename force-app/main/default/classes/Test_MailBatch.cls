@IsTest()

public class Test_MailBatch {
    
 
     static testmethod void TestMailBatch() {
         
         //  Créer un account
         system.debug('création du account');
         
         Account account1 = new Account();
         
         
      	 account1.FirstName = 'Test Account'; 
         account1.LastName = 'Test Account';
         account1.PersonBirthdate = Date.newInstance(1976, 12, 9);
         account1.RecordTypeId = '0120Y000000ZZgEQAW';
         account1.CodePostal__c='94000';
         account1.PersonHomePhone='0155658899';
         account1.PersonMobilePhone='0656546323';
         account1.TelephoneBureau__c='0155668899';
      	 insert account1; 
         //Inserer l'account dans la BD
         TestHttpCalloutMock mock = new TestHttpCalloutMock();
    	 Test.setMock(HttpCalloutMock.class, mock);
		  
         
         //  Créer un case relié à l'account precedent
         Case case1 = new Case();
         
         case1.AccountId = Account1.Id;
         
         insert case1;
         
         // Vérifier si l'account et le case ont bien été créé
         System.assertEquals('Test Account', Account1.LastName);
      	 System.assertEquals(Account1.Id, case1.AccountId);
        
         // Lancer le test du batch
       
        
         Test.startTest();
       
          system.debug('nb start');
         MailBatch batch = new MailBatch();
         Database.executeBatch(batch);
        
         Test.stopTest();
         // Vérifier que les champs du account en question sont mis à blanc
        
        
      	 List<Account> nb = [select Id from Account where PersonEmail='']; 
         system.debug('nb ='+nb);
         System.assertEquals(0, nb.size());


         
    }
    
}