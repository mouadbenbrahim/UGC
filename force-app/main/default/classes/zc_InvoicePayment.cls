/**
 * zc_InvoicePayment
 */
public class zc_InvoicePayment implements zc_Zuc.MappedProperties {
    /**
     * The amount of the payment to apply to an invoice.\n
     * @return amount
     */
    public String amount { get; set; }

    /**
     * The ID of the invoice that the payment is applied to.\n
     * @return invoiceId
     */
    public String invoiceId { get; set; }

    /**
     * The ID of the payment.\n
     * @return paymentId
     */
    public String paymentId { get; set; }

    private static final Map<String, String> propertyMappings = new Map<String, String>{
        'Amount' => 'amount',
        'InvoiceId' => 'invoiceId',
        'PaymentId' => 'paymentId'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    // public static zc_InvoicePayment getExample() {
    //     zc_InvoicePayment invoicePayment = new zc_InvoicePayment();
    //     invoicePayment.amount = 'aeiou';
    //     invoicePayment.invoiceId = 'aeiou';
    //     invoicePayment.paymentId = 'aeiou';
    //     return invoicePayment;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_InvoicePayment) {
            zc_InvoicePayment invoicePayment = (zc_InvoicePayment) obj;
            return this.amount == invoicePayment.amount
                && this.invoiceId == invoicePayment.invoiceId
                && this.paymentId == invoicePayment.paymentId;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (amount == null ? 0 : System.hashCode(amount));
        hashCode = (17 * hashCode) + (invoiceId == null ? 0 : System.hashCode(invoiceId));
        hashCode = (17 * hashCode) + (paymentId == null ? 0 : System.hashCode(paymentId));
        return hashCode;
    }
}