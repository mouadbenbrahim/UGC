public with sharing class SM_Subscribe {
    public SM_Subscribe() {

    }

    public static zc_ProxyActionsubscribeRequest subscribe(SubscribeIn subIn, Boolean isPreview, Account porteur, Account payeur, List<zc_AmendmentRatePlanData> subOffreRatePlans, Map<String,Object> customSub){

        // String sDateDebutContrat = (String)subMap.get('dateDebutContrat'); //).format('yyyy-MM-dd');
        // Date dateDebutContrat = Date.valueOf(sDateDebutContrat);
        // List<Object> produits = (List<Object>)subMap.get('produit');
        Date dateDebutContrat = subIn.dateDebutContrat;
        String produit = subIn.produit.get(0);
        String typeContrat = (produit.contains('CDI')?'CDI':'CDD');

        // Zuora subscribeRequest
        zc_ProxyActionsubscribeRequest subscribeReq = new zc_ProxyActionsubscribeRequest();
        zc_SubscribeRequest sub = new zc_SubscribeRequest();

        sub.account = subAccount(typeContrat, porteur,customSub);
        sub.billToContact = billToContact(payeur);
        sub.soldToContact = soldToContact(porteur);
        if (subIn.mandateId != null && subIn.iban != null && !isPreview) sub.paymentMethod = paymentMethod(typeContrat, payeur, subIn.iban, subIn.mandateId, customSub); // activer si isPreview = false
        sub.previewOptions = new zc_SubscribeRequestPreviewOptions();
        sub.subscriptionData = new zc_SubscribeRequestSubscriptionData();
        sub.subscribeOptions = new zc_SubscribeRequestSubscribeOptions();
        
        sub.previewOptions.enablePreviewMode = isPreview;
        //sub.previewOptions.previewType = sub.previewOptions.PreviewTypeEnum.//'InvoiceItem';
        sub.previewOptions.numberOfPeriods = 5;


        //invoiceOptions
        sub.subscribeOptions.generateInvoice = true;
        sub.subscribeOptions.processPayments = false;
        sub.subscribeOptions.subscribeInvoiceProcessingOptions = new zc_SubscribeRequestInvProcessingOptions();
        sub.subscribeOptions.subscribeInvoiceProcessingOptions.invoiceDate = Date.today();
        sub.subscribeOptions.subscribeInvoiceProcessingOptions.invoiceTargetDate = dateDebutContrat;
        sub.subscribeOptions.subscribeInvoiceProcessingOptions.invoiceProcessingScope = 'Subscription';

        // subscription Terms
        sub.subscriptionData.subscription = subTerm(typeContrat, dateDebutContrat, subIn, customSub);


        // RatePlans
        sub.subscriptionData.ratePlanData.addAll(subOffreRatePlans);
        subscribeReq.subscribes.add(sub);
  
        return subscribeReq;
    }

    private static zc_SubscribeRequestSubscriptionDataSub subTerm(String typeContrat, Date dateDebutContrat, SubscribeIn subIn, Map<String,Object> customSub){
        
        zc_SubscribeRequestSubscriptionDataSub sub = new zc_SubscribeRequestSubscriptionDataSub();
        Boolean isFutur = (dateDebutContrat == Date.today())?false:true;
        // WSZ.Paiement paiement;

        // if (subMap.containsKey('paiement'))  paiement = (WSZ.Paiement)subMap.get('paiement'); 
            
        
        if (typeContrat == 'CDI') {
            sub.termType = 'TERMED';
            sub.initialTermPeriodType = 'Month';
            sub.renewalTermPeriodType = 'Month';
            sub.initialTerm = 12;
            //sub.renewalTerm = 12;
            sub.renewalSetting = 'RENEW_TO_EVERGREEN';
            sub.autoRenew = true;
            sub.IsInvoiceSeparate = true;
            sub.contractEffectiveDate = dateDebutContrat;
            if (!isFutur) sub.serviceActivationDate = dateDebutContrat;
            if (!isFutur) sub.contractAcceptanceDate = dateDebutContrat;
            if (dateDebutContrat.toStartOfMonth() != dateDebutContrat) {
                sub.termStartDate = dateDebutContrat.toStartOfMonth().addMonths(1);
            }else {
                sub.termStartDate = dateDebutContrat;
            }

        }else if (typeContrat == 'CDD'){
            sub.termType = 'TERMED';
            sub.initialTermPeriodType = 'Month';
            sub.renewalTermPeriodType = 'Month';
            sub.initialTerm = 12;
            sub.renewalTerm = 12;
            sub.renewalSetting = 'RENEW_WITH_SPECIFIC_TERM';
            sub.autoRenew = false;
            sub.IsInvoiceSeparate = true;
            sub.contractEffectiveDate = dateDebutContrat;
            if (!isFutur) sub.serviceActivationDate = dateDebutContrat;
            if (!isFutur) sub.contractAcceptanceDate = dateDebutContrat;            
            sub.termStartDate = dateDebutContrat;
        }

        sub.modeLivraison = subIn.modeLivraison;
        sub.codeOffreCo = (String)customSub.get('codeOffreCo');
        sub.codePromo = subIn.coupon;
        sub.lieu = subIn.lieu;
        sub.agent = subIn.agent;
        sub.payeurCRMID = subIn.payeurSFID;
        sub.numCarteParrain = subIn.numCarteParrain;
        sub.typeContrat = typeContrat;
        if (customSub.containsKey('IsB2B') && customSub.get('IsB2B') == true ) {
            sub.marche = 'BTOB';
        }else {
            sub.marche = 'BTOC';
        }
        sub.codeOffrePrincipale = 'UI1CDI'; //TODO Famille du RatePlan de l'abonnement.
        if (typeContrat == 'CDI') { 
            sub.methodePaiement = 'PRE';
        }else {
            sub.methodePaiement = subIn.paiement.methodePaiement; //TODO si besoin de mapping
        }

        // if (subMap.containsKey('modeLivraison')) sub.modeLivraison = (String)subMap.get('modeLivraison');
        // if (subMap.containsKey('codeOffreCo')) sub.codeOffreCo = (String)subMap.get('codeOffreCo');
        // if (subMap.containsKey('coupon')) sub.codePromo = (String)subMap.get('coupon');
        // if (subMap.containsKey('lieu')) sub.lieu = (String)subMap.get('lieu');
        // if (subMap.containsKey('agent')) sub.agent = (String)subMap.get('agent');
        // if (subMap.containsKey('payeurSFID')) sub.payeurCRMID = (String)subMap.get('payeurSFID');
        // if (subMap.containsKey('numCarteParrain')) sub.numCarteParrain = (String)subMap.get('numCarteParrain');


        return sub;
    }

    private static zc_SubscribeRequestAccount subAccount(String typeContrat, Account acc, Map<String,Object> customSub){

        zc_SubscribeRequestAccount subAcc = new zc_SubscribeRequestAccount();
        Boolean isPreview = (Boolean)customSub.get('isPreview');


        if (typeContrat == 'CDI') {
            //subAcc.id='8adce4216787fdf0016788ffa3cf4110';
            subAcc.name = acc.LastName + ' ' + acc.FirstName;
            subAcc.idMoncompte = acc.IdMonCompte__c;
            subAcc.dateNaissance = acc.PersonBirthdate;
            subAcc.crmId = acc.Id;
            subAcc.autoPay = (isPreview)?false:true; 
            subAcc.batch = 'Batch1';
            subAcc.billCycleDay = 1;
            subAcc.currency2 = 'EUR';
            subAcc.paymentTerm = 'Due Upon Receipt';
        }else if (typeContrat == 'CDD'){
            subAcc.name = acc.LastName + ' ' + acc.FirstName;
            subAcc.idMoncompte = acc.IdMonCompte__c;
            subAcc.dateNaissance = acc.PersonBirthdate;
            subAcc.crmId = acc.Id;
            subAcc.autoPay = false;
            subAcc.batch = 'Batch1';
            subAcc.billCycleDay = 1;
            subAcc.currency2 = 'EUR';
            subAcc.paymentTerm = 'Due Upon Receipt';
            if (customSub.containsKey('IsB2B') && customSub.get('IsB2B') == true) {
                subAcc.defaultPaymentMethodId = Utils.getUgcGenericParam('Zuora_PM_'+'BTB','033').ParamValue__c;
            }else {
                subAcc.defaultPaymentMethodId = Utils.getUgcGenericParam('Zuora_PM_'+'CBI','033').ParamValue__c; //TODO 
            }
            
        }

        return subAcc;

        // Id, Name, LastName, FirstName, PersonBirthdate, IdMonCompte__c, PersonEmail, NoVoie__c, TypeVoie__c, NomVoie__c, 
		//		CodePostal__c, Ville__r.Name, ClientResident__c, CodePays__c, 

    }   

    private static zc_SubscribeRequestBillToContact billToContact(Account acc){
            
            zc_SubscribeRequestBillToContact billTo = new zc_SubscribeRequestBillToContact();
            
            billTo.address1 = acc.NoVoie__c + ' ' + acc.TypeVoie__c + ' ' + acc.NomVoie__c;
            billTo.city = acc.Ville__r.Name;
            billTo.country = acc.Ville__r.Pays__c;
            billTo.firstName = acc.FirstName;
            billTo.lastName = acc.LastName;
            billTo.postalCode = acc.Ville__r.CodePostal__c;
            billTo.personalEmail = acc.PersonEmail;

            return billTo;

        // Id, Name, LastName, FirstName, PersonBirthdate, IdMonCompte__c, PersonEmail, NoVoie__c, TypeVoie__c, NomVoie__c, 
		//		CodePostal__c, Ville__r.Name, ClientResident__c, CodePays__c, 

    }  


    private static zc_SubscribeRequestSoldToContact soldToContact(Account acc){

            zc_SubscribeRequestSoldToContact soldTo = new zc_SubscribeRequestSoldToContact();
            soldTo.address1 = acc.NoVoie__c + ' ' + acc.TypeVoie__c + ' ' + acc.NomVoie__c;
            soldTo.city = acc.Ville__r.Name;
            soldTo.country = acc.Ville__r.Pays__c;
            soldTo.firstName = acc.FirstName;
            soldTo.lastName = acc.LastName;
            soldTo.postalCode = acc.Ville__r.CodePostal__c;
            soldTo.personalEmail = acc.PersonEmail;

            return soldTo;

        // Id, Name, LastName, FirstName, PersonBirthdate, IdMonCompte__c, PersonEmail, NoVoie__c, TypeVoie__c, NomVoie__c, 

    } 

    private static zc_SubscribeRequestPaymentMethod paymentMethod(String typeContrat, Account acc, String iban, String mandateId, Map<String,Object> customSub){

        zc_SubscribeRequestPaymentMethod pm = new zc_SubscribeRequestPaymentMethod();
        if (typeContrat == 'CDI'){
            //zc_SubscribeRequestPaymentMethod.RTypeEnum pp; // = new zc_SubscribeRequestPaymentMethod.RTypeEnum();
            pm.gatewayOptionData = new zc_SubscribeRequestPaymentMethodGat();
            pm.r_type = 'BankTransfer';
            pm.bankTransferType = 'SEPA';
            //pm.IBAN = '';
            pm.bankTransferAccountNumber = iban; //doit etre valide meme pour le test
            pm.existingMandate = 'Yes'; // le mandat est cree meme si en preview
            pm.mandateReceived = 'Yes';
            pm.mandateID = mandateId;
            pm.country = 'FR'; //TODO
            pm.firstName = acc.FirstName;
            pm.lastName = acc.LastName;
            pm.streetName = acc.TypeVoie__c + ' ' + acc.NomVoie__c;
            pm.streetNumber = acc.NoVoie__c;
            pm.postalCode = acc.Ville__r.CodePostal__c;
            pm.city = acc.Ville__r.Name;
        }else if (typeContrat == 'CDD'){
            pm = null;
        }

        return pm;


    }

    // si besoin de faire du mapping champ par champ
    public static SubscribeIn mapToSubscribeIn(Object objIn){
        
        SubscribeIn subIn;
        if (objIn instanceof WSZ.AcquisitionIn) {
            //subIn = (SubscribeIn)objIn;
            subIn = (SubscribeIn)JSON.deserialize(JSON.serialize(objIn,true), SubscribeIn.class);
            // champ1..
            // champ2...etc.

        }else if (objIn instanceof WSZ.PreviewIn){
            subIn = (SubscribeIn)JSON.deserialize(JSON.serialize(objIn,true), SubscribeIn.class);
        }
        return subIn;

    }

    public class SubscribeIn {
        public Date dateDebutContrat;
        public String lieu;
        public String agent;
        public String coupon;
        public String operation;
        //public String produit;
        public String codeOffreCo;
        public String modeLivraison;
        public String numCarteParrain;
        public String iban;
        public String mandateId;
        public List<String> produit;
        public WSZ.Paiement paiement;
        public String payeurSFID;

        // public SubscribeIn(Date dateDebutContrat, String lieu,String agent, String coupon,List<String> produit,String codeOffreCo, String modeLivraison,
        // String numCarteParrain, String iban, String mandateId, WSZ.Paiement paiement){
        //     this.dateDebutContrat = dateDebutContrat;
        //     this.lieu = lieu;
        //     this.agent = agent;
        //     this.coupon = coupon;
        //     this.operation = operation;
        //     this.produit = produit;
        //     this.codeOffreCo = codeOffreCo;
        //     this.modeLivraison = modeLivraison;
        //     this.numCarteParrain = numCarteParrain;
        //     this.iban = iban;
        //     this.mandateId = mandateId;
        //     this.paiement = paiement;    
        //     //this.payeurSFID = payeurSFID;        
        // }        
    }    

}