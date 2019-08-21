public class Sched_SurveillanceEtAlerteSousMotifs implements Schedulable  {
	
    public void execute(SchedulableContext SC) {
        Batch_SurveillanceEtAlerteSousMotifs batch = new Batch_SurveillanceEtAlerteSousMotifs();
        Database.executeBatch(batch);
    }
}