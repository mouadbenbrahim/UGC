/**
 * zc_GETAmendmentType
 */
public class zc_GETAmendmentType {
    /**
     * Determines whether the subscription is automatically renewed, or whether it expires at the end of the term and needs to be manually renewed. \n
     * @return autoRenew
     */
    public Boolean autoRenew { get; set; }

    /**
     * The rate plan ID on which changes are made. Only the Update or Remove amendment returns a base rate plan ID.\n
     * @return baseRatePlanId
     */
    public String baseRatePlanId { get; set; }

    /**
     * The ID of the subscription based on which the amendment is created.\n
     * @return baseSubscriptionId
     */
    public String baseSubscriptionId { get; set; }

    /**
     * The amendment code.\n
     * @return code
     */
    public String code { get; set; }

    /**
     * The date when the amendment becomes effective for billing purposes, as `yyyy-mm-dd`.\n
     * @return contractEffectiveDate
     */
    public Date contractEffectiveDate { get; set; }

    /**
     * The length of the period for the current subscription term. \n
     * @return currentTerm
     */
    public Long currentTerm { get; set; }

    /**
     * The period type for the current subscription term.\nPossible values are:\n\n- Month\n- Year\n- Day\n- Week\n
     * @return currentTermPeriodType
     */
    public String currentTermPeriodType { get; set; }

    /**
     * The date when the customer accepts the amendment changes to the subscription, as `yyyy-mm-dd`.\n
     * @return customerAcceptanceDate
     */
    public Date customerAcceptanceDate { get; set; }

    /**
     * Description of the amendment.\n
     * @return description
     */
    public String description { get; set; }

    /**
     * The ID of the account that the subscription is being transferred to.\n
     * @return destinationAccountId
     */
    public String destinationAccountId { get; set; }

    /**
     * The ID of the invoice that the subscription is being transferred to.\n
     * @return destinationInvoiceOwnerId
     */
    public String destinationInvoiceOwnerId { get; set; }

    /**
     * The date when the amendment changes take effective. \n
     * @return effectiveDate
     */
    public Date effectiveDate { get; set; }

    /**
     * The amendment ID.\n
     * @return id
     */
    public String id { get; set; }

    /**
     * The name of the amendment.\n
     * @return name
     */
    public String name { get; set; }

    /**
     * The ID of the rate plan charge on which amendment is made. Only the Add or Update amendment returns a new rate plan ID.\n
     * @return newRatePlanId
     */
    public String newRatePlanId { get; set; }

    /**
     * The ID of the subscription that the amendment changes.\n
     * @return newSubscriptionId
     */
    public String newSubscriptionId { get; set; }

    /**
     * Specifies whether a termed subscription will remain termed or change to evergreen when it is renewed.\nPossible values are:\n\n- RENEW_WITH_SPECIFIC_TERM\n- RENEW_TO_EVERGREEN\n
     * @return renewalSetting
     */
    public String renewalSetting { get; set; }

    /**
     * The term of renewal for the amended subscription.\n
     * @return renewalTerm
     */
    public Long renewalTerm { get; set; }

    /**
     * The period type for the subscription renewal term.\nPossible values are:\n\n- Month\n- Year\n- Day\n- Week\n
     * @return renewalTermPeriodType
     */
    public String renewalTermPeriodType { get; set; }

    /**
     * The date when the subscription resumption takes effect, as `yyyy-mm-dd`.\n\n**Note:** This feature is in **Limited Availability**. If you wish to have access to the feature, submit a request at [Zuora Global Support](http://support.zuora.com/).\n
     * @return resumeDate
     */
    public Date resumeDate { get; set; }

    /**
     * The date when service is activated, as `yyyy-mm-dd`.\n
     * @return serviceActivationDate
     */
    public Date serviceActivationDate { get; set; }

    /**
     * The date when the Update Product amendment takes effect. \nOnly for the Update Product amendments if there is already a future-dated Update Product amendment on\nthe subscription.\n
     * @return specificUpdateDate
     */
    public Date specificUpdateDate { get; set; }

    /**
     * The status of the amendment.\nPossible values are:\n\n- Draft \n- Pending Activation\n- Pending Acceptance\n- Completed\n
     * @return status
     */
    public String status { get; set; }

