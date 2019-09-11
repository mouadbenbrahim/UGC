/**
 * Created by  mouad on 05/09/2018.
 */

public with sharing class WSZ {

    public class InvoiceItemsOut {

        public List<InvoiceItem> invoiceItems = null;
        public Boolean success;

    }

    public class InvoiceItem {

        public String id;
        public String subscriptionName;
        public String subscriptionId;
        public String serviceStartDate;
        public String serviceEndDate;
        public Double chargeAmount;
        public String chargeDescription;
        public String chargeName;
        public String chargeId;
        public String chargeType;
        public String chargeDate;
        public String productName;
        public Double quantity;
        public Double taxAmount;
        public String unitOfMeasure;
        public String appliedToItemId;
        public String processingType;
        public String balance;
        public String availableToCreditAmount;
        public taxationItem taxationItems;
    }

    public class taxationItem {
        public List<taxationItemsdata> data;
    }

    public class taxationItemsdata {

        public Double balance;
        public Double paymentAmount;
        public Double creditAmount;
        public String id;
        public Double taxAmount;
        public String name;
        public Double exemptAmount;
        public String jurisdiction;
        public String locationCode;
        public String taxCode;
        public String taxCodeDescription;
        public String taxDate;
        public Double taxRate;
        public String taxRateDescription;
        public String taxRateType;
        public String availableToCreditAmount;


    }


    public class PaymentPartsOut {
        public List<PaymentPart> parts;
        public Boolean success;
    }


    public class PaymentPart {
        public String id;
        public String debitMemoId;
        public String invoiceId;
        public Double amount;
        public String createdDate;
        public String createdById;
        public String updatedDate;
        public String updatedById;
    }


    public class CouponIn {
        public String coupon;
        public String dateSub;
    }

    public class GenericOut {
        public Boolean Success;
        public String Message;
        public Integer ErrorCode;
        public String Name;
        public String objetId;
    }


    public class CouponGeneric {
        public ID Id;
        public ID ItemId;
        public String Name;
        public String RecordType;
        public Date DateDebut;
        public Date DateFin;
        public Double PrixVente;
        public Double QuantiteDisponible;
        public Double QuantiteUtilise;
        public Boolean Utilise;
        public Boolean isAvailable;
        public String Type;
        public String Agent;
        public String Account;

    }

    public class SubOffreIn {
        public String dateSub;
        public Date dateSubscription;
        public String lieu;
        public String agent;
        public String coupon = null;
        public String crmId;
        public String operation;
        public List<String> references;
    }

    public class SubOffreOut {
        public Boolean Success = true;
        public String Message;
        public Integer ErrorCode;
        public List<SubProduct> subProducts = null;
    }

    public class ChargeOverride {
        public String productRatePlanChargeId;
        public String endDateCondition;
        public String specificEndDate;
        public String lieu_c;
        public String agent_c;
        public String intitule_c;
        public Integer upToPeriods;
        public String triggerEvent;
        public String triggerDate;
        public Double discountPercentage;
        public Double discountAmount;
        public Double price;
    }

    public class SubProduct {
        public String Reference;
        public String HermesIntituleOffre;
        public String HermesIntituleOffreNL;
        public String Marche;
        public String CodeOffreCo;
        public Boolean IsB2B;
        public Boolean IsPrepaid;
        public List<SubscribeToRatePlan> subscribeToRatePlans = null;
    }

    public class SubscribeToRatePlan {
        public String productRatePlanId;
        public String lieu_c;
        public String agent_c;
        public String intitule_c;
        public List<ChargeOverride> chargeOverrides = new List<ChargeOverride>();
    }


    public class ProdRatePlanChargeOut {

        public List<ProdRatePlanCharge> records = null;
        public Integer size;
        public Boolean done;

    }

    public class ProdRatePlanCharge {

        public String chargeModel;
        public String createdDate;
        public String id;
        public String name;
        public String chargeType;
        public String reference_c;
        public String familleRPC_c;
        public String productRatePlanId;
        public String updatedDate;
        public String description;
        public String eligibleoffre_c;
        public String referenceCIC_c;
    }

    public class Zquery {

        public String queryString;

    }
    public class ProdRatePlanOut {

        public List<ProdRatePlan> records = null;
        public Integer size;
        public Boolean done;

    }

    public class ProdRatePlan {

        public String productId;
        public String famille_c;
        public String id;
        public String createdById;
        public String createdDate;
        public String name;
        public String reference_c;
        public String effectiveEndDate;
        public String updatedDate;
        public String updatedById;
        public String effectiveStartDate;
        public String description;
        public String produit_c;
        public String referenceCIC_c;
    }

    public class CarteAddIn {
        public String CardID;
        public Integer CardSubType;
        public String DebutValidite;
        public String FinValidite;
        public Double PrixContrepartie;
        public Integer Reference;
        public String DateCle;
        public String DernierNumero;
    }


    public class CarteOut {
        public String Id;
        public Integer TypeCarteId;
        public Integer SousTypeCarteId;
        public String PortefeuilleId;
        public Integer Reference;
        public Integer Statut;
        public Integer BlacklistId;
        public String DebutValidite;
        public String FinValidite;
        public Boolean Supprime;
        public String DateCreation;
        public String DateModification;
    }

    public class CreditMemoOut {
        public String id;
        public String numberx;
        public String accountId;
        public String currencyTMP;
        public String creditMemoDate;
        public String targetDate;
        public String postedById;
        public String postedOn;
        public String status;
        public String taxStatus;
        public String taxMessage;
        public Double amount;
        public Double taxAmount;
        public Double totalTaxExemptAmount;
        public Double unappliedAmount;
        public Double refundAmount;
        public Double appliedAmount;
        public String comment;
        public String source;
        public String sourceId;
        public String referredInvoiceId;
        public String reasonCode;
        public String createdDate;
        public String createdById;
        public String updatedDate;
        public String updatedById;
        public String cancelledOn;
        public String cancelledById;
        public String latestPDFFileId;
        public String transferredToAccounting;
        public Boolean excludeFromAutoApplyRules;
        public Boolean autoApplyUponPosting;
        public Boolean success;

    }


    //CLasses for subscription update
    public without sharing class SubOut {
        public Boolean Success;
        public String Id;
    }


    //Classes subscription cancel:
    public class SubCancelIn {
        public String cancellationEffectiveDate;
        public String cancellationPolicy;
        public Boolean runBilling;
        public String targetDate;
        //public Boolean xcollect;
    }

    public class SubCancelOut {
        public Boolean success;
        public String subscriptionId;
        public String cancelledDate;
        public String totalDeltaMrr;
        public String totalDeltaTcv;
        public String invoiceId;
        public String creditMemoId;
    }


    public class DebitMemoCreate {
        public DebitMemoCreateInp inp;
        public DebitMemoOut out;
    }

    public class memoItemCharge {
        public Double memoItemAmount;
        public String chargeId;
        public String comment;

        public memoItemCharge(String mChargeId, Double mAmount) {
            this.memoItemAmount = mAmount;
            this.chargeId = mChargeId;
        }

    }


    public class DebitMemoCreateInp {
        public String accountId;
        public Boolean autoPay;
        public List<memoItemCharge> charges = new List<memoItemCharge>();
        public String comment;
        public String effectiveDate;
        public String reasonCode;
    }

    public class DebitMemoOut {
        public String id;
        public String numberx;
        public String accountId;
        public String debitMemoDate;
        public String currencyTMP;
        public Object targetDate;
        public String dueDate;
        public Object postedOn;
        public Object postedById;
        public String status;
        public Double amount;
        public Double taxAmount;
        public Double totalTaxExemptAmount;
        public Double balance;
        public Double beAppliedAmount;
        public Boolean autoPay;
        public String comment;
        public Object referredInvoiceId;
        public String transferredToAccounting;
        public String reasonCode;
        public String createdDate;
        public String createdById;
        public String updatedDate;
        public String updatedById;
        public Object cancelledOn;
        public Object cancelledById;
        public Object latestPDFFileId;
        public Boolean success;
    }
    
    public class BillRunlIn {
        public String AccountId;
        public boolean AutoEmail;
        public boolean AutoPost;
        public boolean AutoRenewal;
        public String InvoiceDate;
        public String TargetDate;
    }
    
    public class RefundlIn {
        public String refundDate;
        public Decimal totalAmount;
        public String typeX;
        public String methodType;
        public String reasonCode;
        public String comment;
        //public FinanceInformation financeInformation;
    }
    
    public class RefundOut {
        public String id;
        public String numberX;                  //number
        public String status;
        public String typeX;                    //type
        public String methodType;
        public String accountId;
        public Double amount;
        public String refundDate;
        public String comment;
        public String paymentMethodId;
        public String paymentMethodSnapshotId;
        public String paymentId;
        public String creditMemoId;
        public String reasonCode;
        public String gatewayId;
        public String gatewayResponse;
        public String gatewayResponseCode;
        public String gatewayState;
        public String markedForSubmissionOn;
        public String referenceId;
        public String secondRefundReferenceId;
        public String softDescriptor;
        public String softDescriptorPhone;
        public String submittedOn;
        public String settledOn;
        public String cancelledOn;
        public String createdDate;
        public String createdById;
        public String updatedDate;
        public String updatedById;
        public String refundTransactionTime;
        public String Canal;                    //Canal__c
        public String Agent;                    //Agent__c
        public String Lieu;
        public String TECH_RefundGatewayResponseCode; 
        public String DateRejetBanque;
        public String TECH_DejaTraiter;
        public String TECH_RefundCreatedDate;                    
        public boolean success;
        public FinanceInformation financeInformation;
    }
    
    public class FinanceInformation {
        public String bankAccountAccountingCode;
        public String bankAccountAccountingCodeType;
        public String unappliedPaymentAccountingCode;
        public String unappliedPaymentAccountingCodeType;
        public String onAccountAccountingCode;
        public String onAccountAccountingCodeType;
        public String transferredToAccounting;
    }
    
    public class BillRunOut {
        public boolean AutoRenewal;
        public String TargetDate;
        public String Id;
        public Double NumberOfInvoices;
        public String UpdatedDate;
        public String AccountId;
        public boolean AutoPost;
        public boolean NoEmailForZeroAmountInvoice;
        public Double NumberOfAccounts;
        public String BillRunNumber;
        public String Status;
        public String ExecutedDate;
        public String InvoiceDate;
        public String UpdatedById;
        public boolean AutoEmail;
        public String CreatedById;
        public boolean InvoicesEmailed;
        public String CreatedDate;
    }
    
    public class ListCreditMemosOut {
        public List<CreditMemo> creditmemos;
        public boolean success;
    }
    
    public class CreditMemo {
        public String id;
        public String numberX;              //number
        public String accountId;
        public String currencyX;            //currency
        public String creditMemoDate;
        public String targetDate;
        public String postedById;
        public String postedOn;
        public String status;
        public Double amount;
        public Double taxAmount;
        public Double totalTaxExemptAmount;
        public Double unappliedAmount;
        public Double refundAmount;
        public Double appliedAmount;
        public String comment;
        public String source;
        public String sourceId;
        public String referredInvoiceId;
        public String reasonCode;
        public String createdDate;
        public String createdById;
        public String updatedDate;
        public String updatedById;
        public String cancelledOn;
        public String cancelledById;
        public String latestPDFFileId;
        public String transferredToAccounting;
        public boolean excludeFromAutoApplyRules;
        public boolean autoApplyUponPosting;
    }
    
    
    public class UnapplyPaymentIn {
    	public list<UnapplyPaymentInItem> invoices;
    	
    	public UnapplyPaymentIn(){
    		this.invoices = new list<UnapplyPaymentInItem>();
    	}
    }
    
    public class UnapplyPaymentInItem {
    	public Decimal amount;
	 	public String invoiceId;
	 	
	 	/*public UnapplyPaymentInItem(String invoiceId, Decimal amount){
	 		this.invoiceId = invoiceId;
	 		this.amount = amount;
	 	}*/
    }
    
    public class ApplyCreditMemoIn {
    	public String effectiveDate;
    	public list<UnapplyPaymentInItem> invoices;
    	
    	public ApplyCreditMemoIn(){
    		this.invoices = new list<UnapplyPaymentInItem>();
    	}
    }


    public class CreateCreditMemoIn {
        public String effectiveDate;
        public Boolean autoApplyToInvoiceUponPosting;
        public Boolean taxAutoCalculation;
        public list<CreateCreditMemoInItem> items;
        
        public CreateCreditMemoIn(){
            this.items = new list<CreateCreditMemoInItem>();
        }
    }


    public class CreateCreditMemoInItem {
        public Double amount;
        public String invoiceItemId;
        public String skuName;
        public List<CreditTaxationItemIn> taxItems;

        public CreateCreditMemoInItem(){
            this.taxItems = new list<CreditTaxationItemIn>();
        }
    }
   

    public class CreditTaxationItemIn {
        public Double amount;
        public String taxName;
        public String taxDate;
        public Double taxRate;
        public Double taxExemptAmount;
        public String taxRateType;
        public String taxRateDescription;
        public String taxCodeDescription;
        public String taxCode;
        public String locationCode;
        public String jurisdiction;
        public String sourceTaxItemId;
    }

    public class AmendOut {
		public boolean success;
		public String id;
		public String code;
		public String name;
		public String typeX;
		public String description;
		public String status;
		public String contractEffectiveDate;
		public String serviceActivationDate;
		public String customerAcceptanceDate;
		public String effectiveDate;
		public String newSubscriptionId;
		public String baseSubscriptionId;
		public String termType;
		public String currentTerm;
		public String currentTermPeriodType;
		public String termStartDate;
		public String renewalSetting;
		public String renewalTerm;
		public String renewalTermPeriodType;
		public String autoRenew;
		public String specificUpdateDate;
		public String newRatePlanId;
		public String baseRatePlanId;
		public String destinationAccountId;
		public String destinationInvoiceOwnerId;
    }
    
    public class DeleteIn {
    	public list<String> ids;
 		public String typeX;
 		
 		public DeleteIn(list<String> ids, String typeX){
    		this.ids = ids;
    		this.typeX = typeX;
    	}
    }
    
    //pareil que SubOut sans les majuscule (sensible a la cast)
    public class DeleteOut {
        public Boolean success;
        public String id;
    }

    public class SubUpdateIn {

        public List<Zuora__Subscription__c> objects = new List<Zuora__Subscription__c>();
        public String type;


        public SubUpdateIn(List<Zuora__Subscription__c> subs) {
            this.objects = subs;
            this.type = 'Subscription';
        }

    }


    public class SubItem {

        public String id;
        public String TarifFacture_c;
        public String DateTarifFacture_c;


        public SubItem(String id, String TarifFacture_c, String DateTarifFacture_c) {
            this.id = id;
            this.TarifFacture_c = TarifFacture_c;
            this.DateTarifFacture_c = DateTarifFacture_c;
        }

    }

    public class price {
        public String typeDate;
        public Decimal tarif;
        public Date dateTarif;

        public price(String typeDate, Decimal tarif, Date dateTarif){
            this.typeDate = typeDate;
            this.tarif = tarif;
            this.dateTarif = dateTarif;
        }

    }

    public without sharing class WRPOauthLogin{
        public String access_token;
        public String token_type;
        public String expires_in;
        public String scope;
        public String jti;

        public WRPOauthLogin(String access_token){
            this.access_token = access_token;
            // this.expires_in = expires_in;
        }
    }

    public class PaymentRunIn {
      
        public String batch;
        public Boolean autoApplyCreditMemo;
        public Boolean autoApplyUnappliedPayment;
        public Boolean consolidatedPayment;
        public Boolean collectPayment;
        public Boolean processPaymentWithClosedPM;
        public String runDate;

    }

    public class AmendIn {
        public String id;
        public String code;
        public String name;
        public String typeX;
        public String description;
        public String status;
        public String contractEffectiveDate;
        public String serviceActivationDate;
        public String customerAcceptanceDate;
        public String effectiveDate;
        public String newSubscriptionId;
        public String baseSubscriptionId;
        public String termType;
        public String currentTerm;
        public String currentTermPeriodType;
        public String termStartDate;
        public String renewalSetting;
        public String renewalTerm;
        public String renewalTermPeriodType;
        public String autoRenew;
        public String specificUpdateDate;
        public String newRatePlanId;
        public String baseRatePlanId;
        public String destinationAccountId;
        public String destinationInvoiceOwnerId;
        public String operation_c;

        public AmendIn(String id, String operation_c){
            this.id = id;
            this.operation_c = operation_c;
        }
    }

    //CLasses for subscription update
    public class GenericOut2 {
        public Boolean Success;
        public String Id;
    }


    public class SlmRefundIn {

        public Creditor creditor;
        public Mandate mandate;
        public Integer amount;
        public String label;
        public String reference;
        public String scheme;

        public SlmRefundIn(String creditor, String mandate, Integer amount, String label, String reference, String scheme){
            this.creditor = new Creditor(creditor);
            this.mandate = new Mandate(mandate);
            this.amount = amount;
            this.label = label;
            this.reference = reference;
            this.scheme = scheme;
        }
    }

    public class Creditor {
        public String reference;

        public Creditor(String reference){
            this.reference = reference;
        }
    }

    public class Mandate {
        public String reference;

        public Mandate(String reference){
            this.reference = reference;
        }
    }
    
    public class CreatePaymentIn {
		public String accountId;
		public Decimal amount;
		public String effectiveDate;
		public String paymentMethodId;
		public String typeX;
		public String currencyX; 
		public list<UnapplyPaymentInItem> invoices;
		
		public CreatePaymentIn(String accountId, String invoiceId, Decimal amount, String paymentMethodId){
			this.accountId = accountId;
			this.amount = amount;
            this.effectiveDate = String.valueOf(Date.Today());
            this.paymentMethodId = paymentMethodId;
            this.typeX = 'External';
            this.currencyX = 'EUR';
            this.invoices = new list<UnapplyPaymentInItem>();
            UnapplyPaymentInItem tmp = new UnapplyPaymentInItem();
            tmp.invoiceId = invoiceId;
	 		tmp.amount = amount;
            this.invoices.add(tmp);
        }
	}


}


