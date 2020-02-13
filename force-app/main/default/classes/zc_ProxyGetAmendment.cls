/**
 * zc_ProxyGetAmendment
 */
public class zc_ProxyGetAmendment {
    /**
     *  Determines whether the subscription is automatically renewed, or whether it expires at the end of the term and needs to be manually renewed. **Required:** For amendment of type TermsAndConditions when changing the automatic renewal status of a subscription.\n**Values**: true, false 
     * @return autoRenew
     */
    public Boolean autoRenew { get; set; }

    /**
     *  A unique alphanumeric string that identifies the amendment.\n**Character limit**: 50 **Values**: one of the following:\n\n- `null` generates a value automatically\n- A string\n
     * @return code
     */
    public String code { get; set; }

    /**
     *  The date when the amendment\'s changes become effective for billing purposes.\n**Version notes**: -- 
     * @return contractEffectiveDate
     */
    public Date contractEffectiveDate { get; set; }

    /**
     *  The user ID of the person who created the amendment.\n**Character limit**: 32 **Values**: automatically generated 
     * @return createdById
     */
    public String createdById { get; set; }

    /**
     *  The date when the amendment was created.\n**Values**: automatically generated 
     * @return createdDate
     */
    public Datetime createdDate { get; set; }

    /**
     *  The length of the period for the current subscription term. This field can be updated when Status is `Draft`.\n**Required**: Only if the value of the Type field is set to `TermsAndConditions` and TermType is set to `TERMED`. This field is not required if TermType is set to `EVERGREEN`.\n**Character limit**: **Values**: a valid number 
     * @return currentTerm
     */
    public Long currentTerm { get; set; }

    /**
     *  The period type for the current subscription term. **Values**:\n\n- `Month` (default)\n- `Year`\n- `Day`\n- `Week`\n**Note**:\n\n- This field can be updated when Status is `Draft`.\n- This field is used with the CurrentTerm field to specify the current subscription term.\n
     * @return currentTermPeriodType
     */
    public String currentTermPeriodType { get; set; }

    /**
     * The date when the customer accepts the amendment\'s changes to the subscription.\n\nThis field is only required if [Zuora is configured to require customer acceptance in Z-Billing](https://knowledgecenter.zuora.com/CB_Billing/W_Billing_and_Payments_Settings/Define_Default_Subscription_Settings) and the subscription is currently in the Pending Acceptance status (the value of the `Status` field is currently `PendingAcceptance`).\n
     * @return customerAcceptanceDate
     */
    public Date customerAcceptanceDate { get; set; }

    /**
     *  A description of the amendment.\n**Character limit**: 500 **Values**: maximum 500 characters 
     * @return description
     */
    public String description { get; set; }

    /**
     *  The date when the amendment\'s changes take effective. This field validates that the amendment\'s changes are within valid ranges of products and product rate plans.\n**Required**: For the cancellation amendments. Optional for other types of amendments.\n**Version notes**: -- 
     * @return effectiveDate
     */
    public Date effectiveDate { get; set; }

    /**
     * Object identifier.
     * @return id
     */
    public String id { get; set; }

    /**
     *  The name of the amendment.\n**Character limit**: 100 **Values**: a string of 100 characters or fewer 
     * @return name
     */
    public String name { get; set; }

    /**
     *  Specifies whether a termed subscription will remain termed or change to evergreen when it is renewed.\n**Required**: If TermType is Termed **Values**: RENEW_WITH_SPECIFIC_TERM (default), RENEW_TO_EVERGREEN 
     * @return renewalSetting
     */
    public String renewalSetting { get; set; }

    /**
     *  The term of renewal for the amended subscription. This field can be updated when Status is `Draft`.\n**Required**: Only if the value of the Type field is set to `TermsAndConditions`.\n**Character limit**: **Values:** a valid number 
     * @return renewalTerm
     */
    public Long renewalTerm { get; set; }

    /**
     *  The period type for the subscription renewal term. This field can be updated when Status is `Draft`.\n**Required**: Only if the value of the Type field is set to `TermsAndConditions`. This field is used with the RenewalTerm field to specify the subscription renewal term.\n**Values**:\n\n- `Month` (default)\n- `Year`\n- `Day`\n- `Week`\n
     * @return renewalTermPeriodType
     */
    public String renewalTermPeriodType { get; set; }

