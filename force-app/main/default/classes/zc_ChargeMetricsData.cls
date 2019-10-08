public class zc_ChargeMetricsData implements zc_Zuc.MappedProperties {
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

    public zc_ChargeMetricsData() {
        chargeMetrics = new List<zc_NewChargeMetrics>();
    }

    public static zc_ChargeMetricsData getExample() {
        zc_ChargeMetricsData chargeMetricsData = new zc_ChargeMetricsData();
        chargeMetricsData.chargeMetrics = new List<zc_NewChargeMetrics>{zc_NewChargeMetrics.getExample()};
        return chargeMetricsData;
    }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_ChargeMetricsData) {
            zc_ChargeMetricsData chargeMetricsData = (zc_ChargeMetricsData) obj;
            return this.chargeMetrics == chargeMetricsData.chargeMetrics;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (chargeMetrics == null ? 0 : System.hashCode(chargeMetrics));
        return hashCode;
    }
}