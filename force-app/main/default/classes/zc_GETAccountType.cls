/**
 * zc_GETAccountType
 */
public class zc_GETAccountType {
    /**
     * Get basicInfo
     * @return basicInfo
     */
    public zc_GETAccountTypeBasicInfo basicInfo { get; set; }

    /**
     * Get billToContact
     * @return billToContact
     */
    public zc_GETAccountTypeBillToContact billToContact { get; set; }

    /**
     * Get billingAndPayment
     * @return billingAndPayment
     */
    public zc_GETAccountTypeBillingAndPayment billingAndPayment { get; set; }

    /**
     * Get metrics
     * @return metrics
     */
    public zc_GETAccountTypeMetrics metrics { get; set; }

    /**
     * Get soldToContact
     * @return soldToContact
     */
    public zc_GETAccountTypeSoldToContact soldToContact { get; set; }

    /**
     * Returns `true` if the request was processed successfully.\n
     * @return success
     */
    public Boolean success { get; set; }

    public zc_GETAccountType(){
        this.basicInfo = new zc_GETAccountTypeBasicInfo();
        this.billingAndPayment = new zc_GETAccountTypeBillingAndPayment();
        this.billToContact = new zc_GETAccountTypeBillToContact();
        this.metrics = new zc_GETAccountTypeMetrics();
        this.soldToContact = new zc_GETAccountTypeSoldToContact();
    }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Aaaa' => 'aaa',
        'Bbbb' => 'bbb'
    };

    

    /**
     * Get taxInfo
     * @return taxInfo
     */
    // MBEN public zc_GETAccountSummaryTypeTaxInfo taxInfo { get; set; }

    // public static zc_GETAccountType getExample() {
    //     zc_GETAccountType geTAccountType = new zc_GETAccountType();
    //     geTAccountType.basicInfo = zc_GETAccountTypeBasicInfo.getExample();
    //     geTAccountType.billToContact = zc_GETAccountTypeBillToContact.getExample();
    //     geTAccountType.billingAndPayment = zc_GETAccountTypeBillingAndPayment.getExample();
    //     geTAccountType.metrics = zc_GETAccountTypeMetrics.getExample();
    //     geTAccountType.soldToContact = zc_GETAccountTypeSoldToContact.getExample();
    //     geTAccountType.success = true;
    //     // MBEN  geTAccountType.taxInfo = zc_GETAccountSummaryTypeTaxInfo.getExample();
    //     return geTAccountType;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_GETAccountType) {
            zc_GETAccountType geTAccountType = (zc_GETAccountType) obj;
            return this.basicInfo == geTAccountType.basicInfo
                && this.billToContact == geTAccountType.billToContact
                && this.billingAndPayment == geTAccountType.billingAndPayment
                && this.metrics == geTAccountType.metrics
                && this.soldToContact == geTAccountType.soldToContact
                && this.success == geTAccountType.success
                // MBEN  && this.taxInfo == geTAccountType.taxInfo
                ;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (basicInfo == null ? 0 : System.hashCode(basicInfo));
        hashCode = (17 * hashCode) + (billToContact == null ? 0 : System.hashCode(billToContact));
        hashCode = (17 * hashCode) + (billingAndPayment == null ? 0 : System.hashCode(billingAndPayment));
        hashCode = (17 * hashCode) + (metrics == null ? 0 : System.hashCode(metrics));
        hashCode = (17 * hashCode) + (soldToContact == null ? 0 : System.hashCode(soldToContact));
        hashCode = (17 * hashCode) + (success == null ? 0 : System.hashCode(success));
        // MBEN hashCode = (17 * hashCode) + (taxInfo == null ? 0 : System.hashCode(taxInfo))
        return hashCode;
    }
}