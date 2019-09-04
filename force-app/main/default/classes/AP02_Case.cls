/**
* @description : Classe a utiliser en trigger after durant la creation d'un nouvel account
*                Les nouveaux account crees sont envoye au WS RCU UGC
* @author yann d'ALMEIDA 
*/
public class AP02_Case {
	
	public static String TECHIdStatut_007AD = '007AD';	//0- Souscription -> 07- Creation Abonnement 	-> AD- Action DRC
	public static String TECHIdStatut_005AD = '005AD';	//0- Souscription -> 05- B2B 					-> AD- Action DRC
	public static String TECHIdStatut_005AH = '005AH';	//0- Souscription -> 05- B2B 					-> AH- Action Selfcare
	public static String TECHIdStatut_007AH = '007AH';	//0- Souscription -> 07- Creation Abonnement 	-> AH- Action Selfcare
	public static String TECHIdStatut_007AS = '007AS';	//0- Souscription -> 07- Creation Abonnement 	-> AS- Action Stand
    
    // methode pour envoyer les informations du nouvel account au RCU UGC pour validation 
    public static void processTriggerBeforeInsert (List<Case> cases)  {   
        
        system.debug ('--#### Nombre de case à créer =' + cases.size()) ; 

        // Mise à jour des champs tech sur Case à partir des données Contact__c
        List<Case> casesGroupementLst = new List<Case>();
        List<Case> casesQueueOwnerLst = new List<Case>();
        List<Id> complexesId = new List<Id>();
        map<Id, list<Case>> mapListCaseByAccId = new map<Id, list<Case>>();
        set<Id> setAccId = new set<Id>();

        for(Case caseToCre : cases){

            // Identification des cases à transférer
            if(caseToCre.Actions__c == 'Transfert à la salle' && caseToCre.Cinema__c != null){
                casesQueueOwnerLst.add(caseToCre);
                complexesId.add(caseToCre.Cinema__c);
            }

           if(caseToCre.Famille__c!=null && caseToCre.Motif__c!=null && caseToCre.SousMotif__c!=null ){
               casesGroupementLst.add(caseToCre);                
            }
            
            if(caseToCre.AccountId != null){
            	if(!mapListCaseByAccId.containsKey(caseToCre.AccountId)){
            		 mapListCaseByAccId.put(caseToCre.AccountId, new list<Case>());
            	}
	            mapListCaseByAccId.get(caseToCre.AccountId).add(caseToCre);
	            setAccId.add(caseToCre.AccountId);
            }
        }

        // Appel de la méthode de maj des champs Tech famille, motif et sous motif
        system.debug ('--#### Nombre de case impactés par les maj de tech famille/motif/sous-motif =' + casesGroupementLst.size()) ; 
        if(casesGroupementLst.size() > 0){
            updateTechFamMotifSousMotif(casesGroupementLst);            
        }

        // Appel de méthode de maj du Owner
        system.debug ('--#### Nombre de case impactés par les maj du case owner =' + casesQueueOwnerLst.size()) ; 
        if(casesQueueOwnerLst.size() > 0){
            updateOwnerOnTransferedCase(casesQueueOwnerLst, complexesId);
        }
        for(Case cse: casesQueueOwnerLst) {
            system.debug('## AP02_Case ## Owner : ' + cse.ownerId);
            
        }
        
        //MNE_31-07-2018
        getCaseRecordType(cases);
        
        //MNE_22-11-2018
        initDesaboDate (cases);
        
        //MNE_04-04-2019
        initSubscriptionId(mapListCaseByAccId, setAccId);
    }
    
    
    public static void processTriggerAfterInsert (List<Case> cases)  {   
        
        system.debug ('--#### Nombre de case à créer =' + cases.size()) ; 

        // Mise à jour des champs tech sur Case à partir des données Contact__c
        List<Case> casesGroupementLst = new List<Case>();

        for(Case caseToCre : cases){

           if(caseToCre.Famille__c!=null && caseToCre.Motif__c!=null && caseToCre.SousMotif__c!=null ){
               casesGroupementLst.add(caseToCre);                
            }

           if(caseToCre.Famille__c!=null && caseToCre.Motif__c!=null){
               if(caseToCre.Famille__c.equals('1VieAbonnement') && caseToCre.Motif__c.equals('06MigrationUI123') && String.isNotBlank(caseToCre.CreditMemoId__c))
               createReboursementCase(caseToCre);          
           }

        }

        // Appel de la méthode de maj des champs Tech famille, motif et sous motif
        system.debug ('--#### Nombre de case impactés par les maj de tech famille/motif/sous-motif =' + casesGroupementLst.size()) ; 
        if(casesGroupementLst.size() > 0){
            makeSdocJobs(casesGroupementLst);            
        }

    }
        
