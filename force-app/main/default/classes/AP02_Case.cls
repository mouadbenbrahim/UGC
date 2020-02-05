/**
* @description : Classe a utiliser en trigger after durant la creation d'un nouvel account
*                Les nouveaux account crees sont envoye au WS RCU UGC
* @author yann d'ALMEIDA 
*/
public class AP02_Case {
    
    public static final Id CaseAnnulationMigrationRTid = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Annulation Migration').getRecordTypeId();
    public static final Id CaseRemboursementRTId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Remboursement').getRecordTypeId();

    public static void processTriggerBeforeInsert (List<Case> cases)  {   
        system.debug ('##MNE AP02_Case processTriggerBeforeInsert cases.size() >> ' + cases.size()) ; 
        List<Case> casesGroupementLst = new List<Case>();
        List<Case> casesQueueOwnerLst = new List<Case>();
        List<Id> complexesId = new List<Id>();
        map<Id, list<Case>> mapListCaseByAccId = new map<Id, list<Case>>();
        set<Id> setAccId = new set<Id>();
        map<String, list<Case>> mapListCaseBySubName = new map<String, list<Case>>();
        set<String> setSubName = new set<String>();

        for(Case caseToCre : cases){
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
            if(caseToCre.SubscriptionZName__c != null){
                if(!mapListCaseBySubName.containsKey(caseToCre.SubscriptionZName__c)){
                     mapListCaseBySubName.put(caseToCre.SubscriptionZName__c, new list<Case>());
                }
                mapListCaseBySubName.get(caseToCre.SubscriptionZName__c).add(caseToCre);
                setSubName.add(caseToCre.SubscriptionZName__c);
            }
            
        }

        //Update des champs TECH_FamilleMatrice__c, TECH_MotifMatrice__c et TECH_SousMotifMatrice__c
        system.debug ('##MNE AP02_Case processTriggerBeforeInsert casesGroupementLst.size() >> ' + casesGroupementLst.size()) ; 
        if(casesGroupementLst.size() > 0){
            updateTechFamMotifSousMotif(casesGroupementLst);            
        }

        ///Update du champs OwnerId
        system.debug ('##MNE AP02_Case processTriggerBeforeInsert casesQueueOwnerLst.size() >> ' + casesQueueOwnerLst.size()) ; 
        if(casesQueueOwnerLst.size() > 0){
            updateOwnerOnTransferedCase(casesQueueOwnerLst, complexesId);
        }
        
        //MNE_31-07-2018 OK
        getCaseRecordType(cases); 
        
        //MNE_22-11-2018
        initDesaboDate(cases);
        
        //MNE_04-04-2019
        system.debug ('##MNE AP02_Case processTriggerBeforeInsert setSubName.size() >> ' + setSubName.size()) ; 
        system.debug ('##MNE AP02_Case processTriggerBeforeInsert setAccId.size() >> ' + setAccId.size()) ; 
        if (setAccId.size() > 0 || setAccId.size() > 0){
        	initSubscriptionId(mapListCaseBySubName, setSubName, mapListCaseByAccId, setAccId);
        }
        
    }
    
    
    public static void processTriggerAfterInsert (List<Case> cases)  {   
        system.debug ('##MNE AP02_Case processTriggerAfterInsert cases.size() >> ' + cases.size()) ; 
        list<Case> listCaseToCreateDoc = new list<Case>();
        map<String, Contacts__c> mapContactsByName = new map<String, Contacts__c>();
        
        list<Contacts__c> contactsList = new list<Contacts__c>([SELECT Id, name, TypeTemplate__c FROM Contacts__c WHERE TypeTemplate__c = 'StandardTemplate']);
		for(Contacts__c cont : contactsList){
			mapContactsByName.put(cont.Name, cont);
		}

        for(Case caseToCre : cases){
			if(caseToCre.Famille__c != null && caseToCre.Motif__c != null && caseToCre.SousMotif__c != null && caseToCre.Subscription__c != null && 
               caseToCre.TECHIdStatut__c != null && mapContactsByName.containsKey(caseToCre.TECHIdStatut__c)){
				listCaseToCreateDoc.add(caseToCre);                
			}
			/*MBEN SYNCRO:  Deplace dans le code du WSIN
            if(caseToCre.Famille__c!=null && caseToCre.Motif__c!=null){
                if(caseToCre.Famille__c.equals('1VieAbonnement') && caseToCre.Motif__c.equals('06MigrationUI123') && String.isNotBlank(caseToCre.CreditMemoId__c)){
                	createReboursementCase(caseToCre);       
                }   
			}*/
        }

        system.debug ('##MNE AP02_Case processTriggerAfterInsert listCaseToCreateDoc.size() >> ' + listCaseToCreateDoc.size()) ; 
        if(listCaseToCreateDoc.size() > 0){
            SM_SDoc.makeSdocJobs(listCaseToCreateDoc);
        }
    }
        
        
    public static void processTriggerBeforeUpdate (Map<Id, Case> mapOldCases, Map<Id, Case> mapNewCases)  {   
        system.debug ('##MNE AP02_Case processTriggerBeforeUpdate mapOldCases.size() >> ' + mapOldCases.size()); 
        system.debug ('##MNE AP02_Case processTriggerBeforeUpdate mapNewCases.size() >> ' + mapNewCases.size()); 

        List<Case> casesGroupementLst = new List<Case>();
        List<Case> casesQueueOwnerLst = new List<Case>();
        List<Id> complexesId = new List<Id>();
        List<Case> desaboDateCases = new List<Case>();
        List<Case> listCaseChangeCaseRecordType = new List<Case>();
        map<Id, list<Case>> mapListCaseByAccId = new map<Id, list<Case>>();
        set<Id> setAccId = new set<Id>();
        map<String, list<Case>> mapListCaseBySubName = new map<String, list<Case>>();
        set<String> setSubName = new set<String>();
               
        for(Case caseToUpd : mapNewCases.values()){
            Case oldCase = mapOldCases.get(caseToUpd.Id);
            // Identification des case dont les champs Tech famille, motif et sous motif sont à maj
			if((caseToUpd.Famille__c!=null && !caseToUpd.Famille__c.equals(oldCase.Famille__c)) ||
              (caseToUpd.Motif__c!=null && !caseToUpd.Motif__c.equals(oldCase.Motif__c)) ||
              (caseToUpd.SousMotif__c!=null && !caseToUpd.SousMotif__c.equals(oldCase.SousMotif__c)) ){
               casesGroupementLst.add(caseToUpd);                
            }
			if((caseToUpd.Famille__c!=null && !caseToUpd.Famille__c.equals(oldCase.Famille__c)) || (caseToUpd.Motif__c!=null && !caseToUpd.Motif__c.equals(oldCase.Motif__c))){
				listCaseChangeCaseRecordType.add(caseToUpd);
			}
            // Identification des cases à transférer
            if(caseToUpd.Actions__c != oldCase.Actions__c &&  caseToUpd.Actions__c == 'Transfert à la salle' && caseToUpd.Cinema__c != null) {
                casesQueueOwnerLst.add(caseToUpd);
                complexesId.add(caseToUpd.Cinema__c);
                system.debug('======== added case ' + caseToUpd);
            }
            //initSubscriptionId: event updates on : Subscription__c, SubscriptionZName__c
            if (caseToUpd.Subscription__c != oldCase.Subscription__c || caseToUpd.SubscriptionZName__c != oldCase.SubscriptionZName__c){
                if(caseToUpd.AccountId != null){
                    if(!mapListCaseByAccId.containsKey(caseToUpd.AccountId)){
                        mapListCaseByAccId.put(caseToUpd.AccountId, new list<Case>());
                    }
                    mapListCaseByAccId.get(caseToUpd.AccountId).add(caseToUpd);
                    setAccId.add(caseToUpd.AccountId);
                }
                if(caseToUpd.SubscriptionZName__c != null){
                    if(!mapListCaseBySubName.containsKey(caseToUpd.SubscriptionZName__c)){
                        mapListCaseBySubName.put(caseToUpd.SubscriptionZName__c, new list<Case>());
                    }
                    mapListCaseBySubName.get(caseToUpd.SubscriptionZName__c).add(caseToUpd);
                    setSubName.add(caseToUpd.SubscriptionZName__c);
                }
            }
            
           // initDesaboDate: Identification des case dont les champs : RecordTypeId, DateDemande__c, DateFinContrat__c,Date_de_R_siliation__c, Date_fin_engagement__c
           //  Type_de_d_sabonnement__c, Date_de_D_sabonnement__c...
           if((!caseToUpd.RecordTypeId.equals(oldCase.RecordTypeId)) ||
              (caseToUpd.DateDemande__c != oldCase.DateDemande__c) ||
              (caseToUpd.DateFinContrat__c != oldCase.DateFinContrat__c) ||
              (caseToUpd.Date_de_R_siliation__c != oldCase.Date_de_R_siliation__c) ||
              (caseToUpd.Date_fin_engagement__c != oldCase.Date_fin_engagement__c) ||
              (caseToUpd.Type_de_d_sabonnement__c != oldCase.Type_de_d_sabonnement__c) ||
              (caseToUpd.Date_de_D_sabonnement__c != oldCase.Date_de_D_sabonnement__c) ){
               desaboDateCases.add(caseToUpd);                
            }
        }

        //Update des champs TECH_FamilleMatrice__c, TECH_MotifMatrice__c et TECH_SousMotifMatrice__c
        system.debug ('##MNE AP02_Case processTriggerBeforeUpdate casesGroupementLst.size() >> ' + casesGroupementLst.size()) ; 
        if(casesGroupementLst.size() > 0){
            updateTechFamMotifSousMotif(casesGroupementLst);
        }

        ///Update du champs OwnerId
        system.debug ('##MNE AP02_Case processTriggerBeforeUpdate casesQueueOwnerLst.size() >> ' + casesQueueOwnerLst.size()) ; 
        if(casesQueueOwnerLst.size() > 0){
            updateOwnerOnTransferedCase(casesQueueOwnerLst, complexesId);
        }
        
        //MNE_31-07-2018
        system.debug ('##MNE AP02_Case processTriggerBeforeUpdate listCaseChangeCaseRecordType.size() >> ' + listCaseChangeCaseRecordType.size()) ; 
        if(listCaseChangeCaseRecordType.size() > 0){
        	getCaseRecordType(listCaseChangeCaseRecordType);
        }
        
        //MNE_22-11-2018
        if (desaboDateCases.size() > 0){
            initDesaboDate(desaboDateCases);
        }
        
        //MNE_04-04-2019
        system.debug ('##MNE AP02_Case processTriggerBeforeUpdate setSubName.size() >> ' + setSubName.size()) ; 
        system.debug ('##MNE AP02_Case processTriggerBeforeUpdate setAccId.size() >> ' + setAccId.size()) ; 
        if (setAccId.size() > 0 || setAccId.size() > 0){
        	initSubscriptionId(mapListCaseBySubName, setSubName, mapListCaseByAccId, setAccId);
        }
    }
    
    
    public static void processTriggerAfterUpdate (Map<Id, Case> mapOldCases, Map<Id, Case> mapNewCases)  {   
        system.debug ('##MNE AP02_Case processTriggerAfterUpdate mapOldCases.size() >> ' + mapOldCases.size()); 
        system.debug ('##MNE AP02_Case processTriggerAfterUpdate mapNewCases.size() >> ' + mapNewCases.size()); 

        list<Case> listCaseToCreateDoc = new list<Case>();
        list<Case> casesSocialNetwork = new list<Case>();
        //map<Id, Case> mapCaseByIdForFI = new map<Id, Case>();
        map<String, Contacts__c> mapContactsByName = new map<String, Contacts__c>();
        
        list<Contacts__c> contactsList = new list<Contacts__c>([SELECT Id, name, TypeTemplate__c FROM Contacts__c WHERE TypeTemplate__c = 'StandardTemplate']);
		for(Contacts__c cont : contactsList){
			mapContactsByName.put(cont.Name, cont);
		}

        for(Case caseToUpd : mapNewCases.values()){
            Case oldCase = mapOldCases.get(caseToUpd.Id);

			if( caseToUpd.TECHIdStatut__c!=null && mapContactsByName.containsKey(caseToUpd.TECHIdStatut__c) &&
			  ((caseToUpd.Subscription__c!=null && !caseToUpd.TECH_GeneratedDoc__c && !caseToUpd.Subscription__c.equals(oldCase.Subscription__c)) ||
               (caseToUpd.Subscription__c!=null && !caseToUpd.TECH_GeneratedDoc__c && ((caseToUpd.Famille__c != null && !caseToUpd.Famille__c.equals(oldCase.Famille__c)) ||
               (caseToUpd.Motif__c != null && !caseToUpd.Motif__c.equals(oldCase.Motif__c)) ||
               (caseToUpd.SousMotif__c != null && !caseToUpd.SousMotif__c.equals(oldCase.SousMotif__c)))))){
				listCaseToCreateDoc.add(caseToUpd);
            }
            // TODO: utiliser compte inconnu
            if(caseToUpd.AccountId != null && oldCase.AccountId == null 
                && (caseToUpd.TECH_idCritizr__c != null || caseToUpd.TECH_idFacebook__c != null || caseToUpd.TECH_idInstagram__c != null || caseToUpd.TECH_idTwitter__c != null)) {
                casesSocialNetwork.add(caseToUpd);
            }
            /*if(caseToUpd.Subscription__c != null && !caseToUpd.Subscription__c.equals(oldCase.Subscription__c)){
                mapCaseByIdForFI.put(caseToUpd.Id, caseToUpd);
            }*/
        }

        system.debug ('##MNE AP02_Case processTriggerAfterUpdate listCaseToCreateDoc.size() >> ' + listCaseToCreateDoc.size()) ; 
        if(listCaseToCreateDoc.size() > 0){
            SM_SDoc.makeSdocJobs(listCaseToCreateDoc);
        }
        
        
        // Appel de méthode update SN
        system.debug ('##MNE AP02_Case processTriggerAfterUpdate casesSocialNetwork.size()' + casesSocialNetwork.size()) ; 
        if(casesSocialNetwork.size() > 0){
            updateAccountOnReconciliationSN(casesSocialNetwork);
        }
        
        // Appel de méthode update Fil Impression
        //MNE SYNCRO: exclusion a mettre 
        /*system.debug ('##MNE AP02_Case processTriggerAfterUpdate mapCaseByIdForFI.size()' + mapCaseByIdForFI.size()) ; 
        if(mapCaseByIdForFI.size() > 0){
            updateFilImpression(mapCaseByIdForFI);
        }*/
    }
        
