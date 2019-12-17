/**
 * zc_ProxyActionqueryRequest
 */
public class zc_ProxyActionqueryRequest {
    /**
     * Get conf
     * @return conf
     */
    public zc_ProxyActionqueryRequestConf conf { get; set; }

    /**
     * [ZOQL](https://knowledgecenter.zuora.com/DC_Developers/K_Zuora_Object_Query_Language) expression that specifies the object to query, the fields to retrieve, and any filters.\n\n**Note:** When querying one time charges from ProductRatePlanCharge, you need to specify the `ChargeType` value as `One-Time` rather than `OneTime`.\n
     * @return queryString
     */
    public String queryString { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Aaa' => 'aaa',
        'Bbb' => 'bbb'
    };   
    
    // public static zc_ProxyActionqueryRequest getExample() {
    //     zc_ProxyActionqueryRequest proxyActionqueryRequest = new zc_ProxyActionqueryRequest();
    //     proxyActionqueryRequest.conf = zc_ProxyActionqueryRequestConf.getExample();
    //     proxyActionqueryRequest.queryString = 'aeiou';
    //     return proxyActionqueryRequest;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_ProxyActionqueryRequest) {
            zc_ProxyActionqueryRequest proxyActionqueryRequest = (zc_ProxyActionqueryRequest) obj;
            return this.conf == proxyActionqueryRequest.conf
                && this.queryString == proxyActionqueryRequest.queryString;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (conf == null ? 0 : System.hashCode(conf));
        hashCode = (17 * hashCode) + (queryString == null ? 0 : System.hashCode(queryString));
        return hashCode;
    }
}