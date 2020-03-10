/**
 * Created by mouad on 02/12/2018.
 */

public with sharing class SM_Rejet {
	
	public static String endpoint = '/v1/action/amend';
	public static String prodRatePlanChargeReferenceDetteTechnique = 'DETTETECH';
	public static list<RejetExtItem__c> listRejetExtItemToUpdate;
    
    public static void traiterFichier(Id rejetExterneId) {
    	system.debug('##MNE SM_Rejet traiterFichier rejetExterneId >> '+rejetExterneId);
    	
    	list<RejetExtItem__c> listNtry = new list<RejetExtItem__c>([SELECT Id FROM RejetExtItem__c WHERE RejetExterne__c = :rejetExterneId]);
    	
    	if(listNtry.size() > 0){
     		throw new MyException('Le fichier à deja été parser');
     	}
        
        list<ContentDocumentLink> listDoc = new list<ContentDocumentLink>([SELECT ContentDocumentId, LinkedEntityId, ContentDocument.FileExtension, ContentDocument.FileType  FROM ContentDocumentLink
        WHERE LinkedEntityId = :rejetExterneId AND LinkedEntity.Type='RejetExterne__c' AND ContentDocument.FileType = 'XML']);
        
        if(listDoc.size() == 0){
        	throw new MyException('Pas de fichié de type XML trouvé');
        }
        
        if(listDoc.size() > 1){
        	throw new MyException('Plusieur fichié de type XML trouvé');
        }
        
        Id docId = listDoc.get(0).ContentDocumentId;
    	
    	processRejetBred(rejetExterneId, docId);
    }
    
    //Parse les rejets BRED
    public static void processRejetBred(Id rejetExterneId, Id docId){
    	system.debug('##MNE SM_Rejet processRejetBred rejetExterneId >> '+rejetExterneId);
    	system.debug('##MNE SM_Rejet processRejetBred docId >> '+docId);
        
        if(docId == null){
        	throw new MyException('Pas de fichier trouver');
        }

        Blob body = [SELECT VersionData FROM ContentVersion WHERE ContentDocumentId = :docId AND IsLatest = true].VersionData;

        String rejet = body.toString();
        List<String> lignes = new List<String>();
        DOM.Document doc=new DOM.Document();
        doc.load(rejet);
        DOM.XmlNode rootNode = doc.getRootElement();
        
        list<RejetExtItem__c> listNtry = new List<RejetExtItem__c>();
        Util.parseXML(rootNode, listNtry, rejetExterneId);
        
        if(listNtry.size() > 0){
        	insert listNtry;
        }
        
        //traiter les rejet
        //getZSubRejetBred(listNtry);
    }
    
    public static void getZSubRejetBredStep2(Id rejetExternId){
    	system.debug('##MNE SM_Rejet getZSubRejetBredStep2 rejetExternId >> '+rejetExternId);
    	
    	if(rejetExternId == null){
    		throw new MyException('Error Id');
    	}
    	
    	list<RejetExtItem__c> listNtry = new list<RejetExtItem__c>([SELECT CodeRejet__c,Contenu__c,CurrencyRejet__c,DebiteurName__c,ErrorMessage__c,Id,MontantRejet__c,Name,PaymentReference__c,REF_BE__c,REF_FR__c,RejetDate__c,RejetExterne__c,RUM__c FROM RejetExtItem__c WHERE RejetExterne__c = :rejetExternId]);
    	
    	if(listNtry == null || listNtry.size() == 0){
     		throw new MyException('Pas de rejet trouvé à traiter');
     	}
     	
    	//traiter les rejet
        getZSubRejetBred(listNtry);
    }
    
    
	public static void getZSubRejetBred(list<RejetExtItem__c> listNtry){
     	system.debug('##MNE SM_Rejet getZSubRejetBred listNtry >> '+listNtry);
     	
     	if(listNtry == null || listNtry.size() == 0){
     		return;
     	}
     	
     	map<Id, RejetExtItem__c> mapRejetExtItemById = new map<Id, RejetExtItem__c>();
     	map<Id, Zuora__Subscription__c> mapZSubscriptionByRejetExtItemId= new map<Id, Zuora__Subscription__c>();
     	
     	map<String, BilendiAccounting__c> mapBilendiAccountingBypaymentRef = new map<String, BilendiAccounting__c>();
     	map<String, Zuora__Subscription__c> mapZSubscriptionByContratId = new map<String, Zuora__Subscription__c>();
     	
     	//1 recuperer les BillendiAccounting
     	list<String> paymentRefFR = new list<String>();
     	list<String> paymentRefBE = new list<String>();
     	for(RejetExtItem__c item : listNtry){
     		paymentRefFR.add('FR_'+item.PaymentReference__c);
     		paymentRefBE.add('BE_'+item.PaymentReference__c);
     		mapRejetExtItemById.put(item.Id, item);
     	}
     	list<BilendiAccounting__c> listBilendiAccounting = new list<BilendiAccounting__c>([Select Id, Name, ContratId__c From BilendiAccounting__c WHERE Name IN :paymentRefFR OR Name IN :paymentRefBE]);
     	system.debug('##MNE SM_Rejet getZSubRejetBred listBilendiAccounting >> '+listBilendiAccounting);
     	if(listBilendiAccounting == null || listBilendiAccounting.size() == 0){
     		notifierAllItem(listNtry, 'Pas de Bilendi Accounting trouvé');
     		return;
     	}
     	
     	//2 recuperer les ZSubId
     	list<String> listContratId = new list<String>();
     	for(BilendiAccounting__c ba : listBilendiAccounting){ 
     		listContratId.add(ba.ContratId__c);
     		mapBilendiAccountingBypaymentRef.put(ba.Name, ba);
     	}
     	
     	list<Zuora__Subscription__c> listZSub = new list<Zuora__Subscription__c>([Select Id, LegacyExternalID__c, Zuora__External_Id__c, Zuora__CustomerAccount__r.Zuora__External_Id__c, TECH_Pays__c From Zuora__Subscription__c WHERE LegacyExternalID__c IN :listContratId]);
     	system.debug('##MNE SM_Rejet getZSubRejetBred listZSub >> '+listZSub);
     	if(listZSub == null || listZSub.size() == 0){
     		notifierAllItem(listNtry, 'Pas de subscription trouvé');
     		return;
     	}
     	
     	for(Zuora__Subscription__c sub : listZSub){ 
     		mapZSubscriptionByContratId.put(sub.LegacyExternalID__c, sub);
     	}
     	
     	//3 lier les Ntry avec les Zsub
     	listRejetExtItemToUpdate = new list<RejetExtItem__c>();
     	for(RejetExtItem__c item : listNtry){
     		BilendiAccounting__c ba = null;
     		Zuora__Subscription__c zSub = null;
     		if(mapBilendiAccountingBypaymentRef.containsKey('FR_'+item.PaymentReference__c)){
     			ba = mapBilendiAccountingBypaymentRef.get('FR_'+item.PaymentReference__c);
     		}else if(mapBilendiAccountingBypaymentRef.containsKey('BE_'+item.PaymentReference__c)){
     			ba = mapBilendiAccountingBypaymentRef.get('BE_'+item.PaymentReference__c);
     		} else {
     			//pas de BilendiAccounting trouver
     			item.ErrorMessage__c = 'pas de BilendiAccounting trouver';
     			listRejetExtItemToUpdate.add(item);
     			continue;
     		}
     		
     		if(mapZSubscriptionByContratId.containsKey(ba.ContratId__c)){
     			zSub = mapZSubscriptionByContratId.get(ba.ContratId__c);
     		} else {
     			//pas de Sub trouver
     			item.ErrorMessage__c = 'pas de Subscription trouver';
     			listRejetExtItemToUpdate.add(item);
     			continue;
     		}
     		
     		if(zSub != null){
     			mapZSubscriptionByRejetExtItemId.put(item.Id, zSub);
     		}
     	}

     	
     	if(mapZSubscriptionByRejetExtItemId.size() > 0){
     		processRejetBredInZuora(mapRejetExtItemById, mapZSubscriptionByRejetExtItemId);
     	} else if(listRejetExtItemToUpdate.size() > 0){
     		update listRejetExtItemToUpdate;
     	}
     	
     }
     
     public static void processRejetBredInZuora(map<Id, RejetExtItem__c> mapRejetExtItemById, map<Id, Zuora__Subscription__c> mapZSubscriptionByRejetExtItemId){
     	
     	if(mapZSubscriptionByRejetExtItemId.size() == 0 || mapZSubscriptionByRejetExtItemId.size() == 0){
     		notifierAllItem(mapRejetExtItemById, mapZSubscriptionByRejetExtItemId, 'Pas de subscription trouvé 2');
     		return;
     	}
     	
     	//recuperer ProductRatePlanChargeId pour la dette technique France et Belgique
     	String FR_ProductRatePlanId;
		String FR_ProductRatePlanChargeId;
		String BE_ProductRatePlanId;
		String BE_ProductRatePlanChargeId;
		
		/*String prefixe = '';
		if(acc.CodePays__c == '033'){
			prefixe = 'FR';
		}else if(acc.CodePays__c == '032'){
			prefixe = 'BE';
		}*/
		
		String FR_productRatePlanReference = 'FR' + prodRatePlanChargeReferenceDetteTechnique;
		String BE_productRatePlanReference = 'BE' + prodRatePlanChargeReferenceDetteTechnique;
		list<ProdRatePlanCharge__c> listProdRatePlanCharge = new list<ProdRatePlanCharge__c>([SELECT Reference__c, zid__c, ProdRatePlan__r.zid__c FROM ProdRatePlanCharge__c WHERE Reference__c = :FR_productRatePlanReference OR Reference__c = :BE_productRatePlanReference]);
		system.debug('##MNE SM_Rejet processRejetBredInZuora listProdRatePlanCharge >> '+listProdRatePlanCharge);
		if(listProdRatePlanCharge.size() != 2){
			system.debug('##MNE SM_Rejet processRejetBredInZuora Pas de Product Rate Plan Charge trouvée pour la dette technique du Rejet Bred');
			notifierAllItem(mapRejetExtItemById, mapZSubscriptionByRejetExtItemId, 'Pas de Product Rate Plan Charge trouvée pour la dette technique');
            throw new MyException('Pas de Product Rate Plan Charge trouvée pour la dette technique du Rejet Bred.');
		}
		
		for(ProdRatePlanCharge__c prpc : listProdRatePlanCharge){
			if(prpc.Reference__c.startsWithIgnoreCase('FR')){
				FR_ProductRatePlanId = prpc.ProdRatePlan__r.zid__c;
				FR_ProductRatePlanChargeId = prpc.zid__c;
			}else{
				BE_ProductRatePlanId = prpc.ProdRatePlan__r.zid__c;
				BE_ProductRatePlanChargeId = prpc.zid__c;
			}
		}
		
		//recuperer paymentMethodId pour other France et Belgique
		String FR_paymentMethodId;
		String BE_paymentMethodId;
		list<UGC_Generic_Param__mdt> listPaymentMethodId = new list<UGC_Generic_Param__mdt>([SELECT ParamValue__c, Entite__c FROM UGC_Generic_Param__mdt WHERE ParamName__c = 'Zuora_PM_BTB']);
        system.debug('##MNE SM_Rejet processRejetBredInZuora listPaymentMethodId >> '+listPaymentMethodId);
		if(listPaymentMethodId.size() != 2){
			system.debug('##MNE SM_Rejet processRejetBredInZuora Pas de Payment Method Other trouvé pour le Rejet Bred');
			notifierAllItem(mapRejetExtItemById, mapZSubscriptionByRejetExtItemId, 'Pas de Payment Method Other trouvé');
            throw new MyException('Pas de Payment Method Other trouvé pour le Rejet Bred.');
		}
		
		for(UGC_Generic_Param__mdt pm : listPaymentMethodId){
			if(pm.Entite__c == 'France'){
				FR_paymentMethodId = pm.ParamValue__c;
			}else{
				BE_paymentMethodId = pm.ParamValue__c;
			}
		}
		
     	String access_token = WS001_CallZuora.oauthLogin();								//OK
     	for(Id itemId : mapZSubscriptionByRejetExtItemId.keySet()){
     		Zuora__Subscription__c zSub = mapZSubscriptionByRejetExtItemId.get(itemId);
     		RejetExtItem__c item = mapRejetExtItemById.get(itemId);
     		
     		String ProductRatePlanId;													//OK
			String ProductRatePlanChargeId;												//OK
			String paymentMethodId;														//OK
			if(Util.FRANCE.contains(zSub.TECH_Pays__c)){
     			ProductRatePlanId = FR_ProductRatePlanId;
     			ProductRatePlanChargeId = FR_ProductRatePlanChargeId;
     			paymentMethodId = FR_paymentMethodId;
     		} else {
     			ProductRatePlanId = BE_ProductRatePlanId;
     			ProductRatePlanChargeId = BE_ProductRatePlanChargeId;
     			paymentMethodId = BE_paymentMethodId;
     		}
			String zEntityId = WS001_CallZuora.getZuoraEntityId(zSub.TECH_Pays__c);		//OK
			
	     	String zuoraSubId = zSub.Zuora__External_Id__c;								//OK
	     	String accountId = zSub.Zuora__CustomerAccount__r.Zuora__External_Id__c;	//OK
	     	Decimal price = item.MontantRejet__c;										//OK
	     	String rejetCode = item.CodeRejet__c;										//OK
	     	Date rejetDate = item.RejetDate__c;										//OK
	     	
			String zInvoiceId;															//OK
			String zPaymentId;
			
			
			try{
           		String rep = SM_Rejet.precessAmendmentAddProd(zuoraSubId, ProductRatePlanId, ProductRatePlanChargeId, price, zEntityId, access_token);
           		system.debug('##MNE SM_Rejet processRejetBredInZuora Step 1 Res >> '+rep);
           		Resultat resApex = (Resultat)System.JSON.deserialize(rep, Resultat.class);
           		zInvoiceId = resApex.results.get(0).InvoiceId;
	        }catch(Exception e){
	        	system.debug('##MNE SM_Rejet processRejetBredInZuora add product exception >> '+e.getMessage());
	            system.debug('##MNE SM_Rejet processRejetBredInZuora add product Error Step 1');
	            item.ErrorMessage__c = 'add product Error Step 1 >> '+e.getMessage();
     			listRejetExtItemToUpdate.add(item);
	            continue;
	        }
	        
	        try{
           		String rep = SM_Payment.precessCreatePayment(accountId, zInvoiceId, price, paymentMethodId, zEntityId, access_token);
           		WSZ.RefundOut resApex = (WSZ.RefundOut)System.JSON.deserialize(rep, WSZ.RefundOut.class);
           		zPaymentId = resApex.id;
	        }catch(Exception e){
	        	system.debug('##MNE SM_Rejet processRejetBredInZuora create payment exception >> '+e.getMessage());
	            system.debug('##MNE SM_Rejet processRejetBredInZuora create payment Error Step 2');
	            item.ErrorMessage__c = 'create payment Error Step 2 >> '+e.getMessage();
     			listRejetExtItemToUpdate.add(item);
	            continue;
	        }
	        
	        try{
           		SM_Remboursement.unapplyPayment(price, zInvoiceId, zPaymentId, zEntityId, access_token);
	        }catch(Exception e){
	        	system.debug('##MNE SM_Rejet processRejetBredInZuora Unapply Payment exception >> '+e.getMessage());
	            system.debug('##MNE SM_Rejet processRejetBredInZuora Unapply Payment Error Step 3');
	            item.ErrorMessage__c = 'Unapply Payment Error Step 3 >> '+e.getMessage();
     			listRejetExtItemToUpdate.add(item);
	            continue;
	        }
     		
     		try{
           		SM_Remboursement.executeRefundRejetBred(price, zPaymentId, rejetCode, rejetDate, zEntityId, access_token);
	        }catch(Exception e){
	        	system.debug('##MNE SM_Rejet processRejetBredInZuora create Refund exception >> '+e.getMessage());
	            system.debug('##MNE SM_Rejet processRejetBredInZuora create Refund Error Step 4');
	            item.ErrorMessage__c = 'Create Refund Error Step 4 >> '+e.getMessage();
     			listRejetExtItemToUpdate.add(item);
	            continue;
	        }
	        
	        item.ErrorMessage__c = 'OK traité : Pas d\'erreur';
     		listRejetExtItemToUpdate.add(item);
     	}
     	
     	if(listRejetExtItemToUpdate.size() > 0){
     		update listRejetExtItemToUpdate;
     	}
     }
     
    
    private class MyException extends Exception {
	}
	
	
	

	public static void notifierAllItem(map<Id, RejetExtItem__c> mapRejetExtItemById, map<Id, Zuora__Subscription__c> mapZSubscriptionByRejetExtItemId, String message){
		if(mapZSubscriptionByRejetExtItemId == null || mapZSubscriptionByRejetExtItemId == null || mapZSubscriptionByRejetExtItemId.size() == 0 || mapZSubscriptionByRejetExtItemId.size() == 0){
			return;
		}
		list<RejetExtItem__c> listItemToUpdate = new list<RejetExtItem__c>();
		for(Id itemId : mapZSubscriptionByRejetExtItemId.keySet()){
     		RejetExtItem__c item = mapRejetExtItemById.get(itemId);
     		listItemToUpdate.add(item);
		}
		
		if(listItemToUpdate.size() > 0){
			notifierAllItem(listItemToUpdate, message);
		}
	}
	
	public static void notifierAllItem(list<RejetExtItem__c> listItem, String message){
		if(listItem == null){
			listItem = new list<RejetExtItem__c>();
		}
		
		if(listItem.size() != 0){
			for(RejetExtItem__c item : listItem){
				item.ErrorMessage__c = message;
			}
		}
		
		if(listRejetExtItemToUpdate != null && listRejetExtItemToUpdate.size() != 0){
			listItem.addAll(listRejetExtItemToUpdate);
		}
		
		if(listItem.size() > 0){
			update listItem;
		}
		
	}
	
	
	
	public static String precessAmendmentAddProd(String zuoraSubId, String ProductRatePlanId, String ProductRatePlanChargeId, Decimal price, String zEntityId, String access_token){
		system.debug('##MNE SM_Rejet precessAmendmentAddProd zuoraSubId >> '+zuoraSubId);
		system.debug('##MNE SM_Rejet precessAmendmentAddProd ProductRatePlanId >> '+ProductRatePlanId);
		system.debug('##MNE SM_Rejet precessAmendmentAddProd ProductRatePlanChargeId >> '+ProductRatePlanChargeId);
		system.debug('##MNE SM_Rejet precessAmendmentAddProd price >> '+price);
		system.debug('##MNE SM_Rejet precessAmendmentAddProd zEntityId >> '+zEntityId);
		system.debug('##MNE SM_Rejet precessAmendmentAddProd access_token >> '+access_token);
		
		//creation du json
		String bodyRejetBredAddProd = getBodyRejetBredAddProd(zuoraSubId, ProductRatePlanId, ProductRatePlanChargeId, price);
		system.debug('##MNE SM_Rejet precessAmendmentAddProd bodyRejetBredAddProd >> '+bodyRejetBredAddProd);
		
		String method = 'POST';
		String wsOut = WS001_CallZuora.sendRequest(access_token, endpoint, zEntityId, method, bodyRejetBredAddProd, 'type1', '211.0');
		system.debug('##MNE SM_Rejet precessAmendmentAddProd wsOut >> '+wsOut);
		return wsOut;
	}
	
	public static String getBodyRejetBredAddProd (String zuoraSubId, String ProductRatePlanId, String ProductRatePlanChargeId, Decimal price){
        try{
            BodyRejetBredAddProd res = new BodyRejetBredAddProd(zuoraSubId, ProductRatePlanId, ProductRatePlanChargeId, price);
            String s = JSON.serialize(res);
            system.debug('##MNE SM_Rejet getBodyRejetBredAddProd json rep >> '+s);
            return s;
        }catch(Exception e){
            system.debug('##MNE SM_Rejet getBodyRejetBredAddProd exception >> '+e.getMessage());
            throw e;
        }
    }

    //-----------------------------------Request Body-----------------------------------------
    public class BodyRejetBredAddProd {
        public list<Request> requests = null;
        
        public BodyRejetBredAddProd (String zuoraSubId, String ProductRatePlanId, String ProductRatePlanChargeId, Decimal price){
            requests = new list<Request>();
            requests.add(new Request(zuoraSubId, ProductRatePlanId, ProductRatePlanChargeId, price));
        }
    }
    
    //-----------------------------------Request-----------------------------------------
    public class Request {
        public PreviewOptions PreviewOptions;
        public AmendOptions AmendOptions;
        public list<Amendment> Amendments = null;
        
        public Request(String zuoraSubId, String ProductRatePlanId, String ProductRatePlanChargeId, Decimal price){
            PreviewOptions = new PreviewOptions();
            AmendOptions = new AmendOptions();
            Amendments = new list<Amendment>();
            Amendments.add(new Amendment(zuoraSubId, ProductRatePlanId, ProductRatePlanChargeId, price));
        }
    }
    //-----------------------------------PreviewOptions-----------------------------------
    public class PreviewOptions {
        public Boolean EnablePreviewMode;   
        
        public PreviewOptions(){
            EnablePreviewMode = false;
        }
    }
    //-----------------------------------AmendOptions--------------------------------------
    public class AmendOptions {
        public Boolean GenerateInvoice;
        
        public AmendOptions(){
            GenerateInvoice = true;
        }
    }
    //-----------------------------------Amendment-----------------------------------------
    public class Amendment {
        public String ContractEffectiveDate;
        public String ServiceActivationDate;
        public String Name;
        public String SubscriptionId;
        public String Type;
        public String Status;
        public String Description;
        public RatePlanData RatePlanData;
        
        public Amendment (String zuoraSubId, String ProductRatePlanId, String ProductRatePlanChargeId, Decimal price){
            this.ContractEffectiveDate = String.valueOf(Date.Today());
            this.ServiceActivationDate = String.valueOf(Date.Today());
            this.Name = 'Gestion Rejet Bred';
            this.SubscriptionId = zuoraSubId;
            this.Type = 'NewProduct';
            this.Status = 'Completed';
            this.Description = 'Gestion Rejet Bred';
            this.RatePlanData = new RatePlanData(ProductRatePlanId, ProductRatePlanChargeId, price);
        }
    }
    //-----------------------------------RatePlanData-----------------------------------
    public class RatePlanData {
        public RatePlan RatePlan;
        public list<RatePlanChargeData> RatePlanChargeData;
        
        public RatePlanData(String ProductRatePlanId, String ProductRatePlanChargeId, Decimal price){
            RatePlan = new RatePlan(ProductRatePlanId);
            RatePlanChargeData = new list<RatePlanChargeData>();
            RatePlanChargeData tmp = new RatePlanChargeData(ProductRatePlanChargeId, price);
            RatePlanChargeData.add(tmp);
        }
    }
    //-----------------------------------RatePlan-----------------------------------
    public class RatePlan {
        public String ProductRatePlanId;
        
        public RatePlan(String ProductRatePlanId){
            this.ProductRatePlanId = ProductRatePlanId;
        }
    }
    //-----------------------------------RatePlanChargeData-----------------------------------
    public class RatePlanChargeData {
        public RatePlanCharge RatePlanCharge;
        
        public RatePlanChargeData(String ProductRatePlanChargeId, Decimal price){
            RatePlanCharge = new RatePlanCharge(ProductRatePlanChargeId, price);
        }
    }
    //-----------------------------------RatePlanCharge-----------------------------------
    public class RatePlanCharge {
        public String ProductRatePlanChargeId;
        public Decimal Price;
        
        public RatePlanCharge(String ProductRatePlanChargeId, Decimal price){
            this.ProductRatePlanChargeId = ProductRatePlanChargeId;
            this.Price = price;
        }
    }
    
    
    
    //-----------------------------------Response Resultat-----------------------------------
    public class Resultat {
        public list<Result> results = null;
    }
    //-----------------------------------Result-----------------------------------
    public class Result {
        public list<Error> Errors = null;
        public String SubscriptionId;
        public Double TotalDeltaTcv;
        public list<String> AmendmentIds = null;
        public Integer TotalDeltaMrr;
        public Boolean Success;
        public String InvoiceId;
    }
    //-----------------------------------Error-----------------------------------
    public class Error {
        public String Code;
        public String Message;
    }


}