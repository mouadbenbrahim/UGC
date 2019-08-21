/**
 * Created by Valera on 27.09.2017.
 */

@IsTest
@TestVisible
private class CaseIncomingCall_Test {

    @TestVisible
    private static String json = '{'+
            '  \"sf\": {'+
            '    \"phone\": 7852416200,'+
            '    \"contacts\": ['+
            '        {'+
            '            \"type\": \"Contact\",'+
            '            \"service_id\": null,'+
            '            \"id\": \"0030Y00000VCN2wQAH\",'+
            '            \"group_id\": null,'+
            '            \"agent_id\": null'+
            '        },'+
            '        {'+
            '            \"type\": \"Account\",'+
            '            \"service_id\": null,'+
            '            \"id\": \"0010Y00000anFKOQA2\",'+
            '            \"group_id\": null,'+
            '            \"agent_id\": null'+
            '        }'+
            '    ],'+
            '    \"organization_id\": \"00D0Y000002iyaOUAQ\",'+
            '    \"user_id\": \"0050Y000002wveiQAA\"'+
            '  },'+
            '  \"agent\": {'+
            '    \"id\": \"1003203\",'+
            '    \"sda\": \"0123456789\",'+
            '    \"status\": \"8\",'+
            '    \"name\": \"John Doe\",'+
            '    \"change_time\": \"2017-09-08 17:51:38\"'+
            '  },'+
            '  \"call\": {'+
            '    \"callid\": \"V44200717090800ffcba\",'+
            '    \"start_time\": \"2017-09-08 17:51:38\",'+
            '    \"agent_uid\": \"1003203\",'+
            '    \"status\": \"3\",'+
            '    \"change_time\": \"2017-09-08 17:51:38\",'+
            '    \"service_uid\": \"11089\",'+
            '    \"group_uid\": \"55522\",'+
            '    \"product_uid\": \"1\",'+
            '    \"sda\": \"7852416200\",'+
            '    \"ref\": \"Call test\"'+
            '  }'+
            '}';
    // This test method should give 100% coverage
    static testMethod void testParse() {

        CaseIncomingCall r = CaseIncomingCall.parse(json);
        System.assert(r != null);

        json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
        CaseIncomingCall.Agent objAgent = new CaseIncomingCall.Agent(System.JSON.createParser(json));
        System.assert(objAgent != null);
        System.assert(objAgent.id == null);
        System.assert(objAgent.sda == null);
        System.assert(objAgent.status == null);
        System.assert(objAgent.name == null);
        System.assert(objAgent.change_time == null);

        json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
        CaseIncomingCall.Call objCall = new CaseIncomingCall.Call(System.JSON.createParser(json));
        System.assert(objCall != null);
        System.assert(objCall.callid == null);
        System.assert(objCall.start_time == null);
        System.assert(objCall.agent_uid == null);
        System.assert(objCall.status == null);
        System.assert(objCall.change_time == null);
        System.assert(objCall.service_uid == null);
        System.assert(objCall.group_uid == null);
        System.assert(objCall.product_uid == null);
        System.assert(objCall.sda == null);
        System.assert(objCall.ref == null);

        json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
        CaseIncomingCall.Sf objSf = new CaseIncomingCall.Sf(System.JSON.createParser(json));
        System.assert(objSf != null);
        System.assert(objSf.contacts == null);
        System.assert(objSf.organization_id == null);
        System.assert(objSf.user_id == null);

        json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
        CaseIncomingCall.Contacts objContacts = new CaseIncomingCall.Contacts(System.JSON.createParser(json));
        System.assert(objContacts != null);
        System.assert(objContacts.type_Z == null);
        System.assert(objContacts.service_id == null);
        System.assert(objContacts.id == null);
        System.assert(objContacts.group_id == null);
        System.assert(objContacts.agent_id == null);

        json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
        CaseIncomingCall objCaseIncomingCall = new CaseIncomingCall(System.JSON.createParser(json));
        System.assert(objCaseIncomingCall != null);
        System.assert(objCaseIncomingCall.sf == null);
        System.assert(objCaseIncomingCall.agent == null);
        System.assert(objCaseIncomingCall.call == null);
    }

    private static testMethod void initSerchContacts() {
        CaseIncomingCall.Sf sfTest = new CaseIncomingCall.Sf();
        sfTest.getContactIds();
        System.assert(sfTest.contacts == null);
        CaseIncomingCall.Contacts serchRecord = new CaseIncomingCall.Contacts();
        serchRecord.id = '123456789';
        sfTest.contacts = new List<CaseIncomingCall.Contacts>();
        sfTest.contacts.add(serchRecord);
        sfTest.getContactIds();
    }
}