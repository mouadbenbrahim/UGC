@IsTest()
public class majTest {

      static testmethod void majTest() {
     	Case c = new Case(origin='Facebook', NbFacebook__c=null);
    	insert c;
        Task t3 = new Task(WhatId = c.id,Origine__c = 'Facebook');
        insert t3; 
         Test.startTest();
         maj batch = new maj();
         Database.executeBatch(batch);
         Test.stopTest();
    
    }
    
}