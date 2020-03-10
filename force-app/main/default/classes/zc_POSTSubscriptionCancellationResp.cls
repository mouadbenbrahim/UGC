/**
 * zc_POSTSubscriptionCancellationResp
 */
public class zc_POSTSubscriptionCancellationResp {
    /**
     * The date that the subscription was canceled.\n
     * @return cancelledDate
     */
    public Date cancelledDate { get; set; }

    /**
     * The credit memo ID, if a credit memo is generated during the subscription process.\n\n**Note:** This field is only available if you have the Invoice Settlements feature enabled.\n
     * @return creditMemoId
     */
    public String creditMemoId { get; set; }

    /**
     * ID of the invoice, if one is generated.\n
     * @return invoiceId
     */
    public String invoiceId { get; set; }

    /**
     * Amount paid.\n
     * @return paidAmount
     */
    public String paidAmount { get; set; }

    /**
     * ID of the payment, if a payment is collected.\n
     * @return paymentId
     */
    public String paymentId { get; set; }

    /**
     * The subscription ID.\n
     * @return subscriptionId
     */
    public String subscriptionId { get; set; }

    /**
     * Returns `true` if the request was processed successfully.\n
     * @return success
     */
    public Boolean success { get; set; }

    /**
     * Change in the subscription monthly recurring revenue as a result of the update.\n
     * @return totalDeltaMrr
     */
    public String totalDeltaMrr { get; set; }

    /**
     * Change in the total contracted value of the subscription as a result of the update.\n
     * @return totalDeltaTcv
     */
    public String totalDeltaTcv { get; set; }


    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Aaaa' => 'aaaa'
    };

    // public static zc_POSTSubscriptionCancellationResp getExample() {
    //     zc_POSTSubscriptionCancellationResp poSTSubscriptionCancellationResponseType = new zc_POSTSubscriptionCancellationResp();
    //     poSTSubscriptionCancellationResponseType.cancelledDate = Date.newInstance(2000, 1, 23);
    //     poSTSubscriptionCancellationResponseType.creditMemoId = 'aeiou';
    //     poSTSubscriptionCancellationResponseType.invoiceId = 'aeiou';
    //     poSTSubscriptionCancellationResponseType.paidAmount = 'aeiou';
    //     poSTSubscriptionCancellationResponseType.paymentId = 'aeiou';
    //     poSTSubscriptionCancellationResponseType.subscriptionId = 'aeiou';
    //     poSTSubscriptionCancellationResponseType.success = true;
    //     poSTSubscriptionCancellationResponseType.totalDeltaMrr = 'aeiou';
    //     poSTSubscriptionCancellationResponseType.totalDeltaTcv = 'aeiou';
    //     return poSTSubscriptionCancellationResponseType;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_POSTSubscriptionCancellationResp) {
            zc_POSTSubscriptionCancellationResp poSTSubscriptionCancellationResponseType = (zc_POSTSubscriptionCancellationResp) obj;
            return this.cancelledDate == poSTSubscriptionCancellationResponseType.cancelledDate
                && this.creditMemoId == poSTSubscriptionCancellationResponseType.creditMemoId
                && this.invoiceId == poSTSubscriptionCancellationResponseType.invoiceId
                && this.paidAmount == poSTSubscriptionCancellationResponseType.paidAmount
                && this.paymentId == poSTSubscriptionCancellationResponseType.paymentId
                && this.subscriptionId == poSTSubscriptionCancellationResponseType.subscriptionId
                && this.success == poSTSubscriptionCancellationResponseType.success
                && this.totalDeltaMrr == poSTSubscriptionCancellationResponseType.totalDeltaMrr
                && this.totalDeltaTcv == poSTSubscriptionCancellationResponseType.totalDeltaTcv;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (cancelledDate == null ? 0 : System.hashCode(cancelledDate));
        hashCode = (17 * hashCode) + (creditMemoId == null ? 0 : System.hashCode(creditMemoId));
        hashCode = (17 * hashCode) + (invoiceId == null ? 0 : System.hashCode(invoiceId));
        hashCode = (17 * hashCode) + (paidAmount == null ? 0 : System.hashCode(paidAmount));
        hashCode = (17 * hashCode) + (paymentId == null ? 0 : System.hashCode(paymentId));
        hashCode = (17 * hashCode) + (subscriptionId == null ? 0 : System.hashCode(subscriptionId));
        hashCode = (17 * hashCode) + (success == null ? 0 : System.hashCode(success));
        hashCode = (17 * hashCode) + (totalDeltaMrr == null ? 0 : System.hashCode(totalDeltaMrr));
        hashCode = (17 * hashCode) + (totalDeltaTcv == null ? 0 : System.hashCode(totalDeltaTcv));
        return hashCode;
    }
}