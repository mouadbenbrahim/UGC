public with sharing class SM_ReeditionCarte {

    public SM_ReeditionCarte() {

    }

    public static WSZ.ReeditionOut reedition(WSZ.ReeditionIn redIn){

        WSZ.ReeditionOut wsOut;
        String redInStr = JSON.serialize(redIn);
        ProcessLog__c pLog = new ProcessLog__c(Process__c = 'reedition', Account__c = redIn.accountSFID, Message__c = redInStr);
        Account porteur = SM_Account.getAccountData(redIn.accountSFID);        
        //Account payeur = SM_Account.getAccountData(migIn.payeurSFID);
        Zuora__Subscription__c sub = SM_Subscription.getSubscriptionBySetName(new Set<String>{redIn.subscriptionName}).get(0);
        String currentSubId = sub.Zuora__External_Id__c;
        String oriSubId = sub.Zuora__External_Id__c;
        String accountZID = sub.Zuora__CustomerAccount__r.Zuora__External_Id__c;
        String typeContrat = sub.TypeContrat__c;       
        Boolean isGratuit; // = redIn.isGratuit;    
        Boolean isPreview = false; 
        Date chargeDateCE,invoiceDate;
        Boolean compteBloque = false;
        String payMethodId,paymentId,caseId,fileImpId;
        Double invAmount;

        //For Rollback
		Map<String,List<Map<String,Object>>> mapRollBackProcess = new Map<String,List<Map<String,Object>>>();
        Boolean isDMLoperation = false;

        //token/entity
        String accessToken = WS001_CallZuora.access_token;
        String zEntityId = WS001_CallZuora.getZuoraEntityId(porteur.CodePays__c);


        // Initialisation date facture, gratuite...etc
        if(redIn.lieu == 'WEB') {
            isGratuit = false;
            chargeDateCE = Date.today();
            invoiceDate = Date.today();
        }else if (redIn.lieu == 'DRC'){
            if(typeContrat == 'CDD'){
                if (Util.FRANCE.contains(porteur.CodePays__c)){
                    isGratuit = true; //override
                    chargeDateCE = Date.today();
                    invoiceDate =  Date.today();
                }else if (redIn.paiement.methodePaiement <> 'VIR' || redIn.paiement.methodePaiement == null){ //BE pas de paiement
                    isGratuit = true; //override
                    chargeDateCE = Date.today();
                    invoiceDate =  Date.today();
                }else if (redIn.paiement.methodePaiement == 'VIR'){ //BE paiement externe VIR
                    isGratuit = false; //override
                    chargeDateCE = Date.today();
                    invoiceDate = Date.today();
                }
            }else { //CDI
                isGratuit = redIn.isGratuit;
                chargeDateCE = Util.firstOfNextMonth(Date.today());
                invoiceDate = null;
            }
        }

        try{

            // ###### Amends Reedition de carte
            String entite = (porteur.CodePays__c == '033') ? 'France' : 'Belgique';
            // list<ProdRatePlanCharge__c> listProdRatePlanCharge = new list<ProdRatePlanCharge__c>([SELECT ReferenceCIC__c, zid__c, ProdRatePlan__r.zid__c 
            // FROM ProdRatePlanCharge__c WHERE ReferenceCIC__c = :rpcReference and Entite__c = :entite]);  
            String fraisRpId = [SELECT ReferenceCIC__c, zid__c, ProdRatePlan__r.zid__c 
            FROM ProdRatePlanCharge__c WHERE ReferenceCIC__c = 'FRAISREDIT' and Entite__c = :entite].get(0).ProdRatePlan__r.zid__c;
            String remiseRpId = [SELECT ReferenceCIC__c, zid__c, ProdRatePlan__r.zid__c 
            FROM ProdRatePlanCharge__c WHERE ReferenceCIC__c = 'REMFRAISEDIT' and Entite__c = :entite].get(0).ProdRatePlan__r.zid__c;


            zc_ProxyActionAmendRequest actionAmend = new zc_ProxyActionAmendRequest();
            zc_AmendRequest req1 = new zc_AmendRequest();        
            req1.previewOptions = new zc_AmendRequestPreviewOptions();
            req1.amendOptions = new zc_AmendRequestAmendOptions();
            zc_Amendment amend1 = new zc_Amendment(); //charge reedition
            zc_Amendment amend2 = new zc_Amendment(); //charge remise

            req1.previewOptions.enablePreviewMode=isPreview;
            req1.amendOptions.generateInvoice = (invoiceDate == null)?false:true;
            req1.amendOptions.processPayments = false;
            zc_InvoiceProcessingOptions invPrc = new zc_InvoiceProcessingOptions();
            invPrc.invoiceDate = invoiceDate;
            invPrc.invoiceTargetDate = invoiceDate;
            req1.amendOptions.invoiceProcessingOptions = invPrc;


            // Add charge Reedition
            amend1.contractEffectiveDate = chargeDateCE;
            amend1.serviceActivationDate = chargeDateCE;
            amend1.customerAcceptanceDate = chargeDateCE;        
            amend1.r_type='NewProduct';
            amend1.name='charge reedition carte';
            amend1.description='charge reedition carte';
            amend1.status='Completed';
            amend1.subscriptionId=currentSubId;
            amend1.ratePlanData = new zc_AmendmentRatePlanData();
            amend1.ratePlanData.ratePlan = new zc_RatePlan();
            amend1.ratePlanData.ratePlan.productRatePlanId = fraisRpId;
            req1.amendments.add(amend1);

            //FOR ROLLBACK #### Add amend to delete
            list<map<String, Object>> listMapAmend= new list<map<String, Object>>();
            listMapAmend.add(new map<String, Object>{
                'SUBID' 			=> currentSubId
            });

                     

            if (isGratuit) {
                // Add charge Remise Reedition
                amend2.contractEffectiveDate = chargeDateCE;
                amend2.serviceActivationDate = chargeDateCE;
                amend2.customerAcceptanceDate = chargeDateCE;        
                amend2.r_type='NewProduct';
                amend2.name='Remise reedition carte';
                amend2.description='Remise reedition carte';
                amend2.status='Completed';
                amend2.subscriptionId=currentSubId;
                amend2.ratePlanData = new zc_AmendmentRatePlanData();
                amend2.ratePlanData.ratePlan = new zc_RatePlan();
                amend2.ratePlanData.ratePlan.productRatePlanId = remiseRpId;
                req1.amendments.add(amend2);

                //FOR ROLLBACK #### Add amend to delete
                listMapAmend.add(new map<String, Object>{
                    'SUBID' 			=> currentSubId
                });

            }

            actionAmend.requests.add(req1);

            zc_ProxyActionAmendResponse amendResult = zc_Api.actionAmendPOST(accessToken, zEntityId, actionAmend, RTExceptionCode.ERREUR_REEDITION_POST_AMEND, new ProcessLog__c());
            
            //FOR ROLLBACK #### UPDATE mapRollBackProcess
            if(listMapAmend.size()>0){
                mapRollBackProcess.put('03_DELETESUB', listMapAmend);
            }
                 
            String invoiceId = amendResult.results.get(0).invoiceId;
            Integer amendCount = amendResult.results.get(0).amendmentIds.size();
            String amendId = amendResult.results.get(0).amendmentIds.get(amendCount-1); //Last AmendId
            currentSubId = amendResult.results.get(0).subscriptionId;

            //###### get invoice ######
            if (invoiceDate != null) {
                zc_ProxyGetInvoice invRes = zc_Api.objectInvoiceGET(accessToken, zEntityId, invoiceId, RTExceptionCode.ERREUR_REEDITION_GET_INVOICE, pLog);
                invAmount = invRes.amount;
            }
            
            // Paiement
            if (invoiceDate != null && !isGratuit && redIn.paiement.refPaiement != null){ //external payment
                zc_CreatePaymentType paymentReq = SM_Payment.paymentReq(invoiceId, accountZID, invAmount, redIn.paiement.montant, redIn.paiement.refPaiement, 
                redIn.paiement.methodePaiement, redIn.lieu, redIn.agent, redIn.paiement.dateVirement, porteur.CodePays__c);
                zc_GETARPaymentType paymentRes = zc_Api.paymentsPOST2(accessToken, zEntityId, paymentReq, RTExceptionCode.ERREUR_REEDITION_PAYMENT,new ProcessLog__c());
                //payMethodId = paymentRes.paymentMethodId; //TODO:OK il faut prendre celle du contrat
                paymentId = paymentRes.id;

                //FOR ROLLBACK CREATE REFUND ###### GET Payment Data #####
                Map<String,String> retPayment = new Map<String,String>{'paymentId'=>null,'payMethodId'=>null};
                retPayment.put('payMethodId',paymentRes.paymentMethodId);
                retPayment.put('paymentId',paymentRes.id);
                String paymentType = paymentRes.r_type == zc_GETARPaymentType.RTypeEnum.ELECTRONIC ? 'Electronic' : 'External';
                retPayment.put('paymentType',paymentType);
                retPayment.put('paymentAmount',String.valueOf(paymentRes.amount));
                addRollBackActionRefund(mapRollBackProcess, invoiceId, retPayment, zEntityId, accessToken);


            }

            //###### Get Zuora Data (subscription) ######
            zc_GETSubscriptionTypeWithSuccess zSub = zc_Api.subscriptionGET(accessToken, zEntityId, currentSubId, RTExceptionCode.ERREUR_REEDITION_GET_ZSUBSCRIPTION,pLog);

            //###### Get Zuora Data (Account) ######
            zc_ProxyGetAccount zacc = zc_Api.objectAccountGET(accessToken, zEntityId, accountZID, RTExceptionCode.ERREUR_REEDITION_GET_ACCOUNT,pLog);
            payMethodId = zacc.defaultPaymentMethodId;

            //###### Get Zuora Data (PaymentMethod) ######
            zc_ProxyGetPaymentMethod pm = zc_Api.objectPaymentMethodGET(accessToken, zEntityId, payMethodId, RTExceptionCode.ERREUR_REEDITION_GET_PAYMENTMETHOD,pLog);

            //###### insert zdocdata subscription ######
            Id zDocId = SM_Hermes.addZdocData(new Map<String,Object>{'ZSUB' => zSub,'ZPM' => pm,'ACC' => porteur});

            isDMLoperation = true;
            //###### insert case ######
            //String sousMotif = lieuToSousMotif(hermesIn.lieu);
            String origin = SM_Hermes.lieuToOrigin(redIn.lieu);
            String commentairesInternes = (isGratuit)?'réédition gratuite':'réédition payante'; //03- Réédition gratuite
            String motif = (isGratuit)?'03- Réédition gratuite':'02- Réédition payante';
            Case c = SM_Hermes.newCase2(zDocId, redIn.subscriptionName, porteur.PersonContactId, origin, '1- Vie de l\'abonnement', motif, 'A- Action', 'Fermee', 
            redIn.lieu, commentairesInternes, redIn.accountSFID,null,null,null,redIn.agent);
            caseId = c.Id;

            //FOR ROLLBACK CANCEL CASE ###### GET Payment Data #####
            if(!mapRollBackProcess.containsKey('10_CANCELCASE')){
                mapRollBackProcess.put('10_CANCELCASE', new list<map<String, Object>>());
            }
            mapRollBackProcess.get('10_CANCELCASE').add(new map<String, Object>{
                'CASEID' 			=> caseId
            });   

            //###### generate sDoc ######
            List<Case> cs = [SELECT Id,AccountId,TECHIdStatut__c FROM Case WHERE Id=:caseId];
            SM_SDoc.makeSdocJobs(cs);

            //###### insert Fil impression ######
            ZDocData__c zDoc = [Select Id, Payeur__r.FirstName, Payeur__r.LastName from ZDocData__c where Id = :zDocId];
            fileImpId = SM_FileImpression.createFileImpressionCarte(null, (Id)redIn.accountSFID, null, (Id)caseId, redIn.subscriptionName, zSub.CodeOffrePrincipale, zDoc.Payeur__r.FirstName, zDoc.Payeur__r.LastName);

            wsOut = new WSZ.ReeditionOut(redIn.accountSFID, accountZID, currentSubId, redIn.subscriptionName,compteBloque, paymentId, invoiceId, caseId,fileImpId);

        }catch(Exception e){

            SM_Rollback.executeCatch(e, pLog, isDMLoperation, redIn.accountSFID, zEntityId, accessToken, mapRollBackProcess);
            
        }    
    
        return wsOut;



    }

    public static void addRollBackActionRefund(Map<String,List<Map<String,Object>>> mapRollBackProcess, String invoiceId, Map<String,String> retPayment, String zEntityId, String accessToken){
		if(!mapRollBackProcess.containsKey('02_REFUNDACTION')){
			mapRollBackProcess.put('02_REFUNDACTION', new list<map<String, Object>>());
		}
		String paymentMethodType = 'Other';
		if(retPayment.get('paymentType') == 'Electronic'){
			paymentMethodType = null;
		}
		mapRollBackProcess.get('02_REFUNDACTION').add(new map<String, Object>{
			'amount' 			=> Decimal.valueOf(retPayment.get('paymentAmount')),
			'zInvoiceId' 		=> invoiceId,
			'zPaymentId' 		=> retPayment.get('paymentId'),
			'zEntityId' 		=> zEntityId,
			'access_token' 		=> accessToken,
			'refundDate' 		=> Util.zDate(Date.today()),
			'paymentType' 		=> retPayment.get('paymentType'),
			'paymentMethodType' => paymentMethodType,
			'reasonCode' 		=> 'Standard Refund',
			'comment' 			=> 'RollBack'
		});
	}
    
    public static void ThrowError(String Err)
    {
        throw new MyCustomException(Err);
    }


}