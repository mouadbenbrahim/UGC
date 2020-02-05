/**
 * zc_ProxyBadRequestResponse
 */
public class zc_ProxyBadRequestResponse {
    /**
     * Get errors
     * @return errors
     */
    public List<zc_ProxyBadRequestResponseErrors> errors { get; set; }

    /**
     * 
     * @return success
     */
    public Boolean success { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Errors' => 'errors',
        'Success' => 'success'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public zc_ProxyBadRequestResponse() {
        errors = new List<zc_ProxyBadRequestResponseErrors>{new zc_ProxyBadRequestResponseErrors()};
    }

    // public static zc_ProxyBadRequestResponse getExample() {
    //     zc_ProxyBadRequestResponse proxyBadRequestResponse = new zc_ProxyBadRequestResponse();
    //     proxyBadRequestResponse.errors = new List<zc_ProxyBadRequestResponseErrors>{zc_ProxyBadRequestResponseErrors.getExample()};
    //     proxyBadRequestResponse.success = true;
    //     return proxyBadRequestResponse;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_ProxyBadRequestResponse) {
            zc_ProxyBadRequestResponse proxyBadRequestResponse = (zc_ProxyBadRequestResponse) obj;
            return this.errors == proxyBadRequestResponse.errors
                && this.success == proxyBadRequestResponse.success;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (errors == null ? 0 : System.hashCode(errors));
        hashCode = (17 * hashCode) + (success == null ? 0 : System.hashCode(success));
        return hashCode;
    }
}