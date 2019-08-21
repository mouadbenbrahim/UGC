public without sharing class SM00X2_Canevas2 {
    
    public enum Pays {France, Belgique}
    
    public static WRPRep zuoraGetAccount(String access_token){
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        string endpoint =  '/v1/accounts/B00000005';
        //req.setEndpoint(endpoint);
        req.setEndpoint('callout:ZuoraAPI'+endpoint);
        
        
        req.setMethod('GET');
        req.setHeader('Content-Type', 'application/json');
        /*if(pays == Pays.France){
        	req.setHeader('Zuora-Entity-Ids', '8adc8f99690e257001690e9c372515fe');//France
        } else {
        	req.setHeader('Zuora-Entity-Ids', '8adce421-63ec-c07b-0163-f457db12717e');//Belgique
        }*/
        req.setHeader('Zuora-Entity-Ids', '8adce421-63ec-c07b-0163-f457db12717e');//Belgique
        req.setHeader('Authorization', 'Bearer '+access_token);
        
        req.setCompressed(true);
        req.setTimeout(60000);
        HttpResponse res = null;
        res = h.send(req);
        string responseValue = '';
        responseValue = res.getBody();
        //blob res2 = res.getBodyAsBlob();
		
        responseValue = responseValue.replace('"currency"', '"currencyTMP"');
        //responseValue = responseValue.replace('"name"', '"nameTMP"');
        
        system.debug('##MNE responseValue >> '+responseValue);
        
        WRPRep wrp = (WRPRep)JSON.deserializeStrict(responseValue,WRPRep.class);
        
        return wrp;
    }

    public without sharing class WRPRep {
		public BasicInfo basicInfo;
		public BillingAndPayment billingAndPayment;
		public Metrics metrics;
		public BillToContact billToContact;
		public SoldToContact soldToContact;
		public TaxInfo taxInfo;
		public Boolean success;
	}

	public without sharing class BasicInfo {
		public String id;
		public String name;
		public String accountNumber;
		public String notes;
		public String status;
		public String crmId;
		public String batch;
		public String invoiceTemplateId;
		public String communicationProfileId;
		public String salesRep;
		public String creditMemoTemplateId;
		public String debitMemoTemplateId;
	}
	
	public without sharing class BillingAndPayment {
		public String billCycleDay;
		public String currencyTMP;
		public String paymentTerm;
		public String paymentGateway;
		public Boolean invoiceDeliveryPrefsPrint;
		public Boolean invoiceDeliveryPrefsEmail;
		public List<String> additionalEmailAddresses = null;
	}
	
	public without sharing class Metrics {
		public String balance;
		public String totalInvoiceBalance;
		public String creditBalance;
		public String totalDebitMemoBalance;
		public String unappliedPaymentAmount;
		public String unappliedCreditMemoAmount;
		public String contractedMrr;
	}

	public without sharing class BillToContact {
		public String address1;
		public String address2;
		public String city;
		public String country;
		public String county;
		public String fax;
		public String firstName;
		public String homePhone;
		public String lastName;
		public String mobilePhone;
		public String nickname;
		public String otherPhone;
		public String otherPhoneType;
		public String personalEmail;
		public String state;
		public String taxRegion;
		public String workEmail;
		public String workPhone;
		public String zipCode;
	}
	
	public without sharing class SoldToContact {
		public String address1;
		public String address2;
		public String city;
		public String country;
		public String county;
		public String fax;
		public String firstName;
		public String homePhone;
		public String lastName;
		public String mobilePhone;
		public String nickname;
		public String otherPhone;
		public String otherPhoneType;
		public String personalEmail;
		public String state;
		public String taxRegion;
		public String workEmail;
		public String workPhone;
		public String zipCode;
	}
	
	public without sharing class TaxInfo {
		public String exemptStatus;
		public String exemptCertificateId;
		public String exemptCertificateType;
		public String exemptIssuingJurisdiction;
		public String exemptEffectiveDate;
		public String exemptExpirationDate;
		public String exemptDescription;
		public String exemptEntityUseCode;
		public String companyCode;
		public String vATId;
	}

}