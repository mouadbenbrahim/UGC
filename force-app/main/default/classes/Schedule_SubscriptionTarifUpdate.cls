/**
 * Created by mouad on 19/06/2019.
 */

global class Schedule_SubscriptionTarifUpdate implements  Schedulable {

    global void execute(SchedulableContext SC) {

        Batch_SubscriptionTarifUpdate batch = new Batch_SubscriptionTarifUpdate('FR',1);

        database.executebatch(batch,2000);
    }


}