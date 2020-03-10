/**
 * zc_PaymentInvoiceApplicationCreateR
 */
public class zc_PaymentInvoiceApplicationCreateR {
    /**
     * The amount of the payment associated with the invoice.\n
     * @return amount
     */
    public Double amount { get; set; }

    /**
     * The unique ID of the invoice that the payment is created on.\n
     * @return invoiceId
     */
    public String invoiceId { get; set; }

    /**
     * Container for invoice items.\n\n**Note:** The Invoice Item Settlement feature is in **Limited Availability**. If you wish to have access to the feature, submit a request at [Zuora Global Support](http://support.zuora.com/).\n
     * @return items
     */
    public List<zc_PaymentInvoiceApplicationItemCre> items { get; set; }

    public zc_PaymentInvoiceApplicationCreateR() {
        items = new List<zc_PaymentInvoiceApplicationItemCre>();
    }

    // public static zc_PaymentInvoiceApplicationCreateR getExample() {
    //     zc_PaymentInvoiceApplicationCreateR paymentInvoiceApplicationCreateRequestType = new zc_PaymentInvoiceApplicationCreateR();
    //     paymentInvoiceApplicationCreateRequestType.amount = 1.3579;
    //     paymentInvoiceApplicationCreateRequestType.invoiceId = 'aeiou';
    //     paymentInvoiceApplicationCreateRequestType.items = new List<zc_PaymentInvoiceApplicationItemCre>{zc_PaymentInvoiceApplicationItemCre.getExample()};
    //     return paymentInvoiceApplicationCreateRequestType;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_PaymentInvoiceApplicationCreateR) {
            zc_PaymentInvoiceApplicationCreateR paymentInvoiceApplicationCreateRequestType = (zc_PaymentInvoiceApplicationCreateR) obj;
            return this.amount == paymentInvoiceApplicationCreateRequestType.amount
                && this.invoiceId == paymentInvoiceApplicationCreateRequestType.invoiceId
                && this.items == paymentInvoiceApplicationCreateRequestType.items;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (amount == null ? 0 : System.hashCode(amount));
        hashCode = (17 * hashCode) + (invoiceId == null ? 0 : System.hashCode(invoiceId));
        hashCode = (17 * hashCode) + (items == null ? 0 : System.hashCode(items));
        return hashCode;
    }
}