    /**
     * The date when service is activated.\n\nThis field is only required if [Zuora is configured to require service activation in Z-Billing](https://knowledgecenter.zuora.com/CB_Billing/W_Billing_and_Payments_Settings/Define_Default_Subscription_Settings) and the subscription is currently in the Pending Activation status (the value of the `Status` field is currently `PendingActivation`).\n
     * @return serviceActivationDate
     */
    public Date serviceActivationDate { get; set; }

    /**
     *  The date when the UpdateProduct amendment takes effect. This field is only applicable if there is already a future-dated UpdateProduct amendment on the subscription.\n**Required**: Only for the UpdateProduct amendments if there is already a future-dated UpdateProduct amendment on the subscription.\n**Version notes**: -- 
     * @return specificUpdateDate
     */
    public Date specificUpdateDate { get; set; }

    /**
     *  The status of the amendment. Type: string (enum) **Character limit**: 17 **Values**: one of the following:\n\n- Draft (default, if left null)\n- Pending Activation\n- Pending Acceptance\n- Completed\n
     * @return status
     */
    public String status { get; set; }

    /**
     *  The ID of the subscription that the amendment changes.\n**Character limit**: 32 **Values**: a valid subscription ID 
     * @return subscriptionId
     */
    public String subscriptionId { get; set; }

    /**
     *  The date when the new terms and conditions take effect.\n\n\n**Version notes**: -- 
     * @return termStartDate
     */
    public Date termStartDate { get; set; }

    /**
     *  Indicates if the subscription isTERMED or EVERGREEN.\n\n- A TERMED subscription has an expiration date, and must be manually renewed.\n- An EVERGREEN subscription doesn\'t have an expiration date, and must be manually ended.\n\n**Required**: Only when as part of an amendment of type TermsAndConditions &#65279;to change the term type of a subscription. Type: string **Character limit**: 9 **Values**: TERMED, EVERGREEN 
     * @return termType
     */
    public String termType { get; set; }

    /**
     *  The type of amendment.\n**Character limit**: 18 **Values**: one of the following:\n\n- Cancellation\n- NewProduct\n- OwnerTransfer\n- RemoveProduct\n- Renewal\n- UpdateProduct\n- TermsAndConditions\n- SuspendSubscription (This value is in **Limited Availability**.)\n- ResumeSubscription (This value is in **Limited Availability**.)\n
     * @return r_type
     */
    public String r_type { get; set; }

    /**
     *  The ID of the user who last updated the amendment.\n**Character limit**: 32 **Values**: automatically generated 
     * @return updatedById
     */
    public String updatedById { get; set; }

    /**
     *  The date when the amendment was last updated.\n**Values**: automatically generated 
     * @return updatedDate
     */
    public Datetime updatedDate { get; set; }

