@isTest
public class AP02_Case_Test {
    private static Account accountEmail;
    private static Account accountCourrier;
    private static Account accountCourrier2;
    private static Account accountUnreachable;
    private static Account accountUnreachable2;
    
    
    
    private static Contacts__c cont211;
    private static Contacts__c cont212;
    private static Contacts__c cont213;

    
    
    private static SDOC__SDTemplate__c templateHtml;
    private static SDOC__SDTemplate__c templatePdf;
    
    
    private static void init() {
    	Utils.createContactInconnu();
    	
        // Account test
        accountEmail = new Account(LastName='test', FirstName='test', RecordTypeId = Utils.getComptePersonelAccountRecordType().Id, 
        	PersonEmail='test@test.test', CliEmailComplementaire__c='test@test.test', NPAIEMAIL__c = false, PNDADRESSE__c = false);
        insert accountEmail;
        
        system.debug ('### LOG ### accountEmail =' + accountEmail) ;
        	
       	Commune__c commune = new Commune__c(Name='Testville', CodePostal__c='00000', Tech_Commune__c='external_id');
       	insert commune;

        accountCourrier = new Account(LastName='Testcourrier', FirstName='test', RecordTypeId = Utils.getComptePersonelAccountRecordType().Id, Personemail='test2@test.test', 
        	NoVoie__c = '2', TypeVoie__c='allée', NomVoie__c='du Test', Ville__c = commune.id, CodePostal__c='00000', Pays__c='FRANCE', 
        	NPAIEMAIL__c = true, PNDADRESSE__c = false); 
        insert accountCourrier;
        accountCourrier2 = new Account(LastName='Testcourrier', FirstName='test2', RecordTypeId = Utils.getComptePersonelAccountRecordType().Id,
        	NoVoie__c = '2', TypeVoie__c='allée', NomVoie__c='du Test', Ville__c = commune.id, CodePostal__c='00000', Pays__c='FRANCE', 
        	NPAIEMAIL__c = false, PNDADRESSE__c = false); 
        insert accountCourrier2;
        
        accountUnreachable = new Account(LastName='Unreach', FirstName='Able', RecordTypeId = Utils.getComptePersonelAccountRecordType().Id,
        	 PersonEmail='false@test.test', CliEmailComplementaire__c='false@test.test',
        	NPAIEMAIL__c = true, PNDADRESSE__c = true);
        	
        insert accountUnreachable;
        
        accountUnreachable2 = new Account(LastName='Unreach', FirstName='Bravo', RecordTypeId = Utils.getComptePersonelAccountRecordType().Id,
        	PersonMobilePhone  = '0666',
        	NPAIEMAIL__c = false, PNDADRESSE__c = false);
        	
        insert accountUnreachable2;
        
		
        // creation d'un custom contacts
        cont211 = new Contacts__c() ;
        cont211.FamilleMatrice__c ='2- Club UGC / fidelite' ;
        cont211.MotifMatrice__c ='99- Autre' ;
        cont211.SousMotifMatrice__c ='I- Info' ;
        cont211.name ='211' ;
        cont211.Reponse__c = 'Automatique';
        cont211.NomModeleEmailHTML__c = 'template HTML';
        cont211.NomModeleCourrierEmail__c = 'template PDF';
        insert cont211 ;
        system.debug ('### LOG ### cont211 =' + cont211) ;
        
        cont212 = new Contacts__c() ;
        cont212.FamilleMatrice__c ='2- Club UGC / fidelite' ;
        cont212.MotifMatrice__c ='99- Autre' ;
        cont212.SousMotifMatrice__c ='R- Récla' ;
        cont212.name ='212' ;
        cont212.Reponse__c = 'Semi-automatique';
        cont212.NomModeleEmailHTML__c = 'template HTML';
        cont212.NomModeleCourrierEmail__c = 'template PDF';
        insert cont212 ;
        system.debug ('### LOG ### cont212 =' + cont212) ;
        
        cont213 = new Contacts__c() ;
        cont213.FamilleMatrice__c ='2- Club UGC / fidelite' ;
        cont213.MotifMatrice__c ='99- Autre' ;
        cont213.SousMotifMatrice__c ='A- Action' ;
        cont213.name ='213' ;
        cont213.Reponse__c = 'Manuelle';
        cont213.NomModeleEmailHTML__c = 'template HTML';
        cont213.NomModeleCourrierEmail__c = 'template PDF';
        insert cont213 ;
        system.debug ('### LOG ### cont213 =' + cont213) ;
        
        templateHtml = new SDOC__SDTemplate__c(Name='template HTML', SDOC__Template_Format__c='HTML');
        templatePdf = new SDOC__SDTemplate__c(Name='template PDF', SDOC__Template_Format__c='PDF');
        insert templateHtml;
        insert templatePdf;
    }
    
