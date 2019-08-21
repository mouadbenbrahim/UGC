@IsTest
public class DisplayCases_CC_Test {
    
    private static Account account;
    private static Account account2;
    private static List<Case> cases;
    
    
    private static void init() {
    	// Account test
        account = new Account(LastName='test', FirstName='test', RecordTypeId = Utils.getComptePersonelAccountRecordType().Id, 
        	PersonEmail='test@test.test', CliEmailComplementaire__c='test@test.test', NPAIEMAIL__c = false, PNDADRESSE__c = false);
        insert account;
        
        account2 = new Account(LastName='test2', FirstName='test2', RecordTypeId = Utils.getComptePersonelAccountRecordType().Id, 
        	PersonEmail='test2@test.test', CliEmailComplementaire__c='test2@test.test', NPAIEMAIL__c = false, PNDADRESSE__c = false);
        insert account2;
        
        cases = new List<Case>();
        
        Case cse = new Case () ;
        cse.RecordTypeId =  Utils.getNouvelleDemandeClientCaseRecordType().id ;
        cse.AccountId = account.ID;
        cse.Status ='à traiter' ;
        cse.RecordTypeId = Utils.getNouvelleDemandeClientCaseRecordType().id ;
        cse.Origin = 'E-mail';
        cse.Famille__c = '6- GestionCompteUI' ;
        cse.CommentairesInternes__c = 'Case 0';
        cases.add(cse);
        
        cse = new Case () ;
        cse.RecordTypeId = Utils.getNouvelleDemandeClientCaseRecordType().id ;
        cse.AccountId = account.ID;
        cse.Status ='à traiter' ;
        cse.RecordTypeId = Utils.getNouvelleDemandeClientCaseRecordType().id ;
        cse.Origin = 'E-mail';
        cse.Famille__c ='2- Demande d\'infos générales' ;
        cse.CommentairesInternes__c = 'Case 1';
        cases.add(cse);
        
        cse = new Case () ;
        cse.RecordTypeId = Utils.getNouvelleDemandeClientCaseRecordType().id ;
        cse.AccountId = account.ID;
        cse.Status ='à traiter' ;
        cse.RecordTypeId = Utils.getNouvelleDemandeClientCaseRecordType().id ;
        cse.Origin = 'E-mail';
        cse.Famille__c ='2- Demande d\'infos générales' ;
        cse.CommentairesInternes__c = 'Case 2';
        cases.add(cse);
        
        cse = new Case () ;
        cse.RecordTypeId = Utils.getNouvelleDemandeClientCaseRecordType().id ;
        cse.AccountId = account.ID;
        cse.Status ='à traiter' ;
        cse.RecordTypeId = Utils.getNouvelleDemandeClientCaseRecordType().id ;
        cse.Origin = 'E-mail';
        cse.Famille__c ='2- Demande d\'infos générales' ;
        cse.CommentairesInternes__c = 'Case 3';
        cases.add(cse);
        
        cse = new Case () ;
        cse.RecordTypeId = Utils.getNouvelleDemandeClientCaseRecordType().id ;
        cse.AccountId = account.ID;
        cse.Status ='à traiter' ;
        cse.RecordTypeId = Utils.getNouvelleDemandeClientCaseRecordType().id ;
        cse.Origin = 'E-mail';
        cse.CommentairesInternes__c = 'Case 4';
        cases.add(cse);
        
        cse = new Case () ;
        cse.RecordTypeId = Utils.getNouvelleDemandeClientCaseRecordType().id ;
        cse.AccountId = account.ID;
        cse.Status ='à traiter' ;
        cse.RecordTypeId = Utils.getNouvelleDemandeClientCaseRecordType().id ;
        cse.Origin = 'E-mail';
        cse.CommentairesInternes__c = 'Case 5';
        cases.add(cse);
        
        cse = new Case () ;
        cse.RecordTypeId = Utils.getNouvelleDemandeClientCaseRecordType().id ;
        cse.AccountId = account.ID;
        cse.Status ='à traiter' ;
        cse.RecordTypeId = Utils.getNouvelleDemandeClientCaseRecordType().id ;
        cse.Origin = 'E-mail';
        cse.CommentairesInternes__c = 'Case 6';
        cases.add(cse);
        
        cse = new Case () ;
        cse.RecordTypeId = Utils.getNouvelleDemandeClientCaseRecordType().id ;
        cse.AccountId = account2.ID;
        cse.Status ='à traiter' ;
        cse.RecordTypeId = Utils.getNouvelleDemandeClientCaseRecordType().id ;
        cse.Origin = 'E-mail';
        cse.CommentairesInternes__c = 'Case 7';
        cases.add(cse);
        
        cse = new Case () ;
        cse.RecordTypeId = Utils.getNouvelleDemandeClientCaseRecordType().id ;
        cse.AccountId = account2.ID;
        cse.Status ='à traiter' ;
        cse.RecordTypeId = Utils.getNouvelleDemandeClientCaseRecordType().id ;
        cse.Origin = 'E-mail';
        cse.CommentairesInternes__c = 'Case 8';
        cases.add(cse);
        
        insert cases;
        
        Task task1 = new Task();
        task1.whatId = cases.get(8).Id;
        task1.subject = 'task 1';
        task1.activityDate = Date.valueOf('2017-01-01'); 
        task1.origine__c = 'Email entrant';
        insert task1;
        
        Task task2 = new Task();
        task2.whatId = cases.get(8).Id;
        task2.subject = 'task 2';
        task2.activityDate = Date.valueOf('2017-01-02');
        task2.origine__c = 'Email sortant';
        insert task2;
    }
    
