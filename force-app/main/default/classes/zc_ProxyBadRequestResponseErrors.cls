/**
 * zc_ProxyBadRequestResponseErrors
 */
public class zc_ProxyBadRequestResponseErrors {
    /**
     * 
     * @return code
     */
    public String code { get; set; }

    /**
     * 
     * @return message
     */
    public String message { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Code' => 'code',
        'Message' => 'message'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    // public static zc_ProxyBadRequestResponseErrors getExample() {
    //     zc_ProxyBadRequestResponseErrors proxyBadRequestResponseErrors = new zc_ProxyBadRequestResponseErrors();
    //     proxyBadRequestResponseErrors.code = 'aeiou';
    //     proxyBadRequestResponseErrors.message = 'aeiou';
    //     return proxyBadRequestResponseErrors;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_ProxyBadRequestResponseErrors) {
            zc_ProxyBadRequestResponseErrors proxyBadRequestResponseErrors = (zc_ProxyBadRequestResponseErrors) obj;
            return this.code == proxyBadRequestResponseErrors.code
                && this.message == proxyBadRequestResponseErrors.message;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (code == null ? 0 : System.hashCode(code));
        hashCode = (17 * hashCode) + (message == null ? 0 : System.hashCode(message));
        return hashCode;
    }
}