public with sharing class CalculPrimes {
	
	private static final Integer dailyBusinessHours = 24;
	
	@TestVisible
	static Date dateDuJour = Date.today();
    
    public static void tallyFrenchCounters() {
    	BusinessHours frBH = [select id from Businesshours where name='France'];
    	if(!BusinessHours.isWithin(frBH.id, dateDuJour)) {
    		return;
    	}
    	
    	String[] names = Utils.getQueueNames('France');
    	 
    	tallyCounters(frBH, names, 'France');
    }
    
    public static void tallyBelgianCounters() {
    	BusinessHours beBH = [select id from Businesshours where name='Belgique']; 
    	if(!BusinessHours.isWithin(beBH.id, dateDuJour)) {
    		return;
    	}
    	
    	Global_Parameters__mdt param = Utils.getGlobalParameters('UGC_One_Parameters');
    	String[] names = Utils.getQueueNames('Belgique');
    	
    	tallyCounters(beBH, names, 'Belgique');
    }
    
    public static void tallyCounters(BusinessHours bh, String[] queueNames, String pays) {
    	
    	System.debug('CalculPrime ## names: ' + queueNames );
    	
    	List<Group> queues = [SELECT Id, DeveloperNAME 
                                FROM Group 
                               WHERE Type = 'Queue'
                                 AND DeveloperNAME IN :queueNames];
                                 
        System.debug('CalculPrime ## queues: ' + queues );
        Map<Id, Group> idQueues = new Map<Id, Group>();
        for(Group queue: queues) {
        	idQueues.put(queue.id, queue);
        }
        List<AggregateResult> oldestCases = [SELECT min(CreatedDate) CreatedDate, OwnerId 
        									FROM Case 
        									WHERE OwnerId IN :idQueues.keySet() AND Status = 'ATraiter'
        									AND (AccountId = null OR Account.NoCarteUI__c = null)
        									GROUP BY OwnerId];
        
        System.debug('CalculPrime ## oldestCases: ' + oldestCases );
        
        List<Compteur_Prime__c> compteurs = new List<Compteur_Prime__c>();
        
    	for(AggregateResult agg: oldestCases) {
    		Compteur_Prime__c cpt = new Compteur_Prime__c();
    		cpt.Queue_Name__c = idQueues.get((Id) agg.get('OwnerId')).DeveloperNAME;
    		cpt.Date_du_jour__c = dateDuJour;
    		cpt.Date_Demande__c = ((DateTime) agg.get('CreatedDate')).date();
    		Decimal diff = BusinessHours.diff(bh.id, cpt.Date_Demande__c, cpt.Date_du_jour__c);
    		Long delai = (diff / 1000 / 3600 / dailyBusinessHours).round(System.RoundingMode.HALF_EVEN);
    		cpt.Delai__c =  delai;
    		compteurs.add(cpt);
    	} 
    	insert compteurs;
    }
}