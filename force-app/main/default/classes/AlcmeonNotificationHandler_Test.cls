@IsTest
public class AlcmeonNotificationHandler_Test {
    
    private static void  handleCases(String jsonEntry){
        
        Test.startTest();
        
        //As Per Best Practice it is important to instantiate the Rest Context 
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/AlcmeonNotification/*';  //Request URL
        req.httpMethod = 'POST';//HTTP Request Type
        req.requestBody = Blob.valueof(jsonEntry);
        RestContext.request = req;
        RestContext.response= res;
        String resp = AlcmeonNotificationHandler.HandleCases();
      
        Test.stopTest();
        
    }
    
    @IsTest
    static void handleNonAnswerTest() {
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
    	
    	
    	String jsonEntry = '[{"action": {"status": "ok", "account": {"type": "facebook", "id": 220, "name": "UGC"},' 
        	+ ' "task": {"tags": [{"id": 3, "value": {"id": 74, "value": {"fr": "Fran\\u00e7ais", "en": "French", "nl": "Frans", "es": "Franc\\u00e9s"}},' 
        	+ '  "name": {"fr": "Langue", "en": "Language", "nl": "Taal", "es": "Idioma"}},' 
        	+ '  {"id": 40, "value": {"id": 440, "value": {"fr": "Aucun", "en": "None", "nl": "Geen", "es": "Ninguna"}},' 
        	+ '  "name": {"fr": "Motifs de contacts", "en": "Motifs de contacts", "nl": "Motifs de contacts", "es": "Motifs de contacts"}},' 
        	+ '  {"id": 47, "value": {"id": 476, "value": {"fr": "Aucun", "en": "None", "nl": "Geen", "es": "Ninguna"}},' 
        	+ '  "name": {"fr": "Motifs de contacts 2", "en": "Motifs de contacts 2", "nl": "Motifs de contacts 2", "es": "Motifs de contacts 2"}}],' 
        	+ '  "url": "https://alcmeon.com/c/65/task/20173641/acquire-and-process/", "state": "pending", "conversation_id": 18194699,' 
        	+ '  "message": {"content": "belle phrase", "attachments": [], "time": "17:31:26", "date": "2017-10-30",' 
        	+ '  "author": {"facebook_author": {"first_name": "Oussama", "last_name": "Jabbari", "name": "Oussama Jabbari"},' 
        	+ '  "id": 9432384, "name": "Oussama Jabbari"}, "external_id": "1666773876706562_1675753925808557",' 
        	+ '  "id": 28994810, "is_private": 0, "discussion_id": 18717657}, "id": 20173641},' 
        	+ '  "user": {"is_bot": 1, "id": 1302, "name": "Alcmeon Bot", "email": "alcmeon-bot-company-65@alc.cx"}, "time": "17:31:39", "date": "2017-10-30",' 
        	+ '  "type": "task-create", "id": 18095064}, "id": 1}]';
        AlcmeonNotificationHandler_Test.handleCases(jsonEntry);
        List<Case> cases = [SELECT Id FROM Case];
       
    }
    
    
    @IsTest
    static void isError() {
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
    	
    	
    	String jsonEntry = '{"action": {"status": "ok", "account": {"type": "facebook", "id": 220, "name": "UGC"},' 
        	+ ' "task": {"tags": [{"id": 3, "value": {"id": 74, "value": {"fr": "Fran\\u00e7ais", "en": "French", "nl": "Frans", "es": "Franc\\u00e9s"}},' 
        	+ '  "name": {"fr": "Langue", "en": "Language", "nl": "Taal", "es": "Idioma"}},' 
        	+ '  {"id": 40, "value": {"id": 440, "value": {"fr": "Aucun", "en": "None", "nl": "Geen", "es": "Ninguna"}},' 
        	+ '  "name": {"fr": "Motifs de contacts", "en": "Motifs de contacts", "nl": "Motifs de contacts", "es": "Motifs de contacts"}},' 
        	+ '  {"id": 47, "value": {"id": 476, "value": {"fr": "Aucun", "en": "None", "nl": "Geen", "es": "Ninguna"}},' 
        	+ '  "name": {"fr": "Motifs de contacts 2", "en": "Motifs de contacts 2", "nl": "Motifs de contacts 2", "es": "Motifs de contacts 2"}}],' 
        	+ '  "url": "https://alcmeon.com/c/65/task/20173641/acquire-and-process/", "state": "pending", "conversation_id": 18194699,' 
        	+ '  "message": {"content": "belle phrase", "attachments": [], "time": "17:31:26", "date": "2017-10-30",' 
        	+ '  "author": {"facebook_author": {"first_name": "Oussama", "last_name": "Jabbari", "name": "Oussama Jabbari"},' 
        	+ '  "id": 9432384, "name": "Oussama Jabbari"}, "external_id": "1666773876706562_1675753925808557",' 
        	+ '  "id": 28994810, "is_private": 0, "discussion_id": 18717657}, "id": 20173641},' 
        	+ '  "user": {"is_bot": 1, "id": 1302, "name": "Alcmeon Bot", "email": "alcmeon-bot-company-65@alc.cx"}, "time": "17:31:39", "date": "2017-10-30",' 
        	+ '  "type": "task-create", "id": 18095064}, "id": 1}';
        AlcmeonNotificationHandler_Test.handleCases(jsonEntry);
       
    }
    
    
    
    
    
    
    @IsTest
    static void handleEmptyTest() {
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
    	
    	
    	String jsonEntry = '';
        handleCases(jsonEntry);
        List<Case> cases = [SELECT Id FROM Case];
        system.assertEquals(0, cases.size());
    }
    
    @IsTest 
    static void handleAnswerTest() {
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
    	
    	
    	Utils.createContactInconnu();
    	
    	Profile prof = [select id from profile where name = 'Chargé de Clientèle'];
    	
    	User u = new user();
		u.LastName = 'Boudot';
		u.Email = 'chargeclientele03@ugc.fr';
		u.Alias = 'Tcode';
		u.Username = 'chargeclientele03@ugc.fr';
		u.CommunityNickname = 'test12';
		u.LocaleSidKey = 'en_US';
		u.TimeZoneSidKey = 'GMT';
		u.ProfileID = prof.Id;
		u.LanguageLocaleKey = 'en_US';
		u.EmailEncodingKey = 'UTF-8';
		insert u;
		
		Contacts__c c = new Contacts__c();
        /*
		c.ValeurALCMEON__c = '008 Autres';
		c.Famille_Statut__c = '6- GestionCompteUI';
		c.Motif_Statut__c = '1- Réédition de carte gratuite';
		c.SousMotif_Statut__c = '6- Réedition sans frais';
		*/
		c.ValeurALCMEON__c = '115 réclamation solde de points';
		c.Famille_Statut__c = '9- Supports Digitaux';
		c.Motif_Statut__c = '3- UGC fidélité';
		c.SousMotif_Statut__c = '5- Réclamation solde de points';
		
		insert c;
    	String jsonEntry = '[{"action": {"status": "pending", "account": {"type": "critizr", "id": 250, "name": "UGC / Critizr"},' 
        	+ '  "task": {"tags": [{"id": 3, "value": {"id": 74, "value": {"fr": "Fran\\u00e7ais", "en": "French", "nl": "Frans", "es": "Franc\\u00e9s"}},' 
        	+ '  "name": {"fr": "Langue", "en": "Language", "nl": "Taal", "es": "Idioma"}},' 
        	+ '  {"id": 40, "value": {"id": 472,' 
        	+ '  "value": {"fr": "008 Autres", "en": "Infos Services Produits Digital",' 
        	+ '  "nl": "Infos Services Produits Digital", "es": "Infos Services Produits Digital"}},' 
        	+ '  "name": {"fr": "Motifs de contacts", "en": "Motifs de contacts", "nl": "Motifs de contacts", "es": "Motifs de contacts"}},' 
        	+ '  {"id": 47, "value": {"id": 504, "value": {"fr": "115 réclamation solde de points", "en": "115 réclamation solde de points",' 
        	+ '  "nl": "115 réclamation solde de points", "es": "115 réclamation solde de points"}},' 
        	+ '  "name": {"fr": "Motifs de contacts 2", "en": "Motifs de contacts 2", "nl": "Motifs de contacts 2", "es": "Motifs de contacts 2"}}],' 
        	+ '  "url": "https://alcmeon.com/c/65/task/20161430/acquire-and-process/", "state": "assigned", "conversation_id": 18189955,' 
        	+ '  "message": {"content": "Le cin\\u00e9ma est tr\\u00e8s tr\\u00e8s bien et la qualit\\u00e9 est pr\\u00e9sente ",' 
        	+ '  "attachments": [], "time": "11:33:22", "date": "2017-10-29", "author": {"id": 9429465, "name": "Marius"},' 
        	+ '  "external_id": "4179067", "id": 28973214, "is_private": 0, "discussion_id": 18750901}, "id": 20161430},' 
        	+ '  "data": {"answers": [{"content": "Bonjour Marius,\\nNous vous remercions de votre compliment et esp\\u00e9rons vous revoir bient\\u00f4t.\\nBien \\u00e0 vous,\\nFlorian/UGC",' 
        	+ '  "pictures": []}], "is_private": 0},' 
        	+ '  "user": {"is_bot": 0, "id": 882, "name": "Florian Boudot", "email": "chargeclientele03@ugc.fr"}' 
        	+ ' , "time": "17:39:06", "date": "2017-10-30", "type": "answer", "id": 18095600}, "id": 22}]';
    	
		handleCases(jsonEntry);
    	
    	
        List<Case> cases = [SELECT Id, Origin, OwnerId, TECH_idCritizr__c, AccountId, Famille__c, Motif__c, SousMotif__c FROM Case];
      
        
        List<Task> tasks = [SELECT Id, WhatId, WhoId, Origine__c, Description, ActivityDate, OwnerId FROM Task];
        
       
        //Date d = Date.valueOf('2017-10-30');
        Boolean messageOk = false;
        Boolean answerOk = false;
        String descriptions = '';
        for(Task task: tasks) {
        	
        	descriptions += '\n' + task.description;
        	if(task.description == 'Le cinéma est très très bien et la qualité est présente') {
        		messageOk = true;
        	}
        	if(task.description == 'Bonjour Marius,\nNous vous remercions de votre compliment et espérons vous revoir bientôt.\nBien à vous,\nFlorian/UGC') {
        		answerOk = true;
        	}
        }
      
        
    }
    
