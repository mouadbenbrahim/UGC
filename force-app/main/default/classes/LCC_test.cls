public class LCC_test {
    
    public without sharing class WRPInit {
        @AuraEnabled public String image        { get; set; }
        
        public WRPInit() {
            this.image      = null;
        }
    }
    
    @AuraEnabled  
    public static WRPInit test(){
        WRPInit rep = new WRPInit();
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        //string firstImageURL =  'http://scd.mashable.france24.com/sites/default/files/styles/mashable_983x554/public/thumbnails/image/chien_oreilles_main.jpg?itok=w3ARMCqP';
        //string firstImageURL =  'https://velvetconsulting.com/wp-content/uploads/2016/11/logo-easyfront.png';
        string firstImageURL =  'https://moteur.ugc.fr/moncompte.api.preprod/api/Photos/GetPhoto/033/1234567';
        
        firstImageURL = firstImageURL.replace(' ', '%20');
        req.setEndpoint(firstImageURL);
        req.setMethod('GET');
        req.setHeader('Content-Type', 'image/jpg');
        req.setCompressed(true);
        req.setTimeout(60000);
        HttpResponse res = null;
        res = h.send(req);
        string responseValue = '';
        responseValue = res.getBody();
        //system.debug('Response Body for File: ' + responseValue);
        blob image = res.getBodyAsBlob();
        
        String imageUrl = 'data:'+res.getHeader('Content-Type')+';base64,'+EncodingUtil.base64Encode(image);

        system.debug('##MNE >> '+imageUrl);
        
        rep.image = imageUrl;
        
        
        
        
        return rep;
    }

}