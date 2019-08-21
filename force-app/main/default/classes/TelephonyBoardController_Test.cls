/**
 * Created by Valera on 09.10.2017.
 */

@IsTest
private class TelephonyBoardController_Test {
    private static TelephonyBoardController telephonyBoardController;
    public static String responseAuthorize = '{' +
            '	\"access_token\": \"eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0dCI6IlRlc3RDb21wYW55IiwicHAiOiJ7XC JycGxcIjp7fX0iLCJjaSI6MjAwMDAsInNjb3BlIjpbInNhbGVzZm9yY2UtYXBpIl0sImV4cCI6M TUwNTE1NzY5NSwianRpIjoiMmI5MmE4ZjctNDc1Ny00MWIyLTg3MzgtYWQ1MDI1YmY5 MzYyIiwiYXV0aG9yaXRpZXMiOlsiUk9MRV9TQUxFU0ZPUkNFIl0sImNsaWVudF9pZCI6Ij d5WTVSRUtzIn0.nzt72QYCiJ-qk8lSwRPx_9bmSDnsdTFKlY2ZMciOQnYvlfrE7ZkxcPLI4U Jr0YHHYY9s5XcPiG6v-eqYmeYHJycxdU3VtHo6JdBtoy3-AWgU79ggeC6POM7gxHV65D XcNZ7cTR9cFpkN7tAYUmwtSgZC4d7VE48bhy5z0-ttSzwix4tGJTNccYZ7Jkx8lfDe5bIBK7 j_rNhxvllGT4gGjGykAMXHMmP3y5FoljXnefc0GOlqEeOGPaMnQNJxTrR32r9t784r0itzZc giCDGq4xRhQA009rxwmonDw2Rq9UAT-evsfrIByrUZSRY-w5zShBXU68KTKJzj5q7JIpR2 RA\",' +
            '	\"token_type\": \"bearer\",' +
            '	\"expires_in\": 43199,' +
            '	\"scope\": \"salesforce-api\"' +
            '}';
    public static String responseEmptyToken = '{' +
            '	\"access_token\": \"\",' +
            '	\"token_type\": \"bearer\",' +
            '	\"expires_in\": 43199,' +
            '	\"scope\": \"salesforce-api\"' +
            '}';
    public static String checkCredBody = ' {"error": false,"agentid": 1023308}';


    private static testMethod void testChangeComponents() {
        telephonyBoardController = new TelephonyBoardController();
        telephonyBoardController.showComponentsForNotAvailable();
        telephonyBoardController.showComponentsForAvailable();
        telephonyBoardController.showComponentsForIncommingCallWith0();
        telephonyBoardController.showComponentsForIncommingCallWith1();
        telephonyBoardController.showComponentsForIncommingCallWithMulty();
    }

    private static testMethod void testAuthorization() {
        try {
            initDBAuth();
            CalloutService_Test.GeneralRequestMock clients = new CalloutService_Test.GeneralRequestMock(200, 'OK', CalloutService_Test.responseAuthorize, null);
            Test.setMock(HttpCalloutMock.class, clients);
            TelephonyBoardController authorization = new TelephonyBoardController();
            Test.startTest();
            authorization.authorization(Credentials__c.getInstance(UserInfo.getUserId()), Credentials__c.getOrgDefaults());
            Test.stopTest();
        } catch (MyCustomException e) {
            System.assertEquals(e.getMessage(), 'Empty credentials');

        }
    }

    private static testMethod void testAuthorizationError() {
        try {
            CalloutService_Test.initTestData();
            CalloutService_Test.GeneralRequestMock clients = new CalloutService_Test.GeneralRequestMock(201, 'OK', CalloutService_Test.responseAuthorize, null);
            Test.setMock(HttpCalloutMock.class, clients);
            TelephonyBoardController authorization = new TelephonyBoardController();
            Test.startTest();
            authorization.authorization(Credentials__c.getInstance(UserInfo.getUserId()), Credentials__c.getOrgDefaults());
            Test.stopTest();
        } catch (MyCustomException e) {
            System.assertEquals(e.getMessage(), 'Code : 201Status : OK');
        }
    }