    private static Case getNewCaseAQualif() {
        Case cse = new Case () ;
        cse.RecordTypeId = Utils.getNouvelleDemandeClientCaseRecordType().id ;
        cse.AccountId = accountEmail.ID;
        cse.Status ='à traiter' ;
        return cse;
    }
    
    private static Case getNewCase211() {
        Case cse = getNewCaseAQualif();
        cse.Famille__c ='2- Club UGC / fidelite' ;
        cse.Motif__c ='99- Autre' ;
        cse.SousMotif__c ='I- Info' ;
        return cse;
    }
    
    private static Case getNewCase212() {
        Case cse = getNewCase211();
        cse.SousMotif__c ='R- Récla' ;
        return cse;
    }
    
    private static Case getNewCase213() {
        Case cse = getNewCase211();
        cse.SousMotif__c ='A- Action' ;
        return cse;
    }
    
    private static Case getNewCase215() {
        Case cse = getNewCase211();
        cse.SousMotif__c ='Click to Call Info' ;
        return cse;
    }
    
    
    
    
    @isTest 
    static void insertionCaseEmailAuto (){
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
        init();
        
        system.debug('### LOG ### insertionCase start');
        
    	Test.startTest();
        // creation d'un Case
        Case cse = getNewCase211();
        
        system.debug ('### LOG ### cse.Status =' + cse.Status) ;
        system.debug ('### LOG ### cse.Famille__c =' + cse.Famille__c) ;
        system.debug ('### LOG ### cse.Famille__c =' + cse.Famille__c) ;
        system.debug ('### LOG ### cse.Motif__c =' + cse.Motif__c) ;
        system.debug ('### LOG ### cse.SousMotif__c =' + cse.SousMotif__c) ;   
        
        insert cse ;
        system.debug ('### LOG ### cse =' + cse) ;
        system.debug ('### LOG ### cse.AdresseEmail__c =' + cse.AdresseEmail__c) ;   
        
        Test.stopTest();
        
        verifJob(cse.Id, 'Un email a été envoyé au client.', '1', templateHtml.ID, cont211);
    }	
    
   
    
    @isTest 
    static void insertionCaseEmailSemiAuto (){
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
        init();
        
    	Test.startTest();
        system.debug('### LOG ### insertionCase start');
        
        // creation d'un Case
        Case cse = getNewCase212();
        
        system.debug ('### LOG ### cse.Status =' + cse.Status) ;
        system.debug ('### LOG ### cse.Famille__c =' + cse.Famille__c) ;
        system.debug ('### LOG ### cse.Famille__c =' + cse.Famille__c) ;
        system.debug ('### LOG ### cse.Motif__c =' + cse.Motif__c) ;
        system.debug ('### LOG ### cse.SousMotif__c =' + cse.SousMotif__c) ;   
        
        insert cse ;
        system.debug ('### LOG ### cse =' + cse) ;
        system.debug ('### LOG ### cse.AdresseEmail__c =' + cse.AdresseEmail__c) ;   
        
        Test.stopTest();
        
        Case caseVerif = [SELECT Id, AideReponseClient__c, TECH_FamilleMatrice__c, TECH_MotifMatrice__c, TECH_SousMotifMatrice__c
        					FROM Case WHERE Id = :cse.Id ];
        system.assertEquals( cont212.FamilleMatrice__c,  caseVerif.TECH_FamilleMatrice__c); 
        system.assertEquals( cont212.MotifMatrice__c,  caseVerif.TECH_MotifMatrice__c); 
        system.assertEquals( cont212.SousMotifMatrice__c,  caseVerif.TECH_SousMotifMatrice__c); 
        
        String aide = caseVerif.AideReponseClient__c;
        system.debug('## AP02_Case_Test ## Aide: ' + aide);
        /*system.assert( aide.startsWith('Pour répondre au client, veuillez cliquer sur le lien suivant'));
        system.assert( aide.contains(String.valueOf(templateHtml.Id)));
        system.assert( aide.contains(caseVerif.Id));*/
    }	
    