      @IsTest 
    static void handleAnswerTeswittert() {
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
    	Utils.createContactInconnu();
    	
    	Profile prof = [select id from profile where name = 'Chargé de Clientèle'];
    	
    	User u = new user();
		u.LastName = 'Boudot';
		u.Email = 'chargeclientele03@ugc.fr';
		u.Alias = 'Tcode';
		u.Username = 'chargeclientele03@ugc.fr';
		u.CommunityNickname = 'test12';
		u.LocaleSidKey = 'en_US';
		u.TimeZoneSidKey = 'GMT';
		u.ProfileID = prof.Id;
		u.LanguageLocaleKey = 'en_US';
		u.EmailEncodingKey = 'UTF-8';
		insert u;
		
		Contacts__c c = new Contacts__c();
        /*
		c.ValeurALCMEON__c = '008 Autres';
		c.Famille_Statut__c = '6- GestionCompteUI';
		c.Motif_Statut__c = '1- Réédition de carte gratuite';
		c.SousMotif_Statut__c = '6- Réedition sans frais';
		*/
		c.ValeurALCMEON__c = '115 réclamation solde de points';
		c.Famille_Statut__c = '9- Supports Digitaux';
		c.Motif_Statut__c = '3- UGC fidélité';
		c.SousMotif_Statut__c = '5- Réclamation solde de points';
		
		insert c;
    	String jsonEntry = '[{"action": {"status": "pending", "account": {"type": "twitter", "id": 250, "name": "UGC / Critizr"},' 
        	+ '  "task": {"tags": [{"id": 3, "value": {"id": 74, "value": {"fr": "Fran\\u00e7ais", "en": "French", "nl": "Frans", "es": "Franc\\u00e9s"}},' 
        	+ '  "name": {"fr": "Langue", "en": "Language", "nl": "Taal", "es": "Idioma"}},' 
        	+ '  {"id": 40, "value": {"id": 472,' 
        	+ '  "value": {"fr": "008 Autres", "en": "Infos Services Produits Digital",' 
        	+ '  "nl": "Infos Services Produits Digital", "es": "Infos Services Produits Digital"}},' 
        	+ '  "name": {"fr": "Motifs de contacts", "en": "Motifs de contacts", "nl": "Motifs de contacts", "es": "Motifs de contacts"}},' 
        	+ '  {"id": 47, "value": {"id": 504, "value": {"fr": "115 réclamation solde de points", "en": "115 réclamation solde de points",' 
        	+ '  "nl": "115 réclamation solde de points", "es": "115 réclamation solde de points"}},' 
        	+ '  "name": {"fr": "Motifs de contacts 2", "en": "Motifs de contacts 2", "nl": "Motifs de contacts 2", "es": "Motifs de contacts 2"}}],' 
        	+ '  "url": "https://alcmeon.com/c/65/task/20161430/acquire-and-process/", "state": "assigned", "conversation_id": 18189955,' 
        	+ '  "message": {"content": "Le cin\\u00e9ma est tr\\u00e8s tr\\u00e8s bien et la qualit\\u00e9 est pr\\u00e9sente ",' 
        	+ '  "attachments": [], "time": "11:33:22", "date": "2017-10-29", "author": {"id": 9429465, "name": "Marius"},' 
        	+ '  "external_id": "4179067", "id": 28973214, "is_private": 0, "discussion_id": 18750901}, "id": 20161430},' 
        	+ '  "data": {"answers": [{"content": "Bonjour Marius,\\nNous vous remercions de votre compliment et esp\\u00e9rons vous revoir bient\\u00f4t.\\nBien \\u00e0 vous,\\nFlorian/UGC",' 
        	+ '  "pictures": []}], "is_private": 0},' 
        	+ '  "user": {"is_bot": 0, "id": 882, "name": "Florian Boudot", "email": "chargeclientele03@ugc.fr"}' 
        	+ ' , "time": "17:39:06", "date": "2017-10-30", "type": "answer", "id": 18095600}, "id": 22}]';
    	
		handleCases(jsonEntry);
    	
    	
        List<Case> cases = [SELECT Id, Origin, OwnerId, TECH_idCritizr__c, AccountId, Famille__c, Motif__c, SousMotif__c FROM Case];
      
        
        List<Task> tasks = [SELECT Id, WhatId, WhoId, Origine__c, Description, ActivityDate, OwnerId FROM Task];
        
       
        //Date d = Date.valueOf('2017-10-30');
        Boolean messageOk = false;
        Boolean answerOk = false;
        String descriptions = '';
        for(Task task: tasks) {
        	
        	descriptions += '\n' + task.description;
        	if(task.description == 'Le cinéma est très très bien et la qualité est présente') {
        		messageOk = true;
        	}
        	if(task.description == 'Bonjour Marius,\nNous vous remercions de votre compliment et espérons vous revoir bientôt.\nBien à vous,\nFlorian/UGC') {
        		answerOk = true;
        	}
        }
      
        
    }
    
    
     @IsTest 
    static void handleAnswerTestinsta() {
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
    	Utils.createContactInconnu();
    	
    	Profile prof = [select id from profile where name = 'Chargé de Clientèle'];
    	
    	User u = new user();
		u.LastName = 'Boudot';
		u.Email = 'chargeclientele03@ugc.fr';
		u.Alias = 'Tcode';
		u.Username = 'chargeclientele03@ugc.fr';
		u.CommunityNickname = 'test12';
		u.LocaleSidKey = 'en_US';
		u.TimeZoneSidKey = 'GMT';
		u.ProfileID = prof.Id;
		u.LanguageLocaleKey = 'en_US';
		u.EmailEncodingKey = 'UTF-8';
		insert u;
		
		Contacts__c c = new Contacts__c();
        /*
		c.ValeurALCMEON__c = '008 Autres';
		c.Famille_Statut__c = '6- GestionCompteUI';
		c.Motif_Statut__c = '1- Réédition de carte gratuite';
		c.SousMotif_Statut__c = '6- Réedition sans frais';
		*/
		c.ValeurALCMEON__c = '115 réclamation solde de points';
		c.Famille_Statut__c = '9- Supports Digitaux';
		c.Motif_Statut__c = '3- UGC fidélité';
		c.SousMotif_Statut__c = '5- Réclamation solde de points';
		
		insert c;
    	String jsonEntry = '[{"action": {"status": "pending", "account": {"type": "facebook", "id": 426, "name": "Annick Maeckelberghe"},' 
        	+ '  "task": {"tags": [{"id": 3, "value": {"id": 74, "value": {"fr": "Fran\\u00e7ais", "en": "French", "nl": "Frans", "es": "Franc\\u00e9s"}},' 
        	+ '  "name": {"fr": "Langue", "en": "Language", "nl": "Taal", "es": "Idioma"}},' 
        	+ '  {"id": 40, "value": {"id": 472,' 
        	+ '  "value": {"fr": "008 Autres", "en": "Infos Services Produits Digital",' 
        	+ '  "nl": "Infos Services Produits Digital", "es": "Infos Services Produits Digital"}},' 
        	+ '  "name": {"fr": "Motifs de contacts", "en": "Motifs de contacts", "nl": "Motifs de contacts", "es": "Motifs de contacts"}},' 
        	+ '  {"id": 47, "value": {"id": 504, "value": {"fr": "115 réclamation solde de points", "en": "115 réclamation solde de points",' 
        	+ '  "nl": "115 réclamation solde de points", "es": "115 réclamation solde de points"}},' 
        	+ '  "name": {"fr": "Motifs de contacts 2", "en": "Motifs de contacts 2", "nl": "Motifs de contacts 2", "es": "Motifs de contacts 2"}}],' 
        	+ '  "url": "https://alcmeon.com/c/65/task/20161430/acquire-and-process/", "state": "assigned", "conversation_id": 18189955,' 
        	+ '  "message": {"content": "Le cin\\u00e9ma est tr\\u00e8s tr\\u00e8s bien et la qualit\\u00e9 est pr\\u00e9sente ",' 
        	+ '  "attachments": [], "time": "11:33:22", "date": "2017-10-29", "author": {"id": 9429465, "name": "Marius"},' 
        	+ '  "external_id": "4179067", "id": 28973214, "is_private": 0, "discussion_id": 18750901}, "id": 20161430},' 
        	+ '  "data": {"answers": [{"content": "Bonjour Marius,\\nNous vous remercions de votre compliment et esp\\u00e9rons vous revoir bient\\u00f4t.\\nBien \\u00e0 vous,\\nFlorian/UGC",' 
        	+ '  "pictures": []}], "is_private": 0},' 
        	+ '  "user": {"is_bot": 0, "id": 882, "name": "Florian Boudot", "email": "chargeclientele03@ugc.fr"}' 
        	+ ' , "time": "17:39:06", "date": "2017-10-30", "type": "answer", "id": 18095600}, "id": 22}]';
    	
		handleCases(jsonEntry);
    	
    	
        List<Case> cases = [SELECT Id, Origin, OwnerId, TECH_idCritizr__c, AccountId, Famille__c, Motif__c, SousMotif__c FROM Case];
      
        
        List<Task> tasks = [SELECT Id, WhatId, WhoId, Origine__c, Description, ActivityDate, OwnerId FROM Task];
        
       
        //Date d = Date.valueOf('2017-10-30');
        Boolean messageOk = false;
        Boolean answerOk = false;
        String descriptions = '';
        for(Task task: tasks) {
        	
        	descriptions += '\n' + task.description;
        	if(task.description == 'Le cinéma est très très bien et la qualité est présente') {
        		messageOk = true;
        	}
        	if(task.description == 'Bonjour Marius,\nNous vous remercions de votre compliment et espérons vous revoir bientôt.\nBien à vous,\nFlorian/UGC') {
        		answerOk = true;
        	}
        }
      
        
    }
    
    
    
    
    @IsTest
    public static void testIdentifyContact() {
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
    	
    	
    	Utils.createContactInconnu();
    	
    	Profile prof = [select id from profile where name = 'Chargé de Clientèle'];
    	
    	User u = new user();
		u.LastName = 'Boudot';
		u.Email = 'chargeclientele03@ugc.fr';
		u.Alias = 'Tcode';
		u.Username = 'chargeclientele03@ugc.fr';
		u.CommunityNickname = 'test12';
		u.LocaleSidKey = 'en_US';
		u.TimeZoneSidKey = 'GMT';
		u.ProfileID = prof.Id;
		u.LanguageLocaleKey = 'en_US';
		u.EmailEncodingKey = 'UTF-8';
		insert u;
		
		Contacts__c c = new Contacts__c();
        /*
		c.ValeurALCMEON__c = '008 Autres';
		c.Famille_Statut__c = '6- GestionCompteUI';
		c.Motif_Statut__c = '1- Réédition de carte gratuite';
		c.SousMotif_Statut__c = '6- Réedition sans frais';
		*/
		c.ValeurALCMEON__c = '115 réclamation solde de points';
		c.Famille_Statut__c = '9- Supports Digitaux';
		c.Motif_Statut__c = '3- UGC fidélité';
		c.SousMotif_Statut__c = '5- Réclamation solde de points';
		
		insert c;
		
		Account acc = new Account(LastName='test', FirstName='test', RecordTypeId = Utils.getComptePersonelAccountRecordType().Id, 
        	PersonEmail='test@test.test', ClientResident__c = 'France', TECH_idCritizr__c='250', TECH_idInstagram__c='251', TECH_idTwitter__c = '252', TECH_idFacebook__c  = '253');
        insert acc;
		
    	String jsonEntry = '[{"action": {"status": "pending", "account": {"type": "critizr", "id": 250, "name": "UGC / Critizr"},' 
        	+ '  "task": {"tags": [{"id": 3, "value": {"id": 74, "value": {"fr": "Fran\\u00e7ais", "en": "French", "nl": "Frans", "es": "Franc\\u00e9s"}},' 
        	+ '  "name": {"fr": "Langue", "en": "Language", "nl": "Taal", "es": "Idioma"}},' 
        	+ '  {"id": 40, "value": {"id": 472,' 
        	+ '  "value": {"fr": "008 Autres", "en": "Infos Services Produits Digital",' 
        	+ '  "nl": "Infos Services Produits Digital", "es": "Infos Services Produits Digital"}},' 
        	+ '  "name": {"fr": "Motifs de contacts", "en": "Motifs de contacts", "nl": "Motifs de contacts", "es": "Motifs de contacts"}},' 
        	+ '  {"id": 47, "value": {"id": 504, "value": {"fr": "115 réclamation solde de points", "en": "115 réclamation solde de points",' 
        	+ '  "nl": "115 réclamation solde de points", "es": "115 réclamation solde de points"}},' 
        	+ '  "name": {"fr": "Motifs de contacts 2", "en": "Motifs de contacts 2", "nl": "Motifs de contacts 2", "es": "Motifs de contacts 2"}}],' 
        	+ '  "url": "https://alcmeon.com/c/65/task/20161430/acquire-and-process/", "state": "assigned", "conversation_id": 18189955,' 
        	+ '  "message": {"content": "Le cin\\u00e9ma est tr\\u00e8s tr\\u00e8s bien et la qualit\\u00e9 est pr\\u00e9sente ",' 
        	+ '  "attachments": [], "time": "11:33:22", "date": "2017-10-29", "author": {"id": 9429465, "name": "Marius"},' 
        	+ '  "external_id": "4179067", "id": 28973214, "is_private": 0, "discussion_id": 18750901}, "id": 20161430},' 
        	+ '  "data": {"answers": [{"content": "Bonjour Marius,\\nNous vous remercions de votre compliment et esp\\u00e9rons vous revoir bient\\u00f4t.\\nBien \\u00e0 vous,\\nFlorian/UGC",' 
        	+ '  "pictures": []}], "is_private": 0},' 
        	+ '  "user": {"is_bot": 0, "id": 882, "name": "Florian Boudot", "email": "chargeclientele03@ugc.fr"}' 
        	+ ' , "time": "17:39:06", "date": "2017-10-30", "type": "answer", "id": 18095600}, "id": 22}]';
    	handleCases(jsonEntry);
    	
    	List<Case> cases = [SELECT Id, AccountId FROM Case];
     
    }
    
