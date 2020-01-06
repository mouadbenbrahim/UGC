/**
 * zc_InvoiceFile
 */
public class zc_InvoiceFile {
    /**
     * The ID of the invoice PDF file. This is the ID for the file object and different from the file handle ID in the `pdfFileUrl` field. To open a file, you have to use the file handle ID.\n
     * @return id
     */
    public String id { get; set; }

    /**
     * The REST URL for the invoice PDF file. Click the URL to open the invoice PDF file.\n
     * @return pdfFileUrl
     */
    public String pdfFileUrl { get; set; }

    /**
     * The version number of the invoice PDF file.\n
     * @return versionNumber
     */
    public Long versionNumber { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Aaaa' => 'aaa',
        'Bbbb' => 'bbb'
    };    

    // public static zc_InvoiceFile getExample() {
    //     zc_InvoiceFile invoiceFile = new zc_InvoiceFile();
    //     invoiceFile.id = 'aeiou';
    //     invoiceFile.pdfFileUrl = 'aeiou';
    //     invoiceFile.versionNumber = 123456789L;
    //     return invoiceFile;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_InvoiceFile) {
            zc_InvoiceFile invoiceFile = (zc_InvoiceFile) obj;
            return this.id == invoiceFile.id
                && this.pdfFileUrl == invoiceFile.pdfFileUrl
                && this.versionNumber == invoiceFile.versionNumber;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
        hashCode = (17 * hashCode) + (pdfFileUrl == null ? 0 : System.hashCode(pdfFileUrl));
        hashCode = (17 * hashCode) + (versionNumber == null ? 0 : System.hashCode(versionNumber));
        return hashCode;
    }
}