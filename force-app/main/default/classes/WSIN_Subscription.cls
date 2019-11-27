@RestResource(urlMapping='/sub/*')
global with sharing class WSIN_Subscription {

    @HttpPost
    global static void subHttpPost() {

        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        WSZ.GenericOut wsOut = new WSZ.GenericOut();

        Datetime startTime = System.now();
        Boolean enableResponseTime = Boolean.valueOf(Utils.getUgcGenericParam('Enable Response Time Log',null).ParamValue__c);

        String uri = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);

        switch on uri {
            when 'acquisition'{
                acquisition(req,res);
            }
            when 'renouvellement'{
                renouvellement(req,res);
            }
            when 'migration'{
                migration(req,res);
            }
            when 'changebanque'{
                changebanque(req,res);
            }
            when 'reedition'{
                reedition(req,res);
            }                          
            when else{
                wsOut.success = false;
                wsOut.message = 'Requette inconnue, verifiez les parametres';
                res.responseBody = Blob.valueOf(JSON.serializePretty(wsOut, true));
            }
        }
        
        if (enableResponseTime){
            Datetime endTime = System.now();
            ProcessLog__c pLog2 = new ProcessLog__c(Process__c = 'ResponseTime_'+uri, StartTime__c = startTime, EndTime__c = endTime);
            insert pLog2;
        }

    }
    
    
    public static void acquisition(RestRequest req, RestResponse res) {

        WSZ.SubHermesOut wsOut = new WSZ.SubHermesOut();
        WSZ.SubHermesIn wsIn; // = new WSZ.SubHermesIn();
        Blob body = req.requestBody;
        String respBodyStr = null;
        
        try {
            wsIn = (WSZ.SubHermesIn) JSON.deserializeStrict(body.toString(), WSZ.SubHermesIn.class);
            wsOut = SM_Hermes.acquisition(wsIn);
            wsOut.success = true;
            wsOut.message = null;
            //wsOut = subProducts.clone();
        } catch (RTException e) {
            wsOut.success = false;
            wsOut.message = e.getMessage();
            wsOut.errorCode = e.Code;
        } catch (Exception e) {
            wsOut.success = false;
            wsOut.message = e.getMessage() + e.getStackTraceString();
            String fullMessage = e.getMessage() + e.getStackTraceString() + e.getTypeName() + e.getCause() + e.getLineNumber() + body.toString();
            ProcessLog__c pLog = new ProcessLog__c(Process__c = 'acquisition', Account__c = wsIn.accountId, AccountZID__c = wsIn.accountZID, SubscriptionZID__c = wsIn.subscriptionZID, SubscriptionName__c = wsIn.subscriptionName ,Message__c = fullMessage);
            insert pLog;
        } finally {
            //return wsOut;
            res.responseBody = Blob.valueOf(JSON.serializePretty(wsOut, false));
        }
    }

    public static void renouvellement(RestRequest req, RestResponse res) {

        WSZ.SubHermesOut wsOut = new WSZ.SubHermesOut();
        WSZ.SubHermesIn wsIn; // = new WSZ.SubHermesIn();
        Blob body = req.requestBody;
        String respBodyStr = null;
        
        try {
            wsIn = (WSZ.SubHermesIn) JSON.deserializeStrict(body.toString(), WSZ.SubHermesIn.class);
            wsOut = SM_Hermes.renouvellement(wsIn);
            wsOut.success = true;
            wsOut.message = null;
            //wsOut = subProducts.clone();
        } catch (RTException e) {
            wsOut.success = false;
            wsOut.message = e.getMessage();
            wsOut.errorCode = e.Code;
        } catch (Exception e) {
            wsOut.success = false;
            wsOut.message = e.getMessage() + e.getStackTraceString();
            String fullMessage = e.getMessage() + e.getStackTraceString() + e.getTypeName() + e.getCause() + e.getLineNumber() + body.toString();
            ProcessLog__c pLog = new ProcessLog__c(Process__c = 'renouvellement', Account__c = wsIn.accountId, AccountZID__c = wsIn.accountZID, SubscriptionZID__c = wsIn.subscriptionZID, SubscriptionName__c = wsIn.subscriptionName ,Message__c = fullMessage);
            insert pLog;            
        } finally {
            //return wsOut;
            res.responseBody = Blob.valueOf(JSON.serializePretty(wsOut, false));
        }
    }    

    public static void migration(RestRequest req, RestResponse res) {

        WSZ.SubHermesOut wsOut = new WSZ.SubHermesOut();
        WSZ.SubHermesIn wsIn; // = new WSZ.SubHermesIn();
        Blob body = req.requestBody;
        String respBodyStr = null;
        
        try {
            wsIn = (WSZ.SubHermesIn) JSON.deserializeStrict(body.toString(), WSZ.SubHermesIn.class);
            wsOut = SM_Hermes.migration(wsIn);
            wsOut.success = true;
            wsOut.message = null;
            //wsOut = subProducts.clone();
        } catch (RTException e) {
            wsOut.success = false;
            wsOut.message = e.getMessage();
            wsOut.errorCode = e.Code;
        } catch (Exception e) {
            wsOut.success = false;
            wsOut.message = e.getMessage() + e.getStackTraceString();
            String fullMessage = e.getMessage() + e.getStackTraceString() + e.getTypeName() + e.getCause() + e.getLineNumber() + body.toString();
            ProcessLog__c pLog = new ProcessLog__c(Process__c = 'migration', Account__c = wsIn.accountId, AccountZID__c = wsIn.accountZID, SubscriptionZID__c = wsIn.subscriptionZID, SubscriptionName__c = wsIn.subscriptionName ,Message__c = fullMessage);
            insert pLog;
        } finally {
            //return wsOut;
            res.responseBody = Blob.valueOf(JSON.serializePretty(wsOut, false));
        }
    } 

    public static void changebanque(RestRequest req, RestResponse res) {

        WSZ.SubHermesOut wsOut = new WSZ.SubHermesOut();
        WSZ.SubHermesIn wsIn; // = new WSZ.SubHermesIn();
        Blob body = req.requestBody;
        String respBodyStr = null;
        
        try {
            wsIn = (WSZ.SubHermesIn) JSON.deserializeStrict(body.toString(), WSZ.SubHermesIn.class);
            wsOut = SM_Hermes.changebanque(wsIn);
            wsOut.success = true;
            wsOut.message = null;
            //wsOut = subProducts.clone();
        } catch (RTException e) {
            wsOut.success = false;
            wsOut.message = e.getMessage();
            wsOut.errorCode = e.Code;
        } catch (Exception e) {
            wsOut.success = false;
            wsOut.message = e.getMessage() + e.getStackTraceString();
            String fullMessage = e.getMessage() + e.getStackTraceString() + e.getTypeName() + e.getCause() + e.getLineNumber() + body.toString();
            ProcessLog__c pLog = new ProcessLog__c(Process__c = 'changebanque', Account__c = wsIn.accountId, AccountZID__c = wsIn.accountZID, SubscriptionZID__c = wsIn.subscriptionZID, SubscriptionName__c = wsIn.subscriptionName ,Message__c = fullMessage);
            insert pLog;            
        } finally {
            //return wsOut;
            res.responseBody = Blob.valueOf(JSON.serializePretty(wsOut, false));
        }
    } 

    public static void reedition(RestRequest req, RestResponse res) {

        WSZ.SubHermesOut wsOut = new WSZ.SubHermesOut();
        WSZ.SubHermesIn wsIn; // = new WSZ.SubHermesIn();
        Blob body = req.requestBody;
        String respBodyStr = null;
        
        try {
            wsIn = (WSZ.SubHermesIn) JSON.deserializeStrict(body.toString(), WSZ.SubHermesIn.class);
            wsOut = SM_Hermes.reedition(wsIn);
            wsOut.success = true;
            wsOut.message = null;
            //wsOut = subProducts.clone();
        } catch (RTException e) {
            wsOut.success = false;
            wsOut.message = e.getMessage();
            wsOut.errorCode = e.Code;
        } catch (Exception e) {
            wsOut.success = false;
            wsOut.message = e.getMessage() + e.getStackTraceString();
            String fullMessage = e.getMessage() + e.getStackTraceString() + e.getTypeName() + e.getCause() + e.getLineNumber() + body.toString();
            ProcessLog__c pLog = new ProcessLog__c(Process__c = 'reedition', Account__c = wsIn.accountId, AccountZID__c = wsIn.accountZID, SubscriptionZID__c = wsIn.subscriptionZID, SubscriptionName__c = wsIn.subscriptionName ,Message__c = fullMessage);
            insert pLog;             
        } finally {
            //return wsOut;
            res.responseBody = Blob.valueOf(JSON.serializePretty(wsOut, false));
        }
    } 


}