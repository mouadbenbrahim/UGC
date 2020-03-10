/**
 * zc_ProxyCreatePayment
 */
public class zc_ProxyCreatePayment implements zc_Zuc.MappedProperties { //zc_PaymentObjectNSFields, zc_PaymentObjectCustomFields, 
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
     * The unique account ID for the customer that the payment is for.\n
     * @return accountId
     */
    public String accountId { get; set; }

    /**
     * The aacccounting code for the payment. Accounting codes group transactions that contain similar accounting attributes.\n
     * @return accountingCode
     */
    public String accountingCode { get; set; }

    /**
     * The amount of the payment.\n
     * @return amount
     */
    public Double amount { get; set; }

    /**
     * The amount of the payment to apply to a credit balance. This field is only required if the `AppliedInvoiceAmount` field value is null.\n
     * @return appliedCreditBalanceAmount
     */
    public Double appliedCreditBalanceAmount { get; set; }

    /**
     * The amount of the payment to apply to an invoice. This field is only required if either the `InvoiceId` or `InvoiceNumber` field is not null.\n
     * @return appliedInvoiceAmount
     */
    public Double appliedInvoiceAmount { get; set; }

    /**
     * The authorization transaction ID from the payment gateway. Use this field for electronic payments, such as credit cards.\n
     * @return authTransactionId
     */
    public String authTransactionId { get; set; }

    /**
     * Additional information related to the payment.\n
     * @return comment
     */
    public String comment { get; set; }

    /**
     * The date when the payment takes effect.\n
     * @return effectiveDate
     */
    public Date effectiveDate { get; set; }

    /**
     * The name of the gateway instance that processes the payment. When creating a payment, the value of this field must be a valid gateway instance name, and this gateway must support the specific payment method. If no value is specified, the default gateway on the Account will be used.\n
     * @return gateway
     */
    public String gateway { get; set; }

    /**
     * Get gatewayOptionData
     * @return gatewayOptionData
     */
    public zc_ProxyCreatePaymentGatewayOptionD gatewayOptionData { get; set; }

    /**
     * A merchant-specified natural key value that can be passed to the electronic payment gateway when a payment is created. If not specified, the payment number will be passed in instead.\n\nGateways check duplicates on the gateway order ID to ensure that the merchant do not accidentally enter the same transaction twice. This ID can also be used to do reconciliation and tie the payment to a natural key in external systems. The source of this ID varies by merchant. Some merchants use their shopping cart order IDs, and others use something different. Merchants use this ID to track transactions in their eCommerce systems.\n
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
     * The ID of the invoice that the payment is applied to. When applying a payment to a single invoice, this field is only required if the `InvoiceNumber` field is null.\n
     * @return invoiceId
     */
    public String invoiceId { get; set; }

    /**
     * The unique identification number for the invoice that the payment is applied to. When applying a payment to a single invoice, this field is only required if the `InvoiceId` field is null.\n
     * @return invoiceNumber
     */
    public String invoiceNumber { get; set; }

    /**
     * Get invoicePaymentData
     * @return invoicePaymentData
     */
    public zc_InvoicePaymentData invoicePaymentData { get; set; }

    /**
     * The ID of the payment method used for the payment. \n
     * @return paymentMethodId
     */
    public String paymentMethodId { get; set; }

    /**
     * The unique identification number of the payment. For example, P-00000028.\n
     * @return paymentNumber
     */
    public String paymentNumber { get; set; }

    /**
     * The transaction ID returned by the payment gateway. Use this field to reconcile payments between your gateway and Zuora Payments.\n
     * @return referenceId
     */
    public String referenceId { get; set; }

    /**
     * A payment gateway-specific field that maps to Zuora for the gateways, Orbital, Vantiv and Verifi. \n\nZuora passes this field to Verifi directly without verification. In general, this field will be defaulted by the gateway. For Orbital, this field contains two fields separated by an asterisk, `SDMerchantName` and `SDProductionInfo`. For more information, contact your payment gateway.\n
     * @return softDescriptor
     */
    public String softDescriptor { get; set; }

    /**
     * A payment gateway-specific field that maps to Zuora for the gateways, Orbital, Vantiv and Verifi.\n\nVerifi and Orbital determine how to format this string. For more information, contact your payment gateway.\n
     * @return softDescriptorPhone
     */
    public String softDescriptorPhone { get; set; }

    /**
     * The status of the payment in Zuora. The value depends on the type of payment.\n\nFor electronic payments, the status can be `Processed`, `Error`, or `Voided`. For external payments, the status can be `Processed` or `Canceled`.\n
     */
    public enum StatusEnum {
        PROCESSED,
        ERROR,
        VOIDED,
        CANCELED
    }

