/**
 * zc_PostNonRefRefundType
 */
public class zc_PostNonRefRefundType {
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
     * Comments about the refund.\n
     * @return comment
     */
    public String comment { get; set; }

    /**
     * Get financeInformation
     * @return financeInformation
     */
    public zc_PostNonRefRefundTypeFinanceInfor financeInformation { get; set; }

    /**
     * The ID of the gateway instance that processes the refund. This field can be specified only for electronic refunds. The ID must be a valid gateway instance ID, and this gateway must support the specific payment method. \n\nIf no gateway ID is specified, the default gateway in the billing account configuration will be used. If no gateway is specified in the billing account, the default gateway of the corresponding tenant will be used.\n
     * @return gatewayId
     */
    public String gatewayId { get; set; }

    /**
     * Container for credit memo items.\n\n**Note:** The Invoice Item Settlement feature is in **Limited Availability**. If you wish to have access to the feature, submit a request at [Zuora Global Support](http://support.zuora.com/).\n
     * @return items
     */
    public List<zc_RefundCreditMemoItemType> items { get; set; }

    /**
     * How an external refund was issued to a customer. This field is required for an external refund and must be left empty for an electronic refund. You can issue an external refund on a credit memo.\n
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
        Other
    }

    /**
     * How an external refund was issued to a customer. This field is required for an external refund and must be left empty for an electronic refund. You can issue an external refund on a credit memo.\n
     * @return methodType
     */
    public String methodType { get; set; }

    /**
     * The ID of the payment method used for the refund. This field is required for an electronic refund, and the value must be an electronic payment method ID. This field must be left empty for an external refund. \n
     * @return paymentMethodId
     */
    public String paymentMethodId { get; set; }

    /**
     * A code identifying the reason for the transaction. The value must be an existing reason code or empty. If you do not specify a value, Zuora uses the default reason code.\n
     * @return reasonCode
     */
    public String reasonCode { get; set; }

    /**
     * The transaction ID returned by the payment gateway for an electronic refund. Use this field to reconcile refunds between your gateway and Zuora Payments.\n
     * @return referenceId
     */
    public String referenceId { get; set; }

    /**
     * The date when the refund takes effect, in `yyyy-mm-dd` format. The date of the refund cannot be before the credit memo date. Specify this field only for external refunds. Zuora automatically generates this field for electronic refunds.\n
     * @return refundDate
     */
    public Date refundDate { get; set; }

    /**
     * The transaction ID returned by the payment gateway if there is an additional transaction for the refund. Use this field to reconcile payments between your gateway and Zuora Payments.\n
     * @return secondRefundReferenceId
     */
    public String secondRefundReferenceId { get; set; }

    /**
     * The total amount of the refund. The amount cannot exceed the unapplied amount of the associated credit memo. If the original credit memo was applied to one or more invoices or debit memos, you have to unapply a full or partial credit memo from the invoices or debit memos, and then refund the full or partial unapplied credit memo to your customers.\n
     * @return totalAmount
     */
    public Double totalAmount { get; set; }

    /**
     * The type of the refund.\n
     */
    public enum RTypeEnum {
        External,
        Electronic
    }

    /**
     * The type of the refund.\n
     * @return r_type
     */
    public String r_type { get; set; }