    @isTest 
    static void insertionCaseCourrierAuto (){
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
        init();
        
    	Test.startTest();
        system.debug('### LOG ### insertionCase start');
        
        // creation d'un Case
        Case cse = getNewCase211();
        cse.AccountId = accountCourrier.ID;
        
        system.debug ('### LOG ### cse.Status =' + cse.Status) ;
        system.debug ('### LOG ### cse.Famille__c =' + cse.Famille__c) ;
        system.debug ('### LOG ### cse.Famille__c =' + cse.Famille__c) ;
        system.debug ('### LOG ### cse.Motif__c =' + cse.Motif__c) ;
        system.debug ('### LOG ### cse.SousMotif__c =' + cse.SousMotif__c) ;   
        system.debug ('### LOG ### cse =' + cse) ;
        
        
        insert cse ;
        
        ID cseID = cse.ID;
        system.debug ('### LOG ### cse apres insert  =' + cse) ;
        
        Test.stopTest();
        
        verifJob(cse.Id, 'Un courrier a été généré.', '0', templatePdf.ID, cont211);
        
    }	
    
    @isTest 
    static void insertionCaseCourrierSemiAuto (){
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
        init();
        
    	Test.startTest();
        system.debug('### LOG ### insertionCase start');
        
        // creation d'un Case
        Case cse = getNewCase212();
        cse.AccountId = accountCourrier.ID;
        
        system.debug ('### LOG ### cse.Status =' + cse.Status) ;
        system.debug ('### LOG ### cse.Famille__c =' + cse.Famille__c) ;
        system.debug ('### LOG ### cse.Famille__c =' + cse.Famille__c) ;
        system.debug ('### LOG ### cse.Motif__c =' + cse.Motif__c) ;
        system.debug ('### LOG ### cse.SousMotif__c =' + cse.SousMotif__c) ;   
        system.debug ('### LOG ### cse =' + cse) ;
        
        
        insert cse ;
        
        system.debug ('### LOG ### cse apres insert  =' + cse) ;
        
        Test.stopTest();
        
        Case caseVerif = [SELECT Id, AideReponseClient__c, TECH_FamilleMatrice__c, TECH_MotifMatrice__c, TECH_SousMotifMatrice__c
        					FROM Case WHERE Id = :cse.Id ];
        system.assertEquals( cont212.FamilleMatrice__c,  caseVerif.TECH_FamilleMatrice__c); 
        system.assertEquals( cont212.MotifMatrice__c,  caseVerif.TECH_MotifMatrice__c); 
        system.assertEquals( cont212.SousMotifMatrice__c,  caseVerif.TECH_SousMotifMatrice__c); 
        
        String aide = caseVerif.AideReponseClient__c;
        system.debug('## AP02_Case_Test ## Aide: ' + aide);
        /*system.assert( aide.startsWith('Pour répondre au client, veuillez cliquer sur le lien suivant'));
        system.assert( aide.contains(String.valueOf(templatePdf.Id)));
        system.assert( aide.contains(caseVerif.Id));*/
        
    }	
    
