public without sharing class LCC00X_Canevas {
	
	//MNE ant commentaire
    
    @AuraEnabled 
    public static WRPInt initApexMethod(Id idCase, String otherVar, String bttnOperation){
        WRPInt rep = new WRPInt();

        try{
            system.debug('##MBEN5 bttnOperation: ' + bttnOperation);
            if (bttnOperation == 'Desabonnement') {
                system.debug('##MBEN6 bttnOperation: ' + bttnOperation);
                //SM_Subscription.cancel();
            } else
            {
            SM00X2_Canevas2.WRPRep zuoraAccount;
            String token = SM00X_Canevas.oauthLogin();
            zuoraAccount = SM00X2_Canevas2.zuoraGetAccount(token);
            system.debug('##MNE LCC00X_Canevas initApexMethod >> '+zuoraAccount);
            system.debug('##MBEN bttnOperation: ' + bttnOperation);
            system.debug('##MBEN idCase: ' + idCase);
            system.debug('##MBEN otherVar: ' + otherVar);
            
            //DML Update Insert Delete
            
            String test = zuoraAccount.metrics.totalInvoiceBalance;

            }
        }catch(Exception e){
            rep.showMessage = true;
        	rep.messageToDisplay = e.getMessage();
        	rep.isError = true;
            return rep;
        }
        
        return rep;
        
    }
    
    public without sharing class WRPInt {
        @AuraEnabled public Boolean showMessage 						{ get; set; }
    	@AuraEnabled public String  messageToDisplay 					{ get; set; }
        @AuraEnabled public Boolean isWarning 							{ get; set; }
        @AuraEnabled public Boolean isError 							{ get; set; }
        @AuraEnabled public Boolean isInfo 								{ get; set; }
        
		public WRPInt() {
            this.showMessage			= false;
            this.messageToDisplay		= '';
            this.isWarning   			= false;
            this.isError   				= false;
            this.isInfo   				= false;
        }
	}

}