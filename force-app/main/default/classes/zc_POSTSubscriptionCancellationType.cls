/**
 * zc_POSTSubscriptionCancellationType
 */
public class zc_POSTSubscriptionCancellationType {
    /**
     * Applies a credit balance to an invoice.\n\nIf the value is `true`, the credit balance is applied to the invoice. If the value is `false`, no action is taken.\n\n\nTo view the credit balance adjustment, retrieve the details of the invoice using the Get Invoices method.\n\nPrerequisite: `invoice` must be `true`. \n\n**Note:** \n  - If you are using the field `invoiceCollect` rather than the field `invoice`, the `invoiceCollect` value must be `true`.\n  - This field is deprecated if you have the Invoice Settlement feature enabled.\n
     * @return applyCreditBalance
     */
    public Boolean applyCreditBalance { get; set; }

    /**
     * Date the cancellation takes effect, in the format yyyy-mm-dd.  Use only if `cancellationPolicy` is `SpecificDate`. Should not be earlier than the subscription contract-effective date, later than the subscription term-end date, or within a period for which the customer has been invoiced.\n
     * @return cancellationEffectiveDate
     */
    public Date cancellationEffectiveDate { get; set; }

    /**
     * Cancellation method. Possible values are: `EndOfCurrentTerm`, `EndOfLastInvoicePeriod`, `SpecificDate`. If using `SpecificDate`, the `cancellationEffectiveDate` field is required.\n
     * @return cancellationPolicy
     */
    public String cancellationPolicy { get; set; }

    /**
     * Collects an automatic payment for a subscription. The collection generated in this operation is only for this subscription, not for the entire customer account.\n\nIf the value is `true`, the automatic payment is collected. If the value is `false`, no action is taken.\n\nPrerequisite: The `invoice` or `runBilling` field must be `true`. \n\n**Note**: This field is only available if you set the `zuora-version` request header to `196.0` or later.\n
     * @return r_collect
     */
    public Boolean r_collect { get; set; }

    /**
     * The date of the billing document, in `yyyy-mm-dd` format. It represents the invoice date for invoices, credit memo date for credit memos, and debit memo date for debit memos.\n\n- If this field is specified, the specified date is used as the billing document date. \n- If this field is not specified, the date specified in the `targetDate` is used as the billing document date.\n
     * @return documentDate
     */
    public Date documentDate { get; set; }

    /**
     * **Note:** This field has been replaced by the `runBilling` field. The\n`invoice` field is only available for backward compatibility.\n\n\nCreates an invoice for a subscription. The invoice generated in this\noperation is only for this subscription, not for the entire customer\naccount.\n\n\nIf the value is `true`, an invoice is created. If the value is\n`false`, no action is taken. The default value is `false`. \n\n\nThis field is in Zuora REST API version control. Supported minor\nversions are `196.0` and `207.0`. To use this field in the method, you\nmust set the zuora-version parameter to the minor version number in\nthe request header. \n
     * @return invoice
     */
    public Boolean invoice { get; set; }

    /**
     * This field has been replaced by the `invoice` field and the\n`collect` field. `invoiceCollect` is available only for backward compatibility.\n\nIf this field is set to `true`, an invoice is generated and payment automatically collected.\n\n**Note**: This field is only available if you set the `zuora-version` request header to `186.0`, `187.0`, `188.0`, or `189.0`.\n
     * @return invoiceCollect
     */
    public Boolean invoiceCollect { get; set; }

    /**
     * **Note:** This field has been replaced by the `targetDate` field. The\n`invoiceTargetDate` field is only available for backward\ncompatibility.\n\n\nDate through which to calculate charges if an invoice is generated, as\nyyyy-mm-dd. Default is current date.\n\n\nThis field is in Zuora REST API version control. Supported minor\nversions are `207.0` and earlier.  \n
     * @return invoiceTargetDate
     */
    public Date invoiceTargetDate { get; set; }

    /**
     * Creates an invoice for a subscription. If you have the Invoice Settlement feature enabled, a credit memo might also be created based on the [invoice and credit memo generation rule](https://knowledgecenter.zuora.com/CB_Billing/Invoice_Settlement/Credit_and_Debit_Memos/Rules_for_Generating_Invoices_and_Credit_Memos).  \n\n\nThe billing documents generated\nin this operation is only for this subscription, not for the entire\ncustomer account.\n\n\nPossible values:\n\n- `true`: An invoice is created. If you have the Invoice Settlement feature enabled, a credit memo might also be created.\n\n\n- `false`: No invoice is created.\n\n\n**Note:** This field is in Zuora REST API version control. Supported\nminor versions are `211.0` or later. To use this field in the method,\nyou must set the `zuora-version` parameter to the minor version number\nin the request header.\n
     * @return runBilling
     */
    public Boolean runBilling { get; set; }

