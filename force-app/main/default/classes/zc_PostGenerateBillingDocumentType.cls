/**
 * zc_PostGenerateBillingDocumentType
 */
public class zc_PostGenerateBillingDocumentType {
    /**
     * Whether to automatically post the billing documents after the draft billing documents are generated. \n\nIf an error occurs during posting billing documents, the draft billing documents are not generated too.\n
     * @return autoPost
     */
    public Boolean autoPost { get; set; }

    /**
     * Whether to automatically renew the subscriptions with **Auto Renew** set to **Yes**. \n
     * @return autoRenew
     */
    public Boolean autoRenew { get; set; }

    /**
     * The types of the charges to be excluded from the generation of billing documents. The field values are case insensitive. Supported values include `onetime`, `recurring`, and `usage`. \n
     * @return chargeTypeToExclude
     */
    public List<String> chargeTypeToExclude { get; set; }

    /**
     * The date on which to generate the billing documents, in `yyyy-mm-dd` format.\n
     * @return effectiveDate
     */
    public Date effectiveDate { get; set; }

    /**
     * The IDs of the subscriptions that you want to create the billing documents for. \n
     * @return subscriptionIds
     */
    public List<String> subscriptionIds { get; set; }

    /**
     * The date used to determine which charges are to be billed, in `yyyy-mm-dd` format.\n
     * @return targetDate
     */
    public Date targetDate { get; set; }

    public zc_PostGenerateBillingDocumentType() {
        autoPost = false;
        autoRenew = false;
        chargeTypeToExclude = new List<String>();
        subscriptionIds = new List<String>();
    }

    // public static zc_PostGenerateBillingDocumentType getExample() {
    //     zc_PostGenerateBillingDocumentType postGenerateBillingDocumentType = new zc_PostGenerateBillingDocumentType();
    //     postGenerateBillingDocumentType.autoPost = true;
    //     postGenerateBillingDocumentType.autoRenew = true;
    //     postGenerateBillingDocumentType.chargeTypeToExclude = new List<String>{'aeiou'};
    //     postGenerateBillingDocumentType.effectiveDate = Date.newInstance(2000, 1, 23);
    //     postGenerateBillingDocumentType.subscriptionIds = new List<String>{'aeiou'};
    //     postGenerateBillingDocumentType.targetDate = Date.newInstance(2000, 1, 23);
    //     return postGenerateBillingDocumentType;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_PostGenerateBillingDocumentType) {
            zc_PostGenerateBillingDocumentType postGenerateBillingDocumentType = (zc_PostGenerateBillingDocumentType) obj;
            return this.autoPost == postGenerateBillingDocumentType.autoPost
                && this.autoRenew == postGenerateBillingDocumentType.autoRenew
                && this.chargeTypeToExclude == postGenerateBillingDocumentType.chargeTypeToExclude
                && this.effectiveDate == postGenerateBillingDocumentType.effectiveDate
                && this.subscriptionIds == postGenerateBillingDocumentType.subscriptionIds
                && this.targetDate == postGenerateBillingDocumentType.targetDate;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (autoPost == null ? 0 : System.hashCode(autoPost));
        hashCode = (17 * hashCode) + (autoRenew == null ? 0 : System.hashCode(autoRenew));
        hashCode = (17 * hashCode) + (chargeTypeToExclude == null ? 0 : System.hashCode(chargeTypeToExclude));
        hashCode = (17 * hashCode) + (effectiveDate == null ? 0 : System.hashCode(effectiveDate));
        hashCode = (17 * hashCode) + (subscriptionIds == null ? 0 : System.hashCode(subscriptionIds));
        hashCode = (17 * hashCode) + (targetDate == null ? 0 : System.hashCode(targetDate));
        return hashCode;
    }
}