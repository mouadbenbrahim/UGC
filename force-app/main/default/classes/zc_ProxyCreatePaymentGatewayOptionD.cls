/**
 * A field used to pass gateway options. Zuora allows you to pass in special gateway-specific parameters for payments that go through the Adyen, Autorize.et, CyberSource, Merchant eSolutions, Orbital (Chase Paymentech), QValent, Vantiv, and Verifi gateways.\n\nFor each of these special parameters, you supply the name-value pair and Zuora passes it to the gateway. This allows you to add functionality that\&#39;s supported by a specific gateway but currently not supported by Zuora.\n
 */
public class zc_ProxyCreatePaymentGatewayOptionD implements zc_Zuc.MappedProperties {
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

    public zc_ProxyCreatePaymentGatewayOptionD() {
        gatewayOption = new List<zc_GatewayOption>();
    }

    // public static zc_ProxyCreatePaymentGatewayOptionD getExample() {
    //     zc_ProxyCreatePaymentGatewayOptionD proxyCreatePaymentGatewayOptionData = new zc_ProxyCreatePaymentGatewayOptionD();
    //     proxyCreatePaymentGatewayOptionData.gatewayOption = new List<zc_GatewayOption>{zc_GatewayOption.getExample()};
    //     return proxyCreatePaymentGatewayOptionData;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_ProxyCreatePaymentGatewayOptionD) {
            zc_ProxyCreatePaymentGatewayOptionD proxyCreatePaymentGatewayOptionData = (zc_ProxyCreatePaymentGatewayOptionD) obj;
            return this.gatewayOption == proxyCreatePaymentGatewayOptionData.gatewayOption;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (gatewayOption == null ? 0 : System.hashCode(gatewayOption));
        return hashCode;
    }
}