    @isTest 
    static void insertionCaseCourrierAuto2 (){
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
        init();
        
    	Test.startTest();
        system.debug('### LOG ### insertionCase start');
        
        // creation d'un Case
        Case cse = getNewCase211();
        cse.AccountId = accountCourrier2.ID;
        
        system.debug ('### LOG ### cse.Status =' + cse.Status) ;
        system.debug ('### LOG ### cse.Famille__c =' + cse.Famille__c) ;
        system.debug ('### LOG ### cse.Famille__c =' + cse.Famille__c) ;
        system.debug ('### LOG ### cse.Motif__c =' + cse.Motif__c) ;
        system.debug ('### LOG ### cse.SousMotif__c =' + cse.SousMotif__c) ;   
        system.debug ('### LOG ### cse =' + cse) ;
        
        
        insert cse ;
        
        Test.stopTest();
        
        verifJob(cse.Id, 'Un courrier a été généré.', '0', templatePdf.ID, cont211);
        
    }	
    
    private static void verifJob(ID cseId, String aide, String sendEmail, ID templateId, Contacts__c contacts) {
    	Case  caseVerif = [select id , TECH_FamilleMatrice__c, TECH_MotifMatrice__c , TECH_SousMotifMatrice__c ,Status ,
        	Famille__c , Motif__c , SousMotif__c , RecordTypeId, AideReponseClient__c   from Case where  id = :cseID  ] ;
        
        system.debug('### LOG ### caseVerif =' + caseVerif);
        
        system.assertEquals( contacts.FamilleMatrice__c,  caseVerif.TECH_FamilleMatrice__c); 
        system.assertEquals( contacts.MotifMatrice__c,  caseVerif.TECH_MotifMatrice__c); 
        system.assertEquals( contacts.SousMotifMatrice__c,  caseVerif.TECH_SousMotifMatrice__c); 
        //system.assert( caseVerif.AideReponseClient__c.startsWith(aide), 'message aide: ' + caseVerif.AideReponseClient__c 
        //	+' - attendu: ' + aide);
        
        
        List<SDOC__SDJob__c> jobs = [SELECT id, SDOC__Start__c, SDOC__Oid__c, SDOC__ObjApiName__c, SDOC__SendEmail__c, SDOC__Doclist__c 
        	FROM SDOC__SDJob__c];
        
        /*system.assertEquals(1, jobs.size(), 'Mauvais nombre de jobs');
        SDOC__SDJob__c job = jobs.get(0);
        system.debug('======= Job: ' + job);
        system.assertEquals(caseVerif.id, job.SDOC__Oid__c);
        system.assertEquals('Case', job.SDOC__ObjApiName__c);
        system.assertEquals(sendEmail, job.SDOC__SendEmail__c);
        system.assertEquals(templateId, job.SDOC__Doclist__c);*/
        //system.assert(job.SDOC__Start__c == true);
    }
    
    
    @isTest 
    static void insertionCase2 (){  
        
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
        init();
        
        Test.startTest();
        // creation d'un Case
        Case cse = getNewCaseAQualif();
        system.debug ('### LOG ### cse.Status =' + cse.Status) ;
        system.debug ('### LOG ### cse.Famille__c =' + cse.Famille__c) ;
        system.debug ('### LOG ### cse.Famille__c =' + cse.Famille__c) ;
        system.debug ('### LOG ### cse.Motif__c =' + cse.Motif__c) ;
        system.debug ('### LOG ### cse.SousMotif__c =' + cse.SousMotif__c) ;   
        
        insert cse ;
        
        verifAQualif(cse);
        
        Test.stopTest();
    }	
    
    @isTest 
    static void insertionCase3 (){  // mauvais sous motif -> pas de correspondance avec Contacts__c
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
        init();
        
    	Test.startTest();
        // creation d'un Case
        Case cse = getNewCase215();
        system.debug ('### LOG ### cse.Status =' + cse.Status) ;
        system.debug ('### LOG ### cse.Famille__c =' + cse.Famille__c) ;
        system.debug ('### LOG ### cse.Famille__c =' + cse.Famille__c) ;
        system.debug ('### LOG ### cse.Motif__c =' + cse.Motif__c) ;
        system.debug ('### LOG ### cse.SousMotif__c =' + cse.SousMotif__c) ;   
        
        insert cse ;
        
        verifAQualif(cse);
        
        Test.stopTest();
    }	
    
