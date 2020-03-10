public without sharing class SM_Rollback {


    public static void executeCatch(Exception e, ProcessLog__c pLog, Boolean isDMLoperation, Id accountSFID, String zEntityId, String accessToken, map<String,list<map<String,Object>>> mapRollBackProcess){
    	String fullMessage = e.getMessage() + e.getStackTraceString() + e.getTypeName() + e.getCause() + e.getLineNumber();
		pLog.Message__c = pLog.Message__c + fullMessage;
		if(isDMLoperation){
			Account acctoblock = new Account(Id = accountSFID, Locked__c = true);
			update acctoblock;
			SM_QueueableRollback rb = new SM_QueueableRollback(accessToken, zEntityId, mapRollBackProcess, accountSFID, pLog);
			System.enqueueJob(rb);
		} else{
			rollback(accessToken, zEntityId, mapRollBackProcess, accountSFID, pLog);
        }
        

        if(e.getTypeName()=='RTException')
            e = (RTException)e;
           
        throw e;
    }
    
    
    public static void rollback(String accessToken, String zEntityId,Map<String,List<Map<String,Object>>> mapIn, String AccId ,ProcessLog__c pLog){
    
        try{
            
            List<String> actionlst = new List<String>();
            for (String strKey : mapIn.keySet()) {
                actionlst.add(strKey);
            }
            actionlst.sort();
            for (String actionIn : actionlst) {
                System.debug('Key: ' + actionIn);
                switch on actionIn.substring(3) {
                    when 'UPDATEACTION' {
                        System.debug('## ECH SM_Rollback.rollback actionIn >> '+actionIn);
                        for(Map<String,Object> mapAct : mapIn.get(actionIn)){
                            zc_Api.actionUpdatePOST(accessToken, zEntityId, (zc_ProxyActionupdateRequest)mapAct.get('ACTIONUPDATEREQUEST'), RTExceptionCode.ERREUR_ROLLBACK_UPDATEACC_DEFPAYMETHOD,pLog);    

                        }
                    }
                    when 'UPDATEACCOUNT' {
                        System.debug('## ECH SM_Rollback.rollback actionIn >> '+actionIn);
                        for(Map<String,Object> mapAcc : mapIn.get(actionIn)){
                            zc_CommonResponseType billToUpdResp = zc_Api.accountPUT(accessToken, zEntityId, (String)mapAcc.get('accountZID'), (zc_PUTAccountType )mapAcc.get('ACCUPDATEREQUEST'), RTExceptionCode.ERREUR_ROLLBACK_UPDATE_BILLSOLDTO, pLog);
                        }
                    }
                    when 'CANCELSUB' {
                        System.debug('## ECH SM_Rollback.rollback actionIn >> '+actionIn);
                        for(Map<String,Object> mapSub : mapIn.get(actionIn)){
                            Datetime DateDebutTime = (Datetime)mapSub.get('DATEDEBUTCONTRAT');
                            Date DateDebut = Date.newinstance(DateDebutTime.year(), DateDebutTime.month(), DateDebutTime.day());
                            if(DateDebut>Date.today()) {
                                zc_ProxyActionupdateRequest subUpdateReq = new zc_ProxyActionupdateRequest();   
                                subUpdateReq.r_type = 'Subscription';
                                zc_ZObjectUpdate zObj = new zc_ZObjectUpdate();
                                zObj.id = (String)mapSub.get('SUBID');
                                zObj.serviceActivationDate = DateDebut;
                                zObj.contractAcceptanceDate = DateDebut;
                                subUpdateReq.objects.add(zObj);
                                //Activation du contrat futur avant cancel
                                zc_Api.actionUpdatePOST(accessToken, zEntityId, subUpdateReq, RTExceptionCode.ERREUR_ROLLBACK_UPDATE_ZSUBSCRIPTION,pLog);
                            }
                            //Cancel du contrat
                            zc_POSTSubscriptionCancellationResp rCancel = zc_Api.subscriptionCancelPUT(accessToken, zEntityId, (zc_POSTSubscriptionCancellationType )mapSub.get('SUBCANCELREQUEST'), (String)mapSub.get('SUBID'), RTExceptionCode.ERREUR_ROLLBACK_CANCEL_ZSUBSCRIPTION, pLog);
                            //Apply du credit memo                        
                            if(!String.isBlank(rCancel.creditMemoId)){
                                zc_ApplyCreditMemoType CMreq = new zc_ApplyCreditMemoType();
                                CMreq.effectiveDate = DateDebut;
                                WSZ.CreditMemoOut cm = SM_CreditMemo.getCreditMemo(rCancel.creditMemoId, zEntityId);
                                pLog.Message__c = pLog.Message__c + 'CMAmount>>'+cm.amount;
                                Decimal amountToRefund = Decimal.valueOf(cm.amount);
                                zc_CreditMemoApplyInvoiceRequestTyp invReq = new zc_CreditMemoApplyInvoiceRequestTyp();
                                //invReq.amount = Double.valueOf(rCancel.paidAmount);
                                invReq.amount = amountToRefund;
                                invReq.invoiceId = (String)mapSub.get('INVOICEID');
                                CMreq.invoices = new List<zc_CreditMemoApplyInvoiceRequestTyp>{invReq};
                                zc_GETCreditMemoType CMres = zc_Api.creditmemosAPPLY(accessToken, zEntityId, rCancel.creditMemoId, CMreq, RTExceptionCode.ERREUR_ROLLBACK_APPLY_CREDITMEMO, pLog);
                            }
                        }
                    }
                    when 'UPDATESUB' {
                        System.debug('## ECH SM_Rollback.rollback actionIn >> '+actionIn);
                        for(Map<String,Object> mapSub : mapIn.get(actionIn)){
                            zc_Api.actionUpdatePOST(accessToken, zEntityId, (zc_ProxyActionupdateRequest)mapSub.get('SUBUPDATEREQUEST'), RTExceptionCode.ERREUR_ROLLBACK_UPDATE_ZSUBSCRIPTION,pLog);
                        }
                    }
                    when 'REFUNDACTION' {
                        System.debug('## ECH SM_Rollback.rollback actionIn >> '+actionIn);
                        refundAction(mapIn, actionIn);
                    }
                    when 'CANCELCASE' {
                        System.debug('## ECH SM_Rollback.rollback actionIn >> '+actionIn);
                        Set<String> caseSetid = new Set<String>();
                        for(Map<String,Object> mapCase : mapIn.get(actionIn)){
                            caseSetid.add((String)mapCase.get('CASEID'));
                        }
                        if(!caseSetid.isEmpty()){
                            
                            //Case updatecase = new Case(Id = caseSetid, CommentairesInternes__c = 'Rollback du process avec abandon de la demande');
                            
                            List<Case> updateCaselst = [SELECT id,CommentairesInternes__c from Case where id in :caseSetid];
                            for(Case updatecase : updateCaselst){
                                updatecase.Status = 'Abandonne';
                                updatecase.CommentairesInternes__c = updatecase.CommentairesInternes__c+' - Rollback du process avec abandon de la demande';
                            }
                            update updateCaselst;
                        }
                    }

                    when 'DELETESUB' {
                        System.debug('## ECH SM_Rollback.rollback actionIn >> '+actionIn);
                        for(Map<String,Object> mapSub : mapIn.get(actionIn)){
                            zc_SaveResult res = zc_Api.objectSubscriptionDELETE(accessToken, zEntityId, (String)mapSub.get('SUBID'), RTExceptionCode.ERREUR_ROLLBACK_DELETE_ZSUBSCRIPTION, pLog);
           
                        }
                    }
                    /*when 'CANCEL_INVOICE_ACTION' {
                        System.debug('## ECH SM_Rollback.rollback actionIn >> '+actionIn);
                        cancelInvoicedAction(mapIn, actionIn, pLog);
                    }*/
                    
                    /*when 'UNLOCKACC' {
                        System.debug('## ECH SM_Rollback.rollback actionIn >> '+actionIn);
                        for(Map<String,Object> mapAcc : mapIn.get(actionIn)){
                            Account acctoblock = [SELECT id from Account where id=:(String)mapAcc.get('ACCID') limit 1];
                            acctoblock.Locked__c = false;
                            update acctoblock;
                        }
                    }*/
                }

            }

            List<Account> acctoblock = [SELECT id, Locked__c from Account where id=:AccId limit 1];
            if(acctoblock.size() > 0 && acctoblock[0].Locked__c){
                acctoblock[0].Locked__c = false;
                update acctoblock;
            }

            pLog.Rollback__c = 'OK';

        }catch(Exception e){
            
            List<Account> acctoblock = [SELECT id, Locked__c from Account where id=:AccId limit 1];
            if(acctoblock.size() > 0 && !acctoblock[0].Locked__c){
                acctoblock[0].Locked__c = true;
                update acctoblock;
            }
            
            String fullMessage = e.getMessage() + e.getStackTraceString() + e.getTypeName() + e.getCause() + e.getLineNumber();

            if(e.getTypeName()=='RTException'){
                pLog.Rollback__c = ((RTException)e).Code+':'+e.getMessage();
                
            }
            else{
                pLog.Rollback__c = fullMessage;
            }
            
        }
        finally{
            insert pLog;
        }
    }
    
    
    //actionName = 'REFUNDACTION'
    public static void refundAction(map<String, list<map<String, Object>>> mapRollBackProcess, String actionName){
    	if(mapRollBackProcess.containsKey(actionName)){
    		if(mapRollBackProcess.get(actionName) != null && mapRollBackProcess.get(actionName).size() > 0){
    			for(map<String, Object> mapIn : mapRollBackProcess.get(actionName)){
    				Decimal amount				= (Decimal) mapIn.get('amount');
					String zInvoiceId			= String.valueOf(mapIn.get('zInvoiceId'));
					String zPaymentId			= String.valueOf(mapIn.get('zPaymentId'));
					String zEntityId			= String.valueOf(mapIn.get('zEntityId'));
					String access_token			= String.valueOf(mapIn.get('access_token'));
					String refundDate			= String.valueOf(mapIn.get('refundDate'));
					String paymentType			= String.valueOf(mapIn.get('paymentType'));
					String paymentMethodType	= String.valueOf(mapIn.get('paymentMethodType'));
					String reasonCode			= String.valueOf(mapIn.get('reasonCode'));
					String comment				= String.valueOf(mapIn.get('comment'));
					SM_Remboursement.unapplyPayment(amount, zInvoiceId, zPaymentId, zEntityId, access_token); 
					WSZ.RefundOut refOut = SM_Remboursement.executeRefund(refundDate, amount, paymentType, paymentMethodType, reasonCode, zPaymentId, zEntityId, access_token, comment);
    			}
    		}
    	}
	}
	
	//actionName = 'CANCEL_INVOICE_ACTION'
    /*public static void cancelInvoicedAction(map<String, list<map<String, Object>>> mapRollBackProcess, String actionName, ProcessLog__c pLog){
    	if(mapRollBackProcess.containsKey(actionName)){
    		if(mapRollBackProcess.get(actionName) != null && mapRollBackProcess.get(actionName).size() > 0){
    			for(map<String, Object> mapIn : mapRollBackProcess.get(actionName)){
					String zEntityId			= String.valueOf(mapIn.get('zEntityId'));
					String access_token			= String.valueOf(mapIn.get('access_token'));
					zc_ProxyActionupdateRequest accUpdateReq = new zc_ProxyActionupdateRequest();
					accUpdateReq.r_type = 'Invoice';
				    zc_ZObjectUpdate zObj = new zc_ZObjectUpdate();
				    zObj.id = String.valueOf(mapIn.get('zInvoiceId'));
				    zObj.status = String.valueOf(mapIn.get('status'));
				    accUpdateReq.objects.add(zObj);
					
					zc_Api.actionUpdatePOST(access_token, zEntityId, accUpdateReq, RTExceptionCode.ERREUR_IMPAYE_REGLER_UPDATE_ACCOUNT, pLog); 
    			}
    		}
    	}
    }*/

}