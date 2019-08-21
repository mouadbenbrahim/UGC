@isTest
public class WS01_WebToCaseWithPJ_Test {
    
    @isTest
    static void HandleCasesWithEmail() {

 		Account compte = new Account();
		compte.PersonEmail = 'test@test.com'; 
        compte.FirstName = 'Prenom';
        compte.LastName = 'Nom';
        PAD.ApexForcedBypass.add ('AP01_AccountAfterInsert'); 
        PAD.ApexForcedBypass.add ('AP01_AccountAfterUpdate');
        Insert compte;
        String jsonEntry = '{"firstName": "Prenom", "lastName": "Nom", "subject": "subject", "questionConcerne": "questionConcerne", "carteNumber": "", "description": "description", "email": "test@test.com", "Pays":"FR"}';
        
        Test.startTest();
        
        //As Per Best Practice it is important to instantiate the Rest Context 
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/WebToCase';  //Request URL
        req.httpMethod = 'POST';//HTTP Request Type
        req.requestBody = Blob.valueof(jsonEntry);
        RestContext.request = req;
        RestContext.response= res;
        
        WS01_WebToCaseWithPJ.ReturnClass response = WS01_WebToCaseWithPJ.HandleCases();
        
        //System.assertEquals(response.status,'success');
        
        Test.stopTest();
        
    }
    
    @isTest
    static void HandleCasesWithCarteUI() {

 		Account compte = new Account();
		compte.PersonEmail = 'testNom@test.com'; 
        compte.LastName = 'Compte non communiqué';
		PAD.ApexForcedBypass.add ('AP01_AccountAfterInsert'); 
        PAD.ApexForcedBypass.add ('AP01_AccountAfterUpdate');
        Insert compte;
        String jsonEntry = '{"firstName": "Prenom", "lastName": "Compte non communiqué", "subject": "subject", "questionConcerne": "questionConcerne", "carteNumber": "00034543216", "description": "description", "email": "test@test.com"}';
        
        Test.startTest();
        
        //As Per Best Practice it is important to instantiate the Rest Context 
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/WebToCase';  //Request URL
        req.httpMethod = 'POST';//HTTP Request Type
        req.requestBody = Blob.valueof(jsonEntry);
        RestContext.request = req;
        RestContext.response= res;
        
        WS01_WebToCaseWithPJ.ReturnClass response = WS01_WebToCaseWithPJ.HandleCases();
        
        System.assertEquals(response.status,'delayed');
        
        Test.stopTest();    
    }
                            
    @isTest
    static void HandleCasesWithCarteFid() {

 		Account compte = new Account();
		compte.PersonEmail = 'testNom@test.com'; 
        compte.LastName = 'Compte non communiqué';
		PAD.ApexForcedBypass.add ('AP01_AccountAfterInsert');
        PAD.ApexForcedBypass.add ('AP01_AccountAfterUpdate');
        Insert compte;
        String jsonEntry = '{"firstName": "Prenom", "lastName": "Compte non communiqué", "subject": "subject", "questionConcerne": "questionConcerne", "carteNumber": "8310656454323456", "description": "description", "email": "test@test.com"}';
        
        Test.startTest();
        
        //As Per Best Practice it is important to instantiate the Rest Context 
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/WebToCase';  //Request URL
        req.httpMethod = 'POST';//HTTP Request Type
        req.requestBody = Blob.valueof(jsonEntry);
        RestContext.request = req;
        RestContext.response= res;
        
        WS01_WebToCaseWithPJ.ReturnClass response = WS01_WebToCaseWithPJ.HandleCases();
        
        //System.assertEquals(response.status,'success');
        
        Test.stopTest();    
    }

    
    
    
    
}