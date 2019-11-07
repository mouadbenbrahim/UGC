public with sharing class SM_Hermes {
    public SM_Hermes() {

    }

    public static WSZ.SubHermesOut acquisition(WSZ.SubHermesIn hermesIn){
        
        Account acc = SM_Account.getAccount(hermesIn.accountId);
        ProcessLog__c pLog = new ProcessLog__c(Process__c = 'acquisition', Account__c = hermesIn.accountId, AccountZID__c = hermesIn.accountZID, SubscriptionZID__c = hermesIn.subscriptionZID);

        // Zuora token
        String accessToken = WS001_CallZuora.access_token;
        String zEntityId = WS001_CallZuora.getZuoraEntityId(acc.CodePays__c);

        // Get Zuora Data (subscription)
        zc_GETSubscriptionTypeWithSuccess sub = zc_Api.subscriptionGET(accessToken, zEntityId, hermesIn.subscriptionZID, RTExceptionCode.ERREUR_ACQUISIT_GET_ZSUBSCRIPTION,pLog);

        // Get Zuora Data (Account)
        zc_ProxyGetAccount zacc = zc_Api.objectAccountGET(accessToken, zEntityId, hermesIn.accountZID, RTExceptionCode.ERREUR_ACQUISIT_GET_ACCOUNT,pLog);
        String payMethodId = zacc.defaultPaymentMethodId;

        // Get Zuora Data (PaymentMethod)
        zc_ProxyGetPaymentMethod pm = zc_Api.objectPaymentMethodGET(accessToken, zEntityId, payMethodId, RTExceptionCode.ERREUR_ACQUISIT_GET_PAYMENTMETHOD,pLog);

        // insert zdocdata subscription
        Id zDocId = addZdocData(sub,pm);

        // insert case
        String sousMotif = lieuToSousMotif(hermesIn.lieu);
        Case c = newCase(zDocId, hermesIn.subscriptionName, acc.PersonContactId, hermesIn.origin, '0- Souscription', hermesIn.motif, sousMotif, 'Fermee', 
        hermesIn.lieu, hermesIn.commentairesInternes, hermesIn.accountId,null,null,null);
        Id caseId = c.Id;

        // generate sDoc 
        List<Case> cs = [SELECT Id,AccountId,TECHIdStatut__c FROM Case WHERE Id=:caseId];
        SM_SDoc.makeSdocJobs(cs);

        // insert Fil impression
        List<Carte__c> cartes = [Select Id from Carte__c where Name = :hermesIn.numeroCarte];
        Id carteId = (cartes.size() > 0)?cartes.get(0).Id:null;
        ZDocData__c zDoc = [Select Id, Payeur__r.FirstName, Payeur__r.LastName from ZDocData__c where Id = :zDocId];
        SM_FileImpression.createFileImpressionCarte(hermesIn.numeroCarte, (Id)hermesIn.accountId, carteId, caseId, hermesIn.subscriptionName, sub.CodeOffrePrincipale, zDoc.Payeur__r.FirstName, zDoc.Payeur__r.LastName);

        //RETURN
        WSZ.SubHermesOut hermOut = new WSZ.SubHermesOut(hermesIn.accountId, hermesIn.accountZID, hermesIn.subscriptionZID, hermesIn.subscriptionName, caseId);

        return hermOut;
    }

public static WSZ.SubHermesOut migration(WSZ.SubHermesIn hermesIn){
        
        Date dateFinContrat = Date.valueOf(hermesIn.dateFinContrat);
        Account acc = SM_Account.getAccount(hermesIn.accountId);
        ProcessLog__c pLog = new ProcessLog__c(Process__c = 'acquisition', Account__c = hermesIn.accountId, AccountZID__c = hermesIn.accountZID, SubscriptionZID__c = hermesIn.subscriptionZID);

        // Zuora token
        String accessToken = WS001_CallZuora.access_token;
        String zEntityId = WS001_CallZuora.getZuoraEntityId(acc.CodePays__c);

        // Get Zuora Data (subscription)
        zc_GETSubscriptionTypeWithSuccess sub = zc_Api.subscriptionGET(accessToken, zEntityId, hermesIn.subscriptionZID, RTExceptionCode.ERREUR_ACQUISIT_GET_ZSUBSCRIPTION,pLog);

        // Get Zuora Data (Account)
        zc_ProxyGetAccount zacc = zc_Api.objectAccountGET(accessToken, zEntityId, hermesIn.accountZID, RTExceptionCode.ERREUR_ACQUISIT_GET_ACCOUNT,pLog);
        String payMethodId = zacc.defaultPaymentMethodId;

        // Get Zuora Data (PaymentMethod)
        zc_ProxyGetPaymentMethod pm = zc_Api.objectPaymentMethodGET(accessToken, zEntityId, payMethodId, RTExceptionCode.ERREUR_ACQUISIT_GET_PAYMENTMETHOD,pLog);

        // insert zdocdata subscription
        Id zDocId = addZdocData(sub,pm);

        // Insert case
        String sousMotif = lieuToSousMotif(hermesIn.lieu);
        Case c = newCase(zDocId, hermesIn.subscriptionName, acc.PersonContactId, hermesIn.origin, '1- Vie de l\'abonnement', hermesIn.motif, sousMotif, 'Fermee', 
        hermesIn.lieu, hermesIn.commentairesInternes, hermesIn.accountId,hermesIn.typeDeMigration,hermesIn.creditMemoId,hermesIn.dateFinContrat);
        Id caseId = c.Id;

        // generate sDoc 
        List<Case> cs = [SELECT Id,AccountId,TECHIdStatut__c FROM Case WHERE Id=:caseId];
        SM_SDoc.makeSdocJobs(cs);

        // insert Fil impression
        //List<Carte__c> cartes = [Select Id from Carte__c where Name = :hermesIn.numeroCarte];
        //Id carteId = (cartes.size() > 0)?cartes.get(0).Id:null;
        ZDocData__c zDoc = [Select Id, Payeur__r.FirstName, Payeur__r.LastName from ZDocData__c where Id = :zDocId];
        SM_FileImpression.createFileImpressionCarte(null, (Id)hermesIn.accountId, null, caseId, hermesIn.subscriptionName, sub.CodeOffrePrincipale, zDoc.Payeur__r.FirstName, zDoc.Payeur__r.LastName);

            
        // Create case remboursement
        if(hermesIn.creditMemoId != null){
            // get creditmemo
            WSZ.CreditMemoOut cm = SM_CreditMemo.getCreditMemo(hermesIn.creditMemoId, zEntityId);
            Decimal amountToRefund = Decimal.valueOf(cm.amount);
            if(amountToRefund < 0){
                amountToRefund = amountToRefund * -1;
            }
            Decimal amountToRefundRoundFromCreditMemo = amountToRefund.setScale(2);

            SM_Remboursement.createRebousementCase(caseId, amountToRefundRoundFromCreditMemo, amountToRefundRoundFromCreditMemo, (Id)hermesIn.accountId, hermesIn.creditMemoId, dateFinContrat, null, Date.today(), hermesIn.subscriptionName);
        }

        WSZ.SubHermesOut hermOut = new WSZ.SubHermesOut(hermesIn.accountId, hermesIn.accountZID, hermesIn.subscriptionZID, hermesIn.subscriptionName, caseId);

        return hermOut;

}

    public static WSZ.SubHermesOut reedition(WSZ.SubHermesIn hermesIn){
        
        Account acc = SM_Account.getAccount(hermesIn.accountId);
        ProcessLog__c pLog = new ProcessLog__c(Process__c = 'acquisition', Account__c = hermesIn.accountId, AccountZID__c = hermesIn.accountZID, SubscriptionZID__c = hermesIn.subscriptionZID);

        // Zuora token
        String accessToken = WS001_CallZuora.access_token;
        String zEntityId = WS001_CallZuora.getZuoraEntityId(acc.CodePays__c);

        // Get Zuora Data (subscription)
        zc_GETSubscriptionTypeWithSuccess sub = zc_Api.subscriptionGET(accessToken, zEntityId, hermesIn.subscriptionZID, RTExceptionCode.ERREUR_ACQUISIT_GET_ZSUBSCRIPTION,pLog);

        // Get Zuora Data (Account)
        zc_ProxyGetAccount zacc = zc_Api.objectAccountGET(accessToken, zEntityId, hermesIn.accountZID, RTExceptionCode.ERREUR_ACQUISIT_GET_ACCOUNT,pLog);
        String payMethodId = zacc.defaultPaymentMethodId;

        // Get Zuora Data (PaymentMethod)
        zc_ProxyGetPaymentMethod pm = zc_Api.objectPaymentMethodGET(accessToken, zEntityId, payMethodId, RTExceptionCode.ERREUR_ACQUISIT_GET_PAYMENTMETHOD,pLog);

        // insert zdocdata subscription
        Id zDocId = addZdocData(sub,pm);

        // insert case
        String sousMotif = lieuToSousMotif(hermesIn.lieu);
        String commentairesInternes = (hermesIn.motif == '02- Réédition payante')?'réédition payante':'réédition gratuite'; //03- Réédition gratuite
        
        Case c = newCase(zDocId, hermesIn.subscriptionName, acc.PersonContactId, hermesIn.origin, '1- Vie de l\'abonnement', hermesIn.motif, sousMotif, 'Fermee', 
        hermesIn.lieu, commentairesInternes, hermesIn.accountId,hermesIn.typeDeMigration,hermesIn.creditMemoId,hermesIn.dateFinContrat);
        Id caseId = c.Id;

        // generate sDoc 
        List<Case> cs = [SELECT Id,AccountId,TECHIdStatut__c FROM Case WHERE Id=:caseId];
        SM_SDoc.makeSdocJobs(cs);

        // insert Fil impression
        //List<Carte__c> cartes = [Select Id from Carte__c where Name = :hermesIn.numeroCarte];
        //Id carteId = (cartes.size() > 0)?cartes.get(0).Id:null;
        ZDocData__c zDoc = [Select Id, Payeur__r.FirstName, Payeur__r.LastName from ZDocData__c where Id = :zDocId];
        SM_FileImpression.createFileImpressionCarte(null, (Id)hermesIn.accountId, null, caseId, hermesIn.subscriptionName, sub.CodeOffrePrincipale, zDoc.Payeur__r.FirstName, zDoc.Payeur__r.LastName);

        //RETURN
        WSZ.SubHermesOut hermOut = new WSZ.SubHermesOut(hermesIn.accountId, hermesIn.accountZID, hermesIn.subscriptionZID, hermesIn.subscriptionName, caseId);

        return hermOut;

    }

    public static WSZ.SubHermesOut renouvellement(WSZ.SubHermesIn hermesIn){
        
        Account acc = SM_Account.getAccount(hermesIn.accountId);
        ProcessLog__c pLog = new ProcessLog__c(Process__c = 'acquisition', Account__c = hermesIn.accountId, AccountZID__c = hermesIn.accountZID, SubscriptionZID__c = hermesIn.subscriptionZID);

        // Zuora token
        String accessToken = WS001_CallZuora.access_token;
        String zEntityId = WS001_CallZuora.getZuoraEntityId(acc.CodePays__c);

        // Get Zuora Data (subscription)
        zc_GETSubscriptionTypeWithSuccess sub = zc_Api.subscriptionGET(accessToken, zEntityId, hermesIn.subscriptionZID, RTExceptionCode.ERREUR_ACQUISIT_GET_ZSUBSCRIPTION,pLog);

        // Get Zuora Data (Account)
        zc_ProxyGetAccount zacc = zc_Api.objectAccountGET(accessToken, zEntityId, hermesIn.accountZID, RTExceptionCode.ERREUR_ACQUISIT_GET_ACCOUNT,pLog);
        String payMethodId = zacc.defaultPaymentMethodId;

        // Get Zuora Data (PaymentMethod)
        zc_ProxyGetPaymentMethod pm = zc_Api.objectPaymentMethodGET(accessToken, zEntityId, payMethodId, RTExceptionCode.ERREUR_ACQUISIT_GET_PAYMENTMETHOD,pLog);

        // insert zdocdata subscription
        Id zDocId = addZdocData(sub,pm);

        // insert case
        String sousMotif = lieuToSousMotif(hermesIn.lieu);
        //TODO commentaire interne, voir si on rappatrie en local: -> NON: trop d informations non presente en local
        Case c = newCase(zDocId, hermesIn.subscriptionName, acc.PersonContactId, hermesIn.origin, '1- Vie de l\'abonnement', hermesIn.motif, sousMotif, 'Fermee', 
        hermesIn.lieu, hermesIn.commentairesInternes, hermesIn.accountId,hermesIn.typeDeMigration,hermesIn.creditMemoId,hermesIn.dateFinContrat);
        Id caseId = c.Id;

        // generate sDoc 
        List<Case> cs = [SELECT Id,AccountId,TECHIdStatut__c FROM Case WHERE Id=:caseId];
        SM_SDoc.makeSdocJobs(cs);

        //RETURN
        WSZ.SubHermesOut hermOut = new WSZ.SubHermesOut(hermesIn.accountId, hermesIn.accountZID, hermesIn.subscriptionZID, hermesIn.subscriptionName, caseId);

        return hermOut;

    }

    public static WSZ.SubHermesOut changebanque(WSZ.SubHermesIn hermesIn){
        
        Account acc = SM_Account.getAccount(hermesIn.accountId);
            ProcessLog__c pLog = new ProcessLog__c(Process__c = 'acquisition', Account__c = hermesIn.accountId, AccountZID__c = hermesIn.accountZID, SubscriptionZID__c = hermesIn.subscriptionZID);    

        // Zuora token
        String accessToken = WS001_CallZuora.access_token;
        String zEntityId = WS001_CallZuora.getZuoraEntityId(acc.CodePays__c);

        // Get Zuora Data (subscription)
        zc_GETSubscriptionTypeWithSuccess sub = zc_Api.subscriptionGET(accessToken, zEntityId, hermesIn.subscriptionZID, RTExceptionCode.ERREUR_ACQUISIT_GET_ZSUBSCRIPTION,pLog);

        // Get Zuora Data (Account)
        zc_ProxyGetAccount zacc = zc_Api.objectAccountGET(accessToken, zEntityId, hermesIn.accountZID, RTExceptionCode.ERREUR_ACQUISIT_GET_ACCOUNT,pLog);
        String payMethodId = zacc.defaultPaymentMethodId;

        // Get Zuora Data (PaymentMethod)
        zc_ProxyGetPaymentMethod pm = zc_Api.objectPaymentMethodGET(accessToken, zEntityId, payMethodId, RTExceptionCode.ERREUR_ACQUISIT_GET_PAYMENTMETHOD,pLog);

        // insert zdocdata subscription
        Id zDocId = addZdocData(sub,pm);

        // insert case
        String sousMotif = lieuToSousMotif(hermesIn.lieu);

        Case c = newCase(zDocId, hermesIn.subscriptionName, acc.PersonContactId, hermesIn.origin, '7- Finance', hermesIn.motif, sousMotif, 'Fermee', 
        hermesIn.lieu, hermesIn.commentairesInternes, hermesIn.accountId,hermesIn.typeDeMigration,hermesIn.creditMemoId,hermesIn.dateFinContrat);
        Id caseId = c.Id;

        // generate sDoc 
        List<Case> cs = [SELECT Id,AccountId,TECHIdStatut__c FROM Case WHERE Id=:caseId];
        SM_SDoc.makeSdocJobs(cs);

        //RETURN
        WSZ.SubHermesOut hermOut = new WSZ.SubHermesOut(hermesIn.accountId, hermesIn.accountZID, hermesIn.subscriptionZID, hermesIn.subscriptionName, caseId);

        return hermOut;

    }


    private static Case newCase(Id zDocId, String subscriptionName, Id personContactId, String origin, String famille, String motif, String sousMotif, String status, String lieu, 
    String commentairesInternes, String accountId, String typeDeMigration, String creditMemoId, String dateFinContrat){

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
        //c.ContactId = personContactId;
        c.SubscriptionZName__c = subscriptionName;
        insert c;
        return c;

    }
    
    private static String lieuToSousMotif(String lieu){
                
        String sousMotif;
        if (lieu == 'WEB') {
           sousMotif = 'AH- Action Selfcare';
        }else if (lieu == 'HORIZ') {
            sousMotif = 'AD- Action DRC';
        }else {
            sousMotif = 'AS- Action Stand';
        } // 'A- Action'; // AS- Action Stand // AH- Action Selfcare // AD- Action DRC

        return sousMotif;
    }

    public static Id addZdocData(zc_GETSubscriptionTypeWithSuccess sub, zc_ProxyGetPaymentMethod pm){
        
        ZDocData__c zDoc = new ZDocData__c();
        //TODO zDoc.Account__c = ;
        zDoc.AutoRenew__c = sub.autoRenew;
        zDoc.BankTransferAccountNumber__c = pm.bankTransferAccountNumber;
        zDoc.CancelledDate__c = (sub.status=='Cancelled')?sub.termEndDate:null;
        zDoc.Cinema__r = new Complexe__c(CodeComplexe__c = sub.Lieu); //update the lookup
        zDoc.CodeFinContrat__c = sub.CodeFinContrat;
        zDoc.CodeOffrePrincipale__c = sub.CodeOffrePrincipale;
        zDoc.CodePromo__c = sub.CodePromo;
        zDoc.ContractEffectiveDate__c = sub.contractEffectiveDate;
        zDoc.CurrentTerm__c = String.valueOf(sub.currentTerm);
        zDoc.CurrentTermPeriodType__c = sub.currentTermPeriodType;
        zDoc.DateFinContrat__c = sub.DateFinContrat;
        zDoc.Lieu__c = sub.Lieu;
        zDoc.MandateID__c = pm.mandateID;
        zDoc.Marche__c = sub.Marche;
        zDoc.Methodedepaiement__c = sub.MethodePaiement;
        zDoc.ModeLivraison__c = sub.ModeLivraison;
        // zDoc.Name = // TODO : par default Id
        zDoc.PayeurCRMID__c = sub.PayeurCRMID;
        zDoc.Payeur__c = sub.PayeurCRMID;
        zDoc.Source__c = sub.Source;
        zDoc.Status__c = sub.status;
        zDoc.Subscriptionname__c = sub.subscriptionNumber;
        zDoc.TermEndDate__c = sub.termEndDate;
        zDoc.TypeContrat__c = sub.TypeContrat;
        insert zDoc;
        return zDoc.Id;

    }

 

}