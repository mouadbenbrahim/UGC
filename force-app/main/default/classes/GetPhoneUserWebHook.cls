/**
 * Created by Valera on 03.10.2017.
 */
@RestResource(urlMapping='/PhoneUser/*')
global with sharing class GetPhoneUserWebHook {

    public static String jsonRequest = '{"phone_number": "(512) 757-6000"}';

    @HttpPost
    global static void getUserByPhone() {
        List<PhoneUserContact> arrayPhoneUser = new List<PhoneUserContact>();
        Map<String, String> finalResponse = new Map<String, String>();
        RestRequest req = RestContext.request;
        String callReturnJson = req.requestbody.tostring();
        RestResponse response = RestContext.response;
        response.addHeader('Content-Type', 'application/json');
        String paramvalue;
        if (String.isEmpty(callReturnJson)) {
            response.responseBody = Blob.valueOf(formatJsonResponseError(true, 'request body is empty'));
            return ;
        }
        Map<String, Object> requestBody = (Map<String, Object>) JSON.deserializeUntyped(callReturnJson);
        if (String.isEmpty(String.valueOf(requestBody.get('phone_number')))) {
            response.responseBody = Blob.valueOf(formatJsonResponseError(true, 'request body is empty'));
            return;
        }

        String phoneNumber = String.valueOf(requestBody.get('phone_number'));
        fullingArrayPhoneUser(arrayPhoneUser, phoneNumber);
        if (arrayPhoneUser.size() == 0) {
            response.responseBody = Blob.valueOf(formatJsonResponseError(true, 'current phone not exist or phone number is not correct'));
            return;
        }
        response.responseBody = Blob.valueOf(formatJsonResponseCorrect(false, String.valueOf(requestBody.get('phone_number')), arrayPhoneUser));
        System.debug(response.responseBody.toString());
    }

    private static String formatJsonResponseError(Boolean error, String message) {
        GetPhoneUserWebHook.ResponseBodyPhoneUser finalResponse = new GetPhoneUserWebHook.ResponseBodyPhoneUser(error, message);
        return JSON.serialize(finalResponse);
    }

    private static String formatJsonResponseCorrect(Boolean error, String tephone, List<PhoneUserContact> arrayPhoneUser) {
        GetPhoneUserWebHook.ResponseBodyPhoneUser finalResponse = new GetPhoneUserWebHook.ResponseBodyPhoneUser(error
        , tephone
        , arrayPhoneUser);
        return JSON.serializePretty(finalResponse);

    }

    private static void fullingArrayPhoneUser(List<PhoneUserContact> arrayPhoneUser, String phoneNumber) {
        List<Contact> contacts = allRecords('Contact', phoneNumber);
        List<Account> accounts = allRecords('Account', phoneNumber);
        List<Lead> leads = allRecords('Lead', phoneNumber);
        List<Account> personalAccounts = new List<Account>();

        if (Schema.sObjectType.Account.fields.getMap().containsKey('isPersonAccount')) {
            if (!contacts.isEmpty() && !accounts.isEmpty()) {
                Map <Id, Contact> mapContact = new Map<Id, Contact>(contacts);
                Map <Id, Account> mapAccount = new Map<Id, Account>(accounts);
                for (Account acc : accounts) {
                    if (!String.isEmpty((Id) acc.get('PersonContactId')) && (Boolean) acc.get('isPersonAccount')) {
                        mapContact.remove((Id) acc.get('PersonContactId'));
                        mapAccount.remove(acc.Id);
                        personalAccounts.add(acc);
                    }
                }
                contacts = mapContact.values();
                accounts = mapAccount.values();
            }
        }
        if (!contacts.isEmpty()) {
            arrayPhoneUser.addAll(initContactRecord(contacts));
        }
        if (!accounts.isEmpty()) {
            arrayPhoneUser.addAll(initContactRecord(accounts));
        }
        if (!leads.isEmpty()) {
            arrayPhoneUser.addAll(initContactRecord(leads));
        }
        if (!personalAccounts.isEmpty()) {
            arrayPhoneUser.addAll(initContactRecord(personalAccounts));
        }
    }

    private static List<PhoneUserContact> initContactRecord(List<SObject> objects) {
        List<PhoneUserContact> arrayPhoneUsers = new List<PhoneUserContact>();
        if (objects.isEmpty()) {
            return arrayPhoneUsers;
        }
        Map<Id, User> foundUsersForContacts = getUsersByUserId(objects);
        for (SObject obj : objects) {
            Id objectId = (Id) obj.get('Id');
            User userOwner = foundUsersForContacts.get((Id) obj.get('OwnerId'));
            Boolean isPersonAcc = false;
            if (obj.getSObjectType().getDescribe().getName() == 'Account'
                    && Schema.sObjectType.Account.fields.getMap().containsKey('isPersonAccount')) {
                isPersonAcc = true;
            }
            PhoneUserContact newUserContact = makePhoneUserContact(objectId, userOwner, isPersonAcc);
            arrayPhoneUsers.add(newUserContact);
        }
        return arrayPhoneUsers;
    }

    private static Map<Id, User> getUsersByUserId(List<SObject> objects) {
        Map<Id, User> foundUsersForContacts = new Map<Id, User>();
        Set<Id> usersId = new Set<Id>();
        for (SObject sobj : objects) {
            usersId.add((Id) sobj.get('OwnerId'));
        }
        if (usersId.isEmpty()) {
            return foundUsersForContacts;
        }
        foundUsersForContacts = new Map<Id, User>([
                SELECT Id
                        , Agent_Id__c
                        , Group_Id_Outbound__c
                        , Service_Id__c
                        , Group_id_Inbound__c
                FROM User
                WHERE Id IN :usersId
        ]);
        return foundUsersForContacts;
    }

    private static PhoneUserContact makePhoneUserContact(Id objectId, User userOwner, Boolean isPersonAcc) {
        String type = objectId.getSobjectType().getDescribe().name;
        if (isPersonAcc) {
            type = 'PersonAccount';
        }
        return new PhoneUserContact(
                objectId,
                type, //objectId.getSobjectType().getDescribe().name,
                userOwner.Agent_Id__c,
                userOwner.Service_Id__c,
                userOwner.Group_id_Inbound__c
        );
    }

    public static List<SObject> allRecords(String obj, String phoneNumber) {
        String fieldsAdditional = '';
        String queryAllRecords = '';
        if (obj.equals('Account')) {
            if (Schema.sObjectType.Account.fields.getMap().containsKey('isPersonAccount')) {
                fieldsAdditional = ', PersonContactId, isPersonAccount';
            }
            queryAllRecords = 'SELECT Id, OwnerId ' + fieldsAdditional + ' FROM ' + obj + ' WHERE Phone LIKE ' + '\'%' + phoneNumber + '\' LIMIT 10000';
        } else if (obj.equals('Contact')) {
            queryAllRecords = 'SELECT Id, OwnerId, MobilePhone, Fax, AssistantPhone, HomePhone, OtherPhone, Phone FROM Contact WHERE '
                    + 'Phone LIKE ' + '\'%' + phoneNumber
                    + '\' OR MobilePhone  LIKE ' + '\'%' + phoneNumber
                    + '\' OR Fax  LIKE ' + '\'%' + phoneNumber
                    + '\' OR AssistantPhone  LIKE ' + '\'%' + phoneNumber
                    + '\' OR HomePhone  LIKE ' + '\'%' + phoneNumber
                    + '\' OR OtherPhone  LIKE ' + '\'%' + phoneNumber
                    + '\' LIMIT 10000';
        } else if (obj.equals('Lead')) {
            queryAllRecords = 'SELECT Id, OwnerId, MobilePhone, Fax, Phone FROM Lead WHERE '
                    + 'Phone LIKE ' + '\'%' + phoneNumber
                    + '\' OR MobilePhone  LIKE ' + '\'%' + phoneNumber
                    + '\' OR Fax  LIKE ' + '\'%' + phoneNumber
                    + '\' LIMIT 10000';
        }
        return Database.query(queryAllRecords);
    }

//    public static List<Contact> allRecordsForContact(String phoneNumber) {
//        return [
//                SELECT
//                        Id
//                        , MobilePhone
//                        , Fax
//                        , AssistantPhone
//                        , HomePhone
//                        , OtherPhone
//                        , Phone
//                FROM Contact
//                WHERE Phone LIKE :'%' + phoneNumber
//                OR MobilePhone LIKE :'%' + phoneNumber
//                OR Fax LIKE :'%' + phoneNumber
//                OR AssistantPhone LIKE :'%' + phoneNumber
//                OR HomePhone LIKE :'%' + phoneNumber
//                OR OtherPhone LIKE :'%' + phoneNumber
//        ];
//    }
//
//    public static List<Lead> allRecordsForLead(String phoneNumber) {
//        return [
//                SELECT
//                        Id
//                        , MobilePhone
//                        , Fax
//                        , Phone
//                FROM Lead
//                WHERE Phone LIKE :'%' + phoneNumber
//                OR MobilePhone LIKE :'%' + phoneNumber
//                OR Fax LIKE :'%' + phoneNumber
//        ];
//    }

    public class ResponseBodyPhoneUser {

        public Boolean error { get; set; }
        public String phone { get; set; }
        public List<PhoneUserContact> contacts { get; set; }
        public String message { get; set; }

        public ResponseBodyPhoneUser(Boolean error, String message) {
            this.error = error;
            this.message = message;
        }
        public ResponseBodyPhoneUser(Boolean error
                , String phone
                , List<PhoneUserContact> contacts) {
            this.error = error;
            this.phone = phone;
            this.contacts = contacts;
        }

        public ResponseBodyPhoneUser parse(String json) {
            return (ResponseBodyPhoneUser) System.JSON.deserialize(json, ResponseBodyPhoneUser.class);
        }
    }
}