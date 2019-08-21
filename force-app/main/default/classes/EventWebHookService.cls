/**
 * Created by Valera on 22.11.2017.
 */
@RestResource(urlMapping='/WebHook/*')
global with sharing class EventWebHookService {
    @HttpPost
    global static String updateEvent() {
        RestResponse response = RestContext.response;
        RestRequest req = RestContext.request;
        String callReturnJson = req.requestbody.tostring();

        if (String.isEmpty(callReturnJson)) {
            return errorResponse('true', Label.Request_body_empty);
        }
        String errorMessage = checkError(callReturnJson);
        if (errorMessage != '') {
            return errorResponse('true', errorMessage);
        }
        EventResponseBody callRt = EventResponseBody.parse(callReturnJson);
        List<Event> eventResult = EventSelector.findEventByCallid(callRt.callid);
        System.debug('EVENT RESULT: ' + eventResult);
        if (eventResult.isEmpty()) {
            return errorResponse('false', Label.Event_not_exist);
        }
        Event eventResultSingle = eventResult[0];
        eventResultSingle = initExistingEvent(eventResultSingle, callRt);
        update eventResultSingle;
        return correctResponse('false', String.valueOf(eventResultSingle.id));
    }

    private static String errorResponse(String error, String message) {
        String finalResponse = '{'
                + '"error": "' + error + '",'
                + '"message": "' + message + '"'
                + '}';
        return finalResponse;
    }

    private static String correctResponse(String error, String eventId) {
        String finalResponse = '{'
                + '"error": "' + error + '",'
                + '"id_event": "' + eventId + '"'
                + '}';
        return finalResponse;
    }

    private static Event initExistingEvent(Event eventResult, EventResponseBody callRt) {
        eventResult.call_result_status__c = callRt.status;
        eventResult.sda__c = callRt.sda;
        eventResult.StartDateTime = Datetime.newinstance(long.valueOf(callRt.start));
        eventResult.EndDateTime = Datetime.newinstance(long.valueOf(callRt.start)).addSeconds(Integer.valueOf(callRt.duration));
        eventResult.Duration__c = Decimal.valueOf(callRt.duration);
        eventResult.Service_id__c = callRt.serviceid;
        eventResult.ref__c = callRt.ref;
        eventResult.url__c = callRt.url;
        eventResult.Agent_duration__c = callRt.agent.get(0).duration;
        eventResult.Agent_id__c = callRt.agent.get(0).id;
        return eventResult;
    }

    public static String checkError(String jsonString) {
        String errorMessage = '';
        Map<String, Object> response_object = (Map<String, Object>) JSON.deserializeUntyped(jsonString);
        for (String str : response_object.keySet()) {
            if (str != 'url' && str != 'ref' && (response_object.get(str) == '' || response_object.get(str) == null)) {
                errorMessage += str + ': is Empty; ';
            }
        }
        return errorMessage;
    }
}