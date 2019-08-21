/**
 * Created by Valera on 09.10.2017.
 */

@IsTest
private class EventResponseBody_Test {
    static testMethod void testParse() {
        String json = '{'+
                '  \"callid\": \"V44200717091100ffccb\",'+
                '  \"start\": \"1505146178\",'+
                '  \"duration\": \"56\",'+
                '  \"serviceid\": \"11089\",'+
                '  \"sda\": \"0177453000\",'+
                '  \"agent\": [{'+
                '       \"id\": \"1003203\",'+
                '       \"duration\": \"51\"'+
                '     }],'+
                '  \"ref\": \"call test\",'+
                '  \"status\": \"4\",'+
                '  \"url\": \"\"'+
                '}';
        EventResponseBody obj = EventResponseBody.parse(json);
        System.assert(obj != null);
    }
}