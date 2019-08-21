/**
 * Created by Valera on 02.10.2017.
 */

@IsTest
private class EventPageController_Test {
    static testMethod void testEdit() {
        EventPageController pageController = new EventPageController();
        TelephonyBoardController telephonyController = new TelephonyBoardController();
        telephonyController.callEvent = initEvent();
        pageController.telephonyBoardCntr = telephonyController;
        pageController.disableTextArea = true;
        pageController.setDescription('new description');
        pageController.logSet = true;
        pageController.addText();
        System.assertEquals(pageController.disableTextArea, false);
        System.assertEquals(pageController.logSet, false);
        pageController.setDisableTextArea(true);
        pageController.setLogSet(true);
        System.assertEquals(pageController.getDisableTextArea(), true);
        System.assertEquals(pageController.getLogSet(), true);
        pageController.saveEvent();
        pageController.lastEvt = initOldEvent();
        pageController.getDescription();
    }
    public static Event initEvent() {
        Event event = new Event(Subject = 'Call', StartDateTime = Datetime.now(), EndDateTime = Datetime.now().addMinutes(2), Description = 'test description', Call_External_Id__c = 'V44200717091100ffccb', sda__c = 'ETST NAME');
        insert event;
        return event;
    }
    public static Event initOldEvent() {
        Event event = new Event(Subject = 'Call', StartDateTime = Datetime.now(), EndDateTime = Datetime.now().addMinutes(2), Description = 'test description Old', Call_External_Id__c = 'V44200717091100ffcff', sda__c = 'TEST');
        insert event;
        return event;
    }

}