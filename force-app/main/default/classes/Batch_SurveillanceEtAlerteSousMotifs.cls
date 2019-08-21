global class Batch_SurveillanceEtAlerteSousMotifs implements Database.Batchable<sObject> {
             
	
	Datetime dateReference;
	String query;
	Integer seuilAlerte = 5;
    CollaborationGroup groupChatter;
	List<String> sousMotifsLst;
	
	global Batch_SurveillanceEtAlerteSousMotifs() {

		Global_Parameters__mdt ugcOneParam = Utils.getGlobalParameters('UGC_One_Parameters');
       	
		if(ugcOneParam!=null){

			System.debug('--#### Custum settings Sous-Motifs à surveiller = ' + ugcOneParam.Sous_Motifs__c);

			seuilAlerte = Integer.valueOf(ugcOneParam.Seuil_Alerte_Par_Heure__c);
			System.debug('--#### Seuil d\'alerte = ' + seuilAlerte);

			String nomGroupChatter = ugcOneParam.Nom_Groupe_Chatter__c;
	        groupChatter = [SELECT Id, Name FROM CollaborationGroup WHERE Name =: nomGroupChatter].get(0);
	        
	        System.debug('--#### Nom du groupe chatter = ' + nomGroupChatter + ', Id = '+groupChatter.Id);

			String sousMotifs = ugcOneParam.Sous_Motifs__c;
            System.debug('--#### String sousMotifs = ' + sousMotifs);

			sousMotifsLst = new List<String>();
            for(String sousphrase : sousMotifs.split('[\n\r]')){
                if (sousphrase !=''){
	                sousMotifsLst.add(sousphrase.trim());
                }
  			}
        
			System.debug('--#### Liste des sous-motifs à surveiller = ' + sousMotifsLst);
		}else{
			System.debug('--#### ERROR BATCH : ugcOneParam est null !!!!');
		}

        // System.now() donne l'heure de GMT c'est a dire 2 heure de moins qu'à Paris donc pour avoir heure de (Paris - 1) :
		dateReference = System.now().addHours(-1);
		query = 'SELECT Id, SousMotif__c ';
		query += ' FROM Case';
		query += ' WHERE SousMotif__c IN :sousMotifsLst';
		query += ' AND CreatedDate >= :dateReference';
		query += ' AND TECH_Alert__c != TRUE';
		query += ' ORDER BY SousMotif__c';

		System.debug('--#### query = ' + query);
		
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<sObject> scope) {
		Map<String, List<Id>> createdSousMotifsMap = new Map<String, List<Id>>();
		List<Id> caseIds;
        System.debug('--#### Nombre de cases à traiter = ' + scope.size());

		for(Case c : (List<Case>)scope){
			caseIds = createdSousMotifsMap.get(c.SousMotif__c);
			if(caseIds==null){
				caseIds = new List<Id>();
			}
			caseIds.add(c.Id);
			createdSousMotifsMap.put(c.SousMotif__c, caseIds);
		}

		for(String sousMotif : createdSousMotifsMap.keySet()){
			Integer nbCasesTraites = createdSousMotifsMap.get(sousMotif).size();
			if( nbCasesTraites >= seuilAlerte){
				System.debug('--#### Post Chatter pour le sous-motif = ' + sousMotif + ', Nombre de case créés = ' + nbCasesTraites);
				String message = nbCasesTraites + ' demandes avec le sous-motif "' + sousMotif + '" ont été traitées dans l\'heure.';
                ConnectApi.FeedElement feedElement = ConnectApi.ChatterFeeds.postFeedElement(Network.getNetworkId(), groupChatter.Id, 
                	ConnectApi.FeedElementType.FeedItem, message);
			}
		}
		
		List<Case> cases = new List<Case>();
		
		for(List<Id> ids: createdSousMotifsMap.values()) {
			for(Id id: ids) {
				cases.add(new Case(Id = id, TECH_Alert__c = true));
			}
		}
		
		update cases;

	}
	
	global void finish(Database.BatchableContext BC) {
		
	}
	
}