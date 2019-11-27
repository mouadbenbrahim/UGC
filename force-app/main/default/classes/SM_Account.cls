/**
 * Created by mouad on 03/09/2018.
 */

public with sharing class SM_Account {

    public static Account getAccount(Id accId){

        Account account = [
                SELECT Id, Name, MauvaisComportement__c, ProduitUGC__c, CodePays__c, PersonContactId
                FROM Account
                WHERE Id = :accId
        ];
        return account; //TODO 5 voir si c une passage en reference ou en valeur ?

    }
    
    public static Account getAccountForScorClient(Id accId){
        list<Account> listAccount = new list<Account> ([
        	SELECT Id, Name, MauvaisComportement__c, ProduitUGC__c, CodePays__c, PersonContactId,
				TECH_ConsommeSemaineActive__c, ID_parrain__c, FidSoldePoints__c,
                CliComplexePrefere1__c, CliComplexePrefere2__c, CliComplexePrefere3__c, CliComplexePrefere4__c, CliComplexePrefere5__c,
                CliStatutRCU__c, NoCarteFidelite__c,
                SouOptInNLHebdoBonsPlansUgc__c, SouOptInNLHebdoBonsPlansUI__c, SouOptInNLMensuelle__c, SouOptInNLPartenaires__c, 
                SouOptInNLPartenairesUGC__c, SouOptInNLPartenairesVLO__c, SouOptInNLVLO__c, PersonMobilePhone
                FROM Account
                WHERE Id = :accId]);
                
        if(listAccount.size() == 0){
        	return null;
        }
        return listAccount.get(0);
    }
    
    public static Double getNoteClient(Id accId){
    	system.debug('##MNE SM_Account getNoteClient accId >> '+accId);
    	
    	if(accId == null){
    		return 0;
    	}
    	
    	list<Zuora__Subscription__c> listSub = SM_Subscription.getActiveSubscriptionBySetAccId(new set<Id>{accId});
    	Zuora__Subscription__c sub = null;
    	
    	if(listSub.size() == 1){
    		sub = listSub.get(0);
    	}
    	
    	Account acc = getAccount(accId);
    	
    	
    	Double nbSemainesActives = 0;
    	Double nbImpayesParSemaineActive = 0;
    	Double nbConsommationParSemaineActive = 0;
    	Double nbParrainages = 0;
    	Double nbContactsEParSemActive = 0;
    	Double nbPointsFidelite = 0;
    	Boolean cinemaPrefereRenseigne = false;
    	Boolean espaceMonCompteActif = false;
    	Boolean fideliteActivee = false;
    	Boolean newsletterActivee = false;
    	Boolean telMobileRenseigne = false;
    	Boolean clickAndCollectChoisi = false;
    	
    	Double scoreNbSemainesActives = 0;
    	Double scoreNbImpayesParSemaineActive = 0;
    	Double scoreNbConsommationParSemaineActive = 0;
    	Double scoreNbParrainages = 0;
    	Double scoreNbContactsEParSemActive = 0;
    	Double scoreNbPointsFidelite = 0;
    	Double scoreCinemaPrefereRenseigne = 0;
    	Double scoreEspaceMonCompteActif = 0;
    	Double scoreFideliteActivee = 0;
    	Double scoreNewsletterActivee = 0;
    	Double scoreTelMobileRenseigne = 0;
    	Double scoreClickAndCollectChoisi = 0;
    	
    	return null;
    }

}