    // methode pour envoyer les informations du nouvel account au RCU UGC pour validation 
    public static void processTriggerBeforeUpdate (Map<Id, Case> mapOldCases, Map<Id, Case> mapNewCases)  {   
        
        system.debug ('--#### Nombre de case à mettre à jour = ' + mapNewCases.values().size()); 

        // Mise à jour des champs tech sur Case à partir des données Contact__c
        List<Case> casesGroupementLst = new List<Case>();
        List<Case> casesQueueOwnerLst = new List<Case>();
        List<Id> complexesId = new List<Id>();
        map<Id, list<Case>> mapListCaseByAccId = new map<Id, list<Case>>();
        set<Id> setAccId = new set<Id>();
        
        

        for(Case caseToUpd : mapNewCases.values()){
            Case oldCase = mapOldCases.get(caseToUpd.Id);
            // Identification des case dont les champs Tech famille, motif et sous motif sont à maj
           if((caseToUpd.Famille__c!=null && !caseToUpd.Famille__c.equals(oldCase.Famille__c)) ||
              (caseToUpd.Motif__c!=null && !caseToUpd.Motif__c.equals(oldCase.Motif__c)) ||
              (caseToUpd.SousMotif__c!=null && !caseToUpd.SousMotif__c.equals(oldCase.SousMotif__c)) ){
               casesGroupementLst.add(caseToUpd);                
            }

            // Identification des cases à transférer
            if(caseToUpd.Actions__c != oldCase.Actions__c &&  caseToUpd.Actions__c == 'Transfert à la salle'
                && caseToUpd.Cinema__c != null) {
                    
                casesQueueOwnerLst.add(caseToUpd);
                complexesId.add(caseToUpd.Cinema__c);
                system.debug('======== added case ' + caseToUpd);
            }
            
            if(caseToUpd.AccountId != null){
            	if(!mapListCaseByAccId.containsKey(caseToUpd.AccountId)){
            		 mapListCaseByAccId.put(caseToUpd.AccountId, new list<Case>());
            	}
	            mapListCaseByAccId.get(caseToUpd.AccountId).add(caseToUpd);
	            setAccId.add(caseToUpd.AccountId);
            }
            
        }

        // Appel de la méthode de maj des champs Tech famille, motif et sous motif
        system.debug ('--#### Nombre de case impactés par les maj de tech famille/motif/sous-motif =' + casesGroupementLst.size()) ;
        if(casesGroupementLst.size() > 0){
            updateTechFamMotifSousMotif(casesGroupementLst);
        }

        // Appel de méthode de maj du Owner
        system.debug ('--#### Nombre de case impactés par les maj du case owner =' + casesQueueOwnerLst.size()) ; 
        if(casesQueueOwnerLst.size() > 0){
            updateOwnerOnTransferedCase(casesQueueOwnerLst, complexesId);
        }
        
        //MNE_31-07-2018
        getCaseRecordType(mapNewCases.values());
        
        //MNE_22-11-2018
        initDesaboDate (mapNewCases.values());
        
        //MNE_04-04-2019
        initSubscriptionId(mapListCaseByAccId, setAccId);
    }
    
    
    public static void processTriggerAfterUpdate (Map<Id, Case> mapOldCases, Map<Id, Case> mapNewCases)  {   
        
        system.debug ('--#### Nombre de case à mettre à jour = ' + mapNewCases.values().size()); 

        // Mise à jour des champs tech sur Case à partir des données Contact__c
        List<Case> casesGroupementLst = new List<Case>();
        List<Case> casesSocialNetwork = new List<Case>();

        for(Case caseToUpd : mapNewCases.values()){
            Case oldCase = mapOldCases.get(caseToUpd.Id);

            // Identification des case dont les champs Tech famille, motif et sous motif sont à maj
           if((caseToUpd.Famille__c!=null && !caseToUpd.Famille__c.equals(oldCase.Famille__c)) ||
              (caseToUpd.Motif__c!=null && !caseToUpd.Motif__c.equals(oldCase.Motif__c)) ||
              (caseToUpd.SousMotif__c!=null && !caseToUpd.SousMotif__c.equals(oldCase.SousMotif__c)) ){
               casesGroupementLst.add(caseToUpd);                
            }


            // TODO: utiliser compte inconnu
            if(caseToUpd.AccountId != null && oldCase.AccountId == null 
                && (caseToUpd.TECH_idCritizr__c != null || caseToUpd.TECH_idFacebook__c != null || caseToUpd.TECH_idInstagram__c != null || caseToUpd.TECH_idTwitter__c != null)) {
                casesSocialNetwork.add(caseToUpd);
            }
        }

        // Appel de la méthode de maj des champs Tech famille, motif et sous motif
        system.debug ('--#### Nombre de case impactés par les maj de tech famille/motif/sous-motif =' + casesGroupementLst.size()) ;
        if(casesGroupementLst.size() > 0){
            makeSdocJobs(casesGroupementLst);
        }
        
        
        // Appel de méthode update SN
        system.debug ('--#### Nombre de case impactés par les maj de l\'account =' + casesSocialNetwork.size()) ; 
        if(casesSocialNetwork.size() > 0){
            updateAccountOnReconciliationSN(casesSocialNetwork);
        }
        
    }
    
    private static Boolean isEmpty(String s) {
        return s == null || s.toUpperCase().replace('<BR>', '').trim() == '';
    }
    
    private static String getTypeTemplateUsed(Case c, Account account) {
        if(account == null) {
            system.debug('--#### Account null');
            return null;
        }
        system.debug('--#### IN NPAIEMAIL__c ' + account.NPAIEMAIL__c);
        system.debug('--#### IN PNDADRESSE__c ' + account.PNDADRESSE__c);
        if(!account.NPAIEMAIL__c && !isEmpty(c.AdresseEmail__c)) {
            system.debug('--#### IN AdresseEmail__c not null ');
            return 'HTML';
        } else if(!account.PNDADRESSE__c && !isEmpty(c.AdressePostale__c) ) {
            system.debug('--#### IN AdresseEmail__c null OR NPAIEMAIL__c = true');
            system.debug('--#### IN AdressePostale__c not null');
            return 'PDF';
        } 
        system.debug('--#### Pas d\'envoi');
        return null;
    }
    
    private static String getHelpMsgChooseTemplate(Case c, Account account) {
        if(account == null) {
            system.debug('--#### Account null');
            return null;
        }
        system.debug('--#### IN NPAIEMAIL__c ' + account.NPAIEMAIL__c);
        system.debug('--#### IN PNDADRESSE__c ' + account.PNDADRESSE__c);
        if(!account.NPAIEMAIL__c && c.AdresseEmail__c != null && !isEmpty(c.AdresseEmail__c) ) {
            return 'Pour répondre au client, veuillez sélectionner un modèle d\'email.';
        } else if (!account.PNDADRESSE__c && !isEmpty(c.AdressePostale__c) ) {
            return 'Pour répondre au client, veuillez sélectionner un modèle de courrier.';
        } else {
            return 'Il n’est pas possible de contacter le client par email ou courrier.';
        }
    }