//CancelSubsctipion
/*    "success": true,
    "subscriptionId": "8adcc59c658a22b70165a9cfc966690a",
    "cancelledDate": "2018-12-15",
            "totalDeltaMrr": 0,
            "totalDeltaTcv": -208.779999993,
    "creditMemoId": "8adcc59c658a22b70165a9cfcab5691d"

    OU


{
    "success": true,
    "subscriptionId": "8adcc59c658a22b70165a9aabd9e3fce",
    "cancelledDate": "2018-12-15",
    "totalDeltaMrr": 0,
    "totalDeltaTcv": -208.779999993,
    "invoiceId": "8adcc59c658a22b70165a9aabe933fed"
}
    */



//Debit Memo output
/*
{
"id": "8adcc59c658a22b70165aa1ee57755df",
"number": "FDM00000006",
"accountId": "8adce42165650a1b01658a0b3e1d1d5d",
"debitMemoDate": "2018-12-15",
"currency": "EUR",
"targetDate": null,
"dueDate": "2018-12-15",
"postedOn": null,
"postedById": null,
"status": "Draft",
"amount": 13,
"taxAmount": 0.68,
"totalTaxExemptAmount": 0,
"balance": 13,
"beAppliedAmount": 0,
"autoPay": false,
"comment": "pour ajutser un credit memo automatique",
"referredInvoiceId": null,
"transferredToAccounting": "No",
"reasonCode": "Correcting invoice error",
"createdDate": "2018-09-05 16:24:36",
"createdById": "8adc8f996445f87c0164602944942186",
"updatedDate": "2018-09-05 16:24:36",
"updatedById": "8adc8f996445f87c0164602944942186",
"cancelledOn": null,
"cancelledById": null,
"latestPDFFileId": null,
"success": true
}*/


