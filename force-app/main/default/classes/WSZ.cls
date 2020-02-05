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
        public Datetime dateSubscription;
        public String lieu;
        public String agent;
        public String coupon = null;
        public String crmId;
        public String operation;
        public String codeLangue;
        public List<String> references = new List<String>();

        public SubOffreIn(Datetime dateSubscription, String lieu, String agent, String coupon,String crmId, String operation,String produit){
            this.dateSubscription = dateSubscription;
            this.dateSub = String.valueOf(dateSubscription);
            this.lieu = lieu;
            this.agent = agent;
            this.coupon = coupon;
            this.crmId = crmId;
            this.operation = operation;
            this.references.add(produit);
        }
        
        public SubOffreIn(){
        }
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
        public String HermesIntituleOffre;
        public String HermesIntituleOffreNL;
        public String name;
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


    //Classes for subscription update
    public class SubOut {
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
    
	public class RefundlIn2 {
        public String refundDate;
        public Decimal totalAmount;
        public String typeX;
        public String methodType;
        public String reasonCode;
        public String comment;
        public String TECH_RefundGatewayResponseCode;
        public String DateRejetBanque;
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

    public class GenericEmptyFields {
        public List<String> fieldsToNull;        
    }

    public class ImpayeIn {
        public String accountId;
        public String subscriptionId;
    }

    public class ImpayeOut {
        public String accountId;
        public String subscriptionId;
        public String subscriptionName;        
        public Double montantDetteEchue;
        public Date dateDetteEchue;        
        public Double montantFrais;
        public Double montantDetteNonEchue;
        public List<DetteEchue> detteEchues = new List<DetteEchue>();
        public Boolean hasImpaye;
        public Boolean success;
        public String message;
        public Integer errorCode;
    }

    public class DetteEchue {
        // public String typeDette;    
        public String invoiceId;
        public Date invoiceDate;
        public Double invoiceBalance;
        public Double invoiceTotalAmount;

        public DetteEchue(String invoiceId,  Date invoiceDate, Double invoiceBalance, Double invoiceTotalAmount){
            this.invoiceId = invoiceId;
            this.invoiceDate = invoiceDate;
            this.invoiceTotalAmount = invoiceTotalAmount;
            this.invoiceBalance = invoiceBalance;
        }
        //public String chargeId;
        //public String chargeName;
        //public Double chargeAmount;
        //public Double taxAmount;
        //public String serviceStartDate;
        //public String serviceEndDate;                
    }

    public class ImpayeReglerIn {
        public String accountId;
        public String subscriptionId;
        public Double montantPaye;
        public String methodPaiement;
        public String lieu;
        public String agent;
        public String referenceId;
        public Date dateVirement;

        public ImpayeReglerIn(String accountId, String subscriptionId, Double montantPaye, String methodPaiement, String lieu, String agent, String referenceId, Date dateVirement){
            this.accountId = accountId;
            this.subscriptionId = subscriptionId;            
            this.montantPaye = montantPaye;            
            this.methodPaiement = methodPaiement;
            this.lieu = lieu;
            this.agent = agent;
            this.referenceId = referenceId;
            this.dateVirement = dateVirement;             
        }
    }

    public class ImpayeReglerOut {
        public String accountId;
        public String subscriptionId;
        public Double montantPaye;
        public String referenceId;        
        public String paymentId;              
        public Boolean success;
        public String message;
        public Integer errorCode;

        public ImpayeReglerOut(String accountId, String subscriptionId, Double montantPaye, String referenceId, String paymentId){
            this.accountId = accountId;
            this.subscriptionId = subscriptionId;            
            this.montantPaye = montantPaye;            
            this.referenceId = referenceId;
            this.paymentId = paymentId;            
        }
        
        public ImpayeReglerOut(){

        }   
             
    }

    public class SubHermesIn {
        public String accountId; //ID Salesforce : [Obligatoire]
        public String accountZID; // -- ajoutee. [Obligatoire]
        public String subscriptionZID; //Id Zuora. [Obligatoire]
        public String subscriptionOldZID; //ancien contrat si migration. [Obligatoire](migration)
        public String subscriptionName; // -- ajoutee. [Obligatoire]
        public String origin; // [Obligatoire]
        // public String famille; 
        public String motif; // [Obligatoire](Acquisition, reedition carte)
        // public String sousMotif; // pas besoin
        public String lieu; // c est le code complexe(HORIZ, WEB...etc), remplace le champ cinema.
        public String commentairesInternes;
        // public String status; // pas besoin
        public String typeDeMigration;
        public String creditMemoId;
        // public String montantRembourser; // a verifier avec kevin
        // public String remboursementFaire;  // a verifier avec kevin
        public String dateFinContrat; 
        // public String montantRemboursementCalc; // a faire en local:creation case remboursement
        // public String dateDemande; // a faire en local: date du jour (creation case remboursmenet)
        // public String Account__r.PersonContactId; // -- a faire en local
        public String numeroCarte;
    }

    public class SubHermesOut {
        public String accountId; //ID Salesforce : [Obligatoire]
        public String accountZID; // -- ajoutee. [Obligatoire]
        public String subscriptionZID; //Id Zuora. [Obligatoire]
        public String subscriptionName;
        public String caseId;
        public Boolean success;
        public String message;
        public Integer errorCode;
        
        public SubHermesOut(String accountId, String accountZID, String subscriptionZID, String subscriptionName, String caseId){
            this.accountId = accountId;
            this.accountZID = accountZID;
            this.subscriptionZID = subscriptionZID;
            this.subscriptionName = subscriptionName;
            this.caseId = caseId;
        }
        
        public SubHermesOut(){

        }        

    }
  
    public class AuthorizeIn {
        public String accountSFID;
        public String lieu;
        public String agent;
        public String typeAgent;
    }
    
    public class AuthorizeOut {
		public Boolean success;
		public String message;
		public Integer errorCode;
		public String subscriptionName;
		public String subscriptionZID;
		public String subscriptionNameAvenir;
		public String subscriptionZIDAvenir;
		public String accountSFID;
		public String accountZID;
		public String porteurSFID;
		public String payeurSFID;
		public Boolean compteBloque;
		public String messageCompteBloque;
		public Integer codeBlocage;
		public list<AuthorizeOut_Autorisation> autorisations;
		public list<AuthorizeOut_Subscription> subscriptions;
		
		public AuthorizeOut(){
			autorisations = new list<AuthorizeOut_Autorisation>();
			subscriptions = new list<AuthorizeOut_Subscription>();
			list<String> listOperation = new list<String>{'acquisition', 'renouvellement', 'migration', 'reglerimpaye', 'changebanque', 'reeditioncarte', 'getimpaye'};
			for(String op : listOperation){
				autorisations.add(new AuthorizeOut_Autorisation(op));
			}
		}
	}
	
	public class AuthorizeOut_Autorisation {
		public String operation;
		public Boolean autorise;
		public Boolean visible;
		public Integer code;
		public String message;
		public String DateFinEligibilite;
		public set<String> produitEligible;
		
		public AuthorizeOut_Autorisation(String operation){
			this.operation 		= operation;
			autorise 			= false;
			visible 			= false;
			produitEligible 	= new set<String>();
		}
	}
	
	public class AuthorizeOut_Subscription {
		public String subscriptionName;
		public Date dateDebutContrat;
		public Date dateFinContrat;
		public String status;
		
		public AuthorizeOut_Subscription(String subscriptionName, Date dateDebutContrat, Date dateFinContrat, String status){
			this.subscriptionName 	= subscriptionName;
			this.dateDebutContrat 	= dateDebutContrat;
			this.dateFinContrat 	= dateFinContrat;
			this.status 			= status;
		}
	}

    public class ContratFileIn {
        //public String accountZID;
        public String accountSFID;        
        public String subscriptionName;
        public String subscriptionNameAvenir;
    }

    public class ContratFileOut {
        //public String accountZID;
        public String accountSFID;        
        public String subscriptionName;
        public String subscriptionNameAvenir;
        public String contratFile;
        public String contratFileAvenir;
        public Boolean success;
        public String message;
        public Integer errorCode;          
    }

    // public virtual class PreviewIn {
    //     public Date dateDebutContrat;
    //     public String lieu;
    //     public String agent;
    //     public String coupon;
    //     public String operation;
    //     public String accountSFID;
    //     //public String accountRCUID;
    //     public String payeurSFID;
    //     //public String payeurRCUID;
    //     //public String codeOffreCo;
    //     public List<String> produits = new List<String>();
        
    // }

    public class ProxyPreviewOut {
        public Boolean success;
        public String message;
        public Integer errorCode; 
        public String accountSFID;
        public List<Preview> preview = new List<Preview>();
    }

    public class Preview {
        public String produit;
        public String intituleOffre;
        //public String intituleOffreFR;
        //public String intituleOffreNL;
        //public Double abonnement;
        public Double montantInitial;
        //public Double fraisAdhesion;
        //public Double fraisAdhesionApresRemise;
        //public Double prorata;
        public String codeOffreCo;
        public Boolean isB2B;
        public Boolean isPrepaid;
        public Date dateDebutContrat;
        public Date dateFinContrat;
        public Decimal montantInitialNonRemise;
        public List<PreviewOffreDetail> offreDetail = new List<PreviewOffreDetail>();
        public List<PreviewDetail> previewDetail = new List<PreviewDetail>();
    }

    public class PreviewOffreDetail {
        public String reference;
        public String intituleRemise;

        public PreviewOffreDetail(String reference, String intituleRemise){
            this.reference = reference;
            this.intituleRemise = intituleRemise;
        }
    }

    public class PreviewDetail {
        public String reference;
        public String libelle;
        public Decimal montant;

        public previewDetail(String reference, String libelle, Decimal montant){
            this.reference = reference;
            this.libelle = libelle;
            this.montant = montant;
        }
    }

    
    public class SubOpeIn {
        public Datetime dateDebutContrat; //RENOUV, PREV
        public String subscriptionName; //RENOUV, MIG, PREV
        public String lieu; // ACQ, RENOUV, MIG, PREV
        public String agent; // ACQ, RENOUV, MIG, PREV
        public String coupon; // ACQ, RENOUV, MIG, PREV
        public String operation; // ACQ, RENOUV, MIG, PREV
        public String accountSFID; // ACQ, RENOUV, MIG, PREV
        //public String accountRCUID; // ACQ, RENOUV, MIG, PREV
        public String payeurSFID; // ACQ, RENOUV, MIG, PREV
        //public String payeurRCUID; // ACQ, RENOUV, MIG, PREV
        public String produit; // ACQ, RENOUV, MIG
        //public String produitActuel; //RENOUV, MIG
        public String codeOffreCo; // ACQ, RENOUV, MIG
        public String modeLivraison;  // ACQ, RENOUV, MIG
        public String numCarteParrain; // ACQ, RENOUV, MIG
        public String iban; // ACQ, RENOUV, MIG
        public String mandateId; // ACQ, RENOUV, MIG
        public Paiement paiement; // ACQ, RENOUV, MIG
        public String codeLangue;
        public List<String> produits = new List<String>(); // PREV

        public SubOpeIn(){
            paiement = new Paiement();
        }
    }

    public class Paiement {
        public Double montant;
        public String refPaiement;
        public String methodePaiement;
        public String lieu; // non expose en WS
        public String agent; // non expose en WS
        public Date dateVirement;

        public Paiement(){

        }

        public Paiement(Double montant, String refPaiement, String methodePaiement, String lieu, String agent, Date dateVirement){
            this.montant = montant;
            this.refPaiement = refPaiement;
            this.methodePaiement = methodePaiement;
            this.lieu = lieu;
            this.agent = agent;
            this.dateVirement = dateVirement;
        }
    }

    public class SubOpeOut {
        public Boolean success;
        public String message;
        public Integer errorCode;
        public String accountSFID; //ID Salesforce : [Obligatoire]
        public String accountZID; // -- ajoutee. [Obligatoire]
        //public String accountRCUID;
        public String subscriptionZID; //Id Zuora. [Obligatoire]
        public String subscriptionName;
        public Boolean compteBloque;
        //public String caseId;
        public String invoiceFileUrl; //non utilise
        public Boolean rembourser;
        public String paymentId;
        public String caseId;
        public String payMethodId;
        public String invoiceId;
        public String fileImpId;
        public List<String> sDocjobIds;
        
        public SubOpeOut(String accountSFID, String accountZID, String subscriptionZID, String subscriptionName, Boolean compteBloque,
        String invoiceFileUrl, Boolean rembourser, String paymentId, String caseId, String payMethodId, String invoiceId, String fileImpId, List<String> sDocjobIds ){
            this.accountSFID = accountSFID;
            this.accountZID = accountZID;
            //this.accountRCUID =  accountRCUID;
            this.subscriptionZID = subscriptionZID;
            this.subscriptionName = subscriptionName;
            this.compteBloque =  compteBloque;
            this.invoiceFileUrl =  invoiceFileUrl;
            this.rembourser =  rembourser;
            this.paymentId = paymentId;
            this.caseId = caseId;
            this.payMethodId = payMethodId;
            this.invoiceId = invoiceId;
            this.fileImpId = fileImpId;
            this.sDocjobIds = sDocjobIds;
        }
        
        public SubOpeOut(){

        }        

    }

    public class SubOpeOutH {
        public Boolean success;
        public String message;
        public Integer errorCode;
        public String accountSFID; //ID Salesforce : [Obligatoire]
        public String accountZID; // -- ajoutee. [Obligatoire]
        //public String accountRCUID;
        public String subscriptionZID; //Id Zuora. [Obligatoire]
        public String subscriptionName;
        public Boolean compteBloque;
        //public String caseId;
        public String invoiceFileUrl;
        public Boolean rembourser;
    }    

    public class InvokeWrapperIn {
        @InvocableVariable @AuraEnabled
        public String operation;
        @InvocableVariable @AuraEnabled
        public String inputJSON;
        @InvocableVariable @AuraEnabled
        public String inputClass;
    }

    public class ReeditionIn {
        public String subscriptionName; 
        public String lieu; 
        public String agent; 
        public String accountSFID; 
        //public String accountRCUID; 
        public String modeLivraison;  
        public Paiement paiement; 
        public Boolean isGratuit;
    }    

    public class ReeditionOut {
        public Boolean success;
        public String message;
        public Integer errorCode;
        public String accountSFID; //ID Salesforce : [Obligatoire]
        public String accountZID; // -- ajoutee. [Obligatoire]
        //public String accountRCUID;
        public String subscriptionZID; //Id Zuora. [Obligatoire]
        public String subscriptionName;
        public Boolean compteBloque;
        public String paymentId;
        public String invoiceId;        
        public String caseId;
        public String fileImpId;        

        public ReeditionOut(String accountSFID, String accountZID, String subscriptionZID, String subscriptionName,
            Boolean compteBloque, String paymentId, String invoiceId, String caseId, String fileImpId){

            this.accountSFID = accountSFID;
            this.accountZID = accountZID;
            //this.accountRCUID =  accountRCUID;
            this.subscriptionZID = subscriptionZID;
            this.subscriptionName = subscriptionName;
            this.compteBloque =  compteBloque;
            this.paymentId = paymentId;
            this.caseId = caseId;
            this.invoiceId = invoiceId;
            this.fileImpId = fileImpId;
        }
        
        public ReeditionOut(){

        }

    }

    public class ReeditionOutH {
        public Boolean success;
        public String message;
        public Integer errorCode;
        public String accountSFID; //ID Salesforce : [Obligatoire]
        public String accountZID; // -- ajoutee. [Obligatoire]
        //public String accountRCUID;
        public String subscriptionZID; //Id Zuora. [Obligatoire]
        public String subscriptionName;
        public Boolean compteBloque;
        // public String paymentId;
        // public String invoiceId;        
        // public String caseId;
        // public String fileImpId;
    }   

    // pour un test de datetime
    public class SubOffreIn2 {     
        public Datetime dt1;
        
    }


}