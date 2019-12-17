public class zc_SubscribeRequestInvProcessingOptions {

    public Date invoiceDate { get; set; }
    public String invoiceProcessingScope { get; set; }
    public Date invoiceTargetDate { get; set; } 

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'InvoiceDate' => 'invoiceDate',
        'InvoiceProcessingScope' => 'invoiceProcessingScope',
        'InvoiceTargetDate' => 'invoiceTargetDate'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

}