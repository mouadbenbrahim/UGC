public with sharing class zc_Api {
    public zc_Api() {

    }

    public static zc_ProxySaveResult actionUpdatePOST(String accessToken, String zEntityId, zc_ProxyActionupdateRequest reqObj, RTExceptionCode rtc, ProcessLog__c pLog){
        
        zc_ProxySaveResult respObj = new zc_ProxySaveResult();
        Map<String,Object> respMap = WS001_CallZuora.sendRequest5(accessToken, '/v1/action/update', zEntityId, 'POST', reqObj,zc_ProxySaveResult.class, null, null);

        String reqStr = JSON.serialize(reqObj);
        RTExceptionCode rtc2 = new RTExceptionCode(rtc.libelle + String.valueOf(respMap.get('RESP_BODY')) + reqStr,rtc.code);

        if(respMap.containsKey('ERROR_HTTP') || respMap.containsKey('ERROR_OBJECT')){
            throw new RTException(rtc2,pLog);
        }else {
            respObj = (zc_ProxySaveResult)respMap.get('RESP_OBJECT');
            if(respObj != null && respObj.results.size() > 0){
                if(!respObj.results.get(0).success){                
                    throw new RTException(rtc2,pLog);             
                }            
            }
        }

        return respObj;
    }

    public static zc_GETARPaymentType paymentsPOST(String accessToken, String zEntityId, zc_CreatePaymentType reqObj, RTExceptionCode rtc, ProcessLog__c pLog){
        
        zc_GETARPaymentType respObj = new zc_GETARPaymentType();
        Map<String,Object> respMap = WS001_CallZuora.sendRequest3(accessToken, '/v1/payments', zEntityId, 'POST', reqObj,zc_GETARPaymentType.class, zc_CommonResponseType.class, null);

        String reqStr = JSON.serialize(reqObj);
        RTExceptionCode rtc2 = new RTExceptionCode(rtc.libelle + String.valueOf(respMap.get('RESP_BODY')) + reqStr,rtc.code);

        if(respMap.containsKey('ERROR_HTTP') || respMap.containsKey('ERROR_OBJECT')){
            throw new RTException(rtc2,pLog);
        }else {
            respObj = (zc_GETARPaymentType)respMap.get('RESP_OBJECT');
            if(respObj != null && respObj.success != null){
                if(!respObj.success){                
                    throw new RTException(rtc2,pLog);
                }            
            }
        }

        return respObj;
    }

    public static zc_GETARPaymentType paymentsPOST2(String accessToken, String zEntityId, zc_CreatePaymentType reqObj, RTExceptionCode rtc, ProcessLog__c pLog){
        
        zc_GETARPaymentType respObj = new zc_GETARPaymentType();
        Map<String,Object> respMap = WS001_CallZuora.sendRequest5(accessToken, '/v1/payments', zEntityId, 'POST', reqObj,zc_GETARPaymentType.class, zc_CommonResponseType.class, null);

        String reqStr = JSON.serialize(reqObj);
        RTExceptionCode rtc2 = new RTExceptionCode(rtc.libelle + String.valueOf(respMap.get('RESP_BODY')) + reqStr,rtc.code);

        if(respMap.containsKey('ERROR_HTTP') || respMap.containsKey('ERROR_OBJECT')){
            throw new RTException(rtc2,pLog);
        }else {
            respObj = (zc_GETARPaymentType)respMap.get('RESP_OBJECT');
            if(respObj != null && respObj.success != null){
                if(!respObj.success){                
                    throw new RTException(rtc2,pLog);
                }            
            }
        }

        return respObj;
    }

    public static zc_BillingPreviewResult opeBillingPreviewPOST(String accessToken, String zEntityId, zc_PostBillingPreviewParam reqObj, RTExceptionCode rtc, ProcessLog__c pLog){
        
        zc_BillingPreviewResult respObj = new zc_BillingPreviewResult();
        Map<String,Object> respMap = WS001_CallZuora.sendRequest3(accessToken, '/v1/operations/billing-preview', zEntityId, 'POST', reqObj,zc_BillingPreviewResult.class, zc_CommonResponseType.class, null);

        String reqStr = JSON.serialize(reqObj);
        RTExceptionCode rtc2 = new RTExceptionCode(rtc.libelle + String.valueOf(respMap.get('RESP_BODY')) + reqStr,rtc.code);

        if(respMap.containsKey('ERROR_HTTP') || respMap.containsKey('ERROR_OBJECT')){
            throw new RTException(rtc2,pLog);
        }else {
            respObj = (zc_BillingPreviewResult)respMap.get('RESP_OBJECT');
            if(respObj != null && respObj.success != null){
                if(!respObj.success){                
                    throw new RTException(rtc2,pLog);
                }            
            }
        }

        return respObj;
    }

    public static zc_GenerateBillingDocumentResponseT accBillDocGeneratePOST(String accessToken, String zEntityId, zc_PostGenerateBillingDocumentType reqObj, String accountId, RTExceptionCode rtc, ProcessLog__c pLog){
        
        zc_GenerateBillingDocumentResponseT respObj = new zc_GenerateBillingDocumentResponseT();
        Map<String,Object> respMap = WS001_CallZuora.sendRequest3(accessToken, '/v1/accounts/'+accountId+'/billing-documents/generate', zEntityId, 'POST', reqObj,zc_GenerateBillingDocumentResponseT.class, zc_CommonResponseType.class, null);

        String reqStr = JSON.serialize(reqObj);
        RTExceptionCode rtc2 = new RTExceptionCode(rtc.libelle + String.valueOf(respMap.get('RESP_BODY')) + reqStr,rtc.code);

        if(respMap.containsKey('ERROR_HTTP') || respMap.containsKey('ERROR_OBJECT')){
            throw new RTException(rtc2,pLog);
        }else {
            respObj = (zc_GenerateBillingDocumentResponseT)respMap.get('RESP_OBJECT');
            if(respObj != null && respObj.success != null){
                if(!respObj.success){                
                    throw new RTException(rtc2,pLog);
                }            
            }
        }

        return respObj;
    }

    public static zc_ProxyActionAmendResponse actionAmendPOST(String accessToken, String zEntityId, zc_ProxyActionAmendRequest reqObj, RTExceptionCode rtc, ProcessLog__c pLog){
        
        zc_ProxyActionAmendResponse respObj = new zc_ProxyActionAmendResponse();
        Map<String,Object> respMap = WS001_CallZuora.sendRequest5(accessToken, '/v1/action/amend', zEntityId, 'POST', reqObj,zc_ProxyActionAmendResponse.class, null, null);


        String reqStr = JSON.serialize(reqObj);
        RTExceptionCode rtc2 = new RTExceptionCode(rtc.libelle + String.valueOf(respMap.get('RESP_BODY')) + reqStr,rtc.code);

        if(respMap.containsKey('ERROR_HTTP') || respMap.containsKey('ERROR_OBJECT')){
            throw new RTException(rtc2,pLog);
        }else {
            respObj = (zc_ProxyActionAmendResponse)respMap.get('RESP_OBJECT');
            if(respObj != null && respObj.results != null  && respObj.results.size() > 0){
                for(zc_AmendResult r : respObj.results){
                    if(!r.success){
                        if(r.errors != null && r.errors.size() > 0){
                            throw new RTException(rtc2,pLog);
                        }
                    }
                }
            }
        }
        return respObj;
    }

    public static zc_GETSubscriptionTypeWithSuccess subscriptionGET(String accessToken, String zEntityId, String subId, RTExceptionCode rtc, ProcessLog__c pLog){
        
        zc_GETSubscriptionTypeWithSuccess respObj = new zc_GETSubscriptionTypeWithSuccess();
        Map<String,Object> respMap = WS001_CallZuora.sendRequest3(accessToken, '/v1/subscriptions/'+subId, zEntityId, 'GET', null,zc_GETSubscriptionTypeWithSuccess.class, zc_CommonResponseType.class, null);

        String reqStr = 'subId: ' + subId;
        RTExceptionCode rtc2 = new RTExceptionCode(rtc.libelle + String.valueOf(respMap.get('RESP_BODY')) + reqStr,rtc.code);

        if(respMap.containsKey('ERROR_HTTP') || respMap.containsKey('ERROR_OBJECT')){
            throw new RTException(rtc2,pLog);
        }else {
            respObj = (zc_GETSubscriptionTypeWithSuccess)respMap.get('RESP_OBJECT');
            if(respObj != null && respObj.success != null){
                if(!respObj.success){                
                    throw new RTException(rtc2,pLog);
                }            
            }
        }

        return respObj;
    }

    public static zc_GETAccountType accountGET(String accessToken, String zEntityId, String accId, RTExceptionCode rtc, ProcessLog__c pLog){
        
        zc_GETAccountType respObj = new zc_GETAccountType();
        Map<String,Object> respMap = WS001_CallZuora.sendRequest3(accessToken, '/v1/accounts/'+accId, zEntityId, 'GET', null,zc_GETAccountType.class, zc_CommonResponseType.class, null);

        String reqStr = 'accId' + accId;
        RTExceptionCode rtc2 = new RTExceptionCode(rtc.libelle + String.valueOf(respMap.get('RESP_BODY')) + reqStr,rtc.code);

        if(respMap.containsKey('ERROR_HTTP') || respMap.containsKey('ERROR_OBJECT')){
            throw new RTException(rtc2,pLog);
        }else {
            respObj = (zc_GETAccountType)respMap.get('RESP_OBJECT');
            if(respObj != null && respObj.success != null){
                if(!respObj.success){                
                    throw new RTException(rtc2,pLog);
                }            
            }
        }

        return respObj;
    }

    public static zc_ProxyGetAccount objectAccountGET(String accessToken, String zEntityId, String accId, RTExceptionCode rtc, ProcessLog__c pLog){
        
        zc_ProxyGetAccount respObj = new zc_ProxyGetAccount();
        Map<String,Object> respMap = WS001_CallZuora.sendRequest3(accessToken, '/v1/object/account/'+accId, zEntityId, 'GET', null,zc_ProxyGetAccount.class, zc_ProxyActionqueryResponse.class, null);

        String reqStr = 'accId' + accId;
        RTExceptionCode rtc2 = new RTExceptionCode(rtc.libelle + String.valueOf(respMap.get('RESP_BODY')) + reqStr,rtc.code);

        if(respMap.containsKey('ERROR_HTTP') || respMap.containsKey('ERROR_OBJECT')){
            throw new RTException(rtc2,pLog);
        }
        else {
            respObj = (zc_ProxyGetAccount)respMap.get('RESP_OBJECT');
            // if(respObj != null && respObj.success != null){
            //     if(!respObj.success){                
            //         throw new RTException(new RTExceptionCode(rtc.libelle + String.valueOf(respMap.get('RESP_BODY')),rtc.code));   
            //     }            
            // }
        }

        return respObj;
    }    

    public static zc_ProxyGetPaymentMethod objectPaymentMethodGET(String accessToken, String zEntityId, String pmId, RTExceptionCode rtc, ProcessLog__c pLog){
        
        zc_ProxyGetPaymentMethod respObj = new zc_ProxyGetPaymentMethod();
        Map<String,Object> respMap = WS001_CallZuora.sendRequest3(accessToken, '/v1/object/payment-method/'+pmId, zEntityId, 'GET', null,zc_ProxyGetPaymentMethod.class, zc_ProxyActionqueryResponse.class, null);

        String reqStr = 'pmId' + pmId;
        RTExceptionCode rtc2 = new RTExceptionCode(rtc.libelle + String.valueOf(respMap.get('RESP_BODY')) + reqStr,rtc.code);

        if(respMap.containsKey('ERROR_HTTP') || respMap.containsKey('ERROR_OBJECT')){
            throw new RTException(rtc2,pLog);
        }else {
            respObj = (zc_ProxyGetPaymentMethod)respMap.get('RESP_OBJECT');
            // if(respObj != null && respObj.success != null){
            //     if(!respObj.success){                
            //         throw new RTException(new RTExceptionCode(rtc.libelle + String.valueOf(respMap.get('RESP_BODY')),rtc.code));   
            //     }            
            // }
        }

        return respObj;
    }  

    public static zc_POSTSubscriptionCancellationResp subscriptionCancelPUT(String accessToken, String zEntityId, zc_POSTSubscriptionCancellationType reqObj, String subId, RTExceptionCode rtc, ProcessLog__c pLog){
        
        zc_POSTSubscriptionCancellationResp respObj = new zc_POSTSubscriptionCancellationResp();
        Map<String,Object> respMap = WS001_CallZuora.sendRequest3(accessToken, '/v1/subscriptions/'+subId+'/cancel', zEntityId, 'PUT', reqObj, zc_POSTSubscriptionCancellationResp.class, zc_CommonResponseType.class, '211.0');

        String reqStr = JSON.serialize(reqObj);
        RTExceptionCode rtc2 = new RTExceptionCode(rtc.libelle + String.valueOf(respMap.get('RESP_BODY')) + reqStr,rtc.code);

        if(respMap.containsKey('ERROR_HTTP') || respMap.containsKey('ERROR_OBJECT')){
            throw new RTException(rtc2,pLog);
        }else {
            respObj = (zc_POSTSubscriptionCancellationResp)respMap.get('RESP_OBJECT');
            if(respObj != null && respObj.success != null){
                if(!respObj.success){                
                    throw new RTException(rtc2,pLog);
                }            
            }
        }

        return respObj;
    }    

    public static zc_SaveResult objectSubscriptionDELETE(String accessToken, String zEntityId, String subId, RTExceptionCode rtc, ProcessLog__c pLog){
        
        zc_SaveResult respObj = new zc_SaveResult();
        Map<String,Object> respMap = WS001_CallZuora.sendRequest3(accessToken, '/v1/object/subscription/'+subId, zEntityId, 'DELETE', null,zc_SaveResult.class, null, null);


        String reqStr = 'subId: ' + subId;
        RTExceptionCode rtc2 = new RTExceptionCode(rtc.libelle + String.valueOf(respMap.get('RESP_BODY')) + reqStr,rtc.code);

        if(respMap.containsKey('ERROR_HTTP') || respMap.containsKey('ERROR_OBJECT')){
            throw new RTException(rtc2,pLog);
        }else {
            respObj = (zc_SaveResult)respMap.get('RESP_OBJECT');
            if(respObj != null && respObj.success != null){
                if(!respObj.success){                
                    throw new RTException(rtc2,pLog);
                }            
            }
        }

        return respObj;
    }

    public static zc_SaveResult objectSubscriptionPUT(String accessToken, String zEntityId, String subId, zc_ProxyModifySubscription reqObj, RTExceptionCode rtc, ProcessLog__c pLog){
        
        zc_SaveResult respObj = new zc_SaveResult();
        Map<String,Object> respMap = WS001_CallZuora.sendRequest3(accessToken, '/v1/object/subscription/'+subId, zEntityId, 'PUT', reqObj,zc_SaveResult.class, null, null);

        String reqStr = JSON.serialize(reqObj);
        RTExceptionCode rtc2 = new RTExceptionCode(rtc.libelle + String.valueOf(respMap.get('RESP_BODY')) + reqStr,rtc.code);

        if(respMap.containsKey('ERROR_HTTP') || respMap.containsKey('ERROR_OBJECT')){
            throw new RTException(rtc2,pLog);
        }else {
            respObj = (zc_SaveResult)respMap.get('RESP_OBJECT');
            if(respObj != null && respObj.success != null){
                if(!respObj.success){                
                    throw new RTException(rtc2,pLog);
                }            
            }
        }

        return respObj;
    }

    public static zc_GETInvoiceItemsResponse invoicesItemsGET(String accessToken, String zEntityId, String invId, RTExceptionCode rtc, ProcessLog__c pLog){
        
        zc_GETInvoiceItemsResponse respObj = new zc_GETInvoiceItemsResponse();
        Map<String,Object> respMap = WS001_CallZuora.sendRequest3(accessToken, '/v1/invoices/'+invId+'/items', zEntityId, 'GET', null,zc_GETInvoiceItemsResponse.class, zc_CommonResponseType.class, null);

        String reqStr = 'invId' + invId;
        RTExceptionCode rtc2 = new RTExceptionCode(rtc.libelle + String.valueOf(respMap.get('RESP_BODY')) + reqStr,rtc.code);

        if(respMap.containsKey('ERROR_HTTP') || respMap.containsKey('ERROR_OBJECT')){
            throw new RTException(rtc2,pLog);
        }else {
            respObj = (zc_GETInvoiceItemsResponse)respMap.get('RESP_OBJECT');
            if(respObj != null && respObj.success != null){
                if(!respObj.success){                
                    throw new RTException(rtc2,pLog);
                }            
            }
        }

        return respObj;
    }

    public static zc_ProxyActionqueryResponse actionQueryPOST(String accessToken, String zEntityId, zc_ProxyActionqueryRequest reqObj, RTExceptionCode rtc, ProcessLog__c pLog){
        
        zc_ProxyActionqueryResponse respObj = new zc_ProxyActionqueryResponse();
        Map<String,Object> respMap = WS001_CallZuora.sendRequest3(accessToken, '/v1/action/query', zEntityId, 'POST', reqObj,zc_ProxyActionqueryResponse.class, null, null);

        String reqStr = JSON.serialize(reqObj);
        RTExceptionCode rtc2 = new RTExceptionCode(rtc.libelle + String.valueOf(respMap.get('RESP_BODY')) + reqStr,rtc.code);

        if(respMap.containsKey('ERROR_HTTP') || respMap.containsKey('ERROR_OBJECT')){
            throw new RTException(rtc2,pLog);
        }else {
            respObj = (zc_ProxyActionqueryResponse)respMap.get('RESP_OBJECT');
            if(respObj != null && respObj.records.size() == 0){
                    throw new RTException(rtc2,pLog);
            }
        }

        //{"queryString": "Select Id, AccountId,  AutoRenew, CancelledDate, ContractAcceptanceDate, ContractEffectiveDate, CreatedById, CreatedDate, CreatorAccountId, CreatorInvoiceOwnerId, CurrentTerm, CurrentTermPeriodType, InitialTerm, InitialTermPeriodType, InvoiceOwnerId, IsInvoiceSeparate, Name, Notes, OriginalCreatedDate, OriginalId, PreviousSubscriptionId, RenewalSetting, RenewalTerm, RenewalTermPeriodType, ServiceActivationDate, Status, SubscriptionEndDate, SubscriptionStartDate, TermEndDate, TermStartDate, TermType, UpdatedById, UpdatedDate, Version, DateDebutContratReel__c From Subscription where AccountId='8adce4216cccb721016ccebbbc0f55ce'"}

        return respObj;
    }

    public static zc_ProxySubscribeResult actionSubscribePOST(String accessToken, String zEntityId, zc_ProxyActionsubscribeRequest reqObj, RTExceptionCode rtc, ProcessLog__c pLog){
        
        zc_ProxySubscribeResult respObj = new zc_ProxySubscribeResult();
        Map<String,Object> respMap = WS001_CallZuora.sendRequest5(accessToken, '/v1/action/subscribe', zEntityId, 'POST', reqObj,zc_ProxySubscribeResult.class, null, null);

        String reqStr = JSON.serialize(reqObj);
        RTExceptionCode rtc2 = new RTExceptionCode(rtc.libelle + String.valueOf(respMap.get('RESP_BODY')) + reqStr,rtc.code);

        if(respMap.containsKey('ERROR_HTTP') || respMap.containsKey('ERROR_OBJECT')){
            throw new RTException(rtc2,pLog);
        }else {
            respObj = (zc_ProxySubscribeResult)respMap.get('RESP_OBJECT');
            if(respObj != null && respObj.results.size() > 0){
                if(!respObj.results.get(0).success){                
                    throw new RTException(rtc2,pLog);             
                }            
            }
        }

        return respObj;
    }

    public static zc_ProxyGetInvoice objectInvoiceGET(String accessToken, String zEntityId, String invId, RTExceptionCode rtc, ProcessLog__c pLog){
        
        zc_ProxyGetInvoice respObj = new zc_ProxyGetInvoice();
        Map<String,Object> respMap = WS001_CallZuora.sendRequest3(accessToken, '/v1/object/invoice/'+invId+'?fields=id,amount', zEntityId, 'GET', null,zc_ProxyGetInvoice.class, zc_ProxyActionqueryResponse.class, null);

        String reqStr = 'invId' + invId;
        RTExceptionCode rtc2 = new RTExceptionCode(rtc.libelle + String.valueOf(respMap.get('RESP_BODY')) + reqStr,rtc.code);

        if(respMap.containsKey('ERROR_HTTP') || respMap.containsKey('ERROR_OBJECT')){
            throw new RTException(rtc2,pLog);
        }
        else {
            respObj = (zc_ProxyGetInvoice)respMap.get('RESP_OBJECT');
            // if(respObj != null && respObj.success != null){
            //     if(!respObj.success){                
            //         throw new RTException(new RTExceptionCode(rtc.libelle + String.valueOf(respMap.get('RESP_BODY')),rtc.code));   
            //     }            
            // }
        }

        return respObj;
    } 

    public static zc_GETInvoiceFilesResponse  invoicesFilesGET(String accessToken, String zEntityId, String invId, RTExceptionCode rtc, ProcessLog__c pLog){
        
        zc_GETInvoiceFilesResponse  respObj = new zc_GETInvoiceFilesResponse ();
        Map<String,Object> respMap = WS001_CallZuora.sendRequest3(accessToken, '/v1/invoices/'+invId+'/files', zEntityId, 'GET', null,zc_GETInvoiceFilesResponse .class, zc_CommonResponseType.class, null);

        String reqStr = 'invId' + invId;
        RTExceptionCode rtc2 = new RTExceptionCode(rtc.libelle + String.valueOf(respMap.get('RESP_BODY')) + reqStr,rtc.code);

        if(respMap.containsKey('ERROR_HTTP') || respMap.containsKey('ERROR_OBJECT')){
            throw new RTException(rtc2,pLog);
        }else {
            respObj = (zc_GETInvoiceFilesResponse )respMap.get('RESP_OBJECT');
            if(respObj != null && respObj.success != null){
                if(!respObj.success){                
                    throw new RTException(rtc2,pLog);
                }            
            }
        }

        return respObj;
    }

    public static zc_GETAccountSummaryType accountSummaryGET(String accessToken, String zEntityId, String accId, RTExceptionCode rtc, ProcessLog__c pLog){
        
        zc_GETAccountSummaryType respObj = new zc_GETAccountSummaryType();
        Map<String,Object> respMap = WS001_CallZuora.sendRequest5(accessToken, '/v1/accounts/'+ accId + '/summary', zEntityId, 'GET', null,zc_GETAccountSummaryType.class, zc_CommonResponseType.class, null);

        if (respMap.containsKey('ERROR_OBJECT')) {            
            throw new RTException(new RTExceptionCode(rtc.libelle + String.valueOf(respMap.get('ERROR_BODY')),rtc.code), pLog);
        }else {
            respObj = (zc_GETAccountSummaryType)respMap.get('RESP_OBJECT');
            if(respObj != null && respObj.success != null){
                if(!respObj.success){                
                    throw new RTException(new RTExceptionCode(rtc.libelle + String.valueOf(respMap.get('RESP_BODY')),rtc.code), pLog);   
                }            
            }
        }

        return respObj;
    }

    public static zc_ProxyCreateOrModifyResponse objectPaymentMethodPOST(String accessToken, String zEntityId, zc_ProxyCreatePaymentMethod reqObj, RTExceptionCode rtc, ProcessLog__c pLog){
        
        zc_ProxyCreateOrModifyResponse respObj = new zc_ProxyCreateOrModifyResponse();
        Map<String,Object> respMap = WS001_CallZuora.sendRequest5(accessToken, '/v1/object/payment-method/', zEntityId, 'POST', reqObj,zc_ProxyCreateOrModifyResponse.class, zc_ProxyBadRequestResponse.class, null);

        String reqStr = JSON.serialize(reqObj);
        RTExceptionCode rtc2 = new RTExceptionCode(rtc.libelle + String.valueOf(respMap.get('RESP_BODY')) + reqStr,rtc.code);

        if(respMap.containsKey('ERROR_HTTP') || respMap.containsKey('ERROR_OBJECT')){
            throw new RTException(rtc2,pLog);
        }else {
            respObj = (zc_ProxyCreateOrModifyResponse)respMap.get('RESP_OBJECT');
            if(respObj != null && respObj.success != null){
                if(!respObj.success){                
                    throw new RTException(rtc2,pLog);
                }            
            }
        }

        return respObj;
    }    

    public static zc_CommonResponseType accountPUT(String accessToken, String zEntityId, String accId, zc_PUTAccountType reqObj, RTExceptionCode rtc, ProcessLog__c pLog){
        
        zc_CommonResponseType respObj = new zc_CommonResponseType();
        Map<String,Object> respMap = WS001_CallZuora.sendRequest5(accessToken, '/v1/accounts/' + accId, zEntityId, 'PUT', reqObj,zc_CommonResponseType.class, null, null);

        String reqStr = JSON.serialize(reqObj);
        RTExceptionCode rtc2 = new RTExceptionCode(rtc.libelle + String.valueOf(respMap.get('RESP_BODY')) + reqStr,rtc.code);

        if(respMap.containsKey('ERROR_HTTP') || respMap.containsKey('ERROR_OBJECT')){
            throw new RTException(rtc2,pLog);
        }else {
            respObj = (zc_CommonResponseType)respMap.get('RESP_OBJECT');
            if(respObj != null && respObj.success != null){
                if(!respObj.success){                
                    throw new RTException(rtc2,pLog);
                }            
            }
        }

        return respObj;
    }

    public static zc_GETAmendmentType amendSubscriptionGET(String accessToken, String zEntityId, String subId, RTExceptionCode rtc, ProcessLog__c pLog){
        
        zc_GETAmendmentType respObj = new zc_GETAmendmentType();
        Map<String,Object> respMap = WS001_CallZuora.sendRequest3(accessToken, '/v1/amendments/subscriptions/'+subId, zEntityId, 'GET', null,zc_GETAmendmentType.class, zc_CommonResponseType.class, null);

        String reqStr = 'subId: ' + subId;
        RTExceptionCode rtc2 = new RTExceptionCode(rtc.libelle + String.valueOf(respMap.get('RESP_BODY')) + reqStr,rtc.code);

        if(respMap.containsKey('ERROR_HTTP') || respMap.containsKey('ERROR_OBJECT')){
            throw new RTException(rtc2,pLog);
        }else {
            respObj = (zc_GETAmendmentType)respMap.get('RESP_OBJECT');
            if(respObj != null && respObj.success != null){
                if(!respObj.success){                
                    throw new RTException(rtc2,pLog);
                }            
            }
        }

        return respObj;
    }    

    public static zc_ProxyGetAmendment objectAmendGET(String accessToken, String zEntityId, String amendId, RTExceptionCode rtc, ProcessLog__c pLog){
        
        zc_ProxyGetAmendment respObj = new zc_ProxyGetAmendment();
        Map<String,Object> respMap = WS001_CallZuora.sendRequest3(accessToken, '/v1/object/amendment/'+amendId, zEntityId, 'GET', null,zc_ProxyGetAmendment.class, zc_ProxyActionqueryResponse.class, null);

        String reqStr = 'amendId' + amendId;
        RTExceptionCode rtc2 = new RTExceptionCode(rtc.libelle + String.valueOf(respMap.get('RESP_BODY')) + reqStr,rtc.code);

        if(respMap.containsKey('ERROR_HTTP') || respMap.containsKey('ERROR_OBJECT')){
            throw new RTException(rtc2,pLog);
        }
        else {
            respObj = (zc_ProxyGetAmendment)respMap.get('RESP_OBJECT');
            // if(respObj != null && respObj.success != null){
            //     if(!respObj.success){                
            //         throw new RTException(new RTExceptionCode(rtc.libelle + String.valueOf(respMap.get('RESP_BODY')),rtc.code));   
            //     }            
            // }
        }

        return respObj;
    }     

} // end class

// // NON UTILISE