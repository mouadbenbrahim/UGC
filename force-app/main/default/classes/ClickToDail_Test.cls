/**
 * Created by Valera on 28.09.2017.
 */

@IsTest
private class ClickToDail_Test {
    // This test method should give 100% coverage
    static testMethod void testParse() {
        String json = '{\"number\":\"(785) 241-6200\",\"objectId\":\"0010Y00000cegka\",\"objectName\":\"Dickenson plc\",\"object\":\"Account\",\"displayName\":\"Account\"}';
        String jsonErrorFalse = '{"error": false,"callid": "V44200917100200ffaf9"}';
        ClickToDail r = ClickToDail.parse(json);
        ClickToDail r2 = ClickToDail.parse(jsonErrorFalse);
        System.assert(r != null);
        System.assert(r2 != null);

        json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
        ClickToDail objClickToDail = new ClickToDail(System.JSON.createParser(json));
        System.assert(objClickToDail != null);
        System.assert(objClickToDail.number_Z == null);
        System.assert(objClickToDail.objectId == null);
        System.assert(objClickToDail.objectName == null);
        System.assert(objClickToDail.object_Z == null);
        System.assert(objClickToDail.displayName == null);
        System.assert(objClickToDail.error == null);
        System.assert(objClickToDail.callid == null);
    }
}