    // methode pour envoyer les informations du nouvel account au RCU UGC pour validation 
    public static void updateTechFamMotifSousMotif (List<Case> cases)  {   
        
        Set<String> statutCaseSet = new Set<String>();
        
        // recuperation de la liste des "id statut" de case
        for (Case c : cases) {
            if (c.TECHIdStatut__c != null) {
                statutCaseSet.add(c.TECHIdStatut__c);
            }
        }

        // recuperation des contacts qui possèdent les "id statut"  presents dans la list statutCaseSet 
        // ( contact qui ont le meme statut id que case)
        List<Contacts__c> contactsLst = [SELECT Id, name, FamilleMatrice__c, MotifMatrice__c, SousMotifMatrice__c, 
                                            Reponse__c, NomModeleCourrierEmail__c, NomModeleEmailHTML__c
                                            FROM Contacts__c
                                            WHERE Name IN :statutCaseSet];
        
        // Préparation d'une Map<idStatut, Contacts__c>
        Map<String, Contacts__c> mapIdStatutContacts = new Map<String, Contacts__c>();
        for(Contacts__c c : contactsLst){
            mapIdStatutContacts.put(c.Name, c);
        }
        
        
        
        // maj de case a partir de la Map 
        for (Case c : cases) {
            
            if (c.TECHIdStatut__c != null) {

                Contacts__c contacts = mapIdStatutContacts.get(c.TECHIdStatut__c);
                if(contacts!=null) {
                    c.TECH_FamilleMatrice__c    = contacts.FamilleMatrice__c  ;
                    c.TECH_MotifMatrice__c      = contacts.MotifMatrice__c  ;
                    c.TECH_SousMotifMatrice__c  = contacts.SousMotifMatrice__c ;
                    
                }else{
                    c.TECH_FamilleMatrice__c    = null  ;
                    c.TECH_MotifMatrice__c      = null ;
                    c.TECH_SousMotifMatrice__c  = null ;                
                    c.AideReponseClient__c = 'Veuillez qualifier le ticket';        
                }
                                    
            } else {
                c.TECH_FamilleMatrice__c    = null  ;
                c.TECH_MotifMatrice__c      = null ;
                c.TECH_SousMotifMatrice__c  = null ;    
                c.AideReponseClient__c = 'Veuillez qualifier le ticket';                    
           }
        }



        system.debug('--#### OUT OF CASE BOUCLE');
    }
    