    private static testMethod void testRerenderComponents() {

        TelephonyBoardController telephonyBoardController = new TelephonyBoardController();
        String testExaple = '{' +
                '  \"sf\": {' +
                '    \"organization_id\":\"00D0Y0000033AJeUAM\",' +
                '    \"user_id\":\"0050Y000002rKOGQA2\",' +
                '    \"searchRecords\": [{"Id":"00Q0Y000007V9wi"},{"Id":"0010Y00000cegkX"}]' +
                '  }' +
                '}';
        telephonyBoardController.infoCallForPage = CaseIncomingCall.parse(testExaple);
        telephonyBoardController.rerenderComponentsForInOutCall(testExaple);
        testExaple = '{' +
                '  \"sf\": {' +
                '    \"organization_id\":\"00D0Y0000033AJeUAM\",' +
                '    \"user_id\":\"0050Y000002rKOGQA2\",' +
                '    \"searchRecords\": [{"Id":"00Q0Y000007V9wi"}]' +
                '  }' +
                '}';
        telephonyBoardController.infoCallForPage = CaseIncomingCall.parse(testExaple);
        telephonyBoardController.rerenderComponentsForInOutCall(testExaple);
        testExaple = '{' +
                '  \"sf\": {' +
                '    \"organization_id\":\"00D0Y0000033AJeUAM\",' +
                '    \"user_id\":\"0050Y000002rKOGQA2\",' +
                '    \"searchRecords\": []' +
                '  }' +
                '}';
        telephonyBoardController.infoCallForPage = CaseIncomingCall.parse(testExaple);
        telephonyBoardController.rerenderComponentsForInOutCall(testExaple);
    }

    private static testMethod void testCreateUrlForBanner() {
        telephonyBoardController = new TelephonyBoardController();
        Map<String, String> dataFromCustomSetting = initData();
        String actualy = telephonyBoardController.createUrlForBanner(dataFromCustomSetting);
        System.assertEquals(actualy, 'BannerUrlitem=autolog&login=Username&password=Password&popup=false&lang=en');
    }

    private static testMethod void testGetStatusPolling() { 
        CalloutService_Test.initTestData();
        paternForTestPolling(CaseIncomingCall_Test.json);
    }

    private static testMethod void testGetStatusPollingThrowMyException() {
        paternForTestPolling(CaseIncomingCall_Test.json);
    }

    private static testMethod void testGetStatusPollingThrowException() {
        CalloutService_Test.initTestData();
        paternForTestPolling(CalloutService_Test.responseBody);
    }

    private static testMethod void testDefineError() {
        telephonyBoardController = new TelephonyBoardController();
        telephonyBoardController.showError(new MyCustomException(Authorization.ERROR_AUTHORIZATION_POLLING));
        telephonyBoardController.showError(new MyCustomException('Empty credentials - getBanerCredentials()'));
        telephonyBoardController.showError(new MyCustomException('Test Message'));
        telephonyBoardController.showError(new JSONException('Test Message'));
    }

    private static testMethod void testOnCall() {
        initDB();
        String json = '{' +
                '  \"sf\": {' +
                '    \"organization_id\":\"00D0Y0000033AJeUAM\",' +
                '    \"user_id\":\"0050Y000002rKOGQA2\",' +
                '    \"searchRecords\": []' +
                '  },' +
                '  \"agent\": {' +
                '    \"id\": \"1003203\",' +
                '    \"sda\": \"0123456789\",' +
                '    \"status\": \"8\",' +
                '    \"name\": \"John Doe\",' +
                '    \"change_time\": \"2017-09-08 17:51:38\"' +
                '  },' +
                '  \"call\": {' +
                '    \"callid\": \"V44200717090800ffcba\",' +
                '    \"start_time\": \"2017-09-08 17:51:38\",' +
                '    \"agent_uid\": \"1003203\",' +
                '    \"status\": \"3\",' +
                '    \"change_time\": \"2017-09-08 17:51:38\",' +
                '    \"service_uid\": \"11089\",' +
                '    \"group_uid\": \"55522\",' +
                '    \"product_uid\": \"1\",' +
                '    \"sda\": \"0177453000\",' +
                '    \"ref\": \"Call test\"' +
                '  }' +
                '}';
        telephonyBoardController = new TelephonyBoardController();
        telephonyBoardController.infoCallForPage = CaseIncomingCall.parse(json);
//        telephonyBoardController.onCall(json);
    }

