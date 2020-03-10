/**
 * zc_GETInvoiceItemsResponse
 */
public class zc_GETInvoiceItemsResponse {
    /**
     * Container for invoice items.\n
     * @return invoiceItems
     */
    public List<zc_InvoiceItem> invoiceItems { get; set; }

    /**
     * URL to retrieve the next page of the response if it exists; otherwise absent.\n
     * @return nextPage
     */
    public String nextPage { get; set; }

    /**
     * Returns `true` if the request was processed successfully.
     * @return success
     */
    public Boolean success { get; set; }

    public zc_GETInvoiceItemsResponse() {
        invoiceItems = new List<zc_InvoiceItem>{new zc_InvoiceItem()};
    }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Aaa' => 'aaa',
        'Bbb' => 'bbb'
    };    

    // public static zc_GETInvoiceItemsResponse getExample() {
    //     zc_GETInvoiceItemsResponse geTInvoiceItemsResponse = new zc_GETInvoiceItemsResponse();
    //     geTInvoiceItemsResponse.invoiceItems = new List<zc_InvoiceItem>{zc_InvoiceItem.getExample()};
    //     geTInvoiceItemsResponse.nextPage = 'aeiou';
    //     geTInvoiceItemsResponse.success = true;
    //     return geTInvoiceItemsResponse;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_GETInvoiceItemsResponse) {
            zc_GETInvoiceItemsResponse geTInvoiceItemsResponse = (zc_GETInvoiceItemsResponse) obj;
            return this.invoiceItems == geTInvoiceItemsResponse.invoiceItems
                && this.nextPage == geTInvoiceItemsResponse.nextPage
                && this.success == geTInvoiceItemsResponse.success;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (invoiceItems == null ? 0 : System.hashCode(invoiceItems));
        hashCode = (17 * hashCode) + (nextPage == null ? 0 : System.hashCode(nextPage));
        hashCode = (17 * hashCode) + (success == null ? 0 : System.hashCode(success));
        return hashCode;
    }
}