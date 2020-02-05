/**
 * zc_GETAccountSummaryType
 */
 // !!! MBEN: CLASS NON UTILISE POUR LE MOMENT
public class zc_GETAccountSummaryType {
    /**
     * Get basicInfo
     * @return basicInfo
     */
    public zc_GETAccountSummaryTypeBasicInfo basicInfo { get; set; }

    /**
     * Get billToContact
     * @return billToContact
     */
    public zc_GETAccountSummaryTypeBillToConta billToContact { get; set; }

    /**
     * Container for invoices. Only returns the last 6 invoices.\n
     * @return invoices
     */
    public List<zc_GETAccountSummaryInvoiceType> invoices { get; set; }

    /**
     * Container for payments. Only returns the last 6 payments.\n
     * @return payments
     */
    public List<zc_GETAccountSummaryPaymentType> payments { get; set; }

    /**
     * Get soldToContact
     * @return soldToContact
     */
    public zc_GETAccountSummaryTypeSoldToConta soldToContact { get; set; }

    /**
     * Container for subscriptions.\n
     * @return subscriptions
     */
    public List<zc_GETAccountSummarySubscriptionTyp> subscriptions { get; set; }

    /**
     * Returns `true` if the request was processed successfully.\n
     * @return success
     */
    public Boolean success { get; set; }

    /**
     * Get taxInfo
     * @return taxInfo
     */
    public zc_GETAccountSummaryTypeTaxInfo taxInfo { get; set; }

    /**
     * Container for usage data. Only returns the last 6 months of usage.\n\n**Note:** If the [Active Rating](https://knowledgecenter.zuora.com/CB_Billing/J_Billing_Operations/H_Active_Rating) feature is enabled, no usage data is returned in the response body field. To retrive usage data information, you can use the [Usage (with Active Rating)](https://www.zuora.com/developer/active-rating-api/#tag/Usage-(with-Active-Rating)) operations.\n
     * @return usage
     */
    // MBEN public List<zc_GETAccountSummaryUsageType> usage { get; set; }

    public zc_GETAccountSummaryType() {
        basicInfo = new zc_GETAccountSummaryTypeBasicInfo();
        billToContact = new zc_GETAccountSummaryTypeBillToConta();
        soldToContact = new zc_GETAccountSummaryTypeSoldToConta(); 
        invoices = new List<zc_GETAccountSummaryInvoiceType>{new zc_GETAccountSummaryInvoiceType()};
        payments = new List<zc_GETAccountSummaryPaymentType>{new zc_GETAccountSummaryPaymentType()};
        subscriptions = new List<zc_GETAccountSummarySubscriptionTyp>{new zc_GETAccountSummarySubscriptionTyp()};
        taxInfo = new zc_GETAccountSummaryTypeTaxInfo();
        // usage = new List<zc_GETAccountSummaryUsageType>();
    }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Aaaa' => 'aaaa',
        'Baaa' => 'bbbb'   
    };


    // public static zc_GETAccountSummaryType getExample() {
    //     zc_GETAccountSummaryType geTAccountSummaryType = new zc_GETAccountSummaryType();
    //     geTAccountSummaryType.basicInfo = zc_GETAccountSummaryTypeBasicInfo.getExample();
    //     geTAccountSummaryType.billToContact = zc_GETAccountSummaryTypeBillToConta.getExample();
    //     geTAccountSummaryType.invoices = new List<zc_GETAccountSummaryInvoiceType>{zc_GETAccountSummaryInvoiceType.getExample()};
    //     geTAccountSummaryType.payments = new List<zc_GETAccountSummaryPaymentType>{zc_GETAccountSummaryPaymentType.getExample()};
    //     geTAccountSummaryType.soldToContact = zc_GETAccountSummaryTypeSoldToConta.getExample();
    //     geTAccountSummaryType.subscriptions = new List<zc_GETAccountSummarySubscriptionTyp>{zc_GETAccountSummarySubscriptionTyp.getExample()};
    //     geTAccountSummaryType.success = true;
    //     geTAccountSummaryType.taxInfo = zc_GETAccountSummaryTypeTaxInfo.getExample();
    //     geTAccountSummaryType.usage = new List<zc_GETAccountSummaryUsageType>{zc_GETAccountSummaryUsageType.getExample()};
    //     return geTAccountSummaryType;
    // }

    // public Boolean equals(Object obj) {
    //     if (obj instanceof zc_GETAccountSummaryType) {
    //         zc_GETAccountSummaryType geTAccountSummaryType = (zc_GETAccountSummaryType) obj;
    //         return this.basicInfo == geTAccountSummaryType.basicInfo
    //             && this.billToContact == geTAccountSummaryType.billToContact
    //             && this.invoices == geTAccountSummaryType.invoices
    //             && this.payments == geTAccountSummaryType.payments
    //             && this.soldToContact == geTAccountSummaryType.soldToContact
    //             && this.subscriptions == geTAccountSummaryType.subscriptions
    //             && this.success == geTAccountSummaryType.success
    //             && this.taxInfo == geTAccountSummaryType.taxInfo
    //             && this.usage == geTAccountSummaryType.usage;
    //     }
    //     return false;
    // }

    // public Integer hashCode() {
    //     Integer hashCode = 43;
    //     hashCode = (17 * hashCode) + (basicInfo == null ? 0 : System.hashCode(basicInfo));
    //     hashCode = (17 * hashCode) + (billToContact == null ? 0 : System.hashCode(billToContact));
    //     hashCode = (17 * hashCode) + (invoices == null ? 0 : System.hashCode(invoices));
    //     hashCode = (17 * hashCode) + (payments == null ? 0 : System.hashCode(payments));
    //     hashCode = (17 * hashCode) + (soldToContact == null ? 0 : System.hashCode(soldToContact));
    //     hashCode = (17 * hashCode) + (subscriptions == null ? 0 : System.hashCode(subscriptions));
    //     hashCode = (17 * hashCode) + (success == null ? 0 : System.hashCode(success));
    //     hashCode = (17 * hashCode) + (taxInfo == null ? 0 : System.hashCode(taxInfo));
    //     hashCode = (17 * hashCode) + (usage == null ? 0 : System.hashCode(usage));
    //     return hashCode;
    // }
}