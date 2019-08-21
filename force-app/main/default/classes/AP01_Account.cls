/**
* @description : Classe a utiliser en trigger after durant la creation d'un nouvel account
*                Les nouveaux account crees sont envoye au WS RCU UGC
* @author yann d'ALMEIDA EIT
*/
public class AP01_Account {
    
    public static void processTriggerBeforeInsert (List<Account> comptes)  {  
        updateCodePaysPostal(comptes);
        checkDuplicates(comptes);
        calculScore(comptes);
    }
    
    public static void processTriggerBeforeUpdate (Map<Id, Account> oldMapAccount, Map<Id, Account> newMapAccount)  {   
        updateCodePaysPostal(newMapAccount.values());
        checkDuplicates(newMapAccount.values());
        calculScore(newMapAccount.values());
    }
    
    // methode pour envoyer les informations du nouvel account au RCU UGC pour validation 
    public static void processTriggerAfterInsert (List<Account> comptes)  {   
        
        system.debug ('--#### Nombre de compte à créer =' + comptes.size()) ;
        List<Account> accountsToCreate = new List<Account>();
        List<Id> accountsId = new List<Id>();
        List<Id> idsRcu = new List<Id>();
        
        
        for(Account compte : comptes){
            if(!'RCU'.equals(compte.Canal_creation_Maj__c)){
                accountsToCreate.add(compte);
                accountsId.add(compte.Id);
            } else {
                idsRcu.add(compte.Id);
            }
        }
        
        system.debug ('--#### Nombre de compte à transmettre au RCU = ' + accountsToCreate.size()) ;  
        if (accountsToCreate.size() > 0 ) {
            List<WrpDataAccountToRcu> accountsToRcu = addAccountsToRCU(accountsToCreate);
            String jasonToRCU = JSON.serialize(accountsToRcu);
            EnvoiversRCU(jasonToRCU, accountsId);
            
            /****** Bypass Webservice for any batchs*******/
          	/*if(!System.isBatch()) {
            	System.debug('%% http request');
              	EnvoiversRCUAsync(jasonToRCU, accountsId);
          	}
           	else{
            	EnvoiversRCU(jasonToRCU, accountsId);
           	}*/
           	/************* end ************/
        }
        
        if(!idsRcu.isEmpty()) {
            updateCanal(idsRcu);
        }
    }
    