    public String operation { get; set; }

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
        'EffectiveDate' => 'effectiveDate',
        'Id' => 'id',
        'Name' => 'name',
        'RenewalSetting' => 'renewalSetting',
        'RenewalTerm' => 'renewalTerm',
        'RenewalTermPeriodType' => 'renewalTermPeriodType',
        'ServiceActivationDate' => 'serviceActivationDate',
        'SpecificUpdateDate' => 'specificUpdateDate',
        'Status' => 'status',
        'SubscriptionId' => 'subscriptionId',
        'TermStartDate' => 'termStartDate',
        'TermType' => 'termType',
        'Type' => 'r_type',
        'UpdatedById' => 'updatedById',
        'UpdatedDate' => 'updatedDate',
        'Operation__c' => 'operation'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    // public static zc_ProxyGetAmendment getExample() {
    //     zc_ProxyGetAmendment proxyGetAmendment = new zc_ProxyGetAmendment();
    //     proxyGetAmendment.autoRenew = true;
    //     proxyGetAmendment.code = 'aeiou';
    //     proxyGetAmendment.contractEffectiveDate = Date.newInstance(2000, 1, 23);
    //     proxyGetAmendment.createdById = 'aeiou';
    //     proxyGetAmendment.createdDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    //     proxyGetAmendment.currentTerm = 123456789L;
    //     proxyGetAmendment.currentTermPeriodType = 'aeiou';
    //     proxyGetAmendment.customerAcceptanceDate = Date.newInstance(2000, 1, 23);
    //     proxyGetAmendment.description = 'aeiou';
    //     proxyGetAmendment.effectiveDate = Date.newInstance(2000, 1, 23);
    //     proxyGetAmendment.id = 'aeiou';
    //     proxyGetAmendment.name = 'aeiou';
    //     proxyGetAmendment.renewalSetting = 'aeiou';
    //     proxyGetAmendment.renewalTerm = 123456789L;
    //     proxyGetAmendment.renewalTermPeriodType = 'aeiou';
    //     proxyGetAmendment.serviceActivationDate = Date.newInstance(2000, 1, 23);
    //     proxyGetAmendment.specificUpdateDate = Date.newInstance(2000, 1, 23);
    //     proxyGetAmendment.status = 'aeiou';
    //     proxyGetAmendment.subscriptionId = 'aeiou';
    //     proxyGetAmendment.termStartDate = Date.newInstance(2000, 1, 23);
    //     proxyGetAmendment.termType = 'aeiou';
    //     proxyGetAmendment.r_type = 'aeiou';
    //     proxyGetAmendment.updatedById = 'aeiou';
    //     proxyGetAmendment.updatedDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    //     return proxyGetAmendment;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_ProxyGetAmendment) {
            zc_ProxyGetAmendment proxyGetAmendment = (zc_ProxyGetAmendment) obj;
            return this.autoRenew == proxyGetAmendment.autoRenew
                && this.code == proxyGetAmendment.code
                && this.contractEffectiveDate == proxyGetAmendment.contractEffectiveDate
                && this.createdById == proxyGetAmendment.createdById
                && this.createdDate == proxyGetAmendment.createdDate
                && this.currentTerm == proxyGetAmendment.currentTerm
                && this.currentTermPeriodType == proxyGetAmendment.currentTermPeriodType
                && this.customerAcceptanceDate == proxyGetAmendment.customerAcceptanceDate
                && this.description == proxyGetAmendment.description
                && this.effectiveDate == proxyGetAmendment.effectiveDate
                && this.id == proxyGetAmendment.id
                && this.name == proxyGetAmendment.name
                && this.renewalSetting == proxyGetAmendment.renewalSetting
                && this.renewalTerm == proxyGetAmendment.renewalTerm
                && this.renewalTermPeriodType == proxyGetAmendment.renewalTermPeriodType
                && this.serviceActivationDate == proxyGetAmendment.serviceActivationDate
                && this.specificUpdateDate == proxyGetAmendment.specificUpdateDate
                && this.status == proxyGetAmendment.status
                && this.subscriptionId == proxyGetAmendment.subscriptionId
                && this.termStartDate == proxyGetAmendment.termStartDate
                && this.termType == proxyGetAmendment.termType
                && this.r_type == proxyGetAmendment.r_type
                && this.updatedById == proxyGetAmendment.updatedById
                && this.updatedDate == proxyGetAmendment.updatedDate;
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
        hashCode = (17 * hashCode) + (effectiveDate == null ? 0 : System.hashCode(effectiveDate));
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
        hashCode = (17 * hashCode) + (name == null ? 0 : System.hashCode(name));
        hashCode = (17 * hashCode) + (renewalSetting == null ? 0 : System.hashCode(renewalSetting));
        hashCode = (17 * hashCode) + (renewalTerm == null ? 0 : System.hashCode(renewalTerm));
        hashCode = (17 * hashCode) + (renewalTermPeriodType == null ? 0 : System.hashCode(renewalTermPeriodType));
        hashCode = (17 * hashCode) + (serviceActivationDate == null ? 0 : System.hashCode(serviceActivationDate));
        hashCode = (17 * hashCode) + (specificUpdateDate == null ? 0 : System.hashCode(specificUpdateDate));
        hashCode = (17 * hashCode) + (status == null ? 0 : System.hashCode(status));
        hashCode = (17 * hashCode) + (subscriptionId == null ? 0 : System.hashCode(subscriptionId));
        hashCode = (17 * hashCode) + (termStartDate == null ? 0 : System.hashCode(termStartDate));
        hashCode = (17 * hashCode) + (termType == null ? 0 : System.hashCode(termType));
        hashCode = (17 * hashCode) + (r_type == null ? 0 : System.hashCode(r_type));
        hashCode = (17 * hashCode) + (updatedById == null ? 0 : System.hashCode(updatedById));
        hashCode = (17 * hashCode) + (updatedDate == null ? 0 : System.hashCode(updatedDate));
        return hashCode;
    }
}