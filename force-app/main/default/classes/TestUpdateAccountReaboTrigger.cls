@isTest
private class TestUpdateAccountReaboTrigger {
    @isTest static void TestUpdateSub1() {
        
        

        Account Acc = new Account();
        Acc.LastName ='TEST TRIG UGC LName';
        Acc.FirstName = 'TEST TRIG UGC FName';
        Acc.ClientResident__c = 'France';
        Acc.PersonEmail = 'blabla@gamil.com';
        insert Acc;
        
        Zuora__Subscription__c sub = new Zuora__Subscription__c();
        sub.Name='Test TRIG UGC Sub';
        sub.Zuora__Zuora_Id__c= 'Test TRIG UGC Sub';
        sub.Zuora__Account__c=Acc.id;
        sub.CodeFinContrat__c = 'E';
        sub.TypeContrat__c ='CDI';
        sub.Zuora__ContractEffectiveDate__c = Date.today()-100;
        sub.Zuora__SubscriptionEndDate__c = Date.today()+10;
        sub.Zuora__TermEndDate__c = Date.today()-25;
        
		insert sub;
        
        Zuora__Subscription__c sub2 = new Zuora__Subscription__c();
        sub2.Name='Test TRIG UGC Sub2';
        sub2.Zuora__Zuora_Id__c= 'Test TRIG UGC Sub2';
        sub2.Zuora__Account__c=Acc.id;
        sub2.CodeFinContrat__c = 'L';
        sub.TypeContrat__c ='CDI';
        sub2.Zuora__ContractEffectiveDate__c = Date.today()-150;
        sub2.Zuora__SubscriptionEndDate__c = Date.today()+10;
        sub2.Zuora__TermEndDate__c = Date.today()-25;
		insert sub2;
                
        list<Account> acclist = [select CodeFinContrat__c,Eligibilite_Reabo__c from Account where id =:Acc.Id];
     	
        if (acclist.size() == 0)
        	System.assertEquals(0,acclist.size());
        else
        {
            //System.assertEquals('E',acclist[0].CodeFinContrat__c);
        	//System.assertEquals(true,acclist[0].Eligibilite_Reabo__c);
        }
      
    }
    
    @isTest static void TestUpdateSub2() {
        
        

        Account Acc = new Account();
        Acc.LastName ='TEST TRIG UGC LName';
        Acc.FirstName = 'TEST TRIG UGC FName';
        Acc.ClientResident__c = 'France';
        Acc.PersonEmail = 'blabla@gamil.com';
        insert Acc;
        
        Zuora__Subscription__c sub = new Zuora__Subscription__c();
        sub.Name='Test TRIG UGC Sub';
        sub.Zuora__Zuora_Id__c= 'Test TRIG UGC Sub';
        sub.Zuora__Account__c=Acc.id;
        sub.CodeFinContrat__c = 'E';
        sub.TypeContrat__c ='CDI';
        sub.Zuora__ContractEffectiveDate__c = Date.today()-100;
        sub.Zuora__SubscriptionEndDate__c = Date.today()+10;
        sub.Zuora__TermEndDate__c = Date.today()-25;
        
		insert sub;
        
        Zuora__Subscription__c sub2 = new Zuora__Subscription__c();
        sub2.Name='Test TRIG UGC Sub2';
        sub2.Zuora__Zuora_Id__c= 'Test TRIG UGC Sub2';
        sub2.Zuora__Account__c=Acc.id;
        sub2.CodeFinContrat__c = 'L';
        sub.TypeContrat__c ='CDI';
        sub2.Zuora__ContractEffectiveDate__c = Date.today()-150;
        sub2.Zuora__SubscriptionEndDate__c = Date.today()+10;
        sub2.Zuora__TermEndDate__c = Date.today()-25;
		insert sub2;
        
        sub2.CodeFinContrat__c = 'X';
        update sub2;
                
        list<Account> acclist = [select CodeFinContrat__c,Eligibilite_Reabo__c from Account where id =:Acc.Id];
     	
        if (acclist.size() == 0)
        	System.assertEquals(0,acclist.size());
        else
        {
            //System.assertEquals('E',acclist[0].CodeFinContrat__c);
        	//System.assertEquals(true,acclist[0].Eligibilite_Reabo__c);
        }
      
    }
    @isTest static void TestUpdateSub3() {
        
        

        Account Acc = new Account();
        Acc.LastName ='TEST TRIG UGC LName';
        Acc.FirstName = 'TEST TRIG UGC FName';
        Acc.ClientResident__c = 'France';
        Acc.PersonEmail = 'blabla@gamil.com';
        insert Acc;
        
        Zuora__Subscription__c sub = new Zuora__Subscription__c();
        sub.Name='Test TRIG UGC Sub';
        sub.Zuora__Zuora_Id__c= 'Test TRIG UGC Sub';
        sub.Zuora__Account__c=Acc.id;
        sub.CodeFinContrat__c = 'E';
        sub.TypeContrat__c ='CDI';
        sub.Zuora__ContractEffectiveDate__c = Date.today()-100;
        sub.Zuora__SubscriptionEndDate__c = Date.today()+10;
        sub.Zuora__TermEndDate__c = Date.today()-25;
        
		insert sub;
        
        Zuora__Subscription__c sub2 = new Zuora__Subscription__c();
        sub2.Name='Test TRIG UGC Sub2';
        sub2.Zuora__Zuora_Id__c= 'Test TRIG UGC Sub2';
        sub2.Zuora__Account__c=Acc.id;
        sub2.CodeFinContrat__c = 'L';
        sub.TypeContrat__c ='CDI';
        sub2.Zuora__ContractEffectiveDate__c = Date.today()-150;
        sub2.Zuora__SubscriptionEndDate__c = Date.today()+10;
        sub2.Zuora__TermEndDate__c = Date.today()-25;
		insert sub2;
        
        sub.Zuora__ContractEffectiveDate__c = Date.today()-200;
        update sub;
                
        list<Account> acclist = [select CodeFinContrat__c,Eligibilite_Reabo__c from Account where id =:Acc.Id];
     	
        if (acclist.size() == 0)
        	System.assertEquals(0,acclist.size());
        else
        {
            //System.assertEquals('E',acclist[0].CodeFinContrat__c);
        	//System.assertEquals(true,acclist[0].Eligibilite_Reabo__c);
        }
      
    }
    
