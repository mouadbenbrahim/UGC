/**
 * Created by mouad on 09/09/2018.
 */

public with sharing class SM_CreditMemo {


    //public static String zEntityId = '8adce421-63ec-c07b-0163-f45782667179'; // France

    public static WSZ.CreditMemoOut getCreditMemo(String memoId, String zEntityId) {
        //String endpoint = 'https://rest.sandbox.eu.zuora.com/v1/creditmemos/' + memoId;
        String endpoint = '/v1/creditmemos/' + memoId;
        String method = 'GET';
        String wsIn = null;
        String wsOut = '';

        // Retrieve Zuora token
        String accessToken = WS001_CallZuora.access_token;

        wsOut = WS001_CallZuora.sendRequest(accessToken, endpoint, zEntityId, method, wsIn, 'type1', null);
        wsOut = wsOut.replace('number','numberx');
        wsOut = wsOut.replace('ExclusionCompta__c', 'exclusioncompta_c');
        //wsOut = wsOut.replace('currency', 'currencyx');
        return (WSZ.CreditMemoOut) JSON.deserializeStrict(wsOut, WSZ.CreditMemoOut.class);
    }

    public static WSZ.CreditMemoOut unpost(String memoId, String zEntityId) {
        //String endpoint = 'https://rest.sandbox.eu.zuora.com/v1/creditmemos/'+memoId+'/unpost';
        String endpoint = '/v1/creditmemos/'+memoId+'/unpost';
        String method = 'PUT';
        String wsIn = null;
        String wsOut = '';

        // Retrieve Zuora token
        String accessToken = WS001_CallZuora.access_token;

        wsOut = WS001_CallZuora.sendRequest(accessToken, endpoint, zEntityId, method, wsIn, 'type1', null);
        wsOut = wsOut.replace('number','numberx');
        wsOut = wsOut.replace('ExclusionCompta__c', 'exclusioncompta_c');
        //wsOut = wsOut.replace('currency', 'currencyx');
        return (WSZ.CreditMemoOut) JSON.deserializeStrict(wsOut, WSZ.CreditMemoOut.class);
    }

    public static WSZ.CreditMemoOut cancel(String memoId, String zEntityId) {
        //String endpoint = 'https://rest.sandbox.eu.zuora.com/v1/creditmemos/'+memoId+'/cancel';
        String endpoint = '/v1/creditmemos/'+memoId+'/cancel';
        String method = 'PUT';
        String wsIn = null;
        String wsOut = '';

        // Retrieve Zuora token
        String accessToken = WS001_CallZuora.access_token;

        wsOut = WS001_CallZuora.sendRequest(accessToken, endpoint, zEntityId, method, wsIn, 'type1', null);
        wsOut = wsOut.replace('number','numberx');
        wsOut = wsOut.replace('ExclusionCompta__c', 'exclusioncompta_c');
        //wsOut = wsOut.replace('currency', 'currencyx');
        return (WSZ.CreditMemoOut) JSON.deserializeStrict(wsOut, WSZ.CreditMemoOut.class);
    }
    
    
    public static WSZ.SubOut executeBillRun(String AccountId, String TargetDate, String zEntityId) {
        //TargetDate = cancelationDate
        String endpoint = '/v1/object/bill-run';
        String method = 'POST';
        String wsIn = null;
        String wsOut = '';

        // Retrieve Zuora token
        String accessToken = WS001_CallZuora.access_token;
        
        Date todayDate = Date.today();
        String zTodayDate = Util.zDate(todayDate);
        WSZ.BillRunlIn wsInObj = new WSZ.BillRunlIn();
        wsInObj.AccountId = AccountId;
        wsInObj.AutoEmail = false;
        wsInObj.AutoPost = true;
        wsInObj.AutoRenewal = false;
        wsInObj.InvoiceDate = zTodayDate ;
        wsInObj.TargetDate = TargetDate;
        wsIn = (String) JSON.serialize(wsInObj);
        
        system.debug('##MNE SM_CreditMemo executeBillRun wsIn >> '+wsIn);
        wsOut = WS001_CallZuora.sendRequest(accessToken, endpoint, zEntityId, method, wsIn, 'type1', null);
        system.debug('##MNE SM_CreditMemo executeBillRun wsOut >> '+wsOut);
        return (WSZ.SubOut) JSON.deserializeStrict(wsOut, WSZ.SubOut.class);
    }
    
    public static WSZ.CreditMemoOut updateCreditMemo(String memoId, String zEntityId, String ExclusionCompta) {
        //String endpoint = 'https://rest.sandbox.eu.zuora.com/v1/creditmemos/'+memoId;
        String endpoint = '/v1/creditmemos/'+memoId;
        String method = 'PUT';
        String wsIn = null;
        String wsOut = '';

        // Retrieve Zuora token
        String accessToken = WS001_CallZuora.access_token;

        WSZ.CreditMemoUpdateIn wsInObj = new WSZ.CreditMemoUpdateIn();
        wsInObj.exclusioncompta_c = ExclusionCompta;
        wsIn = (String) JSON.serialize(wsInObj);

        wsIn = wsIn.replace('exclusioncompta_c','ExclusionCompta__c');

        wsOut = WS001_CallZuora.sendRequest(accessToken, endpoint, zEntityId, method, wsIn, 'type1', null);
        wsOut = wsOut.replace('number','numberx');
        wsOut = wsOut.replace('ExclusionCompta__c', 'exclusioncompta_c');
        return (WSZ.CreditMemoOut) JSON.deserializeStrict(wsOut, WSZ.CreditMemoOut.class);
    }
    /*public static WSZ.RefundOut executeRefund(String creditMemoId, String refundDate, Decimal totalAmount, String typeX, String methodType, Boolean isSansRemboursement, String zEntityId) {
    	system.debug('##MNE SM_CreditMemo executeRefund creditMemoId >> '+creditMemoId);
    	system.debug('##MNE SM_CreditMemo executeRefund refundDate >> '+refundDate);
    	system.debug('##MNE SM_CreditMemo executeRefund totalAmount >> '+totalAmount);
    	system.debug('##MNE SM_CreditMemo executeRefund typeX >> '+typeX);
    	system.debug('##MNE SM_CreditMemo executeRefund methodType >> '+methodType);
    	system.debug('##MNE SM_CreditMemo executeRefund isSansRemboursement >> '+isSansRemboursement);
    	system.debug('##MNE SM_CreditMemo executeRefund zEntityId >> '+zEntityId);
    	
        String endpoint = '/v1/creditmemos/'+creditMemoId+'/refunds';
        String method = 'POST';
        String wsIn = null;
        String wsOut = '';
        
        // Retrieve Zuora token
        String accessToken = WS001_CallZuora.access_token;
        
        Date todayDate = Date.today();
        String zTodayDate = Util.zDate(todayDate);
        WSZ.RefundlIn wsInObj = new WSZ.RefundlIn();
        if(refundDate == null){
            wsInObj.refundDate = zTodayDate;
        }else{
            wsInObj.refundDate = refundDate;
        }
        wsInObj.totalAmount = totalAmount;
        wsInObj.typeX = typeX;
        wsInObj.methodType = methodType;
        if(isSansRemboursement){
            wsInObj.reasonCode = 'Sans Remboursement';
        }
        
        wsIn = (String) JSON.serialize(wsInObj);
        wsIn = wsIn.replace('typeX','type');
        wsIn = wsIn.replace('"reasonCode":null,','');
        wsIn = wsIn.replace('"reasonCode":null','');
        
        wsOut = WS001_CallZuora.sendRequest(accessToken, endpoint, zEntityId, method, wsIn, 'type1', '211.0');
        wsOut = wsOut.replace('number','numberX');
        wsOut = wsOut.replace('type','typeX');
        wsOut = wsOut.replace('Canal__c','Canal');
        wsOut = wsOut.replace('Agent__c','Agent');
        wsOut = wsOut.replace('Lieu__c','Lieu');
        
        return (WSZ.RefundOut) JSON.deserializeStrict(wsOut, WSZ.RefundOut.class);
    }*/
    
    /*public static WSZ.BillRunOut getBillRun(String billRunId) {
        String endpoint = '/v1/object/bill-run/'+billRunId;
        String method = 'GET';
        String wsIn = null;
        String wsOut = '';

        // Retrieve Zuora token
        String accessToken = WS001_CallZuora.access_token;

        wsOut = WS001_CallZuora.sendRequest(accessToken, endpoint, zEntityId, method, wsIn, 'type1', '211.0');
        return (WSZ.BillRunOut) JSON.deserializeStrict(wsOut, WSZ.BillRunOut.class);
    }*/
    
    /*public static WSZ.ListCreditMemosOut getListCreditMemosByBillRunNumber(String BillRunNumber) {
        String endpoint = '/v1/creditmemos?sourceId='+BillRunNumber;
        String method = 'GET';
        String wsIn = null;
        String wsOut = '';

        // Retrieve Zuora token
        String accessToken = WS001_CallZuora.access_token;

        wsOut = WS001_CallZuora.sendRequest(accessToken, endpoint, zEntityId, method, wsIn, 'type1', '211.0');
        wsOut = wsOut.replace('number','numberX');
        wsOut = wsOut.replace('currency', 'currencyX');
        return (WSZ.ListCreditMemosOut) JSON.deserializeStrict(wsOut, WSZ.ListCreditMemosOut.class);
    }*/
    
    
}