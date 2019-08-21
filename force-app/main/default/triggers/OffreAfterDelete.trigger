/**
 * Created by mouad on 16/11/2018.
 */

trigger OffreAfterDelete on Offre__c (after delete) {

    Boolean canTrigger = PAD.canTrigger('OffreAfterDelete');
    if (canTrigger) {
        SM_Offre.Trig_OffreAfterDelete(Trigger.oldMap);
    }
}