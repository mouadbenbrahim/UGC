@isTest public class ScheduleRetrieveTracking_Test {
    
@isTest public static void testschedule() {
Test.StartTest();
ScheduleRetrieveTracking sh1 = new ScheduleRetrieveTracking();

String sch = '0 0 23 * * ?';
system.schedule('Test Territory Check', sch, sh1); Test.stopTest();
}

    
}