    // methode pour envoyer les informations du nouvel account au RCU UGC pour validation 
    public static void processTriggerAfterUpdate (Map<Id, Account> oldMapAccount, Map<Id, Account> newMapAccount)  {   
        
        system.debug ('--#### Nombre total de compte à mettre à jour =' + newMapAccount.values().size()) ;
        List<Account> accountsToUpdate = new List<Account>();
        List<Id> accountsId = new List<Id>();
        
        List<Id> idsRcu = new List<Id>();
        
        Map<String, Id> facebookMap = new Map<String, Id>();
        Map<String, Id> twitterMap = new Map<String, Id>();
        Map<String, Id> critizrMap = new Map<String, Id>();
        Map<String, Id> instagramMap = new Map<String, Id>();
        
        
        for (Account acc : newMapAccount.values()) {
            Account oldAcc = oldMapAccount.get(acc.Id);
            // Envoie au RCU que si le calnal de création maj est différent de 'RCU'
            system.debug ('--#### AccountId = ' +acc.Id+ ', Canal_creation_Maj__c =' + acc.Canal_creation_Maj__c) ;
            if (!'RCU'.equals(acc.Canal_creation_Maj__c) && 
                ( oldAcc.CodePays__c != newMapAccount.get(acc.Id).CodePays__c ||
                 oldAcc.PersonEmail != newMapAccount.get(acc.Id).PersonEmail  ||
                 oldAcc.NoCarteFidelite__c != newMapAccount.get(acc.Id).NoCarteFidelite__c  ||
                 oldAcc.NoCarteUI__c != newMapAccount.get(acc.Id).NoCarteUI__c  ||
                 oldAcc.FirstName != newMapAccount.get(acc.Id).FirstName  ||
                 oldAcc.Lastname != newMapAccount.get(acc.Id).Lastname  ||
                 oldAcc.PersonBirthdate != newMapAccount.get(acc.Id).PersonBirthdate  ||
                 oldAcc.Salutation != newMapAccount.get(acc.Id).Salutation  ||
                 oldAcc.NoVoie__c != newMapAccount.get(acc.Id).NoVoie__c  ||
                 oldAcc.TypeVoie__c != newMapAccount.get(acc.Id).TypeVoie__c  ||
                 oldAcc.Appartement__c != newMapAccount.get(acc.Id).Appartement__c  ||
                 oldAcc.Escalier__c != newMapAccount.get(acc.Id).Escalier__c  ||
                 oldAcc.Batiment__c != newMapAccount.get(acc.Id).Batiment__c  ||
                 oldAcc.Residence__c != newMapAccount.get(acc.Id).Residence__c  ||
                 oldAcc.NomVoie__c != newMapAccount.get(acc.Id).NomVoie__c  ||
                 oldAcc.CodePostal__c != newMapAccount.get(acc.Id).CodePostal__c  ||
                 oldAcc.Ville__c != newMapAccount.get(acc.Id).Ville__c  ||
                 oldAcc.Pays__c != newMapAccount.get(acc.Id).Pays__c  ||
                 oldAcc.PersonHomePhone != newMapAccount.get(acc.Id).PersonHomePhone  ||
                 oldAcc.PersonMobilePhone != newMapAccount.get(acc.Id).PersonMobilePhone
                ) ) {  
                    accountsToUpdate.add(acc);
                    accountsId.add(acc.Id);
                }
            
            
            if(acc.Canal_creation_Maj__c == 'RCU') {
                idsRcu.add(acc.Id);
            }
            
            if(acc.TECH_idCritizr__c != null && acc.TECH_idCritizr__c != oldAcc.TECH_idCritizr__c) {
                system.debug('## AP01_Account ## update Critizr: ' + oldAcc.TECH_idCritizr__c + ' -> ' + acc.TECH_idCritizr__c);
                critizrMap.put(acc.TECH_idCritizr__c, acc.Id);
            }
            if(acc.TECH_idFacebook__c != null && acc.TECH_idFacebook__c != oldAcc.TECH_idFacebook__c) {
                system.debug('## AP01_Account ## update FB: ' + oldAcc.TECH_idFacebook__c + ' -> ' + acc.TECH_idFacebook__c);
                facebookMap.put(acc.TECH_idFacebook__c, acc.Id);
            }
            if(acc.TECH_idInstagram__c != null && acc.TECH_idInstagram__c != oldAcc.TECH_idInstagram__c) {
                system.debug('## AP01_Account ## update Insta');
                instagramMap.put(acc.TECH_idInstagram__c, acc.Id);
            }
            if(acc.TECH_idTwitter__c != null && acc.TECH_idTwitter__c != oldAcc.TECH_idTwitter__c) {
                system.debug('## AP01_Account ## update Twitter');
                twitterMap.put(acc.TECH_idTwitter__c, acc.Id);
            }
            
        }            
        
        system.debug ('--#### Nombre de compte à transmettre au RCU =' + accountsToUpdate.size()) ;  
        if (accountsToUpdate.size() >0 ) {
            List<WrpDataAccountToRcu> accountsToRcu = addAccountsToRCU(accountsToUpdate);
            String jasonToRCU = JSON.serialize(accountsToRcu);
            EnvoiversRCU(jasonToRCU, accountsId);
            
            /****** Bypass Webservice for any batchs*******/
          	/*if(!System.isBatch()) {
              System.debug('%% http request');
              EnvoiversRCUAsync(jasonToRCU, accountsId);
          	}
           	else{
               EnvoiversRCU(jasonToRCU, accountsId);
           }*/
           /************* end ************/
            
        }
        
        if(critizrMap.size() + facebookMap.size() + instagramMap.size() + twitterMap.size() > 0) {
            updateCaseAccounts(facebookMap, twitterMap, critizrMap, instagramMap);
        }
        
        if(!idsRcu.isEmpty()) {
            updateCanal(idsRcu);
        }
    }
    
