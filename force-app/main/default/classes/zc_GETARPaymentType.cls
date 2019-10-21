/**
 * zc_GETARPaymentType
 */
public class zc_GETARPaymentType implements zc_Zuc.MappedProperties { // zc_PaymentObjectNSFields, zc_PaymentObjectCustomFields, 
    /**
     * ID of the corresponding object in NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return integrationIdNS
     */
    public String integrationIdNS { get; set; }

    /**
     * Status of the payment\'s synchronization with NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return integrationStatusNS
     */
    public String integrationStatusNS { get; set; }

    /**
     * Origin of the corresponding object in NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return originNS
     */
    public String originNS { get; set; }

    /**
     * Date when the payment was synchronized with NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return syncDateNS
     */
    public String syncDateNS { get; set; }

    /**
     * Related transaction in NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return transactionNS
     */
    public String transactionNS { get; set; }

    /**
     * The ID of the customer account that the payment is for.\n
     * @return accountId
     */
    public String accountId { get; set; }

    /**
     * The total amount of the payment.\n
     * @return amount
     */
    public Double amount { get; set; }

    /**
     * The applied amount of the payment.\n
     * @return appliedAmount
     */
    public Double appliedAmount { get; set; }

    /**
     * The authorization transaction ID from the payment gateway.\n
     * @return authTransactionId
     */
    public String authTransactionId { get; set; }

    /**
     * The first six digits of the credit card or debit card used for the payment, when applicable.\n
     * @return bankIdentificationNumber
     */
    public String bankIdentificationNumber { get; set; }

    /**
     * The date and time when the payment was cancelled, in `yyyy-mm-dd hh:mm:ss` format.\n
     * @return cancelledOn
     */
    public Datetime cancelledOn { get; set; }

    /**
     * Comments about the payment.\n
     * @return comment
     */
    public String comment { get; set; }

    /**
     * The ID of the Zuora user who created the payment.\n
     * @return createdById
     */
    public String createdById { get; set; }

    /**
     * The date and time when the payment was created, in `yyyy-mm-dd hh:mm:ss` format. For example, 2017-03-01 15:31:10.\n
     * @return createdDate
     */
    public String createdDate { get; set; }

    /**
     * The amount that the payment transfers to the credit balance. The value is not `0` only for those payments that come from legacy payment operations performed without the Invoice Settlement feature.\n
     * @return creditBalanceAmount
     */
    public Double creditBalanceAmount { get; set; }

    /**
     * A currency defined in the web-based UI administrative settings.\n
     * @return currency
     */
    public String currency2 { get; set; }

    /**
     * The date and time when the payment takes effect, in `yyyy-mm-dd hh:mm:ss` format.\n
     * @return effectiveDate
     */
    public Datetime effectiveDate { get; set; }

    /**
     * Get financeInformation
     * @return financeInformation
     */
    public zc_GETARPaymentTypeFinanceInformati financeInformation { get; set; }

    /**
     * The ID of the gateway instance that processes the payment.\n
     * @return gatewayId
     */
    public String gatewayId { get; set; }

    /**
     * A merchant-specified natural key value that can be passed to the electronic payment gateway when a payment is created.  If not specified, the payment number will be passed in instead.\n
     * @return gatewayOrderId
     */
    public String gatewayOrderId { get; set; }

    /**
     * The message returned from the payment gateway for the payment. This message is gateway-dependent.\n
     * @return gatewayResponse
     */
    public String gatewayResponse { get; set; }

    /**
     * The code returned from the payment gateway for the payment. This code is gateway-dependent.\n
     * @return gatewayResponseCode
     */
    public String gatewayResponseCode { get; set; }

    /**
     * The status of the payment in the gateway; use for reconciliation.\n
     */
    public enum GatewayStateEnum {
        MARKEDFORSUBMISSION,
        SUBMITTED,
        SETTLED,
        NOTSUBMITTED,
        FAILEDTOSETTLE
    }

    /**
     * The status of the payment in the gateway; use for reconciliation.\n
     * @return gatewayState
     */
    public GatewayStateEnum gatewayState { get; set; }

    /**
     * The unique ID of the created payment. For example, 4028905f5a87c0ff015a87eb6b75007f.\n
     * @return id
     */
    public String id { get; set; }

    /**
     * The date and time when a payment was marked and waiting for batch submission to the payment process, in `yyyy-mm-dd hh:mm:ss` format.\n
     * @return markedForSubmissionOn
     */
    public Datetime markedForSubmissionOn { get; set; }

