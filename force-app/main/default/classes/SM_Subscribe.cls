public with sharing class SM_Subscribe {

    private final static Set<String> FAMILLE_REMISES = new Set<String>{'REMFRAIDOSS', 'REMMENS', 'REMMONT'};
    private static Map<String,WSZ.Paiement> mapPaiements;


    public SM_Subscribe() {

    }

    public static zc_ProxyActionsubscribeRequest subscribe(SubscribeIn subIn, Boolean isPreview, Account porteur, Account payeur, List<zc_AmendmentRatePlanData> subOffreRatePlans, Map<String,Object> customSub){

        Date dateDebutContrat = Date.newinstance(subIn.dateDebutContrat.year(), subIn.dateDebutContrat.month(), subIn.dateDebutContrat.day());
        //Date dateJourDebutContrat =  
        String produit = subIn.produit;
        String typeContrat = (produit.contains('CDI')?'CDI':'CDD');


        // Zuora subscribeRequest
        zc_ProxyActionsubscribeRequest subscribeReq = new zc_ProxyActionsubscribeRequest();
        zc_SubscribeRequest sub = new zc_SubscribeRequest();

        // parse mapPaiements
        
        if (!isPreview && subIn.paiements.size() > 0){
            mapPaiements = new Map<String,WSZ.Paiement>();
            //List<Paiement> paiements = acqIn.paiements;
            for (WSZ.Paiement item:subIn.paiements){
                mapPaiements.put(item.refCharge,item);         
            }
        }        

        sub.account = subAccount(typeContrat, porteur,customSub);
        sub.billToContact = billToContact(payeur);
        sub.soldToContact = soldToContact(porteur);
        if (subIn.mandateId != null && subIn.iban != null && !isPreview) {
            sub.paymentMethod = paymentMethod(typeContrat, payeur, subIn.iban, subIn.mandateId, customSub);
        }

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
        Boolean isFutur = (dateDebutContrat <= Date.today())?false:true;
        Boolean isPreview = (Boolean)customSub.get('isPreview');        
        
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
            sub.dateFinContrat = dateDebutContrat.addMonths(12).addDays(-1);
        }

        if (!isPreview) {
            sub.modeLivraison = subIn.modeLivraison;
            sub.codeOffreCo = (String)customSub.get('codeOffreCo');
            sub.codePromo = subIn.coupon;
            sub.lieu = subIn.lieu;
            sub.agent = subIn.agent;
            sub.payeurCRMID = subIn.payeurSFID;
            sub.parrainSFID = subIn.parrainSFID;
            sub.typeContrat = typeContrat;
            if (customSub.containsKey('IsB2B') && customSub.get('IsB2B') == true ) {
                sub.marche = 'BTOB';
            }else {
                sub.marche = 'BTOC';
            }
            sub.codeOffrePrincipale = subIn.produit;
            if (typeContrat == 'CDI') { 
                sub.methodePaiement = 'PRE';
            }else {
                sub.methodePaiement = mapPaiements.get('ABO').methodePaiement;
            }
            // TODO sub.idContratPrecedent a remplir pour la migration/renouvellement: de preference le nom de la souscription, car la souscription sera cancelle dans le futur
        }

        return sub;
    }

    private static zc_SubscribeRequestAccount subAccount(String typeContrat, Account acc, Map<String,Object> customSub){

        zc_SubscribeRequestAccount subAcc = new zc_SubscribeRequestAccount();
        Boolean isPreview = (Boolean)customSub.get('isPreview');
        String codePays = acc.CodePays__c;
        Boolean isB2B = false;
        if (customSub.containsKey('IsB2B') && customSub.get('IsB2B') == true) isB2B = true;

        subAcc.name = acc.LastName + ' ' + acc.FirstName;
        subAcc.idMoncompte = acc.IdMonCompte__c;
        subAcc.dateNaissance = acc.PersonBirthdate;
        subAcc.crmId = acc.Id;
        subAcc.billCycleDay = 1;
        subAcc.currency2 = 'EUR';
        subAcc.invoiceTemplateId = SM_Hermes.getInvoiceTemplateId(isB2B, codePays, acc.Langue_parl_e_par_le_client__c);

        if (typeContrat == 'CDI') {
            //subAcc.id='8adce4216787fdf0016788ffa3cf4110';
            subAcc.autoPay = !isPreview; 
            subAcc.batch = 'Batch1';
            subAcc.paymentTerm = 'Due Upon Receipt';
        }else if (typeContrat == 'CDD'){
            subAcc.autoPay = false;
            subAcc.batch = 'Batch21';
            subAcc.paymentTerm = 'Due Upon Receipt';
            
            // //TODO OK: ne fonctionne pas pour les external paymentID (doc API action/subscribe)
            // if (isB2B) {
            //     subAcc.defaultPaymentMethodId = SM_Hermes.getExtPaymentMethodId(true, 'BTB', codePays);
            // }else {
            //     subAcc.defaultPaymentMethodId = SM_Hermes.getExtPaymentMethodId(false, 'CBI', codePays); 
            // }
            
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
            pm.country = acc.Pays__c; //'FR', 'FRANCE', 'France' : OK
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
        if (objIn instanceof WSZ.SubOpeIn) {
            //subIn = (SubscribeIn)objIn;
            subIn = (SubscribeIn)JSON.deserialize(JSON.serialize(objIn,true), SubscribeIn.class);
            // champ1..
            // champ2...etc.
        }

        // }else if (objIn instanceof WSZ.PreviewIn){
        //     WSZ.PreviewIn prevIn = (WSZ.PreviewIn)objIn;
        //     subIn = (SubscribeIn)JSON.deserialize(JSON.serialize(objIn,true), SubscribeIn.class);
        //     subIn.produit =  prevIn.produits.get(0);

        // }
        return subIn;

    }

    public class SubscribeIn {
        public Datetime dateDebutContrat;
        public String lieu;
        public String agent;
        public String coupon;
        public String operation;
        //public String produit;
        public String codeOffreCo;
        public String modeLivraison;
        public String parrainSFID;
        public String iban;
        public String mandateId;
        public String produit;
        public List<WSZ.Paiement> paiements;
        public String payeurSFID;
      
    }    

    public static zc_ProxyActionsubscribeRequest subscribeMigration(SubscribeIn subIn, Boolean isPreview, Account porteur, Account payeur, List<zc_AmendmentRatePlanData> subOffreRatePlans, Map<String,Object> customSub){

        Date dateDebutContrat = Date.newinstance(subIn.dateDebutContrat.year(), subIn.dateDebutContrat.month(), subIn.dateDebutContrat.day());
        String produit = subIn.produit;
        String typeContrat = (produit.contains('CDI')?'CDI':'CDD');
        String accountZID = (String)customSub.get('accountZID');
        String typeMigration = (String)customSub.get('typeMigration');
        Boolean generateInvoice = (Boolean)customSub.get('generateInvoice');

        // Zuora subscribeRequest
        zc_ProxyActionsubscribeRequest subscribeReq = new zc_ProxyActionsubscribeRequest();
        zc_SubscribeRequest sub = new zc_SubscribeRequest();

        
        if(!isPreview) {
            sub.account = new zc_SubscribeRequestAccount();
            sub.account.id = accountZID;
        }else {
            generateInvoice = true; //override pour faire la preview
            sub.account = subAccount(typeContrat, porteur,customSub);
            sub.billToContact = billToContact(payeur);
            sub.soldToContact = soldToContact(porteur);
        }

        // if (subIn.mandateId != null && subIn.iban != null && !isPreview) sub.paymentMethod = paymentMethod(typeContrat, payeur, subIn.iban, subIn.mandateId, customSub); // activer si isPreview = false
        sub.previewOptions = new zc_SubscribeRequestPreviewOptions();
        sub.subscriptionData = new zc_SubscribeRequestSubscriptionData();
        sub.subscribeOptions = new zc_SubscribeRequestSubscribeOptions();
        
        sub.previewOptions.enablePreviewMode = isPreview;
        sub.previewOptions.numberOfPeriods = 5;

        //invoiceOptions
        sub.subscribeOptions.processPayments = false;
        sub.subscribeOptions.generateInvoice = generateInvoice;
        if (generateInvoice) {
            sub.subscribeOptions.subscribeInvoiceProcessingOptions = new zc_SubscribeRequestInvProcessingOptions();
            sub.subscribeOptions.subscribeInvoiceProcessingOptions.invoiceProcessingScope = 'Subscription';
            sub.subscribeOptions.subscribeInvoiceProcessingOptions.invoiceDate = Date.today();
            sub.subscribeOptions.subscribeInvoiceProcessingOptions.invoiceTargetDate = dateDebutContrat;
        }

        // subscription Terms
        sub.subscriptionData.subscription = subTerm(typeContrat, dateDebutContrat, subIn, customSub);

        // RatePlans
        sub.subscriptionData.ratePlanData.addAll(subOffreRatePlans);
        subscribeReq.subscribes.add(sub);
  
        return subscribeReq;
    }    

    public static WSZ.Preview parsePreview(Object resObj, Map<String, Object> offreProxy){

        WSZ.Preview preview = new WSZ.Preview();
        List<zc_InvoiceItem> invItems;
        zc_InvoiceDataInvoice invoice;
        WSZ.SubProduct subOffre = (WSZ.SubProduct)offreProxy.get('offre');
        List<zc_AmendmentRatePlanData> offreRatePlans = (List<zc_AmendmentRatePlanData>)offreProxy.get('offreRatePlans');

        Decimal abonnement=0,montantInitial=0,fraisAdhesion=0,remiseFraisAdhesion=0,fraisAdhesionNet=0,prorata=0,montantInitialNonRemise=0;
        Decimal remiseAbonnement=0,abonnementNet=0;
        
        String typeContrat = (subOffre.Reference.contains('CDI')?'CDI':'CDD');
        if (resObj instanceof zc_ProxySubscribeResult) {
            zc_ProxySubscribeResult resObj1 = (zc_ProxySubscribeResult)resObj;
            invItems = resObj1.results.get(0).invoiceData.get(0).invoiceItem;
            invoice = resObj1.results.get(0).invoiceData.get(0).invoice;
        }else if (resObj instanceof zc_ProxyActionAmendResponse) {
            zc_ProxyActionAmendResponse resObj2 = (zc_ProxyActionAmendResponse)resObj;
            invItems = resObj2.results.get(0).invoiceDatas.get(0).invoiceItem;
            invoice = resObj2.results.get(0).invoiceDatas.get(0).invoice;            
        }
            System.debug('MBEN:invItems: ' + JSON.serialize(invItems));
            System.debug('MBEN:invoice: ' + JSON.serialize(invoice));
        List<String> rpcIds = new List<String>();
        for (zc_InvoiceItem invItem : invItems) {
            System.debug('MBEN:invItem: ' + JSON.serialize(invItem));
            rpcIds.add(invItem.productRatePlanChargeId);
        }
        Map<String,ProdRatePlanCharge__c> rpcs = new Map<String,ProdRatePlanCharge__c>();
        //for(ProdRatePlanCharge__c item : [Select Id, zid__c, Reference__c, ReferenceCIC__c, FamilleRPC__c, Name from ProdRatePlanCharge__c where zid__c in :rpcIds])
        for(ProdRatePlanCharge__c item : [Select Id, zid__c, Reference__c, ReferenceCIC__c, FamilleRPC__c, Name from ProdRatePlanCharge__c])
        rpcs.put(item.zid__c, item);

        System.debug('MBEN:rpcs: ' + JSON.serialize(rpcs));

         
        for (zc_InvoiceItem invItem : invItems) {
            //rpcIds.add(invItem.productRatePlanChargeId);
            WSZ.PreviewDetail prevDetail;
            String rpcZid = invItem.productRatePlanChargeId;
            if (rpcs.get(rpcZid).FamilleRPC__c == 'ABO'  ) {
                abonnement += (Decimal)invItem.unitPrice;
                if (typeContrat == 'CDD') {montantInitial += abonnement;montantInitialNonRemise += abonnement;}

                //preview.dateDebutContrat = invItem.serviceStartDate;
                //preview.dateFinContrat = invItem.serviceEndDate;
            }
            if (rpcs.get(rpcZid).FamilleRPC__c == 'FRAIDOSS') {
                fraisAdhesion += (Decimal)invItem.TaxAmount + (Decimal)invItem.ChargeAmount;
                montantInitial += fraisAdhesion; 
                montantInitialNonRemise += fraisAdhesion;

            }            
            if (rpcs.get(rpcZid).ReferenceCIC__c == 'REMMONTANNUAL') {
                remiseAbonnement += invItem.TaxAmount + invItem.ChargeAmount;
                montantInitial += remiseAbonnement;                
            }            
            if (rpcs.get(rpcZid).FamilleRPC__c == 'REMFRAIDOSS') {
                remiseFraisAdhesion += invItem.TaxAmount + invItem.ChargeAmount;
                montantInitial += remiseFraisAdhesion;                
            }
            if (rpcs.get(rpcZid).FamilleRPC__c == 'ABO' && typeContrat == 'CDI' && invItem.serviceStartDate.toStartOfMonth() != invItem.serviceStartDate) {
                prorata += (Decimal)invItem.TaxAmount + (Decimal)invItem.ChargeAmount;
                prevDetail = new WSZ.PreviewDetail('PRORATA','Prorata sur abonnement',prorata,prorata);
                preview.previewDetail.add(prevDetail);
                montantInitial += prorata;
                montantInitialNonRemise += prorata;
            }              
            // if(rpcs.get(rpcZid).FamilleRPC__c == 'REMFRAIDOSS', 'REMMENS', 'REMMONT')
            
        }

        fraisAdhesionNet = fraisAdhesion + remiseFraisAdhesion;
        preview.previewDetail.add(new WSZ.PreviewDetail('FRAISADHESION','Frais d\'adhesion',fraisAdhesionNet, fraisAdhesion));
        
        abonnementNet = abonnement + remiseAbonnement;
        preview.previewDetail.add(new WSZ.PreviewDetail('ABO','Abonnement',abonnementNet,abonnement));

        //if (typeContrat == 'CDD') {montantInitial += abonnement; montantInitialNonRemise += abonnement;}


        //preview.abonnement = abonnement;
        preview.montantInitial = montantInitial;
        //preview.fraisAdhesion = fraisAdhesion;
        //preview.fraisAdhesionNet = fraisAdhesionNet;
        //preview.prorata = prorata;
        preview.montantInitialNonRemise = montantInitialNonRemise; //TODO: OK voir si ce montant est bon.
         

        preview.intituleOffre = subOffre.HermesIntituleOffre; //TODO: OK: gestion de langue ou a gerer dans SM_Offre;
        //preview.intituleOffreNL = subOffre.HermesIntituleOffreNL;
        preview.isB2B = subOffre.IsB2B;
        preview.isPrepaid = subOffre.IsPrepaid;
        preview.produit = subOffre.Reference;
        preview.codeOffreCo = subOffre.CodeOffreCo;        

        // Parse les offre commerciales(offreDetail): (depuis suboffre)
        for (zc_AmendmentRatePlanData ratePlanData : offreRatePlans){
            zc_RatePlanChargeInRatePlanChargeData rpc2 = ratePlanData.ratePlanChargeData.get(0).ratePlanCharge;
            String rpcZid2 = rpc2.productRatePlanChargeId;
            String referenceRPC = rpcs.get(rpcZid2).ReferenceCIC__c;
            String familleRPC = rpcs.get(rpcZid2).FamilleRPC__c;
            if (FAMILLE_REMISES.contains(familleRPC)) {

                String libelle;
                if (referenceRPC=='REMMENS'){
                    libelle = rpc2.name + ': -' + abonnement + ' euros, '+ rpc2.upToPeriods + ' fois(s) à partir du ' + rpc2.triggerDate;

                }else if (referenceRPC=='REMFRAISDOS'){
                    //libelle = rpc2.name + ': -' + (Double)(fraisAdhesion * rpc2.discountPercentage) + ' euros';
                    libelle = rpc2.name + ': -' + (Double)fraisAdhesion + ' euros';

                }else if (referenceRPC=='REMMONT'){
                    libelle = rpc2.name + ': -' + rpc2.discountAmount + ' euros ' + rpc2.upToPeriods + ' fois(s) à partir du ' + rpc2.triggerDate;

                }else if (referenceRPC=='REMMONTANNUAL'){
                    libelle = rpc2.name + ': -' + rpc2.discountAmount + ' euros';

                }else if (referenceRPC=='REMFRAISDOSRED'){
                    libelle = rpc2.name + ': -' + rpc2.discountAmount + ' euros';
                }

                String referenceOffre;
                if (new List<String>{'REMFRAISDOSRED','REMFRAISDOS'}.contains(referenceRPC))  referenceOffre = 'FRAISADHESION';
                if (new List<String>{'REMMONTANNUAL','REMMONT','REMMENS'}.contains(referenceRPC))  referenceOffre = 'ABO';
                preview.offreDetail.add(new WSZ.PreviewOffreDetail(referenceOffre, libelle)); //TODO gestion de la langue NL.
            }
        }
        return preview; 

    }

}