/**
 * zc_GatewayOption
 */
public class zc_GatewayOption {
    /**
     * The name of a gateway-specific parameter. This field is optional, but you must pass value for this field when using the `GatewayOptionData` field. Otherwise, the additional payment gateway parameter will not be mapped.\n
     * @return name
     */
    public String name { get; set; }

    /**
     * The value of the gateway-specific parameter. This field is optional, but you must pass value for this field when using the `GatewayOptionData` field. Otherwise, the additional payment gateway parameter will not be mapped.\n
     * @return value
     */
    public String value { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Aaaa' => 'aaaa'
    };

    // public static zc_GatewayOption getExample() {
    //     zc_GatewayOption gatewayOption = new zc_GatewayOption();
    //     gatewayOption.name = 'aeiou';
    //     gatewayOption.value = 'aeiou';
    //     return gatewayOption;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_GatewayOption) {
            zc_GatewayOption gatewayOption = (zc_GatewayOption) obj;
            return this.name == gatewayOption.name
                && this.value == gatewayOption.value;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (name == null ? 0 : System.hashCode(name));
        hashCode = (17 * hashCode) + (value == null ? 0 : System.hashCode(value));
        return hashCode;
    }
}