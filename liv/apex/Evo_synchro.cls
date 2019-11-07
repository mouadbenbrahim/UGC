
String accessToken = WS001_CallZuora.access_token;
String zEntityId = WS001_CallZuora.getZuoraEntityId('033');
zc_GETSubscriptionTypeWithSuccess respObj = zc_Api.subscriptionGET(accessToken, zEntityId, '8adc9a416e16dc1c016e1c70821733ed', RTExceptionCode.ERREUR_IMPAYE_REGLER_UPDATE_ACCOUNT);
System.debug('MBEN: '+JSON.serialize(respObj,true));

// acquisition
WSZ.SubHermesIn hermesIn = new WSZ.SubHermesIn();
hermesIn.accountId = '0010E00000bzVUFQA2';
hermesIn.subscriptionZID = '8adcba9c6df77503016df824b81e5880';
hermesIn.subscriptionName = 'F-S00009596';
hermesIn.accountZID = '8adcfb506df787f2016df8249e560b97';
hermesIn.motif = '07- Création abonnement';
hermesIn.lieu = 'WEB';
hermesIn.origin='Selfcare';
hermesIn.numeroCarte = '17100188300';
WSZ.SubHermesOut acquOut = SM_Hermes.acquisition(hermesIn);

// migration
WSZ.SubHermesIn hermesIn = new WSZ.SubHermesIn();
hermesIn.accountId = '0010E00000bzVUFQA2';
hermesIn.subscriptionZID = '8adcba9c6df77503016df824b81e5880';
hermesIn.subscriptionName = 'F-S00009596';
hermesIn.accountZID = '8adcfb506df787f2016df8249e560b97';
hermesIn.motif = '06- Migration UI 1/2/3';
hermesIn.lieu = 'WEB';
hermesIn.origin='Selfcare';
hermesIn.numeroCarte = '17100188300';
hermesIn.typeDeMigration = 'UI 1 > UI 2';
hermesIn.dateFinContrat = String.valueOf(Date.today());
WSZ.SubHermesOut acquOut = SM_Hermes.migration(hermesIn);



Account acc = SM_Account.getAccount('0010E00000bzVUFQA2');

// get Account
String accessToken = WS001_CallZuora.access_token;
String zEntityId = WS001_CallZuora.getZuoraEntityId('033');
 
//zc_ProxyGetAccount acc = zc_Api.objectAccountGET(accessToken, zEntityId, '8adcc59c6684e41e0166a648e4af6c6d', RTExceptionCode.ERREUR_IMPAYE_REGLER_UPDATE_ACCOUNT);
zc_ProxyGetPaymentMethod pm = zc_Api.objectPaymentMethodGET(accessToken, zEntityId, '8adce4216684e4260166a64ca12d3ae4', RTExceptionCode.ERREUR_IMPAYE_REGLER_UPDATE_ACCOUNT);
System.debug(JSON.serialize(pm,true));





SELECT Id, Name, MauvaisComportement__c, ProduitUGC__c, CodePays__c, PersonContactId 
                FROM Account
                WHERE Id = '0010E00000bzVUFQA2'


Date dateFinContrat = null;
// String subNumber = 'SUF00054036'; desabonnement impossible pour CDD (bilendi)
String subNumber = null;
Batch_SubscriptionCancel batch = new Batch_SubscriptionCancel(dateFinContrat,subNumber);
Database.executeBatch(batch,50);


select Id, EventType, LogDate, LogFileLength from EventLogFile where EventType = 'API' limit 10 //and LogDate = 2019-11-04T00:00:00.000Z