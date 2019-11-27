@RestResource(urlMapping='/impaye/*')
global with sharing class WSIN_Impaye {

    @HttpPost
    global static void offreHttpPost() {

        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        WSZ.GenericOut wsOut = new WSZ.GenericOut();

        Datetime startTime = System.now();
        Boolean enableResponseTime = Boolean.valueOf(Utils.getUgcGenericParam('Enable Response Time Log',null).ParamValue__c);

        switch on req.params.get('action') {
            when 'getimpaye'{
                getImpaye(req,res);
            }
            when 'reglerimpaye'{
                reglerImpaye(req,res);
            }
            when else{
                wsOut.success = false;
                wsOut.message = 'Requette inconnue, verifiez les parametres';
                res.responseBody = Blob.valueOf(JSON.serializePretty(wsOut, true));
            }
        }

        if (enableResponseTime){
            Datetime endTime = System.now();
            ProcessLog__c pLog2 = new ProcessLog__c(Process__c = 'ResponseTime_'+req.params.get('action'), StartTime__c = startTime, EndTime__c = endTime);
            insert pLog2;
        }

    }

    public static void getImpaye(RestRequest req, RestResponse res) {

        WSZ.ImpayeOut wsOut = new WSZ.ImpayeOut();
        Blob body = req.requestBody;
        String respBodyStr = null;
        WSZ.ImpayeIn wsIn = new WSZ.ImpayeIn();

        try {
            wsIn = (WSZ.ImpayeIn) JSON.deserializeStrict(body.toString(), WSZ.ImpayeIn.class);
            wsOut = SM_Impaye.getImpaye(wsIn.accountId,wsIN.subscriptionId);
            wsOut.success = true;
            wsOut.message = null;
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
            //respBodyStr = res.responseBody.toString();
            // respBodyStr = respBodyStr.replace('"lieu_c"', '"Lieu__c"');
            // respBodyStr = respBodyStr.replace('"intitule_c"', '"Intitule__c"');
            // respBodyStr = respBodyStr.replace('"agent_c"', '"Agent__c"');
            //res.responseBody = Blob.valueOf(respBodyStr);
        }
    }


    public static void reglerImpaye(RestRequest req, RestResponse res) {

        WSZ.ImpayeReglerOut wsOut = new WSZ.ImpayeReglerOut();
        WSZ.ImpayeReglerIn wsIn; // = new WSZ.ImpayeReglerIn();
        // WSZ.ImpayeReglerIn wsIn = new WSZ.ImpayeReglerIn();
        Blob body = req.requestBody;
        String respBodyStr = null;
        String accountId; // pour la log
        
        try {
            wsIn = (WSZ.ImpayeReglerIn) JSON.deserializeStrict(body.toString(), WSZ.ImpayeReglerIn.class);
            accountId = wsIn.accountId; // pour la log
            wsOut = SM_Impaye.reglerImpaye(wsIn);
            wsOut.success = true;
            wsOut.message = null;
            wsOut.errorCode = null;
            //wsOut = subProducts.clone();
        } catch (RTException e) {
            wsOut.success = false;
            wsOut.message = e.getMessage();
            wsOut.errorCode = e.Code;
            //Util.pLog(e.pLog);
        } catch (Exception e) {
            wsOut.success = false;
            wsOut.message = e.getMessage() + e.getStackTraceString();
            insert new ProcessLog__c(Message__c = wsOut.message, AccountZID__c = accountId);

        } finally {
            //return wsOut;
            res.responseBody = Blob.valueOf(JSON.serializePretty(wsOut, false));

        }
    }

}