    private static void updateCanal(List<Id> ids) {
        if(ids.isEmpty()) {
            return;
        }
        List<Account> accounts = [SELECT Id, Canal_creation_Maj__c FROM Account WHERE Id in :ids];
        for(Account account: accounts) {
            account.Canal_creation_Maj__c = null;
        }
        update accounts;
    }
    
    /*@future(callout=true)
    public static void EnvoiversRCUAsync(String jasonToRcu, List<Id> comptesId) {
        EnvoiversRCU(jasonToRcu, comptesId);
   	}*/
    
    @future(callout=true)
    public static void EnvoiversRCU(String jasonToRcu, List<Id> comptesId) {
        system.debug('AP01_Account ## EnvoiversRCU start');
        
        list<Account> updatedAccountList = new list<Account> ();  //pour update du statut des account
        list<Id>   IdAccountList = new list<Id> ();
        
        // Receuperation de l url endpoint du WS RCU UGC dans le custom setting
        Global_Parameters__mdt ugcOneParam = Utils.getGlobalParameters('UGC_One_Parameters');
        system.debug ('--#### endpoint RCU = ' + ugcOneParam.EP_RCU_Account_Validation__c );
        
        String urlEndpointString ;  // valeur de l'url du endpoint RCU UGC
        
        if (Test.IsRunningTest()) {
            urlEndpointString = 'urlEndpointTest';
        } else {
            urlEndpointString = ugcOneParam.EP_RCU_Account_Validation__c + '/api/PostComptes/PostNewAndUpdateCompte';
        }
        
        // code appel  du WS pour anvoi
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(urlEndpointString);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setTimeout(2 * 60 * 1000);
        
        // Set the body as a JSON object
        system.debug('--#### jasonToRcu = '+jasonToRcu);
        request.setBody(jasonToRcu);
        try {
            HttpResponse response = http.send(request);
            
            system.debug('--#### Response = '+response);
            if ((response.getStatusCode() != 201) && (response.getStatusCode() != 200)) {  
                
                system.debug('--#### Invocation du WS RCU : KO. StausCode = '+response.getStatusCode() + ', Status = ' + response.getStatus());
                system.debug('--#### Mise à jour des statuts à "En attente"');
                //update du statut de l'account
                for (ID accToUpdateid : comptesId) {
                    account a = new account() ;
                    a.Id = accToUpdateid ;
                    a.CliStatutRCU__c = 'En attente' ;
                    a.Canal_creation_Maj__c = '';
                    a.TECH_Code_retour_RCU__c = '';
                    a.TECH_Message_retour_RCU__c = '';
                    updatedAccountList.add(a) ;
                }
            } else {
                
                system.debug('--#### Invocation du WS RCU : OK');
                
                //update du statut de l'account
                for (ID accToUpdateid : comptesId) {
                    Account a = new Account() ;
                    a.Id = accToUpdateid ;
                    a.Canal_creation_Maj__c = '';
                    //a.TECH_Code_retour_RCU__c = '';
                    //a.TECH_Message_retour_RCU__c = '';
                    updatedAccountList.add(a) ;
                }
            }        
        } catch (Exception e) {
            System.debug('--#### Exception ' + e);
        }
        if(updatedAccountList.size() > 0){
            try {
                system.debug('AP01_Account ## Reupdate: ' + updatedAccountList);
                PAD.ApexForcedBypass.add ('AP01_AccountAfterUpdate'); 
                Database.update(updatedAccountList, false) ;
            } catch(DmlException e) {
                system.debug('--#### ERROR lors de la mise à jour des comptes apès envoie RCU. Message = ' + e.getMessage());
            }
            PAD.ApexForcedBypass.remove('AP01_AccountAfterUpdate'); 
        }
        
    }
    
