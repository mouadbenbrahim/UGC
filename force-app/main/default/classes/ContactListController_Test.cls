/**
 * Created by Valera on 02.10.2017.
 */

@IsTest
private class ContactListController_Test {
    static testMethod void testContact() {
        List<Contact> contacts = initCintact('Contact');
        System.assertEquals(contacts.size(), 1);
    }
    static testMethod void testLead() {
        List<Lead> leads = initCintact('Lead');
        System.assertEquals(leads.size(), 1);
    }

    public static List<SObject> initCintact(String nameObject){
        List<SObject> sObjects = allRecords(nameObject);
        ContactListController listController = new ContactListController();
        listController.evt = initEvent();
        System.assertEquals(sObjects.size(), 0);
        listController.contacts = allRecords(nameObject);
        if(nameObject == 'Lead') {
            listController.createLead();
        }else if(nameObject == 'Contact'){
            listController.createContact();
        }
        sObjects = allRecords(nameObject);
        return sObjects;

    }
    static testMethod void testAccount() {
        List<Account> accounts = allRecords('Account');
        ContactListController listController = new ContactListController();
        listController.evt = initEvent();
        System.assertEquals(accounts.size(), 0);
        listController.contacts = allRecords('Account');
        listController.createAccount();
        accounts = allRecords('Account');
        System.assertEquals(accounts.size(), 1);
    }

    static testMethod void testBindEventWithAccount() {
        ContactListController listController = new ContactListController();
        listController.evt = initEvent();
        listController.contactId = initAccount();
        listController.contacts = allRecords('Account');
        Test.startTest();
        listController.bindEventWithContact();
        Test.stopTest();
    }
    static testMethod void testBindEventWithLead() {
        ContactListController listController = new ContactListController();
        listController.evt = initEvent();
        listController.contactId = initLead();
        listController.contacts = allRecords('Lead');
        Test.startTest();
        listController.bindEventWithContact();
        Test.stopTest();
    }

    public static Id initAccount() {
        Account account = new Account(Name = 'Test_Name');
        insert account;
        return account.Id;
    }

    public static Id initLead() {
        Lead lead = new Lead(LastName = 'Test_Name',FirstName = 'Test_Name', Company = 'Test_Company', Status = 'Open - Not Contacted');
        insert lead;
        return lead.Id;
    }

    public static Event initEvent() {
        Event event = new Event(Subject = 'Call', StartDateTime = Datetime.now(), EndDateTime = Datetime.now().addMinutes(2), Call_External_Id__c = 'V44200717091100ffccb', sda__c = 'ETST NAME');
        insert event;
        return event;
    }

    public static List<SObject> allRecords(String obj) {
        String queryAllRecords;
        if (obj == 'Account') {
            queryAllRecords = 'SELECT id, Name FROM ' + obj;
        } else if (obj == 'Contact' || obj == 'Lead') {
            queryAllRecords = 'SELECT id, LastName,FirstName FROM ' + obj;
        }
        return Database.query(queryAllRecords);
    }
}