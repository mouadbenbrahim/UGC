/**
 * Created by mouad on 02/11/2018.
 */

trigger OffreAfterInsert on Offre__c (after insert) {

    Boolean canTrigger = PAD.canTrigger('OffreAfterInsert ');

    if (canTrigger) {
        system.debug( '##MBE OffreAfterInsert trigger Begin');
        SM_Offre.Trig_OffreAfterInsert(Trigger.new);
    }
}