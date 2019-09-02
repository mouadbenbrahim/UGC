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
    

	public static string precessCreatePayment(String accountId, String invoiceId, Decimal amount, String paymentMethodId, String zEntityId, String access_token){
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
		system.debug('##MNE SM_Payment precessCreatePayment wsOut >> '+wsOut);
		return wsOut;        
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