    /**
     * Date through which to calculate charges if an invoice or a credit memo is generated, as\nyyyy-mm-dd. Default is current date.\n\n\n**Note:** The credit memo is only available if you have the Invoice Settlement feature enabled.\n\n\nThis field is in Zuora REST API version control. Supported minor\nversions are `211.0` and later. To use this field in the method, you\nmust set the  `zuora-version` parameter to the minor version number in\nthe request header.\n
     * @return targetDate
     */
    public Date targetDate { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'collect' => 'r_collect'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public zc_POSTSubscriptionCancellationType() {
        //r_collect = false;
        //invoiceCollect = false;
        runBilling = false;
    }

    // public static zc_POSTSubscriptionCancellationType getExample() {
    //     zc_POSTSubscriptionCancellationType poSTSubscriptionCancellationType = new zc_POSTSubscriptionCancellationType();
    //     poSTSubscriptionCancellationType.applyCreditBalance = true;
    //     poSTSubscriptionCancellationType.cancellationEffectiveDate = Date.newInstance(2000, 1, 23);
    //     poSTSubscriptionCancellationType.cancellationPolicy = 'aeiou';
    //     poSTSubscriptionCancellationType.r_collect = true;
    //     poSTSubscriptionCancellationType.documentDate = Date.newInstance(2000, 1, 23);
    //     poSTSubscriptionCancellationType.invoice = true;
    //     poSTSubscriptionCancellationType.invoiceCollect = true;
    //     poSTSubscriptionCancellationType.invoiceTargetDate = Date.newInstance(2000, 1, 23);
    //     poSTSubscriptionCancellationType.runBilling = true;
    //     poSTSubscriptionCancellationType.targetDate = Date.newInstance(2000, 1, 23);
    //     return poSTSubscriptionCancellationType;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_POSTSubscriptionCancellationType) {
            zc_POSTSubscriptionCancellationType poSTSubscriptionCancellationType = (zc_POSTSubscriptionCancellationType) obj;
            return this.applyCreditBalance == poSTSubscriptionCancellationType.applyCreditBalance
                && this.cancellationEffectiveDate == poSTSubscriptionCancellationType.cancellationEffectiveDate
                && this.cancellationPolicy == poSTSubscriptionCancellationType.cancellationPolicy
                && this.r_collect == poSTSubscriptionCancellationType.r_collect
                && this.documentDate == poSTSubscriptionCancellationType.documentDate
                && this.invoice == poSTSubscriptionCancellationType.invoice
                && this.invoiceCollect == poSTSubscriptionCancellationType.invoiceCollect
                && this.invoiceTargetDate == poSTSubscriptionCancellationType.invoiceTargetDate
                && this.runBilling == poSTSubscriptionCancellationType.runBilling
                && this.targetDate == poSTSubscriptionCancellationType.targetDate;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (applyCreditBalance == null ? 0 : System.hashCode(applyCreditBalance));
        hashCode = (17 * hashCode) + (cancellationEffectiveDate == null ? 0 : System.hashCode(cancellationEffectiveDate));
        hashCode = (17 * hashCode) + (cancellationPolicy == null ? 0 : System.hashCode(cancellationPolicy));
        hashCode = (17 * hashCode) + (r_collect == null ? 0 : System.hashCode(r_collect));
        hashCode = (17 * hashCode) + (documentDate == null ? 0 : System.hashCode(documentDate));
        hashCode = (17 * hashCode) + (invoice == null ? 0 : System.hashCode(invoice));
        hashCode = (17 * hashCode) + (invoiceCollect == null ? 0 : System.hashCode(invoiceCollect));
        hashCode = (17 * hashCode) + (invoiceTargetDate == null ? 0 : System.hashCode(invoiceTargetDate));
        hashCode = (17 * hashCode) + (runBilling == null ? 0 : System.hashCode(runBilling));
        hashCode = (17 * hashCode) + (targetDate == null ? 0 : System.hashCode(targetDate));
        return hashCode;
    }
}