    /**
     * Returns `true` if the request was processed successfully.\n
     * @return success
     */
    public Boolean success { get; set; }

    /**
     * The date when the subscription suspension takes effect, as `yyyy-mm-dd`.\n\n**Note:** This feature is in **Limited Availability**. If you wish to have access to the feature, submit a request at [Zuora Global Support](http://support.zuora.com/).\n
     * @return suspendDate
     */
    public Date suspendDate { get; set; }

    /**
     * The date when the new terms and conditions take effect.\n
     * @return termStartDate
     */
    public Date termStartDate { get; set; }

    /**
     * Indicates if the subscription is `TERMED` or `EVERGREEN`.\n
     * @return termType
     */
    public String termType { get; set; }

    /**
     * Type of the amendment.\nPossible values are:\n\n- Cancellation\n- NewProduct\n- OwnerTransfer\n- RemoveProduct\n- Renewal\n- UpdateProduct\n- TermsAndConditions\n
     * @return r_type
     */
    public String r_type { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'type' => 'r_type'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    // public static zc_GETAmendmentType getExample() {
    //     zc_GETAmendmentType geTAmendmentType = new zc_GETAmendmentType();
    //     geTAmendmentType.autoRenew = true;
    //     geTAmendmentType.baseRatePlanId = 'aeiou';
    //     geTAmendmentType.baseSubscriptionId = 'aeiou';
    //     geTAmendmentType.code = 'aeiou';
    //     geTAmendmentType.contractEffectiveDate = Date.newInstance(2000, 1, 23);
    //     geTAmendmentType.currentTerm = 123456789L;
    //     geTAmendmentType.currentTermPeriodType = 'aeiou';
    //     geTAmendmentType.customerAcceptanceDate = Date.newInstance(2000, 1, 23);
    //     geTAmendmentType.description = 'aeiou';
    //     geTAmendmentType.destinationAccountId = 'aeiou';
    //     geTAmendmentType.destinationInvoiceOwnerId = 'aeiou';
    //     geTAmendmentType.effectiveDate = Date.newInstance(2000, 1, 23);
    //     geTAmendmentType.id = 'aeiou';
    //     geTAmendmentType.name = 'aeiou';
    //     geTAmendmentType.newRatePlanId = 'aeiou';
    //     geTAmendmentType.newSubscriptionId = 'aeiou';
    //     geTAmendmentType.renewalSetting = 'aeiou';
    //     geTAmendmentType.renewalTerm = 123456789L;
    //     geTAmendmentType.renewalTermPeriodType = 'aeiou';
    //     geTAmendmentType.resumeDate = Date.newInstance(2000, 1, 23);
    //     geTAmendmentType.serviceActivationDate = Date.newInstance(2000, 1, 23);
    //     geTAmendmentType.specificUpdateDate = Date.newInstance(2000, 1, 23);
    //     geTAmendmentType.status = 'aeiou';
    //     geTAmendmentType.success = true;
    //     geTAmendmentType.suspendDate = Date.newInstance(2000, 1, 23);
    //     geTAmendmentType.termStartDate = Date.newInstance(2000, 1, 23);
    //     geTAmendmentType.termType = 'aeiou';
    //     geTAmendmentType.r_type = 'aeiou';
    //     return geTAmendmentType;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_GETAmendmentType) {
            zc_GETAmendmentType geTAmendmentType = (zc_GETAmendmentType) obj;
            return this.autoRenew == geTAmendmentType.autoRenew
                && this.baseRatePlanId == geTAmendmentType.baseRatePlanId
                && this.baseSubscriptionId == geTAmendmentType.baseSubscriptionId
                && this.code == geTAmendmentType.code
                && this.contractEffectiveDate == geTAmendmentType.contractEffectiveDate
                && this.currentTerm == geTAmendmentType.currentTerm
                && this.currentTermPeriodType == geTAmendmentType.currentTermPeriodType
                && this.customerAcceptanceDate == geTAmendmentType.customerAcceptanceDate
                && this.description == geTAmendmentType.description
                && this.destinationAccountId == geTAmendmentType.destinationAccountId
                && this.destinationInvoiceOwnerId == geTAmendmentType.destinationInvoiceOwnerId
                && this.effectiveDate == geTAmendmentType.effectiveDate
                && this.id == geTAmendmentType.id
                && this.name == geTAmendmentType.name
                && this.newRatePlanId == geTAmendmentType.newRatePlanId
                && this.newSubscriptionId == geTAmendmentType.newSubscriptionId
                && this.renewalSetting == geTAmendmentType.renewalSetting
                && this.renewalTerm == geTAmendmentType.renewalTerm
                && this.renewalTermPeriodType == geTAmendmentType.renewalTermPeriodType
                && this.resumeDate == geTAmendmentType.resumeDate
                && this.serviceActivationDate == geTAmendmentType.serviceActivationDate
                && this.specificUpdateDate == geTAmendmentType.specificUpdateDate
                && this.status == geTAmendmentType.status
                && this.success == geTAmendmentType.success
                && this.suspendDate == geTAmendmentType.suspendDate
                && this.termStartDate == geTAmendmentType.termStartDate
                && this.termType == geTAmendmentType.termType
                && this.r_type == geTAmendmentType.r_type;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (autoRenew == null ? 0 : System.hashCode(autoRenew));
        hashCode = (17 * hashCode) + (baseRatePlanId == null ? 0 : System.hashCode(baseRatePlanId));
        hashCode = (17 * hashCode) + (baseSubscriptionId == null ? 0 : System.hashCode(baseSubscriptionId));
        hashCode = (17 * hashCode) + (code == null ? 0 : System.hashCode(code));
        hashCode = (17 * hashCode) + (contractEffectiveDate == null ? 0 : System.hashCode(contractEffectiveDate));
        hashCode = (17 * hashCode) + (currentTerm == null ? 0 : System.hashCode(currentTerm));
        hashCode = (17 * hashCode) + (currentTermPeriodType == null ? 0 : System.hashCode(currentTermPeriodType));
        hashCode = (17 * hashCode) + (customerAcceptanceDate == null ? 0 : System.hashCode(customerAcceptanceDate));
        hashCode = (17 * hashCode) + (description == null ? 0 : System.hashCode(description));
        hashCode = (17 * hashCode) + (destinationAccountId == null ? 0 : System.hashCode(destinationAccountId));
        hashCode = (17 * hashCode) + (destinationInvoiceOwnerId == null ? 0 : System.hashCode(destinationInvoiceOwnerId));
        hashCode = (17 * hashCode) + (effectiveDate == null ? 0 : System.hashCode(effectiveDate));
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
        hashCode = (17 * hashCode) + (name == null ? 0 : System.hashCode(name));
        hashCode = (17 * hashCode) + (newRatePlanId == null ? 0 : System.hashCode(newRatePlanId));
        hashCode = (17 * hashCode) + (newSubscriptionId == null ? 0 : System.hashCode(newSubscriptionId));
        hashCode = (17 * hashCode) + (renewalSetting == null ? 0 : System.hashCode(renewalSetting));
        hashCode = (17 * hashCode) + (renewalTerm == null ? 0 : System.hashCode(renewalTerm));
        hashCode = (17 * hashCode) + (renewalTermPeriodType == null ? 0 : System.hashCode(renewalTermPeriodType));
        hashCode = (17 * hashCode) + (resumeDate == null ? 0 : System.hashCode(resumeDate));
        hashCode = (17 * hashCode) + (serviceActivationDate == null ? 0 : System.hashCode(serviceActivationDate));
        hashCode = (17 * hashCode) + (specificUpdateDate == null ? 0 : System.hashCode(specificUpdateDate));
        hashCode = (17 * hashCode) + (status == null ? 0 : System.hashCode(status));
        hashCode = (17 * hashCode) + (success == null ? 0 : System.hashCode(success));
        hashCode = (17 * hashCode) + (suspendDate == null ? 0 : System.hashCode(suspendDate));
        hashCode = (17 * hashCode) + (termStartDate == null ? 0 : System.hashCode(termStartDate));
        hashCode = (17 * hashCode) + (termType == null ? 0 : System.hashCode(termType));
        hashCode = (17 * hashCode) + (r_type == null ? 0 : System.hashCode(r_type));
        return hashCode;
    }
}