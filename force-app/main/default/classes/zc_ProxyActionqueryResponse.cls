/**
 * zc_ProxyActionqueryResponse
 */
public class zc_ProxyActionqueryResponse {
    /**
     * 
     * @return done
     */
    public Boolean done { get; set; }

    /**
     * 
     * @return queryLocator
     */
    public String queryLocator { get; set; }

    /**
     * 
     * @return records
     */
    public List<zc_GETSubscriptionTypeWithSuccess> records { get; set; }

    /**
     * 
     * @return size
     */
    public Integer size { get; set; }

    public zc_ProxyActionqueryResponse() {
        records = new List<zc_GETSubscriptionTypeWithSuccess>{new zc_GETSubscriptionTypeWithSuccess()};
    }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Aaa' => 'aaa',
        'Bbb' => 'bbb'
    }; 

    // public static zc_ProxyActionqueryResponse getExample() {
    //     zc_ProxyActionqueryResponse proxyActionqueryResponse = new zc_ProxyActionqueryResponse();
    //     proxyActionqueryResponse.done = true;
    //     proxyActionqueryResponse.queryLocator = 'aeiou';
    //     proxyActionqueryResponse.records = new List<zc_ZObject>{zc_ZObject.getExample()};
    //     proxyActionqueryResponse.size = 123;
    //     return proxyActionqueryResponse;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_ProxyActionqueryResponse) {
            zc_ProxyActionqueryResponse proxyActionqueryResponse = (zc_ProxyActionqueryResponse) obj;
            return this.done == proxyActionqueryResponse.done
                && this.queryLocator == proxyActionqueryResponse.queryLocator
                && this.records == proxyActionqueryResponse.records
                && this.size == proxyActionqueryResponse.size;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (done == null ? 0 : System.hashCode(done));
        hashCode = (17 * hashCode) + (queryLocator == null ? 0 : System.hashCode(queryLocator));
        hashCode = (17 * hashCode) + (records == null ? 0 : System.hashCode(records));
        hashCode = (17 * hashCode) + (size == null ? 0 : System.hashCode(size));
        return hashCode;
    }
}