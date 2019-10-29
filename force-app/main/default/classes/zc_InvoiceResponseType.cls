/**
 * zc_InvoiceResponseType
 */
public class zc_InvoiceResponseType {
    /**
     * The ID of the generated invoice.\n
     * @return id
     */
    public String id { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Aaaa' => 'aaaa'
    };

    // public static zc_InvoiceResponseType getExample() {
    //     zc_InvoiceResponseType invoiceResponseType = new zc_InvoiceResponseType();
    //     invoiceResponseType.id = 'aeiou';
    //     return invoiceResponseType;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_InvoiceResponseType) {
            zc_InvoiceResponseType invoiceResponseType = (zc_InvoiceResponseType) obj;
            return this.id == invoiceResponseType.id;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
        return hashCode;
    }
}