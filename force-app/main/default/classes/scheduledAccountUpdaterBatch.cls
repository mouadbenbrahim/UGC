global class scheduledAccountUpdaterBatch implements Schedulable{

   global void execute(SchedulableContext sc) {

      AccountUpdaterBatch batch = new AccountUpdaterBatch();
	
      database.executebatch(batch);

   }


}