    /**
     * The status of the payment in Zuora. The value depends on the type of payment.\n\nFor electronic payments, the status can be `Processed`, `Error`, or `Voided`. For external payments, the status can be `Processed` or `Canceled`.\n
     * @return status
     */
    public StatusEnum status { get; set; }

    /**
     * The type of the payment, whether the payment is external or electronic.\n
     */
    public enum RTypeEnum {
        EXTERNAL,
        ELECTRONIC
    }

    /**
     * The type of the payment, whether the payment is external or electronic.\n
     * @return r_type
     */
    public RTypeEnum r_type { get; set; }

    private static final Map<String, String> propertyMappings = new Map<String, String>{
        'IntegrationId__NS' => 'integrationIdNS',
        'IntegrationStatus__NS' => 'integrationStatusNS',
        'Origin__NS' => 'originNS',
        'SyncDate__NS' => 'syncDateNS',
        'Transaction__NS' => 'transactionNS',
        'AccountId' => 'accountId',
        'AccountingCode' => 'accountingCode',
        'Amount' => 'amount',
        'AppliedCreditBalanceAmount' => 'appliedCreditBalanceAmount',
        'AppliedInvoiceAmount' => 'appliedInvoiceAmount',
        'AuthTransactionId' => 'authTransactionId',
        'Comment' => 'comment',
        'EffectiveDate' => 'effectiveDate',
        'Gateway' => 'gateway',
        'GatewayOptionData' => 'gatewayOptionData',
        'GatewayOrderId' => 'gatewayOrderId',
        'GatewayResponse' => 'gatewayResponse',
        'GatewayResponseCode' => 'gatewayResponseCode',
        'GatewayState' => 'gatewayState',
        'InvoiceId' => 'invoiceId',
        'InvoiceNumber' => 'invoiceNumber',
        'InvoicePaymentData' => 'invoicePaymentData',
        'PaymentMethodId' => 'paymentMethodId',
        'PaymentNumber' => 'paymentNumber',
        'ReferenceId' => 'referenceId',
        'SoftDescriptor' => 'softDescriptor',
        'SoftDescriptorPhone' => 'softDescriptorPhone',
        'Status' => 'status',
        'Type' => 'r_type'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    // public static zc_ProxyCreatePayment getExample() {
    //     zc_ProxyCreatePayment proxyCreatePayment = new zc_ProxyCreatePayment();
    //     proxyCreatePayment.integrationIdNS = 'aeiou';
    //     proxyCreatePayment.integrationStatusNS = 'aeiou';
    //     proxyCreatePayment.originNS = 'aeiou';
    //     proxyCreatePayment.syncDateNS = 'aeiou';
    //     proxyCreatePayment.transactionNS = 'aeiou';
    //     proxyCreatePayment.accountId = 'aeiou';
    //     proxyCreatePayment.accountingCode = 'aeiou';
    //     proxyCreatePayment.amount = 1.3579;
    //     proxyCreatePayment.appliedCreditBalanceAmount = 1.3579;
    //     proxyCreatePayment.appliedInvoiceAmount = 1.3579;
    //     proxyCreatePayment.authTransactionId = 'aeiou';
    //     proxyCreatePayment.comment = 'aeiou';
    //     proxyCreatePayment.effectiveDate = Date.newInstance(2000, 1, 23);
    //     proxyCreatePayment.gateway = 'aeiou';
    //     proxyCreatePayment.gatewayOptionData = zc_ProxyCreatePaymentGatewayOptionD.getExample();
    //     proxyCreatePayment.gatewayOrderId = 'aeiou';
    //     proxyCreatePayment.gatewayResponse = 'aeiou';
    //     proxyCreatePayment.gatewayResponseCode = 'aeiou';
    //     proxyCreatePayment.gatewayState = GatewayStateEnum.MARKEDFORSUBMISSION;
    //     proxyCreatePayment.invoiceId = 'aeiou';
    //     proxyCreatePayment.invoiceNumber = 'aeiou';
    //     proxyCreatePayment.invoicePaymentData = zc_InvoicePaymentData.getExample();
    //     proxyCreatePayment.paymentMethodId = 'aeiou';
    //     proxyCreatePayment.paymentNumber = 'aeiou';
    //     proxyCreatePayment.referenceId = 'aeiou';
    //     proxyCreatePayment.softDescriptor = 'aeiou';
    //     proxyCreatePayment.softDescriptorPhone = 'aeiou';
    //     proxyCreatePayment.status = StatusEnum.PROCESSED;
    //     proxyCreatePayment.r_type = RTypeEnum.EXTERNAL;
    //     return proxyCreatePayment;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_ProxyCreatePayment) {
            zc_ProxyCreatePayment proxyCreatePayment = (zc_ProxyCreatePayment) obj;
            return this.integrationIdNS == proxyCreatePayment.integrationIdNS
                && this.integrationStatusNS == proxyCreatePayment.integrationStatusNS
                && this.originNS == proxyCreatePayment.originNS
                && this.syncDateNS == proxyCreatePayment.syncDateNS
                && this.transactionNS == proxyCreatePayment.transactionNS
                && this.accountId == proxyCreatePayment.accountId
                && this.accountingCode == proxyCreatePayment.accountingCode
                && this.amount == proxyCreatePayment.amount
                && this.appliedCreditBalanceAmount == proxyCreatePayment.appliedCreditBalanceAmount
                && this.appliedInvoiceAmount == proxyCreatePayment.appliedInvoiceAmount
                && this.authTransactionId == proxyCreatePayment.authTransactionId
                && this.comment == proxyCreatePayment.comment
                && this.effectiveDate == proxyCreatePayment.effectiveDate
                && this.gateway == proxyCreatePayment.gateway
                && this.gatewayOptionData == proxyCreatePayment.gatewayOptionData
                && this.gatewayOrderId == proxyCreatePayment.gatewayOrderId
                && this.gatewayResponse == proxyCreatePayment.gatewayResponse
                && this.gatewayResponseCode == proxyCreatePayment.gatewayResponseCode
                && this.gatewayState == proxyCreatePayment.gatewayState
                && this.invoiceId == proxyCreatePayment.invoiceId
                && this.invoiceNumber == proxyCreatePayment.invoiceNumber
                && this.invoicePaymentData == proxyCreatePayment.invoicePaymentData
                && this.paymentMethodId == proxyCreatePayment.paymentMethodId
                && this.paymentNumber == proxyCreatePayment.paymentNumber
                && this.referenceId == proxyCreatePayment.referenceId
                && this.softDescriptor == proxyCreatePayment.softDescriptor
                && this.softDescriptorPhone == proxyCreatePayment.softDescriptorPhone
                && this.status == proxyCreatePayment.status
                && this.r_type == proxyCreatePayment.r_type;
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
        hashCode = (17 * hashCode) + (accountingCode == null ? 0 : System.hashCode(accountingCode));
        hashCode = (17 * hashCode) + (amount == null ? 0 : System.hashCode(amount));
        hashCode = (17 * hashCode) + (appliedCreditBalanceAmount == null ? 0 : System.hashCode(appliedCreditBalanceAmount));
        hashCode = (17 * hashCode) + (appliedInvoiceAmount == null ? 0 : System.hashCode(appliedInvoiceAmount));
        hashCode = (17 * hashCode) + (authTransactionId == null ? 0 : System.hashCode(authTransactionId));
        hashCode = (17 * hashCode) + (comment == null ? 0 : System.hashCode(comment));
        hashCode = (17 * hashCode) + (effectiveDate == null ? 0 : System.hashCode(effectiveDate));
        hashCode = (17 * hashCode) + (gateway == null ? 0 : System.hashCode(gateway));
        hashCode = (17 * hashCode) + (gatewayOptionData == null ? 0 : System.hashCode(gatewayOptionData));
        hashCode = (17 * hashCode) + (gatewayOrderId == null ? 0 : System.hashCode(gatewayOrderId));
        hashCode = (17 * hashCode) + (gatewayResponse == null ? 0 : System.hashCode(gatewayResponse));
        hashCode = (17 * hashCode) + (gatewayResponseCode == null ? 0 : System.hashCode(gatewayResponseCode));
        hashCode = (17 * hashCode) + (gatewayState == null ? 0 : System.hashCode(gatewayState));
        hashCode = (17 * hashCode) + (invoiceId == null ? 0 : System.hashCode(invoiceId));
        hashCode = (17 * hashCode) + (invoiceNumber == null ? 0 : System.hashCode(invoiceNumber));
        hashCode = (17 * hashCode) + (invoicePaymentData == null ? 0 : System.hashCode(invoicePaymentData));
        hashCode = (17 * hashCode) + (paymentMethodId == null ? 0 : System.hashCode(paymentMethodId));
        hashCode = (17 * hashCode) + (paymentNumber == null ? 0 : System.hashCode(paymentNumber));
        hashCode = (17 * hashCode) + (referenceId == null ? 0 : System.hashCode(referenceId));
        hashCode = (17 * hashCode) + (softDescriptor == null ? 0 : System.hashCode(softDescriptor));
        hashCode = (17 * hashCode) + (softDescriptorPhone == null ? 0 : System.hashCode(softDescriptorPhone));
        hashCode = (17 * hashCode) + (status == null ? 0 : System.hashCode(status));
        hashCode = (17 * hashCode) + (r_type == null ? 0 : System.hashCode(r_type));
        return hashCode;
    }
}