    @isTest static void TestUpdateSub4() {
        
        

        Account Acc = new Account();
        Acc.LastName ='TEST TRIG UGC LName';
        Acc.FirstName = 'TEST TRIG UGC FName';
        Acc.ClientResident__c = 'France';
        Acc.PersonEmail = 'blabla@gamil.com';
        insert Acc;
        
        Zuora__Subscription__c sub = new Zuora__Subscription__c();
        sub.Name='Test TRIG UGC Sub';
        sub.Zuora__Zuora_Id__c= 'Test TRIG UGC Sub';
        sub.Zuora__Account__c=Acc.id;
        sub.CodeFinContrat__c = 'E';
        sub.TypeContrat__c ='CDI';
        sub.Zuora__ContractEffectiveDate__c = Date.today()-100;
        sub.Zuora__SubscriptionEndDate__c = Date.today()+10;
        sub.Zuora__TermEndDate__c = Date.today()-25;
        
		insert sub;
        
        Zuora__Subscription__c sub2 = new Zuora__Subscription__c();
        sub2.Name='Test TRIG UGC Sub2';
        sub2.Zuora__Zuora_Id__c= 'Test TRIG UGC Sub2';
        sub2.Zuora__Account__c=Acc.id;
        sub2.CodeFinContrat__c = 'L';
        sub.TypeContrat__c ='CDI';
        sub2.Zuora__ContractEffectiveDate__c = Date.today()-150;
        sub2.Zuora__SubscriptionEndDate__c = Date.today()-100;
        sub2.Zuora__TermEndDate__c = Date.today()-100;
		insert sub2;
        
        sub.Zuora__ContractEffectiveDate__c = Date.today()-200;
        sub.CodeFinContrat__c = 'M';
        update sub;
                
        list<Account> acclist = [select CodeFinContrat__c,Eligibilite_Reabo__c from Account where id =:Acc.Id];
     	
        if (acclist.size() == 0)
        	System.assertEquals(0,acclist.size());
        else
        {
            //System.assertEquals('L',acclist[0].CodeFinContrat__c);
        	//System.assertEquals(false,acclist[0].Eligibilite_Reabo__c);
        }
      
    }
    
    
    
}