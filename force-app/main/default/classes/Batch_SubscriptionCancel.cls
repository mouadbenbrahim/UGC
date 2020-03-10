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
        // ORI query = 'Select Id, Name, Zuora__External_Id__c, Zuora__Account__r.Id, Zuora__CustomerAccount__r.Zuora__External_Id__c, CancelCaseID__c, Source__c, TypeContrat__c From Zuora__Subscription__c where Zuora__Status__c=\'Active\' and DateFinContrat__c=:dateFinContrat';
        String query;
        if (subNumber == null) {
            query = 'Select Id, Name, Zuora__External_Id__c, Zuora__Account__r.Id, Zuora__CustomerAccount__r.Zuora__External_Id__c, CancelCaseID__c, Source__c, TypeContrat__c, CancelCase__c From Zuora__Subscription__c where Zuora__Status__c=\'Active\' and DateFinContrat__c=:dateFinContrat';
            //query = 'Select Id, Name, Zuora__External_Id__c, Zuora__Account__r.Id, Zuora__CustomerAccount__r.Zuora__External_Id__c, CancelCaseID__c, Source__c, TypeContrat__c From Zuora__Subscription__c where Zuora__Status__c=\'Active\' and DateFinContrat__c=:dateFinContrat and CancelCaseID__c != null and TypeContrat__c = \'CDI\' and Source__c != \'Bilendi\' and Zuora__CustomerAccount__r.Zuora__EntityID__c=\'8adc8f99690e257001690e9c372515fe\' limit 1';
        }else {
            query = 'Select Id, Name, Zuora__External_Id__c, Zuora__Account__r.Id, Zuora__CustomerAccount__r.Zuora__External_Id__c, CancelCaseID__c, Source__c, TypeContrat__c, CancelCase__c From Zuora__Subscription__c where Zuora__Status__c=\'Active\' and DateFinContrat__c=:dateFinContrat and Zuora__SubscriptionNumber__c = :subNumber limit 1';
        }
        system.debug('##MNE Batch_SubscriptionCancel start query >> '+query);
        return Database.getQueryLocator(query); 
        // List<Zuora__Subscription__c> subscriptions = [Select Id, CancelCaseID__c From Zuora__Subscription__c where Zuora__Status__c='Active' and DateFinContrat__c=:dateFinContrat and CancelCaseID__c='5000E000009jn2WQAQ'];
        //List<Case> cases = [Select Id From Case where Subscription__r.DateFinContrat__c=:cancelDate]

    }

    global void execute(Database.BatchableContext BC, List<Zuora__Subscription__c> scope) {
        // List<Case> cases = [Select Id From Case where Subscription__r.DateFinContrat__c=:cancelDate and Id='5000E000009jn2WQAQ'];
        
        Id caseId, subId, currentId;
        ProcessLog__c pLog = new ProcessLog__c();
        
        for (Zuora__Subscription__c sub: scope){
            try {

                if (sub.CancelCase__c != null){ // contrats avec caseID (desabonner depuis un case saleforce)
                    caseId = sub.CancelCase__c;
                    currentId = caseId;
                    System.debug('MBEN: Batch_SubscriptionCancel: Case: '+ caseId);
                    SM_Desabonnement.desabonner(caseId,true);
                }else if (sub.Source__c == 'Bilendi'){//contrats Bilendi: CDD ou CDI futur
                    subId = sub.Id;
                    currentId = subId;
                    System.debug('MBEN: Batch_SubscriptionCancel: Subscription Bilendi: '+ subId);
                    SM_Desabonnement.desabonner_SansCase(subId);
                }else if (sub.TypeContrat__c == 'CDD') {
                    subId = sub.Id;
                    currentId = subId;
                    System.debug('MBEN: Batch_SubscriptionCancel: Subscription Bilendi: '+ subId);
                    SM_Desabonnement.desabonner_SansCase(subId);
                }else {
                    System.debug('MBEN: Batch_SubscriptionCancel: Subscriptionbatch cas non conforme: '+ sub.Id);
                    pLog = new ProcessLog__c(Process__c = 'desabonner__isBatchCall', Account__c = sub.Zuora__Account__r.Id, AccountZID__c = sub.Zuora__CustomerAccount__r.Zuora__External_Id__c, SubscriptionZID__c = sub.Zuora__External_Id__c, SubscriptionName__c = sub.Name);
                    throw new RTException(RTExceptionCode.ERREUR_DESABO_BATCH_NON_CONFORME,pLog);
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

            catch (RTException e) {
                    //
            }

            catch(Exception e) {                        
                if(currentId != null && currentId.getSObjectType() == Schema.Case.SObjectType){
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
                    pLog = new ProcessLog__c(Process__c = 'desabonner__isBatchCall_Exception', Case__c = caseId, Account__c = sub.Zuora__Account__r.Id, AccountZID__c = sub.Zuora__CustomerAccount__r.Zuora__External_Id__c, SubscriptionZID__c = sub.Zuora__External_Id__c, SubscriptionName__c = sub.Name ,Message__c = fullMessage);
                    insert pLog;

                }else {
                    String fullMessage = e.getMessage() + e.getStackTraceString() + e.getTypeName() + e.getCause() + e.getLineNumber();
                    System.debug('MBEN: Batch_SubscriptionCancel: '+ fullMessage); //TODO il faut tracer dans un autre objet
                    pLog = new ProcessLog__c(Process__c = 'desabonner__isBatchCall_Exception', Account__c = sub.Zuora__Account__r.Id, AccountZID__c = sub.Zuora__CustomerAccount__r.Zuora__External_Id__c, SubscriptionZID__c = sub.Zuora__External_Id__c, SubscriptionName__c = sub.Name ,Message__c = fullMessage);
                    insert pLog;
                    //throw new RTException(RTExceptionCode.ERREUR_RETENTION_PRODUIT_ABSENT,pLog);
                    //throw new MyException(e);
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

    private class MyException extends Exception {
    }

}