/**
 * Created by mouad on 12/01/2019.
 */

public with sharing class LCC021_PromoRemise_EditForm {

    @AuraEnabled
    public static ProdRatePlanCharge__c getCharge (String chargeId){
        // no return
        return [SELECT Id,Name,Reference__c FROM ProdRatePlanCharge__c WHERE Id=:chargeId LIMIT 1];
    }

}