/**
 * Created by mouad on 20/11/2018.
 */

trigger OffreBeforeDelete on Offre__c (before delete) {

    Boolean canTrigger = PAD.canTrigger('OffreBeforeDelete');
    if (canTrigger) {
        SM_Offre.Trig_OffreBeforeDelete(Trigger.oldMap);
    }

}