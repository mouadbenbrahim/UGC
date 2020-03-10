/**
 * zc_GETRefundCreditMemoType
 */
public class zc_GETRefundCreditMemoType {
    /**
     * ID of the corresponding object in NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return integrationIdNS
     */
    public String integrationIdNS { get; set; }

    /**
     * Status of the refund\'s synchronization with NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return integrationStatusNS
     */
    public String integrationStatusNS { get; set; }

    /**
     * Origin of the corresponding object in NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return originNS
     */
    public String originNS { get; set; }

    /**
     * Date when the refund was synchronized with NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return syncDateNS
     */
    public String syncDateNS { get; set; }

    /**
     * Specifies whether the refund should be synchronized with NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return synctoNetSuiteNS
     */
    public String synctoNetSuiteNS { get; set; }

    /**
     * The ID of the account associated with this refund. Zuora associates the refund automatically with the account from the associated payment.\n
     * @return accountId
     */
    public String accountId { get; set; }

    /**
     * The total amount of the refund.\n
     * @return amount
     */
    public Double amount { get; set; }

    /**
     * The date and time when the refund was cancelled, in `yyyy-mm-dd hh:mm:ss` format.\n
     * @return cancelledOn
     */
    public String cancelledOn { get; set; }

    /**
     * Comments about the refund.\n
     * @return comment
     */
    public String comment { get; set; }

    /**
     * The ID of the Zuora user who created the refund.\n
     * @return createdById
     */
    public String createdById { get; set; }

    /**
     * The date and time when the refund was created, in `yyyy-mm-dd hh:mm:ss` format. For example, 2017-03-06 15:31:10.\n
     * @return createdDate
     */
    public String createdDate { get; set; }

    /**
     * The ID of the credit memo that is refunded.\n
     * @return creditMemoId
     */
    public String creditMemoId { get; set; }

    /**
     * Get financeInformation
     * @return financeInformation
     */
    public zc_GETRefundCreditMemoTypeFinanceIn financeInformation { get; set; }

    /**
     * The ID of the gateway instance that processes the refund.\n
     * @return gatewayId
     */
    public String gatewayId { get; set; }

    /**
     * The message returned from the payment gateway for the refund. This message is gateway-dependent.\n
     * @return gatewayResponse
     */
    public String gatewayResponse { get; set; }

    /**
     * The response code returned from the payment gateway for the refund. This code is gateway-dependent.\n
     * @return gatewayResponseCode
     */
    public String gatewayResponseCode { get; set; }

    /**
     * The status of the refund in the gateway.\n
     */
    public enum GatewayStateEnum {
        MARKEDFORSUBMISSION,
        SUBMITTED,
        SETTLED,
        NOTSUBMITTED,
        FAILEDTOSETTLE
    }

    /**
     * The status of the refund in the gateway.\n
     * @return gatewayState
     */
    public GatewayStateEnum gatewayState { get; set; }

    /**
     * The ID of the created refund.\n
     * @return id
     */
    public String id { get; set; }

    /**
     * The date and time when a refund was marked and waiting for batch submission to the payment process, in `yyyy-mm-dd hh:mm:ss` format.\n
     * @return markedForSubmissionOn
     */
    public String markedForSubmissionOn { get; set; }

    /**
     * How an external refund was issued to a customer.\n
     */
    public enum MethodTypeEnum {
        ACH,
        CASH,
        CHECK,
        CREDITCARD,
        PAYPAL,
        WIRETRANSFER,
        DEBITCARD,
        CREDITCARDREFERENCETRANSACTION,
        BANKTRANSFER,
        OTHER
    }

    /**
     * How an external refund was issued to a customer.\n
     * @return methodType
     */
    public MethodTypeEnum methodType { get; set; }

    /**
     * The unique identification number of the refund.\n
     * @return r_number
     */
    public String r_number { get; set; }

    /**
     * The ID of the payment associated with the refund.\n
     * @return paymentId
     */
    public String paymentId { get; set; }

    /**
     * The unique ID of the payment method that the customer used to make the refund.\n
     * @return paymentMethodId
     */
    public String paymentMethodId { get; set; }

    /**
     * The unique ID of the payment method snapshot, which is a copy of the particular payment method used in a transaction.\n
     * @return paymentMethodSnapshotId
     */
    public String paymentMethodSnapshotId { get; set; }

    /**
     * A code identifying the reason for the transaction.\n
     * @return reasonCode
     */
    public String reasonCode { get; set; }

