/**
 * Created by Valera on 02.10.2017.
 */

@IsTest
private class LoginPageController_Test {

    public static String responseAuthorize = '{' +
            '	\"access_token\": \"eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0dCI6IlRlc3RDb21wYW55IiwicHAiOiJ7XC JycGxcIjp7fX0iLCJjaSI6MjAwMDAsInNjb3BlIjpbInNhbGVzZm9yY2UtYXBpIl0sImV4cCI6M TUwNTE1NzY5NSwianRpIjoiMmI5MmE4ZjctNDc1Ny00MWIyLTg3MzgtYWQ1MDI1YmY5 MzYyIiwiYXV0aG9yaXRpZXMiOlsiUk9MRV9TQUxFU0ZPUkNFIl0sImNsaWVudF9pZCI6Ij d5WTVSRUtzIn0.nzt72QYCiJ-qk8lSwRPx_9bmSDnsdTFKlY2ZMciOQnYvlfrE7ZkxcPLI4U Jr0YHHYY9s5XcPiG6v-eqYmeYHJycxdU3VtHo6JdBtoy3-AWgU79ggeC6POM7gxHV65D XcNZ7cTR9cFpkN7tAYUmwtSgZC4d7VE48bhy5z0-ttSzwix4tGJTNccYZ7Jkx8lfDe5bIBK7 j_rNhxvllGT4gGjGykAMXHMmP3y5FoljXnefc0GOlqEeOGPaMnQNJxTrR32r9t784r0itzZc giCDGq4xRhQA009rxwmonDw2Rq9UAT-evsfrIByrUZSRY-w5zShBXU68KTKJzj5q7JIpR2 RA\",' +
            '	\"token_type\": \"bearer\",' +
            '	\"expires_in\": 43199,' +
            '	\"scope\": \"salesforce-api\"' +
            '}';

    static testMethod void testTrueResult() {
        LoginPageController loginController =  new LoginPageController();
        CalloutService_Test.initTestData();
        CalloutService_Test.GeneralRequestMock clients = new CalloutService_Test.GeneralRequestMock(200, 'OK', responseAuthorize, null);
        Test.setMock(HttpCalloutMock.class, clients);
        Test.startTest();
        loginController.telephonyBoard = new TelephonyBoardController();
        loginController.login = Credentials__c.getInstance(UserInfo.getUserId()).Username__c;
        loginController.password = Credentials__c.getInstance(UserInfo.getUserId()).Password__c;
        loginController.passwordPolling = Credentials__c.getOrgDefaults().Password_Polling__c;
        loginController.loginPolling = Credentials__c.getOrgDefaults().Slug_Polling__c;
        loginController.save();
        loginController.savePolling();
        Test.stopTest();
    }

    static testMethod void testLogout() {
        LoginPageController loginController =  new LoginPageController();
        CalloutService_Test.initTestData();
        CalloutService_Test.GeneralRequestMock clients = new CalloutService_Test.GeneralRequestMock(200, 'OK', responseAuthorize, null);
        Test.setMock(HttpCalloutMock.class, clients);
        Test.startTest();
        loginController.telephonyBoard = new TelephonyBoardController();
        loginController.login = Credentials__c.getInstance(UserInfo.getUserId()).Username__c;
        loginController.password = Credentials__c.getInstance(UserInfo.getUserId()).Password__c;
        loginController.passwordPolling = Credentials__c.getOrgDefaults().Password_Polling__c;
        loginController.loginPolling = Credentials__c.getOrgDefaults().Slug_Polling__c;
        loginController.save();
        loginController.savePolling();
        Test.stopTest();
    }

    static testMethod void testError() {
        LoginPageController loginController =  new LoginPageController();
        CalloutService_Test.initTestData();
        CalloutService_Test.GeneralRequestMock clients = new CalloutService_Test.GeneralRequestMock(200, 'OK', responseAuthorize, null);
        Test.setMock(HttpCalloutMock.class, clients);
        Credentials__c testOrgCred = Credentials__c.getOrgDefaults();
        loginController.login = Credentials__c.getInstance(UserInfo.getUserId()).Username__c;
        loginController.password = Credentials__c.getInstance(UserInfo.getUserId()).Password__c;
        loginController.passwordPolling = Credentials__c.getOrgDefaults().Password_Polling__c;
        loginController.loginPolling = Credentials__c.getOrgDefaults().Slug_Polling__c;
        loginController.telephonyBoard = new TelephonyBoardController();
        testOrgCred.Username__c = '';
        testOrgCred.Password__c = '';
        testOrgCred.Slug_Polling__c = '';
        testOrgCred.Password_Polling__c = '';
        upsert testOrgCred;
        Test.startTest();
        loginController.save();
        loginController.savePolling();
        Test.stopTest();
    }

    static testMethod void testlogOutOrgDefoult(){
        initDBLogOut();
        LoginPageController loginController =  new LoginPageController();
        loginController.isAdmin = true;
        loginController.logOut();
        loginController.isAdmin = null;
        loginController.logOut();
    }

    private static void initDBLogOut(){
        Credentials__c testUserCred = Credentials__c.getInstance(UserInfo.getUserId());
        testUserCred.Username__c = 'SFtest';
        testUserCred.Password__c = '123456';
        Credentials__c testOrgCred = Credentials__c.getOrgDefaults();
        testOrgCred.Slug_Polling__c = 'viadialog';
        testOrgCred.Valid_To__c = Datetime.now().addSeconds(-500);
        testOrgCred.Password_Polling__c = 'Ung$R974hc';
        testOrgCred.Token_Part1__c = 'asfsffgsdfadfasdfasdgasg';
        testOrgCred.Token_Part2__c = 'aghsdfgsdffgsdgsdfhs';
        testOrgCred.Token_Part3__c = 'hdfhfgjhsdfhfgjdfjhdrh';
        upsert testOrgCred;
        upsert testUserCred;
    }
}