    private static testMethod void testMakeOutboundCallMyCustomException() {
        try {
            CalloutService_Test.initTestData();
            TelephonyBoardController telephonyBoardController = new TelephonyBoardController();
            telephonyBoardController.token = 'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0dCI6IlZpYWRpYWxvZyIsImNpIjoxMDIwMCwic2NvcGUiOlsic2FsZXNmb3JjZS1hcGkiXSwiZXhwIjoxNTA3NzU5NzA3LCJqdGkiOiI0YjRjZWQ3Yy04NTg2LTQ1YzEtYjJmNy03NzFhZjZlZGZmMGQiLCJhdXRob3JpdGllcyI6WyJST0xFX1NBTEVTRk9SQ0UiXSwiY2xpZW50X2lkIjoiN3lZNVJFS3MifQ.cZlGpGrX1_QhPpFB4Tn8PBQkA0IHIRIGd6ZpSxxlDaVUgHVTb56LWArIa8N9b3T4BBJcAaMiWy80NxGnWISXnGbu8aNwKfCVzXBL3tfc_81OZDYrg8YZuqoVPygt7_zwxqY0QWtj-2jJHN9ycGF7und2lRvA7_iHHJc5a5SM0Z31ukx9M3XoctRH3W1HMqb7sHLBZfYxM2Wkph8SIEy_peTeS5bxVruWBrerDTKThAIuNPIXHsZhValhWdN_3MdRebvZs7JbAuUnVnSnMsp56fWqdFOP16fLCWx3b2_jefdIVi21enIvaeP3EXF5pzWmPGhasau2Pvmhqc_5Vm_Lgw';
            TelephonyBoardController.clickToDailResponse = '{"number":"(098) 407-3751","objectId":"' + contactInuit() + '","objectName":"TestAccPhone1","object":"Account","displayName":"Account"}';
            TelephonyBoardController.statusContext.st = (StatusManager.Status) Type.forName('StatusManager.Status1').newInstance();
            CalloutService_Test.GeneralRequestMock clients = new CalloutService_Test.GeneralRequestMock(200, 'OK', '', null);
            Test.setMock(HttpCalloutMock.class, clients);
            Test.startTest();
            telephonyBoardController.makeOutboundCall();
            Test.stopTest();
        } catch (MyCustomException e) {
            System.assertEquals(e.getMessage(), 'Please, full creds in User object');
        }
    }

    private static testMethod void testSetMatchContacts() {
        telephonyBoardController = new TelephonyBoardController();
        initDataForSetMatchedContacts();
        List<Contact> contacts = allRecords('Contact');
        telephonyBoardController.setMatchedContacts(contacts.get(0).Id);
    }

    private static testMethod void testAuthorizationMethod() {
        initDBAuth();
        Authorization authoriz = new Authorization();
        TelephonyBoardController telephonyBoardCont = new TelephonyBoardController();
        authoriz.isNewToken = true;
        setMocksForAuthorization(responseAuthorize);
        Test.startTest();
        telephonyBoardCont.authorization();
        Test.stopTest();
    }

    private static testMethod void testauthorizatioVTMethod() {
        initDBAuth();
        Authorization authoriz = new Authorization();
        TelephonyBoardController telephonyBoardCont = new TelephonyBoardController();
        authoriz.isNewToken = true;
        Credentials__c orgCred = Credentials__c.getOrgDefaults();
        Credentials__c userCred = Credentials__c.getInstance(UserInfo.getUserId());
        setMocksForAuthorization(responseAuthorize);
        Test.startTest();
        telephonyBoardCont.authorization(userCred,orgCred);
        Test.stopTest();
    }

    private static testMethod void testAuthorizationethodErrorAggentId() {
        try {
            initDBAuth();
            Authorization authoriz = new Authorization();
            TelephonyBoardController telephonyBoardCont = new TelephonyBoardController();
            authoriz.isNewToken = true;
            User user = [SELECT id, Agent_id__c FROM User WHERE id = :UserInfo.getUserId() LIMIT 1];
            user.Agent_id__c = null;
            update user;
            setMocksForAuthorization(responseAuthorize);
            Test.startTest();
            telephonyBoardCont.authorization();
            Test.stopTest();
        }catch (MyCustomException e){
            System.assertEquals(e.getMessage(), 'Invalid login Id, token, or incorect banner url');
        }
    }

