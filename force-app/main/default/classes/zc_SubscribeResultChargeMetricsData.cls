/**
 * 
 */
public class zc_SubscribeResultChargeMetricsData {
    /**
     * 
     * @return chargeMetrics
     */
    public List<zc_NewChargeMetrics> chargeMetrics { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'ChargeMetrics' => 'chargeMetrics'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public zc_SubscribeResultChargeMetricsData() {
        chargeMetrics = new List<zc_NewChargeMetrics>{new zc_NewChargeMetrics()};
    }

    // public static zc_SubscribeResultChargeMetricsData getExample() {
    //     zc_SubscribeResultChargeMetricsData subscribeResultChargeMetricsData = new zc_SubscribeResultChargeMetricsData();
    //     subscribeResultChargeMetricsData.chargeMetrics = new List<zc_NewChargeMetrics>{zc_NewChargeMetrics.getExample()};
    //     return subscribeResultChargeMetricsData;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_SubscribeResultChargeMetricsData) {
            zc_SubscribeResultChargeMetricsData subscribeResultChargeMetricsData = (zc_SubscribeResultChargeMetricsData) obj;
            return this.chargeMetrics == subscribeResultChargeMetricsData.chargeMetrics;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (chargeMetrics == null ? 0 : System.hashCode(chargeMetrics));
        return hashCode;
    }
}