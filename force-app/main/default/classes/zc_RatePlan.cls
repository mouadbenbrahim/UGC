public class zc_RatePlan implements zc_Zuc.MappedProperties {
    /**
     *  The ID of the amendment associated with the rate plan. This field only applies to amendment rate plans.\n\n\n**Character limit**: 32\n\n**Values**: a valid amendment ID 
     * @return amendmentId
     */
    public String amendmentId { get; set; }

    /**
     * The ID of the subscription rate plan modified by the amendment. This field only applies to amendment rate plans.\n\n**Character limit**: 32\n\n**Values**: a valid rate plan ID 
     * @return amendmentSubscriptionRatePlanId
     */
    public String amendmentSubscriptionRatePlanId { get; set; }

    /**
     * The type of amendment associated with the rate plan. This field only applies to amendment rate plans.\n\n**Character limit**: 18\n\n**Values**: inherited from `Amendment.Type` 
     * @return amendmentType
     */
    public String amendmentType { get; set; }

    /**
     * The ID of the Zuora user who created the RatePlan object.\n\n**Character limit**: 32\n\n**Values**: automatically generated 
     * @return createdById
     */
    public String createdById { get; set; }

    /**
     * The date when the `RatePlan` object was last updated.\n\n**Character limit**: 29\n\n**Values**: automatically generated 
     * @return createdDate
     */
    public Datetime createdDate { get; set; }

    /**
     * The name of the rate plan. Leave this null in a subscribe call to inherited the `ProductRatePlan.Name` field value.\n\n**Character limit**: 100\n\n**Values**: a string of 100 characters or fewer or inherited from ProductRatePlan.Name 
     * @return name
     */
    public String name { get; set; }

    /**
     * The ID of the associated product rate plan.\n\n**Character limit**: 32\n\n**Values**: a valid product rate plan ID 
     * @return productRatePlanId
     */
    public String productRatePlanId { get; set; }

    /**
     * The ID of the subscription that the rate plan belongs to.\n\n**Character limit**: 32\n\n**Values**: a valid subscription ID 
     * @return subscriptionId
     */
    public String subscriptionId { get; set; }

    /**
     *  The ID of the user who last updated the rate plan.\n\n\n**Character limit**: 32\n\n**Values**: automatically generated 
     * @return updatedById
     */
    public String updatedById { get; set; }

    /**
     *  The date when the rate plan was last updated.\n\n\n**Character limit**: 29\n\n**Values**: automatically generated 
     * @return updatedDate
     */
    public Datetime updatedDate { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'AmendmentId' => 'amendmentId',
        'AmendmentSubscriptionRatePlanId' => 'amendmentSubscriptionRatePlanId',
        'AmendmentType' => 'amendmentType',
        'CreatedById' => 'createdById',
        'CreatedDate' => 'createdDate',
        'Name' => 'name',
        'ProductRatePlanId' => 'productRatePlanId',
        'SubscriptionId' => 'subscriptionId',
        'UpdatedById' => 'updatedById',
        'UpdatedDate' => 'updatedDate'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public static zc_RatePlan getExample() {
        zc_RatePlan ratePlan = new zc_RatePlan();
        ratePlan.amendmentId = 'aeiou';
        ratePlan.amendmentSubscriptionRatePlanId = 'aeiou';
        ratePlan.amendmentType = 'aeiou';
        ratePlan.createdById = 'aeiou';
        ratePlan.createdDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
        ratePlan.name = 'aeiou';
        ratePlan.productRatePlanId = 'aeiou';
        ratePlan.subscriptionId = 'aeiou';
        ratePlan.updatedById = 'aeiou';
        ratePlan.updatedDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
        return ratePlan;
    }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_RatePlan) {
            zc_RatePlan ratePlan = (zc_RatePlan) obj;
            return this.amendmentId == ratePlan.amendmentId
                && this.amendmentSubscriptionRatePlanId == ratePlan.amendmentSubscriptionRatePlanId
                && this.amendmentType == ratePlan.amendmentType
                && this.createdById == ratePlan.createdById
                && this.createdDate == ratePlan.createdDate
                && this.name == ratePlan.name
                && this.productRatePlanId == ratePlan.productRatePlanId
                && this.subscriptionId == ratePlan.subscriptionId
                && this.updatedById == ratePlan.updatedById
                && this.updatedDate == ratePlan.updatedDate;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (amendmentId == null ? 0 : System.hashCode(amendmentId));
        hashCode = (17 * hashCode) + (amendmentSubscriptionRatePlanId == null ? 0 : System.hashCode(amendmentSubscriptionRatePlanId));
        hashCode = (17 * hashCode) + (amendmentType == null ? 0 : System.hashCode(amendmentType));
        hashCode = (17 * hashCode) + (createdById == null ? 0 : System.hashCode(createdById));
        hashCode = (17 * hashCode) + (createdDate == null ? 0 : System.hashCode(createdDate));
        hashCode = (17 * hashCode) + (name == null ? 0 : System.hashCode(name));
        hashCode = (17 * hashCode) + (productRatePlanId == null ? 0 : System.hashCode(productRatePlanId));
        hashCode = (17 * hashCode) + (subscriptionId == null ? 0 : System.hashCode(subscriptionId));
        hashCode = (17 * hashCode) + (updatedById == null ? 0 : System.hashCode(updatedById));
        hashCode = (17 * hashCode) + (updatedDate == null ? 0 : System.hashCode(updatedDate));
        return hashCode;
    }
}