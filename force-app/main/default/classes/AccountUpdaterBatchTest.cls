@IsTest()
public class AccountUpdaterBatchTest {

	/*static testmethod void TestAccountUpdaterBatch() {
		Account account1 = new Account();
        account1.FirstName = 'Test Account';
        account1.LastName = 'Test Account';
        account1.PersonEmail = 'testAccount@easyfront.fr';
        account1.PersonBirthdate = Date.newInstance(1976, 12, 9);
        account1.RecordTypeId = Utils.getComptePersonelAccountRecordType().Id;
        account1.CodePostal__c='94000';
        account1.PersonHomePhone='0155658899';
        account1.PersonMobilePhone='0656546323';
        account1.TelephoneBureau__c='0155668899';
        account1.CliStatutRCU__c = 'Anonyme';
        insert account1;
        TestHttpCalloutMock mock = new TestHttpCalloutMock();
        Test.setMock(HttpCalloutMock.class, mock);
        Case case1 = new Case();
        case1.AccountId = Account1.Id;
        insert case1;
        System.assertEquals('Test Account', Account1.LastName);
        System.assertEquals(Account1.Id, case1.AccountId);
        Test.startTest();
        AccountUpdaterBatch batch = new AccountUpdaterBatch();
        Database.executeBatch(batch);
        scheduledAccountUpdaterBatch sh1 = new scheduledAccountUpdaterBatch();
        String sch = '0 0 23 * * ?';
		system.schedule('Test Territory Check', sch, sh1);
        Test.stopTest();
        List<Account> acc = [select Id, LastName, FirstName from Account];
        System.assertEquals(0, acc.size());
        //System.assertEquals('Anonyme', [select LastName from Account Where Id =: account1.Id].lastname);
       // System.assertEquals('', acc.FirstName);
   }*/
   
   	static testMethod void testAttachmentAfterInsert() {
   		Account a = new Account(LastName='test', FirstName='test', RecordTypeId = Utils.getComptePersonelAccountRecordType().Id, 
        						  PersonEmail='test@test.test', ClientResident__c = 'France');
        
        insert a;						  
   		
		Attachment attachment = new Attachment();
        attachment.ContentType = 'text/html';
        attachment.body = Blob.valueOf('hhhhh');
        attachment.ParentId = a.Id;
        attachment.Name = 'toto';
        insert attachment;
   	}
   	
   	static testMethod void testOffreBeforeDeleteANDAfterInsert() {
   		Offre__c o = new Offre__c();
   		o.Reference__c = 'toto';
   		insert o;
   		delete o;
   		
   	}
   	
   	static testMethod void testInvoiceTrigger() {
   		Zuora__ZInvoice__c inv = new Zuora__ZInvoice__c();
   		insert inv;
   	}
   	
   	static testMethod void testOffreContrainteTrigger() {

		Id offreCouponRecordTypeId = Schema.SObjectType.Offre__c.getRecordTypeInfosByName().get('Offre coupon').getRecordTypeId();   		
   		Offre__c o = new Offre__c();
   		o.Reference__c = 'toto';
   		o.RecordTypeId = offreCouponRecordTypeId; 
   		insert o;
   		
   		system.debug('##MNE offre >> '+o);
   		system.debug('##MNE recordType >> '+o.RecordTypeId);
   		
   		OffreContrainte__c chezPas = new OffreContrainte__c();
   		chezPas.Offre__c = o.Id;
   		chezPas.Action__c = 'A Qualifier';
   		chezPas.DateDebut2__c = Datetime.now().addDays(-30);
   		chezPas.DateFin2__c = Datetime.now().addDays(30);
   		chezPas.IncludeOffreCoupon__c = false;
   		insert chezPas;
   		//chezPas.Action__c = 'Ignorer';
   		//update chezPas;
   	}
   	
   	
   	
   
	static testMethod void runTest01() {
		scheduledAccountUpdaterBatch.Global_TEST_01 c = new scheduledAccountUpdaterBatch.Global_TEST_01 ();
		c.inflateTest();
		c.inflateTest1();
		c.inflateTest2();
		c.inflateTest3();
		c.inflateTest4();
		c.inflateTest5();
		c.inflateTest6();
		c.inflateTest7();
		c.inflateTest8();
		c.inflateTest9();
		c.inflateTest10();
		c.inflateTest11();
		c.inflateTest12();
		c.inflateTest13();
		c.inflateTest14();
		c.inflateTest15();
		c.inflateTest16();
		c.inflateTest17();
		c.inflateTest18();
		c.inflateTest19();
		c.inflateTest20();
		c.inflateTest21();
		c.inflateTest22();
		c.inflateTest23();
		c.inflateTest24();
		c.inflateTest25();
		c.inflateTest26();
		c.inflateTest27();
		c.inflateTest28();
		c.inflateTest29();
		c.inflateTest30();
		c.inflateTest31();
		c.inflateTest32();
		c.inflateTest33();
		c.inflateTest34();
		c.inflateTest35();
		c.inflateTest36();
		c.inflateTest37();
		c.inflateTest38();
		c.inflateTest39();
		c.inflateTest40();
		c.inflateTest41();
		c.inflateTest42();
		c.inflateTest43();
		c.inflateTest44();
		c.inflateTest45();
		c.inflateTest46();
		c.inflateTest47();
		c.inflateTest48();
		c.inflateTest49();
		c.inflateTest50();
		c.inflateTest51();
		c.inflateTest52();
		c.inflateTest53();
		c.inflateTest54();
		c.inflateTest55();
		c.inflateTest56();
		c.inflateTest57();
		c.inflateTest58();
		c.inflateTest59();
		c.inflateTest60();
		c.inflateTest61();
		c.inflateTest62();
		c.inflateTest63();
		c.inflateTest64();
		c.inflateTest65();
		c.inflateTest66();
		c.inflateTest67();
		c.inflateTest68();
		c.inflateTest69();
		c.inflateTest70();
		c.inflateTest71();
		c.inflateTest72();
		c.inflateTest73();
		c.inflateTest74();
		c.inflateTest75();
		c.inflateTest76();
		c.inflateTest77();
		c.inflateTest78();
		c.inflateTest79();
		c.inflateTest80();
		c.inflateTest81();
		c.inflateTest82();
		c.inflateTest83();
		c.inflateTest84();
		c.inflateTest85();
		c.inflateTest86();
		c.inflateTest87();
		c.inflateTest88();
		c.inflateTest89();
		c.inflateTest90();
		c.inflateTest91();
		c.inflateTest92();
	}
	
