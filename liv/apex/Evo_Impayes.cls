

Select Id from Zuora__InvoiceItem__c



Select Zuora__Zuora_Id__c, Name, Zuora__InvoiceDate__c, Zuora__Balance2__c, Zuora__TotalAmount__c,
Tech_CompteurRejet__c,Tech_CodeRejet__c,Tech_DateRejet__c
FROM Zuora__ZInvoice__c 
WHERE Zuora__Balance2__c > 0 AND Tech_CompteurRejet__c != null AND Zuora__BillingAccount__r.Zuora__Zuora_Id__c = '8adcba9c6b26c21f016b2bb6c3f77286' 
order by Name



String accountId = '8adce4216d70ca8a016d8132476a1e02'; //02
String subZID = '8adc8f996df77509016df7fee48543df';
WSZ.ImpayeOut imp = SM_Impaye.getImpaye(accountId,subZID);       
System.debug('impaye: ' + JSON.Serialize(imp));

WSZ.ImpayeOut imp = SM_Impaye.getImpaye('8adce4216d70ca8a016d8132476a1e02','8adcba9c6e017438016e03ae88d26a90');       
System.debug('impaye: ' + JSON.Serialize(imp));

WSZ.ImpayeReglerIn wsIn = new WSZ.ImpayeReglerIn('8adce4216d70ca8a016d8132476a1e02','8adcd9eb6e0184a1016e03c3580c2d33',(Double)151.4,'VIR','WEB','agent007','p_ref_cb0122','2019-10-24');
System.debug(JSON.serialize(wsIn));
WSZ.ImpayeReglerOut wsOut = SM_Impaye.reglerImpaye(wsIn);
System.debug(JSON.serialize(wsOut));


// Generate Account Billing Document
String accessToken = WS001_CallZuora.access_token;
String zEntityId = WS001_CallZuora.getZuoraEntityId('033');
zc_PostGenerateBillingDocumentType billReq = new zc_PostGenerateBillingDocumentType();
billReq.autoPost =true;
billReq.autoRenew = true;
billReq.effectiveDate = Date.Today();
billReq.subscriptionIds.add('8adc8f996df77509016df801cc4c4499');
billReq.targetDate =  Date.Today().addMonths(1);
zc_GenerateBillingDocumentResponseT billResp = zc_Api.accBillDocGeneratePOST(accessToken, zEntityId, billReq, '8adce4216d70ca8a016d8132476a1e02', RTExceptionCode.ERREUR_IMPAYE_REGLER_UPDATE_ACCOUNT);
System.debug(JSON.serialize(billResp));


// update Account
String accessToken = WS001_CallZuora.access_token;
String zEntityId = WS001_CallZuora.getZuoraEntityId('033');
zc_ProxyActionupdateRequest objUpdateReq = new zc_ProxyActionupdateRequest();
objUpdateReq.r_type = 'Account';
zc_ZObjectUpdate zObj = new zc_ZObjectUpdate();
zObj.id = '8adcba9c6b26c21f016b2bb6c3f77286';
zObj.batch = 'Batch3';
objUpdateReq.objects.add(zObj);
System.debug(JSON.serialize(objUpdateReq,true));
zc_Api.actionUpdatePOST(accessToken, zEntityId, objUpdateReq, RTExceptionCode.ERREUR_IMPAYE_REGLER_UPDATE_ACCOUNT);

//Create payment
String accessToken = WS001_CallZuora.access_token;
String zEntityId = WS001_CallZuora.getZuoraEntityId('033');
zc_CreatePaymentType payment = new zc_CreatePaymentType();
payment.accountId = '8adcc59c6d2c95a1016d3a46ea231888'; //86
payment.amount = 60.95;
payment.currency2 = 'EUR';
payment.r_type = zc_CreatePaymentType.RTypeEnum.External;
payment.paymentMethodId = '8adc8f9963ecb5c20163f45800616291';
payment.effectiveDate = Date.today();
payment.referenceId = 'refe';
payment.methodePaiement = 'CBI';
payment.lieu = 'WEB';
payment.agent = 'Agent';
zc_PaymentInvoiceApplicationCreateR invoice1 = new zc_PaymentInvoiceApplicationCreateR(); // Invoice Amend : FG + DNE
invoice1.amount = 40.95; //TODO champ obligatoire, soit on requette invoice dans zuora, ou bien on utitilise les donnes deja calcules
invoice1.invoiceId = '8adcd9eb6d424e53016d43930b7d12f5'; //f5
payment.invoices.add(invoice1);
zc_Api.paymentsPOST(accessToken, zEntityId, payment, RTExceptionCode.ERREUR_IMPAYE_REGLER_APPLICATION_PAYMENT);