    public static void makeSdocJobs(List<Case> cases) {
        Set<String> statutCaseSet = new Set<String>();
        Set<String> accountIdSet = new Set<String>();
        Map<ID, Case> mapCases = new Map<ID, Case>();
        
        // recuperation de la liste des "id statut" de case
        for (Case c : cases) {
            mapCases.put(c.Id, c);
            
            if (c.TECHIdStatut__c != null) {
                statutCaseSet.add(c.TECHIdStatut__c);
            }
            if(c.AccountId != null){
                accountIdSet.add(c.AccountId);
            }
        }

        system.debug('#### accountIdSet SIZE = ' + accountIdSet.size());
        
        // recuperation des contacts qui possèdent les "id statut"  presents dans la list statutCaseSet 
        // ( contact qui ont le meme statut id que case)
        List<Contacts__c> contactsLst = [SELECT Id, name, FamilleMatrice__c, MotifMatrice__c, SousMotifMatrice__c, 
                                            Reponse__c, 
                                            NomModeleCourrierEmail__c, NomModeleEmailHTML__c,
                                            Nom_du_mod_le_courrier_UU_fran_ais_pdf__c, Nom_du_mod_le_email_UU_fran_ais_HTML__c,
                                            Nom_du_mod_le_courrier_UU_n_erlandais__c, Nom_du_mod_le_email_UU_n_erlandais__c
                                            FROM Contacts__c
                                            WHERE Name IN :statutCaseSet];
        
        
        //recupération des nom des template utilises dans les contacts
        Set<String> nomModelSdocSet = New Set<String>();
        for(Contacts__c c : contactsLst){
            /*nomModelSdocSet.add(c.NomModeleCourrierEmail__c);
            nomModelSdocSet.add(c.NomModeleEmailHTML__c);
            nomModelSdocSet.add(c.Nom_du_mod_le_courrier_UU_fran_ais_pdf__c);
            nomModelSdocSet.add(c.Nom_du_mod_le_email_UU_fran_ais_HTML__c);
            nomModelSdocSet.add(c.Nom_du_mod_le_courrier_UU_n_erlandais__c);
            nomModelSdocSet.add(c.Nom_du_mod_le_email_UU_n_erlandais__c);*/
            
            if(String.isNotBlank(c.NomModeleCourrierEmail__c))
	            nomModelSdocSet.addAll(c.NomModeleCourrierEmail__c.split(';'));
	        if(String.isNotBlank(c.NomModeleEmailHTML__c))
	            nomModelSdocSet.addAll(c.NomModeleEmailHTML__c.split(';'));
 			if(String.isNotBlank(c.Nom_du_mod_le_courrier_UU_fran_ais_pdf__c))
	            nomModelSdocSet.addAll(c.Nom_du_mod_le_courrier_UU_fran_ais_pdf__c.split(';'));
	        if(String.isNotBlank(c.Nom_du_mod_le_email_UU_fran_ais_HTML__c))    
	            nomModelSdocSet.addAll(c.Nom_du_mod_le_email_UU_fran_ais_HTML__c.split(';'));
	        if(String.isNotBlank(c.Nom_du_mod_le_courrier_UU_n_erlandais__c))    
	            nomModelSdocSet.addAll(c.Nom_du_mod_le_courrier_UU_n_erlandais__c.split(';'));
	         if(String.isNotBlank(c.Nom_du_mod_le_email_UU_n_erlandais__c))   
	            nomModelSdocSet.addAll(c.Nom_du_mod_le_email_UU_n_erlandais__c.split(';'));
        }
        system.debug('--#### nomModelSdocSet SIZE = ' + nomModelSdocSet.size());
        
        
        //recuperation des ID des templates
        List<SDOC__SDTemplate__c> nomModelSdocList = [SELECT Id, Name 
                                                        FROM SDOC__SDTemplate__c
                                                        WHERE Name IN :nomModelSdocSet];
        
        system.debug('--#### nomModelSdocList SIZE = ' + nomModelSdocList.size());
        
        Map<String, Id> mapNomSdocsIdSdocs = new Map<String, Id>();
        for(SDOC__SDTemplate__c sdocTemplate : nomModelSdocList){
            system.debug('--#### SDOC NAME AND SDOC ID SIZE = ' + sdocTemplate.Name + ' ' + sdocTemplate.Id);
            mapNomSdocsIdSdocs.put(sdocTemplate.Name, sdocTemplate.Id);
        }
        
        // Préparation d'une Map<idStatut, Contacts__c>
        Map<String, Contacts__c> mapIdStatutContacts = new Map<String, Contacts__c>();
        for(Contacts__c c : contactsLst){
            mapIdStatutContacts.put(c.Name, c);
        }
        
        
        List< SDOC__SDJob__c> jobList = new List< SDOC__SDJob__c> ();
        List<Task> taskToInsert = new List<Task> ();
        
        List<Case> casesToUpdate = [SELECT Id, TECHIdStatut__c, Account.Id, Account.NPAIEMAIL__c, Account.PNDADRESSE__c, 
            AideReponseClient__c, AdresseEmail__c, AdressePostale__c , OwnerId,
            Account.ProduitUGC__c, Account.CodePays__c, Account.Langue__c, Description, Subject, ContactId
            FROM Case WHERE Id IN :mapCases.keySet()];
        
        // maj de case a partir de la Map 
        for (Case c : casesToUpdate) {
            
            if (c.TECHIdStatut__c != null) {

                Contacts__c contacts = mapIdStatutContacts.get(c.TECHIdStatut__c);
                if(contacts!=null){
                    system.debug('--#### CASE ACCOUNT = ' + c.Account.Id);
                    Account acc = c.Account;
                    
                    String courrierTemplateName = '';
                    String emailTemplateName = '';
                    
                    if(acc.CodePays__c == '033'){
                        courrierTemplateName = contacts.NomModeleCourrierEmail__c;
                        emailTemplateName    = contacts.NomModeleEmailHTML__c;
                    } 
                    else if(acc.CodePays__c == '032' && acc.Langue__c == 'FR'){
                        courrierTemplateName = contacts.Nom_du_mod_le_courrier_UU_fran_ais_pdf__c;
                        emailTemplateName    = contacts.Nom_du_mod_le_email_UU_fran_ais_HTML__c;
                    }
                    else if(acc.CodePays__c == '032' && acc.Langue__c == 'NL'){
                        courrierTemplateName = contacts.Nom_du_mod_le_courrier_UU_n_erlandais__c;
                        emailTemplateName    = contacts.Nom_du_mod_le_email_UU_n_erlandais__c;
                    } else {
                        system.debug('##MNE Langue du template impossible a definir >> acc.CodePays__c = '+acc.CodePays__c+' et acc.Langue__c = '+ acc.Langue__c);
                        continue;
                    }

                    String typeTemplate = getTypeTemplateUsed(c, acc);
                    
                        
                    if(contacts.Reponse__c == 'Automatique') {
                        system.debug('--#### IN AUTOMATIQUE');
                        if(typeTemplate == null) {
                            c.AideReponseClient__c = getHelpMsgChooseTemplate(c, acc);
                        }
                        
                        else if(c.TECHIdStatut__c == TECHIdStatut_007AD || c.TECHIdStatut__c == TECHIdStatut_005AD || c.TECHIdStatut__c == TECHIdStatut_007AS){
                        	if(String.isNotBlank(courrierTemplateName)){
	                        	list<String> listCourrierTemplateName = courrierTemplateName.split(';');
	                        	for(String courrierTemplateNameTMP : listCourrierTemplateName){
	                        		courrierTemplateNameTMP = courrierTemplateNameTMP.trim();
	                        		if(mapNomSdocsIdSdocs.containsKey(courrierTemplateNameTMP)){
	                        			SDOC__SDJob__c job = new SDOC__SDJob__c(
			                                SDOC__Start__c=true, 
			                                SDOC__Oid__c=c.Id, 
			                                SDOC__ObjApiName__c='Case', 
			                                SDOC__SendEmail__c='0',
			                                SDOC__Doclist__c= mapNomSdocsIdSdocs.get(courrierTemplateNameTMP));
	                            		jobList.add(job);
			                            taskToInsert.add(createTask('courrier', c));
			                            c.AideReponseClient__c = 'Un courrier a été généré.';
	                        		}
	                        	}
                        	}
                        }
                        
                        else if(c.TECHIdStatut__c == TECHIdStatut_005AH || c.TECHIdStatut__c == TECHIdStatut_007AH){
                        	if(String.isNotBlank(courrierTemplateName)){
	                        	list<String> listCourrierTemplateName = courrierTemplateName.split(';');
	                        	for(String courrierTemplateNameTMP : listCourrierTemplateName){
	                        		courrierTemplateNameTMP = courrierTemplateNameTMP.trim();
	                        		if(mapNomSdocsIdSdocs.containsKey(courrierTemplateNameTMP)){
	                        			SDOC__SDJob__c job = new SDOC__SDJob__c(
			                                SDOC__Start__c=true, 
			                                SDOC__Oid__c=c.Id, 
			                                SDOC__ObjApiName__c='Case', 
			                                SDOC__SendEmail__c='0',
			                                SDOC__Doclist__c= mapNomSdocsIdSdocs.get(courrierTemplateNameTMP));
	                            		jobList.add(job);
			                            taskToInsert.add(createTask('courrier', c));
			                            c.AideReponseClient__c = 'Un courrier a été généré.';
	                        		}
	                        	}
                        	}
                        	if(String.isNotBlank(emailTemplateName)){
	                        	list<String> listEmailTemplateName = emailTemplateName.split(';');
	                        	for(String emailTemplateNameTMP : listEmailTemplateName){
	                        		emailTemplateNameTMP = emailTemplateNameTMP.trim();
	                        		if(mapNomSdocsIdSdocs.containsKey(emailTemplateNameTMP)){
	                        			SDOC__SDJob__c job = new SDOC__SDJob__c(
	                                		SDOC__Start__c=true, 
	                                		SDOC__Oid__c=c.Id, 
	                                		SDOC__ObjApiName__c='Case', 
	                                		SDOC__SendEmail__c='1',
	                                		SDOC__Doclist__c= mapNomSdocsIdSdocs.get(emailTemplateNameTMP));
	                            		jobList.add(job);
	                            		taskToInsert.add(createTask('email', c));
	                            		c.AideReponseClient__c = 'Un email a été envoyé au client.';
	                        		}
	                        	}
                        	}
                        }

                        /*if(typeTemplate == 'HTML' && mapNomSdocsIdSdocs.containsKey(emailTemplateName)) {
                            system.debug('--#### Nom Modele Email >> ' + mapNomSdocsIdSdocs.get(emailTemplateName));
                            SDOC__SDJob__c job = new SDOC__SDJob__c(
                                SDOC__Start__c=true, 
                                SDOC__Oid__c=c.Id, 
                                SDOC__ObjApiName__c='Case', 
                                SDOC__SendEmail__c='1',
                                SDOC__Doclist__c= mapNomSdocsIdSdocs.get(emailTemplateName));
                            jobList.add(job);
                            taskToInsert.add(createTask('email', c));
                            c.AideReponseClient__c = 'Un email a été envoyé au client.';

                        } else if(typeTemplate == 'PDF' && mapNomSdocsIdSdocs.containsKey(courrierTemplateName)) {
                            system.debug('--#### Nom Modele Courrier >> ' + mapNomSdocsIdSdocs.get(courrierTemplateName));
                            SDOC__SDJob__c job = new SDOC__SDJob__c(
                                SDOC__Start__c=true, 
                                SDOC__Oid__c=c.Id, 
                                SDOC__ObjApiName__c='Case', 
                                SDOC__SendEmail__c='0',
                                SDOC__Doclist__c= mapNomSdocsIdSdocs.get(courrierTemplateName));
                            jobList.add(job);
                            taskToInsert.add(createTask('courrier', c));
                            c.AideReponseClient__c = 'Un courrier a été généré.';
                        }*/
                        
                        else if(typeTemplate == 'HTML' && String.isNotBlank(emailTemplateName)){
                        	list<String> listEmailTemplateName = emailTemplateName.split(';');
                        	for(String emailTemplateNameTMP : listEmailTemplateName){
                        		emailTemplateNameTMP = emailTemplateNameTMP.trim();
                        		if(mapNomSdocsIdSdocs.containsKey(emailTemplateNameTMP)){
                        			SDOC__SDJob__c job = new SDOC__SDJob__c(
                                		SDOC__Start__c=true, 
                                		SDOC__Oid__c=c.Id, 
                                		SDOC__ObjApiName__c='Case', 
                                		SDOC__SendEmail__c='1',
                                		SDOC__Doclist__c= mapNomSdocsIdSdocs.get(emailTemplateNameTMP));
                            		jobList.add(job);
                            		taskToInsert.add(createTask('email', c));
                            		c.AideReponseClient__c = 'Un email a été envoyé au client.';
                        		}
                        	}
                        	
                        } else if(typeTemplate == 'PDF' && String.isNotBlank(courrierTemplateName)){
                        	list<String> listCourrierTemplateName = courrierTemplateName.split(';');
                        	for(String courrierTemplateNameTMP : listCourrierTemplateName){
                        		courrierTemplateNameTMP = courrierTemplateNameTMP.trim();
                        		if(mapNomSdocsIdSdocs.containsKey(courrierTemplateNameTMP)){
                        			SDOC__SDJob__c job = new SDOC__SDJob__c(
		                                SDOC__Start__c=true, 
		                                SDOC__Oid__c=c.Id, 
		                                SDOC__ObjApiName__c='Case', 
		                                SDOC__SendEmail__c='0',
		                                SDOC__Doclist__c= mapNomSdocsIdSdocs.get(courrierTemplateNameTMP));
                            		jobList.add(job);
		                            taskToInsert.add(createTask('courrier', c));
		                            c.AideReponseClient__c = 'Un courrier a été généré.';
                        		}
                        	}
                        }
                        
                        
                    } else if(contacts.Reponse__c == 'Semi-automatique'){
                        system.debug('--#### IN SEMI AUTOMATIQUE');
                        /*
                        if(typeTemplate == 'HTML') {
                            system.debug('--#### NomModeleEmailHTML__c = ' + mapNomSdocsIdSdocs.get(contacts.NomModeleEmailHTML__c));
                                                        
                            String url = '/apex/SDOC__SDCreate1?id=' + c.Id + '&Object=Case&doclist=' 
                                + mapNomSdocsIdSdocs.get(contacts.NomModeleEmailHTML__c) + '&prepemail=1';
                            c.AideReponseClient__c = 'Pour répondre au client, veuillez cliquer sur le lien suivant : « ' + url + ' ». ';
                        } else if(typeTemplate == 'PDF') {
                            system.debug('--#### NomModeleCourrierEmail__c = ' + mapNomSdocsIdSdocs.get(contacts.NomModeleCourrierEmail__c));
                            
                            String url = '/apex/SDOC__SDCreate1?id=' + c.Id + '&Object=Case&doclist=' 
                                + mapNomSdocsIdSdocs.get(contacts.NomModeleCourrierEmail__c) + '&oneclick=false'; 
                            c.AideReponseClient__c = 'Pour répondre au client, veuillez cliquer sur le lien suivant : « ' + url + ' ». ';
                        } else {
                            
                            c.AideReponseClient__c = getHelpMsgChooseTemplate(c, acc);
                        }
                        
                        system.debug('## AP02_Case ## Aidereponse: ' + c.AideReponseClient__c);*/
                    } else {  // cas manuel
                        c.AideReponseClient__c = getHelpMsgChooseTemplate(c, acc);
                    }
                }else{
                    c.AideReponseClient__c = 'Veuillez qualifier le ticket';        
                }
                                    
            } else {
                c.AideReponseClient__c = 'Veuillez qualifier le ticket';                    
           }
        }
        insert jobList;   
        if(taskToInsert.size() > 0){
            insert taskToInsert; 
        } 
        
        update casesToUpdate;

        system.debug('--#### OUT OF CASE BOUCLE'); 
    }
    

