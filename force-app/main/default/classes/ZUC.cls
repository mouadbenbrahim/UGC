/**
 * @File Name          : ZUC.cls
 * @Description        : 
 * @Author             : mouad
 * @Group              : 
 * @Last Modified By   : mouad
 * @Last Modified On   : 23/09/2019 à 00:57:02
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    07/09/2019   mouad     Initial Version
**/
public with sharing class ZUC {

private static Map<String,String> requestMap;

// public ZUC(){
//     this.requestMap = new Map<String,String>();
// }


public void addMap(Map<String,String> curMap){
    // this.requestMap.putAll(curMap);
}

public class ActionAmendRequest {

    //  public List<ZUC.AmendRequest> requests = new List<ZUC.AmendRequest>();
    public List<ZUC.AmendRequest> requests { get; set; }
   
    public ActionAmendRequest(){
        requests = new List<ZUC.AmendRequest>();
        // requestMap.putALL(new Map<String, String>{'a1' => 'aa1'});
        // system.debug(requestMap);
     }
     


}

// add manually by mouad
public class ActionAmendResult {

    //  public List<ZUC.AmendRequest> requests = new List<ZUC.AmendRequest>();
    public List<ZUC.AmendResult> results { get; set; }
   
    public ActionAmendResult(){
        results = new List<ZUC.AmendResult>{new ZUC.AmendResult()};
     }
     
    // private final Map<String, String> propertyMappings = new Map<String, String>{
    //     'results' => 'results'
    // };

}

public class AmendRequest implements WS001_CallZuora.MappedProperties {

    public AmendRequest() {
        amendments = new List<Amendment>();
        //this.amendOptions = new AmendRequestAmendOptions();
        //this.previewOptions = new AmendRequestPreviewOptions();
        // super.addMap(new Map<String, String>{'b1' => 'bb1'});
    }

    /**
    * Get amendOptions
    * @return amendOptions
    */
    public AmendRequestAmendOptions amendOptions { get; set; }

    /**
    * The `Amendment` object holds the changes that you want to make to the Subscription specified by the `SubscriptionId`, \nincluding its `RatePlan`, `RatePlanCharge`, and `RatePlanChargeTier`.\n
    * @return amendments
    */
    public List<Amendment> amendments { get; set; }

    /**
    * Get previewOptions
    * @return previewOptions
    */
    public AmendRequestPreviewOptions previewOptions { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'AmendOptions' => 'amendOptions',
        'Amendments' => 'amendments',
        'PreviewOptions' => 'previewOptions'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

}


public class Amendment {
    
    // Public Amendment(){
    //     this.ratePlanData = new AmendmentRatePlanData();
    // }
    /**
    *  Determines whether the subscription is automatically renewed, or whether it expires at the end of the term and needs to be manually renewed. For amendment of type `TermsAndConditions`, this field is only required if you change the automatic renewal status of a subscription.\n\n\n**Values**: true, false 
    * @return autoRenew
    */
    public Boolean autoRenew { get; set; }

    /**
    *  A unique alphanumeric string that identifies the amendment.\n\n\n**Character limit**: 50\n\n**Values**: one of the following:\n\n- `null` generates a value automatically\n- A string\n
    * @return code
    */
    public String code { get; set; }

    /**
    *  The date when the amendment\'s changes become effective for billing purposes.\n
    * @return contractEffectiveDate
    */
    public Date contractEffectiveDate { get; set; }

    /**
    *  The user ID of the person who created the amendment.\n\n\n**Character limit**: 32\n\n**Values**: automatically generated 
    * @return createdById
    */
    public String createdById { get; set; }

    /**
    *  The date when the amendment was created.\n\n\n**Values**: automatically generated 
    * @return createdDate
    */
    public Datetime createdDate { get; set; }

    /**
    *  The length of the period for the current subscription term. This field can be updated when Status is `Draft`.\n\nThis field is only required if the `Type` field is set to `TermsAndConditions` and `TermType` is set to `TERMED`. This field is not required if `TermType` is set to `EVERGREEN`.\n\n\n**Values**: a valid number 
    * @return currentTerm
    */
    public Long currentTerm { get; set; }

    /**
    *  The period type for the current subscription term. This field is only required if the `Type` field is set to `TermsAndConditions` and `TermType` is set to `TERMED`. This field is not required if `TermType` is set to `EVERGREEN`.\n\n**Values**:\n\n- `Month` (default)\n- `Year`\n- `Day`\n- `Week`\n\n\n**Note**:\n\n- This field can be updated when Status is `Draft`.\n- This field is used with the CurrentTerm field to specify the current subscription term.\n
    * @return currentTermPeriodType
    */
    public String currentTermPeriodType { get; set; }

    /**
    * The date when the customer accepts the amendment\'s changes to the subscription.\n\nThis field is only required if [Zuora is configured to require customer acceptance in Z-Billing](https://knowledgecenter.zuora.com/CB_Billing/W_Billing_and_Payments_Settings/Define_Default_Subscription_Settings) and the subscription is currently in the Pending Acceptance status (the value of the `Status` field is currently `PendingAcceptance`).\n\nUse this field together with the `Status` field. When you set a date in this field as a customer acceptance date, you should also set the `Status` field as `Completed`.\n
    * @return customerAcceptanceDate
    */
    public Date customerAcceptanceDate { get; set; }

    /**
    *  A description of the amendment.\n\n\n**Character limit**: 500\n\n**Values**: maximum 500 characters 
    * @return description
    */
    public String description { get; set; }

    /**
    *  The ID of the subscription owner that the subscription is being transferred to.\n\n\n**Character limit**: 32\n\n**Values**: a valid account ID 
    * @return destinationAccountId
    */
    public String destinationAccountId { get; set; }

    /**
    *  The ID of the invoice owner that the subscription is being transferred to.\n\n\n**Character limit**: 32\n\n**Values**: a valid invoice ID 
    * @return destinationInvoiceOwnerId
    */
    public String destinationInvoiceOwnerId { get; set; }

    /**
    *  The date when the amendment\'s changes take effective. This field validates that the amendment\'s changes are within valid ranges of products and product rate plans.\nThis field is only required if the `Type` field is set to `Cancellation`.\n\n
    * @return effectiveDate
    */
    public Date effectiveDate { get; set; }

    /**
    *  The name of the amendment.\n\n\n**Character limit**: 100\n\n**Values**: a string of 100 characters or fewer 
    * @return name
    */
    public String name { get; set; }

    /**
    * Get ratePlanData
    * @return ratePlanData
    */
    public AmendmentRatePlanData ratePlanData { get; set; }

    /**
    *  Specifies whether a termed subscription will remain termed or change to evergreen when it is renewed.\n\nThis field is only required if the `TermType` field is set to `Termed`.\n\n\n**Values**: RENEW_WITH_SPECIFIC_TERM (default), RENEW_TO_EVERGREEN 
    * @return renewalSetting
    */
    public String renewalSetting { get; set; }

    /**
    *  The term of renewal for the amended subscription. This field can be updated when Status is `Draft`.\nThis field is only required if the `Type` field is set to `TermsAndConditions`.\n\n\n**Values:** a valid number 
    * @return renewalTerm
    */
    public Long renewalTerm { get; set; }

    /**
    *  The period type for the subscription renewal term. This field can be updated when Status is `Draft`.\n**Required**: Only if the value of the Type field is set to `TermsAndConditions`. This field is used with the RenewalTerm field to specify the subscription renewal term.\n\n\n**Values**:\n\n- `Month` (default)\n- `Year`\n- `Day`\n- `Week`\n
    * @return renewalTermPeriodType
    */
    public String renewalTermPeriodType { get; set; }

    /**
    * The date when the subscription resumption takes effect. See [Resume Date](https://knowledgecenter.zuora.com/BC_Subscription_Management/Subscriptions/Resume_a_Subscription#Resume_Date) for more information.\n\nThis field is only required if you resume a suspended subscription.\n\n**Note:** This feature is in **Limited Availability**. If you want to have access to the feature, submit a request at [Zuora Global Support](http://support.zuora.com/).\n
    * @return resumeDate
    */
    public Date resumeDate { get; set; }

    /**
    * The date when service is activated.\n\nThis field is only required if [Zuora is configured to require service activation in Z-Billing](https://knowledgecenter.zuora.com/CB_Billing/W_Billing_and_Payments_Settings/Define_Default_Subscription_Settings) and the subscription is currently in the Pending Activation status (the value of the `Status` field is currently `PendingActivation`).\n\nUse this field together with the `Status` field. When you set a date in this field as a service activation date, you should also set the `Status` field as the expected next phase status: `Completed` or `PendingAcceptance`.\n
    * @return serviceActivationDate
    */
    public Date serviceActivationDate { get; set; }

    /**
    * The date when the UpdateProduct amendment takes effect. This field is only applicable if there is already a future-dated UpdateProduct amendment on the subscription.\n\n\nFor the UpdateProduct amendments, this field is only required if there is already a future-dated UpdateProduct amendment on the subscription.\n
    * @return specificUpdateDate
    */
    public Date specificUpdateDate { get; set; }

    /**
    *  The status of the amendment. Type: string (enum)\n\n\n\n**Values**: one of the following:\n\n- Draft (default, if left null)\n- Pending Activation\n- Pending Acceptance\n- Completed\n
    * @return status
    */
    public String status { get; set; }

    /**
    *  The ID of the subscription that the amendment changes.\n\n\n**Character limit**: 32\n\n**Values**: a valid subscription ID 
    * @return subscriptionId
    */
    public String subscriptionId { get; set; }

    /**
    * The date when the subscription suspension takes effect. See [Suspend Date](https://knowledgecenter.zuora.com/BC_Subscription_Management/Subscriptions/Suspend_a_Subscription#Suspend_Date) for more information.\n\nThis field is only required if you suspend an active subscription.\n\n**Note:** This feature is in **Limited Availability**. If you want to have access to the feature, submit a request at [Zuora Global Support](http://support.zuora.com/).\n
    * @return suspendDate
    */
    public Date suspendDate { get; set; }

    /**
    *  The date when the new terms and conditions take effect.\nThis field is only required if the `Type` field is set to `TermsAndConditions`.\n
    * @return termStartDate
    */
    public Date termStartDate { get; set; }

    /**
    *  Indicates if the subscription isTERMED or EVERGREEN.\n\n- A TERMED subscription has an expiration date, and must be manually renewed.\n- An EVERGREEN subscription doesn\'t have an expiration date, and must be manually ended.\n\nWhen as part of an amendment of type `TermsAndConditions`, this field is required to change the term type of a subscription.\n\n\n**Character limit**: 9\n\n**Values**: TERMED, EVERGREEN 
    * @return termType
    */
    public String termType { get; set; }

    /**
    *  The type of amendment.\n\n\n**Character limit**: 18\n\n\n\n**Values**: one of the following:\n\n- Cancellation\n- NewProduct\n- OwnerTransfer\n- RemoveProduct\n- Renewal\n- UpdateProduct\n- TermsAndConditions\n- SuspendSubscription (This value is in **Limited Availability**.)\n- ResumeSubscription (This value is in **Limited Availability**.)\n
    * @return r_type
    */
    public String r_type { get; set; }

    /**
    *  The ID of the user who last updated the amendment.\n\n\n**Character limit**: 32\n\n**Values**: automatically generated 
    * @return updatedById
    */
    public String updatedById { get; set; }

    /**
    *  The date when the amendment was last updated.\n\n\n**Values**: automatically generated 
    * @return updatedDate
    */
    public Datetime updatedDate { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'AutoRenew' => 'autoRenew',
        'Code' => 'code',
        'ContractEffectiveDate' => 'contractEffectiveDate',
        'CreatedById' => 'createdById',
        'CreatedDate' => 'createdDate',
        'CurrentTerm' => 'currentTerm',
        'CurrentTermPeriodType' => 'currentTermPeriodType',
        'CustomerAcceptanceDate' => 'customerAcceptanceDate',
        'Description' => 'description',
        'DestinationAccountId' => 'destinationAccountId',
        'DestinationInvoiceOwnerId' => 'destinationInvoiceOwnerId',
        'EffectiveDate' => 'effectiveDate',
        'Name' => 'name',
        'RatePlanData' => 'ratePlanData',
        'RenewalSetting' => 'renewalSetting',
        'RenewalTerm' => 'renewalTerm',
        'RenewalTermPeriodType' => 'renewalTermPeriodType',
        'ResumeDate' => 'resumeDate',
        'ServiceActivationDate' => 'serviceActivationDate',
        'SpecificUpdateDate' => 'specificUpdateDate',
        'Status' => 'status',
        'SubscriptionId' => 'subscriptionId',
        'SuspendDate' => 'suspendDate',
        'TermStartDate' => 'termStartDate',
        'TermType' => 'termType',
        'Type' => 'r_type',
        'UpdatedById' => 'updatedById',
        'UpdatedDate' => 'updatedDate'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }    

}

public class AmendRequestPreviewOptions { // implements WS001_CallZuora.MappedProperties {
/**
    *  Determines whether to create an amendment or display a preview of the change.
    * @return enablePreviewMode
    */
public Boolean enablePreviewMode { get; set; }

/**
    *  Specifies whether to include draft invoice items in amendment previews.
    * @return includeExistingDraftInvoiceItems
    */
public Boolean includeExistingDraftInvoiceItems { get; set; }

/**
    *  Indicates the number of invoice periods to show in a preview.
    * @return numberOfPeriods
    */
public Integer numberOfPeriods { get; set; }

/**
    *  Request to preview the charge through the end of the subscription term.
    * @return previewThroughTermEnd
    */
public Boolean previewThroughTermEnd { get; set; }

/**
    *  The type of preview you will receive from a preview request.
    * @return previewType
    */
public String previewType { get; set; }

private final Map<String, String> propertyMappings = new Map<String, String>{
    'EnablePreviewMode' => 'enablePreviewMode',
    'IncludeExistingDraftInvoiceItems' => 'includeExistingDraftInvoiceItems',
    'NumberOfPeriods' => 'numberOfPeriods',
    'PreviewThroughTermEnd' => 'previewThroughTermEnd',
    'PreviewType' => 'previewType'
};

public Map<String, String> getPropertyMappings() {
    return propertyMappings;
}



public Boolean equals(Object obj) {
    if (obj instanceof AmendRequestPreviewOptions) {
        AmendRequestPreviewOptions amendRequestPreviewOptions = (AmendRequestPreviewOptions) obj;
        return this.enablePreviewMode == amendRequestPreviewOptions.enablePreviewMode
            && this.includeExistingDraftInvoiceItems == amendRequestPreviewOptions.includeExistingDraftInvoiceItems
            && this.numberOfPeriods == amendRequestPreviewOptions.numberOfPeriods
            && this.previewThroughTermEnd == amendRequestPreviewOptions.previewThroughTermEnd
            && this.previewType == amendRequestPreviewOptions.previewType;
    }
    return false;
}

public Integer hashCode() {
    Integer hashCode = 43;
    hashCode = (17 * hashCode) + (enablePreviewMode == null ? 0 : System.hashCode(enablePreviewMode));
    hashCode = (17 * hashCode) + (includeExistingDraftInvoiceItems == null ? 0 : System.hashCode(includeExistingDraftInvoiceItems));
    hashCode = (17 * hashCode) + (numberOfPeriods == null ? 0 : System.hashCode(numberOfPeriods));
    hashCode = (17 * hashCode) + (previewThroughTermEnd == null ? 0 : System.hashCode(previewThroughTermEnd));
    hashCode = (17 * hashCode) + (previewType == null ? 0 : System.hashCode(previewType));
    return hashCode;
}

}


public class AmendmentRatePlanData implements  WS001_CallZuora.MappedProperties {

public AmendmentRatePlanData() {
    //this.ratePlan = new RatePlan();
    ratePlanChargeData = new List<RatePlanChargeDataInRatePlanData>();    
    // this.subscriptionProductFeatureList = new SubscriptionProductFeatureList();
}

/**
    * Get ratePlan
    * @return ratePlan
    */
public RatePlan ratePlan { get; set; }

/**
    * 
    * @return ratePlanChargeData
    */
public List<RatePlanChargeDataInRatePlanData> ratePlanChargeData { get; set; }

/**
    * Get subscriptionProductFeatureList
    * @return subscriptionProductFeatureList
    */
public SubscriptionProductFeatureList subscriptionProductFeatureList { get; set; }

private final Map<String, String> propertyMappings = new Map<String, String>{
    'RatePlan' => 'ratePlan',
    'RatePlanChargeData' => 'ratePlanChargeData',
    'SubscriptionProductFeatureList' => 'subscriptionProductFeatureList'
};

public Map<String, String> getPropertyMappings() {
    return propertyMappings;
}



public Boolean equals(Object obj) {
    if (obj instanceof AmendmentRatePlanData) {
        AmendmentRatePlanData amendmentRatePlanData = (AmendmentRatePlanData) obj;
        return this.ratePlan == amendmentRatePlanData.ratePlan
            && this.ratePlanChargeData == amendmentRatePlanData.ratePlanChargeData
            && this.subscriptionProductFeatureList == amendmentRatePlanData.subscriptionProductFeatureList;
    }
    return false;
}

public Integer hashCode() {
    Integer hashCode = 43;
    hashCode = (17 * hashCode) + (ratePlan == null ? 0 : System.hashCode(ratePlan));
    hashCode = (17 * hashCode) + (ratePlanChargeData == null ? 0 : System.hashCode(ratePlanChargeData));
    hashCode = (17 * hashCode) + (subscriptionProductFeatureList == null ? 0 : System.hashCode(subscriptionProductFeatureList));
    return hashCode;
}
}

public class RatePlan implements WS001_CallZuora.MappedProperties {
    /**
     *  The ID of the amendment associated with the rate plan. This field only applies to amendment rate plans.\n\n\n**Character limit**: 32\n\n**Values**: a valid amendment ID 
     * @return amendmentId
     */
    public String amendmentId { get; set; }

    /**
     * The ID of the subscription rate plan modified by the amendment. This field only applies to amendment rate plans.\n\n**Character limit**: 32\n\n**Values**: a valid rate plan ID 
     * @return amendmentSubscriptionRatePlanId
     */
    public String amendmentSubscriptionRatePlanId { get; set; }

    /**
     * The type of amendment associated with the rate plan. This field only applies to amendment rate plans.\n\n**Character limit**: 18\n\n**Values**: inherited from `Amendment.Type` 
     * @return amendmentType
     */
    public String amendmentType { get; set; }

    /**
     * The ID of the Zuora user who created the RatePlan object.\n\n**Character limit**: 32\n\n**Values**: automatically generated 
     * @return createdById
     */
    public String createdById { get; set; }

    /**
     * The date when the `RatePlan` object was last updated.\n\n**Character limit**: 29\n\n**Values**: automatically generated 
     * @return createdDate
     */
    public Datetime createdDate { get; set; }

    /**
     * The name of the rate plan. Leave this null in a subscribe call to inherited the `ProductRatePlan.Name` field value.\n\n**Character limit**: 100\n\n**Values**: a string of 100 characters or fewer or inherited from ProductRatePlan.Name 
     * @return name
     */
    public String name { get; set; }

    /**
     * The ID of the associated product rate plan.\n\n**Character limit**: 32\n\n**Values**: a valid product rate plan ID 
     * @return productRatePlanId
     */
    public String productRatePlanId { get; set; }

    /**
     * The ID of the subscription that the rate plan belongs to.\n\n**Character limit**: 32\n\n**Values**: a valid subscription ID 
     * @return subscriptionId
     */
    public String subscriptionId { get; set; }

    /**
     *  The ID of the user who last updated the rate plan.\n\n\n**Character limit**: 32\n\n**Values**: automatically generated 
     * @return updatedById
     */
    public String updatedById { get; set; }

    /**
     *  The date when the rate plan was last updated.\n\n\n**Character limit**: 29\n\n**Values**: automatically generated 
     * @return updatedDate
     */
    public Datetime updatedDate { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'AmendmentId' => 'amendmentId',
        'AmendmentSubscriptionRatePlanId' => 'amendmentSubscriptionRatePlanId',
        'AmendmentType' => 'amendmentType',
        'CreatedById' => 'createdById',
        'CreatedDate' => 'createdDate',
        'Name' => 'name',
        'ProductRatePlanId' => 'productRatePlanId',
        'SubscriptionId' => 'subscriptionId',
        'UpdatedById' => 'updatedById',
        'UpdatedDate' => 'updatedDate'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }



public Boolean equals(Object obj) {
    if (obj instanceof RatePlan) {
        RatePlan ratePlan = (RatePlan) obj;
        return this.amendmentId == ratePlan.amendmentId
            && this.amendmentSubscriptionRatePlanId == ratePlan.amendmentSubscriptionRatePlanId
            && this.amendmentType == ratePlan.amendmentType
            && this.createdById == ratePlan.createdById
            && this.createdDate == ratePlan.createdDate
            && this.name == ratePlan.name
            && this.productRatePlanId == ratePlan.productRatePlanId
            && this.subscriptionId == ratePlan.subscriptionId
            && this.updatedById == ratePlan.updatedById
            && this.updatedDate == ratePlan.updatedDate;
    }
    return false;
}

public Integer hashCode() {
    Integer hashCode = 43;
    hashCode = (17 * hashCode) + (amendmentId == null ? 0 : System.hashCode(amendmentId));
    hashCode = (17 * hashCode) + (amendmentSubscriptionRatePlanId == null ? 0 : System.hashCode(amendmentSubscriptionRatePlanId));
    hashCode = (17 * hashCode) + (amendmentType == null ? 0 : System.hashCode(amendmentType));
    hashCode = (17 * hashCode) + (createdById == null ? 0 : System.hashCode(createdById));
    hashCode = (17 * hashCode) + (createdDate == null ? 0 : System.hashCode(createdDate));
    hashCode = (17 * hashCode) + (name == null ? 0 : System.hashCode(name));
    hashCode = (17 * hashCode) + (productRatePlanId == null ? 0 : System.hashCode(productRatePlanId));
    hashCode = (17 * hashCode) + (subscriptionId == null ? 0 : System.hashCode(subscriptionId));
    hashCode = (17 * hashCode) + (updatedById == null ? 0 : System.hashCode(updatedById));
    hashCode = (17 * hashCode) + (updatedDate == null ? 0 : System.hashCode(updatedDate));
    return hashCode;
}
}

public class SubscriptionProductFeatureList implements WS001_CallZuora.MappedProperties {

    public SubscriptionProductFeatureList() {
        subscriptionProductFeature = new List<SubscriptionProductFeature>();
    }

    /**
     * 
     * @return subscriptionProductFeature
     */
    public List<SubscriptionProductFeature> subscriptionProductFeature { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'SubscriptionProductFeature' => 'subscriptionProductFeature'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }


    public Boolean equals(Object obj) {
        if (obj instanceof SubscriptionProductFeatureList) {
            SubscriptionProductFeatureList subscriptionProductFeatureList = (SubscriptionProductFeatureList) obj;
            return this.subscriptionProductFeature == subscriptionProductFeatureList.subscriptionProductFeature;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (subscriptionProductFeature == null ? 0 : System.hashCode(subscriptionProductFeature));
        return hashCode;
    }
}
public class RatePlanChargeDataInRatePlanData {
    public RatePlanChargeInRatePlanChargeData ratePlanCharge;
    
    private final Map<String, String> propertyMappings = new Map<String, String>{
        'RatePlanCharge' => 'ratePlanCharge'
    };
    
    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }    

}
// public class RatePlanChargeDataInRatePlanData { //implements WS001_CallZuora.MappedProperties {
public class RatePlanChargeInRatePlanChargeData { //implements WS001_CallZuora.MappedProperties {    
    /**
     * The accounting code for the charge. Accounting codes group transactions that contain similar accounting attributes.\n\n**Character limit**: 100\n\n\n**Values**: inherited from `ProductRatePlanCharge.AccountingCode` 
     * @return accountingCode
     */
    public String accountingCode { get; set; }

    /**
     *  Specifies the type of charges a specific discount applies to.\n\n**Character limit**: 21\n\n\n**Values**: inherited from `ProductRatePlanCharge.ApplyDiscountTo` 
     * @return applyDiscountTo
     */
    public String applyDiscountTo { get; set; }

    /**
     *  Indicates the charge\'s billing cycle day (BCD), which is when bill runs generate invoices for charges associated with the product rate plan charge or the account.\n\n\n**Character limit**: 2\n\n\n**Values**: inherited from `ProductRatePlanCharge.BillCycleDay` 
     * @return billCycleDay
     */
    public Integer billCycleDay { get; set; }

    /**
     *  Specifies how to determine the billing day for the charge.\n\n\n**Character limit**: 20\n\n\n**Values**: inherited from `ProductRatePlanCharge.BillCycleType` **Note:** You can override the value inherited from the Product Rate Plan Charge, but only when creating a new subscription or a New Product amendment. 
     * @return billCycleType
     */
    public String billCycleType { get; set; }

    /**
     *  Allows billing period to be overridden on rate plan charge.\n\n\n\n**Values**: inherited from `ProductRatePlanCharge.BillingPeriod` **Note:** You can override the value inherited from the Product Rate Plan Charge, but only when creating a new subscription or a New Product amendment. 
     * @return billingPeriod
     */
    public String billingPeriod { get; set; }

    /**
     *  Aligns charges within the same subscription if multiple charges begin on different dates.\n\n\n**Character limit**: 24\n\n\n**Values**: inherited from `ProductRatePlanCharge.BillingPeriodAlignment` 
     * @return billingPeriodAlignment
     */
    public String billingPeriodAlignment { get; set; }

    /**
     *  The billing timing for the charge. You can choose to bill in advance or in arrears for recurring charge types. This field is not used in one-time or usage based charge types.\n\n\n**Character limit**:\n\n\n**Values**: one of the following:\n\n- `In Advance`\n- `In Arrears`\n**Note:** You can override the value inherited from the Product Rate Plan Charge when a subscription has a recurring charge type.\nThis feature is in **Limited Availability**. If you wish to have access to the feature, submit a request at [Zuora Global Support](http://support.zuora.com/).\n\n
     * @return billingTiming
     */
    public String billingTiming { get; set; }

    /**
     *  Determines how to evaluate charges. Charge models must be individually activated in the web-based UI.\n\n\n**Character limit**: 29\n\n\n**Values**: inherited from `ProductRatePlanCharge.ChargeModel` 
     * @return chargeModel
     */
    public String chargeModel { get; set; }

    /**
     *  A unique number that identifies the charge. This number is returned as a string.\n\n\n**Character limit**: 50\n\n\n**Values**: one of the following:\n\n- automatically generated if left null\n- a unique number of 50 characters or fewer\n
     * @return chargeNumber
     */
    public String chargeNumber { get; set; }

    /**
     *  Specifies the type of charge.\n\n\n**Character limit**: 9\n\n\n**Values**: inherited from `ProductRatePlanCharge.ChargeType` 
     * @return chargeType
     */
    public String chargeType { get; set; }

    /**
     *  The date through which a customer has been billed for the charge.\n\n\n**Character limit**: 29\n\n\n**Values**: automatically generated 
     * @return chargedThroughDate
     */
    public Date chargedThroughDate { get; set; }

    /**
     * The ID of the Zuora user who created the `RatePlanCharge` object.\n\n**Character limit**: 32\n\n\n**Values**: automatically generated 
     * @return createdById
     */
    public String createdById { get; set; }

    /**
     *  The date when the `RatePlanCharge` object was created.\n\n\n**Character limit**: 29\n\n\n**Values**: automatically generated 
     * @return createdDate
     */
    public Datetime createdDate { get; set; }

    /**
     * A delta monthly recurring charge is the change in monthly recurring revenue caused by an amendment or a new subscription.\n\n**Character limit**: 16\n\n\n**Values**: automatically generated 
     * @return DMRC
     */
    public Double DMRC { get; set; }

    /**
     *  After an Amendment, the change in the total contract value (TCV) amount for this charge, compared with its previous value.\n\n\n**Character limit**: 16\n\n\n**Values**: automatically generated 
     * @return DTCV
     */
    public Double DTCV { get; set; }

    /**
     *  A description of the charge.\n\n\n**Character limit**: 500\n\n\n**Values**: inherited from `ProductRatePlanCharge.Description` 
     * @return description
     */
    public String description { get; set; }

    /**
     *  Specifies the amount of a fixed-amount discount. You can provide a value for this field if the `ChargeModel` field value is `Discount-Fixed Amount`. If this field is included in a query, the query will filter out the rate plans whose `ChargeModel` field is not of a Discount type. You cannot query this field with the following fields in a single query:\n\n- Price\n- IncludedUnits\n- DiscountPercentage\n- OveragePrice\n\n\n**Character limit**: 16\n\n\n**Values**: a valid currency amount 
     * @return discountAmount
     */
    public Double discountAmount { get; set; }

    /**
     * Specifies if the discount applies to just the product rate plan, the entire subscription, or to any activity in the account. This field is only required if the `ChargeModel` field is set to `DiscountFixedAmount` or `DiscountPercentage`.\n\n**Character limit**: 12\n\n\n**Values**: inherited from `ProductRatePlanCharge.DiscountLevel` 
     * @return discountLevel
     */
    public String discountLevel { get; set; }

    /**
     *  Query Filter 
     * @return discountPercentage
     */
    public Double discountPercentage { get; set; }

    /**
     *  The date when the segmented charge ends or ended.\n\n\n**Character limit**: 16\n\n\n**Values**: automatically generated 
     * @return effectiveEndDate
     */
    public Date effectiveEndDate { get; set; }

    /**
     *  The date when the segmented charge starts or started.\n\n\n**Character limit**: 16\n\n\n**Values**: automatically generated 
     * @return effectiveStartDate
     */
    public Date effectiveStartDate { get; set; }

    /**
     *  Defines when the charge ends after the charge trigger date. This field can be updated when **Status** is `Draft`.\n\n\n\n**Values**: one of the following:\n\n- `SubscriptionEnd`: The charge ends on the subscription end date after the charge trigger date. This is the default value.\n- `FixedPeriod`: The charge ends after a specified period based on the trigger date of the charge. If you set this field to `FixedPeriod`, you must specify the length of the period and a period type by defining the `UpToPeriods` and `UpToPeriodsType` fields.\n- `SpecificEndDate`: The specific date on which the charge ends. If you set this field to `SpecificEndDate`, you must specify the specific date by defining the `SpecificEndDate` field.\n\n\n\n**Note**: If the subscription ends before the charge end date, the charge ends when the subscription ends. But if the subscription end date is subsequently changed through a Renewal, or Terms and Conditions amendment, the charge will end on the charge end date. 
     * @return endDateCondition
     */
    public String endDateCondition { get; set; }

    /**
     *  Query Filter 
     * @return includedUnits
     */
    public Double includedUnits { get; set; }

    /**
     * Indicates if the segment of the rate plan charge is the most recent segment.\n\n**Character limit**: 5\n\n\n**Values**: automatically generated: `true`, `false` 
     * @return isLastSegment
     */
    public Boolean isLastSegment { get; set; }

    /**
     * The list price base for the product rate plan charge.\n\nYou can only change the value of this field if the amendment type is NewProduct.\n\n**Values**: one of the following:\n\n- `Per Month`\n- `Per Billing Period`\n- `Per Week`\n
     * @return listPriceBase
     */
    public String listPriceBase { get; set; }

    /**
     * Monthly recurring revenue (MRR) is the amount of recurring charges in a given month. The MRR calculation doesn\'t include one-time charges nor usage charges.\n\n**Character limit**: 16\n\n\n**Values**: automatically generated 
     * @return MRR
     */
    public Double MRR { get; set; }

    /**
     * The name of the rate plan charge.\n\n**Character limit**: 100\n\n\n**Values**: automatically generated 
     * @return name
     */
    public String name { get; set; }

    /**
     * Specifies the number of periods to use when calculating charges in an overage smoothing charge model.\n\n**Character limit**: 5\n\n\n**Values**: inherited from `ProductRatePlanCharge.NumberOfPeriod` 
     * @return numberOfPeriods
     */
    public Long numberOfPeriods { get; set; }

    /**
     * The original ID of the rate plan charge.\n\n**Character limit**: 32\n\n\n**Values**: automatically generated 
     * @return originalId
     */
    public String originalId { get; set; }

    /**
     * Determines when to calculate overage charges. If the value of the SmoothingMode field is null (not specified and not inherited from ProductRatePlanCharge.SmoothingMode), the value of this field is ignored.\n\n**Character limit**: 20\n\n\n**Values**: inherited from `ProductRatePlanCharge.OverageCalculationOption` 
     * @return overageCalculationOption
     */
    public String overageCalculationOption { get; set; }

    /**
     *  Query Filter 
     * @return overagePrice
     */
    public Double overagePrice { get; set; }

    /**
     *  Determines whether to credit the customer with unused units of usage.\n\n\n**Character limit**: 20\n\n\n**Values**: inherited from `ProductRatePlanCharge.OverageUnusedUnitsCreditOption` 
     * @return overageUnusedUnitsCreditOption
     */
    public String overageUnusedUnitsCreditOption { get; set; }

    /**
     *  Query Filter 
     * @return price
     */
    public Double price { get; set; }

    /**
     *  Applies an automatic price change when a termed subscription is renewed.\n\n\n**Character limit**:\n\n\n**Values**: one of the following:\n\n- `NoChange` (default)\n- `SpecificPercentageValue`\n- `UseLatestProductCatalogPricing`\n
     * @return priceChangeOption
     */
    public String priceChangeOption { get; set; }

    /**
     *  Specifies the percentage to increase or decrease the price of renewed subscriptions. Use this field if the `ProductRatePlanCharge`.`PriceChangeOption` value is set to `SpecificPercentageValue`.\n\n\n**Character limit**: 16\n\n\n**Values**: a decimal value between -100 and 100 
     * @return priceIncreasePercentage
     */
    public Double priceIncreasePercentage { get; set; }

    /**
     *  The date until when charges have been processed. When billing in arrears, such as usage, this field value is the the same as the `ChargedThroughDate` value. This date is the earliest date when a charge can be amended.\n\n\n**Character limit**: 29\n\n\n**Values**: automatically generated 
     * @return processedThroughDate
     */
    public Date processedThroughDate { get; set; }

    /**
     *  The ID of the product rate plan charge associated with the subscription rate plan charge,\n\n**Character limit**: 32\n\n\n**Values**: inherited from `ProductRatePlanCharge.Id` 
     * @return productRatePlanChargeId
     */
    public String productRatePlanChargeId { get; set; }

    /**
     *  The default quantity of units, such as the number of authors in a hosted wiki service. Valid for all charge models except for Flat Fee pricing. This field is only rquired if the charge model is tiered pricing or volume pricing.\n\n\n\n**Character limit**: 16\n\n\n**Values**: a valid quantity value 
     * @return quantity
     */
    public Double quantity { get; set; }

    /**
     *  The ID of the rate plan associated with the rate plan charge.\n\n\n**Character limit**: 32\n\n\n**Values**: inherited from `RatePlan.Id` 
     * @return ratePlanId
     */
    public String ratePlanId { get; set; }

    /**
     *  Associates this product rate plan charge with a specific revenue recognition code.\n\n\n**Character limit**: 70\n\n\n**Values**: a valid revenue recognition code 
     * @return revRecCode
     */
    public String revRecCode { get; set; }

    /**
     *  Specifies when revenue recognition begins.\n\n\n**Character limit**: 22\n\n\n**Values**: one of the following:\n\n-  `ContractEffectiveDate`\n\n-  `ServiceActivationDate`\n\n-  `CustomerAcceptanceDate`\n\n
     * @return revRecTriggerCondition
     */
    public String revRecTriggerCondition { get; set; }

    /**
     *  Specifies the Revenue Recognition Rule that you want the Rate Plan Charge to use. This field can be updated when **Status** is `Draft`. By default, the Revenue Recognition Rule is inherited from the Product Rate Plan Charge. For Amend\ncalls, you can use this field only for NewProduct amendments. For Update\ncalls, you can use this field only to update subscriptions in draft status. Note that if you use this field to specify a Revenue Recognition Rule for the Rate Plan Charge, the rule will remain as specified even if you later change the rule used by the corresponding Product Rate Plan Charge. See [Z-Billing User Role](https://knowledgecenter.zuora.com/CF_Users_and_Administrators/A_Administrator_Settings/User_Roles/d_Billing_Roles) permission enabled to use this field.\n\n\n\n**Character limit**: n/a\n\n\n**Values**: name of an active Revenue Recognition Rule 
     * @return revenueRecognitionRuleName
     */
    public String revenueRecognitionRuleName { get; set; }

    /**
     *  Specifies the number of units of measure (UOM) rolled over from previous periods. This field is applicable only to usage charges with overage models.\n\n\n**Character limit**: 16\n\n\n**Values**: automatically generated\n\n**Note**:\n\n- You cannot query or filter this field with other fields in a single query.\n- To query or filter this field, you must specify and only specify the rate plan charge Id in the condition.\n- You cannot use this field in the query or filter condition.\n
     * @return rolloverBalance
     */
    public Double rolloverBalance { get; set; }

    /**
     *  The identifying number of the subscription rate plan segment. Segments are numbered sequentially, starting with 1.\n\n\n**Character limit**: 2\n\n\n**Values**: automatically generated 
     * @return segment
     */
    public Integer segment { get; set; }

    /**
     *  Customizes the number of months or weeks for the charges billing period. This field is only required if you set the value of the `BillingPeriod` field to `Specific Months` or `Specific Weeks`.\n\n\n**Character limit**: 5\n\n\n**Values**: inherited from `ProductRatePlanCharge.BillingPeriod` **Note:** You can override the value inherited from the Product Rate Plan Charge, but only when creating a new subscription or a New Product amendment. 
     * @return specificBillingPeriod
     */
    public Long specificBillingPeriod { get; set; }

    /**
     *  The specific date on which the charge ends, in `yyyy-mm-dd` format.\n\n\n**Character limit**: 29\n\n\n\n**Note**:\n\n- This field is only applicable when the `EndDateCondition` field is set to `SpecificEndDate`.\n- If the subscription ends before the specific end date, the charge ends when the subscription ends. But if the subscription end date is subsequently changed through a Renewal, or Terms and Conditions amendment, the charge will end on the specific end date.\n
     * @return specificEndDate
     */
    public Date specificEndDate { get; set; }

    /**
     *  The total contract value (TCV) is the value of a single rate plan charge in a subscription over the lifetime of the subscription. This value does not represent all charges on the subscription. The TCV includes recurring charges and one-time charges, but it doesn\'t include usage charge.\n\n\n**Character limit**: 16\n\n\n**Values**: automatically generated 
     * @return TCV
     */
    public Double TCV { get; set; }

    /**
     *  The date when the charge becomes effective and billing begins, in `yyyy-mm-dd` format. This field is only required if the `TriggerEvent` field is set to `SpecificDate`.\n\n\n**Character limit**: 29\n\n
     * @return triggerDate
     */
    public Date triggerDate { get; set; }

    /**
     *  Specifies when to start billing the customer for the charge.\n**Note: **This field can be passed through the subscribe\nand amend\ncalls and will override the default value set on the Product Rate Plan Charge.\n\n\n**Character limit**: 18\n\n\n**Values**: inherited from `ProductRatePlanCharge.TriggerEvent` and can be one of the following values:\n\n- `ContractEffective `is the date when the subscription\'s contract goes into effect and the charge is ready to be billed.\n- `ServiceActivationDate `is when the services or products for a subscription have been activated and the customers have access.\n- `CustomerAcceptance `is when the customer accepts the services or products for a subscription.\n- SpecificDate is valid only on the RatePlanCharge.\n
     * @return triggerEvent
     */
    public String triggerEvent { get; set; }

    /**
     *  Specifies the units to measure usage. Units of measure are configured in the web-based UI: **Z-Billing > Settings**.\n\n\n**Character limit**: 25\n\n\n**Values**: inherited from `ProductRatePlanCharge.UOM` 
     * @return UOM
     */
    public String UOM { get; set; }

    /**
     *  Specifies the rate to credit a customer for unused units of usage. This field is applicable only for overage charge models when the `OverageUnusedUnitsCreditOption` field value is CreditBySpecificRate.\n\n\n**Character limit**: 16\n\n\n**Values**: a valid decimal value 
     * @return unusedUnitsCreditRates
     */
    public Double unusedUnitsCreditRates { get; set; }

    /**
     *  Specifies the length of the period during which the charge is active. If this period ends before the subscription ends, the charge ends when this period ends.\n\n\n**Character limit**: 5\n\n\n**Values**: inherited from `ProductRatePlanCharge.UpToPeriods`\n\n**Note**:\n\n- You must use this field together with the `UpToPeriodsType` field to specify the time period. This field is only applicable only when the `EndDateCondition` field is set to `FixedPeriod`.\n- You can override the value inherited from the Product Rate Plan Charge, but only when creating a new subscription or a New Product amendment.\n- Use this field to override the value in `ProductRatePlanCharge.UpToPeriod`.\n- If you override the value in this field, enter a whole number between 0 and 65535, exclusive.\n- If the subscription end date is subsequently changed through a Renewal, or Terms and Conditions amendment, the charge end date will change accordingly up to the original period end.\n
     * @return upToPeriods
     */
    public Long upToPeriods { get; set; }

    /**
     *  The period type used to define when the charge ends. This field can be updated when **Status** is `Draft`.\n\n\n**Values**: one of the following:\n\n- `Billing Periods` (default)\n- `Days`\n- `Weeks`\n- `Months`\n- `Years`\n\n\n**Note**:\n\n- You must use this field together with the `UpToPeriods` field to specify the time period.\n- This field is only applicable only when the `EndDateCondition` field is set to `FixedPeriod`.\n
     * @return upToPeriodsType
     */
    public String upToPeriodsType { get; set; }

    /**
     * The ID of the last user to update the object.\n\n**Character limit**: 32\n\n\n**Values**: automatically generated 
     * @return updatedById
     */
    public String updatedById { get; set; }

    /**
     *  The date when the object was last updated.\n\n\n**Character limit**: 29\n\n\n**Values**: automatically generated 
     * @return updatedDate
     */
    public Datetime updatedDate { get; set; }

    /**
     *  Determines how Zuora processes usage records for per-unit usage charges.\n\n**Character limit**: 18\n\n\n**Values**: automatically generated 
     * @return usageRecordRatingOption
     */
    public String usageRecordRatingOption { get; set; }

    /**
     *  Determines whether to define a new accounting code for the new discount charge.\n\n\n**Character limit**: 5\n\n\n**Values**: inherited from `ProductRatePlanCharge.UseDiscountSpecificAccountingCode` 
     * @return useDiscountSpecificAccountingCode
     */
    public Boolean useDiscountSpecificAccountingCode { get; set; }

    /**
     *  The version of the rate plan charge. Each time a charge is amended, Zuora creates a new version of the rate plan charge.\n\n**Character limit**: 5\n\n\n**Values**: automatically generated 
     * @return version
     */
    public Long version { get; set; }

    /**
     *  Specifies which day of the week as the bill cycle day (BCD) for the charge.\nThis feature is in **Limited Availability**. If you wish to have access to the feature, submit a request at [Zuora Global Support](http://support.zuora.com/).\n\n\n\n\n**Values**: one of the following:\n\n- `Sunday`\n- `Monday`\n- `Tuesday`\n- `Wednesday`\n- `Thursday`\n- `Friday`\n- `Saturday`\n
     * @return weeklyBillCycleDay
     */
    public String weeklyBillCycleDay { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'AccountingCode' => 'accountingCode',
        'ApplyDiscountTo' => 'applyDiscountTo',
        'BillCycleDay' => 'billCycleDay',
        'BillCycleType' => 'billCycleType',
        'BillingPeriod' => 'billingPeriod',
        'BillingPeriodAlignment' => 'billingPeriodAlignment',
        'BillingTiming' => 'billingTiming',
        'ChargeModel' => 'chargeModel',
        'ChargeNumber' => 'chargeNumber',
        'ChargeType' => 'chargeType',
        'ChargedThroughDate' => 'chargedThroughDate',
        'CreatedById' => 'createdById',
        'CreatedDate' => 'createdDate',
        'Description' => 'description',
        'DiscountAmount' => 'discountAmount',
        'DiscountLevel' => 'discountLevel',
        'DiscountPercentage' => 'discountPercentage',
        'EffectiveEndDate' => 'effectiveEndDate',
        'EffectiveStartDate' => 'effectiveStartDate',
        'EndDateCondition' => 'endDateCondition',
        'IncludedUnits' => 'includedUnits',
        'IsLastSegment' => 'isLastSegment',
        'ListPriceBase' => 'listPriceBase',
        'Name' => 'name',
        'NumberOfPeriods' => 'numberOfPeriods',
        'OriginalId' => 'originalId',
        'OverageCalculationOption' => 'overageCalculationOption',
        'OveragePrice' => 'overagePrice',
        'OverageUnusedUnitsCreditOption' => 'overageUnusedUnitsCreditOption',
        'Price' => 'price',
        'PriceChangeOption' => 'priceChangeOption',
        'PriceIncreasePercentage' => 'priceIncreasePercentage',
        'ProcessedThroughDate' => 'processedThroughDate',
        'ProductRatePlanChargeId' => 'productRatePlanChargeId',
        'Quantity' => 'quantity',
        'RatePlanId' => 'ratePlanId',
        'RevRecCode' => 'revRecCode',
        'RevRecTriggerCondition' => 'revRecTriggerCondition',
        'RevenueRecognitionRuleName' => 'revenueRecognitionRuleName',
        'RolloverBalance' => 'rolloverBalance',
        'Segment' => 'segment',
        'SpecificBillingPeriod' => 'specificBillingPeriod',
        'SpecificEndDate' => 'specificEndDate',
        'TriggerDate' => 'triggerDate',
        'TriggerEvent' => 'triggerEvent',
        'UnusedUnitsCreditRates' => 'unusedUnitsCreditRates',
        'UpToPeriods' => 'upToPeriods',
        'UpToPeriodsType' => 'upToPeriodsType',
        'UpdatedById' => 'updatedById',
        'UpdatedDate' => 'updatedDate',
        'UsageRecordRatingOption' => 'usageRecordRatingOption',
        'UseDiscountSpecificAccountingCode' => 'useDiscountSpecificAccountingCode',
        'Version' => 'version',
        'WeeklyBillCycleDay' => 'weeklyBillCycleDay'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }


    /*
    public Boolean equals(Object obj) {
        if (obj instanceof RatePlanChargeDataInRatePlanData) {
            RatePlanChargeDataInRatePlanData ratePlanChargeDataInRatePlanDataRatePlanCharge = (RatePlanChargeDataInRatePlanData) obj;
            return this.accountingCode == ratePlanChargeDataInRatePlanDataRatePlanCharge.accountingCode
                && this.applyDiscountTo == ratePlanChargeDataInRatePlanDataRatePlanCharge.applyDiscountTo
                && this.billCycleDay == ratePlanChargeDataInRatePlanDataRatePlanCharge.billCycleDay
                && this.billCycleType == ratePlanChargeDataInRatePlanDataRatePlanCharge.billCycleType
                && this.billingPeriod == ratePlanChargeDataInRatePlanDataRatePlanCharge.billingPeriod
                && this.billingPeriodAlignment == ratePlanChargeDataInRatePlanDataRatePlanCharge.billingPeriodAlignment
                && this.billingTiming == ratePlanChargeDataInRatePlanDataRatePlanCharge.billingTiming
                && this.chargeModel == ratePlanChargeDataInRatePlanDataRatePlanCharge.chargeModel
                && this.chargeNumber == ratePlanChargeDataInRatePlanDataRatePlanCharge.chargeNumber
                && this.chargeType == ratePlanChargeDataInRatePlanDataRatePlanCharge.chargeType
                && this.chargedThroughDate == ratePlanChargeDataInRatePlanDataRatePlanCharge.chargedThroughDate
                && this.createdById == ratePlanChargeDataInRatePlanDataRatePlanCharge.createdById
                && this.createdDate == ratePlanChargeDataInRatePlanDataRatePlanCharge.createdDate
                && this.DMRC == ratePlanChargeDataInRatePlanDataRatePlanCharge.DMRC
                && this.DTCV == ratePlanChargeDataInRatePlanDataRatePlanCharge.DTCV
                && this.description == ratePlanChargeDataInRatePlanDataRatePlanCharge.description
                && this.discountAmount == ratePlanChargeDataInRatePlanDataRatePlanCharge.discountAmount
                && this.discountLevel == ratePlanChargeDataInRatePlanDataRatePlanCharge.discountLevel
                && this.discountPercentage == ratePlanChargeDataInRatePlanDataRatePlanCharge.discountPercentage
                && this.effectiveEndDate == ratePlanChargeDataInRatePlanDataRatePlanCharge.effectiveEndDate
                && this.effectiveStartDate == ratePlanChargeDataInRatePlanDataRatePlanCharge.effectiveStartDate
                && this.endDateCondition == ratePlanChargeDataInRatePlanDataRatePlanCharge.endDateCondition
                && this.includedUnits == ratePlanChargeDataInRatePlanDataRatePlanCharge.includedUnits
                && this.isLastSegment == ratePlanChargeDataInRatePlanDataRatePlanCharge.isLastSegment
                && this.listPriceBase == ratePlanChargeDataInRatePlanDataRatePlanCharge.listPriceBase
                && this.MRR == ratePlanChargeDataInRatePlanDataRatePlanCharge.MRR
                && this.name == ratePlanChargeDataInRatePlanDataRatePlanCharge.name
                && this.numberOfPeriods == ratePlanChargeDataInRatePlanDataRatePlanCharge.numberOfPeriods
                && this.originalId == ratePlanChargeDataInRatePlanDataRatePlanCharge.originalId
                && this.overageCalculationOption == ratePlanChargeDataInRatePlanDataRatePlanCharge.overageCalculationOption
                && this.overagePrice == ratePlanChargeDataInRatePlanDataRatePlanCharge.overagePrice
                && this.overageUnusedUnitsCreditOption == ratePlanChargeDataInRatePlanDataRatePlanCharge.overageUnusedUnitsCreditOption
                && this.price == ratePlanChargeDataInRatePlanDataRatePlanCharge.price
                && this.priceChangeOption == ratePlanChargeDataInRatePlanDataRatePlanCharge.priceChangeOption
                && this.priceIncreasePercentage == ratePlanChargeDataInRatePlanDataRatePlanCharge.priceIncreasePercentage
                && this.processedThroughDate == ratePlanChargeDataInRatePlanDataRatePlanCharge.processedThroughDate
                && this.productRatePlanChargeId == ratePlanChargeDataInRatePlanDataRatePlanCharge.productRatePlanChargeId
                && this.quantity == ratePlanChargeDataInRatePlanDataRatePlanCharge.quantity
                && this.ratePlanId == ratePlanChargeDataInRatePlanDataRatePlanCharge.ratePlanId
                && this.revRecCode == ratePlanChargeDataInRatePlanDataRatePlanCharge.revRecCode
                && this.revRecTriggerCondition == ratePlanChargeDataInRatePlanDataRatePlanCharge.revRecTriggerCondition
                && this.revenueRecognitionRuleName == ratePlanChargeDataInRatePlanDataRatePlanCharge.revenueRecognitionRuleName
                && this.rolloverBalance == ratePlanChargeDataInRatePlanDataRatePlanCharge.rolloverBalance
                && this.segment == ratePlanChargeDataInRatePlanDataRatePlanCharge.segment
                && this.specificBillingPeriod == ratePlanChargeDataInRatePlanDataRatePlanCharge.specificBillingPeriod
                && this.specificEndDate == ratePlanChargeDataInRatePlanDataRatePlanCharge.specificEndDate
                && this.TCV == ratePlanChargeDataInRatePlanDataRatePlanCharge.TCV
                && this.triggerDate == ratePlanChargeDataInRatePlanDataRatePlanCharge.triggerDate
                && this.triggerEvent == ratePlanChargeDataInRatePlanDataRatePlanCharge.triggerEvent
                && this.UOM == ratePlanChargeDataInRatePlanDataRatePlanCharge.UOM
                && this.unusedUnitsCreditRates == ratePlanChargeDataInRatePlanDataRatePlanCharge.unusedUnitsCreditRates
                && this.upToPeriods == ratePlanChargeDataInRatePlanDataRatePlanCharge.upToPeriods
                && this.upToPeriodsType == ratePlanChargeDataInRatePlanDataRatePlanCharge.upToPeriodsType
                && this.updatedById == ratePlanChargeDataInRatePlanDataRatePlanCharge.updatedById
                && this.updatedDate == ratePlanChargeDataInRatePlanDataRatePlanCharge.updatedDate
                && this.usageRecordRatingOption == ratePlanChargeDataInRatePlanDataRatePlanCharge.usageRecordRatingOption
                && this.useDiscountSpecificAccountingCode == ratePlanChargeDataInRatePlanDataRatePlanCharge.useDiscountSpecificAccountingCode
                && this.version == ratePlanChargeDataInRatePlanDataRatePlanCharge.version
                && this.weeklyBillCycleDay == ratePlanChargeDataInRatePlanDataRatePlanCharge.weeklyBillCycleDay;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (accountingCode == null ? 0 : System.hashCode(accountingCode));
        hashCode = (17 * hashCode) + (applyDiscountTo == null ? 0 : System.hashCode(applyDiscountTo));
        hashCode = (17 * hashCode) + (billCycleDay == null ? 0 : System.hashCode(billCycleDay));
        hashCode = (17 * hashCode) + (billCycleType == null ? 0 : System.hashCode(billCycleType));
        hashCode = (17 * hashCode) + (billingPeriod == null ? 0 : System.hashCode(billingPeriod));
        hashCode = (17 * hashCode) + (billingPeriodAlignment == null ? 0 : System.hashCode(billingPeriodAlignment));
        hashCode = (17 * hashCode) + (billingTiming == null ? 0 : System.hashCode(billingTiming));
        hashCode = (17 * hashCode) + (chargeModel == null ? 0 : System.hashCode(chargeModel));
        hashCode = (17 * hashCode) + (chargeNumber == null ? 0 : System.hashCode(chargeNumber));
        hashCode = (17 * hashCode) + (chargeType == null ? 0 : System.hashCode(chargeType));
        hashCode = (17 * hashCode) + (chargedThroughDate == null ? 0 : System.hashCode(chargedThroughDate));
        hashCode = (17 * hashCode) + (createdById == null ? 0 : System.hashCode(createdById));
        hashCode = (17 * hashCode) + (createdDate == null ? 0 : System.hashCode(createdDate));
        hashCode = (17 * hashCode) + (DMRC == null ? 0 : System.hashCode(DMRC));
        hashCode = (17 * hashCode) + (DTCV == null ? 0 : System.hashCode(DTCV));
        hashCode = (17 * hashCode) + (description == null ? 0 : System.hashCode(description));
        hashCode = (17 * hashCode) + (discountAmount == null ? 0 : System.hashCode(discountAmount));
        hashCode = (17 * hashCode) + (discountLevel == null ? 0 : System.hashCode(discountLevel));
        hashCode = (17 * hashCode) + (discountPercentage == null ? 0 : System.hashCode(discountPercentage));
        hashCode = (17 * hashCode) + (effectiveEndDate == null ? 0 : System.hashCode(effectiveEndDate));
        hashCode = (17 * hashCode) + (effectiveStartDate == null ? 0 : System.hashCode(effectiveStartDate));
        hashCode = (17 * hashCode) + (endDateCondition == null ? 0 : System.hashCode(endDateCondition));
        hashCode = (17 * hashCode) + (includedUnits == null ? 0 : System.hashCode(includedUnits));
        hashCode = (17 * hashCode) + (isLastSegment == null ? 0 : System.hashCode(isLastSegment));
        hashCode = (17 * hashCode) + (listPriceBase == null ? 0 : System.hashCode(listPriceBase));
        hashCode = (17 * hashCode) + (MRR == null ? 0 : System.hashCode(MRR));
        hashCode = (17 * hashCode) + (name == null ? 0 : System.hashCode(name));
        hashCode = (17 * hashCode) + (numberOfPeriods == null ? 0 : System.hashCode(numberOfPeriods));
        hashCode = (17 * hashCode) + (originalId == null ? 0 : System.hashCode(originalId));
        hashCode = (17 * hashCode) + (overageCalculationOption == null ? 0 : System.hashCode(overageCalculationOption));
        hashCode = (17 * hashCode) + (overagePrice == null ? 0 : System.hashCode(overagePrice));
        hashCode = (17 * hashCode) + (overageUnusedUnitsCreditOption == null ? 0 : System.hashCode(overageUnusedUnitsCreditOption));
        hashCode = (17 * hashCode) + (price == null ? 0 : System.hashCode(price));
        hashCode = (17 * hashCode) + (priceChangeOption == null ? 0 : System.hashCode(priceChangeOption));
        hashCode = (17 * hashCode) + (priceIncreasePercentage == null ? 0 : System.hashCode(priceIncreasePercentage));
        hashCode = (17 * hashCode) + (processedThroughDate == null ? 0 : System.hashCode(processedThroughDate));
        hashCode = (17 * hashCode) + (productRatePlanChargeId == null ? 0 : System.hashCode(productRatePlanChargeId));
        hashCode = (17 * hashCode) + (quantity == null ? 0 : System.hashCode(quantity));
        hashCode = (17 * hashCode) + (ratePlanId == null ? 0 : System.hashCode(ratePlanId));
        hashCode = (17 * hashCode) + (revRecCode == null ? 0 : System.hashCode(revRecCode));
        hashCode = (17 * hashCode) + (revRecTriggerCondition == null ? 0 : System.hashCode(revRecTriggerCondition));
        hashCode = (17 * hashCode) + (revenueRecognitionRuleName == null ? 0 : System.hashCode(revenueRecognitionRuleName));
        hashCode = (17 * hashCode) + (rolloverBalance == null ? 0 : System.hashCode(rolloverBalance));
        hashCode = (17 * hashCode) + (segment == null ? 0 : System.hashCode(segment));
        hashCode = (17 * hashCode) + (specificBillingPeriod == null ? 0 : System.hashCode(specificBillingPeriod));
        hashCode = (17 * hashCode) + (specificEndDate == null ? 0 : System.hashCode(specificEndDate));
        hashCode = (17 * hashCode) + (TCV == null ? 0 : System.hashCode(TCV));
        hashCode = (17 * hashCode) + (triggerDate == null ? 0 : System.hashCode(triggerDate));
        hashCode = (17 * hashCode) + (triggerEvent == null ? 0 : System.hashCode(triggerEvent));
        hashCode = (17 * hashCode) + (UOM == null ? 0 : System.hashCode(UOM));
        hashCode = (17 * hashCode) + (unusedUnitsCreditRates == null ? 0 : System.hashCode(unusedUnitsCreditRates));
        hashCode = (17 * hashCode) + (upToPeriods == null ? 0 : System.hashCode(upToPeriods));
        hashCode = (17 * hashCode) + (upToPeriodsType == null ? 0 : System.hashCode(upToPeriodsType));
        hashCode = (17 * hashCode) + (updatedById == null ? 0 : System.hashCode(updatedById));
        hashCode = (17 * hashCode) + (updatedDate == null ? 0 : System.hashCode(updatedDate));
        hashCode = (17 * hashCode) + (usageRecordRatingOption == null ? 0 : System.hashCode(usageRecordRatingOption));
        hashCode = (17 * hashCode) + (useDiscountSpecificAccountingCode == null ? 0 : System.hashCode(useDiscountSpecificAccountingCode));
        hashCode = (17 * hashCode) + (version == null ? 0 : System.hashCode(version));
        hashCode = (17 * hashCode) + (weeklyBillCycleDay == null ? 0 : System.hashCode(weeklyBillCycleDay));
        return hashCode;
    }
    */
}

public class AmendRequestAmendOptions implements WS001_CallZuora.MappedProperties {
    /**
     * 
     * @return applyCreditBalance
     */
    // public AmendRequestAmendOptions(){
    //     // this.electronicPaymentOptions = new ElectronicPaymentOptions();
    //     // this.externalPaymentOptions = new ExternalPaymentOptions();
    //     // this.invoiceProcessingOptions = new InvoiceProcessingOptions();
    // }

    public Boolean applyCreditBalance { get; set; }

    /**
     * Get electronicPaymentOptions
     * @return electronicPaymentOptions
     */
    public ElectronicPaymentOptions electronicPaymentOptions { get; set; }

    /**
     * Get externalPaymentOptions
     * @return externalPaymentOptions
     */
    public ExternalPaymentOptions externalPaymentOptions { get; set; }

    /**
     * 
     * @return generateInvoice
     */
    public Boolean generateInvoice { get; set; }

    /**
     * Get invoiceProcessingOptions
     * @return invoiceProcessingOptions
     */
    public InvoiceProcessingOptions invoiceProcessingOptions { get; set; }

    /**
     * 
     * @return processPayments
     */
    public Boolean processPayments { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'ApplyCreditBalance' => 'applyCreditBalance',
        'ElectronicPaymentOptions' => 'electronicPaymentOptions',
        'ExternalPaymentOptions' => 'externalPaymentOptions',
        'GenerateInvoice' => 'generateInvoice',
        'InvoiceProcessingOptions' => 'invoiceProcessingOptions',
        'ProcessPayments' => 'processPayments'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }


    public Boolean equals(Object obj) {
        if (obj instanceof AmendRequestAmendOptions) {
            AmendRequestAmendOptions amendRequestAmendOptions = (AmendRequestAmendOptions) obj;
            return this.applyCreditBalance == amendRequestAmendOptions.applyCreditBalance
                && this.electronicPaymentOptions == amendRequestAmendOptions.electronicPaymentOptions
                && this.externalPaymentOptions == amendRequestAmendOptions.externalPaymentOptions
                && this.generateInvoice == amendRequestAmendOptions.generateInvoice
                && this.invoiceProcessingOptions == amendRequestAmendOptions.invoiceProcessingOptions
                && this.processPayments == amendRequestAmendOptions.processPayments;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (applyCreditBalance == null ? 0 : System.hashCode(applyCreditBalance));
        hashCode = (17 * hashCode) + (electronicPaymentOptions == null ? 0 : System.hashCode(electronicPaymentOptions));
        hashCode = (17 * hashCode) + (externalPaymentOptions == null ? 0 : System.hashCode(externalPaymentOptions));
        hashCode = (17 * hashCode) + (generateInvoice == null ? 0 : System.hashCode(generateInvoice));
        hashCode = (17 * hashCode) + (invoiceProcessingOptions == null ? 0 : System.hashCode(invoiceProcessingOptions));
        hashCode = (17 * hashCode) + (processPayments == null ? 0 : System.hashCode(processPayments));
        return hashCode;
    }
}

public class ElectronicPaymentOptions implements WS001_CallZuora.MappedProperties {
    /**
     * 
     * @return paymentMethodId
     */
    public String paymentMethodId { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'PaymentMethodId' => 'paymentMethodId'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }


    public Boolean equals(Object obj) {
        if (obj instanceof ElectronicPaymentOptions) {
            ElectronicPaymentOptions electronicPaymentOptions = (ElectronicPaymentOptions) obj;
            return this.paymentMethodId == electronicPaymentOptions.paymentMethodId;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (paymentMethodId == null ? 0 : System.hashCode(paymentMethodId));
        return hashCode;
    }
}

public class ExternalPaymentOptions implements WS001_CallZuora.MappedProperties {
    /**
     * 
     * @return amount
     */
    public Double amount { get; set; }

    /**
     * 
     * @return effectiveDate
     */
    public Date effectiveDate { get; set; }

    /**
     * 
     * @return gatewayOrderId
     */
    public String gatewayOrderId { get; set; }

    /**
     * 
     * @return paymentMethodId
     */
    public String paymentMethodId { get; set; }

    /**
     * 
     * @return referenceId
     */
    public String referenceId { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Amount' => 'amount',
        'EffectiveDate' => 'effectiveDate',
        'GatewayOrderId' => 'gatewayOrderId',
        'PaymentMethodId' => 'paymentMethodId',
        'ReferenceId' => 'referenceId'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }


    public Boolean equals(Object obj) {
        if (obj instanceof ExternalPaymentOptions) {
            ExternalPaymentOptions externalPaymentOptions = (ExternalPaymentOptions) obj;
            return this.amount == externalPaymentOptions.amount
                && this.effectiveDate == externalPaymentOptions.effectiveDate
                && this.gatewayOrderId == externalPaymentOptions.gatewayOrderId
                && this.paymentMethodId == externalPaymentOptions.paymentMethodId
                && this.referenceId == externalPaymentOptions.referenceId;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (amount == null ? 0 : System.hashCode(amount));
        hashCode = (17 * hashCode) + (effectiveDate == null ? 0 : System.hashCode(effectiveDate));
        hashCode = (17 * hashCode) + (gatewayOrderId == null ? 0 : System.hashCode(gatewayOrderId));
        hashCode = (17 * hashCode) + (paymentMethodId == null ? 0 : System.hashCode(paymentMethodId));
        hashCode = (17 * hashCode) + (referenceId == null ? 0 : System.hashCode(referenceId));
        return hashCode;
    }
}

public class InvoiceProcessingOptions implements WS001_CallZuora.MappedProperties {
    /**
     *  The invoice date.
     * @return invoiceDate
     */
    public Date invoiceDate { get; set; }

    /**
     *  The date that determines which charges to bill. Charges prior to this date or on this date are billed on the resulting invoices. 
     * @return invoiceTargetDate
     */
    public Date invoiceTargetDate { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'InvoiceDate' => 'invoiceDate',
        'InvoiceTargetDate' => 'invoiceTargetDate'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }


    public Boolean equals(Object obj) {
        if (obj instanceof InvoiceProcessingOptions) {
            InvoiceProcessingOptions invoiceProcessingOptions = (InvoiceProcessingOptions) obj;
            return this.invoiceDate == invoiceProcessingOptions.invoiceDate
                && this.invoiceTargetDate == invoiceProcessingOptions.invoiceTargetDate;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (invoiceDate == null ? 0 : System.hashCode(invoiceDate));
        hashCode = (17 * hashCode) + (invoiceTargetDate == null ? 0 : System.hashCode(invoiceTargetDate));
        return hashCode;
    }
}


public class SubscriptionProductFeature  implements WS001_CallZuora.MappedProperties { // SubscriptionProductFeatureObject, 
    /**
     * 
     * @return createdById
     */
    public String createdById { get; set; }

    /**
     *  Date and time when the product feature was added to the subscription.\n\n\n**Character limit**: 29\n\n\n**Values**: 
     * @return createdDate
     */
    public Datetime createdDate { get; set; }

    /**
     *  Description of the subscription product feature.\n\n\n**Character limit**: 500\n\n\n**Values**: 
     * @return description
     */
    public String description { get; set; }

    /**
     *  Unique code of the feature.\n\n\n**Character limit**: 255\n\n\n**Values**: 
     * @return featureCode
     */
    public String featureCode { get; set; }

    /**
     *  Internal Zuora ID of the feature.\n\n\n**Character limit**: 32\n\n\n**Values**: 
     * @return featureId
     */
    public String featureId { get; set; }

    /**
     *  Name of the feature.\n\n\n**Character limit**: 255\n\n\n**Values**: 
     * @return name
     */
    public String name { get; set; }

    /**
     *  Id of the product rate plan to which the feature belongs.\n\n\n**Character limit**: 32\n\n\n**Values**: 
     * @return ratePlanId
     */
    public String ratePlanId { get; set; }

    /**
     *  Internal Zuora ID of the user who last updated the subscription product feature.\n\n\n**Character limit**: 32\n\n\n**Values**: 
     * @return updatedById
     */
    public String updatedById { get; set; }

    /**
     *  Date and time when the subscription product feature was last updated.\n\n\n**Character limit**: 29\n\n\n**Values**: 
     * @return updatedDate
     */
    public Datetime updatedDate { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'CreatedById' => 'createdById',
        'CreatedDate' => 'createdDate',
        'Description' => 'description',
        'FeatureCode' => 'featureCode',
        'FeatureId' => 'featureId',
        'Name' => 'name',
        'RatePlanId' => 'ratePlanId',
        'UpdatedById' => 'updatedById',
        'UpdatedDate' => 'updatedDate'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }


    public Boolean equals(Object obj) {
        if (obj instanceof SubscriptionProductFeature) {
            SubscriptionProductFeature subscriptionProductFeature = (SubscriptionProductFeature) obj;
            return this.createdById == subscriptionProductFeature.createdById
                && this.createdDate == subscriptionProductFeature.createdDate
                && this.description == subscriptionProductFeature.description
                && this.featureCode == subscriptionProductFeature.featureCode
                && this.featureId == subscriptionProductFeature.featureId
                && this.name == subscriptionProductFeature.name
                && this.ratePlanId == subscriptionProductFeature.ratePlanId
                && this.updatedById == subscriptionProductFeature.updatedById
                && this.updatedDate == subscriptionProductFeature.updatedDate;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (createdById == null ? 0 : System.hashCode(createdById));
        hashCode = (17 * hashCode) + (createdDate == null ? 0 : System.hashCode(createdDate));
        hashCode = (17 * hashCode) + (description == null ? 0 : System.hashCode(description));
        hashCode = (17 * hashCode) + (featureCode == null ? 0 : System.hashCode(featureCode));
        hashCode = (17 * hashCode) + (featureId == null ? 0 : System.hashCode(featureId));
        hashCode = (17 * hashCode) + (name == null ? 0 : System.hashCode(name));
        hashCode = (17 * hashCode) + (ratePlanId == null ? 0 : System.hashCode(ratePlanId));
        hashCode = (17 * hashCode) + (updatedById == null ? 0 : System.hashCode(updatedById));
        hashCode = (17 * hashCode) + (updatedDate == null ? 0 : System.hashCode(updatedDate));
        return hashCode;
    }
}

public class AmendResult  { // implements  WS001_CallZuora.MappedProperties {
    /**
     * A list of the IDs of the associated amendments. There can be as many as three amendment IDs. Use a comma to separate each amendment ID.\n
     * @return amendmentIds
     */
    public List<String> amendmentIds { get; set; }
    
    //TODO MBE asupprimer plus tard
    public ActionsErrorResponse singleError { get; set; }

    /**
     * Get chargeMetricsData
     * @return chargeMetricsData
     */
    public ChargeMetricsData chargeMetricsData { get; set; }

    /**
     * 
     * @return errors
     */
    public List<ActionsErrorResponse> errors { get; set; }

    /**
     * 
     * @return gatewayResponse
     */
    public String gatewayResponse { get; set; }

    /**
     * 
     * @return gatewayResponseCode
     */
    public String gatewayResponseCode { get; set; }

    /**
     * 
     * @return invoiceDatas
     */
    public List<InvoiceData> invoiceDatas { get; set; }

    /**
     * 
     * @return invoiceId
     */
    public String invoiceId { get; set; }

    /**
     * 
     * @return paymentId
     */
    public String paymentId { get; set; }

    /**
     * 
     * @return paymentTransactionNumber
     */
    public String paymentTransactionNumber { get; set; }

    /**
     * 
     * @return subscriptionId
     */
    public String subscriptionId { get; set; }

    /**
     * 
     * @return success
     */
    public Boolean success { get; set; }

    /**
     * 
     * @return totalDeltaMrr
     */
    public Double totalDeltaMrr { get; set; }

    /**
     * 
     * @return totalDeltaTcv
     */
    public Double totalDeltaTcv { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'AmendmentIds' => 'amendmentIds',
        'ChargeMetricsData' => 'chargeMetricsData',
        'Errors' => 'errors',
        'GatewayResponse' => 'gatewayResponse',
        'GatewayResponseCode' => 'gatewayResponseCode',
        'InvoiceDatas' => 'invoiceDatas',
        'InvoiceId' => 'invoiceId',
        'PaymentId' => 'paymentId',
        'PaymentTransactionNumber' => 'paymentTransactionNumber',
        'SubscriptionId' => 'subscriptionId',
        'Success' => 'success',
        'TotalDeltaMrr' => 'totalDeltaMrr',
        'TotalDeltaTcv' => 'totalDeltaTcv',
        'SingleError' => 'singleError'        
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public AmendResult() {
        amendmentIds = new List<String>();
        errors = new List<ActionsErrorResponse>{new ActionsErrorResponse()};
        invoiceDatas = new List<InvoiceData>();
        singleError = new ActionsErrorResponse();
    }


    public Boolean equals(Object obj) {
        if (obj instanceof AmendResult) {
            AmendResult amendResult = (AmendResult) obj;
            return this.amendmentIds == amendResult.amendmentIds
                && this.chargeMetricsData == amendResult.chargeMetricsData
                && this.errors == amendResult.errors
                && this.gatewayResponse == amendResult.gatewayResponse
                && this.gatewayResponseCode == amendResult.gatewayResponseCode
                && this.invoiceDatas == amendResult.invoiceDatas
                && this.invoiceId == amendResult.invoiceId
                && this.paymentId == amendResult.paymentId
                && this.paymentTransactionNumber == amendResult.paymentTransactionNumber
                && this.subscriptionId == amendResult.subscriptionId
                && this.success == amendResult.success
                && this.totalDeltaMrr == amendResult.totalDeltaMrr
                && this.totalDeltaTcv == amendResult.totalDeltaTcv;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (amendmentIds == null ? 0 : System.hashCode(amendmentIds));
        hashCode = (17 * hashCode) + (chargeMetricsData == null ? 0 : System.hashCode(chargeMetricsData));
        hashCode = (17 * hashCode) + (errors == null ? 0 : System.hashCode(errors));
        hashCode = (17 * hashCode) + (gatewayResponse == null ? 0 : System.hashCode(gatewayResponse));
        hashCode = (17 * hashCode) + (gatewayResponseCode == null ? 0 : System.hashCode(gatewayResponseCode));
        hashCode = (17 * hashCode) + (invoiceDatas == null ? 0 : System.hashCode(invoiceDatas));
        hashCode = (17 * hashCode) + (invoiceId == null ? 0 : System.hashCode(invoiceId));
        hashCode = (17 * hashCode) + (paymentId == null ? 0 : System.hashCode(paymentId));
        hashCode = (17 * hashCode) + (paymentTransactionNumber == null ? 0 : System.hashCode(paymentTransactionNumber));
        hashCode = (17 * hashCode) + (subscriptionId == null ? 0 : System.hashCode(subscriptionId));
        hashCode = (17 * hashCode) + (success == null ? 0 : System.hashCode(success));
        hashCode = (17 * hashCode) + (totalDeltaMrr == null ? 0 : System.hashCode(totalDeltaMrr));
        hashCode = (17 * hashCode) + (totalDeltaTcv == null ? 0 : System.hashCode(totalDeltaTcv));
        return hashCode;
    }
}

public class ChargeMetricsData implements WS001_CallZuora.MappedProperties {
    /**
     * 
     * @return chargeMetrics
     */
    public List<NewChargeMetrics> chargeMetrics { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'ChargeMetrics' => 'chargeMetrics'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public ChargeMetricsData() {
        chargeMetrics = new List<NewChargeMetrics>();
    }


    public Boolean equals(Object obj) {
        if (obj instanceof ChargeMetricsData) {
            ChargeMetricsData chargeMetricsData = (ChargeMetricsData) obj;
            return this.chargeMetrics == chargeMetricsData.chargeMetrics;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (chargeMetrics == null ? 0 : System.hashCode(chargeMetrics));
        return hashCode;
    }
}

public class NewChargeMetrics  implements WS001_CallZuora.MappedProperties {
    /**
     * 
     * @return chargeNumber
     */
    public String chargeNumber { get; set; }

    /**
     * 
     * @return DMRR
     */
    public Double DMRR { get; set; }

    /**
     * 
     * @return DTCV
     */
    public Double DTCV { get; set; }

    /**
     * 
     * @return MRR
     */
    public Double MRR { get; set; }

    /**
     * 
     * @return originalId
     */
    public String originalId { get; set; }

    /**
     * 
     * @return originalRatePlanId
     */
    public String originalRatePlanId { get; set; }

    /**
     * 
     * @return productRatePlanChargeId
     */
    public String productRatePlanChargeId { get; set; }

    /**
     * 
     * @return productRatePlanId
     */
    public String productRatePlanId { get; set; }

    /**
     * 
     * @return TCV
     */
    public Double TCV { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'ChargeNumber' => 'chargeNumber',
        'OriginalId' => 'originalId',
        'OriginalRatePlanId' => 'originalRatePlanId',
        'ProductRatePlanChargeId' => 'productRatePlanChargeId',
        'ProductRatePlanId' => 'productRatePlanId'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }


    public Boolean equals(Object obj) {
        if (obj instanceof NewChargeMetrics) {
            NewChargeMetrics newChargeMetrics = (NewChargeMetrics) obj;
            return this.chargeNumber == newChargeMetrics.chargeNumber
                && this.DMRR == newChargeMetrics.DMRR
                && this.DTCV == newChargeMetrics.DTCV
                && this.MRR == newChargeMetrics.MRR
                && this.originalId == newChargeMetrics.originalId
                && this.originalRatePlanId == newChargeMetrics.originalRatePlanId
                && this.productRatePlanChargeId == newChargeMetrics.productRatePlanChargeId
                && this.productRatePlanId == newChargeMetrics.productRatePlanId
                && this.TCV == newChargeMetrics.TCV;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (chargeNumber == null ? 0 : System.hashCode(chargeNumber));
        hashCode = (17 * hashCode) + (DMRR == null ? 0 : System.hashCode(DMRR));
        hashCode = (17 * hashCode) + (DTCV == null ? 0 : System.hashCode(DTCV));
        hashCode = (17 * hashCode) + (MRR == null ? 0 : System.hashCode(MRR));
        hashCode = (17 * hashCode) + (originalId == null ? 0 : System.hashCode(originalId));
        hashCode = (17 * hashCode) + (originalRatePlanId == null ? 0 : System.hashCode(originalRatePlanId));
        hashCode = (17 * hashCode) + (productRatePlanChargeId == null ? 0 : System.hashCode(productRatePlanChargeId));
        hashCode = (17 * hashCode) + (productRatePlanId == null ? 0 : System.hashCode(productRatePlanId));
        hashCode = (17 * hashCode) + (TCV == null ? 0 : System.hashCode(TCV));
        return hashCode;
    }
}

public class ActionsErrorResponse  implements WS001_CallZuora.MappedProperties {
    /**
     * 
     * @return code
     */
    public String code { get; set; }

    /**
     * 
     * @return message
     */
    public String message { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Code' => 'code',
        'Message' => 'message'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }


    public Boolean equals(Object obj) {
        if (obj instanceof ActionsErrorResponse) {
            ActionsErrorResponse actionsErrorResponse = (ActionsErrorResponse) obj;
            return this.code == actionsErrorResponse.code
                && this.message == actionsErrorResponse.message;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (code == null ? 0 : System.hashCode(code));
        hashCode = (17 * hashCode) + (message == null ? 0 : System.hashCode(message));
        return hashCode;
    }
}

public class InvoiceData  implements WS001_CallZuora.MappedProperties {
    /**
     * Get invoice
     * @return invoice
     */
    public InvoiceDataInvoice invoice { get; set; }

    /**
     * 
     * @return invoiceItem
     */
    public List<InvoiceItem> invoiceItem { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Invoice' => 'invoice',
        'InvoiceItem' => 'invoiceItem'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public InvoiceData() {
        invoiceItem = new List<InvoiceItem>();
    }


    public Boolean equals(Object obj) {
        if (obj instanceof InvoiceData) {
            InvoiceData invoiceData = (InvoiceData) obj;
            return this.invoice == invoiceData.invoice
                && this.invoiceItem == invoiceData.invoiceItem;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (invoice == null ? 0 : System.hashCode(invoice));
        hashCode = (17 * hashCode) + (invoiceItem == null ? 0 : System.hashCode(invoiceItem));
        return hashCode;
    }
}

public class InvoiceDataInvoice  implements WS001_CallZuora.MappedProperties { // InvoiceObjectNSFields, InvoiceObjectCustomFields, 
    /**
     * ID of the corresponding object in NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return integrationIdNS
     */
    public String integrationIdNS { get; set; }

    /**
     * Status of the invoice\'s synchronization with NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return integrationStatusNS
     */
    public String integrationStatusNS { get; set; }

    /**
     * Date when the invoice was synchronized with NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return syncDateNS
     */
    public String syncDateNS { get; set; }

    /**
     * 
     * @return accountId
     */
    public String accountId { get; set; }

    /**
     *  The amount of the invoice adjustments associated with the invoice. **Character limi**t: 16\n\n\n**Values**: a valid currency amount 
     * @return adjustmentAmount
     */
    public Double adjustmentAmount { get; set; }

    /**
     *  The sum of all charges and taxes associated with the invoice.\n\n\n**Character limit**: 16\n\n\n**Values**: automatically generated 
     * @return amount
     */
    public Double amount { get; set; }

    /**
     *  The sum of all charges associated with the invoice. Taxes are excluded from this value.\n\n\n**Character limit**: 16\n\n\n**Values**: automatically generated 
     * @return amountWithoutTax
     */
    public Double amountWithoutTax { get; set; }

    /**
     *  The remaining balance of the invoice after all payments, adjustments, and refunds are applied.\n\n\n**Character limit**: 16\n\n\n**Values**: automatically generated 
     * @return balance
     */
    public Double balance { get; set; }

    /**
     *  The ID of a Bill Run.\n\n\n**Character limit**: 32\n\n\n**Values**: a BillRun ID 
     * @return billRunId
     */
    public String billRunId { get; set; }

    /**
     *  Required 
     * @return body
     */
    public String body { get; set; }

    /**
     *  Additional information related to the invoice that a Zuora user added to the invoice.\n\n\n**Character limit**: 255 **Values:** a string of 255 characters or fewer 
     * @return comments
     */
    public String comments { get; set; }

    /**
     *  The user ID of the person who created the invoice. If a bill run generated the invoice, then the value is the user ID of person who created the bill run.\n\n\n**Character limit**: 32\n\n\n**Values**: automatically generated 
     * @return createdById
     */
    public String createdById { get; set; }

    /**
     *  The date when the invoice was generated.\n\n\n**Character limit**: 29\n\n\n**Values**: automatically generated 
     * @return createdDate
     */
    public Datetime createdDate { get; set; }

    /**
     *  The currency amount of the adjustment applied to the customer\'s credit balance.\n\n\n**Character limit**: 16\n\n\n**Values**: a valid currency amount This field is only available if the [Zuora Global Support](http://support.zuora.com/) to enable this feature.\n\n\n
     * @return creditBalanceAdjustmentAmount
     */
    public Double creditBalanceAdjustmentAmount { get; set; }

    /**
     *  The date by which the payment for this invoice is due.\n\n\n**Character limit**: 29 
     * @return dueDate
     */
    public Date dueDate { get; set; }

    /**
     *  Specifies whether the invoice includes one-time charges. You can use this field only with the `generate\n` call for the Invoice object.\n\n\n**Character limit**: 5\n\n\n**Values**: automatically generated from one of the following: `True` (default), `False` 
     * @return includesOneTime
     */
    public Boolean includesOneTime { get; set; }

    /**
     *  Specifies whether the invoice includes recurring charges. You can use this field only with the `generate\n`call for the Invoice object.\n\n\n**Character limit**: 5\n\n\n**Values**: automatically generated from one of the following: `True` (default), `False` 
     * @return includesRecurring
     */
    public Boolean includesRecurring { get; set; }

    /**
     *  Specifies whether the invoice includes usage charges. You can use this field only with the `generate\n`call for the Invoice object.\n\n\n**Character limit**: 5\n\n\n**Values**: automatically generated from one of the following: `True `(default), `False` 
     * @return includesUsage
     */
    public Boolean includesUsage { get; set; }

    /**
     *  Specifies the date on which to generate the invoice.\n\n\n**Character limit**: 29 
     * @return invoiceDate
     */
    public Date invoiceDate { get; set; }

    /**
     *  The unique identification number for the invoice. This number is returned as a string.\n\n\n**Character limit**: 32\n\n\n**Values**: automatically generated 
     * @return invoiceNumber
     */
    public String invoiceNumber { get; set; }

    /**
     *  The date when the invoice was last emailed.\n\n\n**Character limit**: 29\n\n\n**Values**: automatically generated 
     * @return lastEmailSentDate
     */
    public Datetime lastEmailSentDate { get; set; }

    /**
     *  The amount of payments applied to the invoice.\n\n\n**Character limit**: 16 **Value**s: automatically generated 
     * @return paymentAmount
     */
    public Double paymentAmount { get; set; }

    /**
     *  The user ID of the person who moved the invoice to Posted status.\n\n\n**Character limit**: 32\n\n\n**Values**: automatically generated 
     * @return postedBy
     */
    public String postedBy { get; set; }

    /**
     *  The date when the invoice was posted.\n**Character limit:** 29\n\n\n**Values**: automatically generated 
     * @return postedDate
     */
    public Datetime postedDate { get; set; }

    /**
     *  Specifies the amount of a refund that was applied against an earlier payment on the invoice.\n\n\n**Character limit**: 16\n\n\n**Values**: automatically generated 
     * @return refundAmount
     */
    public Double refundAmount { get; set; }

    /**
     *  Regenerates a PDF of an invoice that was already generated. Add this field to an `update\n` call to regenerate an invoice PDF. Note that when you set the `RegenerateInvoicePDF` field to `true`, you cannot update any other fields in the same `update\n` call. Otherwise, you will receive the following `INVALID_VALUE` error: &quot;When field RegenerateInvoicePDF is set to true to regenerate the invoice PDF file, changes on other fields of the invoice are not allowed.&quot;\n\n**Character limit**: 5\n\n\n**Values**: `True`, `False` 
     * @return regenerateInvoicePDF
     */
    public Boolean regenerateInvoicePDF { get; set; }

    /**
     *  The status of the invoice in the system. This status is not the status of the payment of the invoice, just the status of the invoice itself.\n\n\n**Character limit**: 8\n\n\n**Values**: one of the following:\n\n-  Draft (default, automatically set upon invoice creation)\n\n-  Posted\n\n-  Canceled\n\n
     * @return status
     */
    public String status { get; set; }

    /**
     *  This date is used to determine which charges are to be billed. All charges that are to be billed on this date or prior will be included in this bill run.\n\n\n**Character limit**: 29 
     * @return targetDate
     */
    public Date targetDate { get; set; }

    /**
     *  The total amount of the taxes applied to the invoice.\n\n\n**Character limit**: 16\n\n\n**Values**: automatically generated 
     * @return taxAmount
     */
    public Double taxAmount { get; set; }

    /**
     *  The total amount of the invoice that is exempt from taxation.\n\n\n**Character limit**: 16\n\n\n**Values**: automatically generated 
     * @return taxExemptAmount
     */
    public Double taxExemptAmount { get; set; }

    /**
     *  Specifies whether or not the invoice was transferred to an external accounting system, such as NetSuite.\n\n\n**Character limit**: 10\n\n\n**Values**: Processing, Yes, Error, Ignore 
     * @return transferredToAccounting
     */
    public String transferredToAccounting { get; set; }

    /**
     * 
     * @return updatedById
     */
    public String updatedById { get; set; }

    /**
     *  The date when the invoice was last updated.\n\n\n**Character limit**: 29\n\n\n**Values**: automatically generated 
     * @return updatedDate
     */
    public Datetime updatedDate { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'IntegrationId__NS' => 'integrationIdNS',
        'IntegrationStatus__NS' => 'integrationStatusNS',
        'SyncDate__NS' => 'syncDateNS',
        'AccountId' => 'accountId',
        'AdjustmentAmount' => 'adjustmentAmount',
        'Amount' => 'amount',
        'AmountWithoutTax' => 'amountWithoutTax',
        'Balance' => 'balance',
        'BillRunId' => 'billRunId',
        'Body' => 'body',
        'Comments' => 'comments',
        'CreatedById' => 'createdById',
        'CreatedDate' => 'createdDate',
        'CreditBalanceAdjustmentAmount' => 'creditBalanceAdjustmentAmount',
        'DueDate' => 'dueDate',
        'IncludesOneTime' => 'includesOneTime',
        'IncludesRecurring' => 'includesRecurring',
        'IncludesUsage' => 'includesUsage',
        'InvoiceDate' => 'invoiceDate',
        'InvoiceNumber' => 'invoiceNumber',
        'LastEmailSentDate' => 'lastEmailSentDate',
        'PaymentAmount' => 'paymentAmount',
        'PostedBy' => 'postedBy',
        'PostedDate' => 'postedDate',
        'RefundAmount' => 'refundAmount',
        'RegenerateInvoicePDF' => 'regenerateInvoicePDF',
        'Status' => 'status',
        'TargetDate' => 'targetDate',
        'TaxAmount' => 'taxAmount',
        'TaxExemptAmount' => 'taxExemptAmount',
        'TransferredToAccounting' => 'transferredToAccounting',
        'UpdatedById' => 'updatedById',
        'UpdatedDate' => 'updatedDate'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }


    public Boolean equals(Object obj) {
        if (obj instanceof InvoiceDataInvoice) {
            InvoiceDataInvoice invoiceDataInvoice = (InvoiceDataInvoice) obj;
            return this.integrationIdNS == invoiceDataInvoice.integrationIdNS
                && this.integrationStatusNS == invoiceDataInvoice.integrationStatusNS
                && this.syncDateNS == invoiceDataInvoice.syncDateNS
                && this.accountId == invoiceDataInvoice.accountId
                && this.adjustmentAmount == invoiceDataInvoice.adjustmentAmount
                && this.amount == invoiceDataInvoice.amount
                && this.amountWithoutTax == invoiceDataInvoice.amountWithoutTax
                && this.balance == invoiceDataInvoice.balance
                && this.billRunId == invoiceDataInvoice.billRunId
                && this.body == invoiceDataInvoice.body
                && this.comments == invoiceDataInvoice.comments
                && this.createdById == invoiceDataInvoice.createdById
                && this.createdDate == invoiceDataInvoice.createdDate
                && this.creditBalanceAdjustmentAmount == invoiceDataInvoice.creditBalanceAdjustmentAmount
                && this.dueDate == invoiceDataInvoice.dueDate
                && this.includesOneTime == invoiceDataInvoice.includesOneTime
                && this.includesRecurring == invoiceDataInvoice.includesRecurring
                && this.includesUsage == invoiceDataInvoice.includesUsage
                && this.invoiceDate == invoiceDataInvoice.invoiceDate
                && this.invoiceNumber == invoiceDataInvoice.invoiceNumber
                && this.lastEmailSentDate == invoiceDataInvoice.lastEmailSentDate
                && this.paymentAmount == invoiceDataInvoice.paymentAmount
                && this.postedBy == invoiceDataInvoice.postedBy
                && this.postedDate == invoiceDataInvoice.postedDate
                && this.refundAmount == invoiceDataInvoice.refundAmount
                && this.regenerateInvoicePDF == invoiceDataInvoice.regenerateInvoicePDF
                && this.status == invoiceDataInvoice.status
                && this.targetDate == invoiceDataInvoice.targetDate
                && this.taxAmount == invoiceDataInvoice.taxAmount
                && this.taxExemptAmount == invoiceDataInvoice.taxExemptAmount
                && this.transferredToAccounting == invoiceDataInvoice.transferredToAccounting
                && this.updatedById == invoiceDataInvoice.updatedById
                && this.updatedDate == invoiceDataInvoice.updatedDate;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (integrationIdNS == null ? 0 : System.hashCode(integrationIdNS));
        hashCode = (17 * hashCode) + (integrationStatusNS == null ? 0 : System.hashCode(integrationStatusNS));
        hashCode = (17 * hashCode) + (syncDateNS == null ? 0 : System.hashCode(syncDateNS));
        hashCode = (17 * hashCode) + (accountId == null ? 0 : System.hashCode(accountId));
        hashCode = (17 * hashCode) + (adjustmentAmount == null ? 0 : System.hashCode(adjustmentAmount));
        hashCode = (17 * hashCode) + (amount == null ? 0 : System.hashCode(amount));
        hashCode = (17 * hashCode) + (amountWithoutTax == null ? 0 : System.hashCode(amountWithoutTax));
        hashCode = (17 * hashCode) + (balance == null ? 0 : System.hashCode(balance));
        hashCode = (17 * hashCode) + (billRunId == null ? 0 : System.hashCode(billRunId));
        hashCode = (17 * hashCode) + (body == null ? 0 : System.hashCode(body));
        hashCode = (17 * hashCode) + (comments == null ? 0 : System.hashCode(comments));
        hashCode = (17 * hashCode) + (createdById == null ? 0 : System.hashCode(createdById));
        hashCode = (17 * hashCode) + (createdDate == null ? 0 : System.hashCode(createdDate));
        hashCode = (17 * hashCode) + (creditBalanceAdjustmentAmount == null ? 0 : System.hashCode(creditBalanceAdjustmentAmount));
        hashCode = (17 * hashCode) + (dueDate == null ? 0 : System.hashCode(dueDate));
        hashCode = (17 * hashCode) + (includesOneTime == null ? 0 : System.hashCode(includesOneTime));
        hashCode = (17 * hashCode) + (includesRecurring == null ? 0 : System.hashCode(includesRecurring));
        hashCode = (17 * hashCode) + (includesUsage == null ? 0 : System.hashCode(includesUsage));
        hashCode = (17 * hashCode) + (invoiceDate == null ? 0 : System.hashCode(invoiceDate));
        hashCode = (17 * hashCode) + (invoiceNumber == null ? 0 : System.hashCode(invoiceNumber));
        hashCode = (17 * hashCode) + (lastEmailSentDate == null ? 0 : System.hashCode(lastEmailSentDate));
        hashCode = (17 * hashCode) + (paymentAmount == null ? 0 : System.hashCode(paymentAmount));
        hashCode = (17 * hashCode) + (postedBy == null ? 0 : System.hashCode(postedBy));
        hashCode = (17 * hashCode) + (postedDate == null ? 0 : System.hashCode(postedDate));
        hashCode = (17 * hashCode) + (refundAmount == null ? 0 : System.hashCode(refundAmount));
        hashCode = (17 * hashCode) + (regenerateInvoicePDF == null ? 0 : System.hashCode(regenerateInvoicePDF));
        hashCode = (17 * hashCode) + (status == null ? 0 : System.hashCode(status));
        hashCode = (17 * hashCode) + (targetDate == null ? 0 : System.hashCode(targetDate));
        hashCode = (17 * hashCode) + (taxAmount == null ? 0 : System.hashCode(taxAmount));
        hashCode = (17 * hashCode) + (taxExemptAmount == null ? 0 : System.hashCode(taxExemptAmount));
        hashCode = (17 * hashCode) + (transferredToAccounting == null ? 0 : System.hashCode(transferredToAccounting));
        hashCode = (17 * hashCode) + (updatedById == null ? 0 : System.hashCode(updatedById));
        hashCode = (17 * hashCode) + (updatedDate == null ? 0 : System.hashCode(updatedDate));
        return hashCode;
    }
}

public class InvoiceItem  implements WS001_CallZuora.MappedProperties { // InvoiceItemObjectNSFields, InvoiceItemObjectCustomFields, 
    /**
     * ID of the corresponding object in NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return integrationIdNS
     */
    public String integrationIdNS { get; set; }

    /**
     * Status of the invoice item\'s synchronization with NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return integrationStatusNS
     */
    public String integrationStatusNS { get; set; }

    /**
     * Date when the invoice item was synchronized with NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return syncDateNS
     */
    public String syncDateNS { get; set; }

    /**
     * The unique ID of the invoice item that the discount charge is applied to.
     * @return appliedToItemId
     */
    public String appliedToItemId { get; set; }

    /**
     * The amount of the invoice item that is available to credit.        \n
     * @return availableToCreditAmount
     */
    public Double availableToCreditAmount { get; set; }

    /**
     * The balance of the invoice item.
     * @return balance
     */
    public String balance { get; set; }

    /**
     * The amount of the charge. This amount does not include taxes regardless if the charge\'s tax mode is inclusive or exclusive.
     * @return chargeAmount
     */
    public String chargeAmount { get; set; }

    /**
     * Description of the charge.
     * @return chargeDescription
     */
    public String chargeDescription { get; set; }

    /**
     * ID of the charge.
     * @return chargeId
     */
    public String chargeId { get; set; }

    /**
     * Name of the charge.
     * @return chargeName
     */
    public String chargeName { get; set; }

    /**
     * Item ID.
     * @return id
     */
    public String id { get; set; }

    /**
     * Name of the product associated with this item.
     * @return productName
     */
    public String productName { get; set; }

    /**
     * Quantity of this item, in the configured unit of measure for the charge.
     * @return quantity
     */
    public String quantity { get; set; }

    /**
     * End date of the service period for this item, i.e., the last day of the service period, as _yyyy-mm-dd_.
     * @return serviceEndDate
     */
    public Date serviceEndDate { get; set; }

    /**
     * Start date of the service period for this item, as _yyyy-mm-dd_. For a one-time fee item, the date of the charge.
     * @return serviceStartDate
     */
    public Date serviceStartDate { get; set; }

    /**
     * ID of the subscription for this item.
     * @return subscriptionId
     */
    public String subscriptionId { get; set; }

    /**
     * Name of the subscription for this item.
     * @return subscriptionName
     */
    public String subscriptionName { get; set; }

    /**
     * Returns `true` if the request was processed successfully.
     * @return success
     */
    public Boolean success { get; set; }

    /**
     * Tax applied to the charge.
     * @return taxAmount
     */
    public String taxAmount { get; set; }

    /**
     * Get taxationItems
     * @return taxationItems
     */
    public InvoiceItemTaxationItems taxationItems { get; set; }

    /**
     * Unit used to measure. consumption.
     * @return unitOfMeasure
     */
    public String unitOfMeasure { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'IntegrationId__NS' => 'integrationIdNS',
        'IntegrationStatus__NS' => 'integrationStatusNS',
        'SyncDate__NS' => 'syncDateNS'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }


    public Boolean equals(Object obj) {
        if (obj instanceof InvoiceItem) {
            InvoiceItem invoiceItem = (InvoiceItem) obj;
            return this.integrationIdNS == invoiceItem.integrationIdNS
                && this.integrationStatusNS == invoiceItem.integrationStatusNS
                && this.syncDateNS == invoiceItem.syncDateNS
                && this.appliedToItemId == invoiceItem.appliedToItemId
                && this.availableToCreditAmount == invoiceItem.availableToCreditAmount
                && this.balance == invoiceItem.balance
                && this.chargeAmount == invoiceItem.chargeAmount
                && this.chargeDescription == invoiceItem.chargeDescription
                && this.chargeId == invoiceItem.chargeId
                && this.chargeName == invoiceItem.chargeName
                && this.id == invoiceItem.id
                && this.productName == invoiceItem.productName
                && this.quantity == invoiceItem.quantity
                && this.serviceEndDate == invoiceItem.serviceEndDate
                && this.serviceStartDate == invoiceItem.serviceStartDate
                && this.subscriptionId == invoiceItem.subscriptionId
                && this.subscriptionName == invoiceItem.subscriptionName
                && this.success == invoiceItem.success
                && this.taxAmount == invoiceItem.taxAmount
                && this.taxationItems == invoiceItem.taxationItems
                && this.unitOfMeasure == invoiceItem.unitOfMeasure;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (integrationIdNS == null ? 0 : System.hashCode(integrationIdNS));
        hashCode = (17 * hashCode) + (integrationStatusNS == null ? 0 : System.hashCode(integrationStatusNS));
        hashCode = (17 * hashCode) + (syncDateNS == null ? 0 : System.hashCode(syncDateNS));
        hashCode = (17 * hashCode) + (appliedToItemId == null ? 0 : System.hashCode(appliedToItemId));
        hashCode = (17 * hashCode) + (availableToCreditAmount == null ? 0 : System.hashCode(availableToCreditAmount));
        hashCode = (17 * hashCode) + (balance == null ? 0 : System.hashCode(balance));
        hashCode = (17 * hashCode) + (chargeAmount == null ? 0 : System.hashCode(chargeAmount));
        hashCode = (17 * hashCode) + (chargeDescription == null ? 0 : System.hashCode(chargeDescription));
        hashCode = (17 * hashCode) + (chargeId == null ? 0 : System.hashCode(chargeId));
        hashCode = (17 * hashCode) + (chargeName == null ? 0 : System.hashCode(chargeName));
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
        hashCode = (17 * hashCode) + (productName == null ? 0 : System.hashCode(productName));
        hashCode = (17 * hashCode) + (quantity == null ? 0 : System.hashCode(quantity));
        hashCode = (17 * hashCode) + (serviceEndDate == null ? 0 : System.hashCode(serviceEndDate));
        hashCode = (17 * hashCode) + (serviceStartDate == null ? 0 : System.hashCode(serviceStartDate));
        hashCode = (17 * hashCode) + (subscriptionId == null ? 0 : System.hashCode(subscriptionId));
        hashCode = (17 * hashCode) + (subscriptionName == null ? 0 : System.hashCode(subscriptionName));
        hashCode = (17 * hashCode) + (success == null ? 0 : System.hashCode(success));
        hashCode = (17 * hashCode) + (taxAmount == null ? 0 : System.hashCode(taxAmount));
        hashCode = (17 * hashCode) + (taxationItems == null ? 0 : System.hashCode(taxationItems));
        hashCode = (17 * hashCode) + (unitOfMeasure == null ? 0 : System.hashCode(unitOfMeasure));
        return hashCode;
    }
}

public class InvoiceItemTaxationItems {
    /**
     * List of taxation items.\n
     * @return data
     */
    public List<GETInvoiceTaxItemType> data { get; set; }

    /**
     * URL to retrieve the next page of the response if it exists; otherwise absent.\n
     * @return nextPage
     */
    public String nextPage { get; set; }

    public InvoiceItemTaxationItems() {
        data = new List<GETInvoiceTaxItemType>();
    }


    public Boolean equals(Object obj) {
        if (obj instanceof InvoiceItemTaxationItems) {
            InvoiceItemTaxationItems invoiceItemTaxationItems = (InvoiceItemTaxationItems) obj;
            return this.data == invoiceItemTaxationItems.data
                && this.nextPage == invoiceItemTaxationItems.nextPage;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (data == null ? 0 : System.hashCode(data));
        hashCode = (17 * hashCode) + (nextPage == null ? 0 : System.hashCode(nextPage));
        return hashCode;
    }
}

public class GETInvoiceTaxItemType {
    /**
     * The amount of the invoice taxation item that is available to credit.\n
     * @return availableToCreditAmount
     */
    public Double availableToCreditAmount { get; set; }

    /**
     * The balance of the taxation item.\n
     * @return balance
     */
    public Double balance { get; set; }

    /**
     * The amount of credit memos applied to the taxation item. \n
     * @return creditAmount
     */
    public Double creditAmount { get; set; }

    /**
     * The amount of taxes or VAT for which the customer has an exemption.\n
     * @return exemptAmount
     */
    public Double exemptAmount { get; set; }

    /**
     * The ID of the taxation item.\n
     * @return id
     */
    public String id { get; set; }

    /**
     * The jurisdiction that applies the tax or VAT. This value is typically a state, province, county, or city.\n
     * @return jurisdiction
     */
    public String jurisdiction { get; set; }

    /**
     * The identifier for the location based on the value of the `taxCode` field.\n
     * @return locationCode
     */
    public String locationCode { get; set; }

    /**
     * The name of the taxation item.\n
     * @return name
     */
    public String name { get; set; }

    /**
     * The amount of payments applied to the taxation item. \n
     * @return paymentAmount
     */
    public Double paymentAmount { get; set; }

    /**
     * The amount of taxation.\n
     * @return taxAmount
     */
    public Double taxAmount { get; set; }

    /**
     * The tax code identifies which tax rules and tax rates to apply to a specific invoice.\n
     * @return taxCode
     */
    public String taxCode { get; set; }

    /**
     * The description of the tax code.\n
     * @return taxCodeDescription
     */
    public String taxCodeDescription { get; set; }

    /**
     * The date that the tax is applied to the invoice, in `yyyy-mm-dd` format.\n
     * @return taxDate
     */
    public Date taxDate { get; set; }

    /**
     * The tax rate applied to the invoice.\n
     * @return taxRate
     */
    public Double taxRate { get; set; }

    /**
     * The description of the tax rate.\n
     * @return taxRateDescription
     */
    public String taxRateDescription { get; set; }

    /**
     * The type of the tax rate.\n
     */
    // public enum TaxRateTypeEnum {
    //     PERCENTAGE,
    //     FLATFEE
    // }

    /**
     * The type of the tax rate.\n
     * @return taxRateType
     */
    // public TaxRateTypeEnum taxRateType { get; set; }


    public Boolean equals(Object obj) {
        if (obj instanceof GETInvoiceTaxItemType) {
            GETInvoiceTaxItemType geTInvoiceTaxItemType = (GETInvoiceTaxItemType) obj;
            return this.availableToCreditAmount == geTInvoiceTaxItemType.availableToCreditAmount
                && this.balance == geTInvoiceTaxItemType.balance
                && this.creditAmount == geTInvoiceTaxItemType.creditAmount
                && this.exemptAmount == geTInvoiceTaxItemType.exemptAmount
                && this.id == geTInvoiceTaxItemType.id
                && this.jurisdiction == geTInvoiceTaxItemType.jurisdiction
                && this.locationCode == geTInvoiceTaxItemType.locationCode
                && this.name == geTInvoiceTaxItemType.name
                && this.paymentAmount == geTInvoiceTaxItemType.paymentAmount
                && this.taxAmount == geTInvoiceTaxItemType.taxAmount
                && this.taxCode == geTInvoiceTaxItemType.taxCode
                && this.taxCodeDescription == geTInvoiceTaxItemType.taxCodeDescription
                && this.taxDate == geTInvoiceTaxItemType.taxDate
                && this.taxRate == geTInvoiceTaxItemType.taxRate
                && this.taxRateDescription == geTInvoiceTaxItemType.taxRateDescription;
                // && this.taxRateType == geTInvoiceTaxItemType.taxRateType;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (availableToCreditAmount == null ? 0 : System.hashCode(availableToCreditAmount));
        hashCode = (17 * hashCode) + (balance == null ? 0 : System.hashCode(balance));
        hashCode = (17 * hashCode) + (creditAmount == null ? 0 : System.hashCode(creditAmount));
        hashCode = (17 * hashCode) + (exemptAmount == null ? 0 : System.hashCode(exemptAmount));
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
        hashCode = (17 * hashCode) + (jurisdiction == null ? 0 : System.hashCode(jurisdiction));
        hashCode = (17 * hashCode) + (locationCode == null ? 0 : System.hashCode(locationCode));
        hashCode = (17 * hashCode) + (name == null ? 0 : System.hashCode(name));
        hashCode = (17 * hashCode) + (paymentAmount == null ? 0 : System.hashCode(paymentAmount));
        hashCode = (17 * hashCode) + (taxAmount == null ? 0 : System.hashCode(taxAmount));
        hashCode = (17 * hashCode) + (taxCode == null ? 0 : System.hashCode(taxCode));
        hashCode = (17 * hashCode) + (taxCodeDescription == null ? 0 : System.hashCode(taxCodeDescription));
        hashCode = (17 * hashCode) + (taxDate == null ? 0 : System.hashCode(taxDate));
        hashCode = (17 * hashCode) + (taxRate == null ? 0 : System.hashCode(taxRate));
        hashCode = (17 * hashCode) + (taxRateDescription == null ? 0 : System.hashCode(taxRateDescription));
        // hashCode = (17 * hashCode) + (taxRateType == null ? 0 : System.hashCode(taxRateType));
        return hashCode;
    }
}


// --------------------------------------------------- getExamples Methods
public static Amendment Amendment_getExample() {
    Amendment amendment = new Amendment();
    amendment.autoRenew = true;
    amendment.code = 'aeiou';
    amendment.contractEffectiveDate = Date.newInstance(2000, 1, 23);
    amendment.createdById = 'aeiou';
    amendment.createdDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    amendment.currentTerm = 123456789L;
    amendment.currentTermPeriodType = 'aeiou';
    amendment.customerAcceptanceDate = Date.newInstance(2000, 1, 23);
    amendment.description = 'aeiou';
    amendment.destinationAccountId = 'aeiou';
    amendment.destinationInvoiceOwnerId = 'aeiou';
    amendment.effectiveDate = Date.newInstance(2000, 1, 23);
    amendment.name = 'aeiou';
    amendment.ratePlanData = AmendmentRatePlanData_getExample();
    amendment.renewalSetting = 'aeiou';
    amendment.renewalTerm = 123456789L;
    amendment.renewalTermPeriodType = 'aeiou';
    amendment.resumeDate = Date.newInstance(2000, 1, 23);
    amendment.serviceActivationDate = Date.newInstance(2000, 1, 23);
    amendment.specificUpdateDate = Date.newInstance(2000, 1, 23);
    amendment.status = 'aeiou';
    amendment.subscriptionId = 'aeiou';
    amendment.suspendDate = Date.newInstance(2000, 1, 23);
    amendment.termStartDate = Date.newInstance(2000, 1, 23);
    amendment.termType = 'aeiou';
    amendment.r_type = 'aeiou';
    amendment.updatedById = 'aeiou';
    amendment.updatedDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);            
    return amendment;
} 

public static AmendRequest AmendRequest_getExample() {
    AmendRequest amendRequest = new AmendRequest();            
    amendRequest.amendOptions = AmendRequestAmendOptions_getExample();
    amendRequest.amendments = new List<Amendment>{Amendment_getExample()};
    amendRequest.previewOptions = AmendRequestPreviewOptions_getExample();
    return amendRequest;
}

public static AmendRequestPreviewOptions AmendRequestPreviewOptions_getExample() {
    AmendRequestPreviewOptions amendRequestPreviewOptions = new AmendRequestPreviewOptions();
    amendRequestPreviewOptions.enablePreviewMode = true;
    amendRequestPreviewOptions.includeExistingDraftInvoiceItems = true;
    amendRequestPreviewOptions.numberOfPeriods = 123;
    amendRequestPreviewOptions.previewThroughTermEnd = true;
    amendRequestPreviewOptions.previewType = 'aeiou';
    return amendRequestPreviewOptions;
}

public static AmendmentRatePlanData AmendmentRatePlanData_getExample() {
    AmendmentRatePlanData amendmentRatePlanData = new AmendmentRatePlanData();
    amendmentRatePlanData.ratePlan = RatePlan_getExample();
    // amendmentRatePlanData.ratePlanChargeData = new List<RatePlanChargeDataInRatePlanData>{RatePlanChargeDataInRatePlanData_getExample()};
    amendmentRatePlanData.subscriptionProductFeatureList = SubscriptionProductFeatureList_getExample();
    return amendmentRatePlanData;
}


public static RatePlan RatePlan_getExample() {
    RatePlan ratePlan = new RatePlan();
    ratePlan.amendmentId = 'aeiou';
    ratePlan.amendmentSubscriptionRatePlanId = 'aeiou';
    ratePlan.amendmentType = 'aeiou';
    ratePlan.createdById = 'aeiou';
    ratePlan.createdDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    ratePlan.name = 'aeiou';
    ratePlan.productRatePlanId = 'aeiou';
    ratePlan.subscriptionId = 'aeiou';
    ratePlan.updatedById = 'aeiou';
    ratePlan.updatedDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    return ratePlan;
}


public static SubscriptionProductFeatureList SubscriptionProductFeatureList_getExample() {
    SubscriptionProductFeatureList subscriptionProductFeatureList = new SubscriptionProductFeatureList();
    subscriptionProductFeatureList.subscriptionProductFeature = new List<SubscriptionProductFeature>{SubscriptionProductFeature_getExample()};
    return subscriptionProductFeatureList;
}
/*
public static RatePlanChargeDataInRatePlanData RatePlanChargeDataInRatePlanData_getExample() {
    RatePlanChargeDataInRatePlanData ratePlanChargeDataInRatePlanDataRatePlanCharge = new RatePlanChargeDataInRatePlanData();
    ratePlanChargeDataInRatePlanDataRatePlanCharge.accountingCode = 'aeiou';
    ratePlanChargeDataInRatePlanDataRatePlanCharge.applyDiscountTo = 'aeiou';
    ratePlanChargeDataInRatePlanDataRatePlanCharge.billCycleDay = 123;
    ratePlanChargeDataInRatePlanDataRatePlanCharge.billCycleType = 'aeiou';
    ratePlanChargeDataInRatePlanDataRatePlanCharge.billingPeriod = 'aeiou';
    ratePlanChargeDataInRatePlanDataRatePlanCharge.billingPeriodAlignment = 'aeiou';
    ratePlanChargeDataInRatePlanDataRatePlanCharge.billingTiming = 'aeiou';
    ratePlanChargeDataInRatePlanDataRatePlanCharge.chargeModel = 'aeiou';
    ratePlanChargeDataInRatePlanDataRatePlanCharge.chargeNumber = 'aeiou';
    ratePlanChargeDataInRatePlanDataRatePlanCharge.chargeType = 'aeiou';
    ratePlanChargeDataInRatePlanDataRatePlanCharge.chargedThroughDate = Date.newInstance(2000, 1, 23);
    ratePlanChargeDataInRatePlanDataRatePlanCharge.createdById = 'aeiou';
    ratePlanChargeDataInRatePlanDataRatePlanCharge.createdDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    ratePlanChargeDataInRatePlanDataRatePlanCharge.DMRC = 1.3579;
    ratePlanChargeDataInRatePlanDataRatePlanCharge.DTCV = 1.3579;
    ratePlanChargeDataInRatePlanDataRatePlanCharge.description = 'aeiou';
    ratePlanChargeDataInRatePlanDataRatePlanCharge.discountAmount = 1.3579;
    ratePlanChargeDataInRatePlanDataRatePlanCharge.discountLevel = 'aeiou';
    ratePlanChargeDataInRatePlanDataRatePlanCharge.discountPercentage = 1.3579;
    ratePlanChargeDataInRatePlanDataRatePlanCharge.effectiveEndDate = Date.newInstance(2000, 1, 23);
    ratePlanChargeDataInRatePlanDataRatePlanCharge.effectiveStartDate = Date.newInstance(2000, 1, 23);
    ratePlanChargeDataInRatePlanDataRatePlanCharge.endDateCondition = 'aeiou';
    ratePlanChargeDataInRatePlanDataRatePlanCharge.includedUnits = 1.3579;
    ratePlanChargeDataInRatePlanDataRatePlanCharge.isLastSegment = true;
    ratePlanChargeDataInRatePlanDataRatePlanCharge.listPriceBase = 'aeiou';
    ratePlanChargeDataInRatePlanDataRatePlanCharge.MRR = 1.3579;
    ratePlanChargeDataInRatePlanDataRatePlanCharge.name = 'aeiou';
    ratePlanChargeDataInRatePlanDataRatePlanCharge.numberOfPeriods = 123456789L;
    ratePlanChargeDataInRatePlanDataRatePlanCharge.originalId = 'aeiou';
    ratePlanChargeDataInRatePlanDataRatePlanCharge.overageCalculationOption = 'aeiou';
    ratePlanChargeDataInRatePlanDataRatePlanCharge.overagePrice = 1.3579;
    ratePlanChargeDataInRatePlanDataRatePlanCharge.overageUnusedUnitsCreditOption = 'aeiou';
    ratePlanChargeDataInRatePlanDataRatePlanCharge.price = 1.3579;
    ratePlanChargeDataInRatePlanDataRatePlanCharge.priceChangeOption = 'aeiou';
    ratePlanChargeDataInRatePlanDataRatePlanCharge.priceIncreasePercentage = 1.3579;
    ratePlanChargeDataInRatePlanDataRatePlanCharge.processedThroughDate = Date.newInstance(2000, 1, 23);
    ratePlanChargeDataInRatePlanDataRatePlanCharge.productRatePlanChargeId = 'aeiou';
    ratePlanChargeDataInRatePlanDataRatePlanCharge.quantity = 1.3579;
    ratePlanChargeDataInRatePlanDataRatePlanCharge.ratePlanId = 'aeiou';
    ratePlanChargeDataInRatePlanDataRatePlanCharge.revRecCode = 'aeiou';
    ratePlanChargeDataInRatePlanDataRatePlanCharge.revRecTriggerCondition = 'aeiou';
    ratePlanChargeDataInRatePlanDataRatePlanCharge.revenueRecognitionRuleName = 'aeiou';
    ratePlanChargeDataInRatePlanDataRatePlanCharge.rolloverBalance = 1.3579;
    ratePlanChargeDataInRatePlanDataRatePlanCharge.segment = 123;
    ratePlanChargeDataInRatePlanDataRatePlanCharge.specificBillingPeriod = 123456789L;
    ratePlanChargeDataInRatePlanDataRatePlanCharge.specificEndDate = Date.newInstance(2000, 1, 23);
    ratePlanChargeDataInRatePlanDataRatePlanCharge.TCV = 1.3579;
    ratePlanChargeDataInRatePlanDataRatePlanCharge.triggerDate = Date.newInstance(2000, 1, 23);
    ratePlanChargeDataInRatePlanDataRatePlanCharge.triggerEvent = 'aeiou';
    ratePlanChargeDataInRatePlanDataRatePlanCharge.UOM = 'aeiou';
    ratePlanChargeDataInRatePlanDataRatePlanCharge.unusedUnitsCreditRates = 1.3579;
    ratePlanChargeDataInRatePlanDataRatePlanCharge.upToPeriods = 123456789L;
    ratePlanChargeDataInRatePlanDataRatePlanCharge.upToPeriodsType = 'aeiou';
    ratePlanChargeDataInRatePlanDataRatePlanCharge.updatedById = 'aeiou';
    ratePlanChargeDataInRatePlanDataRatePlanCharge.updatedDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    ratePlanChargeDataInRatePlanDataRatePlanCharge.usageRecordRatingOption = 'aeiou';
    ratePlanChargeDataInRatePlanDataRatePlanCharge.useDiscountSpecificAccountingCode = true;
    ratePlanChargeDataInRatePlanDataRatePlanCharge.version = 123456789L;
    ratePlanChargeDataInRatePlanDataRatePlanCharge.weeklyBillCycleDay = 'aeiou';
    return ratePlanChargeDataInRatePlanDataRatePlanCharge;
}
*/
public static AmendRequestAmendOptions AmendRequestAmendOptions_getExample() {
    AmendRequestAmendOptions amendRequestAmendOptions = new AmendRequestAmendOptions();
    amendRequestAmendOptions.applyCreditBalance = true;
    amendRequestAmendOptions.electronicPaymentOptions = ElectronicPaymentOptions_getExample();
    amendRequestAmendOptions.externalPaymentOptions = ExternalPaymentOptions_getExample();
    amendRequestAmendOptions.generateInvoice = true;
    amendRequestAmendOptions.invoiceProcessingOptions = InvoiceProcessingOptions_getExample();
    amendRequestAmendOptions.processPayments = true;
    return amendRequestAmendOptions;
}

public static ElectronicPaymentOptions ElectronicPaymentOptions_getExample() {
    ElectronicPaymentOptions electronicPaymentOptions = new ElectronicPaymentOptions();
    electronicPaymentOptions.paymentMethodId = 'aeiou';
    return electronicPaymentOptions;
}

public static ExternalPaymentOptions ExternalPaymentOptions_getExample() {
    ExternalPaymentOptions externalPaymentOptions = new ExternalPaymentOptions();
    externalPaymentOptions.amount = 1.3579;
    externalPaymentOptions.effectiveDate = Date.newInstance(2000, 1, 23);
    externalPaymentOptions.gatewayOrderId = 'aeiou';
    externalPaymentOptions.paymentMethodId = 'aeiou';
    externalPaymentOptions.referenceId = 'aeiou';
    return externalPaymentOptions;
}

public static InvoiceProcessingOptions InvoiceProcessingOptions_getExample() {
    InvoiceProcessingOptions invoiceProcessingOptions = new InvoiceProcessingOptions();
    invoiceProcessingOptions.invoiceDate = Date.newInstance(2000, 1, 23);
    invoiceProcessingOptions.invoiceTargetDate = Date.newInstance(2000, 1, 23);
    return invoiceProcessingOptions;
}

public static SubscriptionProductFeature SubscriptionProductFeature_getExample() {
    SubscriptionProductFeature subscriptionProductFeature = new SubscriptionProductFeature();
    subscriptionProductFeature.createdById = 'aeiou';
    subscriptionProductFeature.createdDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    subscriptionProductFeature.description = 'aeiou';
    subscriptionProductFeature.featureCode = 'aeiou';
    subscriptionProductFeature.featureId = 'aeiou';
    subscriptionProductFeature.name = 'aeiou';
    subscriptionProductFeature.ratePlanId = 'aeiou';
    subscriptionProductFeature.updatedById = 'aeiou';
    subscriptionProductFeature.updatedDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    return subscriptionProductFeature;
}

    public static ChargeMetricsData ChargeMetricsData_getExample() {
        ChargeMetricsData chargeMetricsData = new ChargeMetricsData();
        chargeMetricsData.chargeMetrics = new List<NewChargeMetrics>{NewChargeMetrics_getExample()};
        return chargeMetricsData;
    }

    public static NewChargeMetrics NewChargeMetrics_getExample() {
        NewChargeMetrics newChargeMetrics = new NewChargeMetrics();
        newChargeMetrics.chargeNumber = 'aeiou';
        newChargeMetrics.DMRR = 1.3579;
        newChargeMetrics.DTCV = 1.3579;
        newChargeMetrics.MRR = 1.3579;
        newChargeMetrics.originalId = 'aeiou';
        newChargeMetrics.originalRatePlanId = 'aeiou';
        newChargeMetrics.productRatePlanChargeId = 'aeiou';
        newChargeMetrics.productRatePlanId = 'aeiou';
        newChargeMetrics.TCV = 1.3579;
        return newChargeMetrics;
    }

    public static ActionsErrorResponse ActionsErrorResponse_getExample() {
        ActionsErrorResponse actionsErrorResponse = new ActionsErrorResponse();
        actionsErrorResponse.code = 'aeiou';
        actionsErrorResponse.message = 'aeiou';
        return actionsErrorResponse;
    }

    public static AmendResult AmendResult_getExample() {
        AmendResult amendResult = new AmendResult();
        amendResult.amendmentIds = new List<String>{'aeiou'};
        amendResult.chargeMetricsData = ChargeMetricsData_getExample();
        amendResult.errors = new List<ActionsErrorResponse>{ActionsErrorResponse_getExample()};
        amendResult.gatewayResponse = 'aeiou';
        amendResult.gatewayResponseCode = 'aeiou';
        amendResult.invoiceDatas = new List<InvoiceData>{InvoiceData_getExample()};
        amendResult.invoiceId = 'aeiou';
        amendResult.paymentId = 'aeiou';
        amendResult.paymentTransactionNumber = 'aeiou';
        amendResult.subscriptionId = 'aeiou';
        amendResult.success = true;
        amendResult.totalDeltaMrr = 1.3579;
        amendResult.totalDeltaTcv = 1.3579;
        return amendResult;
    }

    public static InvoiceData InvoiceData_getExample() {
        InvoiceData invoiceData = new InvoiceData();
        invoiceData.invoice = InvoiceDataInvoice_getExample();
        invoiceData.invoiceItem = new List<InvoiceItem>{InvoiceItem_getExample()};
        return invoiceData;
    }

    public static InvoiceDataInvoice InvoiceDataInvoice_getExample() {
        InvoiceDataInvoice invoiceDataInvoice = new InvoiceDataInvoice();
        invoiceDataInvoice.integrationIdNS = 'aeiou';
        invoiceDataInvoice.integrationStatusNS = 'aeiou';
        invoiceDataInvoice.syncDateNS = 'aeiou';
        invoiceDataInvoice.accountId = 'aeiou';
        invoiceDataInvoice.adjustmentAmount = 1.3579;
        invoiceDataInvoice.amount = 1.3579;
        invoiceDataInvoice.amountWithoutTax = 1.3579;
        invoiceDataInvoice.balance = 1.3579;
        invoiceDataInvoice.billRunId = 'aeiou';
        invoiceDataInvoice.body = 'aeiou';
        invoiceDataInvoice.comments = 'aeiou';
        invoiceDataInvoice.createdById = 'aeiou';
        invoiceDataInvoice.createdDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
        invoiceDataInvoice.creditBalanceAdjustmentAmount = 1.3579;
        invoiceDataInvoice.dueDate = Date.newInstance(2000, 1, 23);
        invoiceDataInvoice.includesOneTime = true;
        invoiceDataInvoice.includesRecurring = true;
        invoiceDataInvoice.includesUsage = true;
        invoiceDataInvoice.invoiceDate = Date.newInstance(2000, 1, 23);
        invoiceDataInvoice.invoiceNumber = 'aeiou';
        invoiceDataInvoice.lastEmailSentDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
        invoiceDataInvoice.paymentAmount = 1.3579;
        invoiceDataInvoice.postedBy = 'aeiou';
        invoiceDataInvoice.postedDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
        invoiceDataInvoice.refundAmount = 1.3579;
        invoiceDataInvoice.regenerateInvoicePDF = true;
        invoiceDataInvoice.status = 'aeiou';
        invoiceDataInvoice.targetDate = Date.newInstance(2000, 1, 23);
        invoiceDataInvoice.taxAmount = 1.3579;
        invoiceDataInvoice.taxExemptAmount = 1.3579;
        invoiceDataInvoice.transferredToAccounting = 'aeiou';
        invoiceDataInvoice.updatedById = 'aeiou';
        invoiceDataInvoice.updatedDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
        return invoiceDataInvoice;
    }

    public static InvoiceItem InvoiceItem_getExample() {
        InvoiceItem invoiceItem = new InvoiceItem();
        invoiceItem.integrationIdNS = 'aeiou';
        invoiceItem.integrationStatusNS = 'aeiou';
        invoiceItem.syncDateNS = 'aeiou';
        invoiceItem.appliedToItemId = 'aeiou';
        invoiceItem.availableToCreditAmount = 1.3579;
        invoiceItem.balance = 'aeiou';
        invoiceItem.chargeAmount = 'aeiou';
        invoiceItem.chargeDescription = 'aeiou';
        invoiceItem.chargeId = 'aeiou';
        invoiceItem.chargeName = 'aeiou';
        invoiceItem.id = 'aeiou';
        invoiceItem.productName = 'aeiou';
        invoiceItem.quantity = 'aeiou';
        invoiceItem.serviceEndDate = Date.newInstance(2000, 1, 23);
        invoiceItem.serviceStartDate = Date.newInstance(2000, 1, 23);
        invoiceItem.subscriptionId = 'aeiou';
        invoiceItem.subscriptionName = 'aeiou';
        invoiceItem.success = true;
        invoiceItem.taxAmount = 'aeiou';
        invoiceItem.taxationItems = InvoiceItemTaxationItems_getExample();
        invoiceItem.unitOfMeasure = 'aeiou';
        return invoiceItem;
    }

    public static InvoiceItemTaxationItems InvoiceItemTaxationItems_getExample() {
        InvoiceItemTaxationItems invoiceItemTaxationItems = new InvoiceItemTaxationItems();
        invoiceItemTaxationItems.data = new List<GETInvoiceTaxItemType>{GETInvoiceTaxItemType_getExample()};
        invoiceItemTaxationItems.nextPage = 'aeiou';
        return invoiceItemTaxationItems;
    }

    public static GETInvoiceTaxItemType GETInvoiceTaxItemType_getExample() {
        GETInvoiceTaxItemType geTInvoiceTaxItemType = new GETInvoiceTaxItemType();
        geTInvoiceTaxItemType.availableToCreditAmount = 1.3579;
        geTInvoiceTaxItemType.balance = 1.3579;
        geTInvoiceTaxItemType.creditAmount = 1.3579;
        geTInvoiceTaxItemType.exemptAmount = 1.3579;
        geTInvoiceTaxItemType.id = 'aeiou';
        geTInvoiceTaxItemType.jurisdiction = 'aeiou';
        geTInvoiceTaxItemType.locationCode = 'aeiou';
        geTInvoiceTaxItemType.name = 'aeiou';
        geTInvoiceTaxItemType.paymentAmount = 1.3579;
        geTInvoiceTaxItemType.taxAmount = 1.3579;
        geTInvoiceTaxItemType.taxCode = 'aeiou';
        geTInvoiceTaxItemType.taxCodeDescription = 'aeiou';
        geTInvoiceTaxItemType.taxDate = Date.newInstance(2000, 1, 23);
        geTInvoiceTaxItemType.taxRate = 1.3579;
        geTInvoiceTaxItemType.taxRateDescription = 'aeiou';
        // geTInvoiceTaxItemType.taxRateType = TaxRateTypeEnum.PERCENTAGE;
        return geTInvoiceTaxItemType;
    }


public static void test1(){
    ZUC.AmendRequest c1 = new ZUC.AmendRequest();
    c1.amendOptions.generateInvoice=false;
    c1.amendOptions.processPayments=false;
    c1.amendOptions.invoiceProcessingOptions.invoiceDate=null; // Date.newInstance(2000, 1, 23);
    c1.amendOptions.invoiceProcessingOptions.invoiceTargetDate=null;
    Amendment amend1 = new Amendment();
    c1.amendments.add(amend1);
    c1.amendments[0].contractEffectiveDate=Date.newInstance(2019, 09, 07);
    c1.amendments[0].description='Ajout charge reactivation';
    c1.amendments[0].name='Ajout charge reactivation';
    c1.amendments[0].status='Completed';
    c1.amendments[0].subscriptionId='';
    c1.amendments[0].r_type='NewProduct';
    c1.amendments[0].ratePlanData.ratePlan.productRatePlanId='';
    c1.previewOptions.enablePreviewMode=false;
}



} // END Class