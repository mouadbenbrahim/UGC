/**
 * 
 */
public class zc_SubscribeResultInvoiceResultInvo {
    /**
     * 
     * @return id
     */
    public String id { get; set; }

    /**
     * 
     * @return invoiceNumber
     */
    public String invoiceNumber { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Id' => 'id',
        'InvoiceNumber' => 'invoiceNumber'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    // public static zc_SubscribeResultInvoiceResultInvo getExample() {
    //     zc_SubscribeResultInvoiceResultInvo subscribeResultInvoiceResultInvoice = new zc_SubscribeResultInvoiceResultInvo();
    //     subscribeResultInvoiceResultInvoice.id = 'aeiou';
    //     subscribeResultInvoiceResultInvoice.invoiceNumber = 'aeiou';
    //     return subscribeResultInvoiceResultInvoice;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_SubscribeResultInvoiceResultInvo) {
            zc_SubscribeResultInvoiceResultInvo subscribeResultInvoiceResultInvoice = (zc_SubscribeResultInvoiceResultInvo) obj;
            return this.id == subscribeResultInvoiceResultInvoice.id
                && this.invoiceNumber == subscribeResultInvoiceResultInvoice.invoiceNumber;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
        hashCode = (17 * hashCode) + (invoiceNumber == null ? 0 : System.hashCode(invoiceNumber));
        return hashCode;
    }
}