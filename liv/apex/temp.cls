WSZ.UnapplyPaymentIn cp = new WSZ.UnapplyPaymentIn();

String cpStr = JSON.serialize(cp,true);

System.debug(cpStr);


ID batchprocessid = Database.executeBatch(new Batch_SubscriptionTarifUpdate('033', 5, '8adc85786d82e27c016d849f0d5b48ef'),50); // a terme scope = 50


select Id, Partition__c, TarifFacture__c from Zuora__Subscription__c where Zuora__Zuora_Id__c='8adc9a416dd847b0016dde7e2d887c4c'
