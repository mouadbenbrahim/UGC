/**
 * Created by mouad on 02/12/2018.
 */

public with sharing class SM_Rejet {
	
	public static String endpoint = '/v1/action/amend';
	public static String prodRatePlanChargeReferenceDetteTechnique = 'DETTETECH';
    
    public static void traiterFichier(Id rejetExterneId) {
    	system.debug('##MNE SM_Rejet traiterFichier rejetExterneId >> '+rejetExterneId);
        
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
        getZSubRejetBred(listNtry);
    }
    
	public static void getZSubRejetBred(list<RejetExtItem__c> listNtry){
     	system.debug('##MNE SM_Rejet processRejetBredInZuora listNtry >> '+listNtry);
     	
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
     	system.debug('##MNE SM_Rejet processRejetBredInZuora listBilendiAccounting >> '+listBilendiAccounting);
     	if(listBilendiAccounting == null || listBilendiAccounting.size() == 0){
     		return;
     	}
     	
     	//2 recuperer les ZSubId
     	list<String> listContratId = new list<String>();
     	for(BilendiAccounting__c ba : listBilendiAccounting){ 
     		listContratId.add(ba.ContratId__c);
     		mapBilendiAccountingBypaymentRef.put(ba.Name, ba);
     	}
     	
     	list<Zuora__Subscription__c> listZSub = new list<Zuora__Subscription__c>([Select Id, LegacyExternalID__c, Zuora__External_Id__c, Zuora__CustomerAccount__r.Zuora__External_Id__c From Zuora__Subscription__c WHERE LegacyExternalID__c IN :listContratId]);
     	system.debug('##MNE SM_Rejet processRejetBredInZuora listZSub >> '+listZSub);
     	if(listZSub == null || listZSub.size() == 0){
     		return;
     	}
     	
     	for(Zuora__Subscription__c sub : listZSub){ 
     		mapZSubscriptionByContratId.put(sub.LegacyExternalID__c, sub);
     	}
     	
     	//3 lier les Ntry avec les Zsub
     	list<RejetExtItem__c> listRejetExtItemToUpdate = new list<RejetExtItem__c>();
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
     	
     	if(listRejetExtItemToUpdate.size() > 0){
     		update listRejetExtItemToUpdate;
     	}
     	
     	if(mapZSubscriptionByRejetExtItemId.size() > 0){
     		processRejetBredInZuora(mapRejetExtItemById, mapZSubscriptionByRejetExtItemId);
     	}
     	
     }
     
     public static void processRejetBredInZuora(map<Id, RejetExtItem__c> mapRejetExtItemById, map<Id, Zuora__Subscription__c> mapZSubscriptionByRejetExtItemId){
     	
     	if(mapZSubscriptionByRejetExtItemId.size() == 0 || mapZSubscriptionByRejetExtItemId.size() == 0){
     		return;
     	}
     	
     	for(Id item : mapZSubscriptionByRejetExtItemId.keySet()){
     		
     	}
     	
     	Decimal price = 25;
     	String zuoraSubId = '8adce4216a06d477016a20430bb100fa';
		String ProductRatePlanId = '8adc8f99658a0b910165aa1454d906c6';
		String ProductRatePlanChargeId = '8adc8f99658a0b910165aa15fc33074f';
     	String accountId = '8adc8f9969e30e130169e863cb8c3b7c';
		String zInvoiceId = '8adc8f996cdb8533016cdcaa4c2156e9';
		String paymentMethodId = '8adc8f9963ecb5c20163f45800ab62a9';
		String zPaymentId = '8adcc59c6cdb8da5016cdd52c6b15ca9';
     	String zEntityId = '8adce421-63ec-c07b-0163-f45782667179';
		String access_token = 'e3e33c9fa99c4d7c885cb92ccf93042a';
		
     	
     	
     	SM_Rejet.precessAmendmentAddProd(zuoraSubId, ProductRatePlanId, ProductRatePlanChargeId, price, zEntityId, access_token);
     	SM_Payment.precessCreatePayment(accountId, zInvoiceId, price, paymentMethodId, zEntityId, access_token);
     	SM_Remboursement.unapplyPayment(price, zInvoiceId, zPaymentId, zEntityId, access_token);
     	SM_Remboursement.executeRefundRejetBred(price, zPaymentId, zEntityId, access_token);
     	
     	
     }
     
    
    private class MyException extends Exception {
	}
	
	
	public static void precessAmendmentAddProd(String zuoraSubId, String ProductRatePlanId, String ProductRatePlanChargeId, Decimal price, String zEntityId, String access_token){
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


}