
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
//hermesIn.dateFinContrat = String.valueOf(Date.today());
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


select Id, EventType, LogDate, LogFileLength from EventLogFile where EventType not in ('Login','Logout') //= 'API' limit 10 //and LogDate = 2019-11-04T00:00:00.000Z

Select Lieu__c from Zuora__Subscription__c

Map<String,Zuora__Subscription__c> mp = new Map<String,Zuora__Subscription__c>();
mp.put('AAA',new Zuora__Subscription__c());
mp.put('BBB',new Zuora__Subscription__c());
System.debug(mp.size());
mp.put('AAA',new Zuora__Subscription__c());
System.debug(mp.size());

Set<String> st = new Set<String>();
st.add('AAA');
st.add('BBB');
System.debug(st.size());
st.add('AAAA');
System.debug(st.size());

List<Offre__c> offs = [Select Reference__c from Offre__c];
System.debug(offs.contains(new Offre__c(Reference__c='OFRHIVER2019')));
//System.assertEquals(true,offs.contains(new Offre__c(Reference__c='OFRHIVER2019')));

String str = 'ABO-ITA';
List<String> codeOffreCo = str.split('-');
System.debug(codeOffreCo);
System.debug(codeOffreCo[0]);
System.debug(codeOffreCo.size());
//System.debug(codeOffreCo.get(1));




String offreAboTier = Utils.getUgcGenericParam('Abo Tier Offre Name','032').ParamValue__c;
Integer validiteCoupon_AT = Integer.valueOf(Utils.getUgcGenericParam('Abo Tier Coupon Validite','032').ParamValue__c);
Id parentCouponID_AT = [Select Coupon__c from Offre__c where Name = :offreAboTier Limit 1].Coupon__c;
if (parentCouponID_AT == null) {throw new RTException(RTExceptionCode.ERREUR_DESABO_COUPON_ABOTIER,new ProcessLog__c());}
String coupon_AT = SM_Coupon.generateCouponItem(parentCouponID_AT,null,Date.today(),Date.today().addMonths(validiteCoupon_AT));

System.debug('MBEN:coupon_AT:'+coupon_AT);

Date dt = null;

//If(Date.today() < dt){
    System.debug('MBEN:'+ (Date.today() != dt));
//}


String accessToken = WS001_CallZuora.access_token;
String zEntityId = WS001_CallZuora.getZuoraEntityId('033');
zc_GETInvoiceItemsResponse resp = zc_Api.invoicesItemsGET(accessToken, zEntityId, '8adcfb506c7497ee016c76ac8d8e710b', RTExceptionCode.ERREUR_DESABO_COUPON_ABOTIER, new ProcessLog__c());
System.debug(JSON.serialize(resp));

Boolean hasDetteTech = SM_Impaye.hasDetteTechnique(new List<String>{'8adcfb506c7497ee016c76ac8d8e710b','8adcfb506c7497ee016c76ac8d8e710b'});
System.debug('MBEN:'+hasDetteTech);

Date dd = Date.newInstance(2016, 01, 03).adddays(1490);  // 01/02/2020 --> 
System.debug(dd);


Datetime d1 = System.now()
System.debug('MBEN:'+System.now().getTime());

Boolean enableResponseTime = Boolean.valueOf(Utils.getUgcGenericParam('Enable Response Time Log',null).ParamValue__c);
System.debug('MBEN:'+!enableResponseTime);


select StartTime__c, EndTime__c from ProcessLog__c where Process__c = 'ResponseTime_acquisition'