    /**
     * The unique identification number of the payment. For example, P-00000001.\n
     * @return r_number
     */
    public String r_number { get; set; }

    /**
     * The unique ID of the payment method that the customer used to make the payment.\n
     * @return paymentMethodId
     */
    public String paymentMethodId { get; set; }

    /**
     * The unique ID of the payment method snapshot which is a copy of the particular Payment Method used in a transaction.\n
     * @return paymentMethodSnapshotId
     */
    public String paymentMethodSnapshotId { get; set; }

    /**
     * The transaction ID returned by the payment gateway. Use this field to reconcile payments between your gateway and Zuora Payments.\n
     * @return referenceId
     */
    public String referenceId { get; set; }

    /**
     * The amount of the payment that is refunded.\n
     * @return refundAmount
     */
    public Double refundAmount { get; set; }

    /**
     * The transaction ID returned by the payment gateway if there is an additional transaction for the payment. Use this field to reconcile payments between your gateway and Zuora Payments.\n
     * @return secondPaymentReferenceId
     */
    public String secondPaymentReferenceId { get; set; }

    /**
     * The date and time when the payment was settled in the payment processor, in `yyyy-mm-dd hh:mm:ss` format. This field is used by the Spectrum gateway only and not applicable to other gateways.\n
     * @return settledOn
     */
    public Datetime settledOn { get; set; }

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
     * The status of the payment.\n
     */
    public enum StatusEnum {
        DRAFT,
        PROCESSING,
        PROCESSED,
        ERROR,
        CANCELED,
        POSTED
    }

    /**
     * The status of the payment.\n
     * @return status
     */
    public StatusEnum status { get; set; }

    /**
     * The date and time when the payment was submitted, in `yyyy-mm-dd hh:mm:ss` format.\n
     * @return submittedOn
     */
    public Datetime submittedOn { get; set; }

    /**
     * Returns `true` if the request was processed successfully.
     * @return success
     */
    public Boolean success { get; set; }

    /**
     * The type of the payment.\n
     */
    public enum RTypeEnum {
        EXTERNAL,
        ELECTRONIC
    }

    /**
     * The type of the payment.\n
     * @return r_type
     */
    public RTypeEnum r_type { get; set; }

    /**
     * The unapplied amount of the payment.\n
     * @return unappliedAmount
     */
    public Double unappliedAmount { get; set; }

    /**
     * The ID of the Zuora user who last updated the payment.\n
     * @return updatedById
     */
    public String updatedById { get; set; }

