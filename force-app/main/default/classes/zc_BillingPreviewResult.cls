/**
 * zc_BillingPreviewResult
 */
public class zc_BillingPreviewResult {
    /**
     * ID of the customer account to which the billing preview applies.\n
     * @return accountId
     */
    public String accountId { get; set; }

    /**
     * An array of credit memo items returned as the result of the billing preivew request.\n\n**Note:** The credit memo items are only available if you have Invoice Settlement feature enabled. The Invoice Settlement feature is in **Limited Availability**. If you wish to have access to the feature, submit a request at [Zuora Global Support](http://support.zuora.com/).\n
     * @return creditMemoItems
     */
    public List<zc_POSTBillingPreviewCreditMemoItem> creditMemoItems { get; set; }

    /**
     * An array of invoice items returned as the result of the billing preview request.\n
     * @return invoiceItems
     */
    public List<zc_POSTBillingPreviewInvoiceItem> invoiceItems { get; set; }

    /**
     * Returns `true` if the request was processed successfully.\n
     * @return success
     */
    public Boolean success { get; set; }

    public zc_BillingPreviewResult() {
        creditMemoItems = new List<zc_POSTBillingPreviewCreditMemoItem>{new zc_POSTBillingPreviewCreditMemoItem()};
        invoiceItems = new List<zc_POSTBillingPreviewInvoiceItem>{new zc_POSTBillingPreviewInvoiceItem()};
    }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Abb' => 'abb'
    };

    // public static zc_BillingPreviewResult getExample() {
    //     zc_BillingPreviewResult billingPreviewResult = new zc_BillingPreviewResult();
    //     billingPreviewResult.accountId = 'aeiou';
    //     billingPreviewResult.creditMemoItems = new List<zc_POSTBillingPreviewCreditMemoItem>{zc_POSTBillingPreviewCreditMemoItem.getExample()};
    //     billingPreviewResult.invoiceItems = new List<zc_POSTBillingPreviewInvoiceItem>{zc_POSTBillingPreviewInvoiceItem.getExample()};
    //     billingPreviewResult.success = true;
    //     return billingPreviewResult;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_BillingPreviewResult) {
            zc_BillingPreviewResult billingPreviewResult = (zc_BillingPreviewResult) obj;
            return this.accountId == billingPreviewResult.accountId
                && this.creditMemoItems == billingPreviewResult.creditMemoItems
                && this.invoiceItems == billingPreviewResult.invoiceItems
                && this.success == billingPreviewResult.success;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (accountId == null ? 0 : System.hashCode(accountId));
        hashCode = (17 * hashCode) + (creditMemoItems == null ? 0 : System.hashCode(creditMemoItems));
        hashCode = (17 * hashCode) + (invoiceItems == null ? 0 : System.hashCode(invoiceItems));
        hashCode = (17 * hashCode) + (success == null ? 0 : System.hashCode(success));
        return hashCode;
    }
}