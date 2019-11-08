public without sharing class SM002_Anonymisation{
    
   public enum AnonymisationType {ALL, ONLY_ZUORA}
    
    public static String endpoint = '/v1/action/update';
    public static ProcessLog__c pLog;
    public static zc_GETSubscriptionTypeWithSuccess subZdoc;
    public static zc_ProxyGetPaymentMethod pm;
    
    public static LCC003_Dispatcher.MSGRep accountAnonymisationFromQuickAction(String caseId, AnonymisationType AT){
        
        LCC003_Dispatcher.MSGRep rep = new LCC003_Dispatcher.MSGRep();
        if(caseId == null){
            rep.showMessage         = true;
            rep.messageToDisplay    = 'No Id found for Anonymisation';
            rep.isWarning           = true;
            return rep;
        }
        //Case c = [SELECT Id, AccountId, Account.Tech_IdMonCompte__c FROM Case WHERE Id =:caseId].get(0);
        Case c = SM_Demande.getDemande(caseId);
        Id accId = c.AccountId;
        Account acc = new Account(Id = accId);
        acc.Tech_IdMonCompte__c = c.Account.Tech_IdMonCompte__c;
        list<Account> listAccs = new list<Account>();
        listAccs.add(acc);
        
        /*pLog = new ProcessLog__c(Process__c = 'Anonymisation', Account__c = dem.AccountId, SubscriptionName__c = dem.SubscriptionZName__c, Case__c = caseId);
        
        Zuora__Subscription__c sub = SM_Subscription.getActiveSubscriptionByNameORAccId(c.SubscriptionZName__c, c.AccountId);
        if (sub == null) {
            throw new RTException(RTExceptionCode.ERREUR_DESABO_CONTRAT_ABSENT_DDE,pLog);
        }
        
        //Debut call out pour ZDOC
        String accessToken = WS001_CallZuora.access_token;
        // Get Zuora Data (subscription)
        subZdoc = zc_Api.subscriptionGET(accessToken, zEntityId, sub.Zuora__Zuora_Id__c, RTExceptionCode.ERREUR_ACQUISIT_GET_ZSUBSCRIPTION, pLog);
        // Get Zuora Data (Account)
        zc_ProxyGetAccount zacc = zc_Api.objectAccountGET(accessToken, zEntityId, sub.Zuora__CustomerAccount__r.Zuora__Zuora_Id__c, RTExceptionCode.ERREUR_ACQUISIT_GET_ACCOUNT, pLog);
        String payMethodId = zacc.defaultPaymentMethodId;
        // Get Zuora Data (PaymentMethod)
        pm = zc_Api.objectPaymentMethodGET(accessToken, zEntityId, payMethodId, RTExceptionCode.ERREUR_ACQUISIT_GET_PAYMENTMETHOD, pLog);
        //Fin call out pour ZDOC*/
        
        accountAnonymisation(listAccs, AT);
        
        Id zDocId = SM_Hermes.addZdocData(subZdoc,pm);
		c.ZDocData__c = zDocId;
		c.Status = 'Fermee';
    	update c;
    	SM_SDoc.makeSdocJobs(new list<Case>{c});
        
        return rep;
    }
    
    public static void accountAnonymisation(List<Account> accounts, AnonymisationType AT){
        system.debug('##MNE SM002_Anonymisation accountAnonymisation accounts >> '+accounts);
        system.debug('##MNE SM002_Anonymisation accountAnonymisation accounts.size >> '+accounts.size());
        system.debug('##MNE SM002_Anonymisation accountAnonymisation AT >> '+AT);
        Set<Id> accId = new Set<Id>();
        for(Account acc : accounts){
            accId.add(acc.Id);
        }
        
        List<Zuora__CustomerAccount__c> billingAccounts = new List<Zuora__CustomerAccount__c>([SELECT Id, Zuora__Zuora_Id__c, Zuora__BillToId__c, Zuora__SoldToId__c, Zuora__Account__r.ProduitUGC__c, Zuora__Account__r.CodePays__c FROM Zuora__CustomerAccount__c WHERE Zuora__Account__c IN :accId]);
        set<String> setBillingAccountZId = new set<String>();
        set<String> setContactZId = new set<String>();
        String codePays = null;
        
        
        if(billingAccounts.size() > 0){
            for(Zuora__CustomerAccount__c zAcc : billingAccounts){
                if(zAcc.Zuora__Zuora_Id__c != null){
                    setBillingAccountZId.add(zAcc.Zuora__Zuora_Id__c);
                }
                if(zAcc.Zuora__BillToId__c != null){
                    setContactZId.add(zAcc.Zuora__BillToId__c);
                }
                if(zAcc.Zuora__SoldToId__c != null){
                    setContactZId.add(zAcc.Zuora__SoldToId__c);
                }
                if(codePays == null && String.isNotBlank(zAcc.Zuora__Account__r.CodePays__c)){
                    codePays = zAcc.Zuora__Account__r.CodePays__c;
                }
            }
        }
        
        String zEntityId = WS001_CallZuora.getZuoraEntityId(codePays);
        
        if(setBillingAccountZId != null && setBillingAccountZId.size() > 0){
            String repWSAcc = sendRequestAccount(setBillingAccountZId, zEntityId);
            system.debug('##MNE SM002_Anonymisation repWSAcc >> '+repWSAcc);
            //list<Result> resApexAcc =   (list<Result>)System.JSON.deserialize(repWSAcc, list<Result>.class);
            //system.debug('##MNE SM002_Anonymisation resApexAcc >> '+resApexAcc);
        }
        
        if(setContactZId != null && setContactZId.size() > 0){
            String repWSCont = sendRequestContact(setContactZId, zEntityId);
            system.debug('##MNE SM002_Anonymisation repWSCont >> '+repWSCont);
            //list<Result> resApexCont =   (list<Result>)System.JSON.deserialize(repWSCont, list<Result>.class);
            //system.debug('##MNE SM002_Anonymisation resApexCont >> '+resApexCont);
        }
        
        if(AT == AnonymisationType.ALL){
            List<Case> cases = new List<Case>([SELECT Id FROM Case WHERE AccountId IN :accId]);
            if(cases.size() > 0){
                delete cases;
            }
            
            if(accounts.size() > 0){
                delete accounts;
            }
            
            List<FeedItem> feedItems = new List<FeedItem>([SELECT id FROM FeedItem WHERE ParentId IN :accId]);
            if(feedItems.size() > 0){
                delete feedItems;
            }
            
            //Anonymisation in RCU
            for(Account accTMP : accounts){
                if(String.isNotBlank(accTMP.Tech_IdMonCompte__c)){
                    sendAnonymisationSFDC(accTMP.Tech_IdMonCompte__c);
                }
            }
            
        } else if (AT == AnonymisationType.ONLY_ZUORA){
            List<Case> cases = new List<Case>([SELECT Id FROM Case WHERE AccountId IN :accId AND SubscriptionZName__c != null]); 
            if(cases.size() > 0){
                delete cases;
            }
        }
        
        List<Carte__c> cartes = new List<Carte__c>([SELECT Id FROM Carte__c WHERE Abonn__c IN :accId]);
        if(cartes.size() > 0){
            delete cartes;
        }
        
        billingAccounts = new List<Zuora__CustomerAccount__c>([SELECT Id FROM Zuora__CustomerAccount__c WHERE Zuora__Account__c IN :accId]);
        if(billingAccounts.size() > 0){
            delete billingAccounts;
        }
        
        
    }
    
    public static String sendRequest(String inBody, String zEntityId){
        system.debug('##MNE SM002_Anonymisation sendRequest inBody >> '+inBody);
        
        String access_token = WS001_CallZuora.oauthLogin();
        system.debug('##MNE SM002_Anonymisation sendRequest access_token >> '+access_token);
        
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
        
        system.debug('##MNE SM002_Anonymisation sendRequest rep >> '+rep);
        return rep;
    }
    
    public static String sendRequestAccount (set<String> ZAccIds, String zEntityId){
        system.debug('##MNE SM002_Anonymisation sendRequestAccount ZAccIds >> '+ZAccIds);
        String rep = null;
        if(ZAccIds != null && ZAccIds.size() > 0){
            String inBody = getAccBody(ZAccIds);
            rep = sendRequest(inBody, zEntityId);
        }
        return rep;
    }
    
    public static String sendRequestContact (set<String> ZContIds, String zEntityId){
        system.debug('##MNE SM002_Anonymisation sendRequestContact ZContIds >> '+ZContIds);
        String rep = null;
        if(ZContIds != null && ZContIds.size() > 0){
            String inBody = getContBody(ZContIds);
            rep = sendRequest(inBody, zEntityId);
        }
        return rep;
        
    }

    public static String getAccBody (set<String> ZAccIds){
        try{
            AccBody res = new AccBody(ZAccIds);
            String s = JSON.serialize(res);
            system.debug('##MNE json rep >> '+s);
            return s;
        }catch(Exception e){
            system.debug('##MNE SM002_Anonymisation getAccBody exception >> '+e.getMessage());
            throw e;
        }
    }
    
    public static String getContBody (set<String> ZContIds){
        try{
            ContBody res = new ContBody(ZContIds);
            String s = JSON.serialize(res);
            system.debug('##MNE json rep >> '+s);
            return s;
        }catch(Exception e){
            system.debug('##MNE SM002_Anonymisation getContBody exception >> '+e.getMessage());
            throw e;
        }
    }
    
    
    public static String sendAnonymisationSFDC (String RCUId){
        system.debug('##MNE SM002_Anonymisation sendAnonymisationSFDC RCUId >> '+RCUId);
        
        String endpoint = '/AnonymesEndormis/PostCompte';
        AnonymesObj anonymesObjTMP = new AnonymesObj(RCUId);
        String inBody = JSON.serialize(anonymesObjTMP);
        
        system.debug('##MNE SM002_Anonymisation sendAnonymisationSFDC inBody >> '+inBody);
        
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:HerculeAPI'+endpoint);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setTimeout(60000);
        req.setBody(inBody);
        
        HttpResponse res = h.send(req);
        String rep = res.getBody();
        
        system.debug('##MNE SM002_Anonymisation sendAnonymisationSFDC rep >> '+rep);
        return rep;
    }
    
    //-----------------------------------Request AccBody-----------------------------------------
    public class AccBody {
        list <AccObject> objects = new list <AccObject> ();
        public String type;
 
        public AccBody (set<String> ZAccIds){
            this.objects = new list<AccObject>();
            type = 'Account';
            if(ZAccIds != null && ZAccIds.size() > 0){
                for(String ZAccId : ZAccIds){
                    this.objects.add(new AccObject(ZAccId));
                }
            }
        }
    }
    //-----------------------------------Request AccObject-----------------------------------------
    public class AccObject {
        public String Name;
        public String Id;
        public String CrmId;
 
        public AccObject(String ZAccId){
            this.Id = ZAccId;
            this.Name= 'Anonyme';
            this.CrmId = '';
        }
    }
    
    
    //-----------------------------------Request ContBody-----------------------------------------
    public class ContBody {
        list <ContObject> objects = new list <ContObject> ();
        public String type;
 
        public ContBody (set<String> ZContIds){
            this.objects = new list<ContObject>();
            type = 'Contact';
            if(ZContIds != null && ZContIds.size() > 0){
                for(String ZContId : ZContIds){
                    this.objects.add(new ContObject(ZContId));
                }
            }
        }
    }
    //-----------------------------------Request ContObject-----------------------------------------
    public class ContObject {
        public String Address2;
        public String MobilePhone;
        public String Id;
        public String FirstName;
        public String NickName;
        public String WorkEmail;
        public String HomePhone;
        public String Description;
        public String OtherPhone;
        public String Fax;
        public String County;
        public String PostalCode;
        public String TaxRegion;
        public String State;
        public String City;
        public String PersonalEmail;
        public String WorkPhone;
        public String Address1;
        public String LastName;
 
        public ContObject(String ZContId){
            this.Address2 = '';
            this.MobilePhone = '';
            this.Id = ZContId;
            this.FirstName = 'Anonyme';
            this.NickName = '';
            this.WorkEmail = '';
            this.HomePhone = '';
            this.Description = '';
            this.OtherPhone = '';
            this.Fax = '';
            this.County = '';
            this.PostalCode = '';
            this.TaxRegion = '';
            this.State = '';
            this.City = '';
            this.PersonalEmail = '';
            this.WorkPhone = '';
            this.Address1 = '';
            this.LastName = 'Anonyme';
        }
    }
    
    
    //-----------------------------------Response Resultat-----------------------------------
    public class Resultat {
        public list<Result> results = null;
    }
    //-----------------------------------Result-----------------------------------
    public class Result {
        public Boolean Success;
        public String Id;
    }
    
    public class AnonymesObj {
        public String Pays;
        public String CompteID;
        public String Statut;
        public String DateChangementStatut;
        
        public AnonymesObj (String CompteID){
            Pays = '033';
            this.CompteID = CompteID;
            Statut = 'anonyme';
            DateChangementStatut = String.valueOf(Date.today());
        }
    }
    
}