    /*private static String getTypeTemplateUsed(Case c, Account account) {
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
    }*/
    
    
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
            
            system.debug('##ECH AO02_Case updateTechFamMotifSousMotif :'+c.Famille__c+' '+c.Motif__c);
            
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
                
                
                //##ECH 281019 : Récupération du dernier paiement du compte à la création d'une demande de remboursement
                    system.debug('##ECH AP02_Case updateTechFamMotifSousMotif :'+c.Famille__c+' '+c.Motif__c);
                    if(c.Famille__c =='7- Finance' && c.Motif__c=='04- Remboursement' && c.AccountId != null && c.Payment__c ==null)
                    {
                        List<Zuora__Payment__c> paylst = [SELECT ID from Zuora__Payment__c where Zuora__Account__c=:c.AccountId order by CreatedDate DESC  LIMIT 1];
        				if(paylst.size()>0){
            				c.Payment__c =paylst[0].Id;
        				}
                    }
                 
                //##ECH 281019 : Récupération du marché du contrat pour blocage BTOB
                /*system.debug('##ECH AP02_Case updateTechFamMotifSousMotif Subscription__c:'+c.Subscription__c);	
                	if(c.Famille__c =='7- Finance' && c.Motif__c=='04- Remboursement' && c.Subscription__c != null)
                    {
                        List<Zuora__Subscription__c> sublst = [SELECT Marche__c from Zuora__Subscription__c where id=:c.Subscription__c LIMIT 1];
        				system.debug('##ECH AP02_Case updateTechFamMotifSousMotif sublst:'+sublst);	
                        if(sublst.size()>0){
            				if(sublst[0].Marche__c=='BTOB' && (c.DemandeRemboursement__c=='UGCIllimité' ||c.DemandeRemboursement__c=='UGCUnlimited'))
                            {
                                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, 'Il n\'est pas possible d\'effectuer ce type de remboursement pour une souscription BTOB');
								ApexPages.addMessage(myMsg);
                            }
        				}
                    }*/
                
                
                
                                    
            } else {
                c.TECH_FamilleMatrice__c    = null  ;
                c.TECH_MotifMatrice__c      = null ;
                c.TECH_SousMotifMatrice__c  = null ;    
                c.AideReponseClient__c = 'Veuillez qualifier le ticket';                    
           }
        }



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
    	
        list<RecordTypeMapping__mdt> rtms = new list<RecordTypeMapping__mdt>([SELECT Id, Famille__c, Motif__c, RecordTypeName__c FROM RecordTypeMapping__mdt]);
        Id standardRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Standard').getRecordTypeId();

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
                    } else {
                    	 c.RecordTypeId = standardRecordTypeId;
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
            if (c.Subscription__c != null && setRecordTypeIdToProcess.contains(c.RecordTypeId) && mapSubById.containsKey(c.Subscription__c)) {
                system.debug('##MNE initDesaboDate Hello 1');
                Zuora__Subscription__c sub = mapSubById.get(c.Subscription__c);
                //Date startSub = sub.Zuora__SubscriptionStartDate__c;
                Date startSub = sub.Zuora__ContractEffectiveDate__c;
                Integer startSubYear = startSub.year();
                Integer startSubMonth = startSub.month();
                Date now = c.DateDemande__c;
                Integer nowYear = now.year();
                Integer nowMonth = now.month();
                Date todayDay = Date.today();
                system.debug('##MNE initDesaboDate CodePays__c >> '+sub.Zuora__Account__r.CodePays__c);
                Integer preavis = Util.PREAVIS(sub.Zuora__Account__r.CodePays__c);
                if (c.RecordTypeId == retractationRecordTypeId || c.RecordTypeId == annulationContratRecordTypeId ) {
                	if(startSub > todayDay){
                		c.DateFinContrat__c = startSub;
                	}else{
                		c.DateFinContrat__c = c.DateDemande__c;
                	}
                    //c.DateFinContrat__c = c.DateFinContrat__c;
                }
                else if (c.RecordTypeId == resiliationRecordTypeId) {
                    //c.Type_de_d_sabonnement__c = 'Désabonnement avec justificatif (E)';
                    if(c.Date_de_R_siliation__c != null){
                        Date dateResiliation = Date.valueOf(c.Date_de_R_siliation__c);
                        //c.Date_de_D_sabonnement__c = dateResiliation;
                        c.DateFinContrat__c = dateResiliation;
                        //c.DateFinContrat__c = c.DateFinContrat__c.addDays(1);
                        c.DateFinContrat__c = c.DateFinContrat__c;
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
                            /*Integer desaboYear = c.Date_de_D_sabonnement__c.year();
                            Integer desaboMonth = c.Date_de_D_sabonnement__c.month();
                            //date fin de contrat = date de désabonnement + mois en cours (exemple : désabonnement le 22/11/18 : date de fin de contrat = 30/11/18
                            c.DateFinContrat__c = Date.newInstance(desaboYear, desaboMonth+1, 1);*/
                            c.DateFinContrat__c = c.Date_de_D_sabonnement__c.addDays(1);
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
    
    public static void initSubscriptionId (map<String, list<Case>> mapListCaseBySubName, set<String> setSubName, map<Id, list<Case>> mapListCaseByAccId, set<Id> setAccId){
    	system.debug('##MNE AP02_Case initSubscriptionId mapListCaseBySubName >> '+mapListCaseBySubName);
        system.debug('##MNE AP02_Case initSubscriptionId setSubName >> '+setSubName);
        system.debug('##MNE AP02_Case initSubscriptionId mapListCaseByAccId >> '+mapListCaseByAccId);
        system.debug('##MNE AP02_Case initSubscriptionId setAccId >> '+setAccId);
        
        list<Zuora__Subscription__c> listSub = SM_Subscription.getActiveSubscriptionBySetNameORSetAccId(setSubName, setAccId);
        
        if (listSub.isEmpty()) {
            return;
        }

        /* ECH 04/02 Old Version
        set<Id> setAccIdAlreadyTreated = new set<Id>();
        set<String> setSubNameAlreadyTreated = new set<String>();
        for(Zuora__Subscription__c zSub : listSub) {
           	if(mapListCaseBySubName.containsKey(zSub.Name) && !setSubNameAlreadyTreated.contains(zSub.Name)){
           		list<Case> listCase = mapListCaseBySubName.get(zSub.Name);
                for(Case c : listCase){
                    c.Subscription__c    	= zSub.Id;
                    c.SubscriptionZName__c 	= zSub.Name;
                    setAccIdAlreadyTreated.add(zSub.Zuora__Account__r.Id);
                    setSubNameAlreadyTreated.add(zSub.Name);
                }
           	}
           	else if(mapListCaseByAccId.containsKey(zSub.Zuora__Account__r.Id) && !setAccIdAlreadyTreated.contains(zSub.Zuora__Account__r.Id)){
           		list<Case> listCase = mapListCaseByAccId.get(zSub.Zuora__Account__r.Id);
                for(Case c : listCase){
                    c.Subscription__c    	= zSub.Id;
                    c.SubscriptionZName__c 	= zSub.Name;
                    setAccIdAlreadyTreated.add(zSub.Zuora__Account__r.Id);
                    if(zSub.Name != null){
						setSubNameAlreadyTreated.add(zSub.Name);
                    }
                }
           	}
        }
        */
        /*ECH 04/02 New Version */

        for (Zuora__Subscription__c zSub : listSub){
            list<Case> listCase = mapListCaseByAccId.get(zSub.Zuora__Account__r.Id);
            
            for(Case fCase : listCase){
                if(fCase.SubscriptionZName__c!=null){
                    if(fCase.SubscriptionZName__c == zSub.Name){
                        fCase.Subscription__c    	= zSub.Id;
                        fCase.SubscriptionZName__c 	= zSub.Name;
                    }
                }
                else{
                    if(fCase.Subscription__c==null){
                        if(fCase.RecordTypeId==CaseAnnulationMigrationRTid){
                            if(zSub.Zuora__Status__c =='Pending Activation'){
                                fCase.Subscription__c    	= zSub.Id;
                                fCase.SubscriptionZName__c 	= zSub.Name;
                            }
                        }
                        else if(fCase.RecordTypeId==CaseRemboursementRTId){
                            if(zSub.Zuora__Status__c =='Active'){
                                fCase.Subscription__c    	= zSub.Id;
                                fCase.SubscriptionZName__c 	= zSub.Name;
                            }
                            if(zSub.Zuora__Status__c =='Cancelled' && fCase.Subscription__c==null){
                                fCase.Subscription__c    	= zSub.Id;
                                fCase.SubscriptionZName__c 	= zSub.Name;
                            }
                            if(zSub.Zuora__Status__c =='Pending Activation' && fCase.Subscription__c==null){
                                fCase.Subscription__c    	= zSub.Id;
                                fCase.SubscriptionZName__c 	= zSub.Name;
                            }

                        }else{
                            if(zSub.Zuora__Status__c =='Active'){
                                fCase.Subscription__c    	= zSub.Id;
                                fCase.SubscriptionZName__c 	= zSub.Name;
                            }
                            if(zSub.Zuora__Status__c =='Pending Activation' && fCase.Subscription__c==null){
                                fCase.Subscription__c    	= zSub.Id;
                                fCase.SubscriptionZName__c 	= zSub.Name;
                            }
                        }
                    }
                }
            }
        }
    }
    
        

    /*public static void createReboursementCase(Case demande){
        SM_Remboursement.createRebousementCase(demande.Id, demande.MontantRembourser__c, demande.MontantRembourser__c, demande.AccountId, demande.CreditMemoId__c, demande.DateFinContrat__c, null, Date.today());
    }*/
    
    /*public static void updateFilImpression(map<Id, Case> mapCaseByIdForFI) {
        system.debug('##MNE AP02_Case updateFilImpression mapCaseByIdForFI >> '+mapCaseByIdForFI);
        
        if(mapCaseByIdForFI == null || mapCaseByIdForFI.size() == 0){
            return;
        }
        
        set<Id> setCaseId = mapCaseByIdForFI.keySet();
        
        list<File_Impression__c> listFIToProcess = new list<File_Impression__c>([Select Id, Case__c, SubscriptionZName__c, Subscription__c FROM File_Impression__c WHERE Case__c IN :setCaseId]);
        list<File_Impression__c> listFIToUpdated = new list<File_Impression__c>();
        
        if(listFIToProcess == null || listFIToProcess.size() == 0){
            return;
        }
        
        for(File_Impression__c fi : listFIToProcess){
            if(fi.Case__c != null && mapCaseByIdForFI.containsKey(fi.Case__c)){
                fi.Subscription__c    = mapCaseByIdForFI.get(fi.Case__c).Subscription__c;
                fi.SubscriptionZName__c = mapCaseByIdForFI.get(fi.Case__c).SubscriptionZName__c;
                listFIToUpdated.add(fi);
            }   
        }
        if(listFIToUpdated.size() > 0){
            update listFIToUpdated;
        }
    }*/
    
    /*private class MyException extends Exception {
    }*/
    
}