/**
 * Created by Valera on 05.10.2017.
 */

@IsTest
private class GetPhoneUserWebHook_Test {
    private static String jsonRequest = '{"phone_number": "(098) 407-3751"}';
    private static String emptyPhone = '{"phone_number": ""}';

    static testMethod void testEmptyPhoneSF() {
        createTestContactEmptyPhone();
        String result = initService(jsonRequest);
    }

    static testMethod void testGetUserByPhone() {
        createTestContact();
        String result = initService(jsonRequest);
    }

    static testMethod void testEmptyPhoneRequest() {
        createTestContactEmptyPhone();
        String result = initService(emptyPhone);
    }

    static testMethod void testGetUserByPhoneFewContact() {
        createTestContact();
        createTestContactTwo();
        String result = initService(jsonRequest);
    }

    static Id createTestContact() {
        Account account = new Account(Name = 'Test Name', Phone = '(098) 407-3751');
        insert account;
        return account.Id;
    }

    static void createTestContactTwo(){
        Contact contact = new Contact(LastName = 'Test Name One', Phone = '(098) 407-3751');
        Contact contact2 = new Contact(LastName = 'Test Name Two', Phone = '(098) 407-3751');
        insert contact;
        insert contact2;
    }

    static void createTestContactEmptyPhone() {
        Account account = new Account(Name = 'Test Name');
        insert account;
    }

    static String  initService(String requestBody){
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        request.requestUri = 'https://eu11.salesforce.com/services/apexrest/PhoneUser/';
        request.httpMethod = 'POST';
        request.requestBody = Blob.valueOf(requestBody);
        request.addHeader('Content-Type', 'application/json');
        response.addHeader('Content-Type', 'application/json');
        RestContext.request = request;
        RestContext.response = response;
        Test.startTest();
        GetPhoneUserWebHook.getUserByPhone();
        Test.stopTest();
        String finalresponse = response.responseBody.toString();
        return (String) System.JSON.deserialize(finalresponse, String.class);
    }
}