    public static List<WrpDataAccountToRcu> addAccountsToRCU(List<Account> accountsToToRcu){
        
        List<WrpDataAccountToRcu> accountsFormated = new List<WrpDataAccountToRcu>();
        List<Id> communesId = new List<Id>();
        Map<Id, String> nomCommIdMap = new Map<Id, String>();
        
        for(Account compte : accountsToToRcu){
            if(compte.Ville__c!=null){
                communesId.add(compte.Ville__c);
            }
        }
        
        List<Commune__c> communes = [SELECT Id, Name FROM Commune__c WHERE Id = :communesId];
        if(communes!=null && communes.size()>0){
            for(Commune__c com : communes){
                System.debug('--#### com.Id = '+com.Id+', Name = '+com.Name);
                nomCommIdMap.put(com.Id, com.Name);
            }
        }
        
        for(Account compte : accountsToToRcu){
            
            WrpDataAccountToRcu dataAccount = new WrpDataAccountToRcu();
            
            dataAccount.Pays = compte.CodePays__c;
            dataAccount.CompteId = compte.idMonCompte__c;
            dataAccount.IdSalesForce = compte.Id;
            dataAccount.Email = compte.PersonEmail;
            dataAccount.NumCarteFidelite = ('NC'.equalsIgnoreCase(compte.NoCarteFidelite__c)?null:compte.NoCarteFidelite__c);
            dataAccount.NumCarteUI = ('NC'.equalsIgnoreCase(compte.NoCarteUI__c)?null:compte.NoCarteUI__c);
            dataAccount.Nom = ('NC'.equalsIgnoreCase(Compte.LastName)?null:compte.LastName);
            dataAccount.Prenom = ('NC'.equalsIgnoreCase(compte.FirstName)?null:compte.FirstName);
            dataAccount.Date_Naissance = compte.PersonBirthdate;
            dataAccount.Civilite = ('NC'.equalsIgnoreCase(compte.Salutation)?null:compte.Salutation);
            dataAccount.Adresse_Num_Voie = ('NC'.equalsIgnoreCase(compte.NoVoie__c)?null:compte.NoVoie__c);
            dataAccount.Adresse_Type_Voie = ('NC'.equalsIgnoreCase(compte.TypeVoie__c)?null:compte.TypeVoie__c);
            dataAccount.Adresse_Appartement = ('NC'.equalsIgnoreCase(compte.Appartement__c)?null:compte.Appartement__c);
            dataAccount.Adresse_Escalier = ('NC'.equalsIgnoreCase(compte.Escalier__c)?null:compte.Escalier__c);
            dataAccount.Adresse_Immeuble = ('NC'.equalsIgnoreCase(compte.Batiment__c)?null:compte.Batiment__c);
            dataAccount.Adresse_Residence = ('NC'.equalsIgnoreCase(compte.Residence__c)?null:compte.Residence__c);
            dataAccount.Adresse_Nom_Voie = ('NC'.equalsIgnoreCase(compte.NomVoie__c)?null:compte.NomVoie__c);
            dataAccount.Adresse_Code_Postal = ('NC'.equalsIgnoreCase(compte.CodePostal__c)?null:compte.CodePostal__c);
            System.debug('--#### compte.Ville__c = '+compte.Ville__c);
            System.debug('--#### nomCommIdMap.get(compte.Ville__c) = '+nomCommIdMap.get(compte.Ville__c));
            if(compte.Ville__c!=null){
                dataAccount.Adresse_Ville = ('NC'.equalsIgnoreCase(nomCommIdMap.get(compte.Ville__c))? null : nomCommIdMap.get(compte.Ville__c)) ;
            }else{
                dataAccount.Adresse_Ville = null;
            }
            dataAccount.Adresse_Pays = ('NC'.equalsIgnoreCase(compte.Pays__c)?null:compte.Pays__c);
            dataAccount.Telephone_Fixe = ('NC'.equalsIgnoreCase(compte.PersonHomePhone)?null:compte.PersonHomePhone);
            dataAccount.Telephone_Portable = ('NC'.equalsIgnoreCase(compte.PersonMobilePhone)?null:compte.PersonMobilePhone);
            dataAccount.Date_Creation = compte.CreatedDate;
            dataAccount.Date_Modification = compte.LastModifiedDate;
            
            accountsFormated.add(dataAccount);
        }
        
        return accountsFormated;
    }
    
