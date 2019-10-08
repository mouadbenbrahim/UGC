public class zc_ProxyActionamendRequest {
    /**
     * The value of this field must be an array that contains a single AmendRequest object. To specify multiple Amendment objects, use the `Amendments` field of the AmendRequest object.\n
     * @return requests
     */
    public List<zc_AmendRequest> requests { get; set; }

    public zc_ProxyActionamendRequest() {
        requests = new List<zc_AmendRequest>();
    }

    // public static zc_ProxyActionamendRequest getExample() {
    //     zc_ProxyActionamendRequest proxyActionamendRequest = new zc_ProxyActionamendRequest();
    //     proxyActionamendRequest.requests = new List<zc_AmendRequest>{zc_AmendRequest.getExample()};
    //     return proxyActionamendRequest;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_ProxyActionamendRequest) {
            zc_ProxyActionamendRequest proxyActionamendRequest = (zc_ProxyActionamendRequest) obj;
            return this.requests == proxyActionamendRequest.requests;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (requests == null ? 0 : System.hashCode(requests));
        return hashCode;
    }
}