/**
 * Created by Valera on 09.10.2017.
 */

@IsTest
@TestVisible
private class CalloutService_Test {
    @TestVisible
    public static String responseBody = ' "sf": {},"agent": {"id": "1031177","sda": "0183771988","status": "1","name": "Ikumbitest2","change_time": "2017-09-13 14:44:35"},"call": {}}';
    public static String checkCredBody = ' {"error": false,"agentid": 1023308}';

    @TestVisible
    public static String responseAuthorize = '{' +
            '	\"access_token\": \"eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0dCI6IlRlc3RDb21wYW55IiwicHAiOiJ7XC JycGxcIjp7fX0iLCJjaSI6MjAwMDAsInNjb3BlIjpbInNhbGVzZm9yY2UtYXBpIl0sImV4cCI6M TUwNTE1NzY5NSwianRpIjoiMmI5MmE4ZjctNDc1Ny00MWIyLTg3MzgtYWQ1MDI1YmY5 MzYyIiwiYXV0aG9yaXRpZXMiOlsiUk9MRV9TQUxFU0ZPUkNFIl0sImNsaWVudF9pZCI6Ij d5WTVSRUtzIn0.nzt72QYCiJ-qk8lSwRPx_9bmSDnsdTFKlY2ZMciOQnYvlfrE7ZkxcPLI4U Jr0YHHYY9s5XcPiG6v-eqYmeYHJycxdU3VtHo6JdBtoy3-AWgU79ggeC6POM7gxHV65D XcNZ7cTR9cFpkN7tAYUmwtSgZC4d7VE48bhy5z0-ttSzwix4tGJTNccYZ7Jkx8lfDe5bIBK7 j_rNhxvllGT4gGjGykAMXHMmP3y5FoljXnefc0GOlqEeOGPaMnQNJxTrR32r9t784r0itzZc giCDGq4xRhQA009rxwmonDw2Rq9UAT-evsfrIByrUZSRY-w5zShBXU68KTKJzj5q7JIpR2 RA\",' +
            '	\"token_type\": \"bearer\",' +
            '	\"expires_in\": 43199,' +
            '	\"scope\": \"salesforce-api\"' +
            '}';

    public static String token = 'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0dCI6IlRlc3RDb21wYW55IiwicHAiOiJ7XC JycGxcIjp7fX0iLCJjaSI6MjAwMDAsInNjb3BlIjpbInNhbGVzZm9yY2UtYXBpIl0sImV4cCI6M TUwNTE1NzY5NSwianRpIjoiMmI5MmE4ZjctNDc1Ny00MWIyLTg3MzgtYWQ1MDI1YmY5 MzYyIiwiYXV0aG9yaXRpZXMiOlsiUk9MRV9TQUxFU0ZPUkNFIl0sImNsaWVudF9pZCI6Ij d5WTVSRUtzIn0.nzt72QYCiJ-qk8lSwRPx_9bmSDnsdTFKlY2ZMciOQnYvlfrE7ZkxcPLI4U Jr0YHHYY9s5XcPiG6v-eqYmeYHJycxdU3VtHo6JdBtoy3-AWgU79ggeC6POM7gxHV65D XcNZ7cTR9cFpkN7tAYUmwtSgZC4d7VE48bhy5z0-ttSzwix4tGJTNccYZ7Jkx8lfDe5bIBK7 j_rNhxvllGT4gGjGykAMXHMmP3y5FoljXnefc0GOlqEeOGPaMnQNJxTrR32r9t784r0itzZc giCDGq4xRhQA009rxwmonDw2Rq9UAT-evsfrIByrUZSRY-w5zShBXU68KTKJzj5q7JIpR2 RA';


    static testMethod void testPolling() {
        initTestData();
        CalloutService_Test.GeneralRequestMock clients = initMock(200, 'OK', responseBody, null);
        Test.setMock(HttpCalloutMock.class, clients);
        Test.startTest();
        CalloutService.polling('1031177', 'sometoken');
        Test.stopTest();
    }
    static testMethod void testPollingEmptyCreds() {
        initTestData();
        CalloutService_Test.GeneralRequestMock clients = initMock(200, 'OK', responseBody, null);
        Test.setMock(HttpCalloutMock.class, clients);
        Test.startTest();
        CalloutService.polling('1031177', 'sometoken');
        Test.stopTest();
    }