    public static void updateOwnerOnTransferedCase(List<Case> cases, List<Id> complexesId){

        // Récupération des Queues Names à partir des Complexes
        List<Complexe__c> complexes = [SELECT Id, TECH_QueueName__c
                                         FROM Complexe__c
                                        WHERE Id IN :complexesId];

        Map<Id, String> queueIdsMap = new Map<Id, String>();
        for(Complexe__c cinema : complexes){
            queueIdsMap.put(cinema.Id, cinema.TECH_QueueName__c);
        }
        
        Map<String, Id> queueNameIdMap = new Map<String, Id>();
        List<Group> queues = [SELECT Id, DeveloperNAME 
                                FROM Group 
                               WHERE Type = 'Queue'
                                 AND DeveloperNAME IN :queueIdsMap.values()];
        for(Group grp : queues){
            queueNameIdMap.put(grp.DeveloperNAME, grp.Id);
        }
        
        system.debug('## AP02_Case ## queueNamesMap: ' + queueIdsMap);
        
        // Mise à jour des propriétaire
        for(Case caseToUpd : cases){

            String queueId = queueNameIdMap.get(queueIdsMap.get(caseToUpd.Cinema__c));
            system.debug('## AP02_Case ## queueName: ' + queueId);
            if(queueId != null) {
                caseToUpd.OwnerId = queueId;
            }
            
            system.debug('## AP02_Case ##  case ' + caseToUpd + ' owner changed to ' + caseToUpd.OwnerId);
        }
    
    }
    
