public class zc_Amendment implements zc_Zuc.MappedProperties {
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
    public zc_AmendmentRatePlanData ratePlanData { get; set; }

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

    // public static zc_Amendment getExample() {
    //     zc_Amendment amendment = new zc_Amendment();
    //     amendment.autoRenew = true;
    //     amendment.code = 'aeiou';
    //     amendment.contractEffectiveDate = Date.newInstance(2000, 1, 23);
    //     amendment.createdById = 'aeiou';
    //     amendment.createdDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    //     amendment.currentTerm = 123456789L;
    //     amendment.currentTermPeriodType = 'aeiou';
    //     amendment.customerAcceptanceDate = Date.newInstance(2000, 1, 23);
    //     amendment.description = 'aeiou';
    //     amendment.destinationAccountId = 'aeiou';
    //     amendment.destinationInvoiceOwnerId = 'aeiou';
    //     amendment.effectiveDate = Date.newInstance(2000, 1, 23);
    //     amendment.name = 'aeiou';
    //     amendment.ratePlanData = zc_AmendmentRatePlanData.getExample();
    //     amendment.renewalSetting = 'aeiou';
    //     amendment.renewalTerm = 123456789L;
    //     amendment.renewalTermPeriodType = 'aeiou';
    //     amendment.resumeDate = Date.newInstance(2000, 1, 23);
    //     amendment.serviceActivationDate = Date.newInstance(2000, 1, 23);
    //     amendment.specificUpdateDate = Date.newInstance(2000, 1, 23);
    //     amendment.status = 'aeiou';
    //     amendment.subscriptionId = 'aeiou';
    //     amendment.suspendDate = Date.newInstance(2000, 1, 23);
    //     amendment.termStartDate = Date.newInstance(2000, 1, 23);
    //     amendment.termType = 'aeiou';
    //     amendment.r_type = 'aeiou';
    //     amendment.updatedById = 'aeiou';
    //     amendment.updatedDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    //     return amendment;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_Amendment) {
            zc_Amendment amendment = (zc_Amendment) obj;
            return this.autoRenew == amendment.autoRenew
                && this.code == amendment.code
                && this.contractEffectiveDate == amendment.contractEffectiveDate
                && this.createdById == amendment.createdById
                && this.createdDate == amendment.createdDate
                && this.currentTerm == amendment.currentTerm
                && this.currentTermPeriodType == amendment.currentTermPeriodType
                && this.customerAcceptanceDate == amendment.customerAcceptanceDate
                && this.description == amendment.description
                && this.destinationAccountId == amendment.destinationAccountId
                && this.destinationInvoiceOwnerId == amendment.destinationInvoiceOwnerId
                && this.effectiveDate == amendment.effectiveDate
                && this.name == amendment.name
                && this.ratePlanData == amendment.ratePlanData
                && this.renewalSetting == amendment.renewalSetting
                && this.renewalTerm == amendment.renewalTerm
                && this.renewalTermPeriodType == amendment.renewalTermPeriodType
                && this.resumeDate == amendment.resumeDate
                && this.serviceActivationDate == amendment.serviceActivationDate
                && this.specificUpdateDate == amendment.specificUpdateDate
                && this.status == amendment.status
                && this.subscriptionId == amendment.subscriptionId
                && this.suspendDate == amendment.suspendDate
                && this.termStartDate == amendment.termStartDate
                && this.termType == amendment.termType
                && this.r_type == amendment.r_type
                && this.updatedById == amendment.updatedById
                && this.updatedDate == amendment.updatedDate;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (autoRenew == null ? 0 : System.hashCode(autoRenew));
        hashCode = (17 * hashCode) + (code == null ? 0 : System.hashCode(code));
        hashCode = (17 * hashCode) + (contractEffectiveDate == null ? 0 : System.hashCode(contractEffectiveDate));
        hashCode = (17 * hashCode) + (createdById == null ? 0 : System.hashCode(createdById));
        hashCode = (17 * hashCode) + (createdDate == null ? 0 : System.hashCode(createdDate));
        hashCode = (17 * hashCode) + (currentTerm == null ? 0 : System.hashCode(currentTerm));
        hashCode = (17 * hashCode) + (currentTermPeriodType == null ? 0 : System.hashCode(currentTermPeriodType));
        hashCode = (17 * hashCode) + (customerAcceptanceDate == null ? 0 : System.hashCode(customerAcceptanceDate));
        hashCode = (17 * hashCode) + (description == null ? 0 : System.hashCode(description));
        hashCode = (17 * hashCode) + (destinationAccountId == null ? 0 : System.hashCode(destinationAccountId));
        hashCode = (17 * hashCode) + (destinationInvoiceOwnerId == null ? 0 : System.hashCode(destinationInvoiceOwnerId));
        hashCode = (17 * hashCode) + (effectiveDate == null ? 0 : System.hashCode(effectiveDate));
        hashCode = (17 * hashCode) + (name == null ? 0 : System.hashCode(name));
        hashCode = (17 * hashCode) + (ratePlanData == null ? 0 : System.hashCode(ratePlanData));
        hashCode = (17 * hashCode) + (renewalSetting == null ? 0 : System.hashCode(renewalSetting));
        hashCode = (17 * hashCode) + (renewalTerm == null ? 0 : System.hashCode(renewalTerm));
        hashCode = (17 * hashCode) + (renewalTermPeriodType == null ? 0 : System.hashCode(renewalTermPeriodType));
        hashCode = (17 * hashCode) + (resumeDate == null ? 0 : System.hashCode(resumeDate));
        hashCode = (17 * hashCode) + (serviceActivationDate == null ? 0 : System.hashCode(serviceActivationDate));
        hashCode = (17 * hashCode) + (specificUpdateDate == null ? 0 : System.hashCode(specificUpdateDate));
        hashCode = (17 * hashCode) + (status == null ? 0 : System.hashCode(status));
        hashCode = (17 * hashCode) + (subscriptionId == null ? 0 : System.hashCode(subscriptionId));
        hashCode = (17 * hashCode) + (suspendDate == null ? 0 : System.hashCode(suspendDate));
        hashCode = (17 * hashCode) + (termStartDate == null ? 0 : System.hashCode(termStartDate));
        hashCode = (17 * hashCode) + (termType == null ? 0 : System.hashCode(termType));
        hashCode = (17 * hashCode) + (r_type == null ? 0 : System.hashCode(r_type));
        hashCode = (17 * hashCode) + (updatedById == null ? 0 : System.hashCode(updatedById));
        hashCode = (17 * hashCode) + (updatedDate == null ? 0 : System.hashCode(updatedDate));
        return hashCode;
    }
}