    @IsTest
    public static void testMultiAnswer() {
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
    	
    	
    	Utils.createContactInconnu();
    	
    	Profile prof = [select id from profile where name = 'Chargé de Clientèle'];
    	
    	User u = new user();
		u.LastName = 'Boudot';
		u.Email = 'chargeclientele03@ugc.fr';
		u.Alias = 'Tcode';
		u.Username = 'chargeclientele03@ugc.fr';
		u.CommunityNickname = 'test12';
		u.LocaleSidKey = 'en_US';
		u.TimeZoneSidKey = 'GMT';
		u.ProfileID = prof.Id;
		u.LanguageLocaleKey = 'en_US';
		u.EmailEncodingKey = 'UTF-8';
		insert u;
		
		Contacts__c c = new Contacts__c();
		c.ValeurALCMEON__c = '115 réclamation solde de points';
		c.Famille_Statut__c = '9- Supports Digitaux';
		c.Motif_Statut__c = '3- UGC fidélité';
		c.SousMotif_Statut__c = '5- Réclamation solde de points';
		
		insert c;
		
    	String jsonEntry = '[{"action": {"status": "pending", "account": {"type": "instagram", "id": 250, "name": "UGC / Critizr"},' 
        	+ '  "task": {"tags": [{"id": 3, "value": {"id": 74, "value": {"fr": "Fran\\u00e7ais", "en": "French", "nl": "Frans", "es": "Franc\\u00e9s"}},' 
        	+ '  "name": {"fr": "Langue", "en": "Language", "nl": "Taal", "es": "Idioma"}},' 
        	+ '  {"id": 40, "value": {"id": 472,' 
        	+ '  "value": {"fr": "008 Autres", "en": "Infos Services Produits Digital",' 
        	+ '  "nl": "Infos Services Produits Digital", "es": "Infos Services Produits Digital"}},' 
        	+ '  "name": {"fr": "Motifs de contacts", "en": "Motifs de contacts", "nl": "Motifs de contacts", "es": "Motifs de contacts"}},' 
        	+ '  {"id": 47, "value": {"id": 504, "value": {"fr": "115 réclamation solde de points", "en": "115 réclamation solde de points",' 
        	+ '  "nl": "115 réclamation solde de points", "es": "115 réclamation solde de points"}},' 
        	+ '  "name": {"fr": "Motifs de contacts 2", "en": "Motifs de contacts 2", "nl": "Motifs de contacts 2", "es": "Motifs de contacts 2"}}],' 
        	+ '  "url": "https://alcmeon.com/c/65/task/20161430/acquire-and-process/", "state": "assigned", "conversation_id": 18189955,' 
        	+ '  "message": {"content": "Le cin\\u00e9ma est tr\\u00e8s tr\\u00e8s bien et la qualit\\u00e9 est pr\\u00e9sente ",' 
        	+ '  "attachments": [], "time": "11:33:22", "date": "2017-10-29", "author": {"id": 9429465, "name": "Marius"},' 
        	+ '  "external_id": "4179067", "id": 28973214, "is_private": 0, "discussion_id": 18750901}, "id": 20161430},' 
        	+ '  "data": {"answers": [{"content": "FOO", "pictures": []}, {"content": "BAR", "pictures": []}], "is_private": 0},' 
        	+ '  "user": {"is_bot": 0, "id": 882, "name": "Florian Boudot", "email": "chargeclientele03@ugc.fr"}' 
        	+ ' , "time": "17:39:06", "date": "2017-10-30", "type": "answer", "id": 18095600}, "id": 22}]';
    	handleCases(jsonEntry);
    	
    	List<Case> cases = [SELECT Id FROM Case];
       
        
        List<Task> tasks = [SELECT Id, WhatId, WhoId, Origine__c, Description, ActivityDate, OwnerId FROM Task];
        
       
        //Date d = Date.valueOf('2017-10-30');
        Boolean messageOk1 = false;
        Boolean messageOk2 = false;
        Boolean answerOk1 = false;
        Boolean answerOk2 = false;
        String descriptions = '';
        Id case1Id = null;
        Id case2Id = null;
        for(Task task: tasks) {
        	system.assert(task.whatId != null);
        	descriptions += '\n' + task.description;
        	if(task.description == 'Le cinéma est très très bien et la qualité est présente' && task.whatId == cases.get(0).Id) {
        		messageOk1 = true;
        	}
        	if(task.description == 'Le cinéma est très très bien et la qualité est présente' && task.whatId == cases.get(1).Id) {
        		messageOk2 = true;
        	}
        	if(task.description == 'FOO') {
        		answerOk1 = true;
        		case1Id = task.whatId;
        	}
        	if(task.description == 'BAR') {
        		answerOk2 = true;
        		case2Id = task.whatId;
        	}
        }
      

    }
    
