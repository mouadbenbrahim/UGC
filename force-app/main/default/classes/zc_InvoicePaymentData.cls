/**
 * Container for the invoice payment data. This field is only required if you apply a payment to multiple invoices.\n
 */
public class zc_InvoicePaymentData implements zc_Zuc.MappedProperties {
    /**
     * 
     * @return invoicePayment
     */
    public List<zc_InvoicePayment> invoicePayment { get; set; }

    private static final Map<String, String> propertyMappings = new Map<String, String>{
        'InvoicePayment' => 'invoicePayment'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public zc_InvoicePaymentData() {
        invoicePayment = new List<zc_InvoicePayment>();
    }

    // public static zc_InvoicePaymentData getExample() {
    //     zc_InvoicePaymentData invoicePaymentData = new zc_InvoicePaymentData();
    //     invoicePaymentData.invoicePayment = new List<zc_InvoicePayment>{zc_InvoicePayment.getExample()};
    //     return invoicePaymentData;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_InvoicePaymentData) {
            zc_InvoicePaymentData invoicePaymentData = (zc_InvoicePaymentData) obj;
            return this.invoicePayment == invoicePaymentData.invoicePayment;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (invoicePayment == null ? 0 : System.hashCode(invoicePayment));
        return hashCode;
    }
}