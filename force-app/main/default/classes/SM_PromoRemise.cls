/**
 * Created by mouad on 02/02/2019.
 */

public with sharing class SM_PromoRemise {

    public static void Trig_PromoRemiseBeforeInsert(List<PromoRemise__c> promoRemises)
    {

/*            for (PromoRemise__c promoRemise : promoRemises) {

                String promoRT = [SELECT RecordType.Name FROM Promo__c WHERE Id = :promoRemise.Promo__c LIMIT 1].RecordType.Name;
                //System.debug('MBEN: Trig_PromoRemiseBeforeInsert11: ' + promoRT);
                System.debug('MBEN: Trig_PromoRemiseBeforeInsert12: ' + promoRemise.Promo__r.Id);
                System.debug('MBEN: Trig_PromoRemiseBeforeInsert13: ' + promoRemise.Promo__c);
                promoRemise.RecordTypeId = [SELECT Id FROM RecordType WHERE SobjectType='PromoRemise__c' AND Name = :promoRT LIMIT 1].Id;

                System.debug('MBEN: Trig_PromoRemiseBeforeInsert2');
            }*/


    }

}