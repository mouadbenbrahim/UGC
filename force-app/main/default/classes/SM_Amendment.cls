/**
 * Created by ext-dev-05 on 04/07/2019.
 */

public with sharing class SM_Amendment {

    public static WSZ.AmendOut getAmendment(String subId, String zEntityId) {
        String endpoint = '/v1/amendments/subscriptions/' + subId;
        String method = 'GET';
        String wsIn = null;
        String wsOut = '';

        // Retrieve Zuora token
        String accessToken = WS001_CallZuora.access_token;

        wsOut = WS001_CallZuora.sendRequest(accessToken, endpoint, zEntityId, method, wsIn, 'type1', null);
        wsOut = wsOut.replace('type','typeX');
        return (WSZ.AmendOut) JSON.deserializeStrict(wsOut, WSZ.AmendOut.class);
    }

    public static WSZ.GenericOut2 updateAmendment(WSZ.AmendIn amend, String zEntityId) {
        String endpoint = '/v1/object/amendment/' + amend.id;
        String method = 'PUT';
        String wsIn = null;
        String wsOut = '';

        // WSZ.AmendIn wsInObj = amend.clone();
        wsIn = (String) JSON.serialize(amend);
        wsIn = wsIn.replace('operation_c','Operation__c');
        // Retrieve Zuora token
        String accessToken = WS001_CallZuora.access_token;

        wsOut = WS001_CallZuora.sendRequest(accessToken, endpoint, zEntityId, method, wsIn, 'type1', null);
        wsOut = wsOut.replace('type','typeX');
        return (WSZ.GenericOut2) JSON.deserializeStrict(wsOut, WSZ.GenericOut2.class);
    }

}