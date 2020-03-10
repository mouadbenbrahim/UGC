public class zc_AmendmentRatePlanData implements zc_Zuc.MappedProperties {
    /**
     * Get ratePlan
     * @return ratePlan
     */
    public zc_RatePlan ratePlan { get; set; }

    /**
     * 
     * @return ratePlanChargeData
     */
    public List<zc_RatePlanChargeDataInRatePlanData> ratePlanChargeData { get; set; }

    /**
     * Get subscriptionProductFeatureList
     * @return subscriptionProductFeatureList
     */
    public zc_SubscriptionProductFeatureList subscriptionProductFeatureList { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'RatePlan' => 'ratePlan',
        'RatePlanChargeData' => 'ratePlanChargeData',
        'SubscriptionProductFeatureList' => 'subscriptionProductFeatureList'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public zc_AmendmentRatePlanData() {
        ratePlanChargeData = new List<zc_RatePlanChargeDataInRatePlanData>();
    }

    // public static zc_AmendmentRatePlanData getExample() {
    //     zc_AmendmentRatePlanData amendmentRatePlanData = new zc_AmendmentRatePlanData();
    //     amendmentRatePlanData.ratePlan = zc_RatePlan.getExample();
    //     amendmentRatePlanData.ratePlanChargeData = new List<zc_RatePlanChargeDataInRatePlanData>{zc_RatePlanChargeDataInRatePlanData.getExample()};
    //     amendmentRatePlanData.subscriptionProductFeatureList = zc_SubscriptionProductFeatureList.getExample();
    //     return amendmentRatePlanData;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_AmendmentRatePlanData) {
            zc_AmendmentRatePlanData amendmentRatePlanData = (zc_AmendmentRatePlanData) obj;
            return this.ratePlan == amendmentRatePlanData.ratePlan
                && this.ratePlanChargeData == amendmentRatePlanData.ratePlanChargeData
                && this.subscriptionProductFeatureList == amendmentRatePlanData.subscriptionProductFeatureList;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (ratePlan == null ? 0 : System.hashCode(ratePlan));
        hashCode = (17 * hashCode) + (ratePlanChargeData == null ? 0 : System.hashCode(ratePlanChargeData));
        hashCode = (17 * hashCode) + (subscriptionProductFeatureList == null ? 0 : System.hashCode(subscriptionProductFeatureList));
        return hashCode;
    }
}