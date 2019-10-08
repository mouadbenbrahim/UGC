public class zc_SubscriptionProductFeatureList implements zc_Zuc.MappedProperties {
    /**
     * 
     * @return subscriptionProductFeature
     */
    public List<zc_SubscriptionProductFeature> subscriptionProductFeature { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'SubscriptionProductFeature' => 'subscriptionProductFeature'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public zc_SubscriptionProductFeatureList() {
        subscriptionProductFeature = new List<zc_SubscriptionProductFeature>();
    }

    public static zc_SubscriptionProductFeatureList getExample() {
        zc_SubscriptionProductFeatureList subscriptionProductFeatureList = new zc_SubscriptionProductFeatureList();
        subscriptionProductFeatureList.subscriptionProductFeature = new List<zc_SubscriptionProductFeature>{zc_SubscriptionProductFeature.getExample()};
        return subscriptionProductFeatureList;
    }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_SubscriptionProductFeatureList) {
            zc_SubscriptionProductFeatureList subscriptionProductFeatureList = (zc_SubscriptionProductFeatureList) obj;
            return this.subscriptionProductFeature == subscriptionProductFeatureList.subscriptionProductFeature;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (subscriptionProductFeature == null ? 0 : System.hashCode(subscriptionProductFeature));
        return hashCode;
    }
}