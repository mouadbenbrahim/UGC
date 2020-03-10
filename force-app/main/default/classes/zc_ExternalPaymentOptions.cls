public class zc_ExternalPaymentOptions implements zc_Zuc.MappedProperties {
    /**
     * 
     * @return amount
     */
    public Double amount { get; set; }

    /**
     * 
     * @return effectiveDate
     */
    public Date effectiveDate { get; set; }

    /**
     * 
     * @return gatewayOrderId
     */
    public String gatewayOrderId { get; set; }

    /**
     * 
     * @return paymentMethodId
     */
    public String paymentMethodId { get; set; }

    /**
     * 
     * @return referenceId
     */
    public String referenceId { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Amount' => 'amount',
        'EffectiveDate' => 'effectiveDate',
        'GatewayOrderId' => 'gatewayOrderId',
        'PaymentMethodId' => 'paymentMethodId',
        'ReferenceId' => 'referenceId'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public static zc_ExternalPaymentOptions getExample() {
        zc_ExternalPaymentOptions externalPaymentOptions = new zc_ExternalPaymentOptions();
        externalPaymentOptions.amount = 1.3579;
        externalPaymentOptions.effectiveDate = Date.newInstance(2000, 1, 23);
        externalPaymentOptions.gatewayOrderId = 'aeiou';
        externalPaymentOptions.paymentMethodId = 'aeiou';
        externalPaymentOptions.referenceId = 'aeiou';
        return externalPaymentOptions;
    }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_ExternalPaymentOptions) {
            zc_ExternalPaymentOptions externalPaymentOptions = (zc_ExternalPaymentOptions) obj;
            return this.amount == externalPaymentOptions.amount
                && this.effectiveDate == externalPaymentOptions.effectiveDate
                && this.gatewayOrderId == externalPaymentOptions.gatewayOrderId
                && this.paymentMethodId == externalPaymentOptions.paymentMethodId
                && this.referenceId == externalPaymentOptions.referenceId;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (amount == null ? 0 : System.hashCode(amount));
        hashCode = (17 * hashCode) + (effectiveDate == null ? 0 : System.hashCode(effectiveDate));
        hashCode = (17 * hashCode) + (gatewayOrderId == null ? 0 : System.hashCode(gatewayOrderId));
        hashCode = (17 * hashCode) + (paymentMethodId == null ? 0 : System.hashCode(paymentMethodId));
        hashCode = (17 * hashCode) + (referenceId == null ? 0 : System.hashCode(referenceId));
        return hashCode;
    }
}