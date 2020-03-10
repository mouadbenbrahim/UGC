global with sharing class Schedule_ZDocDataPurge implements Schedulable {
 	
    global void execute(SchedulableContext SC) {
        Integer NbDays = 7;
        Integer BatchSize = 200;
       
        Batch_ZDocDataPurge batch = new Batch_ZDocDataPurge(NbDays);
        Database.executeBatch(batch,BatchSize);
    }
    
}