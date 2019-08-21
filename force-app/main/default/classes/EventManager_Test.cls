/**
 * Created by Valera on 09.10.2017.
 */

@IsTest
private class EventManager_Test {
    static testMethod void testCreateOutboundCallevent() {
        String bodyClickToDail = '{"number":"(098) 407-3751","objectId":"' + contactInuit() + '","objectName":"TestAccPhone1","object":"Account","displayName":"Account"}';
        ClickToDail clickDail = ClickToDail.parse(bodyClickToDail);
        clickDail.objectId = contactInuit();

        CaseOutboundCall outboundCall = new CaseOutboundCall();
        outboundCall.callid = 'V44200717090800ffcba';
        List<Event> events = getEvents();
        System.assertEquals(events.size(), 0);

        EventManager.createOutboundCallevent(clickDail, outboundCall);
        events = getEvents();
        System.assertEquals(events.size(), 1);
    }

    static testMethod void testCreateOutboundCalleventExistEventt() {
        initOudBoundCallDB();
        String bodyClickToDail = '{"number":"(098) 407-3751","objectId":"' + contactInuit() + '","objectName":"TestAccPhone1","object":"Account","displayName":"Account"}';
        ClickToDail clickDail = ClickToDail.parse(bodyClickToDail);
        clickDail.objectId = contactInuit();
        
        CaseOutboundCall outboundCall = new CaseOutboundCall();
        outboundCall.callid = 'V44200717090800ffcba';
        List<Event> events = getEvents();
        System.assertEquals(events.size(), 1);

        EventManager.createOutboundCallevent(clickDail, outboundCall);
        events = getEvents();
        System.assertEquals(events.size(), 1);
    }

    static testMethod void testCreateEventIfCallComing() {
        initDB();

        List<Event> allEvents = getEvents();
        List<Contact> allContacts = getContacts();
        String jsonEventIsNotEmpty = '{' +
                '  \"sf\": {' +
                '    \"contacts\": ['+
                '        {'+
                '            \"type\": \"Contact\",'+
                '            \"service_id\": null,'+
                '            \"id\": "'+ allContacts.get(0).id +'",'+
                '            \"group_id\": null,'+
                '            \"agent_id\": null'+
                '        }'+
                '    ],'+
                '    \"organization_id\": \"00D0Y000002iyaOUAQ\",'+
                '    \"user_id\": \"0050Y000002wveiQAA\"'+
                '  },'+
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
        String jsonEventIsEmpty = '{' +
                '  \"sf\": {' +
                '    \"contacts\": ['+
                '        {'+
                '            \"type\": \"Contact\",'+
                '            \"service_id\": null,'+
                '            \"Id\":' + '"' + allContacts.get(0).id + '"' +
                '            \"group_id\": null,'+
                '            \"agent_id\": null'+
                '        }'+
                '    ],'+
                '  \"agent\": {' +
                '    \"id\": \"1003203\",' +
                '    \"sda\": \"0123456789\",' +
                '    \"status\": \"8\",' +
                '    \"name\": \"John Doe\",' +
                '    \"change_time\": \"2017-09-08 17:51:38\"' +
                '  },' +
                '  \"call\": {' +
                '    \"callid\": \"77770777707777077771\",' +
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

        CaseIncomingCall responseBody = CaseIncomingCall.parse(jsonEventIsNotEmpty);
        Event resultEvent = EventManager.createEventIfCallComing(responseBody);
        System.assertEquals(allEvents.get(0).id, resultEvent.Id);
        System.assertEquals(resultEvent.WhoId, allContacts.get(0).Id);
        System.assertEquals(allEvents.size(), 1);
    }

    static testMethod void testEmptyResponse() {
        String jsonCallIdIsEmpty = '{' +
                '  \"agent\": {' +
                '    \"id\": \"1003203\",' +
                '    \"sda\": \"0123456789\",' +
                '    \"status\": \"8\",' +
                '    \"name\": \"John Doe\",' +
                '    \"change_time\": \"2017-09-08 17:51:38\"' +
                '  }' +
                '}';
        try {

            CaseIncomingCall responseBody = CaseIncomingCall.parse(jsonCallIdIsEmpty);
            Event resultEvent = EventManager.createEventIfCallComing(responseBody);
//            System.assertEquals(resultEvent.Call_External_Id__c, null);
//            System.assertEquals(resultEvent.WhoId, null);
//            System.assertEquals(resultEvent.sda__c, null);
//            System.assertEquals(resultEvent.ref__c, null);
        } catch (MyCustomException e) {
            System.assertEquals(e.getMessage(), 'Incoming call is empty');

        }
    }

    static void initDB() {
        Contact contact1 = new Contact(LastName = 'Test Contact1');
        Contact contact2 = new Contact(LastName = 'Test Contact2');
        insert contact1;
        insert contact2;
        Event event = new Event(Subject = 'Call', StartDateTime = Datetime.now(), EndDateTime = Datetime.now().addMinutes(2), Call_External_Id__c = 'V44200717090800ffcba');
        insert event;
    }

    static void initOudBoundCallDB() {
        Event event = new Event(Subject = 'Call', StartDateTime = Datetime.now(), EndDateTime = Datetime.now().addMinutes(2), Call_External_Id__c = 'V44200717090800ffcba');
        insert event;
    }

    static Id contactInuit() {
        Contact contact = new Contact(LastName = 'Test');
        insert contact;
        return contact.Id;
    }
    static List<Contact> getContacts() {
        return [SELECT id FROM Contact];
    }

    static List<Event> getEvents() {
        return [
                SELECT id,
                        Call_External_Id__c,
                        call_result_status__c,
                        WhoId,
                        sda__c,
                        StartDateTime,
                        EndDateTime,
                        Duration__c,
                        Service_id__c,
                        ref__c,
                        url__c,
                        Agent_duration__c,
                        Agent_id__c
                FROM Event
        ];
    }
}