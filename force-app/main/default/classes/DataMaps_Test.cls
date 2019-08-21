/**
 * Created by Valera on 06.10.2017.
 */

@IsTest
private class DataMaps_Test {
    static testMethod void testGetColor() {
        Test.startTest();
        List<String> labelList = DataMaps.labelList;
        String status = DataMaps.getColor('1');
        System.assertEquals(status,' incoming-call');
        status = DataMaps.getColor('2');
        System.assertEquals(status,' outgoing-call');
        status = DataMaps.getColor('3');
        System.assertEquals(status,' webcallback-call');
        Test.stopTest();
    }
}