    private static testMethod void testAuthorizationethodErrorToken() {
        try {
            initDBAuth();
            Authorization authoriz = new Authorization();
            TelephonyBoardController telephonyBoardCont = new TelephonyBoardController();
            authoriz.isNewToken = true;
            setMocksForAuthorization(responseEmptyToken);
            Test.startTest();
            telephonyBoardCont.authorization();
            Test.stopTest();
        }catch (MyCustomException e){
            System.assertEquals(e.getMessage(), 'Tokent is empty');
        }
    }

    private static testMethod void testShowError(){
        try {
            telephonyBoardController = new TelephonyBoardController();
            telephonyBoardController.showError('test Error');
        }catch (Exception e){
            System.assertEquals(e.getMessage(), 'test Error');

        }
    }

    private static void initDBAuth() {
        Credentials__c orgCred = Credentials__c.getOrgDefaults();
        Credentials__c userCred = Credentials__c.getInstance(UserInfo.getUserId());
        User user = [SELECT id, Agent_id__c FROM User WHERE id = :UserInfo.getUserId() LIMIT 1];
        orgCred.Token_Part1__c = 'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0dCI6IlZpYWRpYWxvZyIsImNpIjoxMDIwMCwic2NvcGUiOlsic2FsZXNmb3JjZS1hcGkiXSwiZXhwIjoxNTA4NDQ1ODc0LCJqdGkiOiIxN2RkYmUwYi1iNjg0LTQ5YzktOTkyMC02YjQyYmYwNjgwOTciLCJhdXRob3J';
        orgCred.Token_Part2__c = 'pdGllcyI6WyJST0xFX1NBTEVTRk9SQ0UiXSwiY2xpZW50X2lkIjoiN3lZNVJFS3MifQ';
        orgCred.Token_Part3__c = 'w0Alt3dE1EjsWKYf_NfjL0Wazadkee3o3EscMHaDe6dchN75dojIjCDqhr3d9xSwffSfwa_5NZTxcg7BhDgWuznsor5kxHNqcywi_nUrDl0ABZlzBUM12s_x_mSm6ja53TCFQSjfbQs9bZWjEAPhXeZc23';
        orgCred.Slug_Polling__c = 'viadialog';
        orgCred.Password_Polling__c = 'Ung$R974hc';
        orgCred.Scope__c = 'salesforce-api';
        orgCred.Viadialog_Url__c = 'http://salesforce.viadialog.com/';
        orgCred.banerUrl__c = 'http://ccv.viatelecom.com/services/?';
        orgCred.Grant_Type__c = 'client_credentials';
        orgCred.Access_Token__c = 'Basic N3lZNVJFS3M6RjY4QnJzNXdUTWFYQ1BTekdIN3lYVk5IQ2VZa3gyZng=N3lZNVJFS3M6RjY4QnJzNXdUTWFYQ1BTekdIN3lYVk5IQ2VZa3gyZng=';
        userCred.Password__c = '123456';
        userCred.Username__c = 'Ikumbitest';
        user.Agent_id__c = '1023308';
        update user;
        upsert orgCred;
        upsert userCred;
    }

    private static void setMocksForAuthorization(String token) {
        CalloutService_Test.GeneralRequestMock checkBanner = new CalloutService_Test.GeneralRequestMock(200, 'OK', checkCredBody, null);
        CalloutService_Test.GeneralRequestMock polling = new CalloutService_Test.GeneralRequestMock(200, 'OK', token, null);
        Map<String, HttpCalloutMock> callout_mocks = new Map<String, HttpCalloutMock>();
        callout_mocks.put('http://salesforce.viadialog.com/check/', checkBanner);
        callout_mocks.put('http://salesforce.viadialog.com/uaa/oauth/token', polling);
        HttpCalloutMock multi_callout_mock = new CalloutService_Test.BulkMockGenerator(callout_mocks);
        Test.setMock(HttpCalloutMock.class, multi_callout_mock);
    }

