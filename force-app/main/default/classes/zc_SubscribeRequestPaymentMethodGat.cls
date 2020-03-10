/**
 *  Use this field to pass gateway options.\n\n\n**Character limit**: 255\n\n\n**Values**: GatewayOption 
 */
public class zc_SubscribeRequestPaymentMethodGat {
    /**
     * 
     * @return gatewayOption
     */
    public List<zc_GatewayOption> gatewayOption { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'GatewayOption' => 'gatewayOption'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public zc_SubscribeRequestPaymentMethodGat() {
        gatewayOption = new List<zc_GatewayOption>();
    }

    // public static zc_SubscribeRequestPaymentMethodGat getExample() {
    //     zc_SubscribeRequestPaymentMethodGat subscribeRequestPaymentMethodGatewayOptionData = new zc_SubscribeRequestPaymentMethodGat();
    //     subscribeRequestPaymentMethodGatewayOptionData.gatewayOption = new List<zc_GatewayOption>{zc_GatewayOption.getExample()};
    //     return subscribeRequestPaymentMethodGatewayOptionData;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_SubscribeRequestPaymentMethodGat) {
            zc_SubscribeRequestPaymentMethodGat subscribeRequestPaymentMethodGatewayOptionData = (zc_SubscribeRequestPaymentMethodGat) obj;
            return this.gatewayOption == subscribeRequestPaymentMethodGatewayOptionData.gatewayOption;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (gatewayOption == null ? 0 : System.hashCode(gatewayOption));
        return hashCode;
    }
}