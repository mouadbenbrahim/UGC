/**
 * Created by mouad on 12/01/2019.
 */

public with sharing class LCC023_PromoRemise_NewEditForm {

    @AuraEnabled
    public static ProdRatePlanCharge__c getCharge (String chargeId){
        // no return
        return [SELECT Id,Name,Reference__c FROM ProdRatePlanCharge__c WHERE Id=:chargeId LIMIT 1];
    }


    @AuraEnabled
    public static String getPromoRemiseRTid(Id promoId){
        // no return
        String promoRT = [SELECT RecordType.Name FROM Promo__c WHERE Id = :promoId LIMIT 1].RecordType.Name;
        return [SELECT Id FROM RecordType WHERE SobjectType='PromoRemise__c'
        AND Name = :promoRT LIMIT 1].Id;
    }

}