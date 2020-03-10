/**
 * zc_ProxyDeleteResponse
 */
public class zc_ProxyDeleteResponse {
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
        'Aaaa' => 'aaaa'
    };

    
    // public static zc_ProxyDeleteResponse getExample() {
    //     zc_ProxyDeleteResponse proxyDeleteResponse = new zc_ProxyDeleteResponse();
    //     proxyDeleteResponse.id = 'aeiou';
    //     proxyDeleteResponse.success = true;
    //     return proxyDeleteResponse;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_ProxyDeleteResponse) {
            zc_ProxyDeleteResponse proxyDeleteResponse = (zc_ProxyDeleteResponse) obj;
            return this.id == proxyDeleteResponse.id
                && this.success == proxyDeleteResponse.success;
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