/**
 * zc_GETTierType
 */
public class zc_GETTierType {
    /**
     * Decimal defining end of tier range.\n
     * @return endingUnit
     */
    public String endingUnit { get; set; }

    /**
     * The decimal value of the tiered charge model. If the charge model is not a tiered type then this price field will be null and the `price` field directly under the `productRatePlanCharges` applies.\n
     * @return price
     */
    public String price { get; set; }

    /**
     * Tier price format. Allowed values: `flat fee`, `per unit`.\n
     * @return priceFormat
     */
    public String priceFormat { get; set; }

    /**
     * Decimal defining start of tier range.\n
     * @return startingUnit
     */
    public String startingUnit { get; set; }

    /**
     * Unique number of the tier.\n
     * @return tier
     */
    public Long tier { get; set; }
    
    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Aaa' => 'aaa',
        'Bbb' => 'bbb'
    };    

    // public static zc_GETTierType getExample() {
    //     zc_GETTierType geTTierType = new zc_GETTierType();
    //     geTTierType.endingUnit = 'aeiou';
    //     geTTierType.price = 'aeiou';
    //     geTTierType.priceFormat = 'aeiou';
    //     geTTierType.startingUnit = 'aeiou';
    //     geTTierType.tier = 123456789L;
    //     return geTTierType;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_GETTierType) {
            zc_GETTierType geTTierType = (zc_GETTierType) obj;
            return this.endingUnit == geTTierType.endingUnit
                && this.price == geTTierType.price
                && this.priceFormat == geTTierType.priceFormat
                && this.startingUnit == geTTierType.startingUnit
                && this.tier == geTTierType.tier;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (endingUnit == null ? 0 : System.hashCode(endingUnit));
        hashCode = (17 * hashCode) + (price == null ? 0 : System.hashCode(price));
        hashCode = (17 * hashCode) + (priceFormat == null ? 0 : System.hashCode(priceFormat));
        hashCode = (17 * hashCode) + (startingUnit == null ? 0 : System.hashCode(startingUnit));
        hashCode = (17 * hashCode) + (tier == null ? 0 : System.hashCode(tier));
        return hashCode;
    }
}