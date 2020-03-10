/**
 * 
 */
public class zc_ProxyActionqueryRequestConf {
    /**
     * Defines the batch size of the query result. The range is 1 - 2000 (inclusive). If a value higher than 2000 is submitted, only 2000 results are returned.\n
     * @return batchSize
     */
    public Integer batchSize { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Aaa' => 'aaa',
        'Bbb' => 'bbb'
    };   
    
    // public static zc_ProxyActionqueryRequestConf getExample() {
    //     zc_ProxyActionqueryRequestConf proxyActionqueryRequestConf = new zc_ProxyActionqueryRequestConf();
    //     proxyActionqueryRequestConf.batchSize = 123;
    //     return proxyActionqueryRequestConf;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_ProxyActionqueryRequestConf) {
            zc_ProxyActionqueryRequestConf proxyActionqueryRequestConf = (zc_ProxyActionqueryRequestConf) obj;
            return this.batchSize == proxyActionqueryRequestConf.batchSize;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (batchSize == null ? 0 : System.hashCode(batchSize));
        return hashCode;
    }
}