//Billing Preview
String accessToken = WS001_CallZuora.access_token;
String zEntityId = WS001_CallZuora.getZuoraEntityId('033');
zc_PostBillingPreviewParam previewReq = new zc_PostBillingPreviewParam();
previewReq.accountId = '8adce4216d70ca8a016d8132476a1e0z'; //02
previewReq.assumeRenewal = 'All';
//prev.chargeTypeToExclude = '';
previewReq.includingEvergreenSubscription = true;
previewReq.targetDate = Date.today().addMonths(1);
zc_Api.opeBillingPreviewPOST(accessToken, zEntityId, previewReq, RTExceptionCode.ERREUR_IMPAYE_REGLER_PROBLEM_PREVIEW);


Date targetDate; // = null;
Zuora__Subscription__c sub = SM_Subscription.getSubscriptionByZID('8adcd9eb6df787ec016df8c4f05d4d8c');
System.debug(sub);
        if (sub == null ) {
            throw new RTException(RTExceptionCode.ERREUR_IMPAYE_REGLER_SOUSCRITPION_NON_TROUVE);
        }
if (sub.DateFinContrat__c != null && sub.Zuora__CancelledDate__c != null && sub.Zuora__CancelledDate__c != sub.DateFinContrat__c.addDays(1)) {
        throw new RTException(RTExceptionCode.ERREUR_IMPAYE_REGLER_INCOHERENCE_DATEFIN);
}
if (!String.isEmpty(sub.Tech_DetteTargetDate__c)){
        targetDate = Date.valueOf(sub.Tech_DetteTargetDate__c);
}
System.debug('MBEN targetDate:' + targetDate);





Double montant1 = 38.48;
Double montant2 = 262.80;
Double montant3 = 20;

System.debug(montant1);
System.debug(montant2);
System.debug(montant3);

//Decimal montant = 0.00;
Double montant = (Decimal)montant1+(Decimal)montant2+(Decimal)montant3;

System.debug(montant);


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


SELECT Id, Name, Intitule__c, HermesIntituleOffre__c, HermesIntituleOffreNL__c, RecordType.Name, Reference__c
                FROM Offre__c
                WHERE RecordType.Name = 'Offre commerciale'
                AND DateDebut__c <= 2019-10-28 AND DateFin__c >= 2019-10-28
                AND Promo__c IN (SELECT Promo__c FROM PromoProduit__c WHERE Produit__r.Reference__c = 'UI1CDI')
                AND Id IN (SELECT Offre__c FROM OffreLieu__c WHERE CodeComplexe2__c = 'WEB')
                AND Operation__c includes ('Acquisition')

SELECT ContrainteSur__c FROM OffreContrainte__c WHERE Offre__c = 'a1D0E0000022FbLUAU'

SELECT Complexe__c FROM OffreLieu__c WHERE Offre__c = 'a1D0E0000022FbLUAU'

SELECT Id FROM OffreContrainte__c WHERE ContrainteSur__c = 'a1D0E0000022FbLUAU'

SM_Offre.refreshContraintes2('a1D0E0000022FbLUAU');

SELECT Id, Name, Zuora__Zuora_Id__c, Zuora__Account__r.Id, Zuora__Account__r.Name,
                        Zuora__SubscriptionNumber__c,Zuora__Status__c,
                        Zuora__CancelledDate__c,Zuora__TermEndDate__c,Zuora__SubscriptionEndDate__c,
                        Zuora__TermStartDate__c,Zuora__SubscriptionStartDate__c,Zuora__ContractEffectiveDate__c,Zuora__NextChargeDate__c,
                        TypeContrat__c, CodeFinContrat__c, Zuora__NextRenewalDate__c,
                        Zuora__CustomerAccount__r.Zuora__Zuora_Id__c, Zuora__PreviousSubscriptionId__c, Tech_AvecRembouesement__c,
                        Zuora__CustomerAccount__r.Zuora__Balance__c, 
                        Zuora__External_Id__c, Zuora__Account__r.CodePays__c, Zuora__CurrentTermPeriodType__c, Zuora__CurrentTerm__c, DateFinContrat__c,
                        Zuora__TermSettingType__c, Tech_DetteFraisGestion__c, Tech_DetteNonEchue__c, Tech_DetteTargetDate__c, Marche__c,Zuora__Account__r.PersonContactId 
                FROM Zuora__Subscription__c
                WHERE Id = 'a0y0E000002gAzGQAU'


Select PersonContactId from Account where Id='0010E00000Y1vmPQAR'


Id caseId = SM_Impaye.createImpayeCase('0010E00000Y1vmPQAR', '0030E00000VrafgQAB', '033', (Double)55.3);
System.debug('MBEN ID: ' + caseId);

String offreAboTier = Utils.getUgcGenericParam('Abo Tier Offre Name','033').ParamValue__c;
Integer validiteCoupon_AT = Integer.valueOf(Utils.getUgcGenericParam('Abo Tier Coupon Validite',acc.CodePays__c).ParamValue__c);
Id parentCouponID_AT = [Select Coupon__c from Offre__c where Name = :offreAboTier Limit 1].Coupon__c;
String coupon_AT = SM_Coupon.generateCouponItem(parentCouponID_AT,null,dateCancelContrat,dateCancelContrat.addMonths(validiteCoupon_AT));

