@IsTest()

public class Test_AccountUpdaterBatch {
    
 
     static testmethod void TestAccountUpdaterBatch() {
         
         //  Créer un account
         system.debug('création du account');
         
         Account account1 = new Account();
         
         
      	 account1.FirstName = 'Test Account'; 
         account1.LastName = 'Test Account';
         account1.PersonEmail = 'testAccount@easyfront.fr';
         account1.PersonBirthdate = Date.newInstance(1976, 12, 9);
         account1.RecordTypeId = '0120Y000000ZZgEQAW';
         account1.CodePostal__c='94000';
         account1.PersonHomePhone='0155658899';
         account1.PersonMobilePhone='0656546323';
         account1.TelephoneBureau__c='0155668899';
         account1.CliStatutRCU__c = 'Anonyme';
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
         User usr= [Select Id from User where Username = 'automate@ugc.com'];
         // Lancer le test du batch
         system.debug('user ='+usr.Id);
        
         Test.startTest();
         system.runAs(usr)
         {
         
         AccountUpdaterBatch batch = new AccountUpdaterBatch();
         Database.executeBatch(batch);
        }
        
         // Vérifier que les champs du account en question sont mis à blanc
        
        
      	List<Account> acc = [select Id, LastName, FirstName from Account]; 
         system.debug('Lastname ='+acc);
         Test.stopTest();
         
         //System.assertEquals('Anonyme', [select LastName from Account Where Id =: account1.Id].lastname);
        // System.assertEquals('', acc.FirstName);
         
           
         
         

         
         
    }
    
}