/**
 * Created by mouad on 03/09/2018.
 */


public without sharing class SM_Desabonnement {

    public static Case dem = new Case();
    public static Zuora__Subscription__c sub = new Zuora__Subscription__c();
    //private static Zuora__Subscription__c zSubIn = new Zuora__Subscription__c();
    private static zc_ProxyModifySubscription zSubIn = new zc_ProxyModifySubscription();
    public static Account acc = new Account();
    private static Date dateLatence, dateCancelContrat;
    private static Boolean isDesaboNow;
    public static Boolean isBatchCall;
    
    public static Id resiliationRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Résiliation').getRecordTypeId();
    public static Id desabonnementRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Désabonnement').getRecordTypeId();
    public static Id retentionRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Rétention').getRecordTypeId();
    public static Id retractationRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Rétractation').getRecordTypeId();
    public static Id annulationContratRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Annulation contrat').getRecordTypeId();
    
    public static ProcessLog__c pLog;
    public static zc_GETSubscriptionTypeWithSuccess subZdoc;
    public static zc_ProxyGetPaymentMethod pm;
    

    // Operation desabonnement
    public static void desabonner(Id ddeId, Boolean isBatchCall2) {
        
        String codeDesaCarte = null;
        String operation = 'desabonnement';
        String zSubZID = null;
        Boolean billRun;
        String amendOperation = null;
        Boolean noRemboursementAFaire = false;
        zc_SaveResult zSubUpdateResult = new zc_SaveResult();
        
        isBatchCall = isBatchCall2;
        
        dem = SM_Demande.getDemande(ddeId);
        dateCancelContrat = dem.DateFinContrat__c;
        String recordTypeName = Schema.SObjectType.Case.getRecordTypeInfosById().get(dem.RecordTypeId).getname();
        
        
        String strIsBatchCall = (isBatchCall)?'_isBatchCall':'_isUI';
        String process = 'desabonner' + strIsBatchCall + '_' + recordTypeName;
        pLog = new ProcessLog__c(Process__c = process, Account__c = dem.AccountId, SubscriptionName__c = dem.SubscriptionZName__c, Case__c = ddeId);
        
        //sub = SM_Subscription.getSubscription(dem.Subscription__c);
        sub = SM_Subscription.getActiveSubscriptionByNameORAccId(dem.SubscriptionZName__c, dem.AccountId);
        
        acc = SM_Account.getAccount(dem.AccountId);
        String zEntityId = WS001_CallZuora.getZuoraEntityId(acc.CodePays__c);

        // Verification du desabo
        verifDesabo();
        
        //calcul boolean pour savoir cas sans remboursement        
        if(dem.RecordTypeId == resiliationRecordTypeId){
            noRemboursementAFaire = true;
        }
        if((dem.RecordTypeId == desabonnementRecordTypeId || dem.RecordTypeId == retentionRecordTypeId) && dem.Type_de_d_sabonnement__c == 'Désabonnement avec préavis (L)'){
            noRemboursementAFaire = true;
        }
        if((dem.RecordTypeId == desabonnementRecordTypeId || dem.RecordTypeId == retentionRecordTypeId) && dem.Type_de_d_sabonnement__c == 'Désabonnement avec justificatif (E)' && sub.TypeContrat__c == 'CDI'){
            noRemboursementAFaire = true;
        }
        

        // Call depuis l'UI: decision Desabo Futur 
        if (!isBatchCall){ // UI Call
            if (dateCancelContrat <= Date.today().addDays(1)) { // Decider si desabonner dans le futur ou pas ? autres criteres date fin contrat
                isDesaboNow = true;
            }else {
                isDesaboNow = false;
            }
        }else { // Batch Call
                isDesaboNow = true;
            }
        
        // assign zSubIn: Code fin contrat + amendOperation  + date fin contrat  + Id   
        if (dem.RecordTypeId == retractationRecordTypeId || dem.RecordTypeId == annulationContratRecordTypeId){
            zSubIn.codeFinContrat = 'A';
            amendOperation = 'Retractation';
        }else if (dem.RecordTypeId == resiliationRecordTypeId){
            if(dem.Motif_de_R_siliation__c == 'Code X'){
                zSubIn.codeFinContrat = 'X';
            } else {
                zSubIn.codeFinContrat = 'M';
            }
            amendOperation = 'Resiliation';            
        }else {
            if (dem.Type_de_d_sabonnement__c == 'Désabonnement avec justificatif (E)') {
                zSubIn.codeFinContrat = 'E';
            } else if (dem.Type_de_d_sabonnement__c == 'Désabonnement avec préavis (L)') {
                zSubIn.codeFinContrat = 'L';
            }
            amendOperation = 'Desabonnement';          
        }        
        zSubIn.dateFinContrat = dateCancelContrat.addDays(-1);
        //zSubZID = dem.Subscription__r.Zuora__Zuora_Id__c;
        zSubZID = sub.Zuora__Zuora_Id__c;
        zSubIn.cancelCaseID = dem.Id;

        System.debug('MBEN:desabonner: ' + ' isDesaboNow: '+isDesaboNow+' isBatchCall: '+isBatchCall+' noRemboursementAFaire: '+noRemboursementAFaire);
        System.debug('MBEN:desabonner: ' + ' dem.DateFinContrat__c: ' + dem.DateFinContrat__c + ' zSubIn.dateFinContrat: ' + zSubIn.dateFinContrat + 'zSubIn.cancelCaseID: ' + zSubIn.cancelCaseID);
        System.debug('MBEN:desabonner: ' + ' amendOperation: ' + amendOperation + ' zSubIn.codeFinContrat: '+zSubIn.codeFinContrat);
        System.debug('MBEN:desabonner: ' + 'zSubIn.cancelCaseID: ' + zSubIn.cancelCaseID + 'dem.Id: '+dem.Id);

        if (isDesaboNow){
            
            // Authentification
            String accessToken = WS001_CallZuora.access_token;

            //Cancel de la subscription
            billRun = !noRemboursementAFaire;
            zc_POSTSubscriptionCancellationType reqObj = new zc_POSTSubscriptionCancellationType();
            reqObj.cancellationEffectiveDate = dateCancelContrat;
            reqObj.targetDate = dateCancelContrat; 
            reqObj.runBilling = billRun; 
            reqObj.cancellationPolicy = 'SpecificDate'; 
            zc_POSTSubscriptionCancellationResp rCancel = zc_Api.subscriptionCancelPUT(accessToken, zEntityId, reqObj, sub.Zuora__Zuora_Id__c, RTExceptionCode.ERREUR_DESABO_APPLICATION_CANCEL1, pLog);
            zSubZID = rCancel.subscriptionId;

            // Get Amendment Id: 
            WSZ.AmendOut amend = SM_Amendment.getAmendment(zSubZID, zEntityId);
            WSZ.GenericOut2 amend2 = new WSZ.GenericOut2();
           

            // Mise a jour amendOperation dans Zuora            
            if (amendOperation != null ) {
                amend2 = SM_Amendment.updateAmendment(new WSZ.AmendIn(amend.id, amendOperation), zEntityId);
            }

            //pour autoriser l'annulation du cancel
            if(String.isBlank(rCancel.creditMemoId) && String.isBlank(rCancel.invoiceId)){  //rCancel.invoiceId
                zSubIn.tech_AvecRembouesement = 'false';
            } else {
                zSubIn.tech_AvecRembouesement = 'true';
            }
            
            // Mise a jour souscription dans Zuora: DateFinContrat__c, CodeFinContrat__c, Tech_AvecRembouesement__c
            zSubUpdateResult = zc_Api.objectSubscriptionPUT(accessToken, zEntityId, zSubZID, zSubIn, RTExceptionCode.ERREUR_DESABO_APPLICATION_UPDATESUB, pLog);
            // zSubUpdateResult = SM_Subscription.updateSub(zSubZID, zSubIn, zEntityId);
       
         
            //Run Bill Run asynchron si remboursement a faire (totalDeltaTcv != 0)
            WSZ.SubOut billRunResult = null;
            Boolean createCaseRemboursement = false;
            Decimal amountToRefundRoundFromCreditMemo; 
            Date dateResiliation;
            if(String.isNotBlank(rCancel.creditMemoId) && !noRemboursementAFaire){  
                WSZ.CreditMemoOut cm = SM_CreditMemo.getCreditMemo(rCancel.creditMemoId, zEntityId);
                Decimal amountToRefund = Decimal.valueOf(cm.amount);
                if(amountToRefund < 0){
                    amountToRefund = amountToRefund * -1;
                }
                amountToRefundRoundFromCreditMemo = amountToRefund.setScale(2);
                dateResiliation = dateCancelContrat;
                createCaseRemboursement = true;
            } else if(String.isNotBlank(rCancel.creditMemoId)  && noRemboursementAFaire) {
                //pas de rembooursement si resiliation, retractation ou annulationContrat
                //normalement on rentre pas ici car cancel a invoice term
                SM_CreditMemo.unpost(rCancel.creditMemoId, zEntityId);
                SM_CreditMemo.cancel(rCancel.creditMemoId, zEntityId);
            }
            
            
            // Get Zuora Doc Data (subscription)
            subZdoc = zc_Api.subscriptionGET(accessToken, zEntityId, zSubZID, RTExceptionCode.ERREUR_ACQUISIT_GET_ZSUBSCRIPTION, pLog);
            // Get Zuora Doc Data (Account)
            zc_ProxyGetAccount zacc = zc_Api.objectAccountGET(accessToken, zEntityId, sub.Zuora__CustomerAccount__r.Zuora__Zuora_Id__c, RTExceptionCode.ERREUR_ACQUISIT_GET_ACCOUNT, pLog);
            String payMethodId = zacc.defaultPaymentMethodId;
            // Get Zuora Doc Data (PaymentMethod)
            pm = zc_Api.objectPaymentMethodGET(accessToken, zEntityId, payMethodId, RTExceptionCode.ERREUR_ACQUISIT_GET_PAYMENTMETHOD, pLog);
            

            //Desactivation de carte synchrone
            if(String.isBlank(zSubIn.codeFinContrat)) {
                codeDesaCarte = null;
            } else {
                codeDesaCarte = zSubIn.codeFinContrat;
            }            
            List<Carte__c> listCarteToUpdate = SM_Carte.desactivation(dem.AccountId, codeDesaCarte);
            update listCarteToUpdate;


            //Remboursement
            if(dem.RemboursementFaire__c && createCaseRemboursement){
                SM_Remboursement.createRebousementCase(dem.Id, dem.MontantRembourser__c, amountToRefundRoundFromCreditMemo, dem.AccountId, rCancel.creditMemoId, dateResiliation, null, Date.today(), dem.SubscriptionZName__c);
            }
            else if(createCaseRemboursement){
                SM_Remboursement.createRebousementCase(dem.Id, amountToRefundRoundFromCreditMemo, amountToRefundRoundFromCreditMemo, dem.AccountId, rCancel.creditMemoId, dateResiliation, null, Date.today(), dem.SubscriptionZName__c);
            }
            else if(dem.RemboursementFaire__c){
                SM_Remboursement.createRebousementCase(dem.Id, dem.MontantRembourser__c, dem.MontantRembourser__c, dem.AccountId, null, dateResiliation, null, Date.today(), dem.SubscriptionZName__c);
            }
      
        }else { //!isDesaboNow            
            
            //Mise a jour Subscription Zuora: Date fin contrat + code fin contrat 
            String accessToken = WS001_CallZuora.access_token;
            zSubUpdateResult = zc_Api.objectSubscriptionPUT(accessToken, zEntityId, zSubZID, zSubIn, RTExceptionCode.ERREUR_DESABO_APPLICATION_UPDATESUB2, pLog);
            //zSubUpdateResult = SM_Subscription.updateSub(zSubZID, zSubIn, zEntityId); 
            
            // Get Zuora Data (subscription)          
            subZdoc = zc_Api.subscriptionGET(accessToken, zEntityId, zSubZID, RTExceptionCode.ERREUR_ACQUISIT_GET_ZSUBSCRIPTION, pLog);
            // Get Zuora Data (Account)
            zc_ProxyGetAccount zacc = zc_Api.objectAccountGET(accessToken, zEntityId, sub.Zuora__CustomerAccount__r.Zuora__Zuora_Id__c, RTExceptionCode.ERREUR_ACQUISIT_GET_ACCOUNT, pLog);
            String payMethodId = zacc.defaultPaymentMethodId;
            // Get Zuora Data (PaymentMethod)
            pm = zc_Api.objectPaymentMethodGET(accessToken, zEntityId, payMethodId, RTExceptionCode.ERREUR_ACQUISIT_GET_PAYMENTMETHOD, pLog);
        }

        if (!isBatchCall) {

            // Create Welcome Back coupon :
            String offreWelcomeBack = Utils.getUgcGenericParam('Welcome Back Offre Name',acc.CodePays__c).ParamValue__c;
            Integer validiteCoupon_WB = Integer.valueOf(Utils.getUgcGenericParam('Welcome Back Coupon Validite',acc.CodePays__c).ParamValue__c);
            Id parentCouponID_WB = [Select Coupon__c from Offre__c where Name = :offreWelcomeBack Limit 1].Coupon__c;
            if (parentCouponID_WB == null) {throw new RTException(RTExceptionCode.ERREUR_DESABO_COUPON_WELCOMEBACK,pLog);}
            String coupon_WB = SM_Coupon.generateCouponItem(parentCouponID_WB,acc.Id,dateCancelContrat,dateCancelContrat.addMonths(validiteCoupon_WB));

            // Create Abo Tier coupon :
            String offreAboTier = Utils.getUgcGenericParam('Abo Tier Offre Name',acc.CodePays__c).ParamValue__c;
            Integer validiteCoupon_AT = Integer.valueOf(Utils.getUgcGenericParam('Abo Tier Coupon Validite',acc.CodePays__c).ParamValue__c);
            Id parentCouponID_AT = [Select Coupon__c from Offre__c where Name = :offreAboTier Limit 1].Coupon__c;
            if (parentCouponID_AT == null) {throw new RTException(RTExceptionCode.ERREUR_DESABO_COUPON_ABOTIER,pLog);}
            String coupon_AT = SM_Coupon.generateCouponItem(parentCouponID_AT,null,dateCancelContrat,dateCancelContrat.addMonths(validiteCoupon_AT));

            // Mise a jour du Case avec le coupon welcomeback et Abo Tier
            dem.CouponWelcomeback__c = coupon_WB;
            dem.couponAbotiers__c = coupon_AT;
			
            Id zDocId = SM_Hermes.addZdocData(new Map<String,Object>{'ZSUB' => subZdoc,'ZPM' => pm,'ACC' => acc});
			dem.ZDocData__c = zDocId;
	        dem.Status = 'Fermee';
            update dem;
            SM_SDoc.makeSdocJobs(new list<Case>{dem});
        }

    }


    private static void verifDesabo() {
        //Integer preavis = Util.PREAVIS(acc.CodePays__c);       
        Boolean isResiliationOrRetractationOrAnnulation = dem.RecordTypeId == resiliationRecordTypeId || dem.RecordTypeId == retractationRecordTypeId || dem.RecordTypeId == annulationContratRecordTypeId;
        
        if (sub == null) {
            throw new RTException(RTExceptionCode.ERREUR_DESABO_CONTRAT_ABSENT_DDE,pLog);
        }
        
        if (dateCancelContrat == null) { 
            throw new RTException(RTExceptionCode.ERREUR_DESABO_DATE_FINCONTRAT_OBLIGATOIRE,pLog);            
        }                

        if (!isBatchCall){
            //Check demande
            if (dem.Status == SM_Demande.getStatus('Fermee')) {
                throw new RTException(RTExceptionCode.ERREUR_DESABO_DDE_DEJA_TRAITE,pLog);
            }
        }

        if (dem.SousMotif__c == null) { //TODO peut etre a mettre au niveau parametrage AVOIR
            throw new RTException(RTExceptionCode.ERREUR_DESABO_SSMOTIF_OBLIGATOIRE,pLog);
        }
         
        //if (dem.Type_de_d_sabonnement__c == null) {
        if (dem.Type_de_d_sabonnement__c == null && !isResiliationOrRetractationOrAnnulation) {
            throw new RTException(RTExceptionCode.ERREUR_DESABO_TYPEDESABO_OBLIGATOIRE,pLog);
        }

        //Check Souscription Status
        if (!isBatchCall){
            if (sub.Zuora__Status__c != 'Active'){
                throw new RTException(RTExceptionCode.ERREUR_DESABO_ABO_NONACTIF,pLog);
            }else if (sub.DateFinContrat__c != null ){ 
                if (sub.TypeContrat__c == 'CDI'){
                    throw new RTException(RTExceptionCode.ERREUR_DESABO_CDI_AVEC_FINCONTRAT,pLog);
                }else if (sub.TypeContrat__c == 'CDD' && sub.DateFinContrat__c.addDays(1) != sub.Zuora__SubscriptionEndDate__c ){                
                        throw new RTException(RTExceptionCode.ERREUR_DESABO_CDD_AVEC_FINCONTRAT,pLog);                
                }
            }else {
                //// on peut desabonner : Actif et (datfin == null ou datefin = aujourdhui)
            }
        }else {
            if (sub.Zuora__Status__c != 'Active'){
                throw new RTException(RTExceptionCode.ERREUR_DESABO_ABO_NONACTIF2,pLog);
            }
        }

        //Check Type/Date Desabo
        if (dem.Type_de_d_sabonnement__c == 'Désabonnement avec justificatif (E)') {
            if (dem.Date_de_D_sabonnement__c == null) {
                throw new RTException(RTExceptionCode.ERREUR_DESABO_DATEDESABO_OBLIGATOIRE,pLog);
            } 
        } else if (dem.Type_de_d_sabonnement__c == 'Désabonnement avec préavis (L)') {
            if (sub.TypeContrat__c == 'CDD') {
                throw new RTException(RTExceptionCode.ERREUR_DESABO_CDD_IMPOSSIBLE,pLog);
            } else if (sub.TypeContrat__c == 'CDI') {
                // on peut desabonner
            }
        }
    }


    // Operation desabonnement: Contrats Sans Case: (Bilendi(CDD+CDI) ou CDD(sans code Fin))
    public static void desabonner_SansCase(Id subId) {
        
        zc_SaveResult zSubUpdateResult = new zc_SaveResult();
        String codeDesaCarte = null;
        String operation = 'desabonnement';
        Boolean billRun;
        String amendOperation = null;
        Boolean noRemboursementAFaire = false;              

        System.debug('MBEN:desabonner_SansCase: DEBUT');

        sub = SM_Subscription.getSubscription(subId);
        acc = SM_Account.getAccount(sub.Zuora__Account__c);

        pLog = new ProcessLog__c(Process__c = 'desabonner_SansCase_isBatchCall', Account__c = acc.Id, SubscriptionName__c = sub.Name, SubscriptionZID__c = sub.Zuora__External_Id__c);

        dateCancelContrat = sub.DateFinContrat__c.addDays(1);

        // Verification du desabo
        verifDesabo_SansCase();
                
        noRemboursementAFaire = true;
        isDesaboNow = true;
        
        // assign zSubIn: Code fin contrat + amendOperation  + date fin contrat  + Id   
        if (sub.CodeFinContrat__c == 'A'){
            amendOperation = 'Retractation';            
        }else if (sub.CodeFinContrat__c == 'X' || sub.CodeFinContrat__c == 'M'){
            amendOperation = 'Resiliation';            
        }else if (sub.CodeFinContrat__c == 'E' || sub.CodeFinContrat__c == 'L') {
            amendOperation = 'Desabonnement';          
        }else {
            amendOperation = 'Desabonnement'; // CDD qui n ont pas de codefin.
        }        
    
        System.debug('MBEN:desabonner_SansCase: ' + ' isDesaboNow: '+isDesaboNow+' noRemboursementAFaire: '+noRemboursementAFaire);
        System.debug('MBEN:desabonner_SansCase: ' + ' sub.DateFinContrat__c: ' + sub.DateFinContrat__c);
        System.debug('MBEN:desabonner_SansCase: ' + ' amendOperation: ' + amendOperation + ' sub.CodeFinContrat__c: '+sub.CodeFinContrat__c);        

        String zEntityId = WS001_CallZuora.getZuoraEntityId(acc.CodePays__c);

        // Auth
        String accessToken = WS001_CallZuora.access_token;

        // Cancel Subscription
        billRun = !noRemboursementAFaire;
        zc_POSTSubscriptionCancellationType reqObj = new zc_POSTSubscriptionCancellationType();
        reqObj.cancellationEffectiveDate = dateCancelContrat;
        reqObj.targetDate = dateCancelContrat; 
        reqObj.runBilling = billRun; 
        reqObj.cancellationPolicy = 'SpecificDate'; 
        zc_POSTSubscriptionCancellationResp rCancel = zc_Api.subscriptionCancelPUT(accessToken, zEntityId, reqObj, sub.Zuora__Zuora_Id__c, RTExceptionCode.ERREUR_DESABO_APPLICATION_CANCEL2, pLog);
        String newSubId = rCancel.subscriptionId;

        // Get Amendment Id: 
        WSZ.AmendOut amend = SM_Amendment.getAmendment(newSubId, zEntityId);
        WSZ.GenericOut2 amend2 = new WSZ.GenericOut2();

        // Mise a jour amendOperation dans Zuora            
        if (amendOperation != null ) {
            amend2 = SM_Amendment.updateAmendment(new WSZ.AmendIn(amend.id, amendOperation), zEntityId);
        }

        // update subscription (code fin pour les CDD sans code fin)
        if (sub.CodeFinContrat__c == null && sub.TypeContrat__c == 'CDD') {
            zSubIn.codeFinContrat = 'L';
            zSubUpdateResult = zc_Api.objectSubscriptionPUT(accessToken, zEntityId, newSubId, zSubIn, RTExceptionCode.ERREUR_DESABO_APPLICATION_UPDATESUB3, pLog);
            //zSubUpdateResult = SM_Subscription.updateSub(newSubId, zSubIn, zEntityId);
        }
        
        //Desactivation de la carte
        if(String.isBlank(sub.CodeFinContrat__c)) {
            codeDesaCarte = null;
        } else {
            codeDesaCarte = sub.CodeFinContrat__c;
        }

        //S41 ECH Appel de la désactivation de carte synchrone
        List<Carte__c> listCarteToUpdate = SM_Carte.desactivation(acc.Id, codeDesaCarte);
             
        update listCarteToUpdate;
    }


    private static void verifDesabo_SansCase() {

        if (dateCancelContrat == null) { 
            throw new RTException(RTExceptionCode.ERREUR_DESABO_DATE_FINCONTRAT_OBLIGATOIRE,pLog);            
        }        
                  
        if (sub.Zuora__Status__c != 'Active'){
            throw new RTException(RTExceptionCode.ERREUR_DESABO_SANSCASE_NONACTIF,pLog);
        }
        
        //Check TypeContrat
        if (sub.TypeContrat__c == 'CDD') {
            // throw new RTException(RTExceptionCode.ERREUR_DESABO_SANSCASE_CDD_IMPOSSIBLE,pLog);
            // on peut desabonner
        } else if (sub.TypeContrat__c == 'CDI') {
                // on peut desabonner
        }
        
    }

}