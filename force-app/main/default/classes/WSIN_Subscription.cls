@RestResource(urlMapping='/sub/*')
global with sharing class WSIN_Subscription {

    @HttpPost
    global static void subHttpPost() {

        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        WSZ.GenericOut wsOut = new WSZ.GenericOut();

        String uri = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);

        switch on uri {
            when 'acquisition'{
                acquisition(req,res);
            }
            when 'renouvellement'{
                //reglerImpaye(req,res);
            }
            when 'migration'{
                //reglerImpaye(req,res);
            }
            when 'changebanque'{
                //reglerImpaye(req,res);
            }
            when 'reedition'{
                //reglerImpaye(req,res);
            }                          
            when else{
                wsOut.success = false;
                wsOut.message = 'Requette inconnue, verifiez les parametres';
                res.responseBody = Blob.valueOf(JSON.serializePretty(wsOut, true));
            }
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
        } finally {
            //return wsOut;
            res.responseBody = Blob.valueOf(JSON.serializePretty(wsOut, false));
        }
    } 


}