    private static void paternForTestPolling(String jsonBody) {
        TelephonyBoardController telephonyBoardController = new TelephonyBoardController();
        CalloutService_Test.GeneralRequestMock clients = new CalloutService_Test.GeneralRequestMock(200, 'OK', jsonBody, null);
        Test.setMock(HttpCalloutMock.class, clients);
        telephonyBoardController.agentId = '1023308';
        telephonyBoardController.token = 'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0dCI6IlZpYWRpYWxvZyIsImNpIjoxMDIwMCwic2NvcGUiOlsic2FsZXNmb3JjZS1hcGkiXSwiZXhwIjoxNTA3NzU5NzA3LCJqdGkiOiI0YjRjZWQ3Yy04NTg2LTQ1YzEtYjJmNy03NzFhZjZlZGZmMGQiLCJhdXRob3JpdGllcyI6WyJST0xFX1NBTEVTRk9SQ0UiXSwiY2xpZW50X2lkIjoiN3lZNVJFS3MifQ.cZlGpGrX1_QhPpFB4Tn8PBQkA0IHIRIGd6ZpSxxlDaVUgHVTb56LWArIa8N9b3T4BBJcAaMiWy80NxGnWISXnGbu8aNwKfCVzXBL3tfc_81OZDYrg8YZuqoVPygt7_zwxqY0QWtj-2jJHN9ycGF7und2lRvA7_iHHJc5a5SM0Z31ukx9M3XoctRH3W1HMqb7sHLBZfYxM2Wkph8SIEy_peTeS5bxVruWBrerDTKThAIuNPIXHsZhValhWdN_3MdRebvZs7JbAuUnVnSnMsp56fWqdFOP16fLCWx3b2_jefdIVi21enIvaeP3EXF5pzWmPGhasau2Pvmhqc_5Vm_Lgw';
        Test.startTest();
        telephonyBoardController.getStatusPolling();
        Test.stopTest();
    }

    private static List<SObject> allRecords(String obj) {
        String queryAllRecords = 'SELECT Id, LastName, FirstName FROM ' + obj;
        System.debug('queryAllRecords: ' + queryAllRecords);
        return Database.query(queryAllRecords);
    }

    private static void initDataForSetMatchedContacts() {
        Contact contact1 = new Contact(LastName = 'Last_Test_1', FirstName = 'First_Test_1');
        insert contact1;
        Account account1 = new Account(Name = 'Test_1');
        insert account1;
        Lead lead1 = new Lead(LastName = 'Last_Test_1', FirstName = 'First_Test_1', Status = 'Open - Not Contacted', Company = 'Company_Test');
        insert lead1;
    }

    static Map<String, String> initData() {
        Map<String, String> dataFromCustomSetting = new Map<String, String>();
        dataFromCustomSetting.put('Password', 'Password');
        dataFromCustomSetting.put('Username', 'Username');
        dataFromCustomSetting.put('BannerUrl', 'BannerUrl');
        return dataFromCustomSetting;
    }

    static void initDB() {
        Contact contact1 = new Contact(LastName = 'Test Contact1');
        Contact contact2 = new Contact(LastName = 'Test Contact2');
        insert contact1;
        insert contact2;
        Event event = new Event(Subject = 'Call', StartDateTime = Datetime.now(), EndDateTime = Datetime.now().addMinutes(2), Call_External_Id__c = 'V44200717090800ffcba');
        insert event;
    }

    static void initDBContextWhoId() {
        Contact contact1 = new Contact(LastName = 'Test Contact1');
        insert contact1;
        Event event = new Event(Subject = 'Call', StartDateTime = Datetime.now(), EndDateTime = Datetime.now().addMinutes(2), Call_External_Id__c = 'V44200717090800ffcba', WhoId = contact1.Id);
        insert event;
    }

    static void initDBContextWhatId() {
        Account account = new Account(Name = 'Test Account');
        insert account;
        Event event = new Event(Subject = 'Call', StartDateTime = Datetime.now(), EndDateTime = Datetime.now().addMinutes(2), Call_External_Id__c = 'V44200717090800ffcba', WhatId = account.Id);
        insert event;
    }

    static Id contactInuit() {
        Contact contact = new Contact(LastName = 'Test');
        insert contact;
        return contact.Id;
    }

}