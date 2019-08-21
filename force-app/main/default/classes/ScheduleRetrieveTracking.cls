global class ScheduleRetrieveTracking Implements Schedulable
{
    global void execute(SchedulableContext sc)
    {
        DataExtension_Batch batch = new DataExtension_Batch(false,'');
        Database.ExecuteBatch(batch ,Integer.valueOf(label.MC_BatchSize));
    }
}