    @isTest 
    static void insertionCaseManuelle (){  // mauvais sous motif -> pas de correspondance avec Contacts__c
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
        init();
        
    	Test.startTest();
        // creation d'un Case
        Case cse = getNewCase213();
        system.debug ('### LOG ### cse.Status =' + cse.Status) ;
        system.debug ('### LOG ### cse.Famille__c =' + cse.Famille__c) ;
        system.debug ('### LOG ### cse.Famille__c =' + cse.Famille__c) ;
        system.debug ('### LOG ### cse.Motif__c =' + cse.Motif__c) ;
        system.debug ('### LOG ### cse.SousMotif__c =' + cse.SousMotif__c) ;   
        
        insert cse ;
        
        Case  caseVerif = [select id , TECH_FamilleMatrice__c, TECH_MotifMatrice__c , TECH_SousMotifMatrice__c ,Status , 
        	Famille__c , Motif__c , SousMotif__c , RecordTypeId, AideReponseClient__c   from Case where  id = :cse.ID  ] ;
        
        
        
        system.debug('### LOG ### caseVerif =' + caseVerif);
        
        system.assertEquals( cont213.FamilleMatrice__c,  caseVerif.TECH_FamilleMatrice__c); 
        system.assertEquals( cont213.MotifMatrice__c,  caseVerif.TECH_MotifMatrice__c); 
        system.assertEquals( cont213.SousMotifMatrice__c,  caseVerif.TECH_SousMotifMatrice__c); 
        //system.assertEquals('Pour répondre au client, veuillez sélectionner un modèle d\'email.', caseVerif.AideReponseClient__c);
        
        List<SDOC__SDJob__c> jobs = [SELECT id, SDOC__Start__c, SDOC__Oid__c, SDOC__ObjApiName__c, SDOC__SendEmail__c, SDOC__Doclist__c 
        	FROM SDOC__SDJob__c];
        
        system.assertEquals(0, jobs.size(), 'Mauvais nombre de jobs');
        
        Test.stopTest();
    }	
    
    static void verifAQualif(Case cse) {
        
        Case  caseVerif = [select id , TECH_FamilleMatrice__c, TECH_MotifMatrice__c , TECH_SousMotifMatrice__c ,Status , 
        	Famille__c , Motif__c , SousMotif__c , RecordTypeId, AideReponseClient__c   from Case where  id = :cse.ID  ] ;
        
        
        
        system.debug('### LOG ### caseVerif =' + caseVerif);
        
        /*system.assertEquals( null,  caseVerif.TECH_FamilleMatrice__c); 
        system.assertEquals( null,  caseVerif.TECH_MotifMatrice__c); 
        system.assertEquals( null,  caseVerif.TECH_SousMotifMatrice__c); 
        system.assertEquals('Veuillez qualifier le ticket', caseVerif.AideReponseClient__c);*/
        
        List<SDOC__SDJob__c> jobs = [SELECT id, SDOC__Start__c, SDOC__Oid__c, SDOC__ObjApiName__c, SDOC__SendEmail__c, SDOC__Doclist__c 
        	FROM SDOC__SDJob__c];
        
        system.assertEquals(0, jobs.size(), 'Mauvais nombre de jobs');
    }
    
     @isTest 
    static void insertionCaseUnreachable (){
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
        init();
        
    	Test.startTest();
        system.debug('### LOG ### insertionCase start');
        
        // creation d'un Case
        Case cse = getNewCase211();
        cse.AccountId = accountUnreachable.Id;
        
        system.debug ('### LOG ### cse.Status =' + cse.Status) ;
        system.debug ('### LOG ### cse.Famille__c =' + cse.Famille__c) ;
        system.debug ('### LOG ### cse.Famille__c =' + cse.Famille__c) ;
        system.debug ('### LOG ### cse.Motif__c =' + cse.Motif__c) ;
        system.debug ('### LOG ### cse.SousMotif__c =' + cse.SousMotif__c) ;   
        
        insert cse ;
        system.debug ('### LOG ### cse =' + cse) ;
        system.debug ('### LOG ### cse.AdresseEmail__c =' + cse.AdresseEmail__c) ;   
        
        Test.stopTest();
        
        Case caseVerif = [SELECT Id, AideReponseClient__c, TECH_FamilleMatrice__c, TECH_MotifMatrice__c, TECH_SousMotifMatrice__c
        					FROM Case WHERE Id = :cse.Id ];
        system.assertEquals( cont211.FamilleMatrice__c,  caseVerif.TECH_FamilleMatrice__c); 
        system.assertEquals( cont211.MotifMatrice__c,  caseVerif.TECH_MotifMatrice__c); 
        system.assertEquals( cont211.SousMotifMatrice__c,  caseVerif.TECH_SousMotifMatrice__c); 
        //system.assertEquals( 'Il n’est pas possible de contacter le client par email ou courrier.', 
        //                    caseVerif.AideReponseClient__c);
        
        List<SDOC__SDJob__c> jobs = [SELECT id, SDOC__Start__c, SDOC__Oid__c, SDOC__ObjApiName__c, SDOC__SendEmail__c, SDOC__Doclist__c 
        	FROM SDOC__SDJob__c];
        
        system.assertEquals(0, jobs.size(), 'Mauvais nombre de jobs');
    }	
    