//Post debitmemo
/*{
    "id": "8adcc59c658a22b70165aa1ee57755df",
    "number": "FDM00000006",
    "accountId": "8adce42165650a1b01658a0b3e1d1d5d",
    "debitMemoDate": "2018-12-15",
    "currency": "EUR",
    "targetDate": null,
    "dueDate": "2018-12-15",
    "postedOn": "2018-09-05 16:31:09",
    "postedById": "8adc8f996445f87c0164602944942186",
    "status": "Posted",
    "amount": 13,
    "taxAmount": 0.68,
    "totalTaxExemptAmount": 0,
    "balance": 13,
    "beAppliedAmount": 0,
    "autoPay": false,
    "comment": "pour ajutser un credit memo automatique",
    "referredInvoiceId": null,
    "transferredToAccounting": "No",
    "reasonCode": "Correcting invoice error",
    "createdDate": "2018-09-05 16:24:36",
    "createdById": "8adc8f996445f87c0164602944942186",
    "updatedDate": "2018-09-05 16:31:09",
    "updatedById": "8adc8f996445f87c0164602944942186",
    "cancelledOn": null,
    "cancelledById": null,
    "latestPDFFileId": null,
    "success": true
}
*/


// Apply Credit memo to a debit memo:
/*
{
    "id": "8adc9a41658a0b810165a9fbea981d27",
    "number": "FCM00000007",
    "accountId": "8adce42165650a1b01658a0b3e1d1d5d",
    "currency": "EUR",
    "creditMemoDate": "2018-12-15",
    "targetDate": "2018-12-15",
    "postedById": "8adc8f996445f87c0164602944942186",
    "postedOn": "2018-09-05 15:46:23",
    "status": "Posted",
    "amount": 12.01,
    "taxAmount": 0,
    "totalTaxExemptAmount": 0,
    "unappliedAmount": 6.01,
    "refundAmount": 0,
    "appliedAmount": 6,
    "comment": null,
    "source": "ApiAmend",
    "sourceId": null,
    "referredInvoiceId": null,
    "reasonCode": "Correcting invoice error",
    "createdDate": "2018-09-05 15:46:23",
    "createdById": "8adc8f996445f87c0164602944942186",
    "updatedDate": "2018-09-05 16:48:42",
    "updatedById": "8adc8f996445f87c0164602944942186",
    "cancelledOn": null,
    "cancelledById": null,
    "latestPDFFileId": "8adcb9fe658a09170165a9fbec12325a",
    "transferredToAccounting": "No",
    "excludeFromAutoApplyRules": false,
    "autoApplyUponPosting": false,
    "success": true
}
 */