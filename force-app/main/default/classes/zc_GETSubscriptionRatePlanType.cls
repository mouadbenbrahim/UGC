/**
 * zc_GETSubscriptionRatePlanType
 */
public class zc_GETSubscriptionRatePlanType {
    /**
     * Rate plan ID.\n
     * @return id
     */
    public String id { get; set; }

    /**
     * The last amendment on the rate plan.\n\nPossible Values:\n\n* `Add`\n* `Update`\n* `Remove`\n
     * @return lastChangeType
     */
    public String lastChangeType { get; set; }

    /**
     * 
     * @return productId
     */
    public String productId { get; set; }

    /**
     * 
     * @return productName
     */
    public String productName { get; set; }

    /**
     * 
     * @return productRatePlanId
     */
    public String productRatePlanId { get; set; }

    /**
     * The unique SKU for the product.\n
     * @return productSku
     */
    public String productSku { get; set; }

    /**
     * Container for one or more charges.\n
     * @return ratePlanCharges
     */
    public List<zc_GETSubscriptionRatePlanChargesTy> ratePlanCharges { get; set; }

    /**
     * Name of the rate plan.\n
     * @return ratePlanName
     */
    public String ratePlanName { get; set; }

    /**
     * Container for one or more features. \n\nOnly available when the following settings are enabled:\n\n* The Entitlements feature in your tenant.\n\n* The Enable Feature Specification in Product and Subscriptions setting in Zuora Billing Settings
     * @return subscriptionProductFeatures
     */
    // mben public List<zc_GETSubscriptionProductFeatureTyp> subscriptionProductFeatures { get; set; }

    public zc_GETSubscriptionRatePlanType() {
        ratePlanCharges = new List<zc_GETSubscriptionRatePlanChargesTy>{new zc_GETSubscriptionRatePlanChargesTy()};
        // mben subscriptionProductFeatures = new List<zc_GETSubscriptionProductFeatureTyp>();
    }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Aaa' => 'aaa',
        'Bbb' => 'bbb'
    };
    // public static zc_GETSubscriptionRatePlanType getExample() {
    //     zc_GETSubscriptionRatePlanType geTSubscriptionRatePlanType = new zc_GETSubscriptionRatePlanType();
    //     geTSubscriptionRatePlanType.id = 'aeiou';
    //     geTSubscriptionRatePlanType.lastChangeType = 'aeiou';
    //     geTSubscriptionRatePlanType.productId = 'aeiou';
    //     geTSubscriptionRatePlanType.productName = 'aeiou';
    //     geTSubscriptionRatePlanType.productRatePlanId = 'aeiou';
    //     geTSubscriptionRatePlanType.productSku = 'aeiou';
    //     geTSubscriptionRatePlanType.ratePlanCharges = new List<zc_GETSubscriptionRatePlanChargesTy>{zc_GETSubscriptionRatePlanChargesTy.getExample()};
    //     geTSubscriptionRatePlanType.ratePlanName = 'aeiou';
    //     geTSubscriptionRatePlanType.subscriptionProductFeatures = new List<zc_GETSubscriptionProductFeatureTyp>{zc_GETSubscriptionProductFeatureTyp.getExample()};
    //     return geTSubscriptionRatePlanType;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_GETSubscriptionRatePlanType) {
            zc_GETSubscriptionRatePlanType geTSubscriptionRatePlanType = (zc_GETSubscriptionRatePlanType) obj;
            return this.id == geTSubscriptionRatePlanType.id
                && this.lastChangeType == geTSubscriptionRatePlanType.lastChangeType
                && this.productId == geTSubscriptionRatePlanType.productId
                && this.productName == geTSubscriptionRatePlanType.productName
                && this.productRatePlanId == geTSubscriptionRatePlanType.productRatePlanId
                && this.productSku == geTSubscriptionRatePlanType.productSku
                && this.ratePlanCharges == geTSubscriptionRatePlanType.ratePlanCharges
                && this.ratePlanName == geTSubscriptionRatePlanType.ratePlanName;
                // && this.subscriptionProductFeatures == geTSubscriptionRatePlanType.subscriptionProductFeatures;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
        hashCode = (17 * hashCode) + (lastChangeType == null ? 0 : System.hashCode(lastChangeType));
        hashCode = (17 * hashCode) + (productId == null ? 0 : System.hashCode(productId));
        hashCode = (17 * hashCode) + (productName == null ? 0 : System.hashCode(productName));
        hashCode = (17 * hashCode) + (productRatePlanId == null ? 0 : System.hashCode(productRatePlanId));
        hashCode = (17 * hashCode) + (productSku == null ? 0 : System.hashCode(productSku));
        hashCode = (17 * hashCode) + (ratePlanCharges == null ? 0 : System.hashCode(ratePlanCharges));
        hashCode = (17 * hashCode) + (ratePlanName == null ? 0 : System.hashCode(ratePlanName));
        //hashCode = (17 * hashCode) + (subscriptionProductFeatures == null ? 0 : System.hashCode(subscriptionProductFeatures));
        return hashCode;
    }
}