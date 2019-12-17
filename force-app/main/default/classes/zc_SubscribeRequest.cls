/**
 * zc_SubscribeRequest
 */
public class zc_SubscribeRequest {
    /**
     * Get account
     * @return account
     */
    public zc_SubscribeRequestAccount account { get; set; }

    /**
     * Get billToContact
     * @return billToContact
     */
    //public zc_SubscribeRequestBillToContact billToContact { get; set; }

    // /**
    //  * Get paymentMethod
    //  * @return paymentMethod
    //  */
    // public zc_SubscribeRequestPaymentMethod paymentMethod { get; set; }

    // /**
    //  * Get previewOptions
    //  * @return previewOptions
    //  */
    // public zc_SubscribeRequestPreviewOptions previewOptions { get; set; }

    // /**
    //  * Get soldToContact
    //  * @return soldToContact
    //  */
    // public zc_SubscribeRequestSoldToContact soldToContact { get; set; }

    // /**
    //  * Get subscribeOptions
    //  * @return subscribeOptions
    //  */
    public zc_SubscribeRequestSubscribeOptions subscribeOptions { get; set; }

    // /**
    //  * Get subscriptionData
    //  * @return subscriptionData
    //  */
    public zc_SubscribeRequestSubscriptionData subscriptionData { get; set; }

    // MBEN add
    // public zc_SubscribeRequest(){
    //     account = new zc_SubscribeRequestAccount();
    // }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Account' => 'account',
        'BillToContact' => 'billToContact',
        'PaymentMethod' => 'paymentMethod',
        'PreviewOptions' => 'previewOptions',
        'SoldToContact' => 'soldToContact',
        'SubscribeOptions' => 'subscribeOptions',
        'SubscriptionData' => 'subscriptionData',
        'Aaaa' => 'vaTaaaId'
    };

    // public Map<String, String> getPropertyMappings() {
    //     return propertyMappings;
    // }

    // public static zc_SubscribeRequest getExample() {
    //     zc_SubscribeRequest subscribeRequest = new zc_SubscribeRequest();
    //     subscribeRequest.account = zc_SubscribeRequestAccount.getExample();
    //     subscribeRequest.billToContact = zc_SubscribeRequestBillToContact.getExample();
    //     subscribeRequest.paymentMethod = zc_SubscribeRequestPaymentMethod.getExample();
    //     subscribeRequest.previewOptions = zc_SubscribeRequestPreviewOptions.getExample();
    //     subscribeRequest.soldToContact = zc_SubscribeRequestSoldToContact.getExample();
    //     subscribeRequest.subscribeOptions = zc_SubscribeRequestSubscribeOptions.getExample();
    //     subscribeRequest.subscriptionData = zc_SubscribeRequestSubscriptionData.getExample();
    //     return subscribeRequest;
    // }

    // public Boolean equals(Object obj) {
    //     if (obj instanceof zc_SubscribeRequest) {
    //         zc_SubscribeRequest subscribeRequest = (zc_SubscribeRequest) obj;
    //         return this.account == subscribeRequest.account
    //             && this.billToContact == subscribeRequest.billToContact
    //             && this.paymentMethod == subscribeRequest.paymentMethod
    //             && this.previewOptions == subscribeRequest.previewOptions
    //             && this.soldToContact == subscribeRequest.soldToContact
    //             && this.subscribeOptions == subscribeRequest.subscribeOptions
    //             && this.subscriptionData == subscribeRequest.subscriptionData;
    //     }
    //     return false;
    // }

    // public Integer hashCode() {
    //     Integer hashCode = 43;
    //     hashCode = (17 * hashCode) + (account == null ? 0 : System.hashCode(account));
    //     hashCode = (17 * hashCode) + (billToContact == null ? 0 : System.hashCode(billToContact));
    //     hashCode = (17 * hashCode) + (paymentMethod == null ? 0 : System.hashCode(paymentMethod));
    //     hashCode = (17 * hashCode) + (previewOptions == null ? 0 : System.hashCode(previewOptions));
    //     hashCode = (17 * hashCode) + (soldToContact == null ? 0 : System.hashCode(soldToContact));
    //     hashCode = (17 * hashCode) + (subscribeOptions == null ? 0 : System.hashCode(subscribeOptions));
    //     hashCode = (17 * hashCode) + (subscriptionData == null ? 0 : System.hashCode(subscriptionData));
    //     return hashCode;
    // }
}