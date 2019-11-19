@isTest
public class CalculPrimes_Test {
    
    private static Account accountNoCarte;
    
    private static void init() {
    	Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
    	accountNoCarte = new Account(LastName='test', FirstName='test', RecordTypeId = Utils.getComptePersonelAccountRecordType().Id, 
        	PersonEmail='test@test.test', CliEmailComplementaire__c='test@test.test', NPAIEMAIL__c = false, PNDADRESSE__c = false);
        insert accountNoCarte;
    }
    
    @IsTest
    static void tallyFrenchCountersTest() {
    	
    	CalculPrimes.dateDuJour = Date.valueOf('2017-11-20');  // Lundi
    	Group queue = [SELECT Id, DeveloperName FROM Group WHERE type='Queue' AND DeveloperName = 'FR_AutresProduitsUnAutreSujet'];
    	
    	createCase(queue.id, Date.valueOf('2017-11-18'));
		createCase(queue.id, Date.valueOf('2017-11-17'));
		createCase(queue.id, Date.valueOf('2017-11-16'));    	
    	
    	CalculPrimes.tallyFrenchCounters();
    	
    	List<Compteur_Prime__c> compteurs = [SELECT id, Queue_Name__c, Date_du_jour__c, Date_Demande__c, Delai__c FROM Compteur_Prime__c];
    	
    	/*System.assertEquals(1, compteurs.size());
    	Compteur_Prime__c cpt = compteurs.get(0);
    	System.assertEquals('FR_AutresProduitsUnAutreSujet', cpt.Queue_Name__c);
    	System.assertEquals(Date.valueOf('2017-11-20'), cpt.Date_du_jour__c);
    	System.assertEquals(Date.valueOf('2017-11-16'), cpt.Date_Demande__c);
    	System.assertEquals(2, cpt.Delai__c);*/
    }
    
    
    @IsTest
    static void tallyFrenchCountersSamediTest() {
    	CalculPrimes.dateDuJour = Date.valueOf('2017-11-18');  // Samedi
    	Group queue = [SELECT Id, DeveloperName FROM Group WHERE type='Queue' AND DeveloperName = 'FR_AutresProduitsUnAutreSujet'];
    	
    	createCase(queue.id, Date.valueOf('2017-11-17'));
    	
    	CalculPrimes.tallyFrenchCounters();
    	
    	List<Compteur_Prime__c> compteurs = [SELECT id FROM Compteur_Prime__c];
    	
    	System.assertEquals(0, compteurs.size());
    	
    }
    
    
    @IsTest
    static void tallyBelgianCountersTest() {
    	CalculPrimes.dateDuJour = Date.valueOf('2017-11-20');  // Lundi
    	Group queue = [SELECT Id, DeveloperName FROM Group WHERE type='Queue' AND DeveloperName = 'BE_Klantendienst'];
    	Group queue2 = [SELECT Id, DeveloperName FROM Group WHERE type='Queue' AND DeveloperName = 'FR_Demande_qualifier'];
    	
    	createCase(queue.id, Date.valueOf('2017-11-18'));
		createCase(queue2.id, Date.valueOf('2017-11-17'));
		createCase(queue2.id, Date.valueOf('2017-11-16'));    	
    	
    	CalculPrimes.tallyBelgianCounters();
    	
    	List<Compteur_Prime__c> compteurs = [SELECT id, Queue_Name__c, Date_du_jour__c, Date_Demande__c, Delai__c
    		FROM Compteur_Prime__c ORDER BY Queue_Name__c];
    	
    	/*System.assertEquals(2, compteurs.size());
    	Compteur_Prime__c cpt = compteurs.get(0);
    	System.assertEquals('BE_Klantendienst', cpt.Queue_Name__c);
    	System.assertEquals(Date.valueOf('2017-11-20'), cpt.Date_du_jour__c);
    	System.assertEquals(Date.valueOf('2017-11-18'), cpt.Date_Demande__c);
    	System.assertEquals(0, cpt.Delai__c);
    	
    	cpt = compteurs.get(1);
    	System.assertEquals('FR_Demande_qualifier', cpt.Queue_Name__c);
    	System.assertEquals(Date.valueOf('2017-11-20'), cpt.Date_du_jour__c);
    	System.assertEquals(Date.valueOf('2017-11-16'), cpt.Date_Demande__c);
    	System.assertEquals(2, cpt.Delai__c);*/
    	
    }
    
    @IsTest
    static void tallyBelgianCountersSamediTest() {
    	CalculPrimes.dateDuJour = Date.valueOf('2017-11-18');  // Samedi
    	Group queue = [SELECT Id, DeveloperName FROM Group WHERE type='Queue' AND DeveloperName = 'BE_Klantendienst'];
    	
    	createCase(queue.id, Date.valueOf('2017-11-17'));
    	
    	CalculPrimes.tallyBelgianCounters();
    	
    	List<Compteur_Prime__c> compteurs = [SELECT id FROM Compteur_Prime__c];
    	
    	System.assertEquals(0, compteurs.size());
    	
    }
    
    private static Case createCase(Id ownerId, Date dateCreation) {
    	if(accountNoCarte == null) {
    		init();
    	}
    	Case cse = new Case(); 
    	cse.OwnerId = ownerId;
    	cse.accountId = accountNoCarte.id;
    	cse.status = 'ATraiter';
    	insert cse;
    	Test.setCreatedDate(cse.id, dateCreation);
    	return cse;
    }
}