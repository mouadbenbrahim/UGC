@IsTest
public class AP01_Account_Test {
	

    private static Account account;
    private static Case cse;
	
	
	private static void init() {
		Utils.createContactInconnu();
		account = new Account(LastName='test', FirstName='test', RecordTypeId = Utils.getComptePersonelAccountRecordType().Id, 
        	PersonEmail='test@test.test', CliEmailComplementaire__c='test@test.test');
        insert account;
	}
	
	@IsTest
	static void testCreateAccountClientFrance() {
		TestHttpCalloutMock mock = new TestHttpCalloutMock();
		Test.setMock(HttpCalloutMock.class, mock);
		Account acc = new Account(LastName='test', FirstName='test', RecordTypeId = Utils.getComptePersonelAccountRecordType().Id, 
        	PersonEmail='test@test.test', ClientResident__c = 'France');
        insert acc;
        Account accVerif = [SELECT Id, ClientResident__c, CodePays__c FROM Account WHERE Id = :acc.Id];
        system.assertEquals('033', accVerif.CodePays__c);
	}
	
	@IsTest
	static void testCreateAccountClientBelgique() {
		TestHttpCalloutMock mock = new TestHttpCalloutMock();
		Test.setMock(HttpCalloutMock.class, mock);
		Account acc = new Account(LastName='test', FirstName='test', RecordTypeId = Utils.getComptePersonelAccountRecordType().Id, 
        	PersonEmail='test@test.test', ClientResident__c = 'Belgique');
        insert acc;
        Account accVerif = [SELECT Id, ClientResident__c, CodePays__c FROM Account WHERE Id = :acc.Id];
        system.assertEquals('032', accVerif.CodePays__c);
	}
	
	@IsTest 
	static void testUpdateAccountParis() {
		TestHttpCalloutMock mock = new TestHttpCalloutMock();
		Test.setMock(HttpCalloutMock.class, mock);
		Commune__c ville = new Commune__c();
		ville.CodePostal__c = '75001';
		ville.Pays__c = 'FRANCE';
		ville.Tech_Commune__c = 'Paris';
		insert ville;
		Account acc = new Account(LastName='test', FirstName='test', RecordTypeId = Utils.getComptePersonelAccountRecordType().Id, 
        	PersonEmail='test@test.test');
        insert acc;
        acc.ville__c = ville.id;
        update acc;
        
        Account accVerif = [SELECT Id, CodePostal__c, Pays__c FROM Account WHERE Id = :acc.Id];
        system.assertEquals('75001', accVerif.CodePostal__c);
        system.assertEquals('FRANCE', accVerif.Pays__c);
	}
	
