/**
 * Created by Valera on 22.11.2017.
 */

@IsTest
private class EventWebHookService_Test {
    static String jsonResponse = '{' +
            '  \"callid\": \"V44200717091100ffccb\",' +
            '  \"start\": \"1505146178\",' +
            '  \"duration\": \"56\",' +
            '  \"serviceid\": \"11089\",' +
            '  \"sda\": \"0177453000\",' +
            '  \"agent\": [{' +
            '       \"id\": \"1003203\",' +
            '       \"duration\": \"51\"' +
            '     }],' +
            '  \"ref\": \"call test\",' +
            '  \"status\": \"4\",' +
            '  \"url\": \"\"' +
            '}';
    static String jsonResponseEmptyCallId = '{' +
            '  \"callid\": \"\",' +
            '  \"start\": \"1505146178\",' +
            '  \"duration\": \"56\",' +
            '  \"serviceid\": \"11089\",' +
            '  \"sda\": \"0177453000\",' +
            '  \"agent\": [{' +
            '       \"id\": \"1003203\",' +
            '       \"duration\": \"51\"' +
            '     }],' +
            '  \"ref\": \"call test\",' +
            '  \"status\": \"4\",' +
            '  \"url\": \"\"' +
            '}';

    static String resultEmpty = '{"callid": "","start": "1505146178","duration": "56","": "","sda": "","agent": [{"id": "","duration": ""}],"ref": "","status": "","url": ""}';
    static testMethod void testUpdateEvent() {
        Id recordId = createTestEvent();
        Map<String ,Object> resultParse = responseMap(jsonResponse);
        System.assertEquals(recordId, (Id)resultParse.get('id_event'));
        System.assertEquals('false', (String)resultParse.get('error'));
    }

    static testMethod void testEmptyRequestField() {
        Map<String ,Object> resultParse = responseMap(jsonResponseEmptyCallId);
        System.assertEquals('callid: is Empty; ', (String)resultParse.get('message'));
        System.assertEquals('true', (String)resultParse.get('error'));
    }


    static testMethod void testEventIsEmpty() {
        Map<String ,Object> resultParse = responseMap(jsonResponse);
        System.assertEquals('Event does not exist', (String)resultParse.get('message'));
        System.assertEquals('false', (String)resultParse.get('error'));
    }

    static testMethod void testRequestBodyIsEmpty() {
        Map<String ,Object> resultParse = responseMap('');
        System.assertEquals('Request body is empty', (String)resultParse.get('message'));
        System.assertEquals('true', (String)resultParse.get('error'));
    }

    private static Map<String ,Object> responseMap(String requestBody){
        RestRequest request = new RestRequest();
        request.requestUri = 'https://eu11.salesforce.com/services/apexrest/WebHook/';
        request.httpMethod = 'POST';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf(requestBody);
        RestContext.request = request;
        String response = EventWebHookService.updateEvent();
        Map<String ,Object> resultParse = ( Map<String ,Object>) System.JSON.deserializeUntyped(EventWebHookService.updateEvent());
        return resultParse;
    }

    static Id createTestEvent() {
        Event event = new Event(Subject = 'Call', StartDateTime = Datetime.now(), EndDateTime = Datetime.now().addMinutes(2), Call_External_Id__c = 'V44200717091100ffccb');
        insert event;
        return event.Id;
    }
}