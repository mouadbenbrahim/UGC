/**
 * Created by mouad on 08/01/2019.
 */

public with sharing class LCC019_NewPromoRemise {

    @AuraEnabled
    public static String initApexMethod(String promoRT){
        // no return
        return [SELECT Id FROM RecordType WHERE SobjectType='PromoRemise__c' AND Name = :promoRT LIMIT 1].Id;
    }

    @AuraEnabled
    public static ProdRatePlanCharge__c getCharge (String chargeId){
        // no return
        return [SELECT Id,Name,Reference__c FROM ProdRatePlanCharge__c WHERE Id=:chargeId LIMIT 1];
    }

}