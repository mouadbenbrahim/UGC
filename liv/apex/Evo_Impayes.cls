

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

try{
WSZ.ImpayeOut imp = SM_Impaye.getImpaye('8adce4216d70ca8a016d8132476a1e02','8adcba9c6e017438016e03ae88d26a90');
}
catch(Exception e){

}



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
ProcessLog__c pLog = null;
String accessToken = WS001_CallZuora.access_token;
String zEntityId = WS001_CallZuora.getZuoraEntityId('033');
zc_PostBillingPreviewParam previewReq = new zc_PostBillingPreviewParam();
previewReq.accountId = '8adc9a416dd847b0016dda63faca2f3c'; //02
previewReq.assumeRenewal = 'All';
//prev.chargeTypeToExclude = '';
previewReq.includingEvergreenSubscription = true;
previewReq.targetDate =  date.newInstance(2020,11,01).addDays(-1);
zc_BillingPreviewResult previewRes = zc_Api.opeBillingPreviewPOST(accessToken, zEntityId, previewReq, RTExceptionCode.ERREUR_IMPAYE_REGLER_PROBLEM_PREVIEW, pLog);

Decimal tvaZuora = Decimal.valueOf(Utils.getUgcGenericParam('TVA Zuora','033').ParamValue__c); 
Decimal montantPreview = 0;
for (zc_POSTBillingPreviewInvoiceItem invoice : previewRes.invoiceItems){
Decimal chargeAmountTTC = (Decimal.valueOf(invoice.chargeAmount) * 100 * (1+(tvaZuora/100)));
chargeAmountTTC = chargeAmountTTC.round();
chargeAmountTTC = (chargeAmountTTC / 100);
montantPreview = (Decimal)montantPreview + chargeAmountTTC;
}


// update sub (via object/subscriptionPUT)
try{
String accessToken = WS001_CallZuora.access_token;
String zEntityId = WS001_CallZuora.getZuoraEntityId('033');
zc_ProxyModifySubscription reqObj = new zc_ProxyModifySubscription();
String zSubZID = '8adc9a416e16dc1c016e1c70821733ed';
ProcessLog__c pLog = new ProcessLog__c(Process__c='objectSubscriptionPUT', Message__c='objectSubscriptionPUT');
reqObj.codeFinContrat = 'L';
reqObj.dateFinContrat = date.newInstance(2020,11,01);
reqObj.tech_AvecRembouesement = 'true';
reqObj.cancelCaseID = '5000E000009hSL0QAM';
zc_SaveResult zSubUpdateResult = zc_Api.objectSubscriptionPUT(accessToken, zEntityId, zSubZID, reqObj, RTExceptionCode.ERREUR_DESABO_APPLICATION_UPDATESUB, pLog);
System.debug('MBEN objectSubscriptionPUT: done' ); 
}
catch(Exception e){
        System.debug('MBEN: exception');
}


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
                AND DateDebut__c <= 2019-10-29 AND DateFin__c >= 2019-10-29
                AND Promo__c IN (SELECT Promo__c FROM PromoProduit__c WHERE Produit__r.Reference__c = 'UI1CDD')
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

ProcessLog__c pLog = new ProcessLog__c(Process__c = 'getImpaye', AccountZID__c = '123', SubscriptionZID__c = '526');
insert pLog;

ProcessLog__c pLog2 = new ProcessLog__c(Process__c = 'getImpaye', AccountZID__c = '123', SubscriptionZID__c = '526');
insert pLog2;  

String toto = '1';
if (toto != null && Integer.valueOf(toto) > 0 ){
        System.debug('MBEN: OK pas null');
}else {
        System.debug('MBEN: OK null');
}


// Attachment att = [Select Id from Attachment where What.Type IN ('Case') and ParentId ='5005E000005sYUoQAM']

List<Carte__c> att = [Select Id from Carte__c]

// Select TYPEOF Parent WHEN Case THEN Subscription__c, Date_de_creation__c, CreditMemoId__c END

Select TYPEOF Parent WHEN Case THEN Account.Name END
from Attachment 
where Id='00P0E0000037rffUAA' and Parent.Type='Case'

