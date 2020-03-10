public with sharing class ContactListController {
    private static String PERSON_ACCOUNT = Label.PersonAccount;
    public Event evt { get; set; }
    public List<String> typeObj { get; set; }
    public String contactId { get; set; }
    public List<SObject> contacts {
        get;
        set {
            System.debug('#### FLE value : ' + value);
            contacts = value;
            infoForTableComponent = new Map<String, List<ContactWrap>>();
            fillingMapForTableInInfoComponent(contacts);
        }
    }
    public Map<String, List<ContactWrap>> infoForTableComponent { get; set; }
    public TelephonyBoardController telephonyBoardCntr { get; set; }

    public PageReference createContact() {
        try {
            crContact();
            upsert evt;
        } catch (DmlException e) {
            try {
                crContact();
                evt.WhatId = null;
                evt.Id = null;
                insert evt;
            } catch (Exception ex) {
                telephonyBoardCntr.showError(new MyCustomException(new MyCustomException(ex.getMessage())));
            }
        }
        return null;
    }

    public class ContactWrap {
        public String type { get; set; }
        public String name { get; set; }
        public SObject obj { get; set; }
        public ContactWrap(String type, String name, SObject obj) {
            this.type = type;
            this.name = name;
            this.obj = obj;
        }
    }
    public void createAccount() {
        try {
            crAccount();
            upsert evt;
        } catch (DmlException e) {
            try {
                crAccount();
                evt.WhoId = null;
                evt.Id = null;
                insert evt;
            } catch (Exception ex) {
                telephonyBoardCntr.showError(new MyCustomException(new MyCustomException(ex.getMessage())));
            }
        } catch (Exception exp) {
            telephonyBoardCntr.showError(new MyCustomException(new MyCustomException(exp.getMessage())));
        }
    }

    public PageReference createLead() {
        try {
            crLead();
            upsert evt;
        } catch (DmlException e) {
            try {
                crLead();
                evt.WhatId = null;
                evt.Id = null;
                insert evt;
            } catch (Exception ex) {
                telephonyBoardCntr.showError(new MyCustomException(new MyCustomException(ex.getMessage())));
            }
        }
        return null;
    }

    public void bindEventWithContact() {
        try {
            List<Lead> leads = new List<Lead>();
            List<Account> accounts = [SELECT Id, Name FROM Account WHERE id = :contactId];
            evt.WhatId = null;
            evt.WhoId = null;

            if (!String.isEmpty(evt.whoId)) {
                leads = [SELECT id FROM Lead WHERE id = :evt.whoId];
            }
            if (leads.isEmpty()) {
                if (!accounts.isEmpty()) {
                    evt.WhatId = accounts.get(0).id;
                } else {
                    evt.whoId = contactId;
                }
            } else {
                evt.whoId = contactId;
            }
            update evt;

            Map<Id, ContactWrap> mapContacts = new Map<Id, ContactWrap>();
            for (SObject obj : contacts) {
                if (obj.getSObjectType().getDescribe().getName() == 'Account'
                        && Schema.sObjectType.Account.fields.getMap().containsKey('isPersonAccount')) {
                    mapContacts.put(obj.Id, new ContactWrap(PERSON_ACCOUNT, setNameToObj(obj), obj));
                } else {
                    mapContacts.put(obj.Id, new ContactWrap(obj.getSObjectType().getDescribe().getLabel(), setNameToObj(obj), obj));
                }
            }
            contacts.clear();
            contacts.add(mapContacts.get(contactId).obj);
        } catch (DmlException ex) {
            contactId = null;
            contacts.clear();
        }
        system.debug('#### bindEventWithContact / contacts : ' + contacts);
    }

    private void refreshContacts(SObject cont) {
        contacts.clear();
        contacts.add(cont);
        this.refeshInfoForTableComponent(cont);
    }


    private void refeshInfoForTableComponent(SObject cont) {
        if (infoForTableComponent == null) {
            infoForTableComponent = new Map<String, List<ContactWrap>>();
        } else {
            infoForTableComponent.clear();
        }
        this.defineSlotSobjectInMap(cont);
    }

    private void defineSlotSobjectInMap(SObject cont) {
        String typeSObject = cont.getSObjectType().getDescribe().getName();
        if (!infoForTableComponent.containsKey(typeSObject)) {
            if (typeSObject == 'Account') {
                Account account = (Account) cont;
                if (Schema.sObjectType.Account.fields.getMap().containsKey('isPersonAccount')) {
                    infoForTableComponent.put(PERSON_ACCOUNT, new List<ContactWrap>{
                            new ContactWrap(typeSObject, account.Name, account)
                    });
                } else {
                    infoForTableComponent.put(typeSObject, new List<ContactWrap>{
                            new ContactWrap(typeSObject, account.Name, account)
                    });
                }
            } else if (typeSObject == 'Contact') {
                Contact contact = (Contact) cont;
                infoForTableComponent.put(typeSObject, new List<ContactWrap>{
                        new ContactWrap(typeSObject, contact.LastName, contact)
                });
            } else if (typeSObject == 'Lead') {
                Lead lead = (Lead) cont;
                infoForTableComponent.put(typeSObject, new List<ContactWrap>{
                        new ContactWrap(typeSObject, lead.LastName, lead)
                });
            }
        } else {
            if (typeSObject == 'Account') {
                Account account = (Account) cont;
                if (Schema.sObjectType.Account.fields.getMap().containsKey('isPersonAccount')) {
                    infoForTableComponent.get(PERSON_ACCOUNT).add(new ContactWrap(typeSObject, account.Name, account));
                } else {
                    infoForTableComponent.get('Account').add(new ContactWrap(typeSObject, account.Name, account));
                }
            } else if (typeSObject == 'Contact') {
                Contact contact = (Contact) cont;
                infoForTableComponent.get('Contact').add(new ContactWrap(typeSObject, contact.LastName, contact));
            } else if (typeSObject == 'Lead') {
                Lead lead = (Lead) cont;
                infoForTableComponent.get('Lead').add(new ContactWrap(typeSObject, lead.LastName, lead));
            }
        }
    }

    private String setNameToObj(SObject cont) {
        String name = '';
        if (cont.getSObjectType() == Contact.getSObjectType() || cont.getSObjectType() == Lead.getSObjectType()) {
            if (cont.get('FirstName') != null) {
                name = (String) cont.get('FirstName') + ' ';
            }
            name += (String) cont.get('LastName');
        } else {
            name = (String) cont.get('Name');
        }
        return name;
    }


    private void crLead() {
        Lead leadToCreate = new Lead(
                LastName = evt.sda__c,
                Company = evt.sda__c,
                Phone = evt.sda__c

        );
        insert leadToCreate;

        evt.whoId = leadToCreate.Id;
        contactId = evt.whoId;
        refreshContacts(leadToCreate);
    }
    private void crAccount() {
        /*Account accountToCreate = new Account(
                LastName = evt.sda__c,
                Phone = evt.sda__c, 
                RecordTypeId=Utils.getComptePersonelAccountRecordType().Id
        );*/
		
		Account accountToCreate = new Account(  LastName= evt.sda__c, 
										        Phone = evt.sda__c,
										        RecordTypeId = Utils.getComptePersonelAccountRecordType().Id,
										        PersonMobilePhone = evt.sda__c);		

        insert accountToCreate;
        evt.WhatId = accountToCreate.Id;
        contactId = evt.WhatId;
        refreshContacts(accountToCreate);
    }
    private void crContact() {
        Contact contactToCreate = new Contact(
                LastName = evt.sda__c,
                Phone = evt.sda__c
        );

        insert contactToCreate;

        evt.whoId = contactToCreate.Id;
        contactId = evt.whoId;
        refreshContacts(contactToCreate);
        System.debug('Event: ' + evt);
    }

    private void fillingMapForTableInInfoComponent(List<SObject> contacts) {
        system.debug('#### FLE fillingMapForTableInInfoComponent');
        system.debug('#### FLE contacts : ' + contacts);
        for (SObject contact : contacts) {
            this.defineSlotSobjectInMap(contact);
        }
    }
}