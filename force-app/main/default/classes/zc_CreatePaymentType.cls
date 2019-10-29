/**
 * zc_CreatePaymentType
 */
public class zc_CreatePaymentType implements zc_Zuc.MappedProperties { // zc_PaymentObjectNSFields, zc_PaymentObjectCustomFields, 
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
     * The ID of the customer account that the payment is created for.\n
     * @return accountId
     */
    public String accountId { get; set; }

    /**
     * The total amount of the payment.\n
     * @return amount
     */
    public Double amount { get; set; }

    /**
     * Additional information related to the payment.\n
     * @return comment
     */
    public String comment { get; set; }

    /**
     * A currency defined in the web-based UI administrative settings.\n
     * @return currency
     */
    public String currency2 { get; set; }

    /**
     * Container for debit memos.\n
     * @return debitMemos
     */
    public List<zc_PaymentDebitMemoApplicationCreat> debitMemos { get; set; }

    /**
     * The date when the payment takes effect, in `yyyy-mm-dd` format.\n
     * @return effectiveDate
     */
    public Date effectiveDate { get; set; }

    /**
     * Get financeInformation
     * @return financeInformation
     */
    public zc_CreatePaymentTypeFinanceInformat financeInformation { get; set; }

    /**
     * The ID of the gateway instance that processes the payment. The ID must be a valid gateway instance ID and this gateway must support the specific payment method. \n\n- When creating electronic payments, this field is required. \n- When creating external payments, this field is optional.\n
     * @return gatewayId
     */
    public String gatewayId { get; set; }

    /**
     * Container for invoices.\n
     * @return invoices
     */
    public List<zc_PaymentInvoiceApplicationCreateR> invoices { get; set; }

    /**
     * The unique ID of the payment method that the customer used to make the payment. \n\nIf no payment method ID is specified in the request body, the default payment method for the customer account is used automatically. If the default payment method is different from the type of payments that you want to create, an error occurs.\n
     * @return paymentMethodId
     */
    public String paymentMethodId { get; set; }

    /**
     * The transaction ID returned by the payment gateway. Use this field to reconcile payments between your gateway and Zuora Payments.\n
     * @return referenceId
     */
    public String referenceId { get; set; }

    /**
     * The type of the payment.\n
     */
    public enum RTypeEnum {
        External,
        Electronic
    }

    /**
     * The type of the payment.\n
     * @return r_type
     */
    public RTypeEnum r_type { get; set; }

    // Custom fields
    public String lieu { get; set; }
    public String methodePaiement { get; set; }
    public String agent { get; set; }
    public String dateVirement { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'IntegrationId__NS' => 'integrationIdNS',
        'IntegrationStatus__NS' => 'integrationStatusNS',
        'Origin__NS' => 'originNS',
        'SyncDate__NS' => 'syncDateNS',
        'Transaction__NS' => 'transactionNS',
        'type' => 'r_type',
        'currency' => 'currency2',
        'Lieu__c' => 'lieu',
        'MethodePaiement__c' => 'methodePaiement',
        'Agent__c' => 'agent',
        'DateVirement__c' => 'dateVirement'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public zc_CreatePaymentType() {
        debitMemos = new List<zc_PaymentDebitMemoApplicationCreat>();
        invoices = new List<zc_PaymentInvoiceApplicationCreateR>();
    }

    // public static zc_CreatePaymentType getExample() {
    //     zc_CreatePaymentType createPaymentType = new zc_CreatePaymentType();
    //     createPaymentType.integrationIdNS = 'aeiou';
    //     createPaymentType.integrationStatusNS = 'aeiou';
    //     createPaymentType.originNS = 'aeiou';
    //     createPaymentType.syncDateNS = 'aeiou';
    //     createPaymentType.transactionNS = 'aeiou';
    //     createPaymentType.accountId = 'aeiou';
    //     createPaymentType.amount = 1.3579;
    //     createPaymentType.comment = 'aeiou';
    //     createPaymentType.currency = 'aeiou';
    //     createPaymentType.debitMemos = new List<zc_PaymentDebitMemoApplicationCreat>{zc_PaymentDebitMemoApplicationCreat.getExample()};
    //     createPaymentType.effectiveDate = Date.newInstance(2000, 1, 23);
    //     createPaymentType.financeInformation = zc_CreatePaymentTypeFinanceInformat.getExample();
    //     createPaymentType.gatewayId = 'aeiou';
    //     createPaymentType.invoices = new List<zc_PaymentInvoiceApplicationCreateR>{zc_PaymentInvoiceApplicationCreateR.getExample()};
    //     createPaymentType.paymentMethodId = 'aeiou';
    //     createPaymentType.referenceId = 'aeiou';
    //     createPaymentType.r_type = RTypeEnum.EXTERNAL;
    //     return createPaymentType;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_CreatePaymentType) {
            zc_CreatePaymentType createPaymentType = (zc_CreatePaymentType) obj;
            return this.integrationIdNS == createPaymentType.integrationIdNS
                && this.integrationStatusNS == createPaymentType.integrationStatusNS
                && this.originNS == createPaymentType.originNS
                && this.syncDateNS == createPaymentType.syncDateNS
                && this.transactionNS == createPaymentType.transactionNS
                && this.accountId == createPaymentType.accountId
                && this.amount == createPaymentType.amount
                && this.comment == createPaymentType.comment
                && this.currency2 == createPaymentType.currency2
                && this.debitMemos == createPaymentType.debitMemos
                && this.effectiveDate == createPaymentType.effectiveDate
                && this.financeInformation == createPaymentType.financeInformation
                && this.gatewayId == createPaymentType.gatewayId
                && this.invoices == createPaymentType.invoices
                && this.paymentMethodId == createPaymentType.paymentMethodId
                && this.referenceId == createPaymentType.referenceId
                && this.r_type == createPaymentType.r_type;
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
        hashCode = (17 * hashCode) + (comment == null ? 0 : System.hashCode(comment));
        hashCode = (17 * hashCode) + (currency2 == null ? 0 : System.hashCode(currency2));
        hashCode = (17 * hashCode) + (debitMemos == null ? 0 : System.hashCode(debitMemos));
        hashCode = (17 * hashCode) + (effectiveDate == null ? 0 : System.hashCode(effectiveDate));
        hashCode = (17 * hashCode) + (financeInformation == null ? 0 : System.hashCode(financeInformation));
        hashCode = (17 * hashCode) + (gatewayId == null ? 0 : System.hashCode(gatewayId));
        hashCode = (17 * hashCode) + (invoices == null ? 0 : System.hashCode(invoices));
        hashCode = (17 * hashCode) + (paymentMethodId == null ? 0 : System.hashCode(paymentMethodId));
        hashCode = (17 * hashCode) + (referenceId == null ? 0 : System.hashCode(referenceId));
        hashCode = (17 * hashCode) + (r_type == null ? 0 : System.hashCode(r_type));
        return hashCode;
    }
}