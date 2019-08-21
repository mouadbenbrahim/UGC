/**
 * Created by Valera on 19.10.2017.
 */

@IsTest
private class StatusManagerTest {
    public static String responseAuthorize = '{' +
            '	\"access_token\": \"eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0dCI6IlRlc3RDb21wYW55IiwicHAiOiJ7XC JycGxcIjp7fX0iLCJjaSI6MjAwMDAsInNjb3BlIjpbInNhbGVzZm9yY2UtYXBpIl0sImV4cCI6M TUwNTE1NzY5NSwianRpIjoiMmI5MmE4ZjctNDc1Ny00MWIyLTg3MzgtYWQ1MDI1YmY5 MzYyIiwiYXV0aG9yaXRpZXMiOlsiUk9MRV9TQUxFU0ZPUkNFIl0sImNsaWVudF9pZCI6Ij d5WTVSRUtzIn0.nzt72QYCiJ-qk8lSwRPx_9bmSDnsdTFKlY2ZMciOQnYvlfrE7ZkxcPLI4U Jr0YHHYY9s5XcPiG6v-eqYmeYHJycxdU3VtHo6JdBtoy3-AWgU79ggeC6POM7gxHV65D XcNZ7cTR9cFpkN7tAYUmwtSgZC4d7VE48bhy5z0-ttSzwix4tGJTNccYZ7Jkx8lfDe5bIBK7 j_rNhxvllGT4gGjGykAMXHMmP3y5FoljXnefc0GOlqEeOGPaMnQNJxTrR32r9t784r0itzZc giCDGq4xRhQA009rxwmonDw2Rq9UAT-evsfrIByrUZSRY-w5zShBXU68KTKJzj5q7JIpR2 RA\",' +
            '	\"token_type\": \"bearer\",' +
            '	\"expires_in\": 43199,' +
            '	\"scope\": \"salesforce-api\"' +
            '}';

    public static String  testExaple = '{' +
    '  \"sf\": {' +
    '    \"organization_id\":\"00D0Y0000033AJeUAM\",' +
    '    \"user_id\":\"0050Y000002rKOGQA2\",' +
    '    \"searchRecords\": []' +
            '  }' +
            '}';

    private static String json = '{'+
            '  \"sf\": {'+
            '    \"phone\": 7852416200,'+
            '    \"contacts\": ['+
            '        {'+
            '            \"type\": \"Contact\",'+
            '            \"service_id\": null,'+
            '            \"id\": \"0030Y00000VCN2wQAH\",'+
            '            \"group_id\": null,'+
            '            \"agent_id\": null'+
            '        },'+
            '        {'+
            '            \"type\": \"Account\",'+
            '            \"service_id\": null,'+
            '            \"id\": \"0010Y00000anFKOQA2\",'+
            '            \"group_id\": null,'+
            '            \"agent_id\": null'+
            '        }'+
            '    ],'+
            '    \"organization_id\": \"00D0Y000002iyaOUAQ\",'+
            '    \"user_id\": \"0050Y000002wveiQAA\"'+
            '  },'+
            '  \"agent\": {'+
            '    \"id\": \"1003203\",'+
            '    \"sda\": \"0123456789\",'+
            '    \"status\": \"8\",'+
            '    \"name\": \"John Doe\",'+
            '    \"change_time\": \"2017-09-08 17:51:38\"'+
            '  },'+
            '  \"call\": {'+
            '    \"callid\": \"V44200717090800ffcba\",'+
            '    \"start_time\": \"2017-09-08 17:51:38\",'+
            '    \"agent_uid\": \"1003203\",'+
            '    \"status\": \"3\",'+
            '    \"change_time\": \"2017-09-08 17:51:38\",'+
            '    \"service_uid\": \"11089\",'+
            '    \"group_uid\": \"55522\",'+
            '    \"product_uid\": \"1\",'+
            '    \"sda\": \"7852416200\",'+
            '    \"ref\": \"Call test\"'+
            '  }'+
            '}';
    static testMethod void testBehavior() {
        TelephonyBoardController telephonyBoardCont = new TelephonyBoardController();
        telephonyBoardCont.infoCallForPage = CaseIncomingCall.parse(json);
        StatusManager.Status1 st = new StatusManager.Status1();
        st.banerColor = 'Blue';
        st.setTelephonyBoardContr(telephonyBoardCont);
        st.run(responseAuthorize);

        StatusManager.Status status = new StatusManager.Status1();
        status = new StatusManager.Status2();
        status.setTelephonyBoardContr(telephonyBoardCont);
        status.run(json);

        status = new StatusManager.Status7();
        status.setTelephonyBoardContr(telephonyBoardCont);
        status.run(json);

        status = new StatusManager.Status8();
        status.setTelephonyBoardContr(telephonyBoardCont);
        status.run(json);


        status = new StatusManager.Status13();
        status.setTelephonyBoardContr(telephonyBoardCont);
        status.run(json);


        status = new StatusManager.Status16();
        status.setTelephonyBoardContr(telephonyBoardCont);
        status.run(json);


        status = new StatusManager.Status25();
        status.setTelephonyBoardContr(telephonyBoardCont);
        status.run(json);



    }
}