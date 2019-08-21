@RestResource(urlMapping='/WebToCase')
global with sharing class WS01_WebToCaseWithPJ {
    
    @HttpPost
    global static ReturnClass HandleCases() {
        
        Case caseWebToCase = new Case();
        RestRequest req = RestContext.request;
        Blob jsonBlob = req.requestBody;
        
        String jsonString = jsonBlob.toString();
        System.debug('--#### jsonString brute = ' + jsonString);
        
        Global_Parameters__mdt gParam = Utils.getGlobalParameters('UGC_One_Parameters');
        System.debug('--#### Deployment Level = '+gParam.Deployment_Level__c); // Deployment_Level__c = SATGE-LOT1
        
        WrpWebToCase webToCaseIn = (WrpWebToCase)JSON.deserialize(jsonString, WrpWebToCase.class);
        System.debug('--#### Jason Data in = ' + webToCaseIn);
        
        String typeCarte = getTypeCarte(webToCaseIn.carteNumber, gParam.Deployment_Level__c); //typeCarte = 'N/A' ou 'CarteFID' ou ''
        System.debug('--#### Type carte formulaire = ' + typeCarte);
        
        Case caseToCreate = new Case();
        Suivi_Demandes_Fidelite__c suiviDemande = new Suivi_Demandes_Fidelite__c();
        suiviDemande.Carte_Number__c = webToCaseIn.carteNumber;
        suiviDemande.Description__c = webToCaseIn.description;
        suiviDemande.Email__c = webToCaseIn.email;
        suiviDemande.First_Name__c = webToCaseIn.firstName;
        suiviDemande.Last_Name__c = webToCaseIn.lastName;
        suiviDemande.Question_Concerne__c = webToCaseIn.questionConcerne;
        suiviDemande.Subject__c = webToCaseIn.subject;  
        
        //pas de case si num catre renseigner et pas de type FID ('831[0-9]{13}')   
        //if('CarteFID'.equalsIgnoreCase(typeCarte)  || (''.equalsIgnoreCase(typeCarte)) && (webToCaseIn.subject.startsWithIgnoreCase('Un autre produit'))){
            
            // Recherche du recorde type du case à créer
            //Id rtId = [SELECT Id FROM RecordType where DeveloperName = 'DemandesCliensencours'].get(0).Id;
            Id rtId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Standard').getRecordTypeId();
            
            Contact[] contacts = [SELECT Id, Account.Id, Account.NoCarteUI__c FROM Contact WHERE Account.PersonEmail = :webToCaseIn.email Limit 1] ;
            
            if (contacts.size() == 1) {
                caseToCreate.AccountId = contacts.get(0).Account.Id;
                caseToCreate.ContactId = contacts.get(0).Id;
            } 
            
            System.debug('--#### Client non UI ==> Création Case ...');
            caseToCreate.Subject = webToCaseIn.subject;
            caseToCreate.Description = webToCaseIn.description;
            caseToCreate.Origin = 'Formulairedecontact';
            String s1 = webToCaseIn.questionConcerne;
        	String s2  = s1.split('\\-').get(0);
            caseToCreate.QuestionConcerne__c = s2;
            System.debug( webToCaseIn.questionConcerne);
            caseToCreate.nom__c = webToCaseIn.lastName;
            caseToCreate.prenom__c = webToCaseIn.firstName;
            caseToCreate.Courriel__c = webToCaseIn.email;
            caseToCreate.TECH_NoCarteFideliteFormulaire__c = webToCaseIn.carteNumber;
            caseToCreate.RecordTypeId = rtId;
            caseToCreate.TECH_CodePaysFormulaire__c = ('FR'.equalsIgnoreCase(webToCaseIn.Pays)?'033':('BE'.equalsIgnoreCase(webToCaseIn.Pays)?'032':''));
            
            try {
                Insert caseToCreate;
                return new ReturnClass('success', 'Cases treatment worked as expected with email client', caseToCreate.Id);
                
            } catch (Exception e) {
                suiviDemande.Message_Erreur__c = 'Erreur Insertion Case : ' + e.getMessage();
                Insert suiviDemande;
                return new ReturnClass('failed', e.getMessage(), null);
            }

        /*}
        
        else{
            suiviDemande.Message_Erreur__c = 'Le numéro de carte n\'est pas reconnue comme carte de Fidélité';
            Insert suiviDemande;
            System.debug('--#### Client UI (Numéro de carte transmise) ==> Pas de création Case, demande de transmission à Bilendi.');
            return new ReturnClass('delayed', 'Ticket à transmettre à Bilendi car numéro de NON Fidélité.', null);
        }*/
        
    }
    
    public static String getTypeCarte(String carteNumber, String deploymentStage){
        String strRetour = 'NA';
        if(carteNumber != ''){
            Pattern patternCarteUI = Pattern.compile('000[0-9]{8}|01[0-9]{9}');
			Pattern patternCarteFID = Pattern.compile('831[0-9]{13}');
        
	        Matcher matchCarteUI = patternCarteUI.matcher(carteNumber);
	        Matcher matchcarteFID = patternCarteFID.matcher(carteNumber);
        
        	if(carteNumber!=null && matchcarteFID.matches()){
            	strRetour = 'CarteFID';
        	}
        	return strRetour;
        }
       return '';
    }
    
    
    global class ReturnClass {
        
        global String status;
        global String message;
        global Id caseId;
        
        global ReturnClass(String status, String message, Id caseId) {
            this.status = status;
            this.message = message;
            this.caseId = caseId;
        }
        
    }
    
}