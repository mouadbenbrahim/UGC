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


    public static zc_CreatePaymentType createExtPayment(String invoiceId, String accountZID, WSZ.Paiement pa){

        // Creation paiement Zuora
        //TODO check si montant invoice = montant paye: il faut un call getinvoice, car le montant ne se trouve pas dans le resultat du subscribe
        // if (acqIn.paiement.montant != resObj.results.get(0).invoiceResult) ..etc
        zc_CreatePaymentType payment = new zc_CreatePaymentType();
        payment.accountId = accountZID;
        payment.amount = pa.montant;
        payment.currency2 = 'EUR';
        payment.r_type = zc_CreatePaymentType.RTypeEnum.External; //TODO
        String pmMethodId = Utils.getUgcGenericParam('Zuora_PM_'+'CBI','033').ParamValue__c; //TODO
        payment.paymentMethodId = pmMethodId;
        payment.effectiveDate = Date.today();
        payment.referenceId = pa.refPaiement;
        payment.methodePaiement = pa.methodePaiement; //TODO si mapping a faire
        payment.lieu = pa.lieu;
        payment.agent = pa.agent;
        if (pa.methodePaiement == 'VIR') {payment.dateVirement = pa.dateVirement;}
        zc_PaymentInvoiceApplicationCreateR invoice1 = new zc_PaymentInvoiceApplicationCreateR(); // Invoice Amend : FG + DNE
        invoice1.amount = pa.montant; //TODO champ obligatoire, soit on requette invoice dans zuora, ou bien on utitilise les donnes du acqIn
        invoice1.invoiceId = invoiceId;
        payment.invoices.add(invoice1);

        //Call WS Payment
        // String accessToken = WS001_CallZuora.access_token;
        // String zEntityId = WS001_CallZuora.getZuoraEntityId('033');        
        // zc_GETARPaymentType paymentRes = zc_Api.paymentsPOST2(accessToken, zEntityId, payment, RTExceptionCode.ERREUR_IMPAYE_REGLER_APPLICATION_PAYMENT,new ProcessLog__c());

        return payment;

    }

    public static zc_CreatePaymentType createElecPayment(String invoiceId, String accountZID, WSZ.Paiement pa){

        // Creation paiement Zuora
        //TODO check si montant invoice = montant paye: il faut un call getinvoice, car le montant ne se trouve pas dans le resultat du subscribe
        // if (acqIn.paiement.montant != resObj.results.get(0).invoiceResult) ..etc
        zc_CreatePaymentType payment = new zc_CreatePaymentType();
        payment.accountId = accountZID;
        payment.amount = pa.montant;
        payment.currency2 = 'EUR';
        payment.r_type = zc_CreatePaymentType.RTypeEnum.Electronic; //TODO
        //String pmMethodId = Utils.getUgcGenericParam('Zuora_PM_'+'CBI','033').ParamValue__c; //TODO
        //payment.paymentMethodId = pmMethodId;
        String gatewayId = Utils.getUgcGenericParam('Zuora Gateway Id','033').ParamValue__c; //TODO country
        payment.gatewayId = gatewayId;
        //payment.effectiveDate = Date.today();
        //payment.referenceId = pa.refPaiement;
        payment.methodePaiement = 'PRE';
        //payment.lieu = pa.lieu;
        //payment.agent = pa.agent;
        //if (pa.methodePaiement == 'VIR') {payment.dateVirement = pa.dateVirement;}
        zc_PaymentInvoiceApplicationCreateR invoice1 = new zc_PaymentInvoiceApplicationCreateR(); // Invoice Amend : FG + DNE
        invoice1.amount = pa.montant; //TODO champ obligatoire, soit on requette invoice dans zuora, ou bien on utitilise les donnes du acqIn
        invoice1.invoiceId = invoiceId;
        payment.invoices.add(invoice1);

        //Call WS Payment
        // String accessToken = WS001_CallZuora.access_token;
        // String zEntityId = WS001_CallZuora.getZuoraEntityId('033');        
        // zc_GETARPaymentType paymentRes = zc_Api.paymentsPOST2(accessToken, zEntityId, payment, RTExceptionCode.ERREUR_IMPAYE_REGLER_APPLICATION_PAYMENT,new ProcessLog__c());

        return payment;

    }

}