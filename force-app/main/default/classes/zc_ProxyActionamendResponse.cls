public class zc_ProxyActionamendResponse {
    /**
     * 
     * @return results
     */
    public List<zc_AmendResult> results { get; set; }

    public zc_ProxyActionamendResponse() {
        results = new List<zc_AmendResult>{new zc_AmendResult()};
    }

    public static zc_ProxyActionamendResponse getExample() {
        zc_ProxyActionamendResponse proxyActionamendResponse = new zc_ProxyActionamendResponse();
        proxyActionamendResponse.results = new List<zc_AmendResult>{zc_AmendResult.getExample()};
        return proxyActionamendResponse;
    }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_ProxyActionamendResponse) {
            zc_ProxyActionamendResponse proxyActionamendResponse = (zc_ProxyActionamendResponse) obj;
            return this.results == proxyActionamendResponse.results;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (results == null ? 0 : System.hashCode(results));
        return hashCode;
    }
}