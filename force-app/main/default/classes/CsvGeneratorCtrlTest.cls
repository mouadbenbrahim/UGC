@IsTest
public class CsvGeneratorCtrlTest {
    
    private static RecordType caseRecordType;
    private static RecordType accRecordType;
    
    private static String famille2 = '7- Réclamations UI';
    private static String motif1 = '2- Réclamation compte UI';
    private static String sousMotif1 = '3- Continuation d\'abonnement';
    private static String sousMotif2 = '4- Plus UI' ;
    
    private static String techFam2 = 'Réclamations UI';
    private static String techMotif1 = 'réclamations compte UI';
    private static String techSousMotif1 = 'continuation d\'abonnement';
    private static String techSousMotif2 = 'Plus UI' ;
  
    static {
        // RecordType d'un Case
		caseRecordType = [SELECT id from RecordType where  IsActive =true and SobjectType ='case' and name ='Nouvelle Demande Client' ] ;
        // RecordType d'un compte 
        accRecordType = [SELECT id from RecordType where  IsActive =true and SobjectType ='account' and name ='Compte personnel' ] ;
        
    }
    
        @IsTest
    public static void testFetchCasesContactsEntrantsSansCriteres() {
    	Test.startTest();
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
        
        Account a = New Account(LastName = 'test');
        insert a;
    	Case c = new Case(AccountId = a.id);
        c.TECH_FamilleMatrice__c =famille2;
        c.TECH_MotifMatrice__c = motif1;
        c.TECH_SousMotifMatrice__c = sousMotif1;
        c.NbAppelsEntrants__c = 1;
        c.NbCritizr__c = null;
        c.NbFacebook__c = null;
        c.NbTwitter__c = null;
        insert c;
        
        Task t = new Task(WhatId = c.id, Origine__c = 'Appel Entrant');
        insert t;
        List<String[]> strings = CsvGeneratorCtrl.fetchCasesContactsEntrants(null, null, null, null);
        
        Test.stopTest();
        
        system.debug('CSV: ' + strings);
        
    } 

    
        @IsTest
    public static void testFetchCasesContactsSortantsSansCriteres() {
    	Test.startTest();
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
        
        Account a = New Account(LastName = 'test');
        insert a;
    	Case c = new Case(AccountId = a.id);
        c.TECH_FamilleMatrice__c =famille2;
        c.TECH_MotifMatrice__c = motif1;
        c.TECH_SousMotifMatrice__c = sousMotif1;
        c.NbAppelsSortants__c = 1;
        c.NbCritizr__c = null;
        c.NbFacebook__c = null;
        c.NbTwitter__c = null;
        insert c;
        
        Task t = new Task(WhatId = c.id, Origine__c = 'Appel Sortant');
        insert t;
        List<String[]> strings = CsvGeneratorCtrl.fetchCasesContactsSortants(null, null, null, null);
        
        Test.stopTest();
        
        system.debug('CSV: ' + strings);
        
    } 
    
        @IsTest
    public static void testFetchCasesContactsSortantsAvecCriteres() {
    	Test.startTest();
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
        
        Account a = New Account(LastName = 'test');
        insert a;
    	Case c = new Case(AccountId = a.id);
        c.TECH_FamilleMatrice__c =famille2;
        c.TECH_MotifMatrice__c = motif1;
        c.TECH_SousMotifMatrice__c = sousMotif1;
        c.NbCourriersSortants__c = 1;
        insert c;
        
        Task t = new Task(WhatId = c.id, Origine__c = 'Courrier Sortant');
        insert t;
        List<String[]> strings = CsvGeneratorCtrl.fetchCasesContactsSortants('10-10-2017', '05-12-2018', 'oui', null);
        
        Test.stopTest();
        
        system.debug('CSV: ' + strings);
        
    } 
    
        @IsTest
    public static void testfetchCasesFluxInternesSansCriteres() {
    	Test.startTest();
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
  		        
        Account a = New Account(LastName = 'test');
        insert a;
    	Case c = new Case(AccountId = a.id);
        c.TECH_FamilleMatrice__c =famille2;
        c.TECH_MotifMatrice__c = motif1;
        c.TECH_SousMotifMatrice__c = sousMotif1;
        c.Origin = 'Salle';
        insert c;
        
        List<String[]> strings = CsvGeneratorCtrl.fetchCasesFluxInternes('01-06-2017', '20-12-2018', null, null);
        
        Test.stopTest();
        
        system.debug('CSV: ' + strings);
    }
    
       @IsTest
    	public static void testFetchCourriersAutoSortants() {  
        Account accountUgc = new Account(LastName='test', FirstName='test', RecordTypeId = accRecordType.ID, 
        	PersonEmail='test@test.test', CliEmailComplementaire__c='test@test.test', NPAIEMAIL__c = false, 
        	PNDADRESSE__c = false, NoCarteUI__c='carte', ProduitUGC__c='français');
        SDOC__SDTemplate__c template1 = new SDOC__SDTemplate__c(Name='template PDF', SDOC__Template_Format__c='PDF');
        insert template1;
    	Case cse = new Case () ;
        cse.TECH_FamilleMatrice__c = famille2 ;
        cse.TECH_MotifMatrice__c = motif1 ;
        cse.TECH_SousMotifMatrice__c = sousMotif1 ;
        cse.accountId = accountUgc.Id;
        cse.Origin = 'Courrier Sortant';
        insert cse;
        
        SDOC__SDoc__c sdoc1 = new SDOC__SDoc__c();
        sdoc1.SDOC__SDTemplate__c = template1.Id;
        insert sdoc1;
        
        SDOC__SDRelationship__c rel1 = new SDOC__SDRelationship__c();
        rel1.SDOC__SDoc__c = sdoc1.Id;
        rel1.SDOC__Case__c = cse.id;
        insert rel1;
  
    	Test.startTest();
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
           
		CsvGeneratorCtrl.fetchCourriersAutoSortants(null, null, null, null);
		Test.stopTest();
    }
    

       
}