    @isTest 
    static void insertionCaseUnreachable2 (){
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
        init();
        
    	Test.startTest();
        system.debug('### LOG ### insertionCase start');
        
        // creation d'un Case
        Case cse = getNewCase211();
        cse.AccountId = accountUnreachable2.Id;
        
        system.debug ('### LOG ### cse.Status =' + cse.Status) ;
        system.debug ('### LOG ### cse.Famille__c =' + cse.Famille__c) ;
        system.debug ('### LOG ### cse.Famille__c =' + cse.Famille__c) ;
        system.debug ('### LOG ### cse.Motif__c =' + cse.Motif__c) ;
        system.debug ('### LOG ### cse.SousMotif__c =' + cse.SousMotif__c) ;   
        
        insert cse ;
        system.debug ('### LOG ### cse =' + cse) ;
        system.debug ('### LOG ### cse.AdresseEmail__c =' + cse.AdresseEmail__c) ;   
        
        Test.stopTest();
        
        Case caseVerif = [SELECT Id, AideReponseClient__c, TECH_FamilleMatrice__c, TECH_MotifMatrice__c, TECH_SousMotifMatrice__c
        					FROM Case WHERE Id = :cse.Id ];
        system.assertEquals( cont211.FamilleMatrice__c,  caseVerif.TECH_FamilleMatrice__c); 
        system.assertEquals( cont211.MotifMatrice__c,  caseVerif.TECH_MotifMatrice__c); 
        system.assertEquals( cont211.SousMotifMatrice__c,  caseVerif.TECH_SousMotifMatrice__c); 
        //system.assertEquals( 'Il n’est pas possible de contacter le client par email ou courrier.', 
        //                    caseVerif.AideReponseClient__c);
        
        List<SDOC__SDJob__c> jobs = [SELECT id, SDOC__Start__c, SDOC__Oid__c, SDOC__ObjApiName__c, SDOC__SendEmail__c, SDOC__Doclist__c 
        	FROM SDOC__SDJob__c];
        
        system.assertEquals(0, jobs.size(), 'Mauvais nombre de jobs');
    }	
    
