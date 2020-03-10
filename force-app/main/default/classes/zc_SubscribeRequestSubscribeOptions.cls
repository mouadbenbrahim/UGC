/**
 *  This optional object specifies parameters related to invoicing - whether to immediately generate an invoice and collect payment, and whether the invoice should cover all subscriptions or just this new subscription.\nThe default behavior is to invoice immediately for all the account\&#39;s subscriptions, with the current date as the target date, and immediately collect payment if the account\&#39;s &#x60;AutoPay&#x60; flag is true.\n\n\n**Values:** A valid SubscribeOptions object. 
 */
public class zc_SubscribeRequestSubscribeOptions {
    /**
     * 
     * @return applyCreditBalance
     */
    public Boolean applyCreditBalance { get; set; }

    /**
     * Get electronicPaymentOptions
     * @return electronicPaymentOptions
     */
    public zc_SubscribeRequestSubscribeOptions electronicPaymentOptions { get; set; }

    /**
     * Get externalPaymentOptions
     * @return externalPaymentOptions
     */
    public zc_SubscribeRequestSubscribeOptions externalPaymentOptions { get; set; }

    /**
     * 
     * @return generateInvoice
     */
    public Boolean generateInvoice { get; set; }

    /**
     * 
     * @return processPayments
     */
    public Boolean processPayments { get; set; }

    /**
     * Get subscribeInvoiceProcessingOptions
     * @return subscribeInvoiceProcessingOptions
     */
    public zc_SubscribeRequestInvProcessingOptions subscribeInvoiceProcessingOptions { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'ApplyCreditBalance' => 'applyCreditBalance',
        'ElectronicPaymentOptions' => 'electronicPaymentOptions',
        'ExternalPaymentOptions' => 'externalPaymentOptions',
        'GenerateInvoice' => 'generateInvoice',
        'ProcessPayments' => 'processPayments',
        'SubscribeInvoiceProcessingOptions' => 'subscribeInvoiceProcessingOptions'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    // public static zc_SubscribeRequestSubscribeOptions getExample() {
    //     zc_SubscribeRequestSubscribeOptions subscribeRequestSubscribeOptions = new zc_SubscribeRequestSubscribeOptions();
    //     subscribeRequestSubscribeOptions.applyCreditBalance = true;
    //     subscribeRequestSubscribeOptions.electronicPaymentOptions = zc_SubscribeRequestSubscribeOptions.getExample();
    //     subscribeRequestSubscribeOptions.externalPaymentOptions = zc_SubscribeRequestSubscribeOptions.getExample();
    //     subscribeRequestSubscribeOptions.generateInvoice = true;
    //     subscribeRequestSubscribeOptions.processPayments = true;
    //     subscribeRequestSubscribeOptions.subscribeInvoiceProcessingOptions = zc_SubscribeRequestSubscribeOptions.getExample();
    //     return subscribeRequestSubscribeOptions;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_SubscribeRequestSubscribeOptions) {
            zc_SubscribeRequestSubscribeOptions subscribeRequestSubscribeOptions = (zc_SubscribeRequestSubscribeOptions) obj;
            return this.applyCreditBalance == subscribeRequestSubscribeOptions.applyCreditBalance
                && this.electronicPaymentOptions == subscribeRequestSubscribeOptions.electronicPaymentOptions
                && this.externalPaymentOptions == subscribeRequestSubscribeOptions.externalPaymentOptions
                && this.generateInvoice == subscribeRequestSubscribeOptions.generateInvoice
                && this.processPayments == subscribeRequestSubscribeOptions.processPayments
                && this.subscribeInvoiceProcessingOptions == subscribeRequestSubscribeOptions.subscribeInvoiceProcessingOptions;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (applyCreditBalance == null ? 0 : System.hashCode(applyCreditBalance));
        hashCode = (17 * hashCode) + (electronicPaymentOptions == null ? 0 : System.hashCode(electronicPaymentOptions));
        hashCode = (17 * hashCode) + (externalPaymentOptions == null ? 0 : System.hashCode(externalPaymentOptions));
        hashCode = (17 * hashCode) + (generateInvoice == null ? 0 : System.hashCode(generateInvoice));
        hashCode = (17 * hashCode) + (processPayments == null ? 0 : System.hashCode(processPayments));
        hashCode = (17 * hashCode) + (subscribeInvoiceProcessingOptions == null ? 0 : System.hashCode(subscribeInvoiceProcessingOptions));
        return hashCode;
    }
}