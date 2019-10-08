public class zc_AmendRequestAmendOptions implements zc_Zuc.MappedProperties {
    /**
     * 
     * @return applyCreditBalance
     */
    public Boolean applyCreditBalance { get; set; }

    /**
     * Get electronicPaymentOptions
     * @return electronicPaymentOptions
     */
    public zc_ElectronicPaymentOptions electronicPaymentOptions { get; set; }

    /**
     * Get externalPaymentOptions
     * @return externalPaymentOptions
     */
    public zc_ExternalPaymentOptions externalPaymentOptions { get; set; }

    /**
     * 
     * @return generateInvoice
     */
    public Boolean generateInvoice { get; set; }

    /**
     * Get invoiceProcessingOptions
     * @return invoiceProcessingOptions
     */
    public zc_InvoiceProcessingOptions invoiceProcessingOptions { get; set; }

    /**
     * 
     * @return processPayments
     */
    public Boolean processPayments { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'ApplyCreditBalance' => 'applyCreditBalance',
        'ElectronicPaymentOptions' => 'electronicPaymentOptions',
        'ExternalPaymentOptions' => 'externalPaymentOptions',
        'GenerateInvoice' => 'generateInvoice',
        'InvoiceProcessingOptions' => 'invoiceProcessingOptions',
        'ProcessPayments' => 'processPayments'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public static zc_AmendRequestAmendOptions getExample() {
        zc_AmendRequestAmendOptions amendRequestAmendOptions = new zc_AmendRequestAmendOptions();
        amendRequestAmendOptions.applyCreditBalance = true;
        amendRequestAmendOptions.electronicPaymentOptions = zc_ElectronicPaymentOptions.getExample();
        amendRequestAmendOptions.externalPaymentOptions = zc_ExternalPaymentOptions.getExample();
        amendRequestAmendOptions.generateInvoice = true;
        amendRequestAmendOptions.invoiceProcessingOptions = zc_InvoiceProcessingOptions.getExample();
        amendRequestAmendOptions.processPayments = true;
        return amendRequestAmendOptions;
    }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_AmendRequestAmendOptions) {
            zc_AmendRequestAmendOptions amendRequestAmendOptions = (zc_AmendRequestAmendOptions) obj;
            return this.applyCreditBalance == amendRequestAmendOptions.applyCreditBalance
                && this.electronicPaymentOptions == amendRequestAmendOptions.electronicPaymentOptions
                && this.externalPaymentOptions == amendRequestAmendOptions.externalPaymentOptions
                && this.generateInvoice == amendRequestAmendOptions.generateInvoice
                && this.invoiceProcessingOptions == amendRequestAmendOptions.invoiceProcessingOptions
                && this.processPayments == amendRequestAmendOptions.processPayments;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (applyCreditBalance == null ? 0 : System.hashCode(applyCreditBalance));
        hashCode = (17 * hashCode) + (electronicPaymentOptions == null ? 0 : System.hashCode(electronicPaymentOptions));
        hashCode = (17 * hashCode) + (externalPaymentOptions == null ? 0 : System.hashCode(externalPaymentOptions));
        hashCode = (17 * hashCode) + (generateInvoice == null ? 0 : System.hashCode(generateInvoice));
        hashCode = (17 * hashCode) + (invoiceProcessingOptions == null ? 0 : System.hashCode(invoiceProcessingOptions));
        hashCode = (17 * hashCode) + (processPayments == null ? 0 : System.hashCode(processPayments));
        return hashCode;
    }
}