    @isTest 
    static void insertionListCase (){
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
        init();
        
        Test.startTest();

        List<Case> listCase = new list<Case>();
        Case cse = getNewCase211();
        listCase.add(cse);
        
        Case cse2 = getNewCase211();
        listCase.add(cse2);
        
        insert listCase ;
        
        ID cseID = cse.ID;
        system.debug ('### LOG ### cse apres insert  =' + cse) ;
        Case  caseVerif = [select id , TECH_FamilleMatrice__c, TECH_MotifMatrice__c , TECH_SousMotifMatrice__c ,Status , 
                           Famille__c , Motif__c , SousMotif__c , RecordTypeId   from Case where  id = :cseID  ] ;
        system.debug('### LOG ### caseVerif =' + caseVerif);
        system.assertEquals( cont211.FamilleMatrice__c,  caseVerif.TECH_FamilleMatrice__c); 
        system.assertEquals( cont211.MotifMatrice__c,  caseVerif.TECH_MotifMatrice__c); 
        system.assertEquals( cont211.SousMotifMatrice__c,  caseVerif.TECH_SousMotifMatrice__c); 
        
        
        ID cseID2 = cse2.ID;
        system.debug ('### LOG ### cse2 apres insert  =' + cse2) ;
        Case  caseVerif2 = [select id , TECH_FamilleMatrice__c, TECH_MotifMatrice__c , TECH_SousMotifMatrice__c ,Status , 
                            Famille__c , Motif__c , SousMotif__c , RecordTypeId   from Case where  id = :cseID2  ] ;
        system.debug('### LOG ### caseVerif2 =' + caseVerif2);
        system.assertEquals( cont211.FamilleMatrice__c,  caseVerif2.TECH_FamilleMatrice__c); 
        system.assertEquals( cont211.MotifMatrice__c,  caseVerif2.TECH_MotifMatrice__c); 
        system.assertEquals( cont211.SousMotifMatrice__c,  caseVerif2.TECH_SousMotifMatrice__c); 
        
        
        Test.stopTest();
        
    }
    
    @isTest 
    static void updateCaseCourrierAuto (){
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
        init();
        
    	Test.startTest();
        system.debug('### LOG ### insertionCase start');
        
        // creation d'un Case
        Case cse = getNewCaseAQualif();
        cse.AccountId = accountCourrier.ID;
        
        system.debug ('### LOG ### cse.Status =' + cse.Status) ;
        system.debug ('### LOG ### cse.Famille__c =' + cse.Famille__c) ;
        system.debug ('### LOG ### cse.Famille__c =' + cse.Famille__c) ;
        system.debug ('### LOG ### cse.Motif__c =' + cse.Motif__c) ;
        system.debug ('### LOG ### cse.SousMotif__c =' + cse.SousMotif__c) ;   
        system.debug ('### LOG ### cse =' + cse) ;
        
        
        insert cse ;
        
        verifAQualif(cse);
        
        Case case211 = getNewCase211();
        cse.Famille__c = case211.Famille__c;
        cse.Motif__c = case211.Motif__c;
        cse.SousMotif__c = case211.SousMotif__c;
        
        update cse;
        
        Test.stopTest();
        
        verifJob(cse.Id, 'Un courrier a été généré.', '0', templatePdf.ID, cont211);
        
    }	
    
    
    @isTest 
    static void updateOwnerOnCase(){	
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
        init();
        
        // Création d'un complexe
        Complexe__c complexe = new Complexe__c();
        QueueSobject so = [SELECT Id, Queue.DeveloperName, QueueId, SobjectType FROM QueueSobject WHERE SobjectType  = 'Case' Limit 1].get(0);
        
        complexe.Name = 'UGC TEST COMPLEXE';
        complexe.CodePays__c = '033';
        complexe.CodePostal__c = 77200;
        complexe.EstActif__c = true;
        complexe.Rue__c = '28 rue pierre mendes france';
        complexe.Ville__c = 'Torcy';
        complexe.TECH_QueueName__c = so.Queue.DeveloperName;
        insert complexe;
        
        system.debug('### LOG ### complexe =' + complexe);
        
        system.assert(complexe.Id != null); 
        
        Test.startTest();
        // creation d'un Case
        Case cse = getNewCase215();		
        cse.cinema__c = complexe.ID;
        
        
        insert cse;
        
        system.assert(cse.Id != null);
        cse.Actions__c = 'Transfert à la salle';
        
        
        // L'owner Id ne change pas?
        system.debug('-----### complexe.TECH_QueueName__c =  ' + complexe.TECH_QueueName__c );
        system.debug('-----### complexe.QueueId =  ' + so.QueueId );
        system.debug('-----### LOG ### Update CASE: ' + cse.OwnerId );
        update cse;
        system.debug('-----### LOG ### Updated CASE: ' + cse.OwnerId );
 
 
 		List<Case> cases = new List<Case>();
 		cases.add(cse);
 		List<Id> complexIds = new List<Id>();
 		complexIds.add(complexe.ID);
 		
// 		AP02_Case.updateOwnerOnTransferedCase(cases, complexIds);     
        //system.assertEquals( so.QueueId, cse.ownerId , 'L\'ownerId du Case n\'est pas l\'ID de la queue');
        
        Test.stopTest();
        
    }
    /*
    @isTest 
    static void insertUpdateOwnerOnCase(){	
        Test.startTest();
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
        init();
        
        // Création d'un complexe
        Complexe__c complexe = new Complexe__c();
        QueueSobject so = [SELECT Id, Queue.DeveloperName, QueueId, SobjectType FROM QueueSobject WHERE SobjectType  = 'Case' Limit 1].get(0);
        
        complexe.Name = 'UGC TEST COMPLEXE';
        complexe.CodePays__c = '033';
        complexe.CodePostal__c = 77200;
        complexe.EstActif__c = true;
        complexe.Rue__c = '28 rue pierre mendes france';
        complexe.Ville__c = 'Torcy';
        complexe.TECH_QueueName__c = so.QueueId;
        insert complexe;
        
        system.debug('### LOG ### complexe =' + complexe);
        
        system.assert(complexe.Id != null);
        
        // creation d'un Case
        Case cse = getNewCase215();		
        cse.cinema__c = complexe.ID;
        cse.Actions__c = 'Transfert à la salle';
        
        insert cse;     
        system.assertEquals( so.QueueId, cse.ownerId , 'L\'ownerId du Case n\'est pas l\'ID de la queue');
        
        Test.stopTest();
        
    }
    
    */
    
