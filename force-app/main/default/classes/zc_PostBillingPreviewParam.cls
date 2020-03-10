/**
 * zc_PostBillingPreviewParam
 */
public class zc_PostBillingPreviewParam {
    /**
     * ID of the customer account to which the billing preview applies.\n
     * @return accountId
     */
    public String accountId { get; set; }

    /**
     * Indicates whether to generate a preview of future invoice items and credit memo items with the assumption that the subscriptions are renewed.\n\nSet one of the following values in this field to decide how the assumption is applied in the billing preview.\n\n  * **All:** The assumption is applied to all the subscriptions. Zuora generates preview invoice item data and credit memo item data from the first day of the customer\'s next billing period to the target date.\n  \n  * **None:** (Default) The assumption is not applied to the subscriptions. Zuora generates preview invoice item data and credit memo item data based on the current term end date and the target date.\n  \n    * If the target date is later than the current term end date, Zuora generates preview invoice item data and credit memo item data from the first day of the customer\'s next billing period to the current term end date.\n\n    * If the target date is earlier than the current term end date, Zuora generates preview invoice item data and credit memo item data from the first day of the customer\'s next billing period to the target date.\n\n  * **Autorenew:** The assumption is applied to the subscriptions that have auto-renew enabled. Zuora generates preview invoice item data and credit memo item data from the first day of the customer\'s next billing period to the target date.\n\n**Note:** \n  - This field can only be used if the subscription renewal term is not set to 0.  \n  \n  \n  - The credit memo item data is only available if you have Invoice Settlement feature enabled. The Invoice Settlement feature is in **Limited Availability**. If you wish to have access to the feature, submit a request at [Zuora Global Support](http://support.zuora.com/).\n
     * @return assumeRenewal
     */
    public String assumeRenewal { get; set; }

    /**
     * The charge types to exclude from the billing preview.\n\n**Possible values:** OneTime, Recurring, Usage, and any combination of these values.\n
     * @return chargeTypeToExclude
     */
    public String chargeTypeToExclude { get; set; }

    /**
     * Indicates if evergreen subscriptions are included in the billingPreview call.\n
     * @return includingEvergreenSubscription
     */
    public Boolean includingEvergreenSubscription { get; set; }

    /**
     * The target date for the billingPreview call. The billingPreview call generates preview invoice item data and credit memo item data from the first day of the customer\'s next billing period to the TargetDate. \n\nIf the TargetDate is later than the subscription current term end date, the preview invoice item data and credit memo item data is generated from the first day of the customer\'s next billing period to the current term end date. If you want to generate preview invoice item data and credit memo item data past the end of the subscription current term, specify the `AssumeRenewal` field in the request.\n\n\n**Note:** The credit memo item data is only available if you have Invoice Settlement feature enabled. The Invoice Settlement feature is in **Limited Availability**. If you wish to have access to the feature, submit a request at [Zuora Global Support](http://support.zuora.com/).\n
     * @return targetDate
     */
    public Date targetDate { get; set; }

    // public static zc_PostBillingPreviewParam getExample() {
    //     zc_PostBillingPreviewParam postBillingPreviewParam = new zc_PostBillingPreviewParam();
    //     postBillingPreviewParam.accountId = 'aeiou';
    //     postBillingPreviewParam.assumeRenewal = 'aeiou';
    //     postBillingPreviewParam.chargeTypeToExclude = 'aeiou';
    //     postBillingPreviewParam.includingEvergreenSubscription = true;
    //     postBillingPreviewParam.targetDate = Date.newInstance(2000, 1, 23);
    //     return postBillingPreviewParam;
    // }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Abb' => 'abb'
    };

    public Boolean equals(Object obj) {
        if (obj instanceof zc_PostBillingPreviewParam) {
            zc_PostBillingPreviewParam postBillingPreviewParam = (zc_PostBillingPreviewParam) obj;
            return this.accountId == postBillingPreviewParam.accountId
                && this.assumeRenewal == postBillingPreviewParam.assumeRenewal
                && this.chargeTypeToExclude == postBillingPreviewParam.chargeTypeToExclude
                && this.includingEvergreenSubscription == postBillingPreviewParam.includingEvergreenSubscription
                && this.targetDate == postBillingPreviewParam.targetDate;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (accountId == null ? 0 : System.hashCode(accountId));
        hashCode = (17 * hashCode) + (assumeRenewal == null ? 0 : System.hashCode(assumeRenewal));
        hashCode = (17 * hashCode) + (chargeTypeToExclude == null ? 0 : System.hashCode(chargeTypeToExclude));
        hashCode = (17 * hashCode) + (includingEvergreenSubscription == null ? 0 : System.hashCode(includingEvergreenSubscription));
        hashCode = (17 * hashCode) + (targetDate == null ? 0 : System.hashCode(targetDate));
        return hashCode;
    }
}