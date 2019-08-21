/**
 * Created by Valera on 19.10.2017.
 */

@IsTest
private class AuthorizationTest {

    public static String responseAuthorize = '{' +
            '	\"access_token\": \"eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0dCI6IlRlc3RDb21wYW55IiwicHAiOiJ7XC JycGxcIjp7fX0iLCJjaSI6MjAwMDAsInNjb3BlIjpbInNhbGVzZm9yY2UtYXBpIl0sImV4cCI6M TUwNTE1NzY5NSwianRpIjoiMmI5MmE4ZjctNDc1Ny00MWIyLTg3MzgtYWQ1MDI1YmY5 MzYyIiwiYXV0aG9yaXRpZXMiOlsiUk9MRV9TQUxFU0ZPUkNFIl0sImNsaWVudF9pZCI6Ij d5WTVSRUtzIn0.nzt72QYCiJ-qk8lSwRPx_9bmSDnsdTFKlY2ZMciOQnYvlfrE7ZkxcPLI4U Jr0YHHYY9s5XcPiG6v-eqYmeYHJycxdU3VtHo6JdBtoy3-AWgU79ggeC6POM7gxHV65D XcNZ7cTR9cFpkN7tAYUmwtSgZC4d7VE48bhy5z0-ttSzwix4tGJTNccYZ7Jkx8lfDe5bIBK7 j_rNhxvllGT4gGjGykAMXHMmP3y5FoljXnefc0GOlqEeOGPaMnQNJxTrR32r9t784r0itzZc giCDGq4xRhQA009rxwmonDw2Rq9UAT-evsfrIByrUZSRY-w5zShBXU68KTKJzj5q7JIpR2 RA\",' +
            '	\"token_type\": \"bearer\",' +
            '	\"expires_in\": 43199,' +
            '	\"scope\": \"salesforce-api\"' +
            '}';
    public static String checkCredBody = ' {"error": false,"agentid": 1023308}';

    static testMethod void testAuthorization() {
        initDB();
        Authorization authoriz = new Authorization();
        authoriz.isNewToken = true;
        CalloutService_Test.GeneralRequestMock checkBanner = new CalloutService_Test.GeneralRequestMock(200, 'OK', checkCredBody, null);
        CalloutService_Test.GeneralRequestMock polling = new CalloutService_Test.GeneralRequestMock(200, 'OK', responseAuthorize, null);
        Map<String, HttpCalloutMock> callout_mocks = new Map<String, HttpCalloutMock>();
        callout_mocks.put('http://salesforce.viadialog.com/check/', checkBanner);
        callout_mocks.put('http://salesforce.viadialog.com/uaa/oauth/token', polling);
        HttpCalloutMock multi_callout_mock = new CalloutService_Test.BulkMockGenerator(callout_mocks);
        Test.setMock(HttpCalloutMock.class, multi_callout_mock);
        Test.startTest();
        Map<String, String> testMap = authoriz.authorizatioVT();
        System.assertEquals('1023308', testMap.get('AgentId'));
        System.assertEquals('123456', testMap.get('Password'));
        System.assertEquals('Ikumbitest', testMap.get('Username'));
        Test.stopTest();
    }

    static testMethod void testBuildTokenAuthorization() {
        initDB();
        Authorization authoriz = new Authorization();
        String actually = authoriz.buildTokenAuthorization();
        String expected = 'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0dCI6IlZpYWRpYWxvZyIsImNpIjoxMDIwMCwic2NvcGUiOlsic2FsZXNmb3JjZS1hcGkiXSwiZXhwIjoxNTA4NDQ1ODc0LCJqdGkiOiIxN2RkYmUwYi1iNjg0LTQ5YzktOTkyMC02YjQyYmYwNjgwOTciLCJhdXRob3JpdGllcyI6WyJST0xFX1NBTEVTRk9SQ0UiXSwiY2xpZW50X2lkIjoiN3lZNVJFS3MifQw0Alt3dE1EjsWKYf_NfjL0Wazadkee3o3EscMHaDe6dchN75dojIjCDqhr3d9xSwffSfwa_5NZTxcg7BhDgWuznsor5kxHNqcywi_nUrDl0ABZlzBUM12s_x_mSm6ja53TCFQSjfbQs9bZWjEAPhXeZc23';
        System.assertEquals(actually, expected);
    }

    static testMethod void testGetPollingTokenNEW() {
        initForPolling();
        Authorization authoriz = new Authorization();
        Boolean expected = authoriz.getPollingTokenNEW();
        System.assertEquals(false, expected);
    }


    private static void initForPolling() {
        Credentials__c orgCred = Credentials__c.getOrgDefaults();
        orgCred.Token_Part1__c = 'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0dCI6IlZpYWRpYWxvZyIsImNpIjoxMDIwMCwic2NvcGUiOlsic2FsZXNmb3JjZS1hcGkiXSwiZXhwIjoxNTA4NDQ1ODc0LCJqdGkiOiIxN2RkYmUwYi1iNjg0LTQ5YzktOTkyMC02YjQyYmYwNjgwOTciLCJhdXRob3J';
        orgCred.Token_Part2__c = 'pdGllcyI6WyJST0xFX1NBTEVTRk9SQ0UiXSwiY2xpZW50X2lkIjoiN3lZNVJFS3MifQ';
        orgCred.Token_Part3__c = 'w0Alt3dE1EjsWKYf_NfjL0Wazadkee3o3EscMHaDe6dchN75dojIjCDqhr3d9xSwffSfwa_5NZTxcg7BhDgWuznsor5kxHNqcywi_nUrDl0ABZlzBUM12s_x_mSm6ja53TCFQSjfbQs9bZWjEAPhXeZc23';
        orgCred.Valid_To__c = Datetime.now().addSeconds(-100);
        upsert orgCred;
    }
    private static void initDB() {
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
        orgCred.Grant_Type__c = 'client_credentials';
        orgCred.Access_Token__c = 'Basic N3lZNVJFS3M6RjY4QnJzNXdUTWFYQ1BTekdIN3lYVk5IQ2VZa3gyZng=N3lZNVJFS3M6RjY4QnJzNXdUTWFYQ1BTekdIN3lYVk5IQ2VZa3gyZng=';
        userCred.Password__c = '123456';
        userCred.Username__c = 'Ikumbitest';
        user.Agent_id__c = '1023308';
        update user;
        upsert orgCred;
        upsert userCred;
    }
}