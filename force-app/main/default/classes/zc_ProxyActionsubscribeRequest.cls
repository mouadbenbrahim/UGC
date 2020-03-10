/**
 * zc_ProxyActionsubscribeRequest
 */
public class zc_ProxyActionsubscribeRequest {
    /**
     * 
     * @return subscribes
     */
    public List<zc_SubscribeRequest> subscribes { get; set; }

    public zc_ProxyActionsubscribeRequest() {
        //subscribes = new List<zc_SubscribeRequest>();
        subscribes = new List<zc_SubscribeRequest>();
    }


    // private final Map<String, String> propertyMappings = new Map<String, String>{
    //     'Aaaa' => 'aaa',
    //     'Bbbb' => 'bbb'
    // };

    // public static zc_ProxyActionsubscribeRequest getExample() {
    //     zc_ProxyActionsubscribeRequest proxyActionsubscribeRequest = new zc_ProxyActionsubscribeRequest();
    //     proxyActionsubscribeRequest.subscribes = new List<zc_SubscribeRequest>{zc_SubscribeRequest.getExample()};
    //     return proxyActionsubscribeRequest;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_ProxyActionsubscribeRequest) {
            zc_ProxyActionsubscribeRequest proxyActionsubscribeRequest = (zc_ProxyActionsubscribeRequest) obj;
            return this.subscribes == proxyActionsubscribeRequest.subscribes;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (subscribes == null ? 0 : System.hashCode(subscribes));
        return hashCode;
    }
}