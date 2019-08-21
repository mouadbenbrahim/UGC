/**
 * Created by mouad on 02/02/2019.
 */

trigger PromoRemiseBeforeInsert on PromoRemise__c (before insert) {
/*
    system.debug('--#### canTrigger PromoRemiseBeforeInsert = '+PAD.canTrigger('SM_PromoRemise_Trig_PromoRemiseBeforeInsert')+', Force By Pass = '+!PAD.ApexForcedBypass.contains('PromoRemiseBeforeInsert')) ;

    if (PAD.canTrigger('PromoRemiseBeforeInsert') ) {
        // appel de  la classe APEX pour maj le case avec les information de l'objet custom contacts
        system.debug('--#### trigger Case before insert : appel de  la classe APEX PromoRemiseBeforeInsert');
        SM_PromoRemise.Trig_PromoRemiseBeforeInsert(Trigger.new);
    }
*/
}