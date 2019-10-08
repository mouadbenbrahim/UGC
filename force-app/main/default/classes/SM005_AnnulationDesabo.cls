/**
 * Created by EasyFront on 20/05/2019.
 */

public without sharing class SM005_AnnulationDesabo {

    public static Case dem = new Case();
    public static Account acc = new Account();
    public static Zuora__Subscription__c sub = new Zuora__Subscription__c();

	public static void AnnulerDesabo(Id ddeId) {    	

        WSZ.GenericEmptyFields subEmpty = new WSZ.GenericEmptyFields();
        subEmpty.fieldsToNull = new List<String>{'DateFinContrat__c','CodeFinContrat__c','CancelCaseID__c'};

        /** Initialisation du contexte: dem: (demande), Account */
        //setDem(ddeId);
        dem = SM_Demande.getDemande(ddeId);
        acc = SM_Account.getAccount(dem.AccountId);

        //recuperer la derniere souscription du compte        
        List<Zuora__Subscription__c> lastSubscription = [Select Id, CancelCaseID__c from Zuora__Subscription__c where Zuora__Account__c =:acc.Id ORDER BY Zuora__OriginalCreated_Date__c DESC NULLS LAST LIMIT 1];
        if (lastSubscription.size() == 0 ){
            throw new RTException(RTExceptionCode.ERREUR_ANNUL_DESABO_AUCUN_CONTRAT_TROUVE);
        }
        sub = SM_Subscription.getSubscription(lastSubscription[0].Id);
        
        verifAnnulerDesabo();
        

        /** Annuler desabonnement */
        String zEntityId = WS001_CallZuora.getZuoraEntityId(acc.CodePays__c);

        if (sub.Zuora__Status__c == 'Active') { //contrat en desabo futur            
            WSZ.SubOut subOut = SM_Subscription.updateSub(sub.Zuora__Zuora_Id__c, subEmpty, zEntityId);  
        }else {   // contract cancelled                 

            //suppression de l'amend cancel
            WSZ.AmendOut rep = SM_Amendment.getAmendment(sub.Zuora__Zuora_Id__c, zEntityId);
            if (rep.typeX != 'Cancellation') {
                throw new MyException('Le dernier Amend n\'est pas un Amend de type Cancellation');
            }
            if (rep.status != 'Completed') {
                throw new MyException('Le dernier Amend n\'est pas Completed');
            }

            list<String> listAmendId = new list<String>();
            listAmendId.add(rep.id);
            list<WSZ.DeleteOut> deleteRep =  SM_Subscription.deleteZObject(listAmendId, 'Amendment', zEntityId);

            WSZ.SubOut subOut = SM_Subscription.updateSub(sub.Zuora__PreviousSubscriptionId__c, subEmpty, zEntityId);            

        }

        SM_Carte.activation(dem.AccountId);

        /** cloture de la demande */        
		dem.Status = 'Fermee';       
        update dem;

// ------
       		
    	
    }
    
    private static void verifAnnulerDesabo() {

        Date dateLatence;

        // if(sub.CancelCaseID__c == null)

        if (dem.Status == SM_Demande.getStatus('Fermee')) {
            throw new MyException('Cette demande a deja ete traite');
        }

        if (dem.SousMotif__c == null) {
            throw new MyException('Sous-Motif obligatoire');
        }
        
        // if(sub.Zuora__PreviousSubscriptionId__c == sub.Zuora__Zuora_Id__c){
        // 	throw new MyException('La souscription est l\'original, elle ne possède aucun desabonnement.');
        // }
        
        if(sub.Zuora__CustomerAccount__r.Zuora__Balance__c != 0){
        	throw new MyException('La balance du compte zuora n\'est pas à 0');
        }
        
        if(sub.Tech_AvecRembouesement__c == 'true'){
        	throw new MyException('Cet amend est suivie par un besoins de remboursement ou de payment');
        }


        if (sub.DateFinContrat__c == null) {
            throw new RTException(RTExceptionCode.ERREUR_ANNUL_DESABO_DATEFINCONTRAT_VIDE);
        }

        //Verifier si on a depasse le mois de latence et le statut du contrat
        Integer periodeLatence = Integer.valueOf(Utils.getUgcGenericParam('Periode de latence',acc.CodePays__c).ParamValue__c);

        // calcul dateLatence
        if (sub.Zuora__Status__c == 'Active' && sub.DateFinContrat__c != null){ //contrat en futur Cancel
            dateLatence = sub.DateFinContrat__c.addMonths(periodeLatence);
        }else if (sub.Zuora__Status__c == 'Cancelled') { // contrat deja cancelled
            dateLatence = sub.Zuora__CancelledDate__c.addMonths(periodeLatence);            
        }
        System.debug('MBEN dateLatence: ' + dateLatence);



        if (sub.Zuora__Status__c == 'Active') {
            if (sub.TypeContrat__c == 'CDI') {
            // continue
            }else if (sub.TypeContrat__c == 'CDD'){                
                // if (sub.DateFinContrat__c.addDays(1) == sub.Zuora__SubscriptionEndDate__c){ //aucun desabo n existe sur ce contrat 
                if (sub.CodeFinContrat__c == null){
                    throw new RTException(RTExceptionCode.ERREUR_ANNUL_DESABO_CONTRAT_DEJA_ACTIF);
                }else {
                // continue
                }
            }                                                     
        }else if (sub.Zuora__Status__c == 'Cancelled') {
            if (sub.TypeContrat__c == 'CDI'){
                if (Date.today() >= dateLatence){
                    throw new RTException(RTExceptionCode.ERREUR_ANNUL_DESABO_PERIODLATENCE_DEPASSE);
                }
            }else if (sub.TypeContrat__c == 'CDD'){
                // en premier annes: NON
                // CDD aterme: NON
                throw new RTException(RTExceptionCode.ERREUR_ANNUL_DESABO_CDD_DEJA_INACTIF);
            }                
        }else {
            throw new RTException(RTExceptionCode.ERREUR_ANNUL_DESABO_STATUT_CONTRAT_NON_VALIDE);
        }        
    }
    
	

    
    private class MyException extends Exception {
    }
    
    
}