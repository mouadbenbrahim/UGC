/**
 * zc_GETAccountSummarySubscriptionRat
 */
public class zc_GETAccountSummarySubscriptionRat {
    /**
     * Product ID.\n
     * @return productId
     */
    public String productId { get; set; }

    /**
     * Product name.\n
     * @return productName
     */
    public String productName { get; set; }

    /**
     * Product Rate Plan ID.\n
     * @return productRatePlanId
     */
    public String productRatePlanId { get; set; }

    /**
     * 
     * @return productSku
     */
    public String productSku { get; set; }

    /**
     * Rate plan name.\n
     * @return ratePlanName
     */
    public String ratePlanName { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Aaaa' => 'aaaa',
        'Baaa' => 'bbbb'   
    };
    
    // public static zc_GETAccountSummarySubscriptionRat getExample() {
    //     zc_GETAccountSummarySubscriptionRat geTAccountSummarySubscriptionRatePlanType = new zc_GETAccountSummarySubscriptionRat();
    //     geTAccountSummarySubscriptionRatePlanType.productId = 'aeiou';
    //     geTAccountSummarySubscriptionRatePlanType.productName = 'aeiou';
    //     geTAccountSummarySubscriptionRatePlanType.productRatePlanId = 'aeiou';
    //     geTAccountSummarySubscriptionRatePlanType.productSku = 'aeiou';
    //     geTAccountSummarySubscriptionRatePlanType.ratePlanName = 'aeiou';
    //     return geTAccountSummarySubscriptionRatePlanType;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_GETAccountSummarySubscriptionRat) {
            zc_GETAccountSummarySubscriptionRat geTAccountSummarySubscriptionRatePlanType = (zc_GETAccountSummarySubscriptionRat) obj;
            return this.productId == geTAccountSummarySubscriptionRatePlanType.productId
                && this.productName == geTAccountSummarySubscriptionRatePlanType.productName
                && this.productRatePlanId == geTAccountSummarySubscriptionRatePlanType.productRatePlanId
                && this.productSku == geTAccountSummarySubscriptionRatePlanType.productSku
                && this.ratePlanName == geTAccountSummarySubscriptionRatePlanType.ratePlanName;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (productId == null ? 0 : System.hashCode(productId));
        hashCode = (17 * hashCode) + (productName == null ? 0 : System.hashCode(productName));
        hashCode = (17 * hashCode) + (productRatePlanId == null ? 0 : System.hashCode(productRatePlanId));
        hashCode = (17 * hashCode) + (productSku == null ? 0 : System.hashCode(productSku));
        hashCode = (17 * hashCode) + (ratePlanName == null ? 0 : System.hashCode(ratePlanName));
        return hashCode;
    }
}