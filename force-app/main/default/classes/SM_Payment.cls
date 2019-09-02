/**
 * Created by mouad on 02/12/2018.
 */

public with sharing class SM_Payment {

    //public static String zEntityId = '8adce421-63ec-c07b-0163-f45782667179'; // France
    public static String endpoint = '/v1/payments';

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
    

	public static void precessCreatePayment(String accountId, String invoiceId, Decimal amount, String paymentMethodId, String zEntityId, String access_token){
		system.debug('##MNE SM_Payment precessCreatePayment accountId >> '+accountId);
		system.debug('##MNE SM_Payment precessCreatePayment invoiceId >> '+invoiceId);
		system.debug('##MNE SM_Payment precessCreatePayment amount >> '+amount);
		system.debug('##MNE SM_Payment precessCreatePayment paymentMethodId >> '+paymentMethodId);
		system.debug('##MNE SM_Payment precessCreatePayment zEntityId >> '+zEntityId);
		system.debug('##MNE SM_Payment precessCreatePayment access_token >> '+access_token);
		
		//creation du json
		String bodyCreatePayment = getBodyCreatePayment(accountId, invoiceId, amount, paymentMethodId);
		system.debug('##MNE SM_Payment precessCreatePayment bodyCreatePayment >> '+bodyCreatePayment);
		
		String method = 'POST';
		String wsOut = WS001_CallZuora.sendRequest(access_token, endpoint, zEntityId, method, bodyCreatePayment, 'type1', '211.0');
        
        /*//call out new product Amendment
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:ZuoraAPI'+endpoint);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Zuora-Entity-Ids', zEntityId);
        req.setHeader('Authorization', 'Bearer '+access_token);
        req.setTimeout(60000);
        req.setBody(bodyCreatePayment);
        HttpResponse res = h.send(req);
        String repWS = res.getBody();
        system.debug('##MNE SM_Payment precessCreatePayment repWS >> '+repWS);
        
        //deserialisation du resultat de l'Amendment
        SM001_GesteCommercial.Resultat resApex =   (SM001_GesteCommercial.Resultat)System.JSON.deserialize(repWS, SM001_GesteCommercial.Resultat.class);
        System.debug('##MNE SM_Payment precessCreatePayment resJsonOriginal >> '+repWS);
        System.debug('##MNE SM_Payment precessCreatePayment resApex >> '+resApex);
        
        //gestion erreur de l'Amendment
        Boolean success = true;
        String messageError = '';
        if(resApex != null && resApex.results != null  && resApex.results.size() > 0){
        	for(SM001_GesteCommercial.Result r : resApex.results){
        		if(!r.Success){
        			if(r.Errors != null && r.Errors.size() > 0){
        				throw new MyException(r.Errors.get(0).Message);
        			}
        		}
        	}
        }*/
        
	}

    
    public static String getBodyCreatePayment(String accountId, String invoiceId, Decimal amount, String paymentMethodId){
        try{
            WSZ.CreatePaymentIn res = new WSZ.CreatePaymentIn(accountId, invoiceId, amount, paymentMethodId);
            String s = JSON.serialize(res);
            s = s.replace('typeX','type');
            s = s.replace('currencyX','currency');
            system.debug('##MNE SM_Payment getBodyCreatePatment json rep >> '+s);
            return s;
        }catch(Exception e){
            system.debug('##MNE SM_Payment getBodyCreatePatment exception >> '+e.getMessage());
            throw e;
        }
    }



}