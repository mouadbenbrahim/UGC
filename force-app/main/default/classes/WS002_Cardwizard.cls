public with sharing class WS002_Cardwizard {

    public static String sendRequest(String endpoint, String method, String inBody){
        String wsOut = '';
        Boolean success = null;
        String msgError = '';

        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod(method);
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('apiKey', 'api_key');
        //req.setHeader('Authorization', 'Bearer '+access_token);
        if (inBody != null ) {req.setBody(inBody);}

        //req.setCompressed(true); si active erreur sur le retour JSON.
        req.setTimeout(60000);
        HttpResponse res = null;
        res = h.send(req);
        wsOut = res.getBody();

        //wsOut = wsOut.replace('"currency"', '"currencyTMP"');

        System.debug('##MBEN responseValue >> '+wsOut);
        //JSONParser
        //Object wsOut = (Object)JSON.deserializeStrict(responseValue,Object.class);

        success = checkWSsuccess(wsOut);
        if (!success || success == null){
            OUT_Error wsOutObj = (OUT_Error)JSON.deserializeStrict(wsOut,OUT_Error.class);
            System.debug('MBEN: Erreur: ' + wsOutObj.Message);
            msgError = wsOut;
            throw new MyException(msgError);
        }

        return wsOut;
    }

    public class MyException extends Exception{}


    public static Boolean checkWSsuccess(String JSONContent) {

        Boolean success = null;

        if (JSONContent.contains('ExceptionMessage') || JSONContent.contains('ExceptionType')) {success=false;}
        else {success=true;}

        if (success == false) {System.debug('MBEN success_false: ' + success);}
        if (success == true) {System.debug('MBEN success_true: ' + success);}
        if (success == null) {System.debug('MBEN success_null: ' + success);}

        return success;
    }

    public without sharing class OUT_Error {
        public String Message;
        public String ExceptionMessage;
        public String ExceptionType;
        public String StackTrace;
    }

}