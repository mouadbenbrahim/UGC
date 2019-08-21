/**
 * Created by Valera on 02.10.2017.
 */

@IsTest
private class CaseOutboundCall_Test {
    static testMethod void testParse() {
        String json = '{\"error\":\"true\",\"errormsg\":\"error message\",\"callid\":\"V44200917100200ffaf9\"}';
        CaseOutboundCall r = CaseOutboundCall.parse(json);
        System.assert(r != null);

        json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
        CaseOutboundCall CaseOutbound = CaseOutboundCall.parse(json);
        System.assert(CaseOutbound != null);
        System.assert(CaseOutbound.error == null);
        System.assert(CaseOutbound.errormsg == null);
        System.assert(CaseOutbound.callid == null);

    }
}