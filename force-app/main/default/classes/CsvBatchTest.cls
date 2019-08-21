@IsTest()
public class CsvBatchTest {

    static testmethod void csvTest() {
     
    Account a = new Account(LastName = 'Test Account');
    insert a;
   	Case c = new Case(origin='Téléphone',AccountId = a.id, NbAppelsEntrants__c = 0, NbAppelsSortants__c = 0, NbFormulaireContact__c =0 );
    insert c;
   	Case c1 = new Case(origin='Formulaire de contact',AccountId = a.id, NbAppelsEntrants__c = 0, NbAppelsSortants__c = 0, NbFormulaireContact__c =0 );
    insert c1;
    Task t = new Task(WhatId = c.id,Origine__c = 'Appel entrant');
    Task t1 = new Task(WhatId = c.id,Origine__c = 'Appel sortant');
    Task t2 = new Task(WhatId = c1.id,Origine__c = 'Formulaire de contact');
    Task t3 = new Task(WhatId = c1.id,Origine__c = 'Facebook');
    Task t4 = new Task(WhatId = c1.id,Origine__c = 'Twitter');
	insert t;
    insert t1;  
   	insert t2;
    insert t3;  
   	insert t4;  
         Test.startTest();
         CsvBatch batch = new CsvBatch();
         Database.executeBatch(batch);
         Test.stopTest();
    
    }
    
    
}