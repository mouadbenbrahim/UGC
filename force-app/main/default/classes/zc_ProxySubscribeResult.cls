public class zc_ProxySubscribeResult {
    public List<zc_SubscribeResult> results { get; set; }
    
    public zc_ProxySubscribeResult() {
        results = new List<zc_SubscribeResult>{new zc_SubscribeResult()};
    }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'results' => 'results'
    };
}