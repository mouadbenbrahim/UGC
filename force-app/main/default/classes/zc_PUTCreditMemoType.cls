/**
 * zc_PUTCreditMemoType
 */
public class zc_PUTCreditMemoType  {
    /**
     * ID of the corresponding object in NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return integrationIdNS
     */
    public String integrationIdNS { get; set; }

    /**
     * Status of the credit memo\'s synchronization with NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return integrationStatusNS
     */
    public String integrationStatusNS { get; set; }

    /**
     * Origin of the corresponding object in NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return originNS
     */
    public String originNS { get; set; }

    /**
     * Date when the credit memo was synchronized with NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return syncDateNS
     */
    public String syncDateNS { get; set; }

    /**
     * Related transaction in NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return transactionNS
     */
    public String transactionNS { get; set; }

    /**
     * Whether the credit memo automatically applies to the invoice upon posting.\n
     * @return autoApplyUponPosting
     */
    public Boolean autoApplyUponPosting { get; set; }

    /**
     * Comments about the credit memo.\n
     * @return comment
     */
    public String comment { get; set; }

    /**
     * The date when the credit memo takes effect.\n
     * @return effectiveDate
     */
    public Date effectiveDate { get; set; }

    /**
     * Whether the credit memo is excluded from the rule of automatically applying credit memos to invoices.\n
     * @return excludeFromAutoApplyRules
     */
    public Boolean excludeFromAutoApplyRules { get; set; }

    /**
     * Container for credit memo items.\n
     * @return items
     */
    public List<zc_PUTCreditMemoItemType> items { get; set; }

    /**
     * A code identifying the reason for the transaction. The value must be an existing reason code or empty. If you do not specify a value, Zuora uses the default reason code.\n
     * @return reasonCode
     */
    public String reasonCode { get; set; }
    
    //add MBE
    public String exclusionCompta { get; set; }
    

    /**
     * Whether the credit memo is transferred to an external accounting system. Use this field for integration with accounting systems, such as NetSuite. \n
     */
    public enum TransferredToAccountingEnum {
        PROCESSING,
        YES,
        NO,
        ERROR,
        IGNORE
    }

    /**
     * Whether the credit memo is transferred to an external accounting system. Use this field for integration with accounting systems, such as NetSuite. \n
     * @return transferredToAccounting
     */
    public TransferredToAccountingEnum transferredToAccounting { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'IntegrationId__NS' => 'integrationIdNS',
        'IntegrationStatus__NS' => 'integrationStatusNS',
        'Origin__NS' => 'originNS',
        'SyncDate__NS' => 'syncDateNS',
        'Transaction__NS' => 'transactionNS',
        'ExclusionCompta__c' => 'exclusionCompta'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public zc_PUTCreditMemoType() {
        items = new List<zc_PUTCreditMemoItemType>();
    }

    // public static zc_PUTCreditMemoType getExample() {
    //     zc_PUTCreditMemoType puTCreditMemoType = new zc_PUTCreditMemoType();
    //     puTCreditMemoType.integrationIdNS = 'aeiou';
    //     puTCreditMemoType.integrationStatusNS = 'aeiou';
    //     puTCreditMemoType.originNS = 'aeiou';
    //     puTCreditMemoType.syncDateNS = 'aeiou';
    //     puTCreditMemoType.transactionNS = 'aeiou';
    //     puTCreditMemoType.autoApplyUponPosting = true;
    //     puTCreditMemoType.comment = 'aeiou';
    //     puTCreditMemoType.effectiveDate = Date.newInstance(2000, 1, 23);
    //     puTCreditMemoType.excludeFromAutoApplyRules = true;
    //     puTCreditMemoType.items = new List<zc_PUTCreditMemoItemType>{zc_PUTCreditMemoItemType.getExample()};
    //     puTCreditMemoType.reasonCode = 'aeiou';
    //     puTCreditMemoType.transferredToAccounting = TransferredToAccountingEnum.PROCESSING;
    //     return puTCreditMemoType;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_PUTCreditMemoType) {
            zc_PUTCreditMemoType puTCreditMemoType = (zc_PUTCreditMemoType) obj;
            return this.integrationIdNS == puTCreditMemoType.integrationIdNS
                && this.integrationStatusNS == puTCreditMemoType.integrationStatusNS
                && this.originNS == puTCreditMemoType.originNS
                && this.syncDateNS == puTCreditMemoType.syncDateNS
                && this.transactionNS == puTCreditMemoType.transactionNS
                && this.autoApplyUponPosting == puTCreditMemoType.autoApplyUponPosting
                && this.comment == puTCreditMemoType.comment
                && this.effectiveDate == puTCreditMemoType.effectiveDate
                && this.excludeFromAutoApplyRules == puTCreditMemoType.excludeFromAutoApplyRules
                && this.items == puTCreditMemoType.items
                && this.reasonCode == puTCreditMemoType.reasonCode
                && this.transferredToAccounting == puTCreditMemoType.transferredToAccounting;
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
        hashCode = (17 * hashCode) + (autoApplyUponPosting == null ? 0 : System.hashCode(autoApplyUponPosting));
        hashCode = (17 * hashCode) + (comment == null ? 0 : System.hashCode(comment));
        hashCode = (17 * hashCode) + (effectiveDate == null ? 0 : System.hashCode(effectiveDate));
        hashCode = (17 * hashCode) + (excludeFromAutoApplyRules == null ? 0 : System.hashCode(excludeFromAutoApplyRules));
        hashCode = (17 * hashCode) + (items == null ? 0 : System.hashCode(items));
        hashCode = (17 * hashCode) + (reasonCode == null ? 0 : System.hashCode(reasonCode));
        hashCode = (17 * hashCode) + (transferredToAccounting == null ? 0 : System.hashCode(transferredToAccounting));
        return hashCode;
    }
}