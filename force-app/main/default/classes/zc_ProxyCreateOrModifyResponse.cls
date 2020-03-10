/**
 * zc_ProxyCreateOrModifyResponse
 */
public class zc_ProxyCreateOrModifyResponse {
    /**
     * 
     * @return id
     */
    public String id { get; set; }

    /**
     * 
     * @return success
     */
    public Boolean success { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Id' => 'id',
        'Success' => 'success'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    // public static zc_ProxyCreateOrModifyResponse getExample() {
    //     zc_ProxyCreateOrModifyResponse proxyCreateOrModifyResponse = new zc_ProxyCreateOrModifyResponse();
    //     proxyCreateOrModifyResponse.id = 'aeiou';
    //     proxyCreateOrModifyResponse.success = true;
    //     return proxyCreateOrModifyResponse;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_ProxyCreateOrModifyResponse) {
            zc_ProxyCreateOrModifyResponse proxyCreateOrModifyResponse = (zc_ProxyCreateOrModifyResponse) obj;
            return this.id == proxyCreateOrModifyResponse.id
                && this.success == proxyCreateOrModifyResponse.success;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
        hashCode = (17 * hashCode) + (success == null ? 0 : System.hashCode(success));
        return hashCode;
    }
}