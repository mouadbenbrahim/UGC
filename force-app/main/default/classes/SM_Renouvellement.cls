public with sharing class SM_Renouvellement {

    public final static Set<String> FAMILLE_REMISES = new Set<String>{'REMFRAIDOSS', 'REMMENS', 'REMMONT'};
    public static String accessToken, zEntityId, codePays;
    public static ProcessLog__c pLog;
    private static Boolean isRemoveAddAbo = false, isPreview;

    public SM_Renouvellement(){

    }

    public static Map<String,Object> renouvellement(WSZ.SubOpeIn renouvIn, Boolean l_isPreview) {
    	
	    //TODO: OK (emmanuel zuora): Renew d'un CDD ayant eu un gestco  extension de term de + x mois.
	    //TODO: OK: renouvellement CDD-CDI : pas d engagement pour le CDI: il faut clarifier la notion de l engagement vis a vis du desabo et du rglt impaye
	    //TODO Abandonne: renouvellement CDD-CDD : pas d'engagement pour le nouveau CDD càd : desabo -> impossible
	    //TODO FUTUR gerer des templateID: B2B/FRANCE, Belgique: FR-FR - FR-NL
	    isPreview = l_isPreview;
	    
	    Map<String,Object> returnObj = new Map<String,Object>();
	    WSZ.Preview previewOut = new WSZ.Preview(); 
	    WSZ.SubOpeOut renouvOut = new WSZ.SubOpeOut(); 
	    zc_ZObjectUpdate zObj;
	    List<String> sDocjobIds = new List<String>{'idjob1','idjob2'};
	    List<String> paymentIds = new List<String>();
	
	    Boolean compteBloque = false, rembourser = false;
	    Date renewDateCE,dateFinContrat,dateFinEngagement;     
	    String currentSubId, invoiceFileUrl,elecPayMethodId,extPaymentMethodId,payMethodId; 
	    String caseId,invoiceId,fileImpId,zDocId;
	    String renouvInStr = JSON.serialize(renouvIn);
	    Map<String,WSZ.Paiement> mapPaiements = new Map<String,WSZ.Paiement>();  // key=refCharge 
	    Map<String,WSZ.Paiement> mapPaiements2 = new Map<String,WSZ.Paiement>();  // key=methodPaiement: si deux paiements de meme method et meme reference, alors c'un seul, on cumul le montant.
	    List<BillingOperation__c> billOpes = new List<BillingOperation__c>();
	    
	    Map<String,List<Map<String,Object>>> mapRollBackProcess = new Map<String,List<Map<String,Object>>>();
        Boolean isDMLoperation = false;
	
	    try {
	    
		
		    // ## init
		    String typeContrat = (renouvIn.produit.contains('CDI')?'CDI':'CDD');    
		    
		    pLog = new ProcessLog__c(Process__c = 'renouvellement', Account__c = renouvIn.accountSFID, Message__c = renouvInStr);
		    //Boolean isNewMandate = (renouvIn.mandateId != null && renouvIn.iban != null);
		
		
		    //###### get Account Data ######
		    Account porteur = SM_Account.getAccountData(renouvIn.accountSFID);
		    Account payeur = SM_Account.getAccountData(renouvIn.payeurSFID);
		    //###### get Subscription Data ######
		    Zuora__Subscription__c sub = SM_Subscription.getSubscriptionBySetName(new Set<String>{renouvIn.subscriptionName}).get(0);
		    currentSubId = sub.Zuora__External_Id__c;
		    String originalSubId = sub.Zuora__External_Id__c;
		    String accountZID = sub.Zuora__CustomerAccount__r.Zuora__External_Id__c;
		    String subscriptionName = sub.Name;
		    String typeContratActuel = sub.TypeContrat__c;
		    String typeRenouvellement = typeContratActuel+'-'+typeContrat;    
		    codePays = porteur.CodePays__c;
		    
		    String paysLibelle = Util.paysLibelle(codePays);
		
		    //isRemoveAddAbo : contrat CDD ayant eu un gestco d'extension de term qui necessite un remove/add product
		    //removeAddAbo (si abo contient gestco= current term != renewal term, attention au cas bilendi): -> non choisi
		    //ou si abo contient gestco= current term != renewal term, : -> non choisit
		    // ou  --> Zuora__ChargedThroughDate__c != Zuora__ProcessedThroughDate__c (sur la derniere version de l'abo sur subscriptionProdCharge)
		    //TODO: tester cas bilendi (term en days)
		    if (typeContrat == 'CDD'){
		        Set<String> rpcs = new Set<String>();
		        for (ProdRatePlanCharge__c rpc : [Select zid__c from ProdRatePlanCharge__c where FamilleRPC__c = 'ABO']){
		            rpcs.add(rpc.zid__c);
		        }    
		        List<Zuora__SubscriptionProductCharge__c> subCharge = [Select Zuora__ChargedThroughDate__c, Zuora__ProcessedThroughDate__c, Zuora__RatePlanId__c,  Zuora__SubscriptionRatePlan__r.Zuora__OriginalProductRatePlanId__c  
		        from Zuora__SubscriptionProductCharge__c where 
		        Zuora__Subscription__r.Zuora__External_Id__c = :currentSubId AND Zuora__ProductRatePlanChargeId__c in :rpcs];
		        if (subCharge.get(0).Zuora__ChargedThroughDate__c != subCharge.get(0).Zuora__ProcessedThroughDate__c){
		            isRemoveAddAbo = true;
		        }
		    }
		
		    // ###### check/calcul:
		    // calcul latence, dateDebutContrat
		    Integer periodeLatence = Integer.valueOf(Utils.getUgcGenericParam('Periode de latence',codePays).ParamValue__c);
		    Date dateFinContratActuel = sub.Zuora__SubscriptionEndDate__c.addDays(-1);
		    Date dateFinEligibilite =  dateFinContratActuel.addDays(-1).addMonths(periodeLatence);   // date eligibilite inclut
		    Date dateDebutContrat = sub.Zuora__NextRenewalDate__c;
		
		    //Date dateFinContratActuel = sub.Zuora__SubscriptionEndDate__c.addDays(-1);
		
		    if  (dateFinEligibilite < Date.today()) {
		        //TODO Abandonne a remettre: throw new RTException(RTExceptionCode.ERREUR_DESABO_COUPON_ABOTIER,pLog); -> Normalement c un controle au niveau authorisation
		    } else if (dateFinContratActuel < Date.today() && dateFinEligibilite >= Date.today()){
		        //isLatence = true;
		        renewDateCE = dateDebutContrat;
		        //generateInvoice = true;   
		    } else if (dateFinContratActuel >= Date.today()){
		        //generateInvoice = true;
		        renewDateCE = dateDebutContrat;
		    }
		    
		
		    if (typeContrat == 'CDD') {
		        //dateFinContrat = dateDebutContrat.addMonths(12).addDays(-1);
		        //CDD date fin du nouveau contrat
		        Integer renewTerm = Integer.valueOf(sub.Zuora__RenewalTerm__c.remove(' Months'));
		        if (sub.Zuora__RenewalTermPeriodType__c == 'Month' ) {
		            dateFinContrat = sub.Zuora__NextRenewalDate__c.addMonths(renewTerm).addDays(-1); 
		        }
		    } else { //CDI
		        dateFinContrat = null;
		    }
		    
		    //###### get subOffres ######
		    Map<String,Object> offreProxyOut = SM_Offre.getOffreProxy((Datetime)dateDebutContrat, renouvIn.lieu, renouvIn.agent, renouvIn.coupon, renouvIn.accountSFID, 'renouvellement', renouvIn.produit,renouvIn.codeLangue);
		    WSZ.SubProduct subOffre = (WSZ.SubProduct)offreProxyOut.get('offre');
		
		    // check: codeOffreCo
		    if (renouvIn.codeOffreCo != null && renouvIn.codeOffreCo != subOffre.CodeOffreCo) {
		         throw new RTException(RTExceptionCode.ERREUR_RENOUV_COUPON_ABOTIER,pLog);
		    }
		
		    // ###### token/entity
		    ZuoraTokenOut zuoraToken = execZuoraToken(porteur.CodePays__c);
		    accessToken = zuoraToken.accessToken;
		    zEntityId =zuoraToken.zEntityId;
		
		    // ###### ExecAmendRenew for Preview
		    if (isPreview){
		        previewOut = execAmendRenewPreview(dateDebutContrat, renewDateCE, currentSubId, offreProxyOut, typeRenouvellement);  
		        previewOut.dateDebutContrat = dateDebutContrat;
		        previewOut.dateFinContrat = dateFinContrat;
		
		        //TODO , il faut fait un preview different si le contrat initialement a Cancel
		    }else {
		
		    //map external payments
		    if (renouvIn.paiements.size() > 0 ){
		        mapPaiements = new Map<String,WSZ.Paiement>();
		        //List<Paiement> paiements = renouvIn.paiements;
		        for (WSZ.Paiement item:renouvIn.paiements){
		            WSZ.Paiement pai1 = new WSZ.Paiement();
		            WSZ.Paiement pai2 = new WSZ.Paiement();
		            pai1 = item.clone();
		            pai2 = item.clone();
		            mapPaiements.put(item.refCharge,pai1);
		            if (mapPaiements2.containsKey(item.methodePaiement)) {
		                mapPaiements2.get(item.methodePaiement).montant += (Double)item.montant;
		            }else {
		                mapPaiements2.put(item.methodePaiement,pai2);
		            }
		        }
		    }
		    System.debug('MBEN:mapPaiements: ' + mapPaiements);
		    System.debug('MBEN:mapPaiements2: ' + mapPaiements2);
		            
		    //###### Create Elec/Ext PaymentMethod ######
		    PaymentMethodOut pmOut = execCreateGetPaymentMethod(typeContrat, subOffre.IsB2B, mapPaiements.get('ABO').methodePaiement, codePays, renouvIn.iban, renouvIn.mandateId, payeur, accountZID);
		    
		    //###### Update Account DefPaymentMethod, Batch..etc ######
		    execUpdAccount(accountZID, pmOut, typeRenouvellement);
		    //mapRollBackProcess : UPDATEACTION	6
		    
		    // ###### Delete Cancel Sub  (mois de latence): 
		    if (sub.Zuora__Status__c == 'Cancelled' && !isPreview) {
		        //get amend informations before delete
		        zc_GETAmendmentType amendRes = zc_Api.amendSubscriptionGET(accessToken, zEntityId, originalSubId, RTExceptionCode.ERREUR_RENOUV_APPLICATION_CANCEL, pLog);
		        //zc_ProxyGetAmendment amendRes2 = zc_Api.objectAmendGET(accessToken, zEntityId, amendRes.id, RTExceptionCode.ERREUR_IMPAYE_REGLER_PROBLEM_PREVIEW, pLog); 
		
		        zc_SaveResult subDelResult = zc_Api.objectSubscriptionDELETE(accessToken, zEntityId, currentSubId, RTExceptionCode.ERREUR_RENOUV_DELETE_ZSUBSCRIPTION, pLog);
		        //mapRollBackProcess : Cancel Subscription	5
		        currentSubId = subDelResult.id;
		        //TODO TRACKING AMEND
		        //SM_Hermes.trackOperation('SUPPRESSION', Datetime.now(), 'Reactivation', 'DeleteCancel', amendRes.id, originalSubId, subscriptionName, codePays);
		        billOpes.add(new BillingOperation__c(Action__c = 'SUPPRESSION', DateOperation__c = Datetime.now(), Operation__c='Reactivation', Zoperation__c = 'DeleteCancel', 
		        AmendZID__c= amendRes.id, SubscriptionZID__c = originalSubId, SubscriptionName__c = subscriptionName, Pays__c=paysLibelle));
		
		    }
		
		    // ###### ExecAmendRenew
		    AmendRenewReelOut amendRenewOut = execAmendRenewReel(dateDebutContrat, currentSubId, offreProxyOut, typeRenouvellement);
		    String amendId = amendRenewOut.amendId; 
		    invoiceId = amendRenewOut.invoiceId; 
		    currentSubId = amendRenewOut.subId;
			//mapRollBackProcess : Delete Amend Renew 4
		
		
		    // ###### Update Amend (operation)
		    execUpdateAmend(amendId,originalSubId);
		    //mapRollBackProcess : Delete Amend Renew 4
		
		    // ###### Update sub: 
		    execUpdateSub(currentSubId, renouvIn.lieu, renouvIn.agent, renouvIn.produit, mapPaiements.get('ABO').methodePaiement, typeContrat, dateFinContrat, originalSubId);
		    //mapRollBackProcess : Update Subscription to previsous values 3
		
		    //###### get invoice ######
		    zc_ProxyGetInvoice invRes = zc_Api.objectInvoiceGET(accessToken, zEntityId, invoiceId, RTExceptionCode.ERREUR_RENOUV_GET_INVOICE, pLog);
		    Double invAmount = invRes.amount;
		
		    //###### get invoice File ######
		    // zc_GETInvoiceFilesResponse invFileRes = zc_Api.invoicesFilesGET(accessToken, zEntityId, invoiceId, RTExceptionCode.ERREUR_IMPAYE_REGLER_APPLICATION_FRAIS, pLog);
		    // if (invFileRes.invoiceFiles.size() > 0 ) invoiceFileUrl = invFileRes.invoiceFiles.get(0).pdfFileUrl;
		    
		    //###### Creation paiement Zuora ######
		    Map<String,String> retPayment;
		    if (renouvIn.paiements.size() > 0) { //External
		        //retPayment = execPayment(invoiceId, accountZID, invAmount, renouvIn.paiement.montant, renouvIn.paiement.refPaiement, renouvIn.paiement.methodePaiement, renouvIn.lieu, renouvIn.agent, renouvIn.paiement.dateVirement);
		        for(String key:mapPaiements2.keySet()){      //key=methodPaiement: CBL,ESP..etc.
		            retPayment = execPayment(invoiceId, accountZID, invAmount, mapPaiements2.get(key).montant, mapPaiements2.get(key).refPaiement, mapPaiements2.get(key).methodePaiement, renouvIn.lieu, renouvIn.agent, mapPaiements2.get(key).dateVirement);
		            paymentIds.add(retPayment.get('paymentId'));
		            //mapRollBackProcess : Refund Payment 2
		        }
		    }else { //Electronic
		        retPayment = execPayment(invoiceId, accountZID, invAmount, null, null, null, null, null, null);    
		        paymentIds.add(retPayment.get('paymentId'));
		        //mapRollBackProcess : Refund Payment 2
		    }
		    //payMethodId = retPayment.get('payMethodId');
		    //paymentId = retPayment.get('paymentId');    
		
		    //###### Get Zuora Data (subscription) ######    
		    zc_GETSubscriptionTypeWithSuccess zSub = zc_Api.subscriptionGET(accessToken, zEntityId, currentSubId, RTExceptionCode.ERREUR_RENOUV_GET_ZSUBSCRIPTION,pLog);
		
		    //###### Get Zuora Data (Account) PaymentMethod ###### 
		    zc_ProxyGetAccount zacc = zc_Api.objectAccountGET(accessToken, zEntityId, accountZID, RTExceptionCode.ERREUR_RENOUV_GET_ACCOUNT,pLog);
		    payMethodId = zacc.defaultPaymentMethodId;
		
		    //###### Get Zuora Data (PaymentMethod) ######
		    zc_ProxyGetPaymentMethod pm = zc_Api.objectPaymentMethodGET(accessToken, zEntityId, payMethodId, RTExceptionCode.ERREUR_RENOUV_GET_PAYMENTMETHOD,pLog);
		    
		    //###### insert zdocdata subscription ######    
		    zDocId = SM_Hermes.addZdocData(new Map<String,Object>{'ZSUB' => zSub,'ZPM' => pm,'ACC' => porteur});
		    isDMLoperation = true;
		
		    //###### insert case ######
		    caseId = crm_newCase(renouvIn.lieu, renouvIn.produit, subOffre.HermesIntituleOffre, renouvIn.accountSFID, zDocId, subscriptionName, porteur.PersonContactId, dateFinContrat, renouvIn.agent);
		    //mapRollBackProcess : Cancel Case
		    
		    //###### generate sDoc ######
		    crm_genSdoc(caseId);
		
		    //###### insert Fil impression ######
		    fileImpId = crm_filImpression(zDocId, renouvIn.accountSFID, caseId, subscriptionName, zSub.CodeOffrePrincipale);
		
		    //###### consomme Coupon ######
		    crm_coupon(renouvIn.coupon, dateDebutContrat);
		
		    //RETURN
		    renouvOut = new WSZ.SubOpeOut(renouvIn.accountSFID, accountZID, currentSubId, subscriptionName, compteBloque,invoiceFileUrl, rembourser,
		    paymentIds, caseId, payMethodId, invoiceId, fileImpId, sDocjobIds);
		    } //end not preview
		
		    if (isPreview) {
		        returnObj.put('preview', previewOut);
		    }else {
		        returnObj.put('renouvellement', renouvOut);
		    }
	    
	    
	    } catch (Exception e) {
	        // renouvOut = new WSZ.SubOpeOut();
	        // renouvOut.success = false;
	        //renouvOut.errorCode = 110;
	        String fullMessage = e.getMessage() + e.getStackTraceString() + e.getTypeName() + e.getCause() + e.getLineNumber() + '\n' + renouvInStr;
	        // renouvOut.message = fullMessage; 
	        // returnObj.put('renouvellement', renouvOut);    
	        // return returnObj;
	        // e.setMessage(fullMessage);
	        // pLog.Message__c += '\n' + fullMessage;
	        // insert pLog;
	        throw new RTException(new RTExceptionCode(fullMessage,110));
	
	    } finally {
	        if (billOpes.size() > 0) insert billOpes;
	    }
	    return returnObj;

    }


    Public static zc_ProxyActionAmendRequest getAmendRenew_CDD_CDD(Date dateDebutContrat, String subId, Map<String,Object> offreProxyOut, Boolean isRemoveAddAbo){
    
	    zc_ProxyActionAmendRequest actionAmend = new zc_ProxyActionAmendRequest();
	    zc_AmendRequest req1 = new zc_AmendRequest();        
	    req1.previewOptions = new zc_AmendRequestPreviewOptions();
	    req1.amendOptions = new zc_AmendRequestAmendOptions();
	    zc_Amendment amend1 = new zc_Amendment(); //renewal
	    zc_Amendment amend2 = new zc_Amendment(); // add abo
	    zc_Amendment amend3 = new zc_Amendment(); //remove abo
	    req1.previewOptions.enablePreviewMode=isPreview;
	    req1.amendOptions.generateInvoice = true;
	    req1.amendOptions.processPayments = false;
	    zc_InvoiceProcessingOptions invPrc = new zc_InvoiceProcessingOptions();
	    invPrc.invoiceDate = Date.today();
	    invPrc.invoiceTargetDate = dateDebutContrat;
	    req1.amendOptions.invoiceProcessingOptions = invPrc;
	
	    List<zc_AmendmentRatePlanData> offreAboRatePlans = (List<zc_AmendmentRatePlanData>)offreProxyOut.get('offreAboRatePlans');
	    
	    if (isRemoveAddAbo){
	        
	        Set<String> rpcs = new Set<String>();
	        for (ProdRatePlanCharge__c rpc : [Select zid__c from ProdRatePlanCharge__c where FamilleRPC__c = 'ABO']){
	            rpcs.add(rpc.zid__c);
	        }
	
	        List<Zuora__SubscriptionProductCharge__c> subCharge = [Select Zuora__RatePlanId__c,  Zuora__SubscriptionRatePlan__r.Zuora__OriginalProductRatePlanId__c  
	        from Zuora__SubscriptionProductCharge__c where 
	        Zuora__Subscription__r.Zuora__External_Id__c = :subId AND Zuora__ProductRatePlanChargeId__c in :rpcs];
	        
	        String subAboRatePlanId = subCharge.get(0).Zuora__RatePlanId__c;
	        String prodAboRatePlanId = subCharge.get(0).Zuora__SubscriptionRatePlan__r.Zuora__OriginalProductRatePlanId__c;
	        
	        amend3.contractEffectiveDate = dateDebutContrat;
	        amend3.serviceActivationDate = dateDebutContrat;
	        amend3.customerAcceptanceDate = dateDebutContrat;        
	        amend3.r_type='RemoveProduct';
	        amend3.name='Renouvellement CDD-CDD';
	        amend3.description='Renouvellement remove product CDD';
	        amend3.status='Completed';
	        amend3.subscriptionId=subId;
	        amend3.ratePlanData = new zc_AmendmentRatePlanData();
	        amend3.ratePlanData.ratePlan = new zc_RatePlan();
	        amend3.ratePlanData.ratePlan.amendmentSubscriptionRatePlanId = subAboRatePlanId;
	        amend3.ratePlanData.ratePlan.productRatePlanId = prodAboRatePlanId;
	        req1.amendments.add(amend3);
	
	        //add Abo
	        amend2.contractEffectiveDate = dateDebutContrat;
	        amend2.serviceActivationDate = dateDebutContrat;
	        amend2.customerAcceptanceDate = dateDebutContrat;        
	        amend2.r_type='NewProduct';
	        amend2.name='Renouvellement CDD-CDD';
	        amend2.description='Renouvellement add product';
	        amend2.status='Completed';
	        amend2.subscriptionId=subId;
	        amend2.ratePlanData = offreAboRatePlans.get(0);
	        req1.amendments.add(amend2);
	    }

	    // renewal
	    amend1.contractEffectiveDate = dateDebutContrat;
	    amend1.serviceActivationDate = dateDebutContrat;
	    amend1.customerAcceptanceDate = dateDebutContrat;        
	    amend1.name='Renouvellement CDD-CDD';
	    amend1.description='Renouvellement contrat';
	    amend1.status='Completed';
	    amend1.subscriptionId=subId;
	    amend1.r_type='Renewal';
	    
	    req1.amendments.add(amend1);

	    // Add offreCos: +ieurs
	    //TODO FUTUR: si on a le temps, sinon TODOFUTUR pour les OffresCo/Renouvellement:
	    // if (offreProxyOut.containsKey('offreCoRatePlans')) 
	    // if (offreProxyOut.containsKey('offreCoRatePlans') != null && offreCoRatePlans.size() > 0){
	    //     for( zc_AmendmentRatePlanData offreCoRatePlan: offreCoRatePlans){
	    //         zc_Amendment amendX = new zc_Amendment();
	    //         amendX.contractEffectiveDate = dateDebutContrat;  //TODO FUTUR verifier si ca passe pour tous les types de remises, ou il faut overrider des champs.
	    //         amendx.serviceActivationDate = dateDebutContrat;
	    //         amendx.customerAcceptanceDate = dateDebutContrat;              
	    //         amendX.name='OffreCo CDD: Ajour remise';
	    //         amendX.status='Completed';
	    //         amendX.subscriptionId=subId;
	    //         amendX.r_type='NewProduct';
	    //         amendX.description='OffreCo CDD: Ajour remise';
	    //         amendX.ratePlanData = offreCoRatePlan.clone();
	    //     }    
	    // }
	
	    // req1.previewOptions = previewOptions;
	    // req1.amendOptions = amendOptions;
	    actionAmend.requests.add(req1);
	
	    return actionAmend;
        
    }

    public static zc_ProxyActionAmendRequest getAmendRenew_CDD_CDI(Date dateDebutContrat, String subId, Map<String,Object> offreProxyOut){
    
	    List<zc_AmendmentRatePlanData> offreCoRatePlans = (List<zc_AmendmentRatePlanData>)offreProxyOut.get('offreCoRatePlans'); 
	    List<zc_AmendmentRatePlanData> offreAboRatePlans = (List<zc_AmendmentRatePlanData>)offreProxyOut.get('offreAboRatePlans');
	
	
	    // ###### Amends (CDD/CDI): actionAmendPUT
	    zc_ProxyActionAmendRequest actionAmend = new zc_ProxyActionAmendRequest();
	    zc_AmendRequest req1 = new zc_AmendRequest();        
	    req1.previewOptions = new zc_AmendRequestPreviewOptions();
	    req1.amendOptions = new zc_AmendRequestAmendOptions();
	    zc_Amendment amend1 = new zc_Amendment(); //termcondition
	    zc_Amendment amend2 = new zc_Amendment(); //removeproduct
	    zc_Amendment amend3 = new zc_Amendment(); //addproduct
	
	    req1.previewOptions.enablePreviewMode=isPreview;
	    req1.amendOptions.generateInvoice = true;
	    req1.amendOptions.processPayments = false;
	    zc_InvoiceProcessingOptions invPrc = new zc_InvoiceProcessingOptions();
	    invPrc.invoiceDate = Date.today();
	    invPrc.invoiceTargetDate = dateDebutContrat;
	    req1.amendOptions.invoiceProcessingOptions = invPrc;
	
	    // Terms and conditions: term et condition avec engagement
	    // amend1.contractEffectiveDate = dateDebutContrat;
	    // amend1.serviceActivationDate = dateDebutContrat;
	    // amend1.customerAcceptanceDate = dateDebutContrat;        
	    // amend1.r_type='TermsAndConditions';
	    // amend1.name='Renouvellement CDD-CDI';
	    // amend1.description='Renouvellement CDD-CDI';
	    // amend1.status='Completed';
	    // amend1.subscriptionId=subId;
	    // amend1.renewalSetting = 'RENEW_TO_EVERGREEN';
	    // amend1.termStartDate = (dateDebutContrat.day() == 1)?dateDebutContrat:Util.firstOfNextMonth(dateDebutContrat);
	    // amend1.autoRenew = true;
	    // req1.amendments.add(amend1);

	    // Terms and conditions: term et condition en evergreen (sans engagement)
	    amend1.contractEffectiveDate = dateDebutContrat;
	    amend1.serviceActivationDate = dateDebutContrat;
	    amend1.customerAcceptanceDate = dateDebutContrat;        
	    amend1.r_type='TermsAndConditions';
	    amend1.name='Renouvellement CDD-CDI';
	    amend1.description='Renouvellement CDD-CDI';
	    amend1.status='Completed';
	    amend1.subscriptionId=subId;
	    amend1.termType = 'EVERGREEN';
	    //amend1.renewalSetting = 'RENEW_TO_EVERGREEN';
	    amend1.termStartDate = (dateDebutContrat.day() == 1)?dateDebutContrat:Util.firstOfNextMonth(dateDebutContrat);
	    //amend1.autoRenew = true;
	    req1.amendments.add(amend1);

	    // Remove product ABO
	    Set<String> rpcs = new Set<String>();
	    for (ProdRatePlanCharge__c rpc : [Select zid__c from ProdRatePlanCharge__c where FamilleRPC__c = 'ABO']){
	        rpcs.add(rpc.zid__c);
	    }    
	    List<Zuora__SubscriptionProductCharge__c> subCharge = [Select Zuora__RatePlanId__c,  Zuora__SubscriptionRatePlan__r.Zuora__OriginalProductRatePlanId__c  
	    from Zuora__SubscriptionProductCharge__c where 
	    Zuora__Subscription__r.Zuora__External_Id__c = :subId AND Zuora__ProductRatePlanChargeId__c in :rpcs];
	    
	    String subAboRatePlanId = subCharge.get(0).Zuora__RatePlanId__c;
	    String prodAboRatePlanId = subCharge.get(0).Zuora__SubscriptionRatePlan__r.Zuora__OriginalProductRatePlanId__c;
	
	    amend2.contractEffectiveDate = dateDebutContrat;
	    amend2.serviceActivationDate = dateDebutContrat;
	    amend2.customerAcceptanceDate = dateDebutContrat;        
	    amend2.r_type='RemoveProduct';
	    amend2.name='Renouvellement CDD-CDI';
	    amend2.description='Renouvellement remove product CDD';
	    amend2.status='Completed';
	    amend2.subscriptionId=subId;
	    amend2.ratePlanData = new zc_AmendmentRatePlanData();
	    amend2.ratePlanData.ratePlan = new zc_RatePlan();
	    amend2.ratePlanData.ratePlan.amendmentSubscriptionRatePlanId = subAboRatePlanId;
	    amend2.ratePlanData.ratePlan.productRatePlanId = prodAboRatePlanId;
	    req1.amendments.add(amend2);

	    // Add product ABO CDI
	    amend3.contractEffectiveDate = dateDebutContrat;
	    amend3.serviceActivationDate = dateDebutContrat;
	    amend3.customerAcceptanceDate = dateDebutContrat;        
	    amend3.r_type='NewProduct';
	    amend3.name='Renouvellement CDD-CDI';
	    amend3.description='Renouvellement add product';
	    amend3.status='Completed';
	    amend3.subscriptionId=subId;
	    amend3.ratePlanData = offreAboRatePlans.get(0);
	    //amend3.ratePlanData.addAll(subOffreRatePlans);
	    req1.amendments.add(amend3);

    
	    //.ratePlanData.addAll(subOffreRatePlans);
	
	    // // Add offreCos: +ieurs
	    // //TODO FUTUR: si on a le temps, sinon TODOFUTUR pour les OffresCo/Renouvellement:
	    // if (offreCoRatePlans != null && offreCoRatePlans.size() > 0){
	    //     for( zc_AmendmentRatePlanData offreCoRatePlan: offreCoRatePlans){
	    //         zc_Amendment amendX = new zc_Amendment();
	    //         amendX.contractEffectiveDate=renewDateCE;  //TODO FUTUR verifier si ca passe pour tous les types de remises, ou il faut overrider des champs.
	    //         amendx.serviceActivationDate = renewDateCE;
	    //         amendx.customerAcceptanceDate = renewDateCE;              
	    //         amendX.name='OffreCo CDD: Ajour remise';
	    //         amendX.status='Completed';
	    //         amendX.subscriptionId=subId;
	    //         amendX.r_type='NewProduct';
	    //         amendX.description='OffreCo CDD: Ajour remise';
	    //         amendX.ratePlanData = offreCoRatePlan.clone();
	    //     }    
	    // }
	
	    // req1.previewOptions = previewOptions;
	    // req1.amendOptions = amendOptions;
	    actionAmend.requests.add(req1);
	
	    return actionAmend;

    }

    public static void crm_coupon(String coupon, Date dateDebutContrat){
        if (coupon != null) SM_Coupon.consommer(coupon,dateDebutContrat);
    }

    public static String crm_filImpression(String zDocId, String accountSFID, String caseId, String subscriptionName, String codeOffrePrincipale){
        // List<Carte__c> cartes = [Select Id from Carte__c where Name = 'numeroCarte']; //TODO:OK voir si numero est cree a l impression et fournit par hermes.
        // Id carteId = (cartes.size() > 0)?cartes.get(0).Id:null;
        ZDocData__c zDoc = [Select Id, Payeur__r.FirstName, Payeur__r.LastName from ZDocData__c where Id = :zDocId];
        return SM_FileImpression.createFileImpressionCarte(null, (Id)accountSFID, null, (Id)caseId, subscriptionName, codeOffrePrincipale, zDoc.Payeur__r.FirstName, zDoc.Payeur__r.LastName);
    }

    public static void crm_genSdoc(String caseId){
        List<Case> cs = [SELECT Id,AccountId,TECHIdStatut__c FROM Case WHERE Id=:caseId];
        SM_SDoc.makeSdocJobs(cs);
    }

    public static Id crm_newCase(String lieu, String produit, String hermesIntituleOffre, String accountSFID, 
    Id zDocId, String subscriptionName, Id personContactId, Date dateFinContrat, String agent){
        String origin = SM_Hermes.lieuToOrigin(lieu);
        String commentairesInternes = 'Reabonnement - ' + produit + ' - ' + hermesIntituleOffre; 
        Case c = SM_Hermes.newCase2(zDocId, subscriptionName, personContactId, origin, '1- Vie de l\'abonnement', '07- Reabonnement', 'A- Action', 'Fermee', 
        lieu, commentairesInternes, accountSFID,null,null,dateFinContrat,agent);
        Id caseId = c.Id;
        return caseId;
    }

    public static Map<String,String> execPayment(String invoiceId, String accountZID, Double invAmount, Double montant, String refPaiement, String methodePaiement, String lieu, String agent, Date  dateVirement) {

        Map<String,String> ret = new Map<String,String>{'paymentId'=>null,'payMethodId'=>null};
        zc_CreatePaymentType paymentReq = SM_Payment.paymentReq(invoiceId, accountZID, invAmount, montant, refPaiement, methodePaiement, lieu, agent, dateVirement, codePays);
        //###### Call WS Payment ######   
        zc_GETARPaymentType paymentRes = zc_Api.paymentsPOST2(accessToken, zEntityId, paymentReq, RTExceptionCode.ERREUR_RENOUV_PAYMENT,pLog);
        ret.put('payMethodId',paymentRes.paymentMethodId);
        ret.put('paymentId',paymentRes.id);
        return ret;

    }

    public static void execUpdateSub(String subId, String lieu, String agent, String produit, String methodePaiement, String typeContrat, Date dateFinContrat, String originalSubId){
        zc_ProxyActionupdateRequest subUpdReq = new zc_ProxyActionupdateRequest();
        subUpdReq.r_type = 'Subscription';
        zc_ZObjectUpdate zObj = new zc_ZObjectUpdate();
        zObj.id = subId;
        zObj.lieu = lieu;
        zObj.agent = agent;
        zObj.codeOffrePrincipale = produit;
        zObj.typeContrat = typeContrat;
        zObj.idContratPrecedent = originalSubId;
        if (typeContrat == 'CDI'){
            zObj.fieldsToNull = new List<String>{'DateFinContrat__c','CodeFinContrat__c','CancelCaseID__c'};
            zObj.methodePaiement = 'PRE'; 
        }else {//CDD
            zObj.methodePaiement = methodePaiement;
            zObj.dateFinContrat = dateFinContrat;
        }
        subUpdReq.objects.add(zObj);
        //Call WS sub update
        zc_Api.actionUpdatePOST(accessToken, zEntityId, subUpdReq, RTExceptionCode.ERREUR_RENOUV_UPDATE_SUBSCRIPTION,pLog);
    }

    public static void execUpdateAmend(String amendId, String originalSubId){
        zc_ProxyActionupdateRequest amendUpdReq = new zc_ProxyActionupdateRequest();
        amendUpdReq.r_type = 'Amendment';
        zc_ZObjectUpdate zObj = new zc_ZObjectUpdate();
        zObj.id = amendId;
        zObj.operation = 'Renouvellement';
        zObj.idContratPrecedent = originalSubId;
        amendUpdReq.objects.add(zObj);
        //Call WS Amend update
        zc_Api.actionUpdatePOST(accessToken, zEntityId, amendUpdReq, RTExceptionCode.ERREUR_RENOUV_UPDATE_AMENDMENT,pLog);    
    }


    public static AmendRenewReelOut execAmendRenewReel(Date dateDebutContrat, String subId, Map<String,Object> offreProxyOut, String typeRenouvellement){

        zc_ProxyActionAmendRequest amendRenewReq;
        AmendRenewReelOut amendOut = new AmendRenewReelOut();
        
        if (typeRenouvellement == 'CDD-CDD') 
            amendRenewReq = getAmendRenew_CDD_CDD(dateDebutContrat, subId, offreProxyOut, isRemoveAddAbo);
        if (typeRenouvellement == 'CDD-CDI') 
            amendRenewReq = getAmendRenew_CDD_CDI(dateDebutContrat, subId, offreProxyOut);

        zc_ProxyActionAmendResponse amendResult = zc_Api.actionAmendPOST(accessToken, zEntityId, amendRenewReq, RTExceptionCode.ERREUR_RENOUV_ADD_AMENDMENT_RENEW, pLog);
        amendOut.invoiceId = amendResult.results.get(0).invoiceId;
        Integer amendCount = amendResult.results.get(0).amendmentIds.size();
        amendOut.amendId = amendResult.results.get(0).amendmentIds.get(amendCount-1); //Last AmendId
        amendOut.subId = amendResult.results.get(0).subscriptionId;
        return amendOut;
        
    }

   public static WSZ.preview execAmendRenewPreview(Date dateDebutContrat, Date renewDateCE, String subId, Map<String,Object> offreProxyOut, String typeRenouvellement){

        zc_ProxyActionAmendRequest amendRenewReq;

        if (typeRenouvellement == 'CDD-CDD') 
            amendRenewReq = getAmendRenew_CDD_CDD(dateDebutContrat, subId, offreProxyOut,isRemoveAddAbo);
        if (typeRenouvellement == 'CDD-CDI') 
            amendRenewReq = getAmendRenew_CDD_CDI(dateDebutContrat, subId, offreProxyOut);

        zc_ProxyActionAmendResponse amendResult = zc_Api.actionAmendPOST(accessToken, zEntityId, amendRenewReq, RTExceptionCode.ERREUR_RENOUV_ADD_AMENDMENT_RENEW_PREVIEW, pLog);
        
        WSZ.preview preview = SM_Subscribe.parsePreview(amendResult, offreProxyOut);

        return preview;
        
    }

    private class AmendRenewReelOut {

        String amendId;
        String invoiceId;
        String subId;

    }

    private class PaymentMethodOut {
        String elecPayMethodId;
        String extPaymentMethodId;
    }

    public static PaymentMethodOut execCreateGetPaymentMethod(String typeContrat, Boolean isB2B, String methodePaiement, String codePays, String iban, String mandateId, Account payeur, String accountZID) {

        PaymentMethodOut pmOut = new PaymentMethodOut();

        if (mandateId != null && iban != null) {         
            zc_ProxyCreatePaymentMethod reqObj = SM_Payment.paymentMethodElec(accountZID, iban, mandateId, payeur);
            zc_ProxyCreateOrModifyResponse resObj = zc_Api.objectPaymentMethodPOST(accessToken, zEntityId, reqObj, RTExceptionCode.ERREUR_RENOUV_POST_PAYMENTMETHOD, pLog);
            pmOut.elecPayMethodId = resObj.id;
        }else if (typeContrat == 'CDD') {
            pmOut.extPaymentMethodId = SM_Hermes.getExtPaymentMethodId(isB2B, methodePaiement, codePays); //TODO: OK methodePaiement mapping
        }
        
        return pmOut;
    } 
       
    public static void execUpdAccount(String accountZID, PaymentMethodOut pmOut, String typeRenouvellement){

        zc_ProxyActionupdateRequest accUpdateReq = new zc_ProxyActionupdateRequest();        
        accUpdateReq.r_type = 'Account';
        zc_ZObjectUpdate zObj = new zc_ZObjectUpdate();
        zObj.id = accountZID;
        if (typeRenouvellement == 'CDD-CDI') {zObj.batch = 'Batch1'; zObj.autoPay = true;}    
        if (pmOut.elecPayMethodId != null) {
            zObj.defaultPaymentMethodId = pmOut.elecPayMethodId;            
        }else if (pmOut.extPaymentMethodId !=null ) {
            zObj.defaultPaymentMethodId = pmOut.extPaymentMethodId;            
        }        
        //TODOFUTUR si renouvellement BTOB subAcc.invoiceTemplateId = SM_Hermes.getInvoiceTemplateId(isB2B, acc.CodePays__c, acc.Langue_parl_e_par_le_client__c);
        accUpdateReq.objects.add(zObj);
        zc_Api.actionUpdatePOST(accessToken, zEntityId, accUpdateReq, RTExceptionCode.ERREUR_RENOUV_UPDATEACC_DEFPAYMETHOD,pLog);

    }

    public static ZuoraTokenOut execZuoraToken(String codePays){
        ZuoraTokenOut zToken = new ZuoraTokenOut();
        zToken.accessToken = WS001_CallZuora.access_token;
        zToken.zEntityId = WS001_CallZuora.getZuoraEntityId(codePays); 
        return zToken;
    }

    public class ZuoraTokenOut {
        String accessToken;
        String zEntityId;
    }


    // public static Map<String,Object> execOffreProxy(Date dateDebutContrat, String lieu, String agent, String coupon, String accountSFID, string operation, String produit){
    //     Map<String,Object> resObj = new Map<String,Object>();
    //     List<zc_AmendmentRatePlanData> offreCoRatePlans;
    //     List<zc_AmendmentRatePlanData> offreAboRatePlans;
        
    //     //get offre
    //     WSZ.SubProduct subOffre = SM_Offre.getSubOffres(new WSZ.SubOffreIn(dateDebutContrat, lieu, agent, coupon,accountSFID, operation, produit)).get(0);
        
    //     //extract and convert RatePlans
    //     List<zc_AmendmentRatePlanData> offreRatePlans = SM_Offre.convertRatePlan(subOffre.subscribeToRatePlans);
    //     if (offreRatePlans.size() == 0) offreRatePlans = null;
                
    //     // get offreCo RatePlans
    //     if (subOffre.CodeOffreCo != null) {
    //         offreCoRatePlans = SM_Offre.getOffreCoRatePlans(offreRatePlans);
    //         if (offreCoRatePlans.size() == 0) offreCoRatePlans = null;
    //     }

    //     //get offreAboRatePlans
    //     offreAboRatePlans = SM_Offre.getOffreAboRatePlans(offreRatePlans);
    //     if (offreAboRatePlans.size() == 0) offreAboRatePlans = null;

    //     resObj.put('offre',subOffre);
    //     resObj.put('offreRatePlans',offreRatePlans);
    //     resObj.put('offreCoRatePlans',offreCoRatePlans);
    //     resObj.put('offreAboRatePlans',offreAboRatePlans);        

    //     return resObj;
    // }


} // END CLASS   



    // public static WSZ.preview executeAmendRenewPreview(String amendRenewReqJSON, String subOffreJSON, String subOffreRatePlansJSON){

    //     zc_ProxyActionAmendRequest amendRenewReq = (zc_ProxyActionAmendRequest)JSON.deserialize(amendRenewReqJSON,zc_ProxyActionAmendRequest.class);
        
    //     zc_ProxyActionAmendRequest amendRenewReq = (zc_ProxyActionAmendRequest)JSON.deserialize(subOffreRatePlansJSON,zc_ProxyActionAmendRequest.class);

    //     zc_ProxyActionAmendResponse amendResult = zc_Api.actionAmendPOST(accessToken, zEntityId, amendRenewReq, RTExceptionCode.ERREUR_IMPAYE_REGLER_APPLICATION_FRAIS, pLog);
        
        
    //     return preview;

    // }

  




    // // update BtoB  product price
    // amend2.contractEffectiveDate = renewDateCE;        
    // amend2.name='Mise a jour prix B2B';
    // amend2.status='Completed';
    // amend2.subscriptionId=currentSubId;
    // amend2.r_type='UpdateProduct';
    // amend2.description='Renouvellement Mise a jour prix B2B';
    // zc_AmendmentRatePlanData ratePlanData = new zc_AmendmentRatePlanData();
    // ratePlanData.ratePlan = new zc_RatePlan();
    // ratePlanData.ratePlan.productRatePlanId=rpId; 
    // ratePlanData.ratePlan.amendmentSubscriptionRatePlanId = ''; //TODO FUTUR
    // zc_RatePlanChargeDataInRatePlanData rpcChargeData = new zc_RatePlanChargeDataInRatePlanData();
    // rpcChargeData.ratePlanCharge = new zc_RatePlanChargeInRatePlanChargeData();        
    // rpcChargeData.ratePlanCharge.price = 150; //TODO FUTUR prix dans le coupon        
    // rpcChargeData.ratePlanCharge.productRatePlanChargeId = rpcId;                
    // ratePlanData.ratePlanChargeData.add(rpcChargeData);
    // amend2.ratePlanData = ratePlanData; 
    // req1.amendments.add(amend2);



        // WSZ.Paiement paymentIn;
    // zc_CreatePaymentType paymentReq;
    // if (renouvIn.paiement != null ) { // TODOFUTUR:  si on traite les B2B : || subOffre.IsB2B == true
    //     if (renouvIn.paiement.montant != invAmount) throw new RTException(RTExceptionCode.ERREUR_DESABO_COUPON_ABOTIER,pLog);
    //     paymentIn = new WSZ.Paiement(renouvIn.paiement.montant, renouvIn.paiement.refPaiement, renouvIn.paiement.methodePaiement, renouvIn.paiement.lieu, renouvIn.paiement.agent, renouvIn.paiement.dateVirement);
    //     paymentReq = SM_Payment.createExtPayment(invoiceId, accountZID, paymentIn);
    // }else {
    //     paymentIn = new WSZ.Paiement(invAmount, null, null, null, null, null);
    //     paymentReq = SM_Payment.createElecPayment(invoiceId, accountZID, paymentIn);
    // }
    // //###### Call WS Payment ######   
    // zc_GETARPaymentType paymentRes = zc_Api.paymentsPOST2(accessToken, zEntityId, paymentReq, RTExceptionCode.ERREUR_IMPAYE_REGLER_APPLICATION_PAYMENT,pLog);
    // String payMethodId = paymentRes.paymentMethodId;