public with sharing class SM_Hermes {
    public SM_Hermes() {

    }

    public static Case newCase(Id zDocId, String subscriptionName, Id personContactId, String origin, String famille, String motif, String sousMotif, String status, String lieu, 
    String commentairesInternes, String accountId, String typeDeMigration, String creditMemoId, String dateFinContrat, String agent){

        Case c = new Case();
        c.Origin =  origin;
        c.Famille__c  = famille;
        c.Motif__c = motif;
        c.SousMotif__c = sousMotif;       
        c.Cinema__r = new Complexe__c(CodeComplexe__c = lieu);
        c.CommentairesInternes__c = commentairesInternes;
        c.AccountId = accountId;
        c.Status = status;
        c.Type_de_migration__c = typeDeMigration;
        c.CreditMemoId__c = creditMemoId;
        if (dateFinContrat != null ) {c.DateFinContrat__c = Date.valueOf(dateFinContrat);}        
        c.ZDocData__c = zDocId;
        c.ContactId = personContactId;
        c.SubscriptionZName__c = subscriptionName;
        List<User> users = [Select Id from User where AgentExtRef__c = :agent];
        if (users.size() == 1) {
            c.OwnerId = users.get(0).Id;
        }else{
            Database.DMLOptions dmo = new Database.DMLOptions();
            dmo.assignmentRuleHeader.useDefaultRule= false;
            c.setOptions(dmo);
        }

        insert c;
        return c;

    }

    public static Case newCase2(Id zDocId, String subscriptionName, Id personContactId, String origin, String famille, String motif, String sousMotif, String status, String lieu, 
    String commentairesInternes, String accountId, String typeDeMigration, String creditMemoId, Date dateFinContrat, String agent){

        Case c = new Case();
        c.Origin =  origin;
        c.Famille__c  = famille;
        c.Motif__c = motif;
        c.SousMotif__c = sousMotif;       
        c.Cinema__r = new Complexe__c(CodeComplexe__c = lieu);
        c.CommentairesInternes__c = commentairesInternes;
        c.AccountId = accountId;
        c.Status = status;
        c.Type_de_migration__c = typeDeMigration;
        c.CreditMemoId__c = creditMemoId;
        if (dateFinContrat != null ) {c.DateFinContrat__c = dateFinContrat.addDays(1);}        
        c.ZDocData__c = zDocId;
        c.ContactId = personContactId;
        c.SubscriptionZName__c = subscriptionName;
        if (agent != null) {
            List<User> users = [Select Id from User where AgentExtRef__c = :agent];
            if (users.size() == 1){
                c.OwnerId = users.get(0).Id;
            }
            else{
                Database.DMLOptions dmo = new Database.DMLOptions();
                dmo.assignmentRuleHeader.useDefaultRule= false;
                c.setOptions(dmo);
            }
        }        
        insert c;
        return c;

    }
    
    public static String lieuToSousMotif(String lieu){
                
        String sousMotif;
        if (lieu == 'WEB') {
           sousMotif = 'AH- Action Selfcare';
        }else if (lieu == 'DRC') {
            sousMotif = 'AD- Action DRC';
        }else {
            sousMotif = 'AS- Action Stand';
        } // 'A- Action'; // AS- Action Stand // AH- Action Selfcare // AD- Action DRC
        return sousMotif;
    }

    public static String lieuToMotif(String lieu, Boolean isB2B){
                
        String motif;
        if (lieu == 'DRC') {
           motif = '06- VPC';
        }else if (isB2B == true) {
            motif = '05- B2B';
        }else {
            motif = '07- Création abonnement';
        } // 'A- Action'; // AS- Action Stand // AH- Action Selfcare // AD- Action DRC
        return motif;
    }    

    public static String lieuToOrigin(String lieu){
                
        String origin;
        if (lieu == 'WEB') {
           origin = 'Selfcare';
        }else if (lieu == 'DRC') {
            origin = 'Courrier entrant';
        }else {
            origin = 'Salle';
        } // 'A- Action'; // AS- Action Stand // AH- Action Selfcare // AD- Action DRC
        return origin;
    }

    //public static Id addZdocData(zc_GETSubscriptionTypeWithSuccess sub, zc_ProxyGetPaymentMethod pm){
    public static Id addZdocData(Map<String,Object> zdd){

        zc_GETSubscriptionTypeWithSuccess zsub;
        zc_ProxyGetPaymentMethod zpm;
        Account acc;
        ZDocData__c zDoc = new ZDocData__c();

        if(zdd.containsKey('ZSUB')){
            zsub = (zc_GETSubscriptionTypeWithSuccess)zdd.get('ZSUB');
            zDoc.AutoRenew__c = zsub.autoRenew;
            zDoc.CancelledDate__c = (zsub.status=='Cancelled')?zsub.termEndDate:null;
            zDoc.Cinema__r = new Complexe__c(CodeComplexe__c = zsub.Lieu); //update the lookup
            zDoc.CodeFinContrat__c = zsub.CodeFinContrat;
            zDoc.CodeOffreCo__c = zsub.CodeOffreCo;
            zDoc.CodeOffrePrincipale__c = zsub.CodeOffrePrincipale;
            zDoc.CodePromo__c = zsub.CodePromo;
            zDoc.ContractEffectiveDate__c = zsub.contractEffectiveDate; //TODO il faut ajouter subscriptionStartDate /termStartDate et verfier dans SF quel date est utilise
            zDoc.CurrentTerm__c = String.valueOf(zsub.currentTerm);
            zDoc.CurrentTermPeriodType__c = zsub.currentTermPeriodType;
            zDoc.DateFinContrat__c = zsub.DateFinContrat;
            zDoc.Lieu__c = zsub.Lieu;
            zDoc.Marche__c = zsub.Marche;
            zDoc.Methodedepaiement__c = zsub.MethodePaiement;
            zDoc.ModeLivraison__c = zsub.ModeLivraison;
            // zDoc.Name = // TODO : par default Id

            if (zsub.CodeOffreCo != null){
                List<String> offresCo = zsub.CodeOffreCo.split('-');
                if (offresCo.size() > 0 && offresCo.get(0) != null) {
                    zDoc.Offre1__r = new Offre__c(Reference__c = offresCo.get(0));
                }
                if (offresCo.size() > 1 && offresCo.get(1) != null) {
                    zDoc.Offre2__r = new Offre__c(Reference__c = offresCo.get(1));
                } 
            }

            zDoc.PayeurCRMID__c = zsub.PayeurCRMID;
            zDoc.Payeur__c = zsub.PayeurCRMID;
            zDoc.Source__c = zsub.Source;
            zDoc.Status__c = zsub.status;
            zDoc.Subscriptionname__c = zsub.subscriptionNumber;
            zDoc.TermEndDate__c = zsub.termEndDate;
            zDoc.TypeContrat__c = zsub.TypeContrat;            
        }

        if(zdd.containsKey('ZPM')){
            zpm = (zc_ProxyGetPaymentMethod)zdd.get('ZPM');
            zDoc.BankTransferAccountNumber__c = zpm.BankTransferAccountNumberMask;
            zDoc.MandateID__c = zpm.mandateID;
            
        }

        if(zdd.containsKey('ACC')){
            acc = (Account)zdd.get('ACC');
            zDoc.Account__c = acc.Id;            
        }

        insert zDoc;
        return zDoc.Id;

    }

    public static String getExtPaymentMethodId(Boolean isB2B, String pmCode, String codePays){

        pmCode = (isB2B)?'BTB':pmCode; //TODO pour CBI a detailler en fonction des cas.
        String pmId =  Utils.getUgcGenericParam('Zuora_PM_'+pmCode,codePays).ParamValue__c;

        return pmId;
        
    }

    public static String getInvoiceTemplateId(Boolean isB2B, String codePays, String langueParle){

        String CodeLangueParle = (langueParle == 'Néerlandais')?'NL':'FR';
        String marche = (isB2B)?'BTOB':'BTOC';
        String invTemplateId = Utils.getUgcGenericParam('Zuora Template ' + CodeLangueParle + '_' + marche,codePays).ParamValue__c;

        return invTemplateId;
        
    }

    //public static void trackOperation(String action, Datetime dateOperation, Enum operation, String zOperation, String amendId, String subId, String subName)
    //@Future    
    public static void trackOperation(String action, Datetime dateOperation, String operation, String zOperation, String amendId, String subId, String subName, String codePays)
    {
        
        //TODO a activer pour le tracking
        // BillingOperation__c ope = new BillingOperation__c(Action__c = action, DateOperation__c = dateOperation, Operation__c=operation, Zoperation__c = zOperation, 
        // AmendZID__c= amendId, SubscriptionZID__c = subId, SubscriptionName__c = subName);
        // insert ope;
        
        //SMQ_TrackOperation trackOpe = new SMQ_TrackOperation(action, dateOperation, operation, zOperation, amendId, subId, subName);
        //Id jobId = System.enqueueJob(trackOpe);
    }


 

}