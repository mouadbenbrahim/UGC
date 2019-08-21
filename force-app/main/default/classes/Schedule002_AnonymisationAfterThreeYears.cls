global class Schedule002_AnonymisationAfterThreeYears implements Schedulable{

   global void execute(SchedulableContext sc) {

      AccountUpdaterBatch batch = new AccountUpdaterBatch();
    
      database.executebatch(batch);

   }
}