    @future
    public static void updateCaseAccounts(Map<String, Id> facebookMap, Map<String, Id> twitterMap, 
                                          Map<String, Id> critizrMap, Map<String, Id> instagramMap) {
                                              system.debug('AP01_Account ## Future call');
                                              Contact contactInconnu = Utils.getContactInconnu();
                                              List<Case> cases = [SELECT Id, TECH_idCritizr__c, TECH_idFacebook__c, TECH_idInstagram__c, TECH_idTwitter__c 
                                                                  FROM Case WHERE AccountId = :contactInconnu.accountId AND 
                                                                  (TECH_idCritizr__c IN :critizrMap.keySet() OR TECH_idFacebook__c IN :facebookMap.keySet() 
                                                                   OR TECH_idInstagram__c IN :instagramMap.keySet() OR TECH_idTwitter__c IN : twitterMap.keySet() ) ];
                                              
                                              for(Case cse: cases) {
                                                  if(cse.TECH_idFacebook__c != null && facebookMap.get(cse.TECH_idFacebook__c) != null) {
                                                      cse.AccountId = facebookMap.get(cse.TECH_idFacebook__c);
                                                  }
                                                  if(cse.TECH_idTwitter__c != null && twitterMap.get(cse.TECH_idTwitter__c) != null) {
                                                      cse.AccountId = twitterMap.get(cse.TECH_idTwitter__c);
                                                  }
                                                  if(cse.TECH_idCritizr__c != null && critizrMap.get(cse.TECH_idCritizr__c) != null) {
                                                      cse.AccountId = critizrMap.get(cse.TECH_idCritizr__c);
                                                  }
                                                  if(cse.TECH_idInstagram__c != null && instagramMap.get(cse.TECH_idInstagram__c) != null) {
                                                      cse.AccountId = instagramMap.get(cse.TECH_idInstagram__c);
                                                  }
                                                  
                                              }
                                              
                                              update cases;
                                              
                                          }
    
    private static void updateCodePaysPostal(List<Account> comptes) {
        Map<Id, Commune__c> villes = new Map<Id, Commune__c>();
        for(Account acc: comptes) {
            if(acc.ClientResident__c == 'France') {
                acc.CodePays__c = '033';
                acc.ProduitUGC__c = 'français';
            } else if(acc.ClientResident__c == 'Belgique') {
                acc.CodePays__c = '032';
                acc.ProduitUGC__c = 'belge';
            }
            
            if(acc.ville__c != null) {
                villes.put(acc.ville__c, null);
            }
        }
        
        List<Commune__c> communes = [SELECT Id, CodePostal__c, Pays__c FROM Commune__c WHERE Id IN :villes.keySet()];
        for(Commune__c commune: communes) {
            villes.put(commune.Id, commune);
        }
        
        for(Account acc: comptes) {
            Commune__c ville = villes.get(acc.ville__c);
            if(acc.ville__c != null && ville != null) {
                acc.CodePostal__c = ville.CodePostal__c;
                acc.Pays__c = ville.Pays__c;
            }
        }
    }
    
    public static void checkDuplicates(List<Account> accounts) {
        Set<String> codePays = new Set<String>();
        Set<String> emails = new Set<String>();
        for(Account acc: accounts) {
            if(acc.PersonEmail!=null){
                codePays.add(acc.CodePays__c);
                emails.add(acc.PersonEmail);
            }
        }
        
        List<Account> potentialDupes = [ SELECT Id, CodePays__c, CliStatutRCU__c, PersonEmail
                                        FROM Account
                                        WHERE CliStatutRCU__c IN ('En attente', 'Validé')
                                        AND CodePays__c IN :codePays
                                        AND PersonEmail IN :emails
                                       ];
        System.debug('AP01 ## Accounts: ' + accounts);
        System.debug('AP01 ## Dupes: ' + potentialDupes);
        for(Account acc: accounts) {
            for(Account candidate: potentialDupes) {
                if(acc.Id != candidate.Id
                   && acc.CodePays__c == candidate.CodePays__c
                   && acc.PersonEmail == candidate.PersonEmail
                   && (candidate.CliStatutRCU__c == 'En attente' || candidate.CliStatutRCU__c == 'Validé' )) {
                       acc.addError(Label.CL06_ERREUR_DOUBLON_SUR_COMPTE);
                   }
            }
        }
    }
    
    public static void calculScore(list<Account> listAccts){
        
    }
    
}