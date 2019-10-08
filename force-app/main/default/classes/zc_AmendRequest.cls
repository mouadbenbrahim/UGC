public class zc_AmendRequest implements zc_Zuc.MappedProperties {
    /**
     * Get amendOptions
     * @return amendOptions
     */
    public zc_AmendRequestAmendOptions amendOptions { get; set; }

    /**
     * The `Amendment` object holds the changes that you want to make to the Subscription specified by the `SubscriptionId`, \nincluding its `RatePlan`, `RatePlanCharge`, and `RatePlanChargeTier`.\n
     * @return amendments
     */
    public List<zc_Amendment> amendments { get; set; }

    /**
     * Get previewOptions
     * @return previewOptions
     */
    public zc_AmendRequestPreviewOptions previewOptions { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'AmendOptions' => 'amendOptions',
        'Amendments' => 'amendments',
        'PreviewOptions' => 'previewOptions'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public zc_AmendRequest() {
        amendments = new List<zc_Amendment>();
    }

    // public static zc_AmendRequest getExample() {
    //     zc_AmendRequest amendRequest = new zc_AmendRequest();
    //     amendRequest.amendOptions = zc_AmendRequestAmendOptions.getExample();
    //     amendRequest.amendments = new List<zc_Amendment>{zc_Amendment.getExample()};
    //     amendRequest.previewOptions = zc_AmendRequestPreviewOptions.getExample();
    //     return amendRequest;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_AmendRequest) {
            zc_AmendRequest amendRequest = (zc_AmendRequest) obj;
            return this.amendOptions == amendRequest.amendOptions
                && this.amendments == amendRequest.amendments
                && this.previewOptions == amendRequest.previewOptions;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (amendOptions == null ? 0 : System.hashCode(amendOptions));
        hashCode = (17 * hashCode) + (amendments == null ? 0 : System.hashCode(amendments));
        hashCode = (17 * hashCode) + (previewOptions == null ? 0 : System.hashCode(previewOptions));
        return hashCode;
    }
}