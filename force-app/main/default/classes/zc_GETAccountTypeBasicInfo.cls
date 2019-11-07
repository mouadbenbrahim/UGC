/**
 * Container for basic information about the account.\n
 */
public class zc_GETAccountTypeBasicInfo {
    /**
     * Value of the Class field for the corresponding customer account in NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return classNS
     */
    public String classNS { get; set; }

    /**
     * Value of the Customer Type field for the corresponding customer account in NetSuite. The Customer Type field is used when the customer account is created in NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     */
    public enum CustomerTypeNSEnum {
        COMPANY,
        INDIVIDUAL
    }

    /**
     * Value of the Customer Type field for the corresponding customer account in NetSuite. The Customer Type field is used when the customer account is created in NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return customerTypeNS
     */
    public CustomerTypeNSEnum customerTypeNS { get; set; }

    /**
     * Value of the Department field for the corresponding customer account in NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return departmentNS
     */
    public String departmentNS { get; set; }

    /**
     * ID of the corresponding object in NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return integrationIdNS
     */
    public String integrationIdNS { get; set; }

    /**
     * Status of the account\'s synchronization with NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return integrationStatusNS
     */
    public String integrationStatusNS { get; set; }

    /**
     * Value of the Location field for the corresponding customer account in NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return locationNS
     */
    public String locationNS { get; set; }

    /**
     * Value of the Subsidiary field for the corresponding customer account in NetSuite. The Subsidiary field is required if you use NetSuite OneWorld. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return subsidiaryNS
     */
    public String subsidiaryNS { get; set; }

    /**
     * Date when the account was sychronized with NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return syncDateNS
     */
    public String syncDateNS { get; set; }

    /**
     * Specifies whether the account should be synchronized with NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     */
    public enum SynctoNetSuiteNSEnum {
        YES,
        NO
    }

    /**
     * Specifies whether the account should be synchronized with NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return synctoNetSuiteNS
     */
    public SynctoNetSuiteNSEnum synctoNetSuiteNS { get; set; }

    /**
     * Account number.\n
     * @return accountNumber
     */
    public String accountNumber { get; set; }

    /**
     * The alias name given to a batch. A string of 50 characters or less.\n
     * @return batch
     */
    public String batch { get; set; }

    /**
     * ID of a communication profile.\n
     * @return communicationProfileId
     */
    public String communicationProfileId { get; set; }

    /**
     * **Note**: This field is only available if you have the Invoice Settlement feature enabled. The Invoice Settlement feature is in **Limited Availability**. If you wish to have access to the feature, submit a request at [Zuora Global Support](http://support.zuora.com/).\n\nThe unique ID of the credit memo template, configured in **Billing Settings** > **Manage Billing Document Configuration** through the Zuora UI. For example, 2c92c08a6246fdf101626b1b3fe0144b.\n
     * @return creditMemoTemplateId
     */
    public String creditMemoTemplateId { get; set; }

    /**
     * CRM account ID for the account, up to 100 characters.\n
     * @return crmId
     */
    public String crmId { get; set; }

    /**
     * A currency2 as defined in Billing Settings in the Zuora UI.\n
     * @return currency2
     */
    public String currency2 { get; set; }

    /**
     * **Note**: This field is only available if you have the Invoice Settlement feature enabled. The Invoice Settlement feature is in **Limited Availability**. If you wish to have access to the feature, submit a request at [Zuora Global Support](http://support.zuora.com/).\n\nThe unique ID of the debit memo template, configured in **Billing Settings** > **Manage Billing Document Configuration** through the Zuora UI. For example, 2c92c08d62470a8501626b19d24f19e2.\n
     * @return debitMemoTemplateId
     */
    public String debitMemoTemplateId { get; set; }

    /**
     * Account ID.\n
     * @return id
     */
    public String id { get; set; }

    /**
     * Invoice template ID, configured in Billing Settings in the Zuora UI.\n
     * @return invoiceTemplateId
     */
    public String invoiceTemplateId { get; set; }

    /**
     * Account name.\n
     * @return name
     */
    public String name { get; set; }

    /**
     * Notes associated with the account, up to 65,535 characters.\n
     * @return notes
     */
    public String notes { get; set; }

