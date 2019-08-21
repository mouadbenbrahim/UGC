@RestResource(urlMapping='/AlcmeonNotification/*')
global with sharing class AlcmeonNotificationHandler {
    
    private static Rejected_Notification__c getRN(Notification notif) {
        notif.oCase = null;
        Rejected_Notification__c rn = new Rejected_Notification__c();
        rn.json__c = JSON.serialize(notif);
        return rn;
    }
    

    @HttpPost
    global static String HandleCases() {
        system.debug('## AlcmeonNotificationHandler ## HandleCases start ');
        try {
            RestRequest req = RestContext.request;
            Blob jsonBlob = req.requestBody;
            system.debug('## AlcmeonNotificationHandler ## ' + jsonBlob);
            String jsonString = jsonBlob.toString();
            
            if(jsonString.trim() == '') {
                return 'OK';
            }
            system.debug('%% ASA jsonString = '+jsonString);
            List<Rejected_Notification__c> rejets = new List<Rejected_Notification__c>();
            
            // Deserialize the JSON string into collections of primitive data types.
            List<Object> jsonNotifications = (List<Object>) JSON.deserializeUntyped(jsonString);
            
            System.debug('--#### Notifications reçues = '+jsonNotifications);
            List<Notification> notifications = new List<Notification>();
            Rejected_Notification__c rejectedNotif;
            
            for (Object o: jsonNotifications) {
                
                Map<String,Object> mapNotif = (Map<String,Object>) o;
                Notification notif = parseNotification(mapNotif);
                System.debug('--#### Notification au format Salesforce : ' + notif);
                
                if(notif.notificationType == 'answer') {
                    notifications.add(notif);
                } else {
                    rejectedNotif = getRN(notif);
                    rejectedNotif.Code_erreur__c = 'ERR_HORS_SCOPE';
                    rejectedNotif.Message_erreur__c = 'Type de notification = '+notif.notificationType;
                    rejets.add(rejectedNotif);
                    System.debug('--#### Type de notification = '+notif.notificationType+', (différent de "answer") hors périmètre.');
                }
            }
            
            System.debug('--#### Nombre de notifications à traiter = '+notifications.size());
            if(notifications.size()>0){
                processNotifications(notifications);
            }
            
            insert rejets;
            
            return 'OK';
        } catch (Exception e) {
            // return new ReturnClass('error', e.getMessage(), null);
            System.debug('--#### AlcmeonNotificationHandler Exception : ' + e.getMessage() + '\n' + e.getStackTraceString());
            return 'error: ' + e.getMessage();
        }
    }
    
    public static void processNotifications(List<Notification> notifications) {
        
        List<Case> oCases = new List<Case>();
        Map<Case, Notification> mapCaseNot = new Map<Case, Notification>();
        List<Rejected_Notification__c> rejectedNotifs = new List<Rejected_Notification__c>();
        Map<String, Id> mapEmailUserId = new Map<String, Id>();
        Map<String, Contact> mapTwitter = new Map<String, Contact>();
        Map<String, Contact> mapFacebook = new Map<String, Contact>();
        Map<String, Contact> mapInstagram = new Map<String, Contact>();
        Map<String, Contact> mapCritizr = new Map<String, Contact>();
        Map<String, Contacts__c> mapMotifs = new Map<String, Contacts__c>();
        Rejected_Notification__c rejectedNotif;
        
        for(Notification notif: notifications) {
            mapEmailUserId.put(notif.userEmail, null);
            if(notif.alcmeonAccountId != null) {
                if(notif.alcmeonAccountType == 'twitter') {
                    mapTwitter.put(notif.alcmeonAccountId, null);
                } else if(notif.alcmeonAccountType == 'facebook') {
                    mapFacebook.put(notif.alcmeonAccountId, null);
                } else if(notif.alcmeonAccountType == 'instagram') {
                    mapInstagram.put(notif.alcmeonAccountId, null);
                } else if(notif.alcmeonAccountType == 'critizr') {
                    mapCritizr.put(notif.alcmeonAccountId, null);
                } 
            }
            
            // Identification des valeurs Alcméon
            if(notif.tags != null) {
                for(Tag tag: notif.tags) {
                    if(tag.name.fr == 'Motifs de contacts 2') {
                        mapMotifs.put(tag.value.fr, null);      // Correspond à la valeur Alcméon
                    }
                }
                
            }
        }
        
        // Récupération des valeurs Alcméons à partir des contacts
        List<Contacts__c> motifs = [SELECT Id, ValeurALCMEON__c, Famille_Statut__c, Motif_Statut__c, SousMotif_Statut__c
                                    FROM Contacts__c 
                                    WHERE ValeurALCMEON__c IN :mapMotifs.keySet() 
                                    ORDER BY SousMotif_Statut__c DESC, Motif_Statut__c DESC, Famille_Statut__c DESC];
       
        for(Contacts__c contacts: motifs) {
            mapMotifs.put(contacts.ValeurALCMEON__c, contacts);
        }

        
        // Récupération des contacts déjà identifiés par leurs identifiant du réseau sociale
        List<Contact> contacts = [SELECT Id, Account.Id, Account.TECH_idCritizr__c, Account.TECH_idInstagram__c, 
                                  Account.TECH_idTwitter__c, Account.TECH_idFacebook__c 
                                  FROM Contact
                                  WHERE Account.TECH_idCritizr__c IN :mapCritizr.keySet() OR  Account.TECH_idInstagram__c IN :mapInstagram.keySet()
                                  OR Account.TECH_idTwitter__c IN :mapTwitter.keySet() OR Account.TECH_idFacebook__c IN :mapFacebook.keySet() ];
        
        for(Contact contact: contacts) {
            
            if(contact.Account.TECH_idCritizr__c != null) {
                mapCritizr.put(contact.Account.TECH_idCritizr__c, contact);
               
            }
            if(contact.Account.TECH_idFacebook__c != null) {
                mapFacebook.put(contact.Account.TECH_idFacebook__c, contact);
            }
            if(contact.Account.TECH_idTwitter__c != null) {
                mapTwitter.put(contact.Account.TECH_idTwitter__c, contact);
            }
            if(contact.Account.TECH_idInstagram__c != null) {
                mapInstagram.put(contact.Account.TECH_idInstagram__c, contact);
            }
        }   
        
        // Récupération des Ids des utilisateurs UGC (propriétaires du futur case)
        List<User> users = [SELECT Id, email FROM User WHERE email IN :mapEmailUserId.keySet()];  
        for(User user: users) {
            mapEmailUserId.put(user.email, user.Id);
        }
        
        for(Notification notif: notifications) {
            System.debug('--#### Traitement de la notification ^= ' + notif);
            //Case customization 
            Case oCase = new Case();
            // oCase.status = 'Fermée';
            oCase.Origin = notif.alcmeonAccountType;
            String famille = null;
            String motif = null;
            String sousMotif = null;
            String valeurAlcmeon = null;
            for(Tag tag: notif.tags) {
                
                if(tag.name.fr == 'Motifs de contacts 2') {
                    valeurAlcmeon = tag.value.fr;
                    Contacts__c c = mapMotifs.get(tag.value.fr);
                    if(c != null) {
                        famille = c.Famille_Statut__c;
                        motif = c.Motif_Statut__c;
                        sousMotif = c.SousMotif_Statut__c;
                    }
                }
                
            }
             System.debug( notif.userEmail + ' est introuvable dans Salesforce.');
                 System.debug( mapEmailUserId.get(notif.userEmail));
            if(famille != null) {
                oCase.Famille__c = famille;
                if(motif != null) {
                    oCase.Motif__c = motif;
                    oCase.SousMotif__c = sousMotif;
                }
                
                oCase.OwnerId = mapEmailUserId.get(notif.userEmail);
                if(oCase.OwnerId == null) {
                    System.debug('--#### L\'utilisateur UGC, proriétaire du Case et ayant l\'email : ' + notif.userEmail + ' est introuvable dans Salesforce.');
                    System.debug('--#### La notification correspondante est donc abandonnée.');
                    continue;
                }
                
                oCase.DateIncident__c = DateTime.valueOfGmt(notif.dateNotif + ' ' + notif.timeNotif); 
                if(notif.alcmeonAccountType == 'twitter' ) {
                    oCase.TECH_idTwitter__c = notif.alcmeonAccountId;
                    if(mapTwitter.get(notif.alcmeonAccountId) != null) {
                        oCase.ContactId = mapTwitter.get(notif.alcmeonAccountId).Id;
                        oCase.AccountId = mapTwitter.get(notif.alcmeonAccountId).AccountId;
                    } else {
                        oCase.ContactId = Utils.getContactInconnu().Id;
                        oCase.AccountId = Utils.getContactInconnu().AccountId;
                    }
                } else if(notif.alcmeonAccountType == 'facebook') {
                    oCase.TECH_idFacebook__c = notif.alcmeonAccountId;
                    if(mapFacebook.get(notif.alcmeonAccountId) != null) {
                        oCase.ContactId = mapFacebook.get(notif.alcmeonAccountId).Id;
                        oCase.AccountId = mapFacebook.get(notif.alcmeonAccountId).AccountId;
                    } else {
                        oCase.ContactId = Utils.getContactInconnu().Id;
                        oCase.AccountId = Utils.getContactInconnu().AccountId;
                    }
                } else if(notif.alcmeonAccountType == 'instagram') {
                    oCase.TECH_idInstagram__c = notif.alcmeonAccountId;
                    if(mapInstagram.get(notif.alcmeonAccountId) != null) {
                        oCase.ContactId = mapInstagram.get(notif.alcmeonAccountId).Id;
                        oCase.AccountId = mapInstagram.get(notif.alcmeonAccountId).AccountId;
                    } else {
                        oCase.ContactId = Utils.getContactInconnu().Id;
                        oCase.AccountId = Utils.getContactInconnu().AccountId;
                    }
                } else if(notif.alcmeonAccountType == 'critizr') {
                    oCase.TECH_idCritizr__c = notif.alcmeonAccountId;
                    if(mapCritizr.get(notif.alcmeonAccountId) != null) {
                        oCase.ContactId = mapCritizr.get(notif.alcmeonAccountId).Id;
                        oCase.AccountId = mapCritizr.get(notif.alcmeonAccountId).AccountId;
                    } else {
                        oCase.ContactId = Utils.getContactInconnu().Id;
                        oCase.AccountId = Utils.getContactInconnu().AccountId;
                    }
                } 
                system.debug('ocase'+oCase);
                notif.oCase = oCase;
                oCase.Status = 'Fermée';
                oCases.add(oCase);
                mapCaseNot.put(oCase, notif);
                
            } else {
                rejectedNotif = getRN(notif);
                rejectedNotif.Code_erreur__c = 'ERR_GET_FAMILLE';
                rejectedNotif.Message_erreur__c = 'Valeur Alcméon = '+valeurAlcmeon;
                rejectedNotifs.add(rejectedNotif);
            }
            
            System.debug('## AlcmeonNotificationHandler ## Clone1: ' + oCase.isClone());
        }
        
        System.debug('## AlcmeonNotificationHandler ## Insert ' + oCases.size() + ' cases.');
        List<Database.SaveResult> srList = Database.insert(oCases, false);
        // Iterate through each returned result
        for (Integer i = 0; i < srList.size(); ++i) {
            Database.SaveResult sr = srList.get(i);
            Case cse = oCases.get(i);
            if (sr.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted Case ' + cse );
            }
            else {
                Notification notif = mapCaseNot.get(cse);
                String errorIns = '';
                // Operation failed, so get all errors                
                for(Database.Error err : sr.getErrors()) {
                    System.debug('The following error has occurred on inserting ' + cse);                    
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Case fields that affected this error: ' + err.getFields());
                    errorIns += err.getStatusCode()+':'+err.getMessage()+', ';
                }
                
                rejectedNotif = getRN(notif);
                rejectedNotif.Code_erreur__c = 'ERR_INSERT_CASE';
                rejectedNotif.Message_erreur__c = 'Erreur lors de la création du Case = '+errorIns;
                rejectedNotifs.add(rejectedNotif);
                
            }
        }
        insert rejectedNotifs;
        
        List<Case> casesToAdd = new List<Case>();
        List<Task> tasks = new List<Task>();
        Map<Task, Case> mapTaskUnsavedCase = new Map<Task, Case>();
        Map<Attachment, Task> mapAttachTask = new Map<Attachment, Task>();
        List<Case> casesDescriptions = new List<Case>();
        for(Notification notif: notifications) {
            if(notif.oCase == null || notif.oCase.Id == null) {
                continue;
            }
            
            system.debug('## AlcmeonNotificationHandler ## nb of answers 2: ' + notif.answers.size());
            for(Answer answer: notif.answers) {
                if(notif.message != null) {
                    Task task1 = new Task();
                    task1.Description = notif.message.content;
                    task1.ActivityDate = Date.valueOf(notif.dateNotif );
                    task1.OwnerId = notif.oCase.OwnerId;
                    task1.WhatId = notif.oCase.Id;
                    task1.WhoId = notif.oCase.ContactId;
                    task1.Origine__c = notif.alcmeonAccountType;
                    tasks.add(task1);
                    
                    Case c = new Case();
                    c.id = notif.oCase.Id;
                    c.Description = notif.message.content;
                    casesDescriptions.add(c);
                    
                    system.debug('## AlcmeonNotificationHandler ## Activity Date: ' + task1.ActivityDate);
                    
                    if(notif.oCase.isClone()) {
                        mapTaskUnsavedCase.put(task1, notif.oCase);
                    }
                }
                
                Task task = new Task();
                task.Description = answer.content;
                task.ActivityDate = Date.valueOf(notif.message.dateMessage );
                task.OwnerId = notif.oCase.OwnerId;
                task.WhatId = notif.oCase.Id;
                task.WhoId = notif.oCase.ContactId;
                task.Origine__c = notif.alcmeonAccountType;
                tasks.add(task);
                system.debug('## AlcmeonNotificationHandler ## Activity Date: ' + task.ActivityDate);
                
                for(Picture pic: answer.pictures) {
                    Attachment attachment = new Attachment();
                    attachment.ContentType = pic.mimeType;
                    attachment.body = pic.picData;
                    mapAttachTask.put(attachment, task);
                }                   
                
                System.debug('## AlcmeonNotificationHandler ## Clone2: ' + notif.oCase.isClone());
                if(notif.oCase.isClone()) {
                    casesToAdd.add(notif.oCase);
                    mapTaskUnsavedCase.put(task, notif.oCase);
                }
                notif.oCase = notif.oCase.clone(false);                 
            }
        }
        Database.update(casesDescriptions, false);
        System.debug('## AlcmeonNotificationHandler ## Insert ' + casesToAdd.size() + ' additional cases.');
        srList = Database.insert(casesToAdd, false);
        
        // Iterate through each returned result
        for (Integer i = 0; i < srList.size(); ++i) {
            Database.SaveResult sr = srList.get(i);
            Case cse = oCases.get(i);
            if (sr.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted Case ' + cse );
            }
            else {
                // Operation failed, so get all errors                
                for(Database.Error err : sr.getErrors()) {
                    System.debug('The following error has occurred on inserting ' + cse);                    
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Case fields that affected this error: ' + err.getFields());
                }
            }
        }
        
        
        for(Task task: mapTaskUnsavedCase.keySet()) {
            task.WhatId = mapTaskUnsavedCase.get(task).Id;
        }
        
        System.debug('## AlcmeonNotificationHandler ## Insert ' + tasks.size() + ' tasks.');
        srList = Database.insert(tasks, false);
        
        // Iterate through each returned result
        for (Integer i = 0; i < srList.size(); ++i) {
            Database.SaveResult sr = srList.get(i);
            Task task = tasks.get(i);
            if (sr.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted task ' + task );
            }
            else {
                // Operation failed, so get all errors                
                for(Database.Error err : sr.getErrors()) {
                    System.debug('The following error has occurred on inserting ' + task);                    
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Case fields that affected this error: ' + err.getFields());
                }
            }
        }
        
        List<Attachment> attachments = new List<Attachment>();
        for(Attachment attachment: mapAttachTask.keySet()) {
            if(mapAttachTask.get(attachment).Id != null) {
                attachment.ParentId = mapAttachTask.get(attachment).Id;
                attachments.add(attachment);
            }
        }
        
        System.debug('## AlcmeonNotificationHandler ## Insert ' + mapAttachTask.size() + ' attachments.');
        srList = Database.insert(attachments, false);
        
        // Iterate through each returned result
        for (Integer i = 0; i < srList.size(); ++i) {
            Database.SaveResult sr = srList.get(i);
            Attachment attachment = attachments.get(i);
            if (sr.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted Attachment ' + attachment );
            }
            else {
                // Operation failed, so get all errors                
                for(Database.Error err : sr.getErrors()) {
                    System.debug('The following error has occurred on inserting ' + attachment);                    
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Case fields that affected this error: ' + err.getFields());
                }
            }
        }
    }
    
    private static Notification parseNotification(Map<String, Object> jsonMap) {
        Notification notif = new Notification();
        Map<String, Object> actionMap = (Map<String, Object>) jsonMap.get('action');
        if(actionMap == null) {
            return null;
        }
        notif.notificationType = (String) actionMap.get('type');
        notif.dateNotif = (String) actionMap.get('date');
        notif.timeNotif = (String) actionMap.get('time');
        
        Map<String, Object> taskMap = (Map<String, Object>) actionMap.get('task');
        if(taskMap != null) {
            Map<String, Object> messageMap = (Map<String, Object>) taskMap.get('message');
            if(messageMap != null) {
                notif.message = new Message();
                notif.message.content = (String) messageMap.get('content');
                notif.message.dateMessage = (String) messageMap.get('date');
            }
            
            List<Object> tags = (List<Object>) taskMap.get('tags');
            if(tags != null) {
                for(Object o: tags) {
                    Tag tag = new Tag();
                    tag.name = new TranslatedString();
                    
                    Map<String, Object> nameMap = (Map<String, Object>) ((Map<String, Object>) o).get('name');
                    if(nameMap != null) {
                        tag.name.en = (String) nameMap.get('en');
                        tag.name.fr = (String) nameMap.get('fr');
                        tag.name.es = (String) nameMap.get('es');
                        tag.name.nl = (String) nameMap.get('nl'); 
                        
                    }
                    
                    Map<String, Object> tagValueMap = (Map<String, Object>) ((Map<String, Object>) o).get('value');
                    if(tagValueMap != null) {
                        Map<String, Object> valueMap = (Map<String, Object>) tagValueMap.get('value');
                        if(valueMap != null) {
                            tag.value = new TranslatedString();
                            tag.value.en = (String) valueMap.get('en');
                            tag.value.fr = (String) valueMap.get('fr');
                            tag.value.es = (String) valueMap.get('es');
                            tag.value.nl = (String) valueMap.get('nl'); 
                            
                        }
                    }
                    notif.tags.add(tag);
                }
                
            }
        }
        
        if(notif.notificationType == 'answer') {
            Map<String, Object> accountMap = (Map<String, Object>) actionMap.get('account');
            if(accountMap != null) {
                notif.alcmeonAccountId = String.valueOf(accountMap.get('id'));
                notif.alcmeonAccountName = (String) accountMap.get('name');
                notif.alcmeonAccountType = (String) accountMap.get('type');
            }
             
            String s = notif.alcmeonAccountName;
           List<Account> li = [Select id from account where name =: s];
             
            for(account  a : li){
                if(notif.alcmeonAccountType == 'twitter') {
                    a.TECH_idTwitter__c =  notif.alcmeonAccountId;
                } else if(notif.alcmeonAccountType == 'facebook') {
                   a.TECH_idFacebook__c = notif.alcmeonAccountId;
                } else if(notif.alcmeonAccountType == 'instagram') {
                    a.TECH_idInstagram__c = notif.alcmeonAccountId;
                } else if(notif.alcmeonAccountType == 'critizr') {
                    a.TECH_idCritizr__c = notif.alcmeonAccountId;
                }          
            }
             System.debug(li);
            Database.update(li, false);
            
            Map<String, Object> userMap = (Map<String, Object>) actionMap.get('user');
            if(userMap != null) {
                notif.userId = String.valueOf( userMap.get('id') );
                notif.userEmail = (String) userMap.get('email');
                notif.userName = (String) userMap.get('name');
            }
            Map<String, Object> dataMap = (Map<String, Object>) actionMap.get('data');
            List<Object> answers = (List<Object>) dataMap.get('answers');
            
            if(answers != null) {
                for(Object o: answers) {
                    Map<String, Object> answerMap = (Map<String, Object>) o;
                    Answer answer = new Answer();
                    answer.content = (String) answerMap.get('content');
                    answer.pictures = new List<Picture>();
                    
                    List<Object> pictures = (List<Object>) answerMap.get('pictures');
                    if(pictures != null) {
                        for(Object o2: pictures) {
                            Map<String, Object> pictureMap = (Map<String, Object>) o2;
                            Picture pic = new Picture();
                            pic.id = (Integer) pictureMap.get('id');
                            pic.picData = EncodingUtil.base64Decode((String) pictureMap.get('data'));
                            pic.mimeType = (String) pictureMap.get('mime_type');
                            pic.size = (Integer) pictureMap.get('size');
                            answer.pictures.add(pic);
                        }
                    }
                    
                    system.debug('## AlcmeonNotificationHandler ## adding answer: ' + answer);
                    notif.answers.add(answer);
                }
            }
            
        }
        return notif;
    }
    
    class Notification {
        public String notificationType;
        public String alcmeonAccountId;
        public String alcmeonAccountName;
        public String alcmeonAccountType;
        public String userId;
        public String userEmail;
        public String userName;
        public String dateNotif;
        public String timeNotif;
        public List<Answer> answers = new List<Answer>();
        public Message message;
        public List<Tag> tags = new List<Tag>();
        
        public Case oCase;
    }
    
    class Message {
        public String content;
        public String dateMessage;
    }
    
    class Answer {
        public String content;
        public List<Picture> pictures;
    }
    
    class Picture {
        public Integer id;
        public Blob picData;
        public String mimeType;
        public Integer size;
    }
    
    class Tag {
        public TranslatedString name, value;
    }
    
    class TranslatedString {
        public String en, fr, nl, es;
    }
    
}