/**
 * zc_GETInvoiceFilesResponse
 */
public class zc_GETInvoiceFilesResponse {
    /**
     * Container for invoice PDF files.\n
     * @return invoiceFiles
     */
    public List<zc_InvoiceFile> invoiceFiles { get; set; }

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

    public zc_GETInvoiceFilesResponse() {
        invoiceFiles = new List<zc_InvoiceFile>{new zc_InvoiceFile()};
    }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Aaaa' => 'aaa',
        'Bbbb' => 'bbb'
    };

    // public static zc_GETInvoiceFilesResponse getExample() {
    //     zc_GETInvoiceFilesResponse geTInvoiceFilesResponse = new zc_GETInvoiceFilesResponse();
    //     geTInvoiceFilesResponse.invoiceFiles = new List<zc_InvoiceFile>{zc_InvoiceFile.getExample()};
    //     geTInvoiceFilesResponse.nextPage = 'aeiou';
    //     geTInvoiceFilesResponse.success = true;
    //     return geTInvoiceFilesResponse;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_GETInvoiceFilesResponse) {
            zc_GETInvoiceFilesResponse geTInvoiceFilesResponse = (zc_GETInvoiceFilesResponse) obj;
            return this.invoiceFiles == geTInvoiceFilesResponse.invoiceFiles
                && this.nextPage == geTInvoiceFilesResponse.nextPage
                && this.success == geTInvoiceFilesResponse.success;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (invoiceFiles == null ? 0 : System.hashCode(invoiceFiles));
        hashCode = (17 * hashCode) + (nextPage == null ? 0 : System.hashCode(nextPage));
        hashCode = (17 * hashCode) + (success == null ? 0 : System.hashCode(success));
        return hashCode;
    }
}