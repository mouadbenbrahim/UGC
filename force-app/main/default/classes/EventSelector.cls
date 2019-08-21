/**
 * Created by Valera on 15.09.2017.
 */

public with sharing class EventSelector {
    public static List<Event> findEventByCallid(String callId) {
        List<Event> eventResult = new List<Event>();
        eventResult = [
                SELECT id
                        , Call_External_Id__c
                        , call_result_status__c
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
                WHERE Call_External_Id__c = :callId
                LIMIT 1
        ];
        return eventResult;
    }
}