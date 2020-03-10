/**
 * zc_PaymentInvoiceApplicationItemCre
 */
public class zc_PaymentInvoiceApplicationItemCre {
    /**
     * The amount of the payment associated with the specific invoice or taxation item.\n
     * @return amount
     */
    public Double amount { get; set; }

    /**
     * The ID of the specific invoice item.\n
     * @return invoiceItemId
     */
    public String invoiceItemId { get; set; }

    /**
     * The ID of the specific taxation item.\n
     * @return taxItemId
     */
    public String taxItemId { get; set; }

    // public static zc_PaymentInvoiceApplicationItemCre getExample() {
    //     zc_PaymentInvoiceApplicationItemCre paymentInvoiceApplicationItemCreateRequestType = new zc_PaymentInvoiceApplicationItemCre();
    //     paymentInvoiceApplicationItemCreateRequestType.amount = 1.3579;
    //     paymentInvoiceApplicationItemCreateRequestType.invoiceItemId = 'aeiou';
    //     paymentInvoiceApplicationItemCreateRequestType.taxItemId = 'aeiou';
    //     return paymentInvoiceApplicationItemCreateRequestType;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_PaymentInvoiceApplicationItemCre) {
            zc_PaymentInvoiceApplicationItemCre paymentInvoiceApplicationItemCreateRequestType = (zc_PaymentInvoiceApplicationItemCre) obj;
            return this.amount == paymentInvoiceApplicationItemCreateRequestType.amount
                && this.invoiceItemId == paymentInvoiceApplicationItemCreateRequestType.invoiceItemId
                && this.taxItemId == paymentInvoiceApplicationItemCreateRequestType.taxItemId;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (amount == null ? 0 : System.hashCode(amount));
        hashCode = (17 * hashCode) + (invoiceItemId == null ? 0 : System.hashCode(invoiceItemId));
        hashCode = (17 * hashCode) + (taxItemId == null ? 0 : System.hashCode(taxItemId));
        return hashCode;
    }
}