public with sharing class SM_Remboursement_010819 {

    //TODO: Creation Case Remboursement suite a une migration par trigger : cf. Spec API 17.6 et 18.5
    public static void Remboursement(Id ddeId) {
    	system.debug('##MNE SM_Remboursement Remboursement ddeId >> '+ddeId);
    	
    	Case dem = SM_Demande.getDemande(ddeId);

        if (dem.Subscription__c == null) {
            throw new MyException('Abonnement absent de la demande: pas dabo, plusieurs ou inactif');
        }
        
        executeRemboursement(dem, dem.AccountId, dem.Subscription__c, null, false);

        //Fermeture de la demande
        dem.Status = 'Fermee';
        update dem;

    }
    
    
    public static void executeRemboursement(Case dem, Id accId, Id subscriptionId, String zPaymentId, Boolean fromOnglet) {
    	system.debug('##MNE SM_Remboursement executeRemboursement dem >> '+dem);
    	system.debug('##MNE SM_Remboursement executeRemboursement accId >> '+accId);
    	system.debug('##MNE SM_Remboursement executeRemboursement subscriptionId >> '+subscriptionId);
    	system.debug('##MNE SM_Remboursement executeRemboursement zPaymentId >> '+zPaymentId);
    	system.debug('##MNE SM_Remboursement executeRemboursement fromOnglet >> '+fromOnglet);
        
        String zuoraPaymentId;
        if(fromOnglet){
        	zuoraPaymentId = zPaymentId;
        } else {
        	zuoraPaymentId = dem.Payment__r.Zuora__EXT_ID__c;
        }
        
        system.debug('##MNE SM_Remboursement executeRemboursement zuoraPaymentId >> '+zuoraPaymentId);
        
        
        Zuora__Subscription__c sub = SM_Subscription.getSubscription(subscriptionId);
    	Account acc = SM_Account.getAccount(accId);
    	String zEntityId = WS001_CallZuora.getZuoraEntityId(acc.CodePays__c); 
    	
        //WSZ.PaymentPartsOut paymentPart = SM_Payment.getPaymentPart(zuoraPaymentId, zEntityId); 
      

        //Check Credit memo
        String targetDateCreditMemo=null;
        String creditMemoDate = null;
        if(dem.CreditMemoId__c != null){
            WSZ.CreditMemoOut cm = SM_CreditMemo.getCreditMemo(dem.CreditMemoId__c, zEntityId);
            targetDateCreditMemo = cm.targetDate;
            creditMemoDate = cm.creditMemoDate;
                        
            Decimal amountCreditMemo = Decimal.valueOf(cm.amount);
            if(dem.MontantRembourser__c > amountCreditMemo){
                throw new MyException('Impossible d\'appliquer le credit memo : montant du remboursement superieur au montant du credit memo');
            }

            if(Date.parse(creditMemoDate.substring(8,10)+'/'+creditMemoDate.substring(5,7)+'/'+creditMemoDate.substring(0,4)) > Date.today()){
                throw new MyException('Impossible d\'appliquer le credit memo : la date cible est supérieure à aujourd\'hui');
            }

        }


        String invoiceId = verifRemboursement(dem, acc, sub, fromOnglet,zEntityId, zuoraPaymentId);
    	  	
    	
    	//MethodType
        String methodTypeRefund = 'Other';
        //refund
        String typeRefund = 'External';
        //refund Date
        String refundDate = Util.zDate(dem.DateDeRemboursement__c);
        String creditDate = Util.zDate(dem.DateDeRemboursement__c);

        /*
        public class FinanceInformation {
        public String bankAccountAccountingCode;
        public String bankAccountAccountingCodeType;
        public String unappliedPaymentAccountingCode;
        public String unappliedPaymentAccountingCodeType;
        public String onAccountAccountingCode;
        public String onAccountAccountingCodeType;
        public String transferredToAccounting;
    }*/


        //WSZ.FinanceInformation fI = new WSZ.FinanceInformation();
        //fi.transferredToAccounting = 'No';

        switch on dem.Moyen_de_paiement_souhait__c {
           when 'Virement (UI)','Virement (UU)' {
               methodTypeRefund = 'WireTransfer' ;
               //fI.bankAccountAccountingCode = '512000 - Virement (??)';
               //fI.unappliedPaymentAccountingCode =  '411900 - Créances';
           }
           when 'CB (UI)','CB (UU)' {
               methodTypeRefund = 'CreditCard' ;
               //fI.bankAccountAccountingCode = '512000 - Encaissements CB';
               //fI.unappliedPaymentAccountingCode =  '411900 - Créances';
           }
           when 'Chèque (UI)','Chèque (UU)' {
               methodTypeRefund = 'Check' ;

           }            
           when 'Prélèvement (UI)','Prélèvement (UU)' {
               methodTypeRefund = null ;
               typeRefund = 'Electronic';
               refundDate = null;
               //fI.bankAccountAccountingCode = '471400 - Encaissements Prélèvement';
               //fI.unappliedPaymentAccountingCode =  '411900 - Créances';
           }
        }

        system.debug('##ECH SM_Remboursement executeRemboursement typeRefund >> '+typeRefund);
        

        //Unaply payment
    	unapplyPayment(dem.MontantRembourser__c, invoiceId, zuoraPaymentId, zEntityId);  
       

    	//String methodTypeRefund = 'Other';
    	String reasonCodeRefund = 'Standard Refund';
    	
        String comment = dem.Raison_remboursement__c;
    	
        //Exécution du remboursement
        try{
            WSZ.RefundOut refOut = executeRefund(refundDate, dem.MontantRembourser__c, typeRefund, methodTypeRefund, reasonCodeRefund, zuoraPaymentId, zEntityId,comment);
        	//Si erreur du remboursement, reapplication du paiemment
            if(refOut.status=='Error' || !refOut.success){
                throw new MyException(refOut.gatewayResponse);
            }
        }
        catch(Exception excep){
            //Reaply payment
            applyPayment(dem.MontantRembourser__c, invoiceId, zuoraPaymentId, zEntityId);  
            throw new MyException(excep.getMessage());

        }
        

    	//apply Credit memo
    	if(dem.CreditMemoId__c != null){
      		applyCreditMemo(targetDateCreditMemo, dem.MontantRembourser__c, invoiceId, dem.CreditMemoId__c, zEntityId);
    	}
    	else {
    		//Create Credit Memo

            //Get Invoice items for Credit Memo to initialize Credit Memo Items
            WSZ.InvoiceItemsOut gInvoiceItemsOut = getInvoiceItems(invoiceId, zEntityId);
            List<WSZ.CreateCreditMemoInItem> lstCreditMemoInItem = new List<WSZ.CreateCreditMemoInItem>();

            for(WSZ.InvoiceItem invoiceItem : gInvoiceItemsOut.invoiceItems){
                if(invoiceItem.chargeAmount == dem.MontantRembourser__c)
                {
                    WSZ.CreateCreditMemoInItem creditMemoInItem = new WSZ.CreateCreditMemoInItem();
                    creditMemoInItem.amount = dem.MontantRembourser__c;
                    creditMemoInItem.invoiceItemId = invoiceItem.id;
                    creditMemoInItem.skuName = invoiceItem.chargeName;

                    for(WSZ.taxationItemsdata invoiceItemData : invoiceItem.taxationItems.data){
                        system.debug('##ECH SM_Remboursement executeRemboursement chargeAmount >> '+invoiceItem.chargeAmount);
                        system.debug('##ECH SM_Remboursement executeRemboursement taxName >> '+invoiceItemData.name);    
                        system.debug('##ECH SM_Remboursement executeRemboursement taxAmount >> '+invoiceItemData.taxAmount);
        
                        WSZ.CreditTaxationItemIn creditTaxItemIn = new WSZ.CreditTaxationItemIn();
                        creditTaxItemIn.amount = invoiceItemData.taxAmount;
                        creditTaxItemIn.taxName = invoiceItemData.name;
                        creditTaxItemIn.taxDate = invoiceItemData.taxDate;
                        creditTaxItemIn.taxRate = invoiceItemData.taxRate;
                        creditTaxItemIn.taxExemptAmount = invoiceItemData.exemptAmount;
                        creditTaxItemIn.taxRateType = invoiceItemData.taxRateType;
                        creditTaxItemIn.taxRateDescription = invoiceItemData.taxRateDescription;
                        creditTaxItemIn.taxCodeDescription = invoiceItemData.taxCodeDescription;
                        creditTaxItemIn.taxCode = invoiceItemData.taxCode;
                        creditTaxItemIn.locationCode = invoiceItemData.locationCode;
                        creditTaxItemIn.jurisdiction = invoiceItemData.jurisdiction;
                        creditTaxItemIn.sourceTaxItemId = invoiceItemData.id;

                        creditMemoInItem.taxItems.add(creditTaxItemIn);
                    }

                    lstCreditMemoInItem.add(creditMemoInItem);
                    break;
                }
            }

            if(lstCreditMemoInItem.isEmpty())
            {
                Double refundAmount = dem.MontantRembourser__c;

                System.debug('##ECH SM_Remboursement executeRemboursement refundAmount origine >> '+refundAmount);
                
                for(WSZ.InvoiceItem invoiceItem : gInvoiceItemsOut.invoiceItems){
                    if(refundAmount>0)
                    {
                        WSZ.CreateCreditMemoInItem creditMemoInItem = new WSZ.CreateCreditMemoInItem();
                        creditMemoInItem.invoiceItemId = invoiceItem.id;
                        creditMemoInItem.skuName = invoiceItem.chargeName;
                        if (refundAmount>invoiceItem.chargeAmount){
                            creditMemoInItem.amount = invoiceItem.chargeAmount;
                            refundAmount = refundAmount - invoiceItem.chargeAmount;
                        }else{
                            creditMemoInItem.amount = refundAmount;
                            refundAmount = 0;
                        }
                        
                        System.debug('##ECH SM_Remboursement executeRemboursement invoiceItem.chargeAmount >> '+invoiceItem.chargeAmount);
                        System.debug('##ECH SM_Remboursement executeRemboursement invoiceItem.chargeAmount >> '+creditMemoInItem.amount);
						System.debug('##ECH SM_Remboursement executeRemboursement refundAmount >> '+refundAmount);
                        
                        for(WSZ.taxationItemsdata invoiceItemData : invoiceItem.taxationItems.data){
                            system.debug('##ECH SM_Remboursement executeRemboursement chargeAmount >> '+invoiceItem.chargeAmount);    
                            system.debug('##ECH SM_Remboursement executeRemboursement taxName >> '+invoiceItemData.name);    
                            system.debug('##ECH SM_Remboursement executeRemboursement taxAmount >> '+invoiceItemData.taxAmount);
                            
                            WSZ.CreditTaxationItemIn creditTaxItemIn = new WSZ.CreditTaxationItemIn();
                            creditTaxItemIn.amount = invoiceItemData.taxAmount;
                            creditTaxItemIn.taxName = invoiceItemData.name;
                            creditTaxItemIn.taxDate = invoiceItemData.taxDate;
                            creditTaxItemIn.taxRate = invoiceItemData.taxRate;
                            creditTaxItemIn.taxExemptAmount = invoiceItemData.exemptAmount;
                            creditTaxItemIn.taxRateType = invoiceItemData.taxRateType;
                            creditTaxItemIn.taxRateDescription = invoiceItemData.taxRateDescription;
                            creditTaxItemIn.taxCodeDescription = invoiceItemData.taxCodeDescription;
                            creditTaxItemIn.taxCode = invoiceItemData.taxCode;
                            creditTaxItemIn.locationCode = invoiceItemData.locationCode;
                            creditTaxItemIn.jurisdiction = invoiceItemData.jurisdiction;
                            creditTaxItemIn.sourceTaxItemId = invoiceItemData.id;

                            creditMemoInItem.taxItems.add(creditTaxItemIn);
                        }
                        
                        lstCreditMemoInItem.add(creditMemoInItem);
                    }

                }
            }

            System.debug('##ECH SM_Remboursement executeRemboursement lstCreditMemoInItem >> '+lstCreditMemoInItem);
               	
            //Create Credit Memo
            WSZ.CreditMemoOut creditMemoOut = createCreditMemo(creditDate, dem.MontantRembourser__c, invoiceId, zEntityId,lstCreditMemoInItem);
            
            //Post Credit Memo
            postCreditMemo(creditMemoOut,zEntityId);

            //Apply Credit Memo
            applyCreditMemo(creditDate, dem.MontantRembourser__c, invoiceId, creditMemoOut.Id, zEntityId);
        
        }
    	
    	//update 
    }
    
    @AuraEnabled
    public static WRPInt ongletRemboursement(Case caseRecord, Id caseId) {
        System.debug('##MNE SM_Remboursement ongletRemboursement caseRecord >> '+caseRecord);
        System.debug('##MNE SM_Remboursement ongletRemboursement caseId >> '+caseId);
        
        WRPInt rep = new WRPInt();  
        
        try{
        	Case c = [SELECT Id, AccountId, Subscription__c, DateDemande__c FROM Case WHERE Id = :caseId LIMIT 1];
	        Zuora__Payment__c payment = [SELECT Id, Zuora__EXT_ID__c  FROM Zuora__Payment__c WHERE Id = :caseRecord.Payment__c LIMIT 1];
	        Id accId = c.AccountId;
	        String zPaymentId = payment.Zuora__EXT_ID__c;
	        
	        System.debug('##MNE SM_Remboursement ongletRemboursement Case c >> '+c);
	        System.debug('##MNE SM_Remboursement ongletRemboursement payment >> '+payment);
	        System.debug('##MNE SM_Remboursement ongletRemboursement zPaymentId >> '+zPaymentId);
	        
	        executeRemboursement(caseRecord, accId, c.Subscription__c, zPaymentId, true);
	        
            //creataion du nouveau case
            /*Id remboursementRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Remboursement').getRecordTypeId();
            Case cTMP = new Case();
            cTMP.Payment__c = caseRecord.Payment__c;
            cTMP.MontantRembourser__c = caseRecord.MontantRembourser__c;
            cTMP.MontantRemboursementCalc__c = caseRecord.MontantRembourser__c;
            cTMP.DateDeRemboursement__c = caseRecord.DateDeRemboursement__c;
            cTMP.AccountId = accId;
            cTMP.ParentId = caseId;
            cTMP.RemboursementFaire__c = true;
            cTMP.RecordTypeId = remboursementRecordTypeId;
            cTMP.Famille__c = '7- Finance';
 			cTMP.Motif__c = '04- Remboursement';
            insert cTMP; */ 
            
            Id caseRemboursementId = createRebousementCase(caseId, caseRecord.MontantRembourser__c, caseRecord.MontantRembourser__c, accId, null, null, caseRecord.Payment__c, caseRecord.DateDeRemboursement__c);   
            //rep.caseIdToRedirect = cTMP.Id;
            rep.caseIdToRedirect = caseRemboursementId;
            rep.accountIdToRedirect = accId;
            
        } catch(Exception e){
        	rep.showMessage = true;
	        rep.messageToDisplay = e.getMessage();
	        return rep;
        }
        
        return rep;
    }
    
    
    private static String verifRemboursement(Case dem, Account acc, Zuora__Subscription__c sub, Boolean fromOnglet, String zEntityId, String zuoraPaymentId ) {

        if (!fromOnglet && dem.Status == SM_Demande.getStatus('Fermee')) {
            throw new MyException('Cette demande a deja ete traite');
        }

        if (!fromOnglet && dem.SousMotif__c == null) { //TODO peut etre a mettre au niveau parametrage AVOIR
            throw new MyException('Sous-Motif obligatoire');
        }
        
        if (dem.Payment__c == null) {
            throw new MyException('Payment obligatoire');
        }
        
        if (dem.MontantRembourser__c == null) {
            throw new MyException('Montant à rembourser obligatoire');
        }
        
        if (!fromOnglet && dem.MontantRemboursementCalc__c != null && dem.CreditMemoId__c != null  && dem.MontantRembourser__c != dem.MontantRemboursementCalc__c) {
            throw new MyException('Une credit memo existe sur se compte : le montant du remboursement doit etre égale au montant du credit memo');
        }
        
        if (dem.DateDeRemboursement__c == null) {
            throw new MyException('Date de remboursement obligatoire');
        }

        
        WSZ.PaymentPartsOut paymentPart = SM_Payment.getPaymentPart(zuoraPaymentId, zEntityId); 
        String invoiceId = paymentPart.parts.get(0).invoiceId; 
        system.debug('##MNE SM_Remboursement Remboursement paymentPart >> '+paymentPart);
        if(paymentPart == null || paymentPart.parts == null || paymentPart.parts.size() == 0 || String.isBlank(paymentPart.parts.get(0).invoiceId)){
            throw new MyException('Pas de facture trouvé pour le payment choisi');
        }
        
        String checkPayment = checkPayment(dem.Payment__c, dem.Moyen_de_paiement_souhait__c, dem.MontantRembourser__c, invoiceId, zEntityId);

        if(checkPayment == 'MethodKO'){
            throw new MyException('Le type du paiement sélectionné doit être électronique lorsque le moyen de paiement du remboursement est Prélèvement.');
        }

        if(checkPayment == 'AmountKO'){
            throw new MyException('Le montant du remboursement ne peut être supérieur à celui du paiement sélectionné.');
        }

        if(checkPayment == 'MinDelayKO'){
            throw new MyException('Le paiment doit êtré daté à plus de 4 jours ouvrés.');
        }

        return invoiceId;
        
    }
    

    public static Id createRebousementCase(Id originCaseId, Decimal montantARembourser, Decimal montantARembourserFromCreditMemo, Id accountId, String creditMemoId, Date dateResiliation, Id paymentId, Date remboursementDate){
        Id remboursementRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Remboursement').getRecordTypeId();
        Case c = new Case();
        c.ParentId = originCaseId;
        c.MontantRembourser__c = montantARembourser;
        
        if(montantARembourser==null || montantARembourser==0){
            c.MontantRembourser__c = montantARembourserFromCreditMemo;
        }
        
        c.MontantRemboursementCalc__c = montantARembourserFromCreditMemo;
        c.RemboursementFaire__c = true;
        c.RecordTypeId = remboursementRecordTypeId;
        c.AccountId = accountId;
        c.CreditMemoId__c = creditMemoId;
        c.Famille__c = '7- Finance';
 		c.Motif__c = '04- Remboursement';
 		//c.DateFinContrat__c = dateResiliation;
 		c.Payment__c = paymentId;
 		c.DateDeRemboursement__c = remboursementDate;
        //c.MontantRembourser__c
        //c.RemboursementValeur__c
        //c.TypeRemboursement__c
        //c.DemandeRemboursement__c = VLO || Réservations autres || UGCIllimité || UGCUnlimited 
        insert c;
        return c.Id;
    }
    
     public static void unapplyPayment(Decimal amountUnapply, String zInvoiceId, String zPaymentId, String zEntityId) {
     	System.debug('##MNE SM_Remboursement unapplyPayment amountUnapply >> ' + amountUnapply);
     	System.debug('##MNE SM_Remboursement unapplyPayment zInvoiceId >> ' + zInvoiceId);
     	System.debug('##MNE SM_Remboursement unapplyPayment zPaymentId >> ' + zPaymentId);
     	System.debug('##MNE SM_Remboursement unapplyPayment zEntityId >> ' + zEntityId);
     	
        String endpoint = '/v1/payments/'+zPaymentId+'/unapply';
        String method = 'PUT';
        String wsIn = '';
        String wsOut = '';

        // Retrieve Zuora token
        String accessToken = WS001_CallZuora.access_token;

        // Call WS
        WSZ.UnapplyPaymentIn wsInObj = new WSZ.UnapplyPaymentIn();
        WSZ.UnapplyPaymentInItem wsInObjItem = new WSZ.UnapplyPaymentInItem();
        wsInObjItem.amount = amountUnapply;
        wsInObjItem.invoiceId = zInvoiceId;
        wsInObj.invoices.add(wsInObjItem);
        
        wsIn = (String) JSON.serialize(wsInObj);

        System.debug('##MNE SM_Remboursement unapplyPayment wsIn >> ' + wsIn);
        wsOut = WS001_CallZuora.sendRequest(accessToken, endpoint, zEntityId, method, wsIn, 'type1', '211.0');
        System.debug('##MNE SM_Remboursement unapplyPayment wsOut >> ' + wsOut);
	}

    public static void applyPayment(Decimal amountUnapply, String zInvoiceId, String zPaymentId, String zEntityId) {
        System.debug('##ECH SM_Remboursement applyPayment amountUnapply >> ' + amountUnapply);
        System.debug('##ECH SM_Remboursement applyPayment zInvoiceId >> ' + zInvoiceId);
        System.debug('##ECH SM_Remboursement applyPayment zPaymentId >> ' + zPaymentId);
        System.debug('##ECH SM_Remboursement applyPayment zEntityId >> ' + zEntityId);
        
        String endpoint = '/v1/payments/'+zPaymentId+'/apply';
        String method = 'PUT';
        String wsIn = '';
        String wsOut = '';

        // Retrieve Zuora token
        String accessToken = WS001_CallZuora.access_token;

        // Call WS
        WSZ.UnapplyPaymentIn wsInObj = new WSZ.UnapplyPaymentIn();
        WSZ.UnapplyPaymentInItem wsInObjItem = new WSZ.UnapplyPaymentInItem();
        wsInObjItem.amount = amountUnapply;
        wsInObjItem.invoiceId = zInvoiceId;
        wsInObj.invoices.add(wsInObjItem);
        
        wsIn = (String) JSON.serialize(wsInObj);

        System.debug('##ECH SM_Remboursement applyPayment wsIn >> ' + wsIn);
        wsOut = WS001_CallZuora.sendRequest(accessToken, endpoint, zEntityId, method, wsIn, 'type1', '211.0');
        System.debug('##ECH SM_Remboursement applyPayment wsOut >> ' + wsOut);
    }


	
	public static WSZ.RefundOut executeRefund(String refundDate, Decimal totalAmount, String typeX, String methodType, String reasonCode, String zPaymentId, String zEntityId, String comment) {
    	System.debug('##MNE SM_Remboursement executeRefund refundDate >> ' + refundDate);
    	System.debug('##MNE SM_Remboursement executeRefund totalAmount >> ' + totalAmount);
    	System.debug('##MNE SM_Remboursement executeRefund typeX >> ' + typeX);
    	System.debug('##MNE SM_Remboursement executeRefund methodType >> ' + methodType);
    	System.debug('##MNE SM_Remboursement executeRefund reasonCode >> ' + reasonCode);
    	System.debug('##MNE SM_Remboursement executeRefund zPaymentId >> ' + zPaymentId);
    	System.debug('##MNE SM_Remboursement executeRefund zEntityId >> ' + zEntityId);
    	
        String endpoint = '/v1/payments/'+zPaymentId+'/refunds';
        String method = 'POST';
        String wsIn = null;
        String wsOut = '';
        
        // Retrieve Zuora token
        String accessToken = WS001_CallZuora.access_token;
        
        //Date todayDate = Date.today();
        //String zTodayDate = Util.zDate(todayDate);
        /*if(refundDate == null){
            wsInObj.refundDate = zTodayDate;
        }else{
            wsInObj.refundDate = refundDate;
        }*/
        WSZ.RefundlIn wsInObj = new WSZ.RefundlIn();
        wsInObj.typeX = typeX;
        wsInObj.methodType = methodType;
        wsInObj.reasonCode = reasonCode;
        wsInObj.refundDate = refundDate;
        wsInObj.totalAmount = totalAmount;
        wsInObj.comment = comment;
        //wsInObj.financeInformation = financeInformation;
        
        
        
        wsIn = (String) JSON.serialize(wsInObj);
        wsIn = wsIn.replace('typeX','type');
        //wsIn = wsIn.replace('"reasonCode":null,','');
        //wsIn = wsIn.replace('"reasonCode":null','');
        
        System.debug('##MNE SM_Remboursement executeRefund wsIn >> ' + wsIn);
        wsOut = WS001_CallZuora.sendRequest(accessToken, endpoint, zEntityId, method, wsIn, 'type1', '211.0');
        wsOut = wsOut.replace('number','numberX');
        wsOut = wsOut.replace('type','typeX');
        wsOut = wsOut.replace('Canal__c','Canal');
        wsOut = wsOut.replace('TECH_RefundGatewayResponseCode__c','TECH_RefundGatewayResponseCode');
        wsOut = wsOut.replace('DateRejetBanque__c','DateRejetBanque');
        wsOut = wsOut.replace('Agent__c','Agent');
        wsOut = wsOut.replace('TECH_DejaTraiter__c','TECH_DejaTraiter');
        wsOut = wsOut.replace('Lieu__c','Lieu');
        wsOut = wsOut.replace('TECH_RefundCreatedDate__c','TECH_RefundCreatedDate');

        System.debug('##MNE SM_Remboursement executeRefund wsOut >> ' + wsOut);
    
        return (WSZ.RefundOut) JSON.deserializeStrict(wsOut, WSZ.RefundOut.class);

    }


    public static WSZ.CreditMemoOut createCreditMemo(String effectiveDate, Decimal amount, String zInvoiceId, String zEntityId, List<WSZ.CreateCreditMemoInItem> invoiceItemsIn) {
        System.debug('##MNE SM_Remboursement createCreditMemo effectiveDate >> ' + effectiveDate);
        System.debug('##MNE SM_Remboursement createCreditMemo amount >> ' + amount);
        System.debug('##MNE SM_Remboursement createCreditMemo zInvoiceId >> ' + zInvoiceId);
        System.debug('##MNE SM_Remboursement createCreditMemo zEntityId >> ' + zEntityId);
        
        String endpoint = '/v1/invoices/'+zInvoiceId+'/creditmemos';
        String method = 'POST';
        String wsIn = '';
        String wsOut = '';

        // Retrieve Zuora token
        String accessToken = WS001_CallZuora.access_token;

        // Call WS
        WSZ.CreateCreditMemoIn wsInObj = new WSZ.CreateCreditMemoIn();
        wsInObj.effectiveDate = effectiveDate;
        wsInObj.autoApplyToInvoiceUponPosting = false;
        wsInObj.taxAutoCalculation = false;
        wsInObj.items = invoiceItemsIn;
        
        System.debug('##MNE SM_Remboursement createCreditMemo invoiceItemsIn >> ' + invoiceItemsIn);
        
        wsIn = (String) JSON.serialize(wsInObj);

        System.debug('##MNE SM_Remboursement createCreditMemo wsIn >> ' + wsIn);
        wsOut = WS001_CallZuora.sendRequest(accessToken, endpoint, zEntityId, method, wsIn, 'type1', '211.0');
        wsOut = wsOut.replace('number','numberX');

        System.debug('##MNE SM_Remboursement createCreditMemo wsOut >> ' + wsOut);

        return (WSZ.CreditMemoOut) JSON.deserializeStrict(wsOut, WSZ.CreditMemoOut.class);

    }

    public static void postCreditMemo(WSZ.CreditMemoOut creditMemoOut, String zEntityId) {
        System.debug('##ECH SM_Remboursement postCreditMemo creditMemoOut >> ' + creditMemoOut);
        System.debug('##ECH SM_Remboursement postCreditMemo zEntityId >> ' + zEntityId);
        String endpoint = '/v1/creditmemos/'+creditMemoOut.id+'/post';
        String method = 'PUT';
        String wsIn = null;
        String wsOut = '';

        // Retrieve Zuora token
        String accessToken = WS001_CallZuora.access_token;

        System.debug('##ECH SM_Remboursement postCreditMemo wsIn >> ' + wsIn);
        wsOut = WS001_CallZuora.sendRequest(accessToken, endpoint, zEntityId, method, wsIn, 'type1', '211.0');
        System.debug('##ECH SM_Remboursement postCreditMemo wsOut >> ' + wsOut);

    }

    public static void applyCreditMemo(String effectiveDate, Decimal amount, String zInvoiceId, String zCrediMemoId, String zEntityId) {
     	System.debug('##MNE SM_Remboursement applyCreditMemo effectiveDate >> ' + effectiveDate);
     	System.debug('##MNE SM_Remboursement applyCreditMemo amount >> ' + amount);
     	System.debug('##MNE SM_Remboursement applyCreditMemo zInvoiceId >> ' + zInvoiceId);
     	System.debug('##MNE SM_Remboursement applyCreditMemo zCrediMemoId >> ' + zCrediMemoId);
     	System.debug('##MNE SM_Remboursement applyCreditMemo zEntityId >> ' + zEntityId);
     	
        String endpoint = '/v1/creditmemos/'+zCrediMemoId+'/apply';
        String method = 'PUT';
        String wsIn = '';
        String wsOut = '';

        // Retrieve Zuora token
        String accessToken = WS001_CallZuora.access_token;

        // Call WS
        WSZ.ApplyCreditMemoIn wsInObj = new WSZ.ApplyCreditMemoIn();
        wsInObj.effectiveDate = effectiveDate;
        WSZ.UnapplyPaymentInItem wsInObjItem = new WSZ.UnapplyPaymentInItem();
        wsInObjItem.amount = amount;
        wsInObjItem.invoiceId = zInvoiceId;
        wsInObj.invoices.add(wsInObjItem);
        
        wsIn = (String) JSON.serialize(wsInObj);

        System.debug('##MNE SM_Remboursement applyCreditMemo wsIn >> ' + wsIn);
        wsOut = WS001_CallZuora.sendRequest(accessToken, endpoint, zEntityId, method, wsIn, 'type1', '211.0');
        System.debug('##MNE SM_Remboursement applyCreditMemo wsOut >> ' + wsOut);
	}


    public static WSZ.InvoiceItemsOut getInvoiceItems(String zInvoiceId, String zEntityId) {
        System.debug('##ECH SM_Remboursement getInvoiceItems zInvoiceId >> ' + zInvoiceId);
        System.debug('##ECH SM_Remboursement getInvoiceItems zEntityId >> ' + zEntityId);
        
        String endpoint = '/v1/invoices/'+zInvoiceId+'/items';
        String method = 'GET';
        String wsIn = null;
        String wsOut = '';

        // Retrieve Zuora token
        String accessToken = WS001_CallZuora.access_token;

        System.debug('##ECH SM_Remboursement getInvoiceItems wsIn >> ' + wsIn);
        wsOut = WS001_CallZuora.sendRequest(accessToken, endpoint, zEntityId, method, wsIn, 'type1', '211.0');
        System.debug('##ECH SM_Remboursement getInvoiceItems wsOut >> ' + wsOut);

        return (WSZ.InvoiceItemsOut) JSON.deserializeStrict(wsOut, WSZ.InvoiceItemsOut.class);
    }

    	
	private class MyException extends Exception {
	}
	
	public without sharing class WRPInt {
        @AuraEnabled public Boolean showMessage                         { get; set; }
        @AuraEnabled public String  messageToDisplay                    { get; set; }
        @AuraEnabled public Id  caseIdToRedirect                    	{ get; set; }
        @AuraEnabled public Id  accountIdToRedirect                    	{ get; set; }
        
        public WRPInt() {
            this.showMessage            = false;
            this.messageToDisplay       = '';
            this.caseIdToRedirect       = null;
            this.accountIdToRedirect    = null;
        }
    }


    public static String checkPayment(ID paymentId, String paymentMethod, Decimal refundAmount, String invoiceId, String zEntityId) {
        
        if (paymentId<>null){
            List<Zuora__Payment__c> zPayment = [Select Zuora__Type__c, Zuora__Amount__c,Zuora__Effective_Date__c from Zuora__Payment__c where Id=:paymentId LIMIT 1];
            if(!zPayment.isEmpty()){
                if(zPayment[0].Zuora__Amount__c < refundAmount){
                    return 'AmountKO';
                }

                if(zPayment[0].Zuora__Type__c <> 'Electronic' && (paymentMethod == 'Prélèvement (UI)' || paymentMethod =='Prélèvement (UU)')){
                    return 'MethodKO';
                }

                if(!checkMinDelay(Date.today(),zPayment[0].Zuora__Effective_Date__c,5))
                    return 'MinDelayKO';
            }
        }


        WSZ.InvoiceItemsOut gInvoiceItemsOut = getInvoiceItems(invoiceId, zEntityId);
        List<WSZ.CreateCreditMemoInItem> lstCreditMemoInItem = new List<WSZ.CreateCreditMemoInItem>();

        Decimal invoiceTotal = 0;

        for(WSZ.InvoiceItem invoiceItem : gInvoiceItemsOut.invoiceItems){
            invoiceTotal = invoiceTotal + invoiceItem.chargeAmount;
        }

        if(invoiceTotal<refundAmount) 
            return 'InvoiceKO'; 

        return 'OK';
    }


    public static Boolean checkMinDelay(Date date1, Date date2, Integer nbDays){

        Double openDays  = (5*(Math.Floor((date.newInstance(1900,1,8).daysBetween(date1))/7))+Math.min(5,Math.Mod(date.newInstance(1900,1,8).daysBetween(date1),7))) - (5*(Math.Floor((date.newInstance(1900,1,8).daysBetween(date2))/7))+Math.Min(5,Math.Mod(date.newInstance(1900,1,8).daysBetween(date2),7)));
        if(openDays>=nbDays)
        return true;
        else
        return false;
        
    }



}