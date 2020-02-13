@RestResource(urlMapping='/sub/*')
global with sharing class WSIN_Subscription {

    @HttpPost
    global static void subHttpPost() {

        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        WSZ.GenericOut wsOut = new WSZ.GenericOut();
        Boolean isTest;

        Datetime startTime = System.now();
        Boolean enableResponseTime = Boolean.valueOf(Utils.getUgcGenericParam('Enable Response Time Log',null).ParamValue__c);

        String uri = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        res.addHeader('Content-Type', 'application/json');

        switch on uri {
            when 'acquisition'{
                acquisition(req,res,false);
            }
            when 'acquisitiontest'{
                acquisition(req,res,true);
            }            
            when 'renouvellement'{
                renouvellement(req,res,false);
            }
            when 'renouvellementtest'{
                renouvellement(req,res,true);
            }            
            when 'migration'{
                migration(req,res,false);
            }
            when 'migrationtest'{
                migration(req,res,true);
            }            
            when 'changebanque'{
                changebanque(req,res);
            }
            when 'reedition'{
                reedition(req,res,false);
            }
            when 'reeditiontest'{
                reedition(req,res,true);
            }            
            when 'opeautorise'{
                opeauthorize(req,res);
            }            
            when 'contratfile'{
                contratfile(req,res);
            }
            when 'preview'{
                preview(req,res);
            }
            when 'renewsample'{
                renewsamplefile(req,res);
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
       
    public static void acquisition(RestRequest req, RestResponse res, Boolean isTest) {

        WSZ.SubOpeOut wsOut = new WSZ.SubOpeOut();
        WSZ.SubOpeIn wsIn; // = new WSZ.SubOpeIn();
        Blob body = req.requestBody;
        String respBodyStr = null;
        Boolean isPreview = false;
        
        try {
            wsIn = (WSZ.SubOpeIn) JSON.deserializeStrict(body.toString(), WSZ.SubOpeIn.class);
            wsOut = (WSZ.SubOpeOut)SM_Acquisition.acquisition(wsIn, isPreview).get('acquisition');
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
            //ProcessLog__c pLog = new ProcessLog__c(Process__c = 'acquisition', Account__c = wsIn.accountSFID, Message__c = fullMessage);
            ProcessLog__c pLog = new ProcessLog__c(Process__c = 'acquisition', Message__c = fullMessage);
            insert pLog;
        } finally {
            //return wsOut;

            String strOut = JSON.serializePretty(wsOut, false);
            //WSZ.SubOpeOutH wsOutH = (WSZ.SubOpeOutH)JSON.deserialize(strOut, WSZ.SubOpeOutH.class);
            WSZ.SubOpeOut wsOutH = (WSZ.SubOpeOut)JSON.deserialize(strOut, WSZ.SubOpeOut.class);
            if(!isTest){
                res.responseBody = Blob.valueOf(JSON.serializePretty(wsOutH, false));
            }else {
                res.responseBody = Blob.valueOf(JSON.serializePretty(wsOut, false));
            }
            
        }
    }

    public static void renouvellement(RestRequest req, RestResponse res, Boolean isTest) {

        WSZ.SubOpeOut wsOut = new WSZ.SubOpeOut();
        WSZ.SubOpeIn wsIn; // = new WSZ.SubOpeIn();
        Blob body = req.requestBody;
        String respBodyStr = null;
        Boolean isPreview = false;
        
        try {
            wsIn = (WSZ.SubOpeIn) JSON.deserializeStrict(body.toString(), WSZ.SubOpeIn.class);
            wsOut = (WSZ.SubOpeOut)SM_Renouvellement.renouvellement(wsIn, isPreview).get('renouvellement');
            wsOut.success = true;
            wsOut.message = null;
        } catch (RTException e) {
            wsOut.success = false;
            wsOut.message = e.getMessage();
            wsOut.errorCode = e.Code;
        } catch (Exception e) {
            wsOut.success = false;
            wsOut.errorCode = 111;
            wsOut.message = e.getMessage();
            //wsOut.message = e.getMessage() + e.getStackTraceString() + body.toString();
            String fullMessage = e.getMessage() + e.getStackTraceString() + e.getTypeName() + e.getCause() + e.getLineNumber() + body.toString();
            //ProcessLog__c pLog = new ProcessLog__c(Process__c = 'renouvellement', Account__c = wsIn.accountSFID, SubscriptionName__c = wsIn.subscriptionName ,Message__c = fullMessage);
            //insert pLog;
        } finally {
            wsOut.refGuid = wsIn.refGuid;
            String strOut = JSON.serializePretty(wsOut, false);
            //WSZ.SubOpeOutH wsOutH = (WSZ.SubOpeOutH)JSON.deserialize(strOut, WSZ.SubOpeOutH.class);
            WSZ.SubOpeOut wsOutH = (WSZ.SubOpeOut)JSON.deserialize(strOut, WSZ.SubOpeOut.class);
            if(!isTest){
                res.responseBody = Blob.valueOf(JSON.serializePretty(wsOutH, false));
            }else {
                res.responseBody = Blob.valueOf(JSON.serializePretty(wsOut, false));
            }
        }
    }
    
    // public static void renouvellement_old(RestRequest req, RestResponse res) {

    //     WSZ.SubHermesOut wsOut = new WSZ.SubHermesOut();
    //     WSZ.SubHermesIn wsIn; // = new WSZ.SubHermesIn();
    //     Blob body = req.requestBody;
    //     String respBodyStr = null;
        
    //     try {
    //         wsIn = (WSZ.SubHermesIn) JSON.deserializeStrict(body.toString(), WSZ.SubHermesIn.class);
    //         wsOut = SM_Hermes.renouvellement(wsIn);
    //         wsOut.success = true;
    //         wsOut.message = null;
    //         //wsOut = subProducts.clone();
    //     } catch (RTException e) {
    //         wsOut.success = false;
    //         wsOut.message = e.getMessage();
    //         wsOut.errorCode = e.Code;
    //     } catch (Exception e) {
    //         wsOut.success = false;
    //         wsOut.message = e.getMessage() + e.getStackTraceString();
    //         String fullMessage = e.getMessage() + e.getStackTraceString() + e.getTypeName() + e.getCause() + e.getLineNumber() + body.toString();
    //         ProcessLog__c pLog = new ProcessLog__c(Process__c = 'renouvellement', Account__c = wsIn.accountId, AccountZID__c = wsIn.accountZID, SubscriptionZID__c = wsIn.subscriptionZID, SubscriptionName__c = wsIn.subscriptionName ,Message__c = fullMessage);
    //         insert pLog;            
    //     } finally {
    //         //return wsOut;
    //         res.responseBody = Blob.valueOf(JSON.serializePretty(wsOut, false));
    //     }
    // }    

    public static void migration(RestRequest req, RestResponse res, Boolean isTest) {

        WSZ.SubOpeOut wsOut = new WSZ.SubOpeOut();
        WSZ.SubOpeIn wsIn; // = new WSZ.SubOpeIn();
        Blob body = req.requestBody;
        String respBodyStr = null;
        Boolean isPreview = false;
        
        try {
            wsIn = (WSZ.SubOpeIn) JSON.deserializeStrict(body.toString(), WSZ.SubOpeIn.class);
            wsOut = (WSZ.SubOpeOut)SM_Migration.migration(wsIn,isPreview).get('migration');
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
            ProcessLog__c pLog = new ProcessLog__c(Process__c = 'migration', Account__c = wsIn.accountSFID, SubscriptionName__c = wsIn.subscriptionName ,Message__c = fullMessage);
            insert pLog;
        } finally {
            String strOut = JSON.serializePretty(wsOut, false);
            //WSZ.SubOpeOutH wsOutH = (WSZ.SubOpeOutH)JSON.deserialize(strOut, WSZ.SubOpeOutH.class);
            WSZ.SubOpeOut wsOutH = (WSZ.SubOpeOut)JSON.deserialize(strOut, WSZ.SubOpeOut.class);
            if(!isTest){
                res.responseBody = Blob.valueOf(JSON.serializePretty(wsOutH, false));
            }else {
                res.responseBody = Blob.valueOf(JSON.serializePretty(wsOut, false));
            }
        }
    } 

    public static void changebanque(RestRequest req, RestResponse res) {

        WSZ.ChangeBanqueOut wsOut = new WSZ.ChangeBanqueOut();
        WSZ.ChangeBanqueIn wsIn;
        Blob body = req.requestBody;
        try {
            wsIn = (WSZ.ChangeBanqueIn) JSON.deserializeStrict(body.toString(), WSZ.ChangeBanqueIn.class);
            //wsOut = SM_Hermes.changebanque(wsIn);
            wsOut = SM_ChangeBanque.changebanque(wsIn); 
            wsOut.success = true;
            wsOut.message = null;
        } catch (RTException e) {
            wsOut.success = false;
            wsOut.message = e.getMessage();
            wsOut.errorCode = e.Code;
        } catch (Exception e) {
            wsOut.success = false;
            wsOut.message = e.getMessage() + e.getStackTraceString();
            String fullMessage = e.getMessage() + e.getStackTraceString() + e.getTypeName() + e.getCause() + e.getLineNumber() + body.toString();
            ProcessLog__c pLog = new ProcessLog__c(Process__c = 'changebanque', Account__c = wsIn.accountSFID, SubscriptionName__c = wsIn.subscriptionName ,Message__c = fullMessage);
            insert pLog;            
        } finally {
            res.responseBody = Blob.valueOf(JSON.serializePretty(wsOut, false));
        }
    } 

    public static void reedition(RestRequest req, RestResponse res, Boolean isTest) {

        WSZ.ReeditionOut wsOut = new WSZ.ReeditionOut();
        WSZ.ReeditionIn wsIn; // = new WSZ.SubHermesIn();
        Blob body = req.requestBody;
        String respBodyStr = null;
        
        try {
            wsIn = (WSZ.ReeditionIn) JSON.deserializeStrict(body.toString(), WSZ.ReeditionIn.class);
            wsOut = SM_ReeditionCarte.reedition(wsIn);
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
            ProcessLog__c pLog = new ProcessLog__c(Process__c = 'reedition', Account__c = wsIn.accountSFID, SubscriptionName__c = wsIn.subscriptionName ,Message__c = fullMessage);
            insert pLog;             
        } finally {
            String strOut = JSON.serializePretty(wsOut, false);
            //WSZ.ReeditionOutH wsOutH = (WSZ.ReeditionOutH)JSON.deserialize(strOut, WSZ.ReeditionOutH.class);
            WSZ.ReeditionOut wsOutH = (WSZ.ReeditionOut)JSON.deserialize(strOut, WSZ.ReeditionOut.class);
            if(!isTest){
                res.responseBody = Blob.valueOf(JSON.serializePretty(wsOutH, false));
            }else {
                res.responseBody = Blob.valueOf(JSON.serializePretty(wsOut, false));
            }
        }
    } 

	public static void opeauthorize(RestRequest req, RestResponse res) {
        WSZ.AuthorizeOut wsOut = new WSZ.AuthorizeOut();
        WSZ.AuthorizeIn wsIn;
        Blob body = req.requestBody;
        String respBodyStr = null;
        
        //a supprimer apres la recette
        Boolean pLogAlreadyInsered = false;
        
        try {
            wsIn = (WSZ.AuthorizeIn) JSON.deserializeStrict(body.toString(), WSZ.AuthorizeIn.class);
            wsOut = SM_Autorisation.opeauthorize(wsIn);
        } catch (RTException e) {
            wsOut.success = false;
            wsOut.message = e.getMessage();
            wsOut.errorCode = e.Code;
        } catch (Exception e) {
            wsOut.success = false;
            wsOut.message = e.getMessage() + e.getStackTraceString();
            String fullMessage = e.getMessage() + e.getStackTraceString() + e.getTypeName() + e.getCause() + e.getLineNumber() + body.toString();
            ProcessLog__c pLog = new ProcessLog__c(Process__c = 'opeauthorize', Account__c = wsIn.accountSFID, Message__c = fullMessage);
            insert pLog;  
            //a supprimer apres la recette 
            pLogAlreadyInsered = true;          
        } finally {
            res.responseBody = Blob.valueOf(JSON.serializePretty(wsOut, false));
            //a supprimer apres la recette
            if(!pLogAlreadyInsered){
                ProcessLog__c pLog = new ProcessLog__c(Process__c = 'opeauthorize_OK', Account__c = wsIn.accountSFID, Message__c = 'WSIN => '+body.toString()+' \nWSOUT => '+JSON.serializePretty(wsOut, false));
                insert pLog; 
            }
        }
    }

    public static void contratfile(RestRequest req, RestResponse res) {

        WSZ.ContratFileOut wsOut = new WSZ.ContratFileOut();
        WSZ.ContratFileIn wsIn; // = new WSZ.SubHermesIn();
        Blob body = req.requestBody;
        String respBodyStr = null;
        
        try {
            wsIn = (WSZ.ContratFileIn) JSON.deserializeStrict(body.toString(), WSZ.ContratFileIn.class);
            wsOut = SM_Subscription.getContratFile(wsIn);
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
            ProcessLog__c pLog;
            if (wsIn == null) { // pb deserialization
                pLog = new ProcessLog__c(Process__c = 'contratfile', Message__c = fullMessage);
            }else {
                pLog = new ProcessLog__c(Process__c = 'contratfile', Account__c = wsIn.accountSFID, SubscriptionName__c = wsIn.subscriptionName, Message__c = fullMessage);
            }
            //
            insert pLog;             
        } finally {
            //return wsOut;
            res.responseBody = Blob.valueOf(JSON.serializePretty(wsOut, false));
        }
    }

    public static void preview(RestRequest req, RestResponse res) {

        WSZ.ProxyPreviewOut wsOut = new WSZ.ProxyPreviewOut();
        WSZ.Preview prev;
        WSZ.SubOpeIn wsIn;
        Blob body = req.requestBody;
        String respBodyStr = null;
        Boolean isPreview = true;
        
        
        try {
            wsIn = (WSZ.SubOpeIn) JSON.deserializeStrict(body.toString(), WSZ.SubOpeIn.class);
            wsOut.accountSFID = wsIn.accountSFID;
            for(String pdt: wsIn.produits){
                prev = new WSZ.Preview();
                wsIn.produit = pdt;
                if (wsIn.operation == 'acquisition') prev = (WSZ.Preview)SM_Acquisition.acquisition(wsIn, isPreview).get('preview');
                if (wsIn.operation == 'renouvellement') prev = (WSZ.Preview)SM_Renouvellement.renouvellement(wsIn, isPreview).get('preview');
                if (wsIn.operation == 'migration') prev = (WSZ.Preview)SM_Migration.migration(wsIn, isPreview).get('preview');
                wsOut.preview.add(prev);
            }
            wsOut.success = true;
            wsOut.message = null;
            //wsOut = subProducts.clone();
        } catch (RTException e) {
            wsOut.preview = new List<WSZ.Preview>();
            wsOut.success = false;
            wsOut.message = e.getMessage();
            wsOut.errorCode = e.Code;
        } catch (Exception e) {
            wsOut.preview = new List<WSZ.Preview>();
            wsOut.success = false;
            wsOut.message = e.getMessage() + e.getStackTraceString();
            String fullMessage = e.getMessage() + e.getStackTraceString() + e.getTypeName() + e.getCause() + e.getLineNumber() + body.toString();
            ProcessLog__c pLog = new ProcessLog__c(Process__c = 'preview', Account__c = wsIn.accountSFID, Message__c = fullMessage);
            insert pLog;
        } finally {
            //return wsOut;
            res.responseBody = Blob.valueOf(JSON.serializePretty(wsOut, false));
        }
    }

    public static void renewsamplefile(RestRequest req, RestResponse res) {

        Blob wsOut;
        String msg;
        SM_TestHelper.RenewSampleIn wsIn; // = new WSZ.SubHermesIn();
        Blob body = req.requestBody;
        String respBodyStr = null;
        res.addHeader('Content-Type', 'text/csv');
        
        
        try {
            wsIn = (SM_TestHelper.RenewSampleIn) JSON.deserializeStrict(body.toString(), SM_TestHelper.RenewSampleIn.class);
            wsOut = SM_TestHelper.genRenewDataSample(wsIn);
            // wsOut.success = true;
            // wsOut.message = null;
            //wsOut = subProducts.clone();
        } catch (RTException e) {
            // wsOut.success = false;
            // wsOut.message = e.getMessage();
            // wsOut.errorCode = e.Code;
            wsOut = Blob.valueOf('Erreur: ');
        } catch (Exception e) {
            msg ='Erreur: ';
            // wsOut.success = false;
            msg += e.getMessage() + e.getStackTraceString();
            wsOut = Blob.valueOf(msg);
            String fullMessage = e.getMessage() + e.getStackTraceString() + e.getTypeName() + e.getCause() + e.getLineNumber() + body.toString();
            ProcessLog__c pLog;
            if (wsIn == null) { // pb deserialization
                pLog = new ProcessLog__c(Process__c = 'genRenewDataSample', Message__c = fullMessage);
            }else {
                pLog = new ProcessLog__c(Process__c = 'genRenewDataSample', Message__c = fullMessage);
            }
            //
            insert pLog;             
        } finally {
            //return wsOut;
            res.responseBody = wsOut;
        }
    }

}