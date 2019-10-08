/**
 * Created by mouad on 02/12/2018.
 */

public with sharing class SM_Invoice {

    //public static String zEntityId = '8adce421-63ec-c07b-0163-f45782667179'; // France

    /*public static WSZ.InvoiceItemsOut getInvoiceItems(String invoiceId) {
        //String endpoint = 'https://rest.sandbox.eu.zuora.com/v1/creditmemos/' + memoId;
        String endpoint = '/v1/invoices/'+ invoiceId +'/items';
        String method = 'GET';
        String wsIn = null;
        String wsOut = '';

        // Retrieve Zuora token
        String accessToken = WS001_CallZuora.access_token;

        wsOut = WS001_CallZuora.sendRequest(accessToken, endpoint, zEntityId, method, wsIn, 'type1', null);
        //wsOut = wsOut.replace('number','numberx');
        //wsOut = wsOut.replace('currency', 'currencyx');
        return (WSZ.InvoiceItemsOut) JSON.deserializeStrict(wsOut, WSZ.InvoiceItemsOut.class);
    }*/
    
    public static void processTriggerAfter (Map<Id, Zuora__ZInvoice__c> mapOldInvoices, List<Zuora__ZInvoice__c> listNewInvoices)  { 
    	if(mapOldInvoices == null){
    		processTriggerAfterInsert(listNewInvoices);
    	}else {
    		processTriggerAfterUpdate (mapOldInvoices, listNewInvoices);
    	}
    	
    }
    
    public static void processTriggerAfterInsert (List<Zuora__ZInvoice__c> listInvoices)  { 
    	system.debug ('##MNE SM_Invoice processTriggerAfterInsert listInvoices >> ' + listInvoices); 
    	map<Id, Zuora__ZInvoice__c> mapInvoiceByIdToCreateCase = new map<Id, Zuora__ZInvoice__c>();
    	set<Id> setAccountIdToDeactivateCard = new set<Id>();
    	set<Id> setAccountIdToReactivateCard = new set<Id>();
    	
    	for(Zuora__ZInvoice__c inv : listInvoices){
    		if(inv.Tech_FlagRejetPaye__c == 'true'){
    			//activer carte
    			if(inv.Zuora__Account__c != null){
    				setAccountIdToReactivateCard.add(inv.Zuora__Account__c);
    			}
    		}
    		else if(inv.Tech_FlagRejetPaye__c == 'false' && (inv.Tech_TypeRejet__c == 'Rejet_1' || inv.Tech_TypeRejet__c == 'Rejet_2')){
    			mapInvoiceByIdToCreateCase.put(inv.Id, inv);
    			if(inv.Zuora__Account__c != null){
    				setAccountIdToDeactivateCard.add(inv.Zuora__Account__c);
    			}
    		}
    	}
    	
    	list<Case> listRejetCaseCreated;
    	if(mapInvoiceByIdToCreateCase.size() > 0){
    		listRejetCaseCreated = createRejetCase(mapInvoiceByIdToCreateCase);
    	}
    	
    	if(setAccountIdToDeactivateCard.size() > 0){
    		system.debug ('##MNE SM_Invoice processTriggerAfterInsert callout Asynchrone methode desactivation card'); 
    		SM_Carte.desactivationByListAsynchrone(setAccountIdToDeactivateCard, 'X');
    	}
    	
    	if(setAccountIdToReactivateCard.size() > 0){
    		system.debug ('##MNE SM_Invoice processTriggerAfterInsert callout Asynchrone methode resactivation card'); 
    		SM_Carte.activationByListAsynchrone(setAccountIdToReactivateCard);
    	}
    	
    	system.debug ('##MNE SM_Invoice processTriggerAfterInsert END'); 
    }
    
	public static void processTriggerAfterUpdate (Map<Id, Zuora__ZInvoice__c> mapOldInvoices, List<Zuora__ZInvoice__c> listNewInvoices)  {   
		system.debug ('##MNE SM_Invoice processTriggerAfterUpdate mapOldInvoices >> ' + mapOldInvoices); 
		system.debug ('##MNE SM_Invoice processTriggerAfterUpdate listNewInvoices >> ' + listNewInvoices); 
		map<Id, Zuora__ZInvoice__c> mapInvoiceByIdToCreateCase = new map<Id, Zuora__ZInvoice__c>();
    	set<Id> setAccountIdToDeactivateCard = new set<Id>();
    	set<Id> setAccountIdToReactivateCard = new set<Id>();
		
		for(Zuora__ZInvoice__c inv : listNewInvoices){
			Zuora__ZInvoice__c oldinv = mapOldInvoices.get(inv.Id);
			
			system.debug ('##MNE SM_Invoice processTriggerAfterUpdate inv.Tech_FlagRejetPaye__c >> ' + inv.Tech_FlagRejetPaye__c); 
			system.debug ('##MNE SM_Invoice processTriggerAfterUpdate oldinv.Tech_FlagRejetPaye__c >> ' + oldinv.Tech_FlagRejetPaye__c); 
			system.debug ('##MNE SM_Invoice processTriggerAfterUpdate inv.Tech_TypeRejet__c >> ' + inv.Tech_TypeRejet__c); 
			system.debug ('##MNE SM_Invoice processTriggerAfterUpdate oldinv.Tech_TypeRejet__c >> ' + oldinv.Tech_TypeRejet__c); 
			
			if(inv.Tech_FlagRejetPaye__c != oldinv.Tech_FlagRejetPaye__c && inv.Tech_FlagRejetPaye__c == 'true'){
				//reactiver la carte
				if(inv.Zuora__Account__c != null){
    				setAccountIdToReactivateCard.add(inv.Zuora__Account__c);
    			}
			}
			else if(inv.Tech_FlagRejetPaye__c == 'false' && inv.Tech_TypeRejet__c != oldinv.Tech_TypeRejet__c && (inv.Tech_TypeRejet__c == 'Rejet_1' || inv.Tech_TypeRejet__c == 'Rejet_2')){
				mapInvoiceByIdToCreateCase.put(inv.Id, inv);
    			if(inv.Zuora__Account__c != null){
    				setAccountIdToDeactivateCard.add(inv.Zuora__Account__c);
    			}
			}
		}
		
		list<Case> listRejetCaseCreated;
    	if(mapInvoiceByIdToCreateCase.size() > 0){
    		listRejetCaseCreated = createRejetCase(mapInvoiceByIdToCreateCase);
    	}
    	
    	if(setAccountIdToDeactivateCard.size() > 0){
    		system.debug ('##MNE SM_Invoice processTriggerAfterUpdate callout Asynchrone methode desactivation card'); 
    		SM_Carte.desactivationByListAsynchrone(setAccountIdToDeactivateCard, 'X');
    	}
    	
    	if(setAccountIdToReactivateCard.size() > 0){
    		system.debug ('##MNE SM_Invoice processTriggerAfterUpdate callout Asynchrone methode resactivation card'); 
    		SM_Carte.activationByListAsynchrone(setAccountIdToReactivateCard);
    	}
    	
    	system.debug ('##MNE SM_Invoice processTriggerAfterUpdate END'); 
    }
    
    
    public static list<Case> createRejetCase(map<Id, Zuora__ZInvoice__c> mapInvoiceByIdToCreateCase){
    	system.debug ('##MNE SM_Invoice createRejetCase mapInvoiceByIdToCreateCase >> ' + mapInvoiceByIdToCreateCase); 
    	list<Case> listCaseToInsert = new list<Case>();
        Id impayeRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Impayé').getRecordTypeId();
        
        for(Zuora__ZInvoice__c inv : mapInvoiceByIdToCreateCase.values()){
        	Case c = new Case();
	        c.RecordTypeId = impayeRecordTypeId;
	        c.AccountId = inv.Zuora__Account__c;
	        c.Famille__c = '7- Finance';
	 		c.Motif__c = '02- Impayé';
	 		c.CommentairesInternes__c = inv.Tech_CodeRejet__c+' / '+inv.Tech_DateRejet__c;
	 		c.Origin = 'Interne';
	 		
	 		if(inv.Tech_FlagRejetPaye__c == 'false' && (inv.Tech_TypeRejet__c == 'Rejet_1' || inv.Tech_TypeRejet__c == 'Rejet_2') && inv.Tech_CodeRejet__c == 'MD07'){
	 			c.SousMotif__c = 'I- Info';
    		}
    		else if(inv.Tech_FlagRejetPaye__c == 'false' && inv.Tech_TypeRejet__c == 'Rejet_1' && inv.Tech_CodeRejet__c != 'MD07'){
    			c.SousMotif__c = 'R1- 1er rejet';
    		}
    		else if(inv.Tech_FlagRejetPaye__c == 'false' && inv.Tech_TypeRejet__c == 'Rejet_2' && inv.Tech_CodeRejet__c != 'MD07'){
    			c.SousMotif__c = 'R2- 2nd rejet';
    		}
	 		listCaseToInsert.add(c);
        }
        system.debug ('##MNE SM_Invoice createRejetCase listCaseToInsert size >> ' + listCaseToInsert); 
        system.debug ('##MNE SM_Invoice createRejetCase listCaseToInsert >> ' + listCaseToInsert.size()); 
        if(listCaseToInsert.size() > 0){
        	insert listCaseToInsert;
        }
        system.debug ('##MNE SM_Invoice createRejetCase END'); 
        return listCaseToInsert;
    }


}