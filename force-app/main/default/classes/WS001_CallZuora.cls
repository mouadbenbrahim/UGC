/**
 * @File Name          : WS001_CallZuora.cls
 * @Description        : 
 * @Author             : mouad
 * @Group              : 
 * @Last Modified By   : mouad
 * @Last Modified On   : 19/09/2019 à 22:25:03
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    09/09/2019   mouad     Initial Version
**/
public with sharing class WS001_CallZuora {

    //public static String oauth_endpoint = 'https://rest.sandbox.eu.zuora.com/oauth/token';    https://rest.sandbox.eu.zuora.com
    //public static String client_id = 'feff2259-51cf-4805-b293-c61c675af605';
    //public static String client_secret = 'whLJPfo6aOBPOrv54%2B1T';
    //public static String grant_type = 'client_credentials';
    
    public enum ZuoraEntityCountry {FRA, BEL}
    
    public static String ZuoraEntityId_France   = Label.ZuoraEntityId_France;
    public static String ZuoraEntityId_Belgique = Label.ZuoraEntityId_Belgique;
    //String testEnumFR = WS001_CallZuora.getZuoraEntityId(WS001_CallZuora.ZuoraEntityCountry.FRA);
    //String testEnumBE = WS001_CallZuora.getZuoraEntityId(WS001_CallZuora.ZuoraEntityCountry.BEL);

    public interface MappedProperties {
        Map<String, String> getPropertyMappings();
    }

    public static String access_token {
        get {
            if (access_token == null){
                access_token = oauthLogin();
            }
            return access_token;
        }
        set;
    }

    public static WSZ.WRPOauthLogin access_token2 {
        get {
            if (access_token2 == null){
                access_token2 = oauthLogin2();
            }
            return access_token2;
        }
        set;

    }

    public static void update_token2(WSZ.WRPOauthLogin tokObject) {
        Datetime myNow = Datetime.now();
        Zuora_Token__c tokenCS = Zuora_Token__c.getOrgDefaults();
        if (tokenCS.Token__c != tokObject.access_token) {
            tokenCS.Token__c = tokObject.access_token;
            tokenCS.DateGeneration__c = myNow.addSeconds(Integer.valueOf(tokObject.expires_in));
            upsert tokenCS;
        }
    }


    public static String getZuoraEntityId(ZuoraEntityCountry entityCountry) {
        if (entityCountry == ZuoraEntityCountry.FRA){
            return ZuoraEntityId_France;
        }
        else if(entityCountry == ZuoraEntityCountry.BEL){
            return ZuoraEntityId_Belgique;
        }
        return '';
    }
    
     public static String getZuoraEntityId(String pays){
        String zuoraEntityId;
        if (Util.BELGIQUE.contains(pays)) {
            zuoraEntityId = ZuoraEntityId_Belgique;
        } else if (Util.FRANCE.contains(pays)){
            zuoraEntityId = ZuoraEntityId_France;
        } else {
            throw new MyException('Attribut Code Pays obligatoire sur le Compte');
        }
        return zuoraEntityId;
    }

    public static String oauthLogin(){
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        //req.setEndpoint(oauth_endpoint);
        //String body = 'client_id=' + client_id + '&client_secret=' + client_secret + '&grant_type=' + grant_type;
        req.setEndpoint('callout:ZuoraAPI/oauth/token');
        String body = 'client_id={!$Credential.UserName}&client_secret={!$Credential.Password}&grant_type=client_credentials' ;
        req.setMethod('POST');
        req.setHeader('Zuora-Track-Id', 'From_WS001_CallZuora');
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
        //return wrp.access_token;
        return access_token;
    }

    public static WSZ.WRPOauthLogin oauthLogin2(){
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        //req.setEndpoint(oauth_endpoint);
        //String body = 'client_id=' + client_id + '&client_secret=' + client_secret + '&grant_type=' + grant_type;
        Zuora_Token__c tokenCS = Zuora_Token__c.getOrgDefaults();
        String token = tokenCS.Token__c;
        Datetime dateToken = tokenCS.DateGeneration__c;
        Datetime myNow = Datetime.now();

        if (String.isBlank(token) || myNow >= dateToken.addMinutes(-5)) {
            req.setEndpoint('callout:ZuoraAPI/oauth/token');
            String body = 'client_id={!$Credential.UserName}&client_secret={!$Credential.Password}&grant_type=client_credentials' ;
            req.setMethod('POST');
            req.setHeader('Zuora-Track-Id', 'From_WS001_CallZuora');
            req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
            req.setHeader('Cache-Control', 'no-cache');
            req.setbody(body);
            req.setTimeout(60000);
            HttpResponse res = null;
            res = h.send(req);
            String responseValue = '';
            responseValue = res.getBody();

            System.debug('##MBE responseValue >> '+responseValue);

            WSZ.WRPOauthLogin wrp = (WSZ.WRPOauthLogin)JSON.deserializeStrict(responseValue,WSZ.WRPOauthLogin.class);
            access_token2 = wrp;
            // Integer tokenExpires = Integer.valueOf(wrp.expires_in);
            // tokenCS.Token__c = access_token2;
            // tokenCS.DateGeneration__c = myNow.addSeconds(tokenExpires);
            // upsert tokenCS;
        }
        else {
            access_token2 = new WSZ.WRPOauthLogin(token);
        }


        //return wrp.access_token;
        return access_token2;
    }

    public static String sendRequest(String access_token, String endpoint, String zEntityId, String method, String inBody, String sucessType, String version){
        String wsOut = '';
        Boolean success = null;
        String msgError = '';

        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:ZuoraAPI'+endpoint);
        req.setMethod(method);
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Zuora-Entity-Ids', zEntityId);//Belgique
        req.setHeader('Authorization', 'Bearer '+access_token);
        if(version != null){
            req.setHeader('Zuora-Version', version);
        }
        if (inBody != null ) {req.setBody(inBody);}

        system.debug('##MBEN endpoint >> '+endpoint);
        system.debug('##MBEN zEntityId >> '+zEntityId);
        system.debug('##MBEN access_token >> '+access_token);
        system.debug('##MBEN requestValue >> '+inBody);
        //req.setCompressed(true); si active erreur sur le retour JSON.
        req.setTimeout(60000);
        HttpResponse res = null;
        res = h.send(req);
        wsOut = res.getBody();
        //blob res2 = res.getBodyAsBlob();

        wsOut = wsOut.replace('"currency"', '"currencyTMP"');
        //responseValue = responseValue.replace('"name"', '"nameTMP"');

        system.debug('##MBEN responseValue >> '+wsOut);
        system.debug('##MBEN sucessType >> '+sucessType);
        //JSONParser
        //Object wsOut = (Object)JSON.deserializeStrict(responseValue,Object.class);

        success = checkWSsuccess(sucessType, wsOut);
        system.debug('##MBEN success >> '+success);
        
        if (success == null || !success){
            system.debug('##MBEN  success false');
            OUT_Error wsOutObj = (OUT_Error)JSON.deserializeStrict(wsOut,OUT_Error.class);
            msgError = wsOutObj.reasons[0].message;
            throw new MyException(msgError);
        }
        return wsOut;
    }

    public static String sendRequest2(String access_token, String endpoint, String zEntityId, String method, Object bodyIn, 
    Type requestType, Type returnType, String version){
        String bodyOutS;       
        Boolean success = null;
        String msgError = '';
        String bodyInS;

        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:ZuoraAPI'+endpoint);
        req.setMethod(method);
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Zuora-Entity-Ids', zEntityId);//Belgique
        req.setHeader('Authorization', 'Bearer '+access_token);
        if(version != null){
            req.setHeader('Zuora-Version', version);
        }

        if (bodyIn != null ) {
            ZUC_Parser reqParser = new ZUC_Parser(ZUC_Parser.MAP_SWAP);
            //reqParser.mapSwap = true;
            bodyInS = reqParser.serializeWithMapping(bodyIn);
            req.setBody(bodyInS);
            system.debug('##MBEN requestValue >> '+bodyInS);
        }    
        
        req.setTimeout(60000);
        HttpResponse res = null;
        res = h.send(req);
        bodyOutS = res.getBody();
        
        system.debug('##MBEN responseValue >> '+bodyOutS);
        
        /*JsonParser parser = Json.createParser(bodyOutS);
        parser.nextToken();
        bodyOut = parser.readValueAs(Object);*/
        
        //Object bodyOut = (Object)JSON.deserializeStrict(bodyOutS,Object.class);
        //ZUC_Parser resParser = new ZUC_Parser(ZUC_Parser.MAP_NO_SWAP);
        //bodyOut = resParser.serializeWithMapping(bodyOut);

        return bodyOutS;

            /*
            bodyInS = (String) JSON.serialize(bodyIn);
            Object o = requestType.newInstance();
            System.debug('---------ETAP1 INSTANCE');
            if (o instanceof MappedProperties) {
                // Map<String, String> propertyMappings = ((MappedProperties) o).getPropertyMappings();
                System.debug('---------ETAP2 INSTANCE');
                Map<String, String> propertyMappings = ((MappedProperties) o).getPropertyMappings();
                System.debug('-----PM:' + propertyMappings);
                for (String baseName : propertyMappings.keySet()) {
                    bodyInS = bodyInS.replaceAll('"' + propertyMappings.get(baseName) + '"\\s*:',
                        '"' + baseName + '":');
                }
                System.debug(bodyInS);
            } 
            */           
            
        


        // system.debug('##MBEN requestValue >> '+bodyIn);
        //req.setCompressed(true); si active erreur sur le retour JSON.
        
        //blob res2 = res.getBodyAsBlob();

        //bodyOut = bodyOut.replace('"currency"', '"currencyTMP"');
        //responseValue = responseValue.replace('"name"', '"nameTMP"');


        //JsonParser parser = Json.createParser(bodyOut);
        //parser.nextToken();
        //return parser.readValueAs(returnType);
        

    }

    public class MyException extends Exception{}

    public without sharing class WRPOauthLogin{
        public String access_token;
        public String token_type;
        public String expires_in;
        public String scope;
        public String jti;
    }

    public static Boolean checkWSsuccess(String sucessType, String JSONContent) {
        Boolean success = null;
        if (sucessType == 'type1') {
            String successFalse = '"success" : false';
            String successFalse2 = '"success":false';
            String successFalse3 = '"Success" : false';
            String successFalse4 = '"Success":false';
            
            String successTrue = '"success" : true';
            String successTrue2 = '"success":true';
            String successTrue3 = '"Success" : true';
            String successTrue4 = '"Success":true';

            //OK
            if (JSONContent.contains(successFalse) || JSONContent.contains(successFalse2) || JSONContent.contains(successFalse3) || JSONContent.contains(successFalse4)) {success=false;}
            if (JSONContent.contains(successTrue)  || JSONContent.contains(successTrue2)  || JSONContent.contains(successTrue3)  || JSONContent.contains(successTrue4)) {success=true;}
        }

        if (sucessType == 'type2') {
            // String successFalse = '"success" : false';
            String successTrue = '"done":true';
            if (JSONContent.contains(successTrue)) {success=true;} else {success=false;}
        }

        /* Ne fonctionne pas : nextToken perd le fil quand il y a un tableau dans le json
        Boolean trouve = false;
        Boolean findeboucle = false;
        Boolean success = null;

        //JSONContent = '{"firstName":"John","toto":11,"success": true,"titi": 36}';
        JSONParser parser =  JSON.createParser(JSONContent);
        parser.nextToken();
        parser.nextValue();

        integer i = 0;
        while (i < 200 && !findeboucle) {
            System.debug('Current token: ' + parser.getCurrentName() + ' - ' + parser.getText());
            parser.nextToken();
            parser.nextValue();
            if (parser.getCurrentName() == 'success') { findeboucle = true; success =  (Boolean)parser.getBooleanValue();}
            if (parser.getCurrentName() == null) { findeboucle = true;}
            i++;
        }*/
        
        if (success == false) {System.debug('success_false: ' + success);}
        if (success == true) {System.debug('success_true: ' + success);}
        if (success == null) {System.debug('success_null: ' + success);}

        return success;
    }

    public without sharing class OUT_Error {
        public Boolean success;
        public String processId;
        public List<Reason> reasons = null;
    }

    public without sharing class Reason {
        public Integer code;
        public String message;
    }


}