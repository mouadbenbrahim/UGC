/**
 * zc_GETAccountSummaryInvoiceType
 */
public class zc_GETAccountSummaryInvoiceType {
    /**
     * Invoice amount before adjustments, discounts, and similar items.\n
     * @return amount
     */
    public String amount { get; set; }

    /**
     * Balance due on the invoice.\n
     * @return balance
     */
    public String balance { get; set; }

    /**
     * Due date as `yyyy-mm-dd`.\n
     * @return dueDate
     */
    public Date dueDate { get; set; }

    /**
     * Invoice ID.\n
     * @return id
     */
    public String id { get; set; }

    /**
     * Invoice date as `yyyy-mm-dd`.\n
     * @return invoiceDate
     */
    public Date invoiceDate { get; set; }

    /**
     * Invoice number.\n
     * @return invoiceNumber
     */
    public String invoiceNumber { get; set; }

    /**
     * Invoice status - not the payment status of the invoice, just the status of the invoice itself. Possible values are: `Posted`, `Draft`, `Canceled`, `Error`.\n
     * @return status
     */
    public String status { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Aaaa' => 'aaaa',
        'Baaa' => 'bbbb'   
    };
    
    // public static zc_GETAccountSummaryInvoiceType getExample() {
    //     zc_GETAccountSummaryInvoiceType geTAccountSummaryInvoiceType = new zc_GETAccountSummaryInvoiceType();
    //     geTAccountSummaryInvoiceType.amount = 'aeiou';
    //     geTAccountSummaryInvoiceType.balance = 'aeiou';
    //     geTAccountSummaryInvoiceType.dueDate = Date.newInstance(2000, 1, 23);
    //     geTAccountSummaryInvoiceType.id = 'aeiou';
    //     geTAccountSummaryInvoiceType.invoiceDate = Date.newInstance(2000, 1, 23);
    //     geTAccountSummaryInvoiceType.invoiceNumber = 'aeiou';
    //     geTAccountSummaryInvoiceType.status = 'aeiou';
    //     return geTAccountSummaryInvoiceType;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_GETAccountSummaryInvoiceType) {
            zc_GETAccountSummaryInvoiceType geTAccountSummaryInvoiceType = (zc_GETAccountSummaryInvoiceType) obj;
            return this.amount == geTAccountSummaryInvoiceType.amount
                && this.balance == geTAccountSummaryInvoiceType.balance
                && this.dueDate == geTAccountSummaryInvoiceType.dueDate
                && this.id == geTAccountSummaryInvoiceType.id
                && this.invoiceDate == geTAccountSummaryInvoiceType.invoiceDate
                && this.invoiceNumber == geTAccountSummaryInvoiceType.invoiceNumber
                && this.status == geTAccountSummaryInvoiceType.status;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (amount == null ? 0 : System.hashCode(amount));
        hashCode = (17 * hashCode) + (balance == null ? 0 : System.hashCode(balance));
        hashCode = (17 * hashCode) + (dueDate == null ? 0 : System.hashCode(dueDate));
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
        hashCode = (17 * hashCode) + (invoiceDate == null ? 0 : System.hashCode(invoiceDate));
        hashCode = (17 * hashCode) + (invoiceNumber == null ? 0 : System.hashCode(invoiceNumber));
        hashCode = (17 * hashCode) + (status == null ? 0 : System.hashCode(status));
        return hashCode;
    }
}