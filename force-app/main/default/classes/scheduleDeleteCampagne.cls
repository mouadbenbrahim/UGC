global class scheduleDeleteCampagne implements Schedulable{
   global void execute(SchedulableContext sc) {

      DeleteCampaignBatch batch = new DeleteCampaignBatch();
	
      database.executebatch(batch);

   }

}