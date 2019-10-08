/**
 * Created by mouad on 03/09/2018.
 */


public without sharing class SM_Desabonnement {

    public static Case dem = new Case();
    public static Zuora__Subscription__c sub = new Zuora__Subscription__c();
    private static Zuora__Subscription__c zSubIn = new Zuora__Subscription__c();
    public static Account acc = new Account();
    private static Date dateLatence, dateCancelContrat;
    private static Boolean isDesaboNow;
    public static Boolean isBatchCall;
    
    public static Id resiliationRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Résiliation').getRecordTypeId();
    public static Id desabonnementRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Désabonnement').getRecordTypeId();
    public static Id retentionRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Rétention').getRecordTypeId();
    
    public static Id retractationRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Rétractation').getRecordTypeId();
    public static Id annulationContratRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Annulation contrat').getRecordTypeId();
    

    // Operation desabonnement
    public static void desabonner(Id ddeId, Boolean isBatchCall2) {
        
        String policy = 'SpecificDate';
        String codeDesaCarte = null;
        String operation = 'desabonnement';
        WSZ.SubCancelOut rCancel = null;
        String zSubZID = null;        
        String cancellationEffectiveDate;
        String targetDate;        
        Boolean billRun;
        String amendOperation = null;
        Boolean noRemboursementAFaire = false;
        WSZ.SubOut zSubUpdateResult = new WSZ.SubOut();
        
        isBatchCall = isBatchCall2;

        dem = SM_Demande.getDemande(ddeId);
        dateCancelContrat = dem.DateFinContrat__c;

        if (dem.Subscription__c == null) {
            throw new MyException('Abonnement absent de la demande: pas dabo, plusieurs ou inactif');
        } else {
            Id subId = dem.Subscription__c;
        }
        sub = SM_Subscription.getSubscription(dem.Subscription__c);

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
            if (dateCancelContrat <= Date.today()) { //Decider si desabonner dans le futur ou pas ? autres criteres date fin contrat
                isDesaboNow = true;
            }else {
                isDesaboNow = false;
            }
        }else { // Batch Call
                isDesaboNow = true;
            }
        
        // assign zSubIn: Code fin contrat + amendOperation  + date fin contrat  + Id   
        if (dem.RecordTypeId == retractationRecordTypeId || dem.RecordTypeId == annulationContratRecordTypeId){
            zSubIn.CodeFinContrat__c = 'A';
            amendOperation = 'Retractation';
        }else if (dem.RecordTypeId == resiliationRecordTypeId){
            if(dem.Motif_de_R_siliation__c == 'Code X'){
                zSubIn.CodeFinContrat__c = 'X';
            } else {
                zSubIn.CodeFinContrat__c = 'M';
            }
            amendOperation = 'Resiliation';            
        }else {
            if (dem.Type_de_d_sabonnement__c == 'Désabonnement avec justificatif (E)') {
                zSubIn.CodeFinContrat__c = 'E';
            } else if (dem.Type_de_d_sabonnement__c == 'Désabonnement avec préavis (L)') {
                zSubIn.CodeFinContrat__c = 'L';
            }
            amendOperation = 'Desabonnement';          
        }        
        zSubIn.DateFinContrat__c = dateCancelContrat.addDays(-1);
        zSubZID = dem.Subscription__r.Zuora__Zuora_Id__c;
        zSubIn.CancelCaseID__c = dem.Id;

        System.debug('MBEN:desabonner: ' + ' isDesaboNow: '+isDesaboNow+' isBatchCall: '+isBatchCall+' noRemboursementAFaire: '+noRemboursementAFaire);
        System.debug('MBEN:desabonner: ' + ' dem.DateFinContrat__c: ' + dem.DateFinContrat__c + ' zSubIn.DateFinContrat__c: ' + zSubIn.DateFinContrat__c + 'zSubIn.CancelCaseID__c: ' + zSubIn.CancelCaseID__c);
        System.debug('MBEN:desabonner: ' + ' amendOperation: ' + amendOperation + ' zSubIn.CodeFinContrat__c: '+zSubIn.CodeFinContrat__c);
        System.debug('MBEN:desabonner: ' + 'zSubIn.CancelCaseID__c: ' + zSubIn.CancelCaseID__c + 'dem.Id: '+dem.Id);

        if (isDesaboNow){

            //Cancel de la subscription
            cancellationEffectiveDate = Util.zDate(dateCancelContrat);
            targetDate = Util.zDate(dateCancelContrat);            
            billRun = !noRemboursementAFaire;

            rCancel = SM_Subscription.cancelSub(cancellationEffectiveDate, policy, sub.Zuora__Zuora_Id__c, billRun, targetDate, zEntityId);
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
                zSubIn.Tech_AvecRembouesement__c = 'false';
            } else {
                zSubIn.Tech_AvecRembouesement__c = 'true';
            }
            
            // Mise a jour souscription dans Zuora: DateFinContrat__c, CodeFinContrat__c, Tech_AvecRembouesement__c
            zSubUpdateResult = SM_Subscription.updateSub(zSubZID, zSubIn, zEntityId);
       
         
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
                
        
            //Remboursement
            if(dem.RemboursementFaire__c && createCaseRemboursement){
                SM_Remboursement.createRebousementCase(dem.Id, dem.MontantRembourser__c, amountToRefundRoundFromCreditMemo, dem.AccountId, rCancel.creditMemoId, dateResiliation, null, Date.today());
            }
            else if(createCaseRemboursement){
                SM_Remboursement.createRebousementCase(dem.Id, amountToRefundRoundFromCreditMemo, amountToRefundRoundFromCreditMemo, dem.AccountId, rCancel.creditMemoId, dateResiliation, null, Date.today());
            }
            else if(dem.RemboursementFaire__c){
                SM_Remboursement.createRebousementCase(dem.Id, dem.MontantRembourser__c, dem.MontantRembourser__c, dem.AccountId, null, dateResiliation, null, Date.today());
            }

            //Desactivation de la carte
            if(String.isBlank(zSubIn.CodeFinContrat__c)) {
                codeDesaCarte = null;
            } else {
                codeDesaCarte = zSubIn.CodeFinContrat__c;
            }
            SM_Carte.desactivation(dem.AccountId, codeDesaCarte);
        
        
            // Create Welcome Back coupon :
            String offreWelcomeBack = Utils.getUgcGenericParam('Welcome Back Offre Name',acc.CodePays__c).ParamValue__c;
            Integer validiteCoupon = Integer.valueOf(Utils.getUgcGenericParam('Welcome Back Coupon Validite',acc.CodePays__c).ParamValue__c);
            Id parentCouponID = [Select Coupon__c from Offre__c where Name = :offreWelcomeBack Limit 1].Coupon__c;
            String coupon = SM_Coupon.generateCouponItem(parentCouponID,acc.Id,dateCancelContrat,dateCancelContrat.addMonths(validiteCoupon));

            // TODO Create Abotier coupon
        
            // Mise a jour du Case avec le coupon welcomeback
            dem.CouponWelcomeback__c = coupon;
            update dem;

        }else { //!isDesaboNow            
            //Mise a jour Subscription Zuora: Date fin contrat + code fin contrat 

            zSubUpdateResult = SM_Subscription.updateSub(zSubZID, zSubIn, zEntityId);
        }

    }


    private static void verifDesabo() {
        //Integer preavis = Util.PREAVIS(acc.CodePays__c);       
        Boolean isResiliationOrRetractationOrAnnulation = dem.RecordTypeId == resiliationRecordTypeId || dem.RecordTypeId == retractationRecordTypeId || dem.RecordTypeId == annulationContratRecordTypeId;

        if (dateCancelContrat == null) { 
            throw new RTException(RTExceptionCode.ERREUR_DESABO_DATE_FINCONTRAT_OBLIGATOIRE);            
        }                

        if (!isBatchCall){
            //Check demande
            if (dem.Status == SM_Demande.getStatus('Fermee')) {
                throw new MyException('Cette demande a deja ete traite');
            }
        }

        if (dem.SousMotif__c == null) { //TODO peut etre a mettre au niveau parametrage AVOIR
            throw new MyException('Sous-Motif obligatoire');
        }
         
        //if (dem.Type_de_d_sabonnement__c == null) {
        if (dem.Type_de_d_sabonnement__c == null && !isResiliationOrRetractationOrAnnulation) {
            throw new MyException('Type de désabonnement obligatoire');
        }

        //Check Souscription Status
        // TODO Date.today() a creuser et aligner avec AP02Case..
        // tout depend quel datefincontrat on stock dans le case et dans la souscription 
        if (!isBatchCall){
            if (sub.Zuora__Status__c != 'Active'){
                throw new MyException('L abonnement n est pas actif');
            }else if (sub.DateFinContrat__c != null ){ 
                if (sub.TypeContrat__c == 'CDI'){
                    throw new RTException(RTExceptionCode.ERREUR_DESABO_CDI_AVEC_FINCONTRAT);
                }else if (sub.TypeContrat__c == 'CDD' && sub.DateFinContrat__c.addDays(1) != sub.Zuora__SubscriptionEndDate__c ){                
                        throw new RTException(RTExceptionCode.ERREUR_DESABO_CDD_AVEC_FINCONTRAT);                
                }
            }else {
                //// on peut desabonner : Actif et (datfin == null ou datefin = aujourdhui)
            }
        }else {
            if (sub.Zuora__Status__c != 'Active'){
                throw new MyException('L abonnement n est pas actif');
            }
        }

        //Check Type/Date Desabo
        if (dem.Type_de_d_sabonnement__c == 'Désabonnement avec justificatif (E)') {
            if (dem.Date_de_D_sabonnement__c == null) {
                throw new MyException('Veuillez saisir une date de désabonnement');
            } 
        } else if (dem.Type_de_d_sabonnement__c == 'Désabonnement avec préavis (L)') {
            if (sub.TypeContrat__c == 'CDD') {
                throw new MyException('Pas possible de desabonner un contrat CDD, le contrat sera automatique désabonné à la date de fin de contrat');
            } else if (sub.TypeContrat__c == 'CDI') {
                // on peut desabonner
            }
        }
    }


    // Operation desabonnement
    public static void desabonner_Bilendi(Id subId) {
        
        String policy = 'SpecificDate';
        String codeDesaCarte = null;
        String operation = 'desabonnement';
        WSZ.SubCancelOut rCancel = null;  
        String cancellationEffectiveDate;
        String targetDate;        
        Boolean billRun;
        String amendOperation = null;
        // Date dateFinContrat;
        Boolean noRemboursementAFaire = false;              

        System.debug('MBEN:desabonner_Bilendi: DEBUT');

        sub = SM_Subscription.getSubscription(subId);
        acc = SM_Account.getAccount(sub.Zuora__Account__c);
        
        dateCancelContrat = sub.DateFinContrat__c.addDays(1);

        // Verification du desabo
        verifDesabo_Bilendi();
                
        noRemboursementAFaire = true;
        isDesaboNow = true;
        
        // assign zSubIn: Code fin contrat + amendOperation  + date fin contrat  + Id   
        if (sub.CodeFinContrat__c == 'A'){
            amendOperation = 'Retractation';            
        }else if (sub.CodeFinContrat__c == 'X' || sub.CodeFinContrat__c == 'M'){
            amendOperation = 'Resiliation';            
        }else if (sub.CodeFinContrat__c == 'E' || sub.CodeFinContrat__c == 'L') {
            amendOperation = 'Desabonnement';          
        }        
    

        System.debug('MBEN:desabonner_Bilendi: ' + ' isDesaboNow: '+isDesaboNow+' noRemboursementAFaire: '+noRemboursementAFaire);
        System.debug('MBEN:desabonner_Bilendi: ' + ' sub.DateFinContrat__c: ' + sub.DateFinContrat__c);
        System.debug('MBEN:desabonner_Bilendi: ' + ' amendOperation: ' + amendOperation + ' sub.CodeFinContrat__c: '+sub.CodeFinContrat__c);        
        

        String zEntityId = WS001_CallZuora.getZuoraEntityId(acc.CodePays__c);
        //Cancel de la subscription
        cancellationEffectiveDate = Util.zDate(dateCancelContrat);
        targetDate = Util.zDate(dateCancelContrat);            
        billRun = !noRemboursementAFaire;

        rCancel = SM_Subscription.cancelSub(cancellationEffectiveDate, policy, sub.Zuora__Zuora_Id__c, billRun, targetDate, zEntityId);
        String newSubId = rCancel.subscriptionId;
        // Get Amendment Id: 
        WSZ.AmendOut amend = SM_Amendment.getAmendment(newSubId, zEntityId);
        WSZ.GenericOut2 amend2 = new WSZ.GenericOut2();

        // Mise a jour amendOperation dans Zuora            
        if (amendOperation != null ) {
            amend2 = SM_Amendment.updateAmendment(new WSZ.AmendIn(amend.id, amendOperation), zEntityId);
        }

        //Desactivation de la carte
        if(String.isBlank(sub.CodeFinContrat__c)) {
            codeDesaCarte = null;
        } else {
            codeDesaCarte = sub.CodeFinContrat__c;
        }
        SM_Carte.desactivation(acc.Id, codeDesaCarte);
    
    
        // Create Welcome Back coupon :
        String offreWelcomeBack = Utils.getUgcGenericParam('Welcome Back Offre Name',acc.CodePays__c).ParamValue__c;
        Integer validiteCoupon = Integer.valueOf(Utils.getUgcGenericParam('Welcome Back Coupon Validite',acc.CodePays__c).ParamValue__c);
        Id parentCouponID = [Select Coupon__c from Offre__c where Name = :offreWelcomeBack Limit 1].Coupon__c;
        String coupon = SM_Coupon.generateCouponItem(parentCouponID,acc.Id,dateCancelContrat,dateCancelContrat.addMonths(validiteCoupon));

        // TODO Create Abotier coupon
        // TODO maj case mais il n y a pas de case pour les contrat repris Bilendi
    
        // Mise a jour du Case avec le coupon welcomeback
        // dem.CouponWelcomeback__c = coupon;
        // update dem;                           

    }


    private static void verifDesabo_Bilendi() {

        //Integer preavis = Util.PREAVIS(acc.CodePays__c);
                
        if (dateCancelContrat == null) { 
            throw new RTException(RTExceptionCode.ERREUR_DESABO_DATE_FINCONTRAT_OBLIGATOIRE);            
        }        
                  
        if (sub.Zuora__Status__c != 'Active'){
            throw new MyException('L abonnement n est pas actif');
        }
        
        //Check TypeContrat
        if (sub.TypeContrat__c == 'CDD') {
                throw new MyException('Contrat Bilendi : desabonnement non possible pour les CDD');
            } else if (sub.TypeContrat__c == 'CDI') {
                // on peut desabonner
        }
        
    }

    //Annulation du desabonnement: dans SM005_AnnulationDesabo

    private class MyException extends Exception {
    }
}

// --------------           END CLASS

        /*if(noRemboursementAFaire){
            policy = 'EndOfLastInvoicePeriod';
            //targetDate = cancellationEffectiveDate;
        }*/
        
        /*if((dem.RecordTypeId == desabonnementRecordTypeId || dem.RecordTypeId == retentionRecordTypeId) && dem.Type_de_d_sabonnement__c == 'Désabonnement avec préavis (L)'){
            billRun = false;
        }*/

        //calcul boolean pour savoir cas avec remboursement
        /*Boolean remboursementAFaire = false;
        if(dem.RecordTypeId == retentionRecordTypeId && dem.Type_de_d_sabonnement__c == 'Désabonnement avec justificatif (E)' && sub.TypeContrat__c == 'CDI'){
            remboursementAFaire = true;
        }
        if(dem.RecordTypeId == retractationRecordTypeId){
            remboursementAFaire = true;
        }
        if(dem.RecordTypeId == desabonnementRecordTypeId && dem.Type_de_d_sabonnement__c == 'Désabonnement avec justificatif (E)' && sub.TypeContrat__c == 'CDD'){
            remboursementAFaire = true;
        }*/