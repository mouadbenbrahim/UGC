

// Desabo E
SM_Desabonnement.desabonner('5000E000009jhjPQAQ',false); // CDD E
SM_Desabonnement.desabonner('5000E000009jjlRQAQ',false);// CDI E
SM_Desabonnement.desabonner('5000E000009jjlqQAA',false);// CDD L
SM_Desabonnement.desabonner('5000E000009jjllQAA',false);// CDI L
SM_Desabonnement.desabonner('5000E000009jn2WQAQ',false);// CDI E
SM_Desabonnement.desabonner('5000E000009jn2WQAQ',true);// CDI E immediat

SM_Desabonnement.desabonner('5000E000009k1bjQAA',false);// CDI E immediat


// Desabo L
SM_Desabonnement.desabonner('5000E000009jjnrQAA',false);// CDI L -- subid: 8adcba9c6d2c8b97016d3a81f21b7d0c


SM005_AnnulationDesabo.AnnulerDesabo('5000E000009jjnrQAA');
SM005_AnnulationDesabo.AnnulerDesabo('5000E000009jkEbQAI');

SM005_AnnulationDesabo.AnnulerDesabo('5000E000009k0y5QAA');




// ----

//Date cancelDate = Date.today().addMonths(1); //.addDays(0);
Date dateFinContrat = date.newInstance(2019,09,30);
ID batchprocessid = Database.executeBatch(new Batch_SubscriptionCancel(dateFinContrat),50); // a terme scope = 50
//List<Case> cases = [Select Id, Subscription__r.DateFinContrat__c From Case where Subscription__r.DateFinContrat__c=:auj and Id='5000E000009jn2WQAQ'];
//List<Case> cases = [Select Id, Subscription__r.DateFinContrat__c From Case where Subscription__r.DateFinContrat__c=:cancelDate and Id='5000E000009jn2WQAQ'];
//List<Case> cases = [Select Id, Subscription__r.DateFinContrat__c From Case where Id=''];
// List<Zuora__Subscription__c> subscriptions = [Select Id, CancelCaseID__c From Zuora__Subscription__c where Zuora__Status__c='Active' and DateFinContrat__c=:dateFinContrat and CancelCaseID__c='5000E000009jn2WQAQ'];
// System.debug(String.valueOf(subscriptions));

Select id,  from case where ExecStatus__c='Erreur'


// ------------



// ------------
Zuora__Subscription__c sub = new Zuora__Subscription__c();
sub.TypeContrat__c ='CDD';
//sub.attributes = null;
// String str4 = Util.serializeSobject(sub);
// System.debug('str4: '+ str4);



// ------------
String jsonStr = JSON.serializePretty(sub,true);
String str2 = String.valueof(sub);
System.Debug(jsonStr);
Map<String,Object> map1 = (Map<String,Object>)JSON.deserializeUntyped(jsonStr);
map1.remove('attributes');
// String str3=String.valueof(map1);
String str3=JSON.serialize(map1);
System.debug('str2: '+str2);
System.debug('str3: '+str3);

WSZ.GenericEmptyFields subEmpty = new WSZ.GenericEmptyFields();
subEmpty.fieldsToNull = new List<String>{'DateFinContrat__c','CodeFinContrat__c'};

System.debug('subEmpty: ' + JSON.serialize(subEmpty));




// tests:
// ------- Desabo E:

// CDD + Futur : Fait
// CDD + Futur + deja programmée: Fait Err2002
//* CDD immediat:

// CDI + Futur: Fait
// CDI + Futur + deja programmée : Fait: Err2001
//* CDI immediat: Fait

// ------- Desabo L: 

// CDD + Futur : Fait: Incompatible
// CDD + Futur + deja programmée: Fait: Incompatible
//* CDD immediat:

// CDI + Futur: Fait
// CDI + Futur + deja programmée : Fait: Err2001
//* CDI immediat: 

// -------- Resiliation
//* CDD
//* CDI

// -------- Retention
//* CDD
//* CDI

// -------- Annulation Desabo

// CDI + Actif + date fin : Fait
// CDI + Actif + sans date fin :  Fait: Err2003
// CDI + Inactif + Latence: Fait
// CDI + Inactif + Latence depasse: Fait: Err2002

// CDD + Actif + date fin :
// CDD + Actif + sans date fin : 
// CDD + Inactif + Latence:
// CDD + Inactif + Latence depasse:



List<String> myStr = new List<String>{'aa','bb','cc'};


    for (String str: myStr){
        try {
            System.debug(str);
            Double d = 1/0; 
            System.debug('suite');               

        }
        catch (Exception e){
            System.debug('Exeption1');
        }
        

        finally {
            System.debug('la finale');
        }

        System.debug('apres finale');

    }




