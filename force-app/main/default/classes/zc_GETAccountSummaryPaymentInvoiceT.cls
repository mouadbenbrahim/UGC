/**
 * zc_GETAccountSummaryPaymentInvoiceT
 */
public class zc_GETAccountSummaryPaymentInvoiceT {
    /**
     * Amount of payment applied to the invoice.\n
     * @return appliedPaymentAmount
     */
    public String appliedPaymentAmount { get; set; }

    /**
     * Invoice ID.\n
     * @return invoiceId
     */
    public String invoiceId { get; set; }

    /**
     * Invoice number.\n
     * @return invoiceNumber
     */
    public String invoiceNumber { get; set; }


    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Aaaa' => 'aaaa',
        'Baaa' => 'bbbb'   
    };
    
    // public static zc_GETAccountSummaryPaymentInvoiceT getExample() {
    //     zc_GETAccountSummaryPaymentInvoiceT geTAccountSummaryPaymentInvoiceType = new zc_GETAccountSummaryPaymentInvoiceT();
    //     geTAccountSummaryPaymentInvoiceType.appliedPaymentAmount = 'aeiou';
    //     geTAccountSummaryPaymentInvoiceType.invoiceId = 'aeiou';
    //     geTAccountSummaryPaymentInvoiceType.invoiceNumber = 'aeiou';
    //     return geTAccountSummaryPaymentInvoiceType;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_GETAccountSummaryPaymentInvoiceT) {
            zc_GETAccountSummaryPaymentInvoiceT geTAccountSummaryPaymentInvoiceType = (zc_GETAccountSummaryPaymentInvoiceT) obj;
            return this.appliedPaymentAmount == geTAccountSummaryPaymentInvoiceType.appliedPaymentAmount
                && this.invoiceId == geTAccountSummaryPaymentInvoiceType.invoiceId
                && this.invoiceNumber == geTAccountSummaryPaymentInvoiceType.invoiceNumber;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (appliedPaymentAmount == null ? 0 : System.hashCode(appliedPaymentAmount));
        hashCode = (17 * hashCode) + (invoiceId == null ? 0 : System.hashCode(invoiceId));
        hashCode = (17 * hashCode) + (invoiceNumber == null ? 0 : System.hashCode(invoiceNumber));
        return hashCode;
    }
}