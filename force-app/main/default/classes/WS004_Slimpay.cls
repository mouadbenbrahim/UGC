/**
 * Created by ext-dev-05 on 13/08/2019.
 */

public with sharing class WS004_Slimpay {

    public static String access_token;

    public static String getToken(String codePays) {
            if (access_token == null){
                access_token = oauthLogin(codePays);
            }
        return access_token;
    }

    public static String sendRequest(String codePays, String endpoint, String method, String inBody){
        //TODO gerer slimpay belgique

        String namedCredential = getNamedCredential(codePays);
        String wsOut = '';
        // Boolean success = null;
        // String msgError = '';
        String token = getToken(codePays);

        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:'+namedCredential+endpoint);
        req.setMethod(method);
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('authorization', 'Bearer '+token);
        // req.setHeader('Zuora-Entity-Ids', zEntityId);//Belgique
        // req.setHeader('Authorization', 'Bearer '+access_token);
        // if(version != null){
//            req.setHeader('Zuora-Version', version);
//        }
        if (inBody != null ) {req.setBody(inBody);}

        System.debug('##MBEN requestBodyValue >> '+inBody);
        //req.setCompressed(true); si active erreur sur le retour JSON.
        req.setTimeout(60000);
        System.debug('##MBEN requestValue >> '+req);
        HttpResponse res = null;
        res = h.send(req);
        wsOut = res.getBody();
        //blob res2 = res.getBodyAsBlob();

        // wsOut = wsOut.replace('"currency"', '"currencyTMP"');
        //responseValue = responseValue.replace('"name"', '"nameTMP"');

        System.debug('##MBEN responseValue >> '+wsOut);
        // System.debug('##MBEN sucessType >> '+sucessType);
        //JSONParser
        //Object wsOut = (Object)JSON.deserializeStrict(responseValue,Object.class);

        // success = checkWSsuccess(sucessType, wsOut);
        // System.debug('##MBEN success >> '+success);

/*        if (success == null || !success){
            System.debug('##MBEN  success false');
            OUT_Error wsOutObj = (OUT_Error)JSON.deserializeStrict(wsOut,OUT_Error.class);
            msgError = wsOutObj.reasons[0].message;
            throw new MyException(msgError);
        }*/
        return wsOut;
    }

    public static String oauthLogin(String codePays){

        String namedCredential = getNamedCredential(codePays);
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        //req.setEndpoint(oauth_endpoint);
        //String body = 'client_id=' + client_id + '&client_secret=' + client_secret + '&grant_type=' + grant_type;
        req.setEndpoint('callout:'+namedCredential+'/oauth/token');
        // String body = 'client_id={!$Credential.UserName}&client_secret={!$Credential.Password}&grant_type=client_credentials&scope=api' ;
        String body = 'grant_type=client_credentials&scope=api' ;
        req.setMethod('POST');
        //req.setHeader('Zuora-Track-Id', 'From_WS001_CallZuora');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.setHeader('Cache-Control', 'no-cache');
        req.setbody(body);
        req.setTimeout(60000);
        HttpResponse res = null;
        res = h.send(req);
        String responseValue = '';
        responseValue = res.getBody();

        System.debug('##MBE responseValue >> '+responseValue);

        WRPOauthLogin wrp = (WRPOauthLogin)JSON.deserializeStrict(responseValue,WRPOauthLogin.class);
        access_token = wrp.access_token;
        return access_token;

    }

    public static String getNamedCredential(String codePays) {

        String namedCredential;
        if (Util.BELGIQUE.contains(codePays)) {
            namedCredential = 'SlimpayAPI_BE';
        }
        else if (Util.FRANCE.contains(codePays)) {
            namedCredential = 'SlimpayAPI_FR';
        } else {
            throw new MyException('Attribut Code Pays obligatoire sur le Compte');
        }

        return namedCredential;
    }

    public without sharing class WRPOauthLogin{
        public String access_token;
        public String token_type;
        public String expires_in;
        public String scope;
        public String jti;
    }

    public class MyException extends Exception{}

}