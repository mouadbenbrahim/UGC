/**
 * Container for custom fields of an Invoice Item object.\n
 */
public class zc_InvoiceItemObjectCustomFields { // extends HashMap<String, Object> {

    // add by MBE
    public Map<String,Object> customs {get; set;}

    // add by MBE
    public zc_InvoiceItemObjectCustomFields() {        
        customs =  new Map<String,Object>();
    }


    public static zc_InvoiceItemObjectCustomFields getExample() {
        zc_InvoiceItemObjectCustomFields invoiceItemObjectCustomFields = new zc_InvoiceItemObjectCustomFields();
        return invoiceItemObjectCustomFields;
    }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_InvoiceItemObjectCustomFields) {
            zc_InvoiceItemObjectCustomFields invoiceItemObjectCustomFields = (zc_InvoiceItemObjectCustomFields) obj;
            return this.customs == invoiceItemObjectCustomFields.customs; // add by MBE
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        return hashCode;
    }
}