select Id,Parent.Type from Attachment
Select Id, (select Id, Body from Attachments) from Case limit 1


try {
ProcessLog__c pLog = new ProcessLog__c(Message__c='test');
String accessToken = WS001_CallZuora.access_token;
String zEntityId = WS001_CallZuora.getZuoraEntityId('033');
List<String> detteEchueIds = new List<String>{'x8adce4216e5e529f016e60a7396e0ede','x8adc9a416d82e2de016d8ba109d657c4'};
zc_ProxyActionupdateRequest objUpdateReq  = new zc_ProxyActionupdateRequest();
zc_ZObjectUpdate zObj;  
if (detteEchueIds.size() > 0) {
            //List<Zuora__ZInvoice__c> invoices2 = SM_Invoice.getInvoiceByIds(detteEchueIds);                        
            objUpdateReq = new zc_ProxyActionupdateRequest();
            objUpdateReq.r_type = 'Invoice';                 
            for (Zuora__ZInvoice__c inv2 : SM_Invoice.getInvoiceByIds(detteEchueIds) ){
                if (inv2.Tech_CompteurRejet__c != null && Integer.valueOf(inv2.Tech_CompteurRejet__c) > 5 ){  // pour isoler juste les factures 
                    zObj = new zc_ZObjectUpdate();
                    zObj.id = inv2.Zuora__External_Id__c;
                    zObj.tech_FlagRejetPaye = 'true';
                    objUpdateReq.objects.add(zObj);
                }
            }

            System.debug(JSON.serialize(objUpdateReq,true));

            zc_Api.actionUpdatePOST(accessToken, zEntityId, objUpdateReq, RTExceptionCode.ERREUR_IMPAYE_REGLER_UPDATE_INVOICE,pLog);
}
}
catch(Exception e){
        System.debug('MBEN:ERREUR');
}
//objUpdateReq = new zc_ProxyActionupdateRequest();
//objUpdateReq.r_type = 'Invoice';      




     List<Case> cs = [SELECT Id,AccountId,TECHIdStatut__c FROM Case WHERE Id='5005E000005t82pQAA'];
     SM_SDoc.makeSdocJobs(cs);


SELECT Id, name, FamilleMatrice__c, MotifMatrice__c, SousMotifMatrice__c, 
                                         Reponse__c, 
                                         NomModeleCourrierEmail__c, NomModeleEmailHTML__c,
                                         Nom_du_mod_le_courrier_UU_fran_ais_pdf__c, Nom_du_mod_le_email_UU_fran_ais_HTML__c,
                                         Nom_du_mod_le_courrier_UU_n_erlandais__c, Nom_du_mod_le_email_UU_n_erlandais__c, AvecCarte__c
                                         FROM Contacts__c
                                         WHERE Name IN ('007AH')


zc_ProxyActionupdateRequest reqObj = new zc_ProxyActionupdateRequest();
zc_ZObjectUpdate zObj = new zc_ZObjectUpdate();
reqObj.r_type = 'Subscription';
zObj.fieldsToNull = new List<String>{'DateFinContrat__c','CodeFinContrat__c','CancelCaseID__c'};
zObj.id = '111';
reqObj.objects.add(zObj);
zObj.id = '222';
System.debug('MBEN' + String.valueOf(reqObj));

