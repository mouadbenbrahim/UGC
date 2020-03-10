public class zc_InvoiceItemTaxationItems {
    /**
     * List of taxation items.\n
     * @return data
     */
    public List<zc_GETInvoiceTaxItemType> data { get; set; }

    /**
     * URL to retrieve the next page of the response if it exists; otherwise absent.\n
     * @return nextPage
     */
    public String nextPage { get; set; }

    public zc_InvoiceItemTaxationItems() {
        data = new List<zc_GETInvoiceTaxItemType>{new zc_GETInvoiceTaxItemType()};
    }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Aaa' => 'aaa',
        'Bbb' => 'bbb'
    };

    public static zc_InvoiceItemTaxationItems getExample() {
        zc_InvoiceItemTaxationItems invoiceItemTaxationItems = new zc_InvoiceItemTaxationItems();
        invoiceItemTaxationItems.data = new List<zc_GETInvoiceTaxItemType>{zc_GETInvoiceTaxItemType.getExample()};
        invoiceItemTaxationItems.nextPage = 'aeiou';
        return invoiceItemTaxationItems;
    }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_InvoiceItemTaxationItems) {
            zc_InvoiceItemTaxationItems invoiceItemTaxationItems = (zc_InvoiceItemTaxationItems) obj;
            return this.data == invoiceItemTaxationItems.data
                && this.nextPage == invoiceItemTaxationItems.nextPage;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (data == null ? 0 : System.hashCode(data));
        hashCode = (17 * hashCode) + (nextPage == null ? 0 : System.hashCode(nextPage));
        return hashCode;
    }
}