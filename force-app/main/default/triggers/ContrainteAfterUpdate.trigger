/**
 * Created by mouad on 02/11/2018.
 */

trigger ContrainteAfterUpdate on OffreContrainte__c (after update) {

    Boolean canTrigger = PAD.canTrigger('ContrainteAfterUpdate');

    if (canTrigger) {
        system.debug( '##MBE ContrainteAfterUpdate trigger Begin');
        SM_Offre.Trig_ContrainteAfterUpdate(Trigger.oldMap, Trigger.new);
    }

}