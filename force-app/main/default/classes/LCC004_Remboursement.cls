public without sharing class LCC004_Remboursement {
    
	/*@AuraEnabled 
    public static WRPInt createRemboursementCase(Id accId, Id caseId, Double amount){
    	system.debug('##MNE LCC004_Remboursement createRemboursementCase accId >> '+accId);
    	system.debug('##MNE LCC004_Remboursement createRemboursementCase caseId >> '+caseId);
    	system.debug('##MNE LCC004_Remboursement createRemboursementCase amount >> '+amount);
    	
        WRPInt rep = new WRPInt();

        try{
        	list<Zuora__Payment__c> listPayment = new list<Zuora__Payment__c>([SELECT Name, Zuora__External_Id__c FROM Zuora__Payment__c WHERE Zuora__Account__c = :accId]);
        	list<Account> listAcc = new list<Account>([SELECT Id, ProduitUGC__c FROM Account WHERE Id = :accId]);
        	Account acc = listAcc.get(0);
        	String zEntityId = WS001_CallZuora.getZuoraEntityId(acc.ProduitUGC__c);
        	
        	if(listPayment.size() == 0){
        		rep.showMessage = true;
	        	rep.messageToDisplay = 'No Payment found for refund';
	        	rep.isError = true;
	            system.debug('##MNE LCC004_Remboursement createRemboursementCase error no payment found');
        	}
        	
        	Zuora__Payment__c payment = listPayment.get(0);
        	
        	String access_token = WS001_CallZuora.oauthLogin();
        	system.debug('##MNE LCC004_Remboursement createRemboursementCase access_token >> '+access_token);
        	
        	executeUnapplyPayment(payment.Zuora__External_Id__c, access_token, zEntityId);
        	
        	executeRefundPayment(payment.Zuora__External_Id__c, access_token, amount, zEntityId);
        	
			//Id recordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Remboursement').getRecordTypeId();
            //Contact contact = [SELECT id FROM Contact WHERE accountId = :accId];
            //Case c = new Case();
            //c.AccountId	 = accId;
            //c.ContactId  = contact.Id;
            //c.RecordTypeId = recordTypeId;
            //insert c;
            
            //rep.remboursementCaseId = c.Id;
            //system.debug('##MNE inser OK');
            

        } catch(Exception e){
            rep.showMessage = true;
        	rep.messageToDisplay = e.getMessage();
        	rep.isError = true;
            system.debug('##MNE inser KO');
            return rep;
        }
        
        return rep;
        
    }
    
    public static String executeUnapplyPayment(String zuoraPaymentId, String access_token, String zEntityId){
    	system.debug('##MNE LCC004_Remboursement executeUnapplyPayment zuoraPaymentId >> '+zuoraPaymentId);
    	system.debug('##MNE LCC004_Remboursement executeUnapplyPayment access_token >> '+access_token);
        
        String endpoint = '/v1/payments/'+zuoraPaymentId+'/unapply';
        
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:ZuoraAPI'+endpoint);
        req.setMethod('PUT');
        req.setHeader('Content-Type', 'application/json');
        //req.setHeader('Zuora-Entity-Ids', '8adce421-63ec-c07b-0163-f45782667179'); //France
        req.setHeader('Zuora-Entity-Ids', zEntityId);
        req.setHeader('Authorization', 'Bearer '+access_token);
        req.setTimeout(60000);
        req.setBody('{}');
        
        HttpResponse res = h.send(req);
        String rep = res.getBody();
        
        system.debug('##MNE LCC004_Remboursement executeUnapplyPayment rep >> '+rep);
        return rep;
    }
    
    public static String executeRefundPayment(String zuoraPaymentId, String access_token, Double amount, String zEntityId){
    	system.debug('##MNE LCC004_Remboursement executeRefundPayment zuoraPaymentId >> '+zuoraPaymentId);
    	system.debug('##MNE LCC004_Remboursement executeRefundPayment access_token >> '+access_token);
        
        String endpoint = '/v1/payments/'+zuoraPaymentId+'/refunds';
        
        BodyRefund bR = new BodyRefund(amount);
        String body = JSON.serialize(bR);
        body = body.replace('typeTMP', 'type');
        
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:ZuoraAPI'+endpoint);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        //req.setHeader('Zuora-Entity-Ids', '8adce421-63ec-c07b-0163-f45782667179'); //France
        req.setHeader('Zuora-Entity-Ids', zEntityId);
        req.setHeader('Authorization', 'Bearer '+access_token);
        req.setTimeout(60000);
        req.setBody(body);
        
        HttpResponse res = h.send(req);
        String rep = res.getBody();
        
        system.debug('##MNE LCC004_Remboursement executeRefundPayment rep >> '+rep);
        return rep;
    }
    
    public without sharing class WRPInt {
        @AuraEnabled public Id remboursementCaseId 						{ get; set; }
        @AuraEnabled public Boolean showMessage 						{ get; set; }
    	@AuraEnabled public String  messageToDisplay 					{ get; set; }
        @AuraEnabled public Boolean isWarning 							{ get; set; }
        @AuraEnabled public Boolean isError 							{ get; set; }
        @AuraEnabled public Boolean isInfo 								{ get; set; }
        
		public WRPInt() {
            this.remboursementCaseId	= null;
            this.showMessage			= false;
            this.messageToDisplay		= '';
            this.isWarning   			= false;
            this.isError   				= false;
            this.isInfo   				= false;
        }
	}
	
	public without sharing class BodyRefund {
		public String comment;
		public String methodType;
		public String refundDate;
		public Double totalAmount;
		public String typeTMP;
		
		public BodyRefund(Double totalAmount){
			this.comment = '';
			this.methodType = 'Other';
			this.refundDate = String.valueOf(Date.Today());
			this.totalAmount = totalAmount;
			this.typeTMP = 'External';
		}
	}*/
     
}