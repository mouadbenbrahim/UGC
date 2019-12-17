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
    	
    	//get Sub
    	list<Zuora__Subscription__c> listSub = SM_Subscription.getActiveSubscriptionBySetAccId(new set<Id>{accId});
    	Zuora__Subscription__c sub = null;
    	if(listSub.size() == 1){
    		sub = listSub.get(0);
    	}
    	
    	//get Account
    	Account acc = getAccountForScorClient(accId);
    	
    	//get Account Parrainé
    	list<Account> listAccParraine = new list<Account>([SELECT Id FROM Account WHERE ID_parrain__c = :accId]);
    	
    	list<AggregateResult> resElemEntant= new list<AggregateResult>([select COUNT(Id), SUM(NbAppelsEntrants__c)nbAppel, SUM(NbCourriersEntrants__c)nbACourrier,SUM(NbEmailsEntrants__c )nbEmail FROM Case WHERE AccountId = :accId]);
    	list<AggregateResult> resCaseImpaye= new list<AggregateResult>([select COUNT(Id) FROM Case WHERE AccountId = :accId AND RecordType.Name = 'Impayé' AND SousMotif__c IN ('R1- 1er rejet','R2- 2nd rejet')]);
    	
    	
    	//Nombre de semaines actives	OK
    	Double nbSemainesActives = 0;
    	Date todayDate = Date.today();
    	if(sub != null){
    		if(sub.Zuora__ContractEffectiveDate__c > todayDate){
    			nbSemainesActives = 0;
    		} else {
    			Integer numberDays = sub.Zuora__ContractEffectiveDate__c.daysBetween(todayDate);
    			nbSemainesActives = numberDays/7;
    		}
    	}
    	Double scoreNbSemainesActives = 0;
		if(nbSemainesActives <= 53) {scoreNbSemainesActives = 0;}
		else if(nbSemainesActives <= 105) {scoreNbSemainesActives = 0.2;}
		else if(nbSemainesActives <= 157) {scoreNbSemainesActives = 0.4;}
		else if(nbSemainesActives <= 209) {scoreNbSemainesActives = 0.6;}
		else if(nbSemainesActives <= 261) {scoreNbSemainesActives = 0.8;}
		else if(nbSemainesActives <= 313) {scoreNbSemainesActives = 1;}
		else if(nbSemainesActives >= 314) {scoreNbSemainesActives = 1.2;}
		
		system.debug('##MNE SM_Account getNoteClient Nombre de semaines actives >> '+nbSemainesActives);
		system.debug('##MNE SM_Account getNoteClient score pour Nombre de semaines actives >> '+scoreNbSemainesActives);
    	
    	
    	//Nombre d'impayés par semaine active
    	Double nbImpayes = 0;
    	if(resCaseImpaye.size() == 1){
    		nbImpayes = resCaseImpaye[0].get('expr0') != null ? Double.valueof(resCaseImpaye[0].get('expr0')) : 0;
    	}
    	Double nbImpayesParSemActive = 0;
    	if(nbSemainesActives != 0 && nbImpayes != 0){
    		nbImpayesParSemActive = nbImpayes / nbSemainesActives;
    	}
    	Double scoreNbImpayesParSemaineActive = 0;
    	if(nbImpayesParSemActive <= 0.05) {scoreNbImpayesParSemaineActive = 1;}
    	else if(nbImpayesParSemActive > 0.05) {scoreNbImpayesParSemaineActive = 0;}
    	
    	system.debug('##MNE SM_Account getNoteClient Nombre d\'impayés par semaine active >> '+nbImpayesParSemActive);
		system.debug('##MNE SM_Account getNoteClient score Nombre d\'impayés par semaine active >> '+scoreNbImpayesParSemaineActive);
    	
    	
    	//Nombre de consommation par semaine active
    	Double nbConsommationParSemaineActive = 0;
    	if(acc.TECH_ConsommeSemaineActive__c != null && (acc.TECH_ConsommeSemaineActive__c.isNumeric() || acc.TECH_ConsommeSemaineActive__c.remove('.').isNumeric())){
    		nbConsommationParSemaineActive = Double.valueOf(acc.TECH_ConsommeSemaineActive__c);
    	}
    	Double scoreNbConsommationParSemaineActive = 0;
    	if(nbConsommationParSemaineActive == 0) {scoreNbConsommationParSemaineActive = 1.5;}
    	else if(nbConsommationParSemaineActive <= 0.125) {scoreNbConsommationParSemaineActive = 1;}
    	else if(nbConsommationParSemaineActive <= 0.251) {scoreNbConsommationParSemaineActive = 0.5;}
    	else if(nbConsommationParSemaineActive <= 0.751) {scoreNbConsommationParSemaineActive = 0.25;}
    	else if(nbConsommationParSemaineActive > 0.751) {scoreNbConsommationParSemaineActive = 0;}
    	
    	system.debug('##MNE SM_Account getNoteClient Nombre de consommation par semaine active >> '+nbConsommationParSemaineActive);
		system.debug('##MNE SM_Account getNoteClient score Nombre de consommation par semaine active >> '+scoreNbConsommationParSemaineActive);
		
    	
    	//Nombre de parrainages
    	Double nbParrainages = listAccParraine.size();
    	Double scoreNbParrainages = 0;
    	if(nbParrainages == 0) {scoreNbParrainages = 0;}
    	else if(nbParrainages == 1) {scoreNbParrainages = 0.3;}
    	else if(nbParrainages == 2) {scoreNbParrainages = 0.6;}
    	else if(nbParrainages >= 3) {scoreNbParrainages = 1;}
    	
    	system.debug('##MNE SM_Account getNoteClient Nombre de parrainages >> '+nbParrainages);
		system.debug('##MNE SM_Account getNoteClient score Nombre de parrainages >> '+scoreNbParrainages);
		
    	
    	//Nombre de contacts E par sem active
    	Double nbAppel = 0;
		Double nbACourrier = 0;
		Double nbEmail = 0;
    	if(resElemEntant.size() == 1){
    		nbAppel = resElemEntant[0].get('nbAppel') != null ? Double.valueof(resElemEntant[0].get('nbAppel')) : 0;
    		nbACourrier = resElemEntant[0].get('nbACourrier') != null ? Double.valueof(resElemEntant[0].get('nbACourrier')) : 0;
    		nbEmail = resElemEntant[0].get('nbEmail') != null ? Double.valueof(resElemEntant[0].get('nbEmail')) : 0;
    	}
    	Double nbTotalContactsEParSemActive = nbAppel + nbACourrier + nbEmail;
    	Double moyenneContactsEParSemActive = 0;
    	if(nbSemainesActives != 0 && nbTotalContactsEParSemActive != 0){
    		moyenneContactsEParSemActive = nbTotalContactsEParSemActive / nbSemainesActives;
    	}
    	Double scoreNbContactsEParSemActive = 0;
    	if(moyenneContactsEParSemActive <= 0.014){scoreNbContactsEParSemActive = 1;}
    	else if(moyenneContactsEParSemActive > 0.014){scoreNbContactsEParSemActive = 0;}
    	
    	system.debug('##MNE SM_Account getNoteClient Nombre de contacts E par sem active >> '+moyenneContactsEParSemActive);
		system.debug('##MNE SM_Account getNoteClient score Nombre de contacts E par sem active >> '+scoreNbContactsEParSemActive);
		
    	
    	//Nombre de points fidélité
    	Double nbPointsFidelite = acc.FidSoldePoints__c == null ? 0 : acc.FidSoldePoints__c;
    	Double scoreNbPointsFidelite = 0;
    	if(nbPointsFidelite < 750) {scoreNbPointsFidelite = 0;}
    	else if(nbPointsFidelite <= 1500) {scoreNbPointsFidelite = 0.25;}
    	else if(nbPointsFidelite <= 3000) {scoreNbPointsFidelite = 0.5;}
    	else if(nbPointsFidelite > 3000) {scoreNbPointsFidelite = 1;}
    	
    	system.debug('##MNE SM_Account getNoteClient Nombre de points fidélité >> '+nbPointsFidelite);
		system.debug('##MNE SM_Account getNoteClient score Nombre de points fidélité >> '+scoreNbPointsFidelite);
		
    	
    	//Cinéma préféré renseigné?
    	Double scoreCinemaPrefereRenseigne = acc.CliComplexePrefere1__c != null || acc.CliComplexePrefere2__c != null || acc.CliComplexePrefere3__c != null || acc.CliComplexePrefere4__c != null || acc.CliComplexePrefere5__c != null ? 1 : 0;
    	
		system.debug('##MNE SM_Account getNoteClient score Cinéma préféré renseigné >> '+scoreCinemaPrefereRenseigne);
		
		
    	//Espace mon compte actif?
    	Double scoreEspaceMonCompteActif = acc.CliStatutRCU__c == 'Validé' ? 1 : 0;
    	
    	system.debug('##MNE SM_Account getNoteClient score Espace mon compte actif >> '+scoreEspaceMonCompteActif);
    	
    	
    	//Fidélité activée?
    	Double scoreFideliteActivee = acc.NoCarteFidelite__c != null ? 1 : 0;
    	
    	system.debug('##MNE SM_Account getNoteClient score Fidélité activée >> '+scoreFideliteActivee);
    	
    	
    	//newsletter activée?
    	Double scoreNewsletterActivee = acc.SouOptInNLHebdoBonsPlansUgc__c || acc.SouOptInNLHebdoBonsPlansUI__c || acc.SouOptInNLMensuelle__c || acc.SouOptInNLPartenaires__c || acc.SouOptInNLPartenairesUGC__c || acc.SouOptInNLPartenairesVLO__c || acc.SouOptInNLVLO__c ? 1 : 0;
    	
    	system.debug('##MNE SM_Account getNoteClient score Newsletter activée >> '+scoreNewsletterActivee);
    	
    	
    	//Tel Mobile renseigné?
    	Double scoreTelMobileRenseigne = acc.PersonMobilePhone != null ? 1 : 0;
    	
    	system.debug('##MNE SM_Account getNoteClient score Tel Mobile renseigné >> '+scoreTelMobileRenseigne);
    	
    	
    	//Click & Collect choisi?
    	Boolean clickAndCollectChoisi = false;
    	Double scoreClickAndCollectChoisi = clickAndCollectChoisi ? 1 : 0;
    	
    	system.debug('##MNE SM_Account getNoteClient Click & Collect choisi >> '+clickAndCollectChoisi);
		system.debug('##MNE SM_Account getNoteClient score Click & Collect choisi >> '+scoreClickAndCollectChoisi);
		
		Double ScoreFinal = 0;
		
		ScoreFinal += scoreNbSemainesActives				* 1;
		ScoreFinal += scoreNbImpayesParSemaineActive		* 0.8;
		ScoreFinal += scoreNbConsommationParSemaineActive	* 0.8;
		ScoreFinal += scoreNbParrainages					* 0.7;
		ScoreFinal += scoreNbContactsEParSemActive			* 0.4;
		ScoreFinal += scoreNbPointsFidelite					* 0.7;
		ScoreFinal += scoreCinemaPrefereRenseigne			* 0.1;
		ScoreFinal += scoreEspaceMonCompteActif				* 0.5;
		ScoreFinal += scoreFideliteActivee					* 0.1;
		ScoreFinal += scoreNewsletterActivee				* 0.1;
		ScoreFinal += scoreTelMobileRenseigne				* 0.1;
		ScoreFinal += scoreClickAndCollectChoisi			* 0.1;
    	
    	system.debug('##MNE SM_Account getNoteClient ScoreFinal >> '+ScoreFinal);
    	
    	return ScoreFinal;
    }

}