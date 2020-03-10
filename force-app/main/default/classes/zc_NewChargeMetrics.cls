public class zc_NewChargeMetrics implements zc_Zuc.MappedProperties {
    /**
     * 
     * @return chargeNumber
     */
    public String chargeNumber { get; set; }

    /**
     * 
     * @return DMRR
     */
    public Double DMRR { get; set; }

    /**
     * 
     * @return DTCV
     */
    public Double DTCV { get; set; }

    /**
     * 
     * @return MRR
     */
    public Double MRR { get; set; }

    /**
     * 
     * @return originalId
     */
    public String originalId { get; set; }

    /**
     * 
     * @return originalRatePlanId
     */
    public String originalRatePlanId { get; set; }

    /**
     * 
     * @return productRatePlanChargeId
     */
    public String productRatePlanChargeId { get; set; }

    /**
     * 
     * @return productRatePlanId
     */
    public String productRatePlanId { get; set; }

    /**
     * 
     * @return TCV
     */
    public Double TCV { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'ChargeNumber' => 'chargeNumber',
        'OriginalId' => 'originalId',
        'OriginalRatePlanId' => 'originalRatePlanId',
        'ProductRatePlanChargeId' => 'productRatePlanChargeId',
        'ProductRatePlanId' => 'productRatePlanId'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public static zc_NewChargeMetrics getExample() {
        zc_NewChargeMetrics newChargeMetrics = new zc_NewChargeMetrics();
        newChargeMetrics.chargeNumber = 'aeiou';
        newChargeMetrics.DMRR = 1.3579;
        newChargeMetrics.DTCV = 1.3579;
        newChargeMetrics.MRR = 1.3579;
        newChargeMetrics.originalId = 'aeiou';
        newChargeMetrics.originalRatePlanId = 'aeiou';
        newChargeMetrics.productRatePlanChargeId = 'aeiou';
        newChargeMetrics.productRatePlanId = 'aeiou';
        newChargeMetrics.TCV = 1.3579;
        return newChargeMetrics;
    }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_NewChargeMetrics) {
            zc_NewChargeMetrics newChargeMetrics = (zc_NewChargeMetrics) obj;
            return this.chargeNumber == newChargeMetrics.chargeNumber
                && this.DMRR == newChargeMetrics.DMRR
                && this.DTCV == newChargeMetrics.DTCV
                && this.MRR == newChargeMetrics.MRR
                && this.originalId == newChargeMetrics.originalId
                && this.originalRatePlanId == newChargeMetrics.originalRatePlanId
                && this.productRatePlanChargeId == newChargeMetrics.productRatePlanChargeId
                && this.productRatePlanId == newChargeMetrics.productRatePlanId
                && this.TCV == newChargeMetrics.TCV;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (chargeNumber == null ? 0 : System.hashCode(chargeNumber));
        hashCode = (17 * hashCode) + (DMRR == null ? 0 : System.hashCode(DMRR));
        hashCode = (17 * hashCode) + (DTCV == null ? 0 : System.hashCode(DTCV));
        hashCode = (17 * hashCode) + (MRR == null ? 0 : System.hashCode(MRR));
        hashCode = (17 * hashCode) + (originalId == null ? 0 : System.hashCode(originalId));
        hashCode = (17 * hashCode) + (originalRatePlanId == null ? 0 : System.hashCode(originalRatePlanId));
        hashCode = (17 * hashCode) + (productRatePlanChargeId == null ? 0 : System.hashCode(productRatePlanChargeId));
        hashCode = (17 * hashCode) + (productRatePlanId == null ? 0 : System.hashCode(productRatePlanId));
        hashCode = (17 * hashCode) + (TCV == null ? 0 : System.hashCode(TCV));
        return hashCode;
    }
}