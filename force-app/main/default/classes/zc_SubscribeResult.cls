/**
 * zc_SubscribeResult
 */
public class zc_SubscribeResult {
    /**
     * 
     * @return accountId
     */
    public String accountId { get; set; }

    /**
     * 
     * @return accountNumber
     */
    public String accountNumber { get; set; }

    /**
     * Get chargeMetricsData
     * @return chargeMetricsData
     */
    public zc_SubscribeResultChargeMetricsData chargeMetricsData { get; set; }

    /**
     * 
     * @return errors
     */
    public List<zc_ActionsErrorResponse> errors { get; set; }

    /**
     * 
     * @return gatewayResponse
     */
    public String gatewayResponse { get; set; }

    /**
     * 
     * @return gatewayResponseCode
     */
    public String gatewayResponseCode { get; set; }

    /**
     * 
     * @return invoiceData
     */
    public List<zc_InvoiceData> invoiceData { get; set; }

    /**
     * 
     * @return invoiceId
     */
    public String invoiceId { get; set; }

    /**
     * 
     * @return invoiceNumber
     */
    public String invoiceNumber { get; set; }

    /**
     * Get invoiceResult
     * @return invoiceResult
     */
    public zc_SubscribeResultInvoiceResult invoiceResult { get; set; }

    /**
     * 
     * @return paymentId
     */
    public String paymentId { get; set; }

    /**
     * 
     * @return paymentTransactionNumber
     */
    public String paymentTransactionNumber { get; set; }

    /**
     * 
     * @return subscriptionId
     */
    public String subscriptionId { get; set; }

    /**
     * 
     * @return subscriptionNumber
     */
    public String subscriptionNumber { get; set; }

    /**
     * 
     * @return success
     */
    public Boolean success { get; set; }

    /**
     * 
     * @return totalMrr
     */
    public Double totalMrr { get; set; }