    /**
     * The transaction ID returned by the payment gateway for an electronic refund. Use this field to reconcile refunds between your gateway and Zuora Payments.\n
     * @return referenceId
     */
    public String referenceId { get; set; }

    /**
     * The date when the refund takes effect, in yyyy-mm-dd format.\n
     * @return refundDate
     */
    public Date refundDate { get; set; }

    /**
     * The date and time when the refund was issued, in `yyyy-mm-dd hh:mm:ss` format.\n
     * @return refundTransactionTime
     */
    public String refundTransactionTime { get; set; }

    /**
     * The transaction ID returned by the payment gateway if there is an additional transaction for the refund. Use this field to reconcile payments between your gateway and Zuora Payments.\n
     * @return secondRefundReferenceId
     */
    public String secondRefundReferenceId { get; set; }

    /**
     * The date and time when the refund was settled in the payment processor, in `yyyy-mm-dd hh:mm:ss` format. This field is used by the Spectrum gateway only and not applicable to other gateways.\n
     * @return settledOn
     */
    public String settledOn { get; set; }

    /**
     * A payment gateway-specific field that maps to Zuora for the gateways, Orbital, Vantiv and Verifi.\n
     * @return softDescriptor
     */
    public String softDescriptor { get; set; }

    /**
     * A payment gateway-specific field that maps to Zuora for the gateways, Orbital, Vantiv and Verifi.\n
     * @return softDescriptorPhone
     */
    public String softDescriptorPhone { get; set; }

    /**
     * The status of the refund.\n
     */
    public enum StatusEnum {
        PROCESSED,
        CANCELED,
        ERROR,
        PROCESSING
    }

    /**
     * The status of the refund.\n
     * @return status
     */
    public StatusEnum status { get; set; }

    /**
     * The date and time when the refund was submitted, in `yyyy-mm-dd hh:mm:ss` format.\n
     * @return submittedOn
     */
    public String submittedOn { get; set; }

    /**
     * Returns `true` if the request was processed successfully.
     * @return success
     */
    public Boolean success { get; set; }

    /**
     * The type of the refund.\n
     */
    public enum RTypeEnum {
        EXTERNAL,
        ELECTRONIC
    }

    /**
     * The type of the refund.\n
     * @return r_type
     */
    public RTypeEnum r_type { get; set; }

    /**
     * The ID of the Zuora user who last updated the refund.\n
     * @return updatedById
     */
    public String updatedById { get; set; }

    /**
     * The date and time when the refund was last updated, in `yyyy-mm-dd hh:mm:ss` format. For example, 2017-03-07 15:36:10.\n
     * @return updatedDate
     */
    public String updatedDate { get; set; }


