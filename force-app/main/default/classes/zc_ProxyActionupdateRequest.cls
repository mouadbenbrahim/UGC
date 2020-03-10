/**
 * zc_ProxyActionupdateRequest
 */
public class zc_ProxyActionupdateRequest implements zc_Zuc.MappedProperties {
    /**
     * 
     * @return objects
     */
    public List<zc_ZObjectUpdate> objects { get; set; }

    /**
     * 
     * @return r_type
     */
    public String r_type { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'type' => 'r_type'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public zc_ProxyActionupdateRequest() {
        objects = new List<zc_ZObjectUpdate>();
    }

    // public static zc_ProxyActionupdateRequest getExample() {
    //     zc_ProxyActionupdateRequest proxyActionupdateRequest = new zc_ProxyActionupdateRequest();
    //     proxyActionupdateRequest.objects = new List<zc_ZObjectUpdate>{zc_ZObjectUpdate.getExample()};
    //     proxyActionupdateRequest.r_type = 'aeiou';
    //     return proxyActionupdateRequest;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_ProxyActionupdateRequest) {
            zc_ProxyActionupdateRequest proxyActionupdateRequest = (zc_ProxyActionupdateRequest) obj;
            return this.objects == proxyActionupdateRequest.objects
                && this.r_type == proxyActionupdateRequest.r_type;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (objects == null ? 0 : System.hashCode(objects));
        hashCode = (17 * hashCode) + (r_type == null ? 0 : System.hashCode(r_type));
        return hashCode;
    }
}