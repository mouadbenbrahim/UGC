/**
 * Created by Valera on 20.09.2017.
 */

public with sharing class EventManager {

    private static final String INCOMING_CALL_EMPTY = Label.Incoming_call_empty;
    private static final String SUBJECT_CALL = Label.Subject_Call;
    private static final String SUBJECT_OUTBOUND = 'Appel sortant';
    private static final String SUBJECT_INBOUND = 'Appel entrant';
    private  static final String ENGLISH_INBOUND = Label.Outbound;
    private  static final String ENGLISH_OUTBOUND =Label.Inbound;
    public static Event createEventIfCallComing(CaseIncomingCall incomingCall) {
        if (incomingCall == null || incomingCall.call == null) {
            throw new MyCustomException(INCOMING_CALL_EMPTY);
        }
        Boolean isContactOne = isContactOne(incomingCall);
        Event callEvent = new Event();
        if (incomingCall.call.callid != null) {
            List<Event> foundEventByCallId = EventSelector.findEventByCallid(incomingCall.call.callid);
            if (!foundEventByCallId.isEmpty()) {
                callEvent = foundEventByCallId[0];
            }
            callEvent = initEvent(incomingCall, callEvent, isContactOne);
            upsert callEvent;
        } else {
            throw new MyCustomException('call direction not defined');
//            callEvent = initSimpleEvent('0');
        }
        return callEvent;
    }

    private static Boolean isContactOne(CaseIncomingCall incomingCall) {
        return incomingCall.sf != null
                && incomingCall.sf.contacts != null
                && incomingCall.sf.contacts.size() == 1;
    }

    public static Event createOutboundCallevent(ClickToDail clickToDail, CaseOutboundCall caseOutboundCall) {
        String IdClickToDail = clickToDail.objectId;
        Id idObject = Id.valueOf(IdClickToDail);
        if (idObject.getSObjectType().getDescribe().getName() == 'Event') {
            List<Event> event = getEventsByid(idObject);
            return event[0];
        }
        List<Contact> contacts = allRecords('Contact', IdClickToDail);
        List<Lead> leads = allRecords('Lead', IdClickToDail);
        List<Event> events = getEventsByCallid(caseOutboundCall.callid);
//        throw Exception.getMessage( 'SIZE: ' + events.size());

        if (events.isEmpty()) {
            Event event = initSimpleEvent('2');
            event.Call_External_Id__c = caseOutboundCall.callid;
            parseClickToDail(clickToDail, event, leads, contacts);
            insert event;
            return event;
        } else {
            events.get(0).WhoId = null;
            events.get(0).WhatId = null;
            parseClickToDail(clickToDail, events.get(0), leads, contacts);
            upsert events;
            return events[0];
        }
    }


    public static void parseClickToDail(ClickToDail clickToDail, Event event, List<Lead> leads, List<Contact> contacts) {
        event.sda__c = clickToDail.number_Z;
        if (leads.isEmpty() && contacts.isEmpty()) {
            event.WhatId = clickToDail.objectId;
        } else if (!leads.isEmpty() || !contacts.isEmpty()) {
            event.WhoId = clickToDail.objectId;
        }
    }
    public static Event initEvent(CaseIncomingCall responseBody, Event event, Boolean isContactOne) {
        event.StartDateTime = Datetime.valueOf(responseBody.call.start_time);
        event.EndDateTime = event.StartDateTime.addSeconds(2);
        if (responseBody.call.product_uid.equals('1')) {
            event.Subject = SUBJECT_INBOUND;
        } else if (responseBody.call.product_uid.equals('2')) {
            event.Subject = SUBJECT_OUTBOUND;
        } else {
            event.Subject = SUBJECT_CALL;
        }
        event.Agent_id__c = responseBody.call.agent_uid;
        event.Service_id__c = responseBody.call.service_uid;
        event.Group_Id_Outbound__c = responseBody.call.group_uid;
        event.Product_Id__c = responseBody.call.product_uid;
        event.sda__c = responseBody.call.sda;
        event.ref__c = responseBody.call.ref;
        event.Call_External_Id__c = responseBody.call.callid;
        if (isContactOne) {
            List<Account> accounts = getAccountById(responseBody.sf.contacts.get(0).Id);
            if (!accounts.isEmpty()) {
                event.WhatId = responseBody.sf.contacts.get(0).Id;
            } else {
                event.WhoId = responseBody.sf.contacts.get(0).Id;
            }
        }
        return event;
    }

    private static Event initSimpleEvent(String status) {
        Event event = new Event();
        event.StartDateTime = Datetime.now();
        event.EndDateTime = event.StartDateTime.addSeconds(2);
        if (status.equals('1')) {
            event.Subject = SUBJECT_INBOUND;
        } else if (status.equals('2')) {
            event.Subject = SUBJECT_OUTBOUND;

        } else {
            event.Subject = SUBJECT_CALL;
        }
        return event;
    }

    private static List<Account> getAccountById(String idContact) {
        return [
                SELECT id
                        , Name
                FROM Account
                WHERE id = :idContact
        ];
    }

    private static List<SObject> allRecords(String obj, String Id) {
        String queryAllRecords = 'SELECT id FROM ' + obj + ' WHERE Id = ' + '\'' + Id + '\'';
        return Database.query(queryAllRecords);
    }

    private static List<Event> getEventsByCallid(String callid) {
        return [
                SELECT ID
                        , Call_External_Id__c
                        , call_result_status__c
                        , WhatId
                        , WhoId
                        , sda__c
                        , StartDateTime
                        , EndDateTime
                        , Duration__c
                        , Service_id__c
                        , ref__c
                        , url__c
                        , Agent_duration__c
                        , Agent_id__c
                        , Description
                FROM Event
                WHERE Call_External_Id__c = :callid
                LIMIT 1
        ];
    }

    private static List<Event> getEventsByid(ID idEvent) {
        return [
                SELECT ID
                        , Call_External_Id__c
                        , call_result_status__c
                        , WhatId
                        , WhoId
                        , sda__c
                        , StartDateTime
                        , EndDateTime
                        , Duration__c
                        , Service_id__c
                        , ref__c
                        , url__c
                        , Agent_duration__c
                        , Agent_id__c
                        , Description
                FROM Event
                WHERE ID = :idEvent
                LIMIT 1
        ];
    }
}