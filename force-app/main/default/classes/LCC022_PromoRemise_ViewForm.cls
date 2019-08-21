/**
 * Created by mouad on 15/01/2019.
 */

public with sharing class LCC022_PromoRemise_ViewForm {

    @AuraEnabled
    public static PromoRemise__c getCharge (String promoRemiseId){
        // no return
        return [SELECT Id, Charge__r.Reference__c FROM PromoRemise__c WHERE Id=:promoRemiseId LIMIT 1];
    }

}