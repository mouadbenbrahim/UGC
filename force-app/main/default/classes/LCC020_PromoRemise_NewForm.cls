public with sharing class LCC020_PromoRemise_NewForm {

    @AuraEnabled
    public static String initApexMethod(String promoRT){
        // no return
        return [SELECT Id FROM RecordType WHERE SobjectType='PromoRemise__c' AND Name = :promoRT LIMIT 1].Id;
    }

    @AuraEnabled
    public static ProdRatePlanCharge__c getCharge(String chargeId){

        // return [SELECT Id, Name, Reference__c, FamilleRPC__c FROM ProdRatePlanCharge__c where Id = :chargeId LIMIT 1];


        Return [SELECT Id, Name, Reference__c, FamilleRPC__c, EligibleOffre__c FROM ProdRatePlanCharge__c where Id = :chargeId LIMIT 1];
        // myId = [SELECT Id FROM ProdRatePlanCharge__c where Id = :chargeId LIMIT 1].Id;


    }

}