    //add MBE
    public String exclusionCompta { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'IntegrationId__NS' => 'integrationIdNS',
        'IntegrationStatus__NS' => 'integrationStatusNS',
        'Origin__NS' => 'originNS',
        'SyncDate__NS' => 'syncDateNS',
        'SynctoNetSuite__NS' => 'synctoNetSuiteNS',
        'type' => 'r_type',
        'ExclusionCompta__c' => 'exclusionCompta'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public zc_PostNonRefRefundType() {
        items = new List<zc_RefundCreditMemoItemType>();
    }

    // public static zc_PostNonRefRefundType getExample() {
    //     zc_PostNonRefRefundType postNonRefRefundType = new zc_PostNonRefRefundType();
    //     postNonRefRefundType.integrationIdNS = 'aeiou';
    //     postNonRefRefundType.integrationStatusNS = 'aeiou';
    //     postNonRefRefundType.originNS = 'aeiou';
    //     postNonRefRefundType.syncDateNS = 'aeiou';
    //     postNonRefRefundType.synctoNetSuiteNS = 'aeiou';
    //     postNonRefRefundType.comment = 'aeiou';
    //     postNonRefRefundType.financeInformation = zc_PostNonRefRefundTypeFinanceInfor.getExample();
    //     postNonRefRefundType.gatewayId = 'aeiou';
    //     postNonRefRefundType.items = new List<zc_RefundCreditMemoItemType>{zc_RefundCreditMemoItemType.getExample()};
    //     postNonRefRefundType.methodType = MethodTypeEnum.ACH;
    //     postNonRefRefundType.paymentMethodId = 'aeiou';
    //     postNonRefRefundType.reasonCode = 'aeiou';
    //     postNonRefRefundType.referenceId = 'aeiou';
    //     postNonRefRefundType.refundDate = Date.newInstance(2000, 1, 23);
    //     postNonRefRefundType.secondRefundReferenceId = 'aeiou';
    //     postNonRefRefundType.totalAmount = 1.3579;
    //     postNonRefRefundType.r_type = RTypeEnum.EXTERNAL;
    //     return postNonRefRefundType;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_PostNonRefRefundType) {
            zc_PostNonRefRefundType postNonRefRefundType = (zc_PostNonRefRefundType) obj;
            return this.integrationIdNS == postNonRefRefundType.integrationIdNS
                && this.integrationStatusNS == postNonRefRefundType.integrationStatusNS
                && this.originNS == postNonRefRefundType.originNS
                && this.syncDateNS == postNonRefRefundType.syncDateNS
                && this.synctoNetSuiteNS == postNonRefRefundType.synctoNetSuiteNS
                && this.comment == postNonRefRefundType.comment
                && this.financeInformation == postNonRefRefundType.financeInformation
                && this.gatewayId == postNonRefRefundType.gatewayId
                && this.items == postNonRefRefundType.items
                && this.methodType == postNonRefRefundType.methodType
                && this.paymentMethodId == postNonRefRefundType.paymentMethodId
                && this.reasonCode == postNonRefRefundType.reasonCode
                && this.referenceId == postNonRefRefundType.referenceId
                && this.refundDate == postNonRefRefundType.refundDate
                && this.secondRefundReferenceId == postNonRefRefundType.secondRefundReferenceId
                && this.totalAmount == postNonRefRefundType.totalAmount
                && this.r_type == postNonRefRefundType.r_type;
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
        hashCode = (17 * hashCode) + (comment == null ? 0 : System.hashCode(comment));
        hashCode = (17 * hashCode) + (financeInformation == null ? 0 : System.hashCode(financeInformation));
        hashCode = (17 * hashCode) + (gatewayId == null ? 0 : System.hashCode(gatewayId));
        hashCode = (17 * hashCode) + (items == null ? 0 : System.hashCode(items));
        hashCode = (17 * hashCode) + (methodType == null ? 0 : System.hashCode(methodType));
        hashCode = (17 * hashCode) + (paymentMethodId == null ? 0 : System.hashCode(paymentMethodId));
        hashCode = (17 * hashCode) + (reasonCode == null ? 0 : System.hashCode(reasonCode));
        hashCode = (17 * hashCode) + (referenceId == null ? 0 : System.hashCode(referenceId));
        hashCode = (17 * hashCode) + (refundDate == null ? 0 : System.hashCode(refundDate));
        hashCode = (17 * hashCode) + (secondRefundReferenceId == null ? 0 : System.hashCode(secondRefundReferenceId));
        hashCode = (17 * hashCode) + (totalAmount == null ? 0 : System.hashCode(totalAmount));
        hashCode = (17 * hashCode) + (r_type == null ? 0 : System.hashCode(r_type));
        return hashCode;
    }
}