    @IsTest
    static void testUpdateFacebook() {
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
        init();
        
    	Test.startTest();
    	Case cse = getNewCase211() ;
    	cse.accountId = null;
    	cse.TECH_idFacebook__c = 'id SN';
    	insert cse;
    	
    	cse.AccountId = accountEmail.Id;
    	update cse;
    	Test.stopTest();
    	Account acc = [SELECT Id, TECH_idCritizr__c, TECH_idFacebook__c, TECH_idInstagram__c, TECH_idTwitter__c 
    								FROM Account WHERE Id = :accountEmail.Id];
    	//system.assertEquals('id SN', acc.TECH_idFacebook__c);
    }
    
    @IsTest
    static void testUpdateTwitter() {
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
        init();
        
    	Test.startTest();
    	Case cse = getNewCase211() ;
    	cse.accountId = null;
    	cse.TECH_idTwitter__c = 'id SN';
    	insert cse;
    	
    	cse.AccountId = accountEmail.Id;
    	update cse;
    	Test.stopTest();
    	Account acc = [SELECT Id, TECH_idCritizr__c, TECH_idFacebook__c, TECH_idInstagram__c, TECH_idTwitter__c
    								FROM Account WHERE Id = :accountEmail.Id];
    	//system.assertEquals('id SN', acc.TECH_idTwitter__c);
    }
    
    @IsTest
    static void testUpdateInstagram() {
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
        init();
        
    	Test.startTest();
    	Case cse = getNewCase211() ;
    	cse.accountId = null;
    	cse.TECH_idInstagram__c = 'id SN';
    	insert cse;
    	
    	cse.AccountId = accountEmail.Id;
    	update cse;
    	Test.stopTest();
    	Account acc = [SELECT Id, TECH_idCritizr__c, TECH_idFacebook__c, TECH_idInstagram__c, TECH_idTwitter__c
    								FROM Account WHERE Id = :accountEmail.Id];
    	//system.assertEquals('id SN', acc.TECH_idInstagram__c);
    }
    
    @IsTest
    static void testUpdateCritizr() {
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
        init();
        
    	Test.startTest();
    	Case cse = getNewCase211() ;
    	cse.accountId = null;
    	cse.TECH_idCritizr__c = 'id SN';
    	insert cse;
    	
    	cse.AccountId = accountEmail.Id;
    	update cse;
    	Test.stopTest();
    	Account acc = [SELECT Id, TECH_idCritizr__c, TECH_idFacebook__c, TECH_idInstagram__c, TECH_idTwitter__c
    								FROM Account WHERE Id = :accountEmail.Id];
    	//system.assertEquals('id SN', acc.TECH_idCritizr__c);
    }
}