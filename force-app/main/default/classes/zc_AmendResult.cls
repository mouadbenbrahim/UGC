public class zc_AmendResult implements zc_Zuc.MappedProperties {
    /**
     * A list of the IDs of the associated amendments. There can be as many as three amendment IDs. Use a comma to separate each amendment ID.\n
     * @return amendmentIds
     */
    public List<String> amendmentIds { get; set; }

    /**
     * Get chargeMetricsData
     * @return chargeMetricsData
     */
    public zc_ChargeMetricsData chargeMetricsData { get; set; }

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
     * @return invoiceDatas
     */
    public List<zc_InvoiceData> invoiceDatas { get; set; }

    /**
     * 
     * @return invoiceId
     */
    public String invoiceId { get; set; }

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
     * @return success
     */
    public Boolean success { get; set; }

    /**
     * 
     * @return totalDeltaMrr
     */
    public Double totalDeltaMrr { get; set; }

    /**
     * 
     * @return totalDeltaTcv
     */
    public Double totalDeltaTcv { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'AmendmentIds' => 'amendmentIds',
        'ChargeMetricsData' => 'chargeMetricsData',
        'Errors' => 'errors',
        'GatewayResponse' => 'gatewayResponse',
        'GatewayResponseCode' => 'gatewayResponseCode',
        'InvoiceDatas' => 'invoiceDatas',
        'InvoiceId' => 'invoiceId',
        'PaymentId' => 'paymentId',
        'PaymentTransactionNumber' => 'paymentTransactionNumber',
        'SubscriptionId' => 'subscriptionId',
        'Success' => 'success',
        'TotalDeltaMrr' => 'totalDeltaMrr',
        'TotalDeltaTcv' => 'totalDeltaTcv'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public zc_AmendResult() {
        amendmentIds = new List<String>();
        errors = new List<zc_ActionsErrorResponse>{new zc_ActionsErrorResponse()};
        invoiceDatas = new List<zc_InvoiceData>();
    }

    public static zc_AmendResult getExample() {
        zc_AmendResult amendResult = new zc_AmendResult();
        amendResult.amendmentIds = new List<String>{'aeiou'};
        amendResult.chargeMetricsData = zc_ChargeMetricsData.getExample();
        amendResult.errors = new List<zc_ActionsErrorResponse>{zc_ActionsErrorResponse.getExample()};
        amendResult.gatewayResponse = 'aeiou';
        amendResult.gatewayResponseCode = 'aeiou';
        amendResult.invoiceDatas = new List<zc_InvoiceData>{zc_InvoiceData.getExample()};
        amendResult.invoiceId = 'aeiou';
        amendResult.paymentId = 'aeiou';
        amendResult.paymentTransactionNumber = 'aeiou';
        amendResult.subscriptionId = 'aeiou';
        amendResult.success = true;
        amendResult.totalDeltaMrr = 1.3579;
        amendResult.totalDeltaTcv = 1.3579;
        return amendResult;
    }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_AmendResult) {
            zc_AmendResult amendResult = (zc_AmendResult) obj;
            return this.amendmentIds == amendResult.amendmentIds
                && this.chargeMetricsData == amendResult.chargeMetricsData
                && this.errors == amendResult.errors
                && this.gatewayResponse == amendResult.gatewayResponse
                && this.gatewayResponseCode == amendResult.gatewayResponseCode
                && this.invoiceDatas == amendResult.invoiceDatas
                && this.invoiceId == amendResult.invoiceId
                && this.paymentId == amendResult.paymentId
                && this.paymentTransactionNumber == amendResult.paymentTransactionNumber
                && this.subscriptionId == amendResult.subscriptionId
                && this.success == amendResult.success
                && this.totalDeltaMrr == amendResult.totalDeltaMrr
                && this.totalDeltaTcv == amendResult.totalDeltaTcv;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (amendmentIds == null ? 0 : System.hashCode(amendmentIds));
        hashCode = (17 * hashCode) + (chargeMetricsData == null ? 0 : System.hashCode(chargeMetricsData));
        hashCode = (17 * hashCode) + (errors == null ? 0 : System.hashCode(errors));
        hashCode = (17 * hashCode) + (gatewayResponse == null ? 0 : System.hashCode(gatewayResponse));
        hashCode = (17 * hashCode) + (gatewayResponseCode == null ? 0 : System.hashCode(gatewayResponseCode));
        hashCode = (17 * hashCode) + (invoiceDatas == null ? 0 : System.hashCode(invoiceDatas));
        hashCode = (17 * hashCode) + (invoiceId == null ? 0 : System.hashCode(invoiceId));
        hashCode = (17 * hashCode) + (paymentId == null ? 0 : System.hashCode(paymentId));
        hashCode = (17 * hashCode) + (paymentTransactionNumber == null ? 0 : System.hashCode(paymentTransactionNumber));
        hashCode = (17 * hashCode) + (subscriptionId == null ? 0 : System.hashCode(subscriptionId));
        hashCode = (17 * hashCode) + (success == null ? 0 : System.hashCode(success));
        hashCode = (17 * hashCode) + (totalDeltaMrr == null ? 0 : System.hashCode(totalDeltaMrr));
        hashCode = (17 * hashCode) + (totalDeltaTcv == null ? 0 : System.hashCode(totalDeltaTcv));
        return hashCode;
    }
}