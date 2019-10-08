public class zc_InvoiceData implements zc_Zuc.MappedProperties {
    /**
     * Get invoice
     * @return invoice
     */
    public zc_InvoiceDataInvoice invoice { get; set; }

    /**
     * 
     * @return invoiceItem
     */
    public List<zc_InvoiceItem> invoiceItem { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Invoice' => 'invoice',
        'InvoiceItem' => 'invoiceItem'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public zc_InvoiceData() {
        invoiceItem = new List<zc_InvoiceItem>();
    }

    public static zc_InvoiceData getExample() {
        zc_InvoiceData invoiceData = new zc_InvoiceData();
        invoiceData.invoice = zc_InvoiceDataInvoice.getExample();
        invoiceData.invoiceItem = new List<zc_InvoiceItem>{zc_InvoiceItem.getExample()};
        return invoiceData;
    }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_InvoiceData) {
            zc_InvoiceData invoiceData = (zc_InvoiceData) obj;
            return this.invoice == invoiceData.invoice
                && this.invoiceItem == invoiceData.invoiceItem;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (invoice == null ? 0 : System.hashCode(invoice));
        hashCode = (17 * hashCode) + (invoiceItem == null ? 0 : System.hashCode(invoiceItem));
        return hashCode;
    }
}