    static testMethod void testOutboundCallEmpty() {
        try {
            initTestData();
            CalloutService_Test.GeneralRequestMock clients = initMock(302, 'Found', '', null);
            Test.setMock(HttpCalloutMock.class, clients);
            Test.startTest();
            CalloutService.outboundCall('1023308', '64082', '17156', '0177453000', token);
            Test.stopTest();
        } catch (MyCustomException e) {
            System.assertEquals(e.getMessage(), 'Server Error 302, message error: Found');
        }
    }

    static testMethod void testOutboundCall() {
        initTestData();
        CalloutService_Test.GeneralRequestMock clients = initMock(200, 'OK', '', null);
        Test.setMock(HttpCalloutMock.class, clients);
        Test.startTest();
        CalloutService.outboundCall('1023308', '64082', '17156', '0177453000', token);
        Test.stopTest();
    }

    static testMethod void testCheckErrorStatus() {
        try {
            initTestData();
            CalloutService_Test.GeneralRequestMock clients = initMock(302, 'Found', '', null);
            Test.setMock(HttpCalloutMock.class, clients);
            Test.startTest();
            CalloutService.outboundCall('1023308', '64082', '17156', '0177453000', token);
            Test.stopTest();
        } catch (MyCustomException e) {
            System.assertEquals(e.getMessage(), 'Server Error 302, message error: Found');
        }
    }

    static testMethod void testEmptyReqFieldsPolling() {
        try {
            initTestData();
            CalloutService_Test.GeneralRequestMock clients = initMock(200, 'OK', responseBody, null);
            Test.setMock(HttpCalloutMock.class, clients);
            Test.startTest();
            CalloutService.polling('dfdfdf', null);
            Test.stopTest();
        } catch (MyCustomException e) {
            System.debug('ERROR');
            System.assertEquals(e.getMessage(), 'Some requred fields are empty polling');
        }
    }

    static testMethod void testEmptyReqFieldsAuthorizationPolling() {
        try {
            initTestData();
            CalloutService_Test.GeneralRequestMock clients = initMock(200, 'OK', responseAuthorize, null);
            Test.setMock(HttpCalloutMock.class, clients);
            Credentials__c testOrgCred = Credentials__c.getOrgDefaults();
            testOrgCred.Grant_Type__c = '';
            upsert testOrgCred;
            Test.startTest();
            CalloutService.authorizationPolling('', '');
            Test.stopTest();
        } catch (MyCustomException e) {
            System.assertEquals(e.getMessage(), 'Empty credentials - authorizationPolling()');
        }
    }

    static testMethod void testEmptyReqFieldsOutboundCall() {
        try {
            Credentials__c testOrgCred = Credentials__c.getOrgDefaults();
            testOrgCred.Viadialog_Url__c = null;
            upsert testOrgCred;
            CalloutService_Test.GeneralRequestMock clients = initMock(200, 'OK', '', null);
            Test.setMock(HttpCalloutMock.class, clients);
            Test.startTest();
            CalloutService.outboundCall('12245', '64082', '17156', '', token);
            Test.stopTest();
        } catch (MyCustomException e) {
            System.assertEquals(e.getMessage(), 'Some requred fields are empty');
        }
    }

    static testMethod void testAuthorizationPollingError() {
        try {
            initTestData();
            CalloutService_Test.GeneralRequestMock clients = initMock(200, 'OK', responseAuthorize, null);
            Test.setMock(HttpCalloutMock.class, clients);
            Credentials__c testOrgCred = Credentials__c.getOrgDefaults();
            testOrgCred.Slug_Polling__c = '';
            upsert testOrgCred;
            Authorization authorization = new Authorization();
            Test.startTest();
            authorization.authorizatioVT(authorization.orgUser, authorization.orgCred);
            Test.stopTest();
        } catch (MyCustomException e) {
            System.assertEquals(e.getMessage(), 'Empty credentials - authorizationPolling()');
        }
    }

    static testMethod void testAuthorizationErrorTokenEmpty() {
        try {
            initTestData();
            CalloutService_Test.GeneralRequestMock auth = new CalloutService_Test.GeneralRequestMock(200,
                    'OK',
                    responseAuthorize,
                    null
            );
            CalloutService_Test.GeneralRequestMock checkBanner = new CalloutService_Test.GeneralRequestMock(200,
                    'OK',
                    checkCredBody,
                    null
            );
            Map<String, HttpCalloutMock> callout_mocks = new Map<String, HttpCalloutMock>();
            callout_mocks.put('http://salesforce.viadialog.com/uaa/oauth/token', auth);
            callout_mocks.put('http://salesforce.viadialog.com/check/', checkBanner);
            HttpCalloutMock multi_callout_mock = new CalloutService_Test.BulkMockGenerator(callout_mocks);
            Test.setMock(HttpCalloutMock.class, multi_callout_mock);
            Authorization authorizat = new Authorization();
            Authorization.token = '';
            Test.startTest();
            authorizat.authorizatioVT(authorizat.orgUser, authorizat.orgCred);
            Test.stopTest();
        } catch (MyCustomException e) {
            System.assertEquals(e.getMessage(), 'Agent Id is null or incorrect');
        }
    }