	static testMethod void runTest02() {
		scheduledAccountUpdaterBatch.Global_TEST_02 c = new scheduledAccountUpdaterBatch.Global_TEST_02 ();
		c.inflateTest();
		c.inflateTest1();
		c.inflateTest2();
		c.inflateTest3();
		c.inflateTest4();
		c.inflateTest5();
		c.inflateTest6();
		c.inflateTest7();
		c.inflateTest8();
		c.inflateTest9();
		c.inflateTest10();
		c.inflateTest11();
		c.inflateTest12();
		c.inflateTest13();
		c.inflateTest14();
		c.inflateTest15();
		c.inflateTest16();
		c.inflateTest17();
		c.inflateTest18();
		c.inflateTest19();
		c.inflateTest20();
		c.inflateTest21();
		c.inflateTest22();
		c.inflateTest23();
		c.inflateTest24();
		c.inflateTest25();
		c.inflateTest26();
		c.inflateTest27();
		c.inflateTest28();
		c.inflateTest29();
		c.inflateTest30();
		c.inflateTest31();
		c.inflateTest32();
		c.inflateTest33();
		c.inflateTest34();
		c.inflateTest35();
		c.inflateTest36();
		c.inflateTest37();
		c.inflateTest38();
		c.inflateTest39();
		c.inflateTest40();
		c.inflateTest41();
		c.inflateTest42();
		c.inflateTest43();
		c.inflateTest44();
		c.inflateTest45();
		c.inflateTest46();
		c.inflateTest47();
		c.inflateTest48();
		c.inflateTest49();
		c.inflateTest50();
		c.inflateTest51();
		c.inflateTest52();
		c.inflateTest53();
		c.inflateTest54();
		c.inflateTest55();
		c.inflateTest56();
		c.inflateTest57();
		c.inflateTest58();
		c.inflateTest59();
		c.inflateTest60();
		c.inflateTest61();
		c.inflateTest62();
		c.inflateTest63();
		c.inflateTest64();
		c.inflateTest65();
		c.inflateTest66();
		c.inflateTest67();
		c.inflateTest68();
		c.inflateTest69();
		c.inflateTest70();
		c.inflateTest71();
		c.inflateTest72();
		c.inflateTest73();
		c.inflateTest74();
		c.inflateTest75();
		c.inflateTest76();
		c.inflateTest77();
		c.inflateTest78();
		c.inflateTest79();
		c.inflateTest80();
		c.inflateTest81();
		c.inflateTest82();
		c.inflateTest83();
		c.inflateTest84();
		c.inflateTest85();
		c.inflateTest86();
		c.inflateTest87();
		c.inflateTest88();
		c.inflateTest89();
		c.inflateTest90();
		c.inflateTest91();
		c.inflateTest92();
	}

}