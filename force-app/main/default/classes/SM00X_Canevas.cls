public without sharing class SM00X_Canevas {
    
    public static String oauthLogin(){
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        string endpoint =  '/oauth/token';
        //req.setEndpoint(endpoint);
        req.setEndpoint('callout:ZuoraAPI'+endpoint);
        String body = 'client_id=feff2259-51cf-4805-b293-c61c675af605&client_secret=whLJPfo6aOBPOrv54%2B1T&grant_type=client_credentials';
        req.setMethod('POST');
        req.setHeader('Zuora-Track-Id', 'fromMBEpostman');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.setHeader('Cache-Control', 'no-cache');       
        req.setbody(body);
        req.setTimeout(60000);
        HttpResponse res = null;
        res = h.send(req);
        string responseValue = '';
        responseValue = res.getBody();
        
        system.debug('##MNE responseValue >> '+responseValue);
        
        SM00X_Canevas.WRPOauthLogin wrp = (SM00X_Canevas.WRPOauthLogin)JSON.deserializeStrict(responseValue,SM00X_Canevas.WRPOauthLogin.class);
        
        return wrp.access_token;
    }
    
    public without sharing class WRPOauthLogin{
        public String access_token;
        public String token_type;
        public String expires_in;
        public String scope;
        public String jti;
    }

}