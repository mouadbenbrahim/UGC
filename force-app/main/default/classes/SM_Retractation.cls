/**
 * Created by Mohamed on 04/12/2018.
 */

public without sharing class SM_Retractation {

    //Operation retractation
    public static void retractation (Id caseId) {
    
        if(caseId == null){
            throw new MyException('No Id Case found for Retractation');
        }
        Case c = [SELECT Id, Crit_re_14_jours_post_souscription__c, Crit_re_de_souscription_en_ligne__c , Crit_re_non_utilisation_de_la_carte__c FROM Case WHERE Id =:caseId].get(0);
        
        if(!c.Crit_re_14_jours_post_souscription__c   || !c.Crit_re_de_souscription_en_ligne__c || !c.Crit_re_non_utilisation_de_la_carte__c ){
            System.debug('##MNE SM003_Retention retention field empty >> "Offre de rétention", "Raison de désabonnement" et "Résultat Rétention"');
            throw new MyException('Si les trois critères ne sont pas remplies, la rétractation n\'est pas possible');
        }
        SM_Desabonnement.desabonner(caseId);
    }

    private class MyException extends Exception {
    }

}