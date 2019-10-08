public class zc_ElectronicPaymentOptions implements zc_Zuc.MappedProperties {
    /**
     * 
     * @return paymentMethodId
     */
    public String paymentMethodId { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'PaymentMethodId' => 'paymentMethodId'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public static zc_ElectronicPaymentOptions getExample() {
        zc_ElectronicPaymentOptions electronicPaymentOptions = new zc_ElectronicPaymentOptions();
        electronicPaymentOptions.paymentMethodId = 'aeiou';
        return electronicPaymentOptions;
    }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_ElectronicPaymentOptions) {
            zc_ElectronicPaymentOptions electronicPaymentOptions = (zc_ElectronicPaymentOptions) obj;
            return this.paymentMethodId == electronicPaymentOptions.paymentMethodId;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (paymentMethodId == null ? 0 : System.hashCode(paymentMethodId));
        return hashCode;
    }
}