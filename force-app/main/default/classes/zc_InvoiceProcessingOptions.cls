public class zc_InvoiceProcessingOptions implements zc_Zuc.MappedProperties {
    /**
     *  The invoice date.
     * @return invoiceDate
     */
    public Date invoiceDate { get; set; }

    /**
     *  The date that determines which charges to bill. Charges prior to this date or on this date are billed on the resulting invoices. 
     * @return invoiceTargetDate
     */
    public Date invoiceTargetDate { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'InvoiceDate' => 'invoiceDate',
        'InvoiceTargetDate' => 'invoiceTargetDate'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public static zc_InvoiceProcessingOptions getExample() {
        zc_InvoiceProcessingOptions invoiceProcessingOptions = new zc_InvoiceProcessingOptions();
        invoiceProcessingOptions.invoiceDate = Date.newInstance(2000, 1, 23);
        invoiceProcessingOptions.invoiceTargetDate = Date.newInstance(2000, 1, 23);
        return invoiceProcessingOptions;
    }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_InvoiceProcessingOptions) {
            zc_InvoiceProcessingOptions invoiceProcessingOptions = (zc_InvoiceProcessingOptions) obj;
            return this.invoiceDate == invoiceProcessingOptions.invoiceDate
                && this.invoiceTargetDate == invoiceProcessingOptions.invoiceTargetDate;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (invoiceDate == null ? 0 : System.hashCode(invoiceDate));
        hashCode = (17 * hashCode) + (invoiceTargetDate == null ? 0 : System.hashCode(invoiceTargetDate));
        return hashCode;
    }
}