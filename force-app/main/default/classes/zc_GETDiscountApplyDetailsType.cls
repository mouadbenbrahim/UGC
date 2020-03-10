/**
 * zc_GETDiscountApplyDetailsType
 */
public class zc_GETDiscountApplyDetailsType {
    /**
     * The ID of the product rate plan charge that the discount rate plan charge applies to.\n
     * @return appliedProductRatePlanChargeId
     */
    public String appliedProductRatePlanChargeId { get; set; }

    /**
     * The ID of the product rate plan that the discount rate plan charge applies to.\n
     * @return appliedProductRatePlanId
     */
    public String appliedProductRatePlanId { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Aaa' => 'aaa',
        'Bbb' => 'bbb'
    };
    
    // public static zc_GETDiscountApplyDetailsType getExample() {
    //     zc_GETDiscountApplyDetailsType geTDiscountApplyDetailsType = new zc_GETDiscountApplyDetailsType();
    //     geTDiscountApplyDetailsType.appliedProductRatePlanChargeId = 'aeiou';
    //     geTDiscountApplyDetailsType.appliedProductRatePlanId = 'aeiou';
    //     return geTDiscountApplyDetailsType;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_GETDiscountApplyDetailsType) {
            zc_GETDiscountApplyDetailsType geTDiscountApplyDetailsType = (zc_GETDiscountApplyDetailsType) obj;
            return this.appliedProductRatePlanChargeId == geTDiscountApplyDetailsType.appliedProductRatePlanChargeId
                && this.appliedProductRatePlanId == geTDiscountApplyDetailsType.appliedProductRatePlanId;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (appliedProductRatePlanChargeId == null ? 0 : System.hashCode(appliedProductRatePlanChargeId));
        hashCode = (17 * hashCode) + (appliedProductRatePlanId == null ? 0 : System.hashCode(appliedProductRatePlanId));
        return hashCode;
    }
}