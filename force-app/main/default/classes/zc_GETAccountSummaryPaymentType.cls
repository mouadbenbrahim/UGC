/**
 * zc_GETAccountSummaryPaymentType
 */
public class zc_GETAccountSummaryPaymentType {
    /**
     * Effective date as `yyyy-mm-dd`.\n
     * @return effectiveDate
     */
    public Date effectiveDate { get; set; }

    /**
     * Payment ID.\n
     * @return id
     */
    public String id { get; set; }

    /**
     * Container for paid invoices for this subscription.\n
     * @return paidInvoices
     */
    public List<zc_GETAccountSummaryPaymentInvoiceT> paidInvoices { get; set; }

    /**
     * Payment number.\n
     * @return paymentNumber
     */
    public String paymentNumber { get; set; }

    /**
     * Payment type; possible values are: `External`, `Electronic`.\n
     * @return paymentType
     */
    public String paymentType { get; set; }

    /**
     * Payment status. Possible values are: `Draft`, `Processing`, `Processed`, `Error`, `Voided`, `Canceled`, `Posted`.\n
     * @return status
     */
    public String status { get; set; }

    public zc_GETAccountSummaryPaymentType() {
        paidInvoices = new List<zc_GETAccountSummaryPaymentInvoiceT>{new zc_GETAccountSummaryPaymentInvoiceT()};
    }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Aaaa' => 'aaaa',
        'Baaa' => 'bbbb'   
    };

    // public static zc_GETAccountSummaryPaymentType getExample() {
    //     zc_GETAccountSummaryPaymentType geTAccountSummaryPaymentType = new zc_GETAccountSummaryPaymentType();
    //     geTAccountSummaryPaymentType.effectiveDate = Date.newInstance(2000, 1, 23);
    //     geTAccountSummaryPaymentType.id = 'aeiou';
    //     geTAccountSummaryPaymentType.paidInvoices = new List<zc_GETAccountSummaryPaymentInvoiceT>{zc_GETAccountSummaryPaymentInvoiceT.getExample()};
    //     geTAccountSummaryPaymentType.paymentNumber = 'aeiou';
    //     geTAccountSummaryPaymentType.paymentType = 'aeiou';
    //     geTAccountSummaryPaymentType.status = 'aeiou';
    //     return geTAccountSummaryPaymentType;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_GETAccountSummaryPaymentType) {
            zc_GETAccountSummaryPaymentType geTAccountSummaryPaymentType = (zc_GETAccountSummaryPaymentType) obj;
            return this.effectiveDate == geTAccountSummaryPaymentType.effectiveDate
                && this.id == geTAccountSummaryPaymentType.id
                && this.paidInvoices == geTAccountSummaryPaymentType.paidInvoices
                && this.paymentNumber == geTAccountSummaryPaymentType.paymentNumber
                && this.paymentType == geTAccountSummaryPaymentType.paymentType
                && this.status == geTAccountSummaryPaymentType.status;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (effectiveDate == null ? 0 : System.hashCode(effectiveDate));
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
        hashCode = (17 * hashCode) + (paidInvoices == null ? 0 : System.hashCode(paidInvoices));
        hashCode = (17 * hashCode) + (paymentNumber == null ? 0 : System.hashCode(paymentNumber));
        hashCode = (17 * hashCode) + (paymentType == null ? 0 : System.hashCode(paymentType));
        hashCode = (17 * hashCode) + (status == null ? 0 : System.hashCode(status));
        return hashCode;
    }
}