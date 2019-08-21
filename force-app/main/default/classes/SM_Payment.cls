/**
 * Created by mouad on 02/12/2018.
 */

public with sharing class SM_Payment {

    //public static String zEntityId = '8adce421-63ec-c07b-0163-f45782667179'; // France

    public static WSZ.PaymentPartsOut getPaymentPart(String paymentId, String zEntityId) {
        String endpoint = '/v1/payments/'+ paymentId +'/parts';
        String method = 'GET';
        String wsIn = null;
        String wsOut = '';

        // Retrieve Zuora token
        String accessToken = WS001_CallZuora.access_token;

        wsOut = WS001_CallZuora.sendRequest(accessToken, endpoint, zEntityId, method, wsIn, 'type1', null);  
        return (WSZ.PaymentPartsOut) JSON.deserializeStrict(wsOut, WSZ.PaymentPartsOut.class);
    }
    
    /*public static Zuora__Payment__c getPayment(Id paymentId){

        Zuora__Payment__c payment = [
				                SELECT Id, Zuora__EXT_ID__c, Zuora__Invoice__c
				                FROM Zuora__Payment__c
				                WHERE Id = :paymentId
        ];
        return payment;
    }*/

}