    public zc_GETRefundCreditMemoType(){
        this.financeInformation = new zc_GETRefundCreditMemoTypeFinanceIn();
    }
     

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'IntegrationId__NS' => 'integrationIdNS',
        'IntegrationStatus__NS' => 'integrationStatusNS',
        'Origin__NS' => 'originNS',
        'SyncDate__NS' => 'syncDateNS',
        'SynctoNetSuite__NS' => 'synctoNetSuiteNS',
        'number' => 'r_number',
        'type' => 'r_type'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    // public static zc_GETRefundCreditMemoType getExample() {
    //     zc_GETRefundCreditMemoType geTRefundCreditMemoType = new zc_GETRefundCreditMemoType();
    //     geTRefundCreditMemoType.integrationIdNS = 'aeiou';
    //     geTRefundCreditMemoType.integrationStatusNS = 'aeiou';
    //     geTRefundCreditMemoType.originNS = 'aeiou';
    //     geTRefundCreditMemoType.syncDateNS = 'aeiou';
    //     geTRefundCreditMemoType.synctoNetSuiteNS = 'aeiou';
    //     geTRefundCreditMemoType.accountId = 'aeiou';
    //     geTRefundCreditMemoType.amount = 1.3579;
    //     geTRefundCreditMemoType.cancelledOn = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    //     geTRefundCreditMemoType.comment = 'aeiou';
    //     geTRefundCreditMemoType.createdById = 'aeiou';
    //     geTRefundCreditMemoType.createdDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    //     geTRefundCreditMemoType.creditMemoId = 'aeiou';
    //     geTRefundCreditMemoType.financeInformation = zc_GETRefundCreditMemoTypeFinanceIn.getExample();
    //     geTRefundCreditMemoType.gatewayId = 'aeiou';
    //     geTRefundCreditMemoType.gatewayResponse = 'aeiou';
    //     geTRefundCreditMemoType.gatewayResponseCode = 'aeiou';
    //     geTRefundCreditMemoType.gatewayState = GatewayStateEnum.MARKEDFORSUBMISSION;
    //     geTRefundCreditMemoType.id = 'aeiou';
    //     geTRefundCreditMemoType.markedForSubmissionOn = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    //     geTRefundCreditMemoType.methodType = MethodTypeEnum.ACH;
    //     geTRefundCreditMemoType.r_number = 'aeiou';
    //     geTRefundCreditMemoType.paymentId = 'aeiou';
    //     geTRefundCreditMemoType.paymentMethodId = 'aeiou';
    //     geTRefundCreditMemoType.paymentMethodSnapshotId = 'aeiou';
    //     geTRefundCreditMemoType.reasonCode = 'aeiou';
    //     geTRefundCreditMemoType.referenceId = 'aeiou';
    //     geTRefundCreditMemoType.refundDate = Date.newInstance(2000, 1, 23);
    //     geTRefundCreditMemoType.refundTransactionTime = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    //     geTRefundCreditMemoType.secondRefundReferenceId = 'aeiou';
    //     geTRefundCreditMemoType.settledOn = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    //     geTRefundCreditMemoType.softDescriptor = 'aeiou';
    //     geTRefundCreditMemoType.softDescriptorPhone = 'aeiou';
    //     geTRefundCreditMemoType.status = StatusEnum.PROCESSED;
    //     geTRefundCreditMemoType.submittedOn = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    //     geTRefundCreditMemoType.success = true;
    //     geTRefundCreditMemoType.r_type = RTypeEnum.EXTERNAL;
    //     geTRefundCreditMemoType.updatedById = 'aeiou';
    //     geTRefundCreditMemoType.updatedDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    //     return geTRefundCreditMemoType;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_GETRefundCreditMemoType) {
            zc_GETRefundCreditMemoType geTRefundCreditMemoType = (zc_GETRefundCreditMemoType) obj;
            return this.integrationIdNS == geTRefundCreditMemoType.integrationIdNS
                && this.integrationStatusNS == geTRefundCreditMemoType.integrationStatusNS
                && this.originNS == geTRefundCreditMemoType.originNS
                && this.syncDateNS == geTRefundCreditMemoType.syncDateNS
                && this.synctoNetSuiteNS == geTRefundCreditMemoType.synctoNetSuiteNS
                && this.accountId == geTRefundCreditMemoType.accountId
                && this.amount == geTRefundCreditMemoType.amount
                && this.cancelledOn == geTRefundCreditMemoType.cancelledOn
                && this.comment == geTRefundCreditMemoType.comment
                && this.createdById == geTRefundCreditMemoType.createdById
                && this.createdDate == geTRefundCreditMemoType.createdDate
                && this.creditMemoId == geTRefundCreditMemoType.creditMemoId
                && this.financeInformation == geTRefundCreditMemoType.financeInformation
                && this.gatewayId == geTRefundCreditMemoType.gatewayId
                && this.gatewayResponse == geTRefundCreditMemoType.gatewayResponse
                && this.gatewayResponseCode == geTRefundCreditMemoType.gatewayResponseCode
                && this.gatewayState == geTRefundCreditMemoType.gatewayState
                && this.id == geTRefundCreditMemoType.id
                && this.markedForSubmissionOn == geTRefundCreditMemoType.markedForSubmissionOn
                && this.methodType == geTRefundCreditMemoType.methodType
                && this.r_number == geTRefundCreditMemoType.r_number
                && this.paymentId == geTRefundCreditMemoType.paymentId
                && this.paymentMethodId == geTRefundCreditMemoType.paymentMethodId
                && this.paymentMethodSnapshotId == geTRefundCreditMemoType.paymentMethodSnapshotId
                && this.reasonCode == geTRefundCreditMemoType.reasonCode
                && this.referenceId == geTRefundCreditMemoType.referenceId
                && this.refundDate == geTRefundCreditMemoType.refundDate
                && this.refundTransactionTime == geTRefundCreditMemoType.refundTransactionTime
                && this.secondRefundReferenceId == geTRefundCreditMemoType.secondRefundReferenceId
                && this.settledOn == geTRefundCreditMemoType.settledOn
                && this.softDescriptor == geTRefundCreditMemoType.softDescriptor
                && this.softDescriptorPhone == geTRefundCreditMemoType.softDescriptorPhone
                && this.status == geTRefundCreditMemoType.status
                && this.submittedOn == geTRefundCreditMemoType.submittedOn
                && this.success == geTRefundCreditMemoType.success
                && this.r_type == geTRefundCreditMemoType.r_type
                && this.updatedById == geTRefundCreditMemoType.updatedById
                && this.updatedDate == geTRefundCreditMemoType.updatedDate;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (integrationIdNS == null ? 0 : System.hashCode(integrationIdNS));
        hashCode = (17 * hashCode) + (integrationStatusNS == null ? 0 : System.hashCode(integrationStatusNS));
        hashCode = (17 * hashCode) + (originNS == null ? 0 : System.hashCode(originNS));
        hashCode = (17 * hashCode) + (syncDateNS == null ? 0 : System.hashCode(syncDateNS));
        hashCode = (17 * hashCode) + (synctoNetSuiteNS == null ? 0 : System.hashCode(synctoNetSuiteNS));
        hashCode = (17 * hashCode) + (accountId == null ? 0 : System.hashCode(accountId));
        hashCode = (17 * hashCode) + (amount == null ? 0 : System.hashCode(amount));
        hashCode = (17 * hashCode) + (cancelledOn == null ? 0 : System.hashCode(cancelledOn));
        hashCode = (17 * hashCode) + (comment == null ? 0 : System.hashCode(comment));
        hashCode = (17 * hashCode) + (createdById == null ? 0 : System.hashCode(createdById));
        hashCode = (17 * hashCode) + (createdDate == null ? 0 : System.hashCode(createdDate));
        hashCode = (17 * hashCode) + (creditMemoId == null ? 0 : System.hashCode(creditMemoId));
        hashCode = (17 * hashCode) + (financeInformation == null ? 0 : System.hashCode(financeInformation));
        hashCode = (17 * hashCode) + (gatewayId == null ? 0 : System.hashCode(gatewayId));
        hashCode = (17 * hashCode) + (gatewayResponse == null ? 0 : System.hashCode(gatewayResponse));
        hashCode = (17 * hashCode) + (gatewayResponseCode == null ? 0 : System.hashCode(gatewayResponseCode));
        hashCode = (17 * hashCode) + (gatewayState == null ? 0 : System.hashCode(gatewayState));
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
        hashCode = (17 * hashCode) + (markedForSubmissionOn == null ? 0 : System.hashCode(markedForSubmissionOn));
        hashCode = (17 * hashCode) + (methodType == null ? 0 : System.hashCode(methodType));
        hashCode = (17 * hashCode) + (r_number == null ? 0 : System.hashCode(r_number));
        hashCode = (17 * hashCode) + (paymentId == null ? 0 : System.hashCode(paymentId));
        hashCode = (17 * hashCode) + (paymentMethodId == null ? 0 : System.hashCode(paymentMethodId));
        hashCode = (17 * hashCode) + (paymentMethodSnapshotId == null ? 0 : System.hashCode(paymentMethodSnapshotId));
        hashCode = (17 * hashCode) + (reasonCode == null ? 0 : System.hashCode(reasonCode));
        hashCode = (17 * hashCode) + (referenceId == null ? 0 : System.hashCode(referenceId));
        hashCode = (17 * hashCode) + (refundDate == null ? 0 : System.hashCode(refundDate));
        hashCode = (17 * hashCode) + (refundTransactionTime == null ? 0 : System.hashCode(refundTransactionTime));
        hashCode = (17 * hashCode) + (secondRefundReferenceId == null ? 0 : System.hashCode(secondRefundReferenceId));
        hashCode = (17 * hashCode) + (settledOn == null ? 0 : System.hashCode(settledOn));
        hashCode = (17 * hashCode) + (softDescriptor == null ? 0 : System.hashCode(softDescriptor));
        hashCode = (17 * hashCode) + (softDescriptorPhone == null ? 0 : System.hashCode(softDescriptorPhone));
        hashCode = (17 * hashCode) + (status == null ? 0 : System.hashCode(status));
        hashCode = (17 * hashCode) + (submittedOn == null ? 0 : System.hashCode(submittedOn));
        hashCode = (17 * hashCode) + (success == null ? 0 : System.hashCode(success));
        hashCode = (17 * hashCode) + (r_type == null ? 0 : System.hashCode(r_type));
        hashCode = (17 * hashCode) + (updatedById == null ? 0 : System.hashCode(updatedById));
        hashCode = (17 * hashCode) + (updatedDate == null ? 0 : System.hashCode(updatedDate));
        return hashCode;
    }
}