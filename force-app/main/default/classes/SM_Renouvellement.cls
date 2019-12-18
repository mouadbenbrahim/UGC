public with sharing class SM_Renouvellement {
    
    public SM_Renouvellement() {

    }

    public static void newAbo(){

        zc_ProxyActionsubscribeRequest reqObj = new zc_ProxyActionsubscribeRequest();
        zc_SubscribeRequest sub = new zc_SubscribeRequest();
        
        sub.account = new zc_SubscribeRequestAccount();
        //sub.billToContact = new zc_SubscribeRequestBillToContact();
        // sub.soldToContact = new zc_SubscribeRequestSoldToContact();
        // sub.paymentMethod = new zc_SubscribeRequestPaymentMethod();
        // sub.previewOptions = new zc_SubscribeRequestPreviewOptions();
        sub.subscriptionData = new zc_SubscribeRequestSubscriptionData();
        sub.subscribeOptions = new zc_SubscribeRequestSubscribeOptions();

        sub.account.id='8adce4216787fdf0016788ffa3cf4110';
        //sub.account.taxExemptStatus = 'kjlk';

        sub.subscribeOptions.generateInvoice = true;
        sub.subscribeOptions.processPayments = false;
        sub.subscribeOptions.subscribeInvoiceProcessingOptions = new zc_SubscribeRequestInvProcessingOptions();
        sub.subscribeOptions.subscribeInvoiceProcessingOptions.invoiceDate = Date.today();
        sub.subscribeOptions.subscribeInvoiceProcessingOptions.invoiceTargetDate = Date.today();
        sub.subscribeOptions.subscribeInvoiceProcessingOptions.invoiceProcessingScope = 'Subscription';

        sub.subscriptionData.subscription = new zc_SubscribeRequestSubscriptionDataSub();
        sub.subscriptionData.subscription.termType = 'TERMED';
        sub.subscriptionData.subscription.initialTermPeriodType = 'Month';
        sub.subscriptionData.subscription.renewalTermPeriodType = 'Month';
        sub.subscriptionData.subscription.initialTerm = 12;
        sub.subscriptionData.subscription.renewalTerm = 12;
        sub.subscriptionData.subscription.renewalSetting = 'RENEW_WITH_SPECIFIC_TERM';
        sub.subscriptionData.subscription.autoRenew = false;
        sub.subscriptionData.subscription.IsInvoiceSeparate = true;
        sub.subscriptionData.subscription.contractEffectiveDate = Date.today();
        sub.subscriptionData.subscription.termStartDate = Date.today();

        //produit 1
        zc_AmendmentRatePlanData rpdata1 = new zc_AmendmentRatePlanData();
        zc_RatePlanChargeDataInRatePlanData rpc = new zc_RatePlanChargeDataInRatePlanData();
        
        rpdata1.ratePlan = new zc_RatePlan();
        rpdata1.ratePlan.productRatePlanId = '8adce42167366ee301675487512231d7';
        rpc.ratePlanCharge = new zc_RatePlanChargeInRatePlanChargeData(); 
        rpc.ratePlanCharge.productRatePlanChargeId = '8adce42167366ee301675487514831d9';
        rpdata1.ratePlanChargeData.add(rpc);

        //produit 2
        zc_AmendmentRatePlanData rpdata2 = new zc_AmendmentRatePlanData();
        zc_RatePlanChargeDataInRatePlanData rpc2 = new zc_RatePlanChargeDataInRatePlanData();

        rpdata2.ratePlan = new zc_RatePlan();
        rpdata2.ratePlan.productRatePlanId = '8adc8f996532f2c801655b7d2cfe0f22';
        rpc2.ratePlanCharge = new zc_RatePlanChargeInRatePlanChargeData(); 
        rpc2.ratePlanCharge.productRatePlanChargeId = '8adce4216532fbf601655b7d957947f1';
        rpdata2.ratePlanChargeData.add(rpc2);

        sub.subscriptionData.ratePlanData.add(rpdata2);
        sub.subscriptionData.ratePlanData.add(rpdata1);

        reqObj.subscribes.add(sub);


  

        String accessToken = WS001_CallZuora.access_token;
        String zEntityId = WS001_CallZuora.getZuoraEntityId('033');
        zc_ProxySubscribeResult resObj = new zc_ProxySubscribeResult();
        resObj = zc_Api.actionSubscribePOST(accessToken, zEntityId, reqObj, RTExceptionCode.ERREUR_IMPAYE_REGLER_APPLICATION_FRAIS, new ProcessLog__c());
        System.debug('MBEN:resObj: ' + JSON.serialize(resObj));

        // String json1 = JSON.serialize(reqObj, true);
        // System.debug('MBEN json1: ' + json1);


        // ZUC_Parser reqParser = new ZUC_Parser(ZUC_Parser.MAP_SWAP);
        // String resultat = reqParser.serializeWithMapping3(reqObj);
        // System.debug('MBEN XXX: ' + resultat);


        // String json2 = reqParser.serializeWithMapping2(json1, 'zc_ProxyActionsubscribeRequest');
        // System.debug('MBEN json2: ' + json2);


    }
}