    public static void updateAccountOnReconciliationSN(List<Case> casesSocialNetwork) {
        Map<Id, Account> accountMap = new Map<Id, Account>();
        for(Case updatedCase: casesSocialNetwork) {
            accountMap.put(updatedCase.accountId, null);
        }
        List<Account> accounts = [SELECT Id, TECH_idCritizr__c, TECH_idFacebook__c, TECH_idInstagram__c, TECH_idTwitter__c 
                                    FROM Account WHERE Id in :accountMap.keySet()];
        for(Account acc: accounts) {
            accountMap.put(acc.Id, acc);
        }
        
        Set<Id> updatedAccountIds = new Set<Id>();
        for(Case updatedCase: casesSocialNetwork) {
            Account acc = accountMap.get(updatedCase.AccountId);
        // Le set ne marche pas normallement. Un addAll duplique les éléments.
            if(acc != null) {
                if(updatedCase.TECH_idCritizr__c != null && acc.TECH_idCritizr__c != updatedCase.TECH_idCritizr__c && !updatedAccountIds.contains(acc.Id)) {
                    acc.TECH_idCritizr__c = updatedCase.TECH_idCritizr__c;
                    updatedAccountIds.add(acc.Id);
                }
                if(updatedCase.TECH_idFacebook__c != null && acc.TECH_idFacebook__c != updatedCase.TECH_idFacebook__c && !updatedAccountIds.contains(acc.Id)) {
                    acc.TECH_idFacebook__c = updatedCase.TECH_idFacebook__c;
                    updatedAccountIds.add(acc.Id);
                }
                if(updatedCase.TECH_idInstagram__c != null && acc.TECH_idInstagram__c != updatedCase.TECH_idInstagram__c && !updatedAccountIds.contains(acc.Id)) {
                    acc.TECH_idInstagram__c = updatedCase.TECH_idInstagram__c;
                    updatedAccountIds.add(acc.Id);
                }
                if(updatedCase.TECH_idTwitter__c != null && acc.TECH_idTwitter__c != updatedCase.TECH_idTwitter__c && !updatedAccountIds.contains(acc.Id)) {
                    acc.TECH_idTwitter__c = updatedCase.TECH_idTwitter__c;
                    updatedAccountIds.add(acc.Id);
                }
            }
        }
        
        system.debug('## AP02_Case ## accounts set: ' + updatedAccountIds);
        
        List<Account> accountsToUpdate = new List<Account>();
        
        for(Id id: updatedAccountIds) {
            accountsToUpdate.add(accountMap.get(id));
        }
        
        system.debug('## AP02_Case ## accounts list: ' + accountsToUpdate);
        update accountsToUpdate;
        
    }
    