    private static void compareListsInt(List<Integer> l1, List<Integer> l2) {
    	system.assertEquals(l1.size(), l2.size());
    	for(Integer i = 0; i < l1.size(); ++i) {
    		system.assertEquals(l1.get(i), l2.get(i), 'Inégalité à l\'indice ' + i);
    	}
    }
    
    @IsTest
    static void getCasesByAccountIdTest() {
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
        init();
        
        List<Integer> expectedPages = new List<Integer> {1, 2, 3};
        
    	DisplayCases_CC.CasePageWrapper res = DisplayCases_CC.getCases(account.Id, 1, 3, 'Famille__c', true, '', '');
    	compareListsInt(expectedPages, res.numberPages);
    	system.assertEquals(3, res.pageSize);
    	system.assertEquals(1, res.page);
    	system.assertEquals(3, res.cases.size());
    	system.assertEquals('E-mail', res.cases.get(0).Origin);
    	system.assertEquals(null, res.cases.get(0).Famille__c);
    	
    	res = DisplayCases_CC.getCases(account.Id, 3, 3, 'Famille__c', true, '', '');
    	
    	compareListsInt(expectedPages, res.numberPages);
    	system.assertEquals(3, res.pageSize);
    	system.assertEquals(3, res.page);
    	system.assertEquals(1, res.cases.size());
    	system.assertEquals('E-mail', res.cases.get(0).Origin);
    	system.assertEquals('2- Demande d\'infos générales', res.cases.get(0).Famille__c);
    	
    }
    
    
    @IsTest
    static void getCasesByCaseIdTest() {
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
        init();
        
        List<Integer> expectedPages = new List<Integer> {1, 2, 3};
        
    	DisplayCases_CC.CasePageWrapper res = DisplayCases_CC.getCases(cases.get(1).Id, 1, 3, 'Famille__c', false, '', '');
    	compareListsInt(expectedPages, res.numberPages);
    	system.assertEquals(3, res.pageSize);
    	system.assertEquals(1, res.page);
    	system.assertEquals(3, res.cases.size());
    	system.assertEquals('E-mail', res.cases.get(0).Origin);
    	system.assertEquals( '2- Demande d\'infos générales', res.cases.get(0).Famille__c);
    	
    	res = DisplayCases_CC.getCases(account.Id, 3, 3, 'Famille__c', false, '', '');
    	
    	compareListsInt(expectedPages, res.numberPages);
    	system.assertEquals(3, res.pageSize);
    	system.assertEquals(3, res.page);
    	system.assertEquals(1, res.cases.size());
    	system.assertEquals('E-mail', res.cases.get(0).Origin);
    	system.assertEquals(null, res.cases.get(0).Famille__c);
    	
    }
    
