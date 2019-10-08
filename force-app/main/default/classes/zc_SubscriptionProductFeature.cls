public class zc_SubscriptionProductFeature implements zc_Zuc.MappedProperties {
//public class zc_SubscriptionProductFeature implements zc_SubscriptionProductFeatureObject, zc_Zuc.MappedProperties {
    /**
     * 
     * @return createdById
     */
    public String createdById { get; set; }

    /**
     *  Date and time when the product feature was added to the subscription.\n\n\n**Character limit**: 29\n\n\n**Values**: 
     * @return createdDate
     */
    public Datetime createdDate { get; set; }

    /**
     *  Description of the subscription product feature.\n\n\n**Character limit**: 500\n\n\n**Values**: 
     * @return description
     */
    public String description { get; set; }

    /**
     *  Unique code of the feature.\n\n\n**Character limit**: 255\n\n\n**Values**: 
     * @return featureCode
     */
    public String featureCode { get; set; }

    /**
     *  Internal Zuora ID of the feature.\n\n\n**Character limit**: 32\n\n\n**Values**: 
     * @return featureId
     */
    public String featureId { get; set; }

    /**
     *  Name of the feature.\n\n\n**Character limit**: 255\n\n\n**Values**: 
     * @return name
     */
    public String name { get; set; }

    /**
     *  Id of the product rate plan to which the feature belongs.\n\n\n**Character limit**: 32\n\n\n**Values**: 
     * @return ratePlanId
     */
    public String ratePlanId { get; set; }

    /**
     *  Internal Zuora ID of the user who last updated the subscription product feature.\n\n\n**Character limit**: 32\n\n\n**Values**: 
     * @return updatedById
     */
    public String updatedById { get; set; }

    /**
     *  Date and time when the subscription product feature was last updated.\n\n\n**Character limit**: 29\n\n\n**Values**: 
     * @return updatedDate
     */
    public Datetime updatedDate { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'CreatedById' => 'createdById',
        'CreatedDate' => 'createdDate',
        'Description' => 'description',
        'FeatureCode' => 'featureCode',
        'FeatureId' => 'featureId',
        'Name' => 'name',
        'RatePlanId' => 'ratePlanId',
        'UpdatedById' => 'updatedById',
        'UpdatedDate' => 'updatedDate'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public static zc_SubscriptionProductFeature getExample() {
        zc_SubscriptionProductFeature subscriptionProductFeature = new zc_SubscriptionProductFeature();
        subscriptionProductFeature.createdById = 'aeiou';
        subscriptionProductFeature.createdDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
        subscriptionProductFeature.description = 'aeiou';
        subscriptionProductFeature.featureCode = 'aeiou';
        subscriptionProductFeature.featureId = 'aeiou';
        subscriptionProductFeature.name = 'aeiou';
        subscriptionProductFeature.ratePlanId = 'aeiou';
        subscriptionProductFeature.updatedById = 'aeiou';
        subscriptionProductFeature.updatedDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
        return subscriptionProductFeature;
    }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_SubscriptionProductFeature) {
            zc_SubscriptionProductFeature subscriptionProductFeature = (zc_SubscriptionProductFeature) obj;
            return this.createdById == subscriptionProductFeature.createdById
                && this.createdDate == subscriptionProductFeature.createdDate
                && this.description == subscriptionProductFeature.description
                && this.featureCode == subscriptionProductFeature.featureCode
                && this.featureId == subscriptionProductFeature.featureId
                && this.name == subscriptionProductFeature.name
                && this.ratePlanId == subscriptionProductFeature.ratePlanId
                && this.updatedById == subscriptionProductFeature.updatedById
                && this.updatedDate == subscriptionProductFeature.updatedDate;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (createdById == null ? 0 : System.hashCode(createdById));
        hashCode = (17 * hashCode) + (createdDate == null ? 0 : System.hashCode(createdDate));
        hashCode = (17 * hashCode) + (description == null ? 0 : System.hashCode(description));
        hashCode = (17 * hashCode) + (featureCode == null ? 0 : System.hashCode(featureCode));
        hashCode = (17 * hashCode) + (featureId == null ? 0 : System.hashCode(featureId));
        hashCode = (17 * hashCode) + (name == null ? 0 : System.hashCode(name));
        hashCode = (17 * hashCode) + (ratePlanId == null ? 0 : System.hashCode(ratePlanId));
        hashCode = (17 * hashCode) + (updatedById == null ? 0 : System.hashCode(updatedById));
        hashCode = (17 * hashCode) + (updatedDate == null ? 0 : System.hashCode(updatedDate));
        return hashCode;
    }
}