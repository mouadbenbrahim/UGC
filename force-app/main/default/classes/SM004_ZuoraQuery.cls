public without sharing class SM004_ZuoraQuery {
    /*public static String endpoint = '/v1/action/query';
    
    
    public static String sendQueryRequest(String query){
        system.debug('##MNE SM004_ZuoraQuery sendQueryRequest query >> '+query);
        
        Body bodyQuery = new Body(query);
        String inBody = JSON.serialize(bodyQuery);
        
        String access_token = WS001_CallZuora.oauthLogin();
        system.debug('##MNE SM004_ZuoraQuery sendQueryRequest access_token >> '+access_token);
        
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        //req.setEndpoint(endpoint);
        req.setEndpoint('callout:ZuoraAPI'+endpoint);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Zuora-Entity-Ids', '8adce421-63ec-c07b-0163-f45782667179'); //France
        req.setHeader('Authorization', 'Bearer '+access_token);
        req.setTimeout(60000);
        req.setBody(inBody);
        
        HttpResponse res = h.send(req);
        String rep = res.getBody();
        
        system.debug('##MNE SM004_ZuoraQuery sendQueryRequest rep >> '+rep);
        return rep;
    }
    
    
    //-----------------------------------Request Body-----------------------------------------
    public class Body {
        public String queryString;
        
        public Body (String queryString){
            this.queryString = queryString;
        }
    }
    
    //-----------------------------------Response Body-----------------------------------------
    public class Resultat {
        public list<ProductRatePlanCharge> records = new list<ProductRatePlanCharge> ();
        public Integer size;
        public boolean done;
    
    }
    
    public class ProductRatePlanCharge {
        public String ProductRatePlanId;
        public String Reference;
        public String Id;
    }*/
    
}