    @IsTest
    static void getActivitiesTest() {
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
        init();
        
        List<Task> res = DisplayCases_CC.getActivities(cases.get(8).Id);
        system.assertEquals(3, res.size());
        system.assertEquals('task 1', res.get(1).Subject);
        system.assertEquals('task 2', res.get(2).Subject);
    }
    
    @IsTest
    static void getCasesSearchTest() {
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
        init();
        
        List<Integer> expectedPages = new List<Integer> {1};
        
    	DisplayCases_CC.CasePageWrapper res = DisplayCases_CC.getCases(account.Id, 1, 3, 'Famille__c', true, 'Famille__c', 'Gestion');
    	system.debug('## DisplayCases_CC_Test ## ' + res);
    	compareListsInt(expectedPages, res.numberPages);
    	system.assertEquals(3, res.pageSize);
    	system.assertEquals(1, res.page);
    	system.assertEquals(1, res.cases.size());
    	system.assertEquals(cases.get(0).Id, res.cases.get(0).Id);
    	system.assertEquals('6- GestionCompteUI', res.cases.get(0).Famille__c);
    	
    	
    }
    
    @IsTest
    static void getCaseFieldsIdLabelsTest() {
    	Map<String, String> res = DisplayCases_CC.getCaseFieldsIdLabels();
    	system.assertEquals(6, res.size());
    	Map<String, Schema.SObjectType> GlobalMap = Schema.getGlobalDescribe();
        Schema.DescribeSObjectResult obj = GlobalMap.get('Case').getDescribe();
        Map<String, Schema.SObjectField> fieldMap = obj.fields.getMap();
        
    	system.assertEquals(fieldMap.get('CaseNumber').getDescribe().getLabel(), res.get('CaseNumber'));
    	system.assertEquals(fieldMap.get('Origin').getDescribe().getLabel(), res.get('Origin'));
    	system.assertEquals(fieldMap.get('Date_de_creation__c').getDescribe().getLabel(), res.get('Date_de_creation__c'));
    	system.assertEquals(fieldMap.get('Famille__c').getDescribe().getLabel(), res.get('Famille__c'));
    	system.assertEquals(fieldMap.get('Motif__c').getDescribe().getLabel(), res.get('Motif__c'));
    	system.assertEquals(fieldMap.get('SousMotif__c').getDescribe().getLabel(), res.get('SousMotif__c'));
    	
    }
    
    @IsTest
    static void getOriginLabelsTest() {
    	Map<String, String> res = DisplayCases_CC.getOriginLabels();
    	system.assertEquals(10, res.size());
    	System.debug('## DisplayCases_CC_Test ## labels: ' + res);
    	system.assert(res.containsKey('E-mail'));
    }
    
    @IsTest
    static void getCommentairesInternesLabelTest() {
    	String label = DisplayCases_CC.getCommentairesInternesLabel();
    	Map<String, Schema.SObjectType> GlobalMap = Schema.getGlobalDescribe();
        Schema.DescribeSObjectResult obj = GlobalMap.get('Case').getDescribe();
        Map<String, Schema.SObjectField> fieldMap = obj.fields.getMap();
        system.assertEquals(fieldMap.get('CommentairesInternes__c').getDescribe().getLabel(), label);
    	 
    }
    
    @IsTest
    static void getContactIdsTest() {
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
        init();
        DisplayCases_CC.IdsDto res = DisplayCases_CC.getContactIds(account2.Id);
        system.assertEquals(account2.id, res.accountId);
        Contact contact = [SELECT id, accountId FROM Contact where id = :res.contactId];
        system.assertEquals(account2.id, contact.accountId);
        
        res = DisplayCases_CC.getContactIds(cases.get(3).Id);
        system.assertEquals(account.id, res.accountId);
        contact = [SELECT id, accountId FROM Contact where id = :res.contactId];
        system.assertEquals(account.id, contact.accountId);
    }
}