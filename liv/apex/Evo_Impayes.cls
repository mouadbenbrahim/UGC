

Select Id from Zuora__InvoiceItem__c



Select Zuora__Zuora_Id__c, Name, Zuora__InvoiceDate__c, Zuora__Balance2__c, Zuora__TotalAmount__c,
Tech_CompteurRejet__c,Tech_CodeRejet__c,Tech_DateRejet__c
FROM Zuora__ZInvoice__c 
WHERE Zuora__Balance2__c > 0 AND Tech_CompteurRejet__c != null AND Zuora__BillingAccount__r.Zuora__Zuora_Id__c = '8adcba9c6b26c21f016b2bb6c3f77286' 
order by Name



String accountId = '8adcba9c6b26c21f016b2bb6c3f77286';
String subZID = 'ZIDxxxx';
WSZ.ImpayeOut imp = SM_Impaye.getImpaye(accountId,subZID);       
System.debug('impaye: ' + JSON.Serialize(imp));


String accountId = '8adce4216d70ca8a016d8132476a1e02';
String subZID = '8adcd9eb6db4a6b2016db5fdf7470219';
Double montantPaye = 109.5;
SM_Impaye.reglerImpaye(accountID, subZID, montantPaye, 'CBI'); //accountID, subZID, montantPaye, methodePaiement


// Decimal dc1 = (20.76 * 1.055 * 100 );
Decimal dc1 = (34.88 * 100 * (1 + (5.5 / 100) ) ); // 2190.18; 34.88
// Decimal dc1 = (34.88 * 1.055 ); // 2190.18; 34.88
//dc1 = dc1.round(System.RoundingMode.UP);
dc1 = dc1.round();
dc1 = (dc1 / 100);
//System.RoundingMode();
System.debug('MBEN: '+ dc1 );


Date d1 = Date.today();
System.debug(d1);

Datetime t1 = Datetime.now();
System.debug(t1);

public class test {
        Date d1;
        Datetime t1;
}

test c1 = new test();
c1.d1 = Date.today();
c1.t1 = Datetime.now();
System.debug('MBEN: ' + JSON.serialize(c1,false));
Datetime t2 = Datetime.now();
System.debug('MBEN t2: '+ t2);
System.debug('MBEN: object result: ' + JSON.deserializeStrict(JSON.serialize(c1,false),test.class)); //Object mais contient les null

// String body = '{"t1":"2019-10-16T14:53:22.645Z","d1":"2019-10-16"}';
String body = '{"t1":"2019-10-16 14:55:37","d1":"2019-10-16"}';
System.debug('MBEN: object result: ' + JSON.deserializeStrict(body,test.class));




        select Zuora__External_Id__c, Name, Zuora__InvoiceDate__c, Zuora__Balance2__c, Tech_CompteurRejet__c,Tech_CodeRejet__c,Tech_DateRejet__c
        From Zuora__ZInvoice__c WHERE Zuora__Balance2__c > 0 and  Name = 'FINV00001398'  AND Zuora__BillingAccount__r.Zuora__Zuora_Id__c = '8adcba9c6b26c21f016b2bb6c3f77286'

        Zuora__Balance2__c > 0
        
        AND Zuora__BillingAccount__r.Zuora__Zuora_Id__c = '8adcba9c6b26c21f016b2bb6c3f77286'


        SELECT Id, CodePays__c, CliStatutRCU__c, PersonEmail
                                        FROM Account
                                        WHERE 
                                        CodePays__c = '033'
                                        AND PersonEmail = 'test_1559806092119@ugc.fr'