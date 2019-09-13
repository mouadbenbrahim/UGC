/**
 * Created by mouad on 03/09/2018.
 */


public with sharing class SM_Desabonnement {

    public static Case dem = new Case();
    public static Zuora__Subscription__c sub = new Zuora__Subscription__c();
    public static Account acc = new Account();
    private static Date dateLatence;
    
    public static Id resiliationRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Résiliation').getRecordTypeId();
    public static Id desabonnementRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Désabonnement').getRecordTypeId();
	public static Id retentionRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Rétention').getRecordTypeId();
	
    public static Id retractationRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Rétractation').getRecordTypeId();
    public static Id annulationContratRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Annulation contrat').getRecordTypeId();
    
    


    // Operation desabonnement
    public static void desabonner(Id ddeId) {
		
        String policy = 'SpecificDate';
        String codeDesaCarte = null;
        String operation = 'desabonnement';
        Case dem2 = new Case();

        dem = SM_Demande.getDemande(ddeId);

        if (dem.Subscription__c == null) {
            throw new MyException('Abonnement absent de la demande: pas dabo, plusieurs ou inactif');
        } else {
            Id subId = dem.Subscription__c;
        }
        sub = SM_Subscription.getSubscription(dem.Subscription__c);

        acc = SM_Account.getAccount(dem.AccountId);
        String zEntityId = WS001_CallZuora.getZuoraEntityId(acc.CodePays__c);

        verifDesabo();
        
        
        //calcul boolean pour savoir cas sans remboursement
        Boolean noRemboursementAFaire = false;
		if(dem.RecordTypeId == resiliationRecordTypeId){
			noRemboursementAFaire = true;
		}
		if((dem.RecordTypeId == desabonnementRecordTypeId || dem.RecordTypeId == retentionRecordTypeId) && dem.Type_de_d_sabonnement__c == 'Désabonnement avec préavis (L)'){
			noRemboursementAFaire = true;
		}
		if((dem.RecordTypeId == desabonnementRecordTypeId || dem.RecordTypeId == retentionRecordTypeId) && dem.Type_de_d_sabonnement__c == 'Désabonnement avec justificatif (E)' && sub.TypeContrat__c == 'CDI'){
			noRemboursementAFaire = true;
		}
		
		
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


        //Cansel de la subscription
        WSZ.SubCancelOut rCancel = null;
        String newSubZID = null;
        Date dateFinContrat = dem.DateFinContrat__c;
        
        String cancellationEffectiveDate = Util.zDate(dateFinContrat);
        system.debug('##MNE SM_Desabonnement desabonner cancellationEffectiveDate >> '+cancellationEffectiveDate);
        Boolean billRun = true;
        String targetDate = cancellationEffectiveDate;

        /*if(noRemboursementAFaire){
            policy = 'EndOfLastInvoicePeriod';
            //targetDate = cancellationEffectiveDate;
        }*/
        
        /*if((dem.RecordTypeId == desabonnementRecordTypeId || dem.RecordTypeId == retentionRecordTypeId) && dem.Type_de_d_sabonnement__c == 'Désabonnement avec préavis (L)'){
            billRun = false;
        }*/
        if(noRemboursementAFaire){
            billRun = false;
        }
        
        rCancel = SM_Subscription.cancelSub(cancellationEffectiveDate, policy, sub.Zuora__Zuora_Id__c, billRun, targetDate, zEntityId);
        system.debug('##MNE SM_Desabonnement desabonner rCancel >> '+rCancel);
        newSubZID = rCancel.subscriptionId;
        system.debug('##MNE SM_Desabonnement desabonner newSubZID >> '+newSubZID);
        System.debug((String) JSON.serialize(rCancel));

        // Create Welcome Back coupon :
        String offreWelcomeBack = Utils.getUgcGenericParam('Welcome Back Offre Name',acc.CodePays__c).ParamValue__c;
        Integer validiteCoupon = Integer.valueOf(Utils.getUgcGenericParam('Welcome Back Coupon Validite',acc.CodePays__c).ParamValue__c);
        Id parentCouponID = [Select Coupon__c from Offre__c where Name = :offreWelcomeBack Limit 1].Coupon__c;
        String coupon = SM_Coupon.generateCouponItem(parentCouponID,acc.Id,Date.today(),Date.today().addMonths(validiteCoupon));

        // TODO Create Abotier coupon
        
        // Mise a jour du Case avec le coupon welcomeback
        dem.CouponWelcomeback__c = coupon;
        update dem;

        // Get Amendment Id: (MBEN: 04072019)
        WSZ.AmendOut amend = SM_Amendment.getAmendment(newSubZID, zEntityId);
        WSZ.GenericOut2 amend2 = new WSZ.GenericOut2();


        // Mise a jour de la souscription dans Zuora
        Zuora__Subscription__c newSub = new Zuora__Subscription__c();
        newSub.DateFinContrat__c = dateFinContrat;
        if (dem.RecordTypeId == retractationRecordTypeId || dem.RecordTypeId == annulationContratRecordTypeId){
            newSub.CodeFinContrat__c = 'A';
            amend2 = SM_Amendment.updateAmendment(new WSZ.AmendIn(amend.id, 'Retractation'), zEntityId);
        }
        else if (dem.RecordTypeId == resiliationRecordTypeId){
            if(dem.Motif_de_R_siliation__c == 'Code X'){
                newSub.CodeFinContrat__c = 'X';
            } else {
                newSub.CodeFinContrat__c = 'M';
            }
            amend2 = SM_Amendment.updateAmendment(new WSZ.AmendIn(amend.id, 'Resiliation'), zEntityId);
        }
        else {
            if (dem.Type_de_d_sabonnement__c == 'Désabonnement avec justificatif (E)') {
                newSub.CodeFinContrat__c = 'E';

            } else if (dem.Type_de_d_sabonnement__c == 'Désabonnement avec préavis (L)') {
                newSub.CodeFinContrat__c = 'L';
            }
            amend2 = SM_Amendment.updateAmendment(new WSZ.AmendIn(amend.id, 'Desabonnement'), zEntityId);
        }
        
        //pour autoriser l'annulation du cancel
        if(String.isBlank(rCancel.creditMemoId) && String.isBlank(rCancel.invoiceId)){  //rCancel.invoiceId
        	newSub.Tech_AvecRembouesement__c = 'false';
        } else {
        	newSub.Tech_AvecRembouesement__c = 'true';
        }
        
        WSZ.SubOut rUpdate = SM_Subscription.updateSub(newSubZID, newSub, zEntityId);
        
        
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
            dateResiliation = dateFinContrat;
            createCaseRemboursement = true;
        } else if(String.isNotBlank(rCancel.creditMemoId)  && noRemboursementAFaire) {
        	//pas de rembooursement si resiliation, retractation ou annulationContrat
        	//normalement on rentre pas ici car cancel a invoice term
            SM_CreditMemo.unpost(rCancel.creditMemoId, zEntityId);
            SM_CreditMemo.cancel(rCancel.creditMemoId, zEntityId);
        }
        
        
        
        
        //Remboursement
        if(dem.RemboursementFaire__c && createCaseRemboursement){
        	SM_Remboursement.createRebousementCase(dem.Id, dem.MontantRembourser__c, amountToRefundRoundFromCreditMemo, dem.AccountId, rCancel.creditMemoId, dateResiliation, null, null);
        }
        else if(createCaseRemboursement){
        	SM_Remboursement.createRebousementCase(dem.Id, amountToRefundRoundFromCreditMemo, amountToRefundRoundFromCreditMemo, dem.AccountId, rCancel.creditMemoId, dateResiliation, null, null);
        }
        else if(dem.RemboursementFaire__c){
        	SM_Remboursement.createRebousementCase(dem.Id, dem.MontantRembourser__c, dem.MontantRembourser__c, dem.AccountId, null, dateResiliation, null, null);
        }

        //Desactivation de la carte
        if(String.isBlank(newSub.CodeFinContrat__c)) {
        	codeDesaCarte = null;
        } else {
        	codeDesaCarte = newSub.CodeFinContrat__c;
        }
        SM_Carte.desactivation(dem.AccountId, codeDesaCarte);

        clientNotification();
    }


    private static void verifDesabo() {

        Integer preavis = Util.PREAVIS(acc.CodePays__c);
        
        Boolean isResiliationOrRetractationOrAnnulation = dem.RecordTypeId == resiliationRecordTypeId || dem.RecordTypeId == retractationRecordTypeId || dem.RecordTypeId == annulationContratRecordTypeId;

        //Check demande
        if (dem.Status == SM_Demande.getStatus('Fermee')) {
            throw new MyException('Cette demande a deja ete traite');
        }

        if (dem.SousMotif__c == null) { //TODO peut etre a mettre au niveau parametrage AVOIR
            throw new MyException('Sous-Motif obligatoire');
        }
        
        //if (dem.Type_de_d_sabonnement__c == null) {
        if (dem.Type_de_d_sabonnement__c == null && !isResiliationOrRetractationOrAnnulation) {
            throw new MyException('Type de désabonnement obligatoire');
        }

        //Check Souscription Status
        if (sub.Zuora__Status__c != 'Active') {
            throw new MyException('L abonnement n est pas actif');
        }

        //Check Date Fin contrat
        if (dem.Type_de_d_sabonnement__c == 'Désabonnement avec justificatif (E)') {
            if (dem.Date_de_D_sabonnement__c == null) {
                throw new MyException('Veuillez saisir une date de désabonnement');
            } 
        } else if (dem.Type_de_d_sabonnement__c == 'Désabonnement avec préavis (L)') {
            if (sub.TypeContrat__c == 'CDD') {
                throw new MyException('Pas possible de desabonner un contrat CDD, le contrat sera automatique désabonné à la date de fin de contrat');
            } else if (sub.TypeContrat__c == 'CDI') {

            }
        }
    }

    //Annulation du desabonnement
    public static void annuler(Id ddeId){
        //TODO gestion de la reprise sur erreur: savepoint.

        String codeDesaCarte = null;
        String operation = 'annulation';
        Id remboursementId = null;        
        WSZ.SubOut rAnnule = null;


        /** Initialisation du contexte: dem: (demande) */
        //setDem(ddeId);
        dem = SM_Demande.getDemande(ddeId);

        /** Initialisation du contexte: sub: (souscription) */
        if (dem.Subscription__c == null) {
            throw new MyException('Abonnement absent de la demande: pas dabo, plusieurs ou inactif');
        } else {
            Id subId = dem.Subscription__c;
        }
        sub = SM_Subscription.getSubscription(dem.Subscription__c);

        /** Initialisation autres */
        dateLatence = sub.Zuora__CancelledDate__c.addMonths(1);
        acc = SM_Account.getAccount(dem.AccountId);
        String zEntityId = WS001_CallZuora.getZuoraEntityId(acc.CodePays__c);

        /** Verifications */
        verifAnnulation();

        /** Annuler desabonnement */
        Id prevSubZID = sub.Zuora__PreviousSubscriptionId__c;
        rAnnule = SM_Subscription.deleteSub(sub.Zuora__Zuora_Id__c, zEntityId);

        /** Mise a jour de la souscription dans Zuora */
        //Pas besoin de maj le code fin contrat a null car il est supprime automatiquement suite au delete
        //Zuora__Subscription__c newSub = new Zuora__Subscription__c();
        //newSub.CodeFinContrat__c = null;
        //WSZ.SubOut rUpdate = SM_Subscription.updateSub(newSubZID, newSub);

        /** Encaissement du mois en cours */
        if (SM_Subscription.getLastChargedDate(prevSubZID) < Date.today()){
            //TODO: getLastChargedDate: verifier scenario:
            // Desabo fait le 20/04/2018 pour le 30/06/2018(preavis 2 mois), le 01/05 bill run, le 10/05 j'annule le desabo
            // Quelle est la valeur du getLastChargeDate ? est-ce qu'elle disparait avec la subscription ? normalement pas d impact a tester
            //TODO Billrun + Payment du mois en cours: invoice date=today , target date fin du mois en cours
        }

        /** Activation de la carte TODO*/
        /*
        if (dem.SousMotif__c == 'Exceptionnel') {
            codeDesaCarte = 'E';
        } else if (dem.SousMotif__c == 'Legitime') {
            codeDesaCarte = 'L';
        }
        */
        //SM_Carte.carteActivation(codeDesaCarte);
        SM_Carte.activation(codeDesaCarte);


        /** Mise a jour de la demande */
        dem.Status = SM_Demande.getStatus('DesaboAnnule'); // close ticket
        update dem;

        //Mise à jour du Client
        // TODO acc2.CodeResiliation = ??; voir si on met à jour depuis Trigger sur souscription
        //update acc2;

        //ClientNotification
        clientNotification();

    }

    private static void verifAnnulation() {
        //TODO: voir specs pour les verifications

        //Verifier si on a depasse le mois de latence
        If (dateLatence < Date.today()) {
            throw new MyException('Date de fin latence depasse: impossible d annuler l abonnement');
        }
    }

    private static void clientNotification() {

    }


    private class MyException extends Exception {
    }


}