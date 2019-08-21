/**
 * Created by Valera on 15.09.2017.
 */

public with sharing class EventResponseBody {
    public static final String callJson = '{'+
            '  \"callid\": \"V44200717091100ffccb   \",'+
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

    public String callid; //Call identification
    public String start; //Timestamp call start
    public String duration; //Call duration in second
    public String serviceid;
    public String sda; //Client phone number
    public List<Agent> agent;
    public String ref;
    public String status; //call result status 4,5,6, 24, 25, 26 ,31
    public String url;


    public class Agent {
        public String id;
        public String duration;
    }

    public static EventResponseBody parse(String json) {
        return (EventResponseBody) System.JSON.deserialize(json, EventResponseBody.class);
    }
}