    /**
     * Identifier of the parent customer account for this Account object. The length is 32 characters. Use this field if you have customer hierarchy enabled.
     * @return parentId
     */
    public String parentId { get; set; }

    /**
     * The name of the sales representative associated with this account, if applicable. Maximum of 50 characters.
     * @return salesRep
     */
    public String salesRep { get; set; }

    /**
     * The ID of the billing document sequence set that is assigned to the customer account. \n
     * @return sequenceSetId
     */
    public String sequenceSetId { get; set; }

    /**
     * Account status; possible values are: `Active`, `Draft`, `Canceled`.\n
     * @return status
     */
    public String status { get; set; }

    /**
     * 
     * @return tags
     */
    public String tags { get; set; }

    private static final Map<String, String> propertyMappings = new Map<String, String>{
        'Class__NS' => 'classNS',
        'CustomerType__NS' => 'customerTypeNS',
        'Department__NS' => 'departmentNS',
        'IntegrationId__NS' => 'integrationIdNS',
        'IntegrationStatus__NS' => 'integrationStatusNS',
        'Location__NS' => 'locationNS',
        'Subsidiary__NS' => 'subsidiaryNS',
        'SyncDate__NS' => 'syncDateNS',
        'SynctoNetSuite__NS' => 'synctoNetSuiteNS',
        'currency' => 'currency2'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    // public static zc_GETAccountTypeBasicInfo getExample() {
    //     zc_GETAccountTypeBasicInfo geTAccountTypeBasicInfo = new zc_GETAccountTypeBasicInfo();
    //     geTAccountTypeBasicInfo.classNS = 'aeiou';
    //     geTAccountTypeBasicInfo.customerTypeNS = CustomerTypeNSEnum.COMPANY;
    //     geTAccountTypeBasicInfo.departmentNS = 'aeiou';
    //     geTAccountTypeBasicInfo.integrationIdNS = 'aeiou';
    //     geTAccountTypeBasicInfo.integrationStatusNS = 'aeiou';
    //     geTAccountTypeBasicInfo.locationNS = 'aeiou';
    //     geTAccountTypeBasicInfo.subsidiaryNS = 'aeiou';
    //     geTAccountTypeBasicInfo.syncDateNS = 'aeiou';
    //     geTAccountTypeBasicInfo.synctoNetSuiteNS = SynctoNetSuiteNSEnum.YES;
    //     geTAccountTypeBasicInfo.accountNumber = 'aeiou';
    //     geTAccountTypeBasicInfo.batch = 'aeiou';
    //     geTAccountTypeBasicInfo.communicationProfileId = 'aeiou';
    //     geTAccountTypeBasicInfo.creditMemoTemplateId = 'aeiou';
    //     geTAccountTypeBasicInfo.crmId = 'aeiou';
    //     geTAccountTypeBasicInfo.currency2 = 'aeiou';
    //     geTAccountTypeBasicInfo.debitMemoTemplateId = 'aeiou';
    //     geTAccountTypeBasicInfo.id = 'aeiou';
    //     geTAccountTypeBasicInfo.invoiceTemplateId = 'aeiou';
    //     geTAccountTypeBasicInfo.name = 'aeiou';
    //     geTAccountTypeBasicInfo.notes = 'aeiou';
    //     geTAccountTypeBasicInfo.parentId = 'aeiou';
    //     geTAccountTypeBasicInfo.salesRep = 'aeiou';
    //     geTAccountTypeBasicInfo.sequenceSetId = 'aeiou';
    //     geTAccountTypeBasicInfo.status = 'aeiou';
    //     geTAccountTypeBasicInfo.tags = 'aeiou';
    //     return geTAccountTypeBasicInfo;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_GETAccountTypeBasicInfo) {
            zc_GETAccountTypeBasicInfo geTAccountTypeBasicInfo = (zc_GETAccountTypeBasicInfo) obj;
            return this.classNS == geTAccountTypeBasicInfo.classNS
                && this.customerTypeNS == geTAccountTypeBasicInfo.customerTypeNS
                && this.departmentNS == geTAccountTypeBasicInfo.departmentNS
                && this.integrationIdNS == geTAccountTypeBasicInfo.integrationIdNS
                && this.integrationStatusNS == geTAccountTypeBasicInfo.integrationStatusNS
                && this.locationNS == geTAccountTypeBasicInfo.locationNS
                && this.subsidiaryNS == geTAccountTypeBasicInfo.subsidiaryNS
                && this.syncDateNS == geTAccountTypeBasicInfo.syncDateNS
                && this.synctoNetSuiteNS == geTAccountTypeBasicInfo.synctoNetSuiteNS
                && this.accountNumber == geTAccountTypeBasicInfo.accountNumber
                && this.batch == geTAccountTypeBasicInfo.batch
                && this.communicationProfileId == geTAccountTypeBasicInfo.communicationProfileId
                && this.creditMemoTemplateId == geTAccountTypeBasicInfo.creditMemoTemplateId
                && this.crmId == geTAccountTypeBasicInfo.crmId
                && this.currency2 == geTAccountTypeBasicInfo.currency2
                && this.debitMemoTemplateId == geTAccountTypeBasicInfo.debitMemoTemplateId
                && this.id == geTAccountTypeBasicInfo.id
                && this.invoiceTemplateId == geTAccountTypeBasicInfo.invoiceTemplateId
                && this.name == geTAccountTypeBasicInfo.name
                && this.notes == geTAccountTypeBasicInfo.notes
                && this.parentId == geTAccountTypeBasicInfo.parentId
                && this.salesRep == geTAccountTypeBasicInfo.salesRep
                && this.sequenceSetId == geTAccountTypeBasicInfo.sequenceSetId
                && this.status == geTAccountTypeBasicInfo.status
                && this.tags == geTAccountTypeBasicInfo.tags;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (classNS == null ? 0 : System.hashCode(classNS));
        hashCode = (17 * hashCode) + (customerTypeNS == null ? 0 : System.hashCode(customerTypeNS));
        hashCode = (17 * hashCode) + (departmentNS == null ? 0 : System.hashCode(departmentNS));
        hashCode = (17 * hashCode) + (integrationIdNS == null ? 0 : System.hashCode(integrationIdNS));
        hashCode = (17 * hashCode) + (integrationStatusNS == null ? 0 : System.hashCode(integrationStatusNS));
        hashCode = (17 * hashCode) + (locationNS == null ? 0 : System.hashCode(locationNS));
        hashCode = (17 * hashCode) + (subsidiaryNS == null ? 0 : System.hashCode(subsidiaryNS));
        hashCode = (17 * hashCode) + (syncDateNS == null ? 0 : System.hashCode(syncDateNS));
        hashCode = (17 * hashCode) + (synctoNetSuiteNS == null ? 0 : System.hashCode(synctoNetSuiteNS));
        hashCode = (17 * hashCode) + (accountNumber == null ? 0 : System.hashCode(accountNumber));
        hashCode = (17 * hashCode) + (batch == null ? 0 : System.hashCode(batch));
        hashCode = (17 * hashCode) + (communicationProfileId == null ? 0 : System.hashCode(communicationProfileId));
        hashCode = (17 * hashCode) + (creditMemoTemplateId == null ? 0 : System.hashCode(creditMemoTemplateId));
        hashCode = (17 * hashCode) + (crmId == null ? 0 : System.hashCode(crmId));
        hashCode = (17 * hashCode) + (currency2 == null ? 0 : System.hashCode(currency2));
        hashCode = (17 * hashCode) + (debitMemoTemplateId == null ? 0 : System.hashCode(debitMemoTemplateId));
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
        hashCode = (17 * hashCode) + (invoiceTemplateId == null ? 0 : System.hashCode(invoiceTemplateId));
        hashCode = (17 * hashCode) + (name == null ? 0 : System.hashCode(name));
        hashCode = (17 * hashCode) + (notes == null ? 0 : System.hashCode(notes));
        hashCode = (17 * hashCode) + (parentId == null ? 0 : System.hashCode(parentId));
        hashCode = (17 * hashCode) + (salesRep == null ? 0 : System.hashCode(salesRep));
        hashCode = (17 * hashCode) + (sequenceSetId == null ? 0 : System.hashCode(sequenceSetId));
        hashCode = (17 * hashCode) + (status == null ? 0 : System.hashCode(status));
        hashCode = (17 * hashCode) + (tags == null ? 0 : System.hashCode(tags));
        return hashCode;
    }
}