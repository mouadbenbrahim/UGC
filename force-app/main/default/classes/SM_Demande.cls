/**
 * Created by mouad on 30/08/2018.
 */

public with sharing class SM_Demande {

    public static String closeStatus(){
        String closeStatus = [SELECT MasterLabel FROM CaseStatus WHERE ApiName = 'Fermee'].MasterLabel;
        return closeStatus;
    }

    public static String getStatus(String status){
        String closeStatus = [SELECT MasterLabel FROM CaseStatus WHERE ApiName = :status].MasterLabel;
        return closeStatus;
    }


    public static Case getDemande(Id ddeId){

        Case demande = [
                SELECT Id, AccountId, ParentId, ContactId, Status, Famille__c, Motif__c, SousMotif__c, DateDemande__c, Pays__c,
                        Origin, MontantRembourser__c, MontantRemboursementCalc__c, RemboursementFaire__c, DemandeRemboursement2__c, Subscription__c, SubscriptionZName__c,
                        Date_fin_engagement__c, DateFinContrat__c, Date_de_D_sabonnement__c, Subscription__r.Zuora__SubscriptionStartDate__c, Type_de_d_sabonnement__c,
                        RecordTypeId, Date_de_R_siliation__c, Motif_de_R_siliation__c,Moyen_de_paiement_souhait__c,Raison_remboursement__c,
                        DateDeRemboursement__c, CreditMemoId__c, Payment__c, Payment__r.Id, Payment__r.Zuora__EXT_ID__c,
                        Mois_de_d_but_remise__c, MontantRemise__c, NombreDeMoisRemise__c, Pallier__c, CouponWelcomeback__c,Subscription__r.Zuora__Zuora_Id__c,Etat_remboursement__c,
                        Offre_de_r_tention__c, Raison_de_d_sabonnement__c, R_sultat_R_tention__c, TECHIdStatut__c
                FROM Case
                WHERE Id = :ddeId
        ];
        return demande; //TODO voir si c une passage en reference ou en valeur ?

    }

    public static Id creerRemboursement(Case demande) {

        demande.Famille__c = 'EF-Finance';
        demande.Motif__c = 'EF-Remboursement';

        insert demande;
        return demande.Id;
    }
    
    public static Date getRemiseDate(Integer moidDebutRemise){
        Date todayDate = Date.today();
        Integer todayYear = todayDate.year();
        
        Date dateRemise = Date.newInstance(todayYear, moidDebutRemise, 1);
        
        if(todayDate > dateRemise){
            dateRemise = dateRemise.addYears(1);
        }
        return dateRemise;
    }
    
    public static Date getDateMoisSuivant(Date currentDate){
    	Integer currentDateMonth = currentDate.month();
        Integer currentDateYear = currentDate.year();
        
        Date dateMoisSuivant = Date.newInstance(currentDateYear, currentDateMonth+1, 1);
        
        if(currentDate > dateMoisSuivant){
            dateMoisSuivant = dateMoisSuivant.addYears(1);
        }
        return dateMoisSuivant;
    }


}