	@IsTest 
	static void testUpdateAccountRcu() {
		TestHttpCalloutMock mock = new TestHttpCalloutMock();
		Test.setMock(HttpCalloutMock.class, mock);
		Commune__c ville = new Commune__c();
		ville.CodePostal__c = '75001';
		ville.Pays__c = 'FRANCE';
		ville.Tech_Commune__c = 'Paris';
		insert ville;
		
		Test.startTest();
		
		Account acc = new Account(LastName='test', FirstName='test', RecordTypeId = Utils.getComptePersonelAccountRecordType().Id, 
        	PersonEmail='test@test.test', Canal_creation_Maj__c = 'RCU');
        insert acc;
        
        Account accVerif = [SELECT Id, Canal_creation_Maj__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(null, accVerif.Canal_creation_Maj__c);
        
        acc.Canal_creation_Maj__c = null;
        acc.ville__c = ville.id;
        update acc;
        
        Test.stopTest();
        
        system.assert( mock.counter > 1 ); 
	}
	
    
	@IsTest 
	static void testUpdateAccountRcuTimeout() {
		TestHttpCalloutMock mock = new TestHttpCalloutMock();
		Test.setMock(HttpCalloutMock.class, mock);
		Commune__c ville = new Commune__c();
		ville.CodePostal__c = '75001';
		ville.Pays__c = 'FRANCE';
		ville.Tech_Commune__c = 'Paris';
		insert ville;
		
		Test.startTest();
		
		Account acc = new Account(LastName='test', FirstName='test', RecordTypeId = Utils.getComptePersonelAccountRecordType().Id, 
        	PersonEmail='test@test.test', Canal_creation_Maj__c = 'RCU');
        insert acc;
        
        mock.respond = false; 
        acc.Canal_creation_Maj__c = null;
        acc.ville__c = ville.id;
        update acc;
        
        Test.stopTest();
        
        System.debug('After update: ' + acc); 
        
        
	}
    
    
	@IsTest 
	static void testUpdateAccountRcuKO() {
		TestHttpCalloutMock mock = new TestHttpCalloutMock();
		Test.setMock(HttpCalloutMock.class, mock);
		Commune__c ville = new Commune__c();
		ville.CodePostal__c = '75001';
		ville.Pays__c = 'FRANCE';
		ville.Tech_Commune__c = 'Paris';
		insert ville;
		
		Test.startTest();
		
		Account acc = new Account(LastName='test', FirstName='test', RecordTypeId = Utils.getComptePersonelAccountRecordType().Id, 
        	PersonEmail='test@test.test', Canal_creation_Maj__c = 'RCU');
        insert acc;
        
        mock.respond = false; 
        acc.Canal_creation_Maj__c = 'RCU';
        acc.ville__c = ville.id;
        update acc;
        
        Test.stopTest();
        
        System.debug('After update: ' + acc);
        
        Account accVerif = [SELECT Id, Canal_creation_Maj__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(null, accVerif.Canal_creation_Maj__c); 
        
        
	}
    
    
    
	@IsTest 
	static void testCreateAccountRcuKO() {
		TestHttpCalloutMock mock = new TestHttpCalloutMock(418, 'I\'m a teapot');
		Test.setMock(HttpCalloutMock.class, mock);

		Test.startTest();
		
		Account acc = new Account(LastName='test', FirstName='test', RecordTypeId = Utils.getComptePersonelAccountRecordType().Id, 
        	PersonEmail='test@test.test', ClientResident__c = 'France');
        insert acc;
        
        
        Test.stopTest();
        
        Account accVerif = [SELECT Id, CliStatutRCU__c
        	FROM Account WHERE Id = :acc.Id];
        
        
        
        system.assertEquals(1, mock.counter);
        system.assertEquals('En attente', accVerif.CliStatutRCU__c);
	}
	
	@IsTest
	static void testCreateAccount() {
		TestHttpCalloutMock mock = new TestHttpCalloutMock();
		Test.setMock(HttpCalloutMock.class, mock);
		Test.startTest();
		Account acc = new Account(LastName='test', FirstName='test', RecordTypeId = Utils.getComptePersonelAccountRecordType().Id, 
        	PersonEmail='test@test.test');
        insert acc;
        Test.stopTest();
        system.assertEquals(1, mock.counter);
        
	}

	@IsTest
    static void updateAccountFacebook() {
    	
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
    	init();
    	
    	cse = new Case () ;
        cse.RecordTypeId =  Utils.getNouvelleDemandeClientCaseRecordType().id ;
        cse.accountId = Utils.getContactInconnu().accountId;
        cse.Status ='à traiter' ;
        cse.TECH_idFacebook__c = 'id fb';
        insert cse;
        
        Test.startTest(); 
        account.TECH_idFacebook__c = 'id fb';
        update account;
        Test.stopTest();
        
        Case caseVerif = [SELECT Id, AccountId FROM Case where Id = :cse.Id];
        
        system.assertEquals(account.id, caseVerif.AccountId);
    }
    
    @IsTest
    static void updateAccountTwitter() {
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
    	init();
    	
    	cse = new Case () ;
        cse.RecordTypeId =  Utils.getNouvelleDemandeClientCaseRecordType().id ;
        cse.accountId = Utils.getContactInconnu().accountId;
        cse.Status ='à traiter' ;
        cse.TECH_idTwitter__c = 'id twitter';
        insert cse;
        
        Test.startTest(); 
        account.TECH_idTwitter__c = 'id twitter';
        update account;
        Test.stopTest();
        
        Case caseVerif = [SELECT Id, AccountId FROM Case where Id = :cse.Id];
        
        system.assertEquals(account.id, caseVerif.AccountId);
    }
    
    
    @IsTest
    static void updateAccountCritizr() {
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
    	init();
    	
    	cse = new Case () ;
        cse.RecordTypeId =  Utils.getNouvelleDemandeClientCaseRecordType().id ;
        cse.accountId = Utils.getContactInconnu().accountId;
        cse.Status ='à traiter' ;
        cse.TECH_idCritizr__c = 'id crit';
        insert cse;
        
        Test.startTest(); 
        account.TECH_idCritizr__c = 'id crit';
        update account;
        Test.stopTest();
        
        Case caseVerif = [SELECT Id, AccountId FROM Case where Id = :cse.Id];
        
        system.assertEquals(account.id, caseVerif.AccountId);
    }
    
    @IsTest
    static void updateAccountInstagram() {
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
    	init();
    	
    	cse = new Case () ;
        cse.RecordTypeId =  Utils.getNouvelleDemandeClientCaseRecordType().id ;
        cse.accountId = Utils.getContactInconnu().accountId;
        cse.Status ='à traiter' ;
        cse.TECH_idInstagram__c = 'id insta';
        insert cse;
    	
        Test.startTest(); 
        account.TECH_idInstagram__c = 'id insta';
        update account;
        Test.stopTest();
        
        Case caseVerif = [SELECT Id, AccountId FROM Case where Id = :cse.Id];
        
        system.assertEquals(account.id, caseVerif.AccountId);
    }
}