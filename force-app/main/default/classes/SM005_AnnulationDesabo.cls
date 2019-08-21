/**
 * Created by EasyFront on 20/05/2019.
 */

public without sharing class SM005_AnnulationDesabo {
	
	public static void AnnulerDesabo(Id ddeId) {
    	system.debug('##MNE SM005_AnnulationDesabo AnnulerDesabo ddeId >> '+ddeId);
    	
    	Case dem = SM_Demande.getDemande(ddeId);

        if (dem.Subscription__c == null) {
            throw new MyException('Abonnement absent de la demande: pas dabo, plusieurs ou inactif');
        }
        
        Id subscriptionId = dem.Subscription__c;
        Id accId = dem.AccountId;
        
        Zuora__Subscription__c sub = SM_Subscription.getSubscription(subscriptionId);
    	Account acc = SM_Account.getAccount(accId);
    	String zEntityId = WS001_CallZuora.getZuoraEntityId(acc.CodePays__c);
    	
    	verifAnnulerDesabo(dem, acc, sub);
    	
    	WSZ.AmendOut rep = SM_Amendment.getAmendment(sub.Zuora__Zuora_Id__c, zEntityId);

		system.debug('##MNE SM005_AnnulationDesabo AnnulerDesabo type >> '+rep.typeX);
		system.debug('##MNE SM005_AnnulationDesabo AnnulerDesabo status >> '+rep.status);
		system.debug('##MNE SM005_AnnulationDesabo AnnulerDesabo newSubscriptionId >> '+rep.newSubscriptionId);
		system.debug('##MNE SM005_AnnulationDesabo AnnulerDesabo id >> '+rep.id);
		system.debug('##MNE SM005_AnnulationDesabo AnnulerDesabo code >> '+rep.code);
		
		if (rep.typeX != 'Cancellation') {
            throw new MyException('Le dernier Amend n\'est pas un Amend de type Cancellation');
        }
        if (rep.status != 'Completed') {
            throw new MyException('Le dernier Amend n\'est pas Completed');
        }
        
        list<String> listAmendId = new list<String>();
        listAmendId.add(rep.id);
        list<WSZ.DeleteOut> deleteRep =  SM_Subscription.deleteZObject(listAmendId, 'Amendment', zEntityId);
    	
    	
    }
    
    private static void verifAnnulerDesabo(Case dem, Account acc, Zuora__Subscription__c sub) {

        if (dem.Status == SM_Demande.getStatus('Fermee')) {
            throw new MyException('Cette demande a deja ete traite');
        }

        if (dem.SousMotif__c == null) {
            throw new MyException('Sous-Motif obligatoire');
        }
        
        if(sub.Zuora__PreviousSubscriptionId__c == sub.Zuora__Zuora_Id__c){
        	throw new MyException('La souscription est l\'original, elle ne possède aucun desabonnement.');
        }
        
        if(sub.Zuora__CustomerAccount__r.Zuora__Balance__c != 0){
        	throw new MyException('La balance du compte zuora n\'est pas à 0');
        }
        
        if(sub.Tech_AvecRembouesement__c == 'true'){
        	throw new MyException('Cet amend est suivie par un besoins de remboursement ou de payment');
        }
        
    }
    
	

    
    private class MyException extends Exception {
    }
    
    
}