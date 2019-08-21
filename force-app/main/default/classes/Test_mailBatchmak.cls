@IsTest()
public class Test_mailBatchmak {

     static testmethod void TestMailBatchMak() {
         
         //  Créer un account
         system.debug('création du account');
         
         Contact contacts = new Contact();
         
         
      	 contacts.FirstName = 'Test Account'; 
         contacts.LastName = 'Test Account';
        
      	 insert contacts; 
         //Inserer l'account dans la BD
         TestHttpCalloutMock mock = new TestHttpCalloutMock();
    	 Test.setMock(HttpCalloutMock.class, mock);
		  
         
         //  Créer un case relié à l'account precedent
         Case case1 = new Case();
         
         case1.ContactId = contacts.Id;
         
         insert case1;
         
         // Vérifier si l'account et le case ont bien été créé
         System.assertEquals('Test Account', contacts.LastName);
      	 System.assertEquals(contacts.Id, case1.ContactId);
      
        
         Test.startTest();
       
          system.debug('nb start');
         mailBatchMak batch = new mailBatchMak();
         Database.executeBatch(batch);
        
         Test.stopTest();
         // Vérifier que les champs du account en question sont mis à blanc
        
        
      	 List<Contact> nb = [select Id from Contact where Email='']; 
         system.debug('nb ='+nb);
         System.assertEquals(0, nb.size());


         
    }
    
    
}