    //MNE_30-07-2018
    public static void getCaseRecordType(List<Case> cases) {
        //list<RecordTypeMapping__c> rtms = RecordTypeMapping__c.getall().values();
        /*list<RecordTypeMapping__c> rtms = new list<RecordTypeMapping__c>([SELECT Id,Name,Famille__c,Motif__c,SousMotif__c,RecordTypeName__c FROM RecordTypeMapping__c]);

        if(cases != null && cases.size() > 0 && rtms != null && rtms.size() > 0){
            map<String, RecordTypeMapping__c> mapRecordTypeMappingByFamilleMotif = new map<String, RecordTypeMapping__c>();
            
            for(RecordTypeMapping__c rtm : rtms){
                if(rtm.Famille__c != null && rtm.Motif__c != null){
                    mapRecordTypeMappingByFamilleMotif.put(rtm.Famille__c+rtm.Motif__c, rtm);
                }
            }
            
            for (Case c : cases) {
                if(c.Famille__c != null && c.Motif__c != null){
                    String familleMotif = c.Famille__c+c.Motif__c;
                    if(mapRecordTypeMappingByFamilleMotif.containsKey(familleMotif)){
                        String rtName = mapRecordTypeMappingByFamilleMotif.get(familleMotif).RecordTypeName__c;
                        if(String.isNotBlank(rtName)){
                            Schema.RecordTypeInfo recordTypeInfo = Schema.SObjectType.Case.getRecordTypeInfosByName().get(rtName);
                            if(recordTypeInfo != null){
                                Id recordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get(rtName).getRecordTypeId();
                                if(recordTypeId != null){
                                    c.RecordTypeId = recordTypeId;
                                }
                            }
                        }
                    }
                }
            }
        }*/
        list<RecordTypeMapping__mdt> rtms = new list<RecordTypeMapping__mdt>([SELECT Id, Famille__c, Motif__c, RecordTypeName__c FROM RecordTypeMapping__mdt]);

        if(cases != null && cases.size() > 0 && rtms != null && rtms.size() > 0){
            map<String, RecordTypeMapping__mdt> mapRecordTypeMappingByFamilleMotif = new map<String, RecordTypeMapping__mdt>();
            
            for(RecordTypeMapping__mdt rtm : rtms){
                if(rtm.Famille__c != null && rtm.Motif__c != null){
                    mapRecordTypeMappingByFamilleMotif.put(rtm.Famille__c+rtm.Motif__c, rtm);
                }
            }
            
            for (Case c : cases) {
                if(c.Famille__c != null && c.Motif__c != null){
                    String familleMotif = c.Famille__c+c.Motif__c;
                    if(mapRecordTypeMappingByFamilleMotif.containsKey(familleMotif)){
                        String rtName = mapRecordTypeMappingByFamilleMotif.get(familleMotif).RecordTypeName__c;
                        if(String.isNotBlank(rtName)){
                            Schema.RecordTypeInfo recordTypeInfo = Schema.SObjectType.Case.getRecordTypeInfosByName().get(rtName);
                            if(recordTypeInfo != null){
                                Id recordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get(rtName).getRecordTypeId();
                                if(recordTypeId != null){
                                    c.RecordTypeId = recordTypeId;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    public static void initDesaboDate (List<Case> listCases){
        system.debug('##MNE initDesaboDate listCases >> '+listCases);
        Id desaboRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Désabonnement').getRecordTypeId();
        Id retentionRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Rétention').getRecordTypeId();
        Id retractationRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Rétractation').getRecordTypeId();
        Id annulationContratRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Annulation contrat').getRecordTypeId();
        Id resiliationRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Résiliation').getRecordTypeId();
        
        
        Set<Id> setRecordTypeIdToProcess = new Set<Id>{desaboRecordTypeId, retentionRecordTypeId, retractationRecordTypeId, annulationContratRecordTypeId, resiliationRecordTypeId};
        set<Id> setSubId = new set<Id>();
        
        if(listCases == null || listCases.size() == 0){
            return;
        }
        
        for(Case c : listCases){
            if (c.Subscription__c != null) {
                setSubId.add(c.Subscription__c);
            }
        }
        
        system.debug('##MNE initDesaboDate setSubId >> '+setSubId);
        
        if(setSubId.size() == 0){
            return;
        }
        
        map<Id, Zuora__Subscription__c> mapSubById = new map<Id, Zuora__Subscription__c>([SELECT Id, Name, Zuora__ContractEffectiveDate__c, Zuora__TermStartDate__c, Zuora__SubscriptionStartDate__c, TypeContrat__c, Zuora__Account__r.ProduitUGC__c, Zuora__Account__r.CodePays__c FROM Zuora__Subscription__c WHERE Id IN :setSubId]);
        //Zuora__ContractEffectiveDate__c
        //Zuora__TermStartDate__c
        
        system.debug('##MNE initDesaboDate mapSubById >> '+mapSubById);
        
        system.debug('##MNE initDesaboDate setRecordTypeIdToProcess >> '+setRecordTypeIdToProcess);
        
        for(Case c : listCases){
            system.debug('##MNE initDesaboDate c.Subscription__c >> '+mapSubById);
            system.debug('##MNE initDesaboDate c.RecordTypeId >> '+c.RecordTypeId);
            if (c.Subscription__c != null && setRecordTypeIdToProcess.contains(c.RecordTypeId) ) {
                system.debug('##MNE initDesaboDate Hello 1');
                Zuora__Subscription__c sub = mapSubById.get(c.Subscription__c);
                //Date startSub = sub.Zuora__SubscriptionStartDate__c;
                Date startSub = sub.Zuora__ContractEffectiveDate__c;
                Integer startSubYear = startSub.year();
                Integer startSubMonth = startSub.month();
                Date now = c.DateDemande__c;
                Integer nowYear = now.year();
                Integer nowMonth = now.month();
                system.debug('##MNE initDesaboDate CodePays__c >> '+sub.Zuora__Account__r.CodePays__c);
                Integer preavis = Util.PREAVIS(sub.Zuora__Account__r.CodePays__c);
                if (c.RecordTypeId == retractationRecordTypeId || c.RecordTypeId == annulationContratRecordTypeId ) {
                    //c.Type_de_d_sabonnement__c = 'Désabonnement avec justificatif (E)';
                    //c.Date_de_D_sabonnement__c = c.DateDemande__c;
                    c.DateFinContrat__c = c.DateDemande__c;
                    c.DateFinContrat__c = c.DateFinContrat__c.addDays(1);
                }
                else if (c.RecordTypeId == resiliationRecordTypeId) {
                    //c.Type_de_d_sabonnement__c = 'Désabonnement avec justificatif (E)';
                    if(c.Date_de_R_siliation__c != null){
                        Date dateResiliation = Date.valueOf(c.Date_de_R_siliation__c);
                        //c.Date_de_D_sabonnement__c = dateResiliation;
                        c.DateFinContrat__c = dateResiliation;
                        c.DateFinContrat__c = c.DateFinContrat__c.addDays(1);
                    }
                }
                else if (sub.TypeContrat__c == 'CDD') {
                    // Date de fin d’engagement = Date de souscription +1 an (“contrat date à date” exemple : souscription le 22/11/18, date de fin d’engagement le 21/11/19)
                    //c.Date_fin_engagement__c = startSub.addYears(1).addDays(-1);
                    c.Date_fin_engagement__c = startSub.addYears(1);
                    if (c.Type_de_d_sabonnement__c == 'Désabonnement avec préavis (L)'){
                        //date de fin de contrat = date fin d’engagement
                        c.DateFinContrat__c = c.Date_fin_engagement__c;
                    }
                    else if (c.Type_de_d_sabonnement__c == 'Désabonnement avec justificatif (E)'){ 
                        /*//date de fin de contrat = date de désabonnement
                        c.DateFinContrat__c = c.Date_de_D_sabonnement__c;*/
                        if(c.Date_de_D_sabonnement__c == null){
                            c.DateFinContrat__c = null;
                        } else{
                            Integer desaboYear = c.Date_de_D_sabonnement__c.year();
                            Integer desaboMonth = c.Date_de_D_sabonnement__c.month();
                            //date fin de contrat = date de désabonnement + mois en cours (exemple : désabonnement le 22/11/18 : date de fin de contrat = 30/11/18
                            c.DateFinContrat__c = Date.newInstance(desaboYear, desaboMonth+1, 1);
                        }
                    }
                }
                else if (sub.TypeContrat__c == 'CDI') {
                    //date de fin d’engagement = date de souscription + mois en cours + 12 mois ( exemple : souscription le 22/11/18, date de fin d’engagement le 30/11/19)
                    //c.Date_fin_engagement__c =  Date.newInstance(startSubYear, startSubMonth+1, 1).addMonths(12).addDays(-1);
                    c.Date_fin_engagement__c =  Date.newInstance(startSubYear, startSubMonth+1, 1).addMonths(12);
                    if (c.Type_de_d_sabonnement__c == 'Désabonnement avec préavis (L)'){
                        if(c.DateDemande__c < c.Date_fin_engagement__c.addMonths(-preavis)){
                            //date de fin de contrat = date de fin d’engagement
                            c.DateFinContrat__c = c.Date_fin_engagement__c;
                        } else {
                            //date de fin de contrat = mois en cours + 2 mois (exemple : appel le 22/11/18 : date de fin = 31/01/19)
                            //c.DateFinContrat__c = Date.newInstance(nowYear, nowMonth+1, 1).addMonths(2).addDays(-1);
                            c.DateFinContrat__c = Date.newInstance(nowYear, nowMonth+1, 1).addMonths(preavis);
                        }
                    }
                    else if (c.Type_de_d_sabonnement__c == 'Désabonnement avec justificatif (E)'){
                        if(c.Date_de_D_sabonnement__c == null){
                            c.DateFinContrat__c = null;
                        } else{
                            Integer desaboYear = c.Date_de_D_sabonnement__c.year();
                            Integer desaboMonth = c.Date_de_D_sabonnement__c.month();
                            //date fin de contrat = date de désabonnement + mois en cours (exemple : désabonnement le 22/11/18 : date de fin de contrat = 30/11/18
                            c.DateFinContrat__c = Date.newInstance(desaboYear, desaboMonth+1, 1);
                        }
                    }
                }
            }
        }
    }
    
    //MNE_04-04-2019
    public static void initSubscriptionId (map<Id, list<Case>> mapListCaseByAccId, set<Id> setAccId){
    	system.debug('##MNE AP02_Case initSubscriptionId mapListCaseByAccId >> '+mapListCaseByAccId);
    	system.debug('##MNE AP02_Case initSubscriptionId setAccId >> '+setAccId);
    	
    	Date d1 = Date.today();
        List<Zuora__Subscription__c> subscriptions = [
                SELECT Id, Zuora__Zuora_Id__c, Zuora__Account__r.Id, Name
                FROM Zuora__Subscription__c
                WHERE Zuora__Account__r.Id IN :setAccId
                AND ( Zuora__SubscriptionEndDate__c > :d1 OR Zuora__SubscriptionEndDate__c = NULL )
                ORDER BY CreatedDate DESC
        ];

        if (subscriptions.isEmpty()) {
            return;
        }
        
        set<Id> setAccIdAlreadyTreated = new set<Id>();
        for(Zuora__Subscription__c zSub : subscriptions) {
        	if(mapListCaseByAccId.containsKey(zSub.Zuora__Account__r.Id) && !setAccIdAlreadyTreated.contains(zSub.Zuora__Account__r.Id)){
        		list<Case> listCase = mapListCaseByAccId.get(zSub.Zuora__Account__r.Id);
        		for(Case c : listCase){
        			c.Subscription__c	 = zSub.Id;
        			//c.SubscriptionZID__c = zSub.Zuora__Zuora_Id__c;
        			c.SubscriptionZID__c = zSub.Name;
        			setAccIdAlreadyTreated.add(zSub.Zuora__Account__r.Id);
        		}
        	}
        }
        
    	
    }
        
    
    public static Task createTask(String canal, Case c){
        Task t = new Task();
        t.ActivityDate = Date.Today();
        t.Description = c.Description;
        if(canal == 'courrier'){
            t.Origine__c = 'Courrier sortant';
        } else {
            t.Origine__c = 'Email sortant';
        }
        t.OwnerId = UserInfo.getUserId();
        t.Priority = 'Normale';
        t.Status = 'Achevée';
        t.Subject = c.Subject;
        t.WhatId = c.Id;
        t.WhoId = c.ContactId;

        return t;
    }

    public static void createReboursementCase(Case demande){

        SM_Remboursement.createRebousementCase(demande.Id, demande.MontantRembourser__c, demande.MontantRembourser__c, demande.AccountId, demande.CreditMemoId__c, demande.DateFinContrat__c, null, null);

    }
}