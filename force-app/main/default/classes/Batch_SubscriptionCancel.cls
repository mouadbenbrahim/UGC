global class Batch_SubscriptionCancel implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts {

    public Date dateFinContrat;
    public String subNumber;

    public Batch_SubscriptionCancel(Date dateFinContrat, String subNumber) {
        if (dateFinContrat ==  null){
            this.dateFinContrat = Date.today();
        }else {
            this.dateFinContrat = dateFinContrat;
        }        
        this.subNumber = subNumber;                        
    }

    global Database.QueryLocator start(Database.BatchableContext BC) {

        // String query = 'Select Id From Case where Subscription__r.DateFinContrat__c= :cancelDate and Id = \'5000E000009jn2WQAQ\'';
        //String query = 'Select Id, CancelCaseID__c From Zuora__Subscription__c where Zuora__Status__c=\'Active\' and DateFinContrat__c=:dateFinContrat and CancelCaseID__c = \'5000E000009jn2WQAQ\'';
        String query;
        if (subNumber == null) {
            query = 'Select Id, CancelCaseID__c, Source__c From Zuora__Subscription__c where Zuora__Status__c=\'Active\' and DateFinContrat__c=:dateFinContrat limit 1';
        }else {
            query = 'Select Id, CancelCaseID__c, Source__c From Zuora__Subscription__c where Zuora__Status__c=\'Active\' and DateFinContrat__c=:dateFinContrat and Zuora__SubscriptionNumber__c = :subNumber limit 1';            
        }
        system.debug('##MNE Batch_SubscriptionCancel start query >> '+query);
        return Database.getQueryLocator(query); 
        // List<Zuora__Subscription__c> subscriptions = [Select Id, CancelCaseID__c From Zuora__Subscription__c where Zuora__Status__c='Active' and DateFinContrat__c=:dateFinContrat and CancelCaseID__c='5000E000009jn2WQAQ'];
        //List<Case> cases = [Select Id From Case where Subscription__r.DateFinContrat__c=:cancelDate]

    }

    global void execute(Database.BatchableContext BC, List<Zuora__Subscription__c> scope) {
        // List<Case> cases = [Select Id From Case where Subscription__r.DateFinContrat__c=:cancelDate and Id='5000E000009jn2WQAQ'];
        
        Id caseId, subId, currentId;
        
        for (Zuora__Subscription__c sub: scope){
            try {

                if (sub.CancelCaseID__c != null){ // contrats avec caseID (desabonner depuis un case saleforce)
                    caseId = sub.CancelCaseID__c;
                    currentId = caseId;
                    System.debug('MBEN: Batch_SubscriptionCancel: Case: '+ caseId);
                    SM_Desabonnement.desabonner(caseId,true);
                }else if (sub.Source__c == 'Bilendi'){//contrats Bilendi
                    subId = sub.Id;
                    currentId = subId;
                    System.debug('MBEN: Batch_SubscriptionCancel: Subscription Bilendi: '+ subId);
                    SM_Desabonnement.desabonner_Bilendi(subId);
                }else {
                    throw new RTException(RTExceptionCode.ERREUR_DESABO_BATCH_CASE_ABSENT);
                }

                // trace success
                if(currentId.getSObjectType() == Schema.Case.SObjectType && currentId != null){
                    Case c = new Case();
                    Datetime dNow = Datetime.now();
                    c.Id = caseId;                    
                    c.ExecStatus__c = 'Success';
                    c.ExecDate__c =dNow;
                    c.ExecSuccessDate__c = dNow;
                    update c;
                }
            }

            catch(Exception e) {                        
                if(currentId.getSObjectType() == Schema.Case.SObjectType && currentId != null){
                    Case c = new Case();
                    Datetime dNow = Datetime.now();
                    c.Id = caseId;
                    String sDate = String.valueOf(dNow);
                    String current_ExecMessage = [Select ExecMessage__c from Case where Id=:caseId].ExecMessage__c;
                    String fullMessage = e.getMessage() + e.getStackTraceString() + e.getTypeName() + e.getCause() + e.getLineNumber();
                    c.ExecMessage__c = sDate + fullMessage + '\n' + current_ExecMessage;
                    c.ExecStatus__c = 'Erreur';
                    c.ExecDate__c = dNow;                    
                    update c;
                }else {
                    System.debug('MBEN: Batch_SubscriptionCancel: '+ String.valueOf(e)); //TODO il faut tracer dans un autre objet
                }                
            }

            finally{
                                
            } 

        } //end for
        
        System.debug('MBEN-execute: scope: ' + scope.size());
    }

    global void finish(Database.BatchableContext BC) {
            System.debug('MBEN-finish' );
    
    }

}