    /**
     * The date and time when the payment was last updated, in `yyyy-mm-dd hh:mm:ss` format. For example, 2017-03-02 15:36:10.\n
     * @return updatedDate
     */
    public String updatedDate { get; set; } //MBE old Datetime

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'IntegrationId__NS' => 'integrationIdNS',
        'IntegrationStatus__NS' => 'integrationStatusNS',
        'Origin__NS' => 'originNS',
        'SyncDate__NS' => 'syncDateNS',
        'Transaction__NS' => 'transactionNS',
        'number' => 'r_number',
        'type' => 'r_type'
    };

   public zc_GETARPaymentType(){
       financeInformation = new zc_GETARPaymentTypeFinanceInformati();
   }

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    // public static zc_GETARPaymentType getExample() {
    //     zc_GETARPaymentType geTARPaymentType = new zc_GETARPaymentType();
    //     geTARPaymentType.integrationIdNS = 'aeiou';
    //     geTARPaymentType.integrationStatusNS = 'aeiou';
    //     geTARPaymentType.originNS = 'aeiou';
    //     geTARPaymentType.syncDateNS = 'aeiou';
    //     geTARPaymentType.transactionNS = 'aeiou';
    //     geTARPaymentType.accountId = 'aeiou';
    //     geTARPaymentType.amount = 1.3579;
    //     geTARPaymentType.appliedAmount = 1.3579;
    //     geTARPaymentType.authTransactionId = 'aeiou';
    //     geTARPaymentType.bankIdentificationNumber = 'aeiou';
    //     geTARPaymentType.cancelledOn = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    //     geTARPaymentType.comment = 'aeiou';
    //     geTARPaymentType.createdById = 'aeiou';
    //     geTARPaymentType.createdDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    //     geTARPaymentType.creditBalanceAmount = 1.3579;
    //     geTARPaymentType.currency = 'aeiou';
    //     geTARPaymentType.effectiveDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    //     geTARPaymentType.financeInformation = zc_GETARPaymentTypeFinanceInformati.getExample();
    //     geTARPaymentType.gatewayId = 'aeiou';
    //     geTARPaymentType.gatewayOrderId = 'aeiou';
    //     geTARPaymentType.gatewayResponse = 'aeiou';
    //     geTARPaymentType.gatewayResponseCode = 'aeiou';
    //     geTARPaymentType.gatewayState = GatewayStateEnum.MARKEDFORSUBMISSION;
    //     geTARPaymentType.id = 'aeiou';
    //     geTARPaymentType.markedForSubmissionOn = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    //     geTARPaymentType.r_number = 'aeiou';
    //     geTARPaymentType.paymentMethodId = 'aeiou';
    //     geTARPaymentType.paymentMethodSnapshotId = 'aeiou';
    //     geTARPaymentType.referenceId = 'aeiou';
    //     geTARPaymentType.refundAmount = 1.3579;
    //     geTARPaymentType.secondPaymentReferenceId = 'aeiou';
    //     geTARPaymentType.settledOn = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    //     geTARPaymentType.softDescriptor = 'aeiou';
    //     geTARPaymentType.softDescriptorPhone = 'aeiou';
    //     geTARPaymentType.status = StatusEnum.DRAFT;
    //     geTARPaymentType.submittedOn = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    //     geTARPaymentType.success = true;
    //     geTARPaymentType.r_type = RTypeEnum.EXTERNAL;
    //     geTARPaymentType.unappliedAmount = 1.3579;
    //     geTARPaymentType.updatedById = 'aeiou';
    //     geTARPaymentType.updatedDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    //     return geTARPaymentType;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_GETARPaymentType) {
            zc_GETARPaymentType geTARPaymentType = (zc_GETARPaymentType) obj;
            return this.integrationIdNS == geTARPaymentType.integrationIdNS
                && this.integrationStatusNS == geTARPaymentType.integrationStatusNS
                && this.originNS == geTARPaymentType.originNS
                && this.syncDateNS == geTARPaymentType.syncDateNS
                && this.transactionNS == geTARPaymentType.transactionNS
                && this.accountId == geTARPaymentType.accountId
                && this.amount == geTARPaymentType.amount
                && this.appliedAmount == geTARPaymentType.appliedAmount
                && this.authTransactionId == geTARPaymentType.authTransactionId
                && this.bankIdentificationNumber == geTARPaymentType.bankIdentificationNumber
                && this.cancelledOn == geTARPaymentType.cancelledOn
                && this.comment == geTARPaymentType.comment
                && this.createdById == geTARPaymentType.createdById
                && this.createdDate == geTARPaymentType.createdDate
                && this.creditBalanceAmount == geTARPaymentType.creditBalanceAmount
                && this.currency2 == geTARPaymentType.currency2
                && this.effectiveDate == geTARPaymentType.effectiveDate
                && this.financeInformation == geTARPaymentType.financeInformation
                && this.gatewayId == geTARPaymentType.gatewayId
                && this.gatewayOrderId == geTARPaymentType.gatewayOrderId
                && this.gatewayResponse == geTARPaymentType.gatewayResponse
                && this.gatewayResponseCode == geTARPaymentType.gatewayResponseCode
                && this.gatewayState == geTARPaymentType.gatewayState
                && this.id == geTARPaymentType.id
                && this.markedForSubmissionOn == geTARPaymentType.markedForSubmissionOn
                && this.r_number == geTARPaymentType.r_number
                && this.paymentMethodId == geTARPaymentType.paymentMethodId
                && this.paymentMethodSnapshotId == geTARPaymentType.paymentMethodSnapshotId
                && this.referenceId == geTARPaymentType.referenceId
                && this.refundAmount == geTARPaymentType.refundAmount
                && this.secondPaymentReferenceId == geTARPaymentType.secondPaymentReferenceId
                && this.settledOn == geTARPaymentType.settledOn
                && this.softDescriptor == geTARPaymentType.softDescriptor
                && this.softDescriptorPhone == geTARPaymentType.softDescriptorPhone
                && this.status == geTARPaymentType.status
                && this.submittedOn == geTARPaymentType.submittedOn
                && this.success == geTARPaymentType.success
                && this.r_type == geTARPaymentType.r_type
                && this.unappliedAmount == geTARPaymentType.unappliedAmount
                && this.updatedById == geTARPaymentType.updatedById
                && this.updatedDate == geTARPaymentType.updatedDate;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (integrationIdNS == null ? 0 : System.hashCode(integrationIdNS));
        hashCode = (17 * hashCode) + (integrationStatusNS == null ? 0 : System.hashCode(integrationStatusNS));
        hashCode = (17 * hashCode) + (originNS == null ? 0 : System.hashCode(originNS));
        hashCode = (17 * hashCode) + (syncDateNS == null ? 0 : System.hashCode(syncDateNS));
        hashCode = (17 * hashCode) + (transactionNS == null ? 0 : System.hashCode(transactionNS));
        hashCode = (17 * hashCode) + (accountId == null ? 0 : System.hashCode(accountId));
        hashCode = (17 * hashCode) + (amount == null ? 0 : System.hashCode(amount));
        hashCode = (17 * hashCode) + (appliedAmount == null ? 0 : System.hashCode(appliedAmount));
        hashCode = (17 * hashCode) + (authTransactionId == null ? 0 : System.hashCode(authTransactionId));
        hashCode = (17 * hashCode) + (bankIdentificationNumber == null ? 0 : System.hashCode(bankIdentificationNumber));
        hashCode = (17 * hashCode) + (cancelledOn == null ? 0 : System.hashCode(cancelledOn));
        hashCode = (17 * hashCode) + (comment == null ? 0 : System.hashCode(comment));
        hashCode = (17 * hashCode) + (createdById == null ? 0 : System.hashCode(createdById));
        hashCode = (17 * hashCode) + (createdDate == null ? 0 : System.hashCode(createdDate));
        hashCode = (17 * hashCode) + (creditBalanceAmount == null ? 0 : System.hashCode(creditBalanceAmount));
        hashCode = (17 * hashCode) + (currency2 == null ? 0 : System.hashCode(currency2));
        hashCode = (17 * hashCode) + (effectiveDate == null ? 0 : System.hashCode(effectiveDate));
        hashCode = (17 * hashCode) + (financeInformation == null ? 0 : System.hashCode(financeInformation));
        hashCode = (17 * hashCode) + (gatewayId == null ? 0 : System.hashCode(gatewayId));
        hashCode = (17 * hashCode) + (gatewayOrderId == null ? 0 : System.hashCode(gatewayOrderId));
        hashCode = (17 * hashCode) + (gatewayResponse == null ? 0 : System.hashCode(gatewayResponse));
        hashCode = (17 * hashCode) + (gatewayResponseCode == null ? 0 : System.hashCode(gatewayResponseCode));
        hashCode = (17 * hashCode) + (gatewayState == null ? 0 : System.hashCode(gatewayState));
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
        hashCode = (17 * hashCode) + (markedForSubmissionOn == null ? 0 : System.hashCode(markedForSubmissionOn));
        hashCode = (17 * hashCode) + (r_number == null ? 0 : System.hashCode(r_number));
        hashCode = (17 * hashCode) + (paymentMethodId == null ? 0 : System.hashCode(paymentMethodId));
        hashCode = (17 * hashCode) + (paymentMethodSnapshotId == null ? 0 : System.hashCode(paymentMethodSnapshotId));
        hashCode = (17 * hashCode) + (referenceId == null ? 0 : System.hashCode(referenceId));
        hashCode = (17 * hashCode) + (refundAmount == null ? 0 : System.hashCode(refundAmount));
        hashCode = (17 * hashCode) + (secondPaymentReferenceId == null ? 0 : System.hashCode(secondPaymentReferenceId));
        hashCode = (17 * hashCode) + (settledOn == null ? 0 : System.hashCode(settledOn));
        hashCode = (17 * hashCode) + (softDescriptor == null ? 0 : System.hashCode(softDescriptor));
        hashCode = (17 * hashCode) + (softDescriptorPhone == null ? 0 : System.hashCode(softDescriptorPhone));
        hashCode = (17 * hashCode) + (status == null ? 0 : System.hashCode(status));
        hashCode = (17 * hashCode) + (submittedOn == null ? 0 : System.hashCode(submittedOn));
        hashCode = (17 * hashCode) + (success == null ? 0 : System.hashCode(success));
        hashCode = (17 * hashCode) + (r_type == null ? 0 : System.hashCode(r_type));
        hashCode = (17 * hashCode) + (unappliedAmount == null ? 0 : System.hashCode(unappliedAmount));
        hashCode = (17 * hashCode) + (updatedById == null ? 0 : System.hashCode(updatedById));
        hashCode = (17 * hashCode) + (updatedDate == null ? 0 : System.hashCode(updatedDate));
        return hashCode;
    }
}