    /**
     * 
     * @return totalTcv
     */
    public Double totalTcv { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'AccountId' => 'accountId',
        'AccountNumber' => 'accountNumber',
        'ChargeMetricsData' => 'chargeMetricsData',
        'Errors' => 'errors',
        'GatewayResponse' => 'gatewayResponse',
        'GatewayResponseCode' => 'gatewayResponseCode',
        'InvoiceData' => 'invoiceData',
        'InvoiceId' => 'invoiceId',
        'InvoiceNumber' => 'invoiceNumber',
        'InvoiceResult' => 'invoiceResult',
        'PaymentId' => 'paymentId',
        'PaymentTransactionNumber' => 'paymentTransactionNumber',
        'SubscriptionId' => 'subscriptionId',
        'SubscriptionNumber' => 'subscriptionNumber',
        'Success' => 'success',
        'TotalMrr' => 'totalMrr',
        'TotalTcv' => 'totalTcv'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public zc_SubscribeResult() {
        errors = new List<zc_ActionsErrorResponse>{new zc_ActionsErrorResponse()};
        invoiceData = new List<zc_InvoiceData>{new zc_InvoiceData()};
        invoiceResult = new zc_SubscribeResultInvoiceResult(); 
    }

    // public static zc_SubscribeResult getExample() {
    //     zc_SubscribeResult subscribeResult = new zc_SubscribeResult();
    //     subscribeResult.accountId = 'aeiou';
    //     subscribeResult.accountNumber = 'aeiou';
    //     subscribeResult.chargeMetricsData = zc_SubscribeResultChargeMetricsData.getExample();
    //     subscribeResult.errors = new List<zc_ActionsErrorResponse>{zc_ActionsErrorResponse.getExample()};
    //     subscribeResult.gatewayResponse = 'aeiou';
    //     subscribeResult.gatewayResponseCode = 'aeiou';
    //     subscribeResult.invoiceData = new List<zc_InvoiceData>{zc_InvoiceData.getExample()};
    //     subscribeResult.invoiceId = 'aeiou';
    //     subscribeResult.invoiceNumber = 'aeiou';
    //     subscribeResult.invoiceResult = zc_SubscribeResultInvoiceResult.getExample();
    //     subscribeResult.paymentId = 'aeiou';
    //     subscribeResult.paymentTransactionNumber = 'aeiou';
    //     subscribeResult.subscriptionId = 'aeiou';
    //     subscribeResult.subscriptionNumber = 'aeiou';
    //     subscribeResult.success = true;
    //     subscribeResult.totalMrr = 1.3579;
    //     subscribeResult.totalTcv = 1.3579;
    //     return subscribeResult;
    // }

    // public Boolean equals(Object obj) {
    //     if (obj instanceof zc_SubscribeResult) {
    //         zc_SubscribeResult subscribeResult = (zc_SubscribeResult) obj;
    //         return this.accountId == subscribeResult.accountId
    //             && this.accountNumber == subscribeResult.accountNumber
    //             && this.chargeMetricsData == subscribeResult.chargeMetricsData
    //             && this.errors == subscribeResult.errors
    //             && this.gatewayResponse == subscribeResult.gatewayResponse
    //             && this.gatewayResponseCode == subscribeResult.gatewayResponseCode
    //             && this.invoiceData == subscribeResult.invoiceData
    //             && this.invoiceId == subscribeResult.invoiceId
    //             && this.invoiceNumber == subscribeResult.invoiceNumber
    //             && this.invoiceResult == subscribeResult.invoiceResult
    //             && this.paymentId == subscribeResult.paymentId
    //             && this.paymentTransactionNumber == subscribeResult.paymentTransactionNumber
    //             && this.subscriptionId == subscribeResult.subscriptionId
    //             && this.subscriptionNumber == subscribeResult.subscriptionNumber
    //             && this.success == subscribeResult.success
    //             && this.totalMrr == subscribeResult.totalMrr
    //             && this.totalTcv == subscribeResult.totalTcv;
    //     }
    //     return false;
    // }

    // public Integer hashCode() {
    //     Integer hashCode = 43;
    //     hashCode = (17 * hashCode) + (accountId == null ? 0 : System.hashCode(accountId));
    //     hashCode = (17 * hashCode) + (accountNumber == null ? 0 : System.hashCode(accountNumber));
    //     hashCode = (17 * hashCode) + (chargeMetricsData == null ? 0 : System.hashCode(chargeMetricsData));
    //     hashCode = (17 * hashCode) + (errors == null ? 0 : System.hashCode(errors));
    //     hashCode = (17 * hashCode) + (gatewayResponse == null ? 0 : System.hashCode(gatewayResponse));
    //     hashCode = (17 * hashCode) + (gatewayResponseCode == null ? 0 : System.hashCode(gatewayResponseCode));
    //     hashCode = (17 * hashCode) + (invoiceData == null ? 0 : System.hashCode(invoiceData));
    //     hashCode = (17 * hashCode) + (invoiceId == null ? 0 : System.hashCode(invoiceId));
    //     hashCode = (17 * hashCode) + (invoiceNumber == null ? 0 : System.hashCode(invoiceNumber));
    //     hashCode = (17 * hashCode) + (invoiceResult == null ? 0 : System.hashCode(invoiceResult));
    //     hashCode = (17 * hashCode) + (paymentId == null ? 0 : System.hashCode(paymentId));
    //     hashCode = (17 * hashCode) + (paymentTransactionNumber == null ? 0 : System.hashCode(paymentTransactionNumber));
    //     hashCode = (17 * hashCode) + (subscriptionId == null ? 0 : System.hashCode(subscriptionId));
    //     hashCode = (17 * hashCode) + (subscriptionNumber == null ? 0 : System.hashCode(subscriptionNumber));
    //     hashCode = (17 * hashCode) + (success == null ? 0 : System.hashCode(success));
    //     hashCode = (17 * hashCode) + (totalMrr == null ? 0 : System.hashCode(totalMrr));
    //     hashCode = (17 * hashCode) + (totalTcv == null ? 0 : System.hashCode(totalTcv));
    //     return hashCode;
    // }
}