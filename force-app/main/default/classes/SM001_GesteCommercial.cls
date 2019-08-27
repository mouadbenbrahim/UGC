public without sharing class SM001_GesteCommercial {

    //test MNE
    
    public static String endpoint = '/v1/action/amend';
    public static String prodRatePlanChargeReferenceGesteCommercialCDI = 'REMMONT';
    public static String prodRatePlanChargeReferenceGesteCommercialCDD = 'REMMENS';
    public static String prodRatePlanChargeReferenceDetteTechnique = 'DETTETECH';
    
    public static String sendAmendRequest(String inBody, String zEntityId){
        system.debug('##MNE SM001_GesteCommercial sendRequest inBody >> '+inBody);
        
        String access_token = WS001_CallZuora.oauthLogin();
        system.debug('##MNE SM001_GesteCommercial sendRequest access_token >> '+access_token);
        
        //String inBody = getBodyGC (zuoraSubId, ProductRatePlanId, ProductRatePlanChargeId, montantRemise, nbDeMoisRemise, dateDemande, moisDebutRemise);
        //system.debug('##MNE SM001_GesteCommercial sendRequest inBody >> '+inBody);
        
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        //req.setEndpoint(endpoint);
        req.setEndpoint('callout:ZuoraAPI'+endpoint);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        //req.setHeader('Zuora-Entity-Ids', '8adce421-63ec-c07b-0163-f45782667179'); //France
        req.setHeader('Zuora-Entity-Ids', zEntityId);
        req.setHeader('Authorization', 'Bearer '+access_token);
        req.setTimeout(60000);
        req.setBody(inBody);
        
        HttpResponse res = h.send(req);
        String rep = res.getBody();
        
        /*Resultat resApex =   (Resultat)System.JSON.deserialize(rep, Resultat.class);
        System.debug('##MNE resJsonOriginal >> '+rep);
        System.debug('##MNE resApex >> '+resApex);
        System.debug('##MNE resJson >> '+JSON.serialize(resApex));*/
        
        system.debug('##MNE SM001_GesteCommercial sendRequest rep >> '+rep);
        return rep;
    }
    
    /*public static String sendRequest(String zuoraSubId, String ProductRatePlanId, String ProductRatePlanChargeId, Double montantRemise, Integer nbDeMoisRemise, Date dateDemande, String moisDebutRemise){
        system.debug('##MNE SM001_GesteCommercial sendRequest zuoraSubId >> '+zuoraSubId);
        system.debug('##MNE SM001_GesteCommercial sendRequest ProductRatePlanId >> '+ProductRatePlanId);
        system.debug('##MNE SM001_GesteCommercial sendRequest ProductRatePlanChargeId >> '+ProductRatePlanChargeId);
        system.debug('##MNE SM001_GesteCommercial sendRequest montantRemise >> '+montantRemise);
        system.debug('##MNE SM001_GesteCommercial sendRequest nbDeMoisRemise >> '+nbDeMoisRemise);
        system.debug('##MNE SM001_GesteCommercial sendRequest dateDemande >> '+dateDemande);
        system.debug('##MNE SM001_GesteCommercial sendRequest moisDebutRemise >> '+moisDebutRemise);
        
        String access_token = WS001_CallZuora.oauthLogin();
        system.debug('##MNE SM001_GesteCommercial sendRequest access_token >> '+access_token);
        
        //String inBody = getBody ('8adce4216669863c016676c1939b5bd7', '8adce4216532fbf601655b8d49ad4c14', '8adc8f996532f2c801655b8f127613dd', 11);
        String inBody = getBodyGC (zuoraSubId, ProductRatePlanId, ProductRatePlanChargeId, montantRemise, nbDeMoisRemise, dateDemande, moisDebutRemise);
        system.debug('##MNE SM001_GesteCommercial sendRequest inBody >> '+inBody);
        
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
        
        
        system.debug('##MNE SM001_GesteCommercial sendRequest rep >> '+rep);
        return rep;
    }*/
    

    public static String getBodyGC (String zuoraSubId, String ProductRatePlanId, String ProductRatePlanChargeId, Double montantRemise, Integer nbDeMoisRemise, Date dateDemande, String moisDebutRemise){
        try{
            Body res = new Body(zuoraSubId, ProductRatePlanId, ProductRatePlanChargeId, montantRemise, nbDeMoisRemise, dateDemande, moisDebutRemise);
            String s = JSON.serialize(res);
            s = s.replace('"TermStartDate":null,', '');
			s = s.replace('"TermStartDate":null', '');
			s = s.replace('"CurrentTerm":null,', '');
			s = s.replace('"CurrentTerm":null', '');
            system.debug('##MNE json rep >> '+s);
            return s;
        }catch(Exception e){
            system.debug('##MNE SM001_GesteCommercial getBody exception >> '+e.getMessage());
            throw e;
        }
    }
    

    //-----------------------------------Request Body-----------------------------------------
    public class Body {
        public list<Request> requests = null;
        
        public Body (String zuoraSubId, String ProductRatePlanId, String ProductRatePlanChargeId, Double montantRemise, Integer nbDeMoisRemise, Date dateDemande, String moisDebutRemise){
            requests = new list<Request>();
            requests.add(new Request(zuoraSubId, ProductRatePlanId, ProductRatePlanChargeId, montantRemise, nbDeMoisRemise, dateDemande, moisDebutRemise));
        }
        
        public Body (){
            requests = new list<Request>();
            requests.add(new Request());
        }
    }
    //-----------------------------------Request-----------------------------------------
    public class Request {
        public PreviewOptions PreviewOptions;
        public AmendOptions AmendOptions;
        public list<Amendment> Amendments = null;
        
        public Request(String zuoraSubId, String ProductRatePlanId, String ProductRatePlanChargeId, Double montantRemise, Integer nbDeMoisRemise, Date dateDemande, String moisDebutRemise){
            PreviewOptions = new PreviewOptions();
            AmendOptions = new AmendOptions();
            Amendments = new list<Amendment>();
            Amendments.add(new Amendment(zuoraSubId, ProductRatePlanId, ProductRatePlanChargeId, montantRemise, nbDeMoisRemise, dateDemande, moisDebutRemise));
        }
        
        public Request(){
            PreviewOptions = new PreviewOptions();
            AmendOptions = new AmendOptions();
            Amendments = new list<Amendment>();
        }
    }
    //-----------------------------------PreviewOptions-----------------------------------
    public class PreviewOptions {
        public Boolean EnablePreviewMode;   
        
        public PreviewOptions(){
            EnablePreviewMode = false;
        }
    }
    //-----------------------------------AmendOptions--------------------------------------
    public class AmendOptions {
        public Boolean ProcessPayments;
        
        public AmendOptions(){
            ProcessPayments = false;
        }
    }
    //-----------------------------------Amendment-----------------------------------------
    public class Amendment {
        public String ContractEffectiveDate;
        public String ServiceActivationDate;
        public String TermStartDate;
        public String Name;
        public String SubscriptionId;
        public String Type;
        public String Status;
        public String Description;
        public String CurrentTerm;
        public RatePlanData RatePlanData;
        
        public Amendment (String zuoraSubId, Date contractEffectiveDate, Integer currentTerm){
			this.ContractEffectiveDate 	= String.valueOf(contractEffectiveDate);
			this.ServiceActivationDate 	= String.valueOf(contractEffectiveDate);
			this.TermStartDate			= null;
			this.Name 					= 'Gest commercial CDD';
			this.SubscriptionId 		= zuoraSubId;
			this.Type 					= 'TermsAndConditions';
			this.Status 				= 'Completed';
			this.Description 			= 'Gest commercial CDD';
			this.CurrentTerm 			= String.valueOf(currentTerm);
		}
        
        public Amendment (String zuoraSubId, Date contractEffectiveDate, Date termStartDate){
			this.ContractEffectiveDate 	= String.valueOf(contractEffectiveDate);
			this.ServiceActivationDate 	= String.valueOf(contractEffectiveDate);
			this.TermStartDate			= String.valueOf(termStartDate);
			this.Name 					= 'Offre de retention : Renouvellement';
			this.SubscriptionId 		= zuoraSubId;
			this.Type 					= 'TermsAndConditions';
			this.Status 				= 'Completed';
			this.Description 			= 'offre de retention description';
		}
        
        /*public Amendment (String zuoraSubId){
        	this.ContractEffectiveDate = String.valueOf(Date.today());
        	this.ServiceActivationDate = String.valueOf(Date.today());
        	this.Name = 'Offre de retention : Renouvellement';
        	this.SubscriptionId = zuoraSubId;
        	this.Type = 'Renewal';
        	this.Status = 'Completed';
        	this.Description = 'offre de retention description';
        }*/
        
        public Amendment (String zuoraSubId, String ProductRatePlanId, String ProductRatePlanChargeId, Date StartDate){
            this.ContractEffectiveDate = String.valueOf(StartDate);
            this.ServiceActivationDate = String.valueOf(StartDate);
            this.Name = 'Offre de retention : Remise';
            this.SubscriptionId = zuoraSubId;
            this.Type = 'NewProduct';
            this.Status = 'Completed';
            this.Description = 'offre de retention description';
            this.RatePlanData = new RatePlanData(ProductRatePlanId, ProductRatePlanChargeId);
        }
        
        public Amendment (String zuoraSubId, String ProductRatePlanId, String ProductRatePlanChargeId, Double montantRemise, Integer nbDeMoisRemise, Date dateDemande, String moisDebutRemise){
            this.ContractEffectiveDate = String.valueOf(Date.Today());
            this.ServiceActivationDate = String.valueOf(Date.Today());
            this.Name = 'Geste Commercial';
            this.SubscriptionId = zuoraSubId;
            this.Type = 'NewProduct';
            this.Status = 'Completed';
            this.Description = 'Geste Commercial description';
            this.RatePlanData = new RatePlanData(ProductRatePlanId, ProductRatePlanChargeId, montantRemise, nbDeMoisRemise, dateDemande, moisDebutRemise);
        }
    }
    //-----------------------------------RatePlanData-----------------------------------
    public class RatePlanData {
        public RatePlan RatePlan;
        public list<RatePlanChargeData> RatePlanChargeData;
        
        public RatePlanData(String ProductRatePlanId, String ProductRatePlanChargeId, Double montantRemise, Integer nbDeMoisRemise, Date dateDemande, String moisDebutRemise){
            RatePlan = new RatePlan(ProductRatePlanId);
            RatePlanChargeData = new list<RatePlanChargeData>();
            RatePlanChargeData tmp = new RatePlanChargeData(ProductRatePlanChargeId, montantRemise, nbDeMoisRemise, dateDemande, moisDebutRemise);
            RatePlanChargeData.add(tmp);
        }
        
        public RatePlanData(String ProductRatePlanId, String ProductRatePlanChargeId){
            RatePlan = new RatePlan(ProductRatePlanId);
            RatePlanChargeData = new list<RatePlanChargeData>();
            RatePlanChargeData tmp = new RatePlanChargeData(ProductRatePlanChargeId);
            RatePlanChargeData.add(tmp);
        }
    }
    //-----------------------------------RatePlan-----------------------------------
    public class RatePlan {
        public String ProductRatePlanId;
        
        public RatePlan(String ProductRatePlanId){
            this.ProductRatePlanId = ProductRatePlanId;
        }
    }
    //-----------------------------------RatePlanChargeData-----------------------------------
    public class RatePlanChargeData {
        public RatePlanCharge RatePlanCharge;
        
        public RatePlanChargeData(String ProductRatePlanChargeId, Double montantRemise, Integer nbDeMoisRemise, Date dateDemande, String moisDebutRemise){
            RatePlanCharge = new RatePlanCharge(ProductRatePlanChargeId, montantRemise, nbDeMoisRemise, dateDemande, moisDebutRemise);
        }
        
        public RatePlanChargeData(String ProductRatePlanChargeId){
            RatePlanCharge = new RatePlanCharge(ProductRatePlanChargeId);
        }
    }
    //-----------------------------------RatePlanCharge-----------------------------------
    public class RatePlanCharge {
        public String ProductRatePlanChargeId;
        public Double DiscountAmount;
        public String TriggerEvent;
        public String TriggerDate;
        public Integer UpToPeriods;
        
        public RatePlanCharge(String ProductRatePlanChargeId, Double montantRemise, Integer nbDeMoisRemise, Date dateDemande, String moisDebutRemise){
        	
        	Integer intMoisDebutRemise = Integer.valueOf(moisDebutRemise);
			Date dateDebutRemise = SM_Demande.getRemiseDate(intMoisDebutRemise);
			
			if(dateDemande > dateDebutRemise){
    			dateDebutRemise = dateDebutRemise.addYears(1);
    		}
        	
            /*Date d = dateDemande.addMonths(1);
            Integer year = d.year();
            Integer month = d.month();
            Date d2 = Date.newInstance(year, month, 1);*/
            
            this.ProductRatePlanChargeId = ProductRatePlanChargeId;
            this.DiscountAmount = montantRemise;
            this.TriggerEvent = 'SpecificDate';
            this.TriggerDate = String.valueOf(dateDebutRemise);
            this.UpToPeriods = nbDeMoisRemise;
        }
        
        public RatePlanCharge(String ProductRatePlanChargeId){
            this.ProductRatePlanChargeId = ProductRatePlanChargeId;
        }
    }
    
    
    //-----------------------------------Response Resultat-----------------------------------
    public class Resultat {
        public list<Result> results = null;
    }
    //-----------------------------------Result-----------------------------------
    public class Result {
        public list<Error> Errors = null;
        public String SubscriptionId;
        public Double TotalDeltaTcv;
        public list<String> AmendmentIds = null;
        public Integer TotalDeltaMrr;
        public Boolean Success;
    }
    //-----------------------------------Error-----------------------------------
    public class Error {
        public String Code;
        public String Message;
    }
}