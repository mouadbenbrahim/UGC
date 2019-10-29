/**
 * zc_GenerateBillingDocumentResponseT
 */
public class zc_GenerateBillingDocumentResponseT {
    /**
     * Container for generated credit memos.\n\n**Note:** This container is only available if you have the Invoice Settlement feature enabled. The Invoice Settlement feature is in **Limited Availability**. If you wish to have access to the feature, submit a request at [Zuora Global Support](http://support.zuora.com/).\n
     * @return creditMemos
     */
    public List<zc_CreditMemoResponseType> creditMemos { get; set; }

    /**
     * Container for generated invoics.\n
     * @return invoices
     */
    public List<zc_InvoiceResponseType> invoices { get; set; }

    /**
     * Returns `true` if the request was processed successfully.
     * @return success
     */
    public Boolean success { get; set; }

    public zc_GenerateBillingDocumentResponseT() {
        creditMemos = new List<zc_CreditMemoResponseType>{new zc_CreditMemoResponseType()};
        invoices = new List<zc_InvoiceResponseType>{new zc_InvoiceResponseType()};
    }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Aaaa' => 'aaaa'
    };

    // public static zc_GenerateBillingDocumentResponseT getExample() {
    //     zc_GenerateBillingDocumentResponseT generateBillingDocumentResponseType = new zc_GenerateBillingDocumentResponseT();
    //     generateBillingDocumentResponseType.creditMemos = new List<zc_CreditMemoResponseType>{zc_CreditMemoResponseType.getExample()};
    //     generateBillingDocumentResponseType.invoices = new List<zc_InvoiceResponseType>{zc_InvoiceResponseType.getExample()};
    //     generateBillingDocumentResponseType.success = true;
    //     return generateBillingDocumentResponseType;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_GenerateBillingDocumentResponseT) {
            zc_GenerateBillingDocumentResponseT generateBillingDocumentResponseType = (zc_GenerateBillingDocumentResponseT) obj;
            return this.creditMemos == generateBillingDocumentResponseType.creditMemos
                && this.invoices == generateBillingDocumentResponseType.invoices
                && this.success == generateBillingDocumentResponseType.success;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (creditMemos == null ? 0 : System.hashCode(creditMemos));
        hashCode = (17 * hashCode) + (invoices == null ? 0 : System.hashCode(invoices));
        hashCode = (17 * hashCode) + (success == null ? 0 : System.hashCode(success));
        return hashCode;
    }
}