    @IsTest
    public static void testNoContacts() {
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
    	
    	Utils.createContactInconnu();
    	
    	Profile prof = [select id from profile where name = 'Chargé de Clientèle'];
    	
    	User u = new user();
		u.LastName = 'Boudot';
		u.Email = 'chargeclientele03@ugc.fr';
		u.Alias = 'Tcode';
		u.Username = 'chargeclientele03@ugc.fr';
		u.CommunityNickname = 'test12';
		u.LocaleSidKey = 'en_US';
		u.TimeZoneSidKey = 'GMT';
		u.ProfileID = prof.Id;
		u.LanguageLocaleKey = 'en_US';
		u.EmailEncodingKey = 'UTF-8';
		insert u;
		
		
    	String jsonEntry = '[{"action": {"status": "pending", "account": {"type": "twitter", "id": 250, "name": "UGC / Critizr"},' 
        	+ '  "task": {"tags": [{"id": 3, "value": {"id": 74, "value": {"fr": "Fran\\u00e7ais", "en": "French", "nl": "Frans", "es": "Franc\\u00e9s"}},' 
        	+ '  "name": {"fr": "Langue", "en": "Language", "nl": "Taal", "es": "Idioma"}},' 
        	+ '  {"id": 40, "value": {"id": 472,' 
        	+ '  "value": {"fr": "008 Autres", "en": "Infos Services Produits Digital",' 
        	+ '  "nl": "Infos Services Produits Digital", "es": "Infos Services Produits Digital"}},' 
        	+ '  "name": {"fr": "Motifs de contacts", "en": "Motifs de contacts", "nl": "Motifs de contacts", "es": "Motifs de contacts"}},' 
        	+ '  {"id": 47, "value": {"id": 504, "value": {"fr": "115 réclamation solde de points", "en": "115 réclamation solde de points",' 
        	+ '  "nl": "115 réclamation solde de points", "es": "115 réclamation solde de points"}},' 
        	+ '  "name": {"fr": "Motifs de contacts 2", "en": "Motifs de contacts 2", "nl": "Motifs de contacts 2", "es": "Motifs de contacts 2"}}],' 
        	+ '  "url": "https://alcmeon.com/c/65/task/20161430/acquire-and-process/", "state": "assigned", "conversation_id": 18189955,' 
        	+ '  "message": {"content": "Le cin\\u00e9ma est tr\\u00e8s tr\\u00e8s bien et la qualit\\u00e9 est pr\\u00e9sente ",' 
        	+ '  "attachments": [], "time": "11:33:22", "date": "2017-10-29", "author": {"id": 9429465, "name": "Marius"},' 
        	+ '  "external_id": "4179067", "id": 28973214, "is_private": 0, "discussion_id": 18750901}, "id": 20161430},' 
        	+ '  "data": {"answers": [{"content": "FOO", "pictures": []}, {"content": "BAR", "pictures": []}], "is_private": 0},' 
        	+ '  "user": {"is_bot": 0, "id": 882, "name": "Florian Boudot", "email": "chargeclientele03@ugc.fr"}' 
        	+ ' , "time": "17:39:06", "date": "2017-10-30", "type": "answer", "id": 18095600}, "id": 22}]';
    	handleCases(jsonEntry);
    	
    	List<Case> cases = [SELECT Id FROM Case];
      
        
        List<Rejected_Notification__c> rns = [SELECT json__c FROM Rejected_Notification__c];
       
        
        
    }
    

}