    static testMethod void testAuthorizationPollingErrorStatus() {
        try {
            initTestData();
            CalloutService_Test.GeneralRequestMock auth = new CalloutService_Test.GeneralRequestMock(201,
                    'OK',
                    responseAuthorize,
                    null
            );
            CalloutService_Test.GeneralRequestMock checkBanner = new CalloutService_Test.GeneralRequestMock(200,
                    'OK',
                    checkCredBody,
                    null
            );
            Map<String, HttpCalloutMock> callout_mocks = new Map<String, HttpCalloutMock>();
            callout_mocks.put('http://salesforce.viadialog.com/uaa/oauth/token', auth);
            callout_mocks.put('http://salesforce.viadialog.com/check/', checkBanner);
            HttpCalloutMock multi_callout_mock = new CalloutService_Test.BulkMockGenerator(callout_mocks);
            Test.setMock(HttpCalloutMock.class, multi_callout_mock);
            Authorization authorization = new Authorization();
            Test.startTest();
            authorization.authorizatioVT(authorization.orgUser, authorization.orgCred);
            Test.stopTest();
        } catch (MyCustomException e) {
            System.assertEquals(e.getMessage(), 'Agent Id is null or incorrect');
        }
    }

    @TestVisible
    private static CalloutService_Test.GeneralRequestMock initMock(Integer code, String status, String body, Map<String, String> responseHeaders) {
        return new CalloutService_Test.GeneralRequestMock(code, status, body, responseHeaders);
    }

    @TestVisible
    public static void initTestData() {
        Credentials__c testUserCred = Credentials__c.getInstance(UserInfo.getUserId());
        Credentials__c testOrgCred = Credentials__c.getOrgDefaults();
        testUserCred.Username__c = 'SFtest';
        testUserCred.Password__c = '123456';
        testOrgCred.Slug_Polling__c = 'viadialog';
        testOrgCred.Valid_To__c = Datetime.now().addSeconds(-500);
        testOrgCred.Password_Polling__c = 'Ung$R974hc';
        testOrgCred.Grant_Type__c = 'client_credentials';
        testOrgCred.Scope__c = 'salesforce-api';
        testOrgCred.Access_Token__c = 'Basic N3lZNVJFS3M6RjY4QnJzNXdUTWFYQ1BTekdIN3lYVk5IQ2VZa3gyZng=N3lZNVJFS3M6RjY4QnJzNXdUTWFYQ1BTekdIN3lYVk5IQ2VZa3gyZng=';
        testOrgCred.banerUrl__c = 'http://ccv.viatelecom.com/services/?';
        testOrgCred.Viadialog_Url__c = 'http://salesforce.viadialog.com/';
        upsert testOrgCred;
        upsert testUserCred;
    }

    public class BulkMockGenerator implements HttpCalloutMock {
        Map<String, HttpCalloutMock> requests;

        public BulkMockGenerator(Map<String, HttpCalloutMock> requests) {
            this.requests = requests;
        }

        public HTTPResponse respond(HTTPRequest req) {
            System.debug('Hello single');
            HttpCalloutMock mock = requests.get(req.getEndpoint().substringBefore('?'));
            if (mock != null) {
                return mock.respond(req);
            } else {
                throw new MyCustomException('HTTP callout not supported for test methods');
            }
        }
    }

    @TestVisible
    public virtual class GeneralRequestMock implements HttpCalloutMock {
        protected Integer code;
        protected String status;
        protected String bodyAsString;
        protected Map<String, String> responseHeaders;

        public GeneralRequestMock(Integer code, String status, String body,
                Map<String, String> responseHeaders) {
            System.debug('HELLO');
            this.code = code;
            this.status = status;
            this.bodyAsString = body;
            this.responseHeaders = responseHeaders;
        }

        public virtual HTTPResponse respond(HTTPRequest req) {
            System.debug('HELLO response');
            HttpResponse resp = new HttpResponse();
            resp.setStatusCode(code);
            resp.setStatus(status);
            resp.setBody(bodyAsString);

            if (responseHeaders != null) {
                for (String key : responseHeaders.keySet()) {
                    resp.setHeader(key, responseHeaders.get(key));
                }
            }
            return resp;
        }
    }
}