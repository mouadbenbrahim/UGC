/**
 * 
 */
public class zc_SubscribeResultInvoiceResult {
    /**
     * 
     * @return invoice
     */
    public List<zc_SubscribeResultInvoiceResultInvo> invoice { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Invoice' => 'invoice'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public zc_SubscribeResultInvoiceResult() {
        invoice = new List<zc_SubscribeResultInvoiceResultInvo>{new zc_SubscribeResultInvoiceResultInvo()};
    }

    // public static zc_SubscribeResultInvoiceResult getExample() {
    //     zc_SubscribeResultInvoiceResult subscribeResultInvoiceResult = new zc_SubscribeResultInvoiceResult();
    //     subscribeResultInvoiceResult.invoice = new List<zc_SubscribeResultInvoiceResultInvo>{zc_SubscribeResultInvoiceResultInvo.getExample()};
    //     return subscribeResultInvoiceResult;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_SubscribeResultInvoiceResult) {
            zc_SubscribeResultInvoiceResult subscribeResultInvoiceResult = (zc_SubscribeResultInvoiceResult) obj;
            return this.invoice == subscribeResultInvoiceResult.invoice;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (invoice == null ? 0 : System.hashCode(invoice));
        return hashCode;
    }
}