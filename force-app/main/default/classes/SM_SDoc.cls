public class SM_SDoc {

    public static String TECHIdStatut_007AD = '007AD';  //0- Souscription   -> 07- Creation Abonnement      -> AD- Action DRC
    public static String TECHIdStatut_005AD = '005AD';  //0- Souscription   -> 05- B2B                      -> AD- Action DRC
    public static String TECHIdStatut_005AH = '005AH';  //0- Souscription   -> 05- B2B                      -> AH- Action Selfcare
    public static String TECHIdStatut_007AH = '007AH';  //0- Souscription   -> 07- Creation Abonnement      -> AH- Action Selfcare
    public static String TECHIdStatut_007AS = '007AS';  //0- Souscription   -> 07- Creation Abonnement      -> AS- Action Stand
    public static String TECHIdStatut_106A  = '106A';   //1- Vie de l'abo   -> 06- Migration                -> A- Action
    public static String TECHIdStatut_106AD = '106AD';  //1- Vie de l'abo   -> 06- Migration                -> AD- Action DRC
    public static String TECHIdStatut_106AS = '106AS';  //1- Vie de l'abo   -> 06- Migration                -> AS- Action Stand
    public static String TECHIdStatut_106AH = '106AH';  //1- Vie de l'abo   -> 06- Migration                -> AH- Action Selfcare 
    
    
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
                                         Nom_du_mod_le_courrier_UU_n_erlandais__c, Nom_du_mod_le_email_UU_n_erlandais__c, AvecCarte__c
                                         FROM Contacts__c
                                         WHERE Name IN :statutCaseSet];
        
        
        //recupération des nom des template utilises dans les contacts
        Set<String> nomModelSdocSet = New Set<String>();
        for(Contacts__c c : contactsLst){
            
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
        system.debug('--#### nomModelSdocSet = ' + nomModelSdocSet);
        
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
        
        system.debug('##ECH casesToUpdate :'+casesToUpdate);
        // maj de case a partir de la Map 
        for (Case c : casesToUpdate) {
            
            
            if (c.TECHIdStatut__c != null) {
                system.debug('##ECH c.TECHIdStatut__c 0 :'+c.TECHIdStatut__c);
                Contacts__c contacts = mapIdStatutContacts.get(c.TECHIdStatut__c);
                if(contacts!=null){
                    system.debug('##ECH contacts :'+contacts);
                    system.debug('--#### CASE ACCOUNT = ' + c.Account.Id);
                    Account acc = c.Account;
                    
                    String courrierTemplateName = '';
                    String emailTemplateName = '';
                    
                    system.debug('##ECH acc.CodePays__c :'+acc.CodePays__c);
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
                    
                    system.debug('##ECH courrierTemplateName 0 :'+courrierTemplateName);
                    system.debug('##ECH emailTemplateName 0 :'+emailTemplateName);
                    
                    //BEGIN Compteur Nb Doc
                    Integer nbCarte = contacts.AvecCarte__c ? 1 : 0;
                    Integer nbCourrier = 0;
                    Integer nbCourrierAttachement = 0;
                    
                    system.debug('##MNE AP02_Case makeSdocJobs nbCarte >> '+ nbCarte);
                    system.debug('##MNE AP02_Case makeSdocJobs courrierTemplateName >> '+ courrierTemplateName);
                    
                    if(String.isNotBlank(courrierTemplateName)){
                        list<String> listCourrierTemplateNameTMP = courrierTemplateName.split(';');
                        nbCourrier = listCourrierTemplateNameTMP.size();
                    }
                    
                    system.debug('##MNE AP02_Case makeSdocJobs nbCourrier >> '+ nbCourrier);
                    
                    system.debug('##MNE AP02_Case makeSdocJobs emailTemplateName >> '+ emailTemplateName);
                    
                    if(String.isNotBlank(emailTemplateName)){
                        list<String> listEmailTemplateNameTMP = emailTemplateName.split(';');
                        if(listEmailTemplateNameTMP.size() > 1){
                            Integer cpt = 0;
                            for(String s: listEmailTemplateNameTMP){
                                if(cpt == 0){
                                    cpt++;
                                    continue;
                                } else if (!s.trim().startsWithIgnoreCase('UGC')){
                                    nbCourrierAttachement++;
                                }
                                cpt++;
                            }
                        }
                    }
                    
                    system.debug('##MNE AP02_Case makeSdocJobs nbCourrierAttachement >> '+ nbCourrierAttachement);
                    
                    Integer cptTotal = nbCarte + nbCourrier + nbCourrierAttachement;
                    c.TECH_NBPrintFileTotal__c = cptTotal;
                    system.debug('##MNE AP02_Case makeSdocJobs TECH_NBPrintFileTotal__c >> '+ c.TECH_NBPrintFileTotal__c);
                    //END Compteur Nb Doc
                                      
                    Boolean isHTMLTemplate = isHTMLTemplate(c, acc);
                    Boolean isPDFTemplate = isPDFTemplate(c, acc);
                    
                    if(contacts.Reponse__c == 'Automatique') {
                        system.debug('##ECH contacts.Reponse__c:'+contacts.Reponse__c);
                        
                        system.debug('--#### IN AUTOMATIQUE');
                        if(isHTMLTemplate == null && isPDFTemplate==null) {
                            system.debug('##ECH isHTMLTemplate :'+isHTMLTemplate);
                            system.debug('##ECH isPDFTemplate :'+isPDFTemplate);
                            c.AideReponseClient__c = getHelpMsgChooseTemplate(c, acc);
                        }
                        
                        else if(c.TECHIdStatut__c == TECHIdStatut_007AD || c.TECHIdStatut__c == TECHIdStatut_005AD || c.TECHIdStatut__c == TECHIdStatut_007AS){
                            system.debug('##ECH c.TECHIdStatut__c 1:'+c.TECHIdStatut__c );
                            if(String.isNotBlank(courrierTemplateName)){
                                system.debug('##ECH courrierTemplateName1 :'+courrierTemplateName );
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
                                        //ECH Flag pour identifier une demande traitée
                                        c.TECH_GeneratedDoc__c = true;
                                    }
                                }
                            }
                        }
                        
                        else if(c.TECHIdStatut__c == TECHIdStatut_005AH || c.TECHIdStatut__c == TECHIdStatut_007AH || c.TECHIdStatut__c == TECHIdStatut_106A || c.TECHIdStatut__c == TECHIdStatut_106AD || c.TECHIdStatut__c == TECHIdStatut_106AS || c.TECHIdStatut__c == TECHIdStatut_106AH ){
                            system.debug('##ECH c.TECHIdStatut__c 2 :'+c.TECHIdStatut__c );
                            if(String.isNotBlank(courrierTemplateName)){
                                system.debug('##ECH courrierTemplateName2 :'+courrierTemplateName );
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
                                        //ECH Flag pour identifier une demande traitée
                                        c.TECH_GeneratedDoc__c = true;
                                    }
                                }
                                
                            }
                            if(String.isNotBlank(emailTemplateName)){
                                system.debug('##ECH emailTemplateName 1 :'+emailTemplateName );
                                
                                list<String> listEmailTemplateName = emailTemplateName.split(';');
                                system.debug('##ECH listEmailTemplateName  :'+listEmailTemplateName );
                                
                                list<String> listEmailTemplateId = new list<String>();
                                
                                for(String s: listEmailTemplateName){
                                    if(mapNomSdocsIdSdocs.containsKey(s.trim())){
                                        listEmailTemplateId.add(mapNomSdocsIdSdocs.get(s.trim()));
                                    }
                                }
                                system.debug('##ECH listEmailTemplateId  :'+listEmailTemplateId );
                                
                                string listEmailTemplateIdforSDOC = string.join(listEmailTemplateId,',');
                                
                                system.debug('##ECH listEmailTemplateIdforSDOC  :'+listEmailTemplateIdforSDOC );
                                
                                if(String.isNotEmpty(listEmailTemplateIdforSDOC)){
                                    SDOC__SDJob__c job = new SDOC__SDJob__c(
                                        SDOC__Start__c=true, 
                                        SDOC__Oid__c=c.Id, 
                                        SDOC__ObjApiName__c='Case', 
                                        SDOC__SendEmail__c='1',
                                        SDOC__Doclist__c= listEmailTemplateIdforSDOC);
                                    jobList.add(job);
                                    taskToInsert.add(createTask('email', c));
                                    c.AideReponseClient__c = 'Un email a été envoyé au client.';
                                    //ECH Flag pour identifier une demande traitée
                                    c.TECH_GeneratedDoc__c = true;
                                }
                              
                                
                            }
                            
                        }
                        else {
                            if(isHTMLTemplate && String.isNotBlank(emailTemplateName)){
                                
                                system.debug('##ECH emailTemplateName 2 :'+emailTemplateName );
                                list<String> listEmailTemplateName = emailTemplateName.split(';');
                                system.debug('##ECH listEmailTemplateName 2  :'+listEmailTemplateName );
                                
                                list<String> listEmailTemplateId = new list<String>();
                                
                                for(String s: listEmailTemplateName){
                                    if(mapNomSdocsIdSdocs.containsKey(s.trim())){
                                        listEmailTemplateId.add(mapNomSdocsIdSdocs.get(s.trim()));
                                    }
                                }
                                system.debug('##ECH listEmailTemplateId 2  :'+listEmailTemplateId );
                                
                                //listEmailTemplateId.remove(null);
                                
                                string listEmailTemplateIdforSDOC = string.join(listEmailTemplateId,',');
                                
                                system.debug('##ECH listEmailTemplateIdforSDOC 2  :'+listEmailTemplateIdforSDOC );
                                
                                //string emailTemplateNameTMP = string.join(listEmailTemplateName,',');
                                
                                //                                for(String emailTemplateNameTMP : listEmailTemplateName){
                                //                                  emailTemplateNameTMP = emailTemplateNameTMP.trim();
                                if(String.isNotEmpty(listEmailTemplateIdforSDOC)){
                                    SDOC__SDJob__c job = new SDOC__SDJob__c(
                                        SDOC__Start__c=true, 
                                        SDOC__Oid__c=c.Id, 
                                        SDOC__ObjApiName__c='Case', 
                                        SDOC__SendEmail__c='1',
                                        SDOC__Doclist__c= listEmailTemplateIdforSDOC);
                                    jobList.add(job);
                                    taskToInsert.add(createTask('email', c));
                                    c.AideReponseClient__c = 'Un email a été envoyé au client.';
                                    //ECH Flag pour identifier une demande traitée
                                    c.TECH_GeneratedDoc__c = true;
                                }
                                //                              }
                            }
                            
                            if(isPDFTemplate && String.isNotBlank(courrierTemplateName)){
                                system.debug('##ECH courrierTemplateName 3:'+courrierTemplateName);
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
                                        system.debug('##ECH courrierTemplateName 4:'+courrierTemplateName);
                                        //ECH Flag pour identifier une demande traitée
                                        c.TECH_GeneratedDoc__c = true;   
                                    }
                                }
                            }
                            
                            
                            system.debug('##ECH c.TECHIdStatut__c ELSE :'+c.TECHIdStatut__c );
                            system.debug('##ECH emailTemplateName ELSE:'+emailTemplateName);
                            system.debug('##ECH courrierTemplateName ELSE:'+courrierTemplateName);
                            system.debug('##ECH isHTMLTemplate ELSE :'+isHTMLTemplate);
                            system.debug('##ECH isPDFTemplate ELSE :'+isPDFTemplate);                 
                        }              
                    } 
                    else if(contacts.Reponse__c == 'Semi-automatique'){
                        system.debug('--#### IN SEMI AUTOMATIQUE');
                    } 
                    else {  // cas manuel
                        c.AideReponseClient__c = getHelpMsgChooseTemplate(c, acc);
                    }
                }
                else{
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
    
    private static Boolean isHTMLTemplate(Case c, Account account) {
        if(account == null) {
            system.debug('--#### Account null');
            return null;
        }
        
        system.debug('--#### IN NPAIEMAIL__c ' + account.NPAIEMAIL__c);
        
        if(!account.NPAIEMAIL__c && !isEmpty(c.AdresseEmail__c)) {
            system.debug('--#### IN AdresseEmail__c not null ');
            return true;
        } else {
            return false;
        }
        
    }
    
    private static Boolean isPDFTemplate(Case c, Account account) {
        if(account == null) {
            system.debug('--#### Account null');
            return null;
        }
        
        system.debug('--#### IN PNDADRESSE__c ' + account.PNDADRESSE__c);
        if(!account.PNDADRESSE__c && !isEmpty(c.AdressePostale__c) ) {
            system.debug('--#### IN AdresseEmail__c null OR NPAIEMAIL__c = true');
            system.debug('--#### IN AdressePostale__c not null');
            return true;
        }
        else{
            return false;           
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
    
    private static Boolean isEmpty(String s) {
        return s == null || s.toUpperCase().replace('<BR>', '').trim() == '';
    }
}