// --- OFFRE

        String offId = 'a1D0E0000022GnwUAE';
       Offre__c offre = [SELECT Id, DateDebut__c, DateFin__c, RecordType.Name, Promo__c FROM Offre__c WHERE Id = :offId];
        // Map<Id, String> lieus = new Map<Id, Id>([SELECT Complexe__c, Complexe__r.CodeComplexe__c FROM OffreLieu__c
        //WHERE Offre__c = :offId]);
        Set<Id> lieuSet = new Set<Id>();
        Set<Id> pdtSet = new Set<Id>();

        for (OffreLieu__c offreLieu : [SELECT Complexe__c FROM OffreLieu__c WHERE Offre__c = :offId]) {
            lieuSet.add(offreLieu.Complexe__c);
        }

        for (PromoProduit__c promoProduit : [SELECT Produit__c FROM PromoProduit__c where Promo__c = :offre.Promo__c]) {
            pdtSet.add(promoProduit.Produit__c);
        }

        if (offre.RecordType.Name == 'Offre commerciale' || offre.RecordType.Name == 'Offre coupon') {
            List<Offre__c> tgtOffres = [
                    SELECT Id, DateDebut__c, DateFin__c, Promo__c
                    FROM Offre__c
                    WHERE Id != :offId
                    AND (RecordType.Name = 'Offre commerciale' OR RecordType.Name = 'Offre coupon')
            ];

            List<OffreContrainte__c> contraintes = new List<OffreContrainte__c>();
            List<OffreContrainte__c> tgtContraintes = new List<OffreContrainte__c>();
            System.debug('MBEN lieuSet: ' + lieuSet);
            System.debug('MBEN pdtSet: ' + pdtSet);

            for (Offre__c tgtOffre : tgtOffres) {

                Date maxDateDebut = Util.maxDate(tgtOffre.DateDebut__c, offre.DateDebut__c);
                Date minDateFin = Util.minDate(tgtOffre.DateFin__c, offre.DateFin__c);
                Set<Id> lieuTgtSet = new Set<Id>();
                Set<Id> pdtTgtSet = new Set<Id>();
                Set<Id> lieuSet2 = lieuSet.clone();
                Set<Id> pdtSet2 = pdtSet.clone();
                System.debug('MBEN tgt1: ' + tgtOffre.Id);

                //verifier s'ils offre et tgtOffre n ont pas des dates de chevauchement
                if (maxDateDebut <= minDateFin) {
                    System.debug('MBEN tgt2: ' + tgtOffre.Id);

                    for (OffreLieu__c offreLieu : [SELECT Complexe__c FROM OffreLieu__c WHERE Offre__c = :tgtOffre.Id]) {
                        lieuTgtSet.add(offreLieu.Complexe__c);
                    }
                    System.debug('MBEN lieuTgtSet: ' + lieuTgtSet);
                    lieuSet2.retainAll(lieuTgtSet);
                    System.debug('MBEN lieuSet2: ' + lieuSet2);

                    for (PromoProduit__c promoProduit : [SELECT Produit__c FROM PromoProduit__c where Promo__c = :tgtOffre.Promo__c]) {
                        pdtTgtSet.add(promoProduit.Produit__c);
                    }
                    System.debug('MBEN pdtTgtSet: ' + pdtTgtSet);
                    pdtSet2.retainAll(pdtTgtSet);
                    System.debug('MBEN pdtSet2: ' + pdtSet2);

                    //verifier s'ils offre et tgtOffre n ont pas des lieux cinema en commun : pas de contraintes
                    if (!lieuSet2.isEmpty() &&  !pdtSet2.isEmpty() ) {
                        System.debug('MBEN tgt3: ' + tgtOffre.Id);
                    OffreContrainte__c co = new OffreContrainte__c();
                    OffreContrainte__c tgtco = new OffreContrainte__c();

                    co.Offre__c = offre.Id;
                    co.ContrainteSur__c = tgtOffre.Id;
                    co.DateDebut__c = maxDateDebut;
                    co.DateFin__c = minDateFin;
                    contraintes.add(co);

                    tgtco.Offre__c = tgtOffre.Id;
                    tgtco.ContrainteSur__c = offre.Id;
                    tgtco.DateDebut__c = maxDateDebut;
                    tgtco.DateFin__c = minDateFin;
                    tgtContraintes.add(tgtco);

                    }
                }
            }
            if (!contraintes.isEmpty()) {
                //insert contraintes;
                System.debug('MBEN insert contrainte: ' + String.valueOf(contraintes));
            }
            if (!tgtContraintes.isEmpty()) {
                //insert tgtContraintes;
                System.debug('MBEN insert contrainte: ' + String.valueOf(tgtContraintes));
            }
        }
        

Map<String,Zuora__Subscription__c> subs = new map<String,Zuora__Subscription__c>([Select Adresse_livraison_1__c, Id from Zuora__Subscription__c limit 5]);
System.debug(String.valueOf(subs));
System.debug(subs.get('a0y0E0000013ODlQAM'));

Account acc = new Account();
Map<String,Object> mp = new Map<String, Object>{'ACC' => acc};