public with sharing class zc_ProxySaveResult {
    
    public List<zc_SaveResult> results { get; set; }
    
    public zc_ProxySaveResult() {
        results = new List<zc_SaveResult>{new zc_SaveResult()};
    }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'results' => 'results'
    };

}