/**
 * Container for basic information about the account.\n
 */
public class zc_GETAccountSummaryTypeBasicInfo {
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
     * A list of additional email addresses to receive emailed invoices.\n
     * @return additionalEmailAddresses
     */
    public List<String> additionalEmailAddresses { get; set; }

    /**
     * Current outstanding balance.\n
     * @return balance
     */
    public String balance { get; set; }

    /**
     * The alias name given to a batch. A string of 50 characters or less.\n
     * @return batch
     */
    public String batch { get; set; }

    /**
     * Billing cycle day (BCD), the day of the month when a bill run generates invoices for the account.\n
     * @return billCycleDay
     */
    public String billCycleDay { get; set; }

    /**
     * A currency as defined in Billing Settings in the Zuora UI.\n
     * @return currency
     */
    public String currency2 { get; set; }

    /**
     * Get defaultPaymentMethod
     * @return defaultPaymentMethod
     */
    public zc_GETAccountSummaryTypeBasicInfoDe defaultPaymentMethod { get; set; }

    /**
     * Account ID.\n
     * @return id
     */
    public String id { get; set; }

    /**
     * Whether the customer wants to receive invoices through email. \n
     * @return invoiceDeliveryPrefsEmail
     */
    public Boolean invoiceDeliveryPrefsEmail { get; set; }

    /**
     * Whether the customer wants to receive printed invoices, such as through postal mail.\n
     * @return invoiceDeliveryPrefsPrint
     */
    public Boolean invoiceDeliveryPrefsPrint { get; set; }

    /**
     * Date of the most recent invoice for the account; null if no invoice has ever been generated.\n
     * @return lastInvoiceDate
     */
    public Date lastInvoiceDate { get; set; }

    /**
     * Amount of the most recent payment collected for the account; null if no payment has ever been collected.\n
     * @return lastPaymentAmount
     */
    public String lastPaymentAmount { get; set; }

    /**
     * Date of the most recent payment collected for the account. Null if no payment has ever been collected.\n
     * @return lastPaymentDate
     */
    public Date lastPaymentDate { get; set; }

    /**
     * Account name.\n
     * @return name
     */
    public String name { get; set; }

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

    //MBEN:
    public String source { get; set; }
    
    //MNE
    public String LegacyExternalID { get; set; }
    public String Id_MonCompte { get; set; }
	public String DateNaissance { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Class__NS' => 'classNS',
        'CustomerType__NS' => 'customerTypeNS',
        'Department__NS' => 'departmentNS',
        'IntegrationId__NS' => 'integrationIdNS',
        'IntegrationStatus__NS' => 'integrationStatusNS',
        'Location__NS' => 'locationNS',
        'Subsidiary__NS' => 'subsidiaryNS',
        'SyncDate__NS' => 'syncDateNS',
        'SynctoNetSuite__NS' => 'synctoNetSuiteNS',
        'currency' => 'currency2',
        'Source__c' => 'source',
        'LegacyExternalID' => 'LegacyExternalID__c',
        'Id_MonCompte' => 'Id_MonCompte__c',
		'DateNaissance' => 'DateNaissance__c'
        
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public zc_GETAccountSummaryTypeBasicInfo() {
        additionalEmailAddresses = new List<String>();
        defaultPaymentMethod = new zc_GETAccountSummaryTypeBasicInfoDe();
    }

    // public static zc_GETAccountSummaryTypeBasicInfo getExample() {
    //     zc_GETAccountSummaryTypeBasicInfo geTAccountSummaryTypeBasicInfo = new zc_GETAccountSummaryTypeBasicInfo();
    //     geTAccountSummaryTypeBasicInfo.classNS = 'aeiou';
    //     geTAccountSummaryTypeBasicInfo.customerTypeNS = CustomerTypeNSEnum.COMPANY;
    //     geTAccountSummaryTypeBasicInfo.departmentNS = 'aeiou';
    //     geTAccountSummaryTypeBasicInfo.integrationIdNS = 'aeiou';
    //     geTAccountSummaryTypeBasicInfo.integrationStatusNS = 'aeiou';
    //     geTAccountSummaryTypeBasicInfo.locationNS = 'aeiou';
    //     geTAccountSummaryTypeBasicInfo.subsidiaryNS = 'aeiou';
    //     geTAccountSummaryTypeBasicInfo.syncDateNS = 'aeiou';
    //     geTAccountSummaryTypeBasicInfo.synctoNetSuiteNS = SynctoNetSuiteNSEnum.YES;
    //     geTAccountSummaryTypeBasicInfo.accountNumber = 'aeiou';
    //     geTAccountSummaryTypeBasicInfo.additionalEmailAddresses = new List<String>{'aeiou'};
    //     geTAccountSummaryTypeBasicInfo.balance = 'aeiou';
    //     geTAccountSummaryTypeBasicInfo.batch = 'aeiou';
    //     geTAccountSummaryTypeBasicInfo.billCycleDay = 'aeiou';
    //     geTAccountSummaryTypeBasicInfo.currency = 'aeiou';
    //     geTAccountSummaryTypeBasicInfo.defaultPaymentMethod = zc_GETAccountSummaryTypeBasicInfoDe.getExample();
    //     geTAccountSummaryTypeBasicInfo.id = 'aeiou';
    //     geTAccountSummaryTypeBasicInfo.invoiceDeliveryPrefsEmail = true;
    //     geTAccountSummaryTypeBasicInfo.invoiceDeliveryPrefsPrint = true;
    //     geTAccountSummaryTypeBasicInfo.lastInvoiceDate = Date.newInstance(2000, 1, 23);
    //     geTAccountSummaryTypeBasicInfo.lastPaymentAmount = 'aeiou';
    //     geTAccountSummaryTypeBasicInfo.lastPaymentDate = Date.newInstance(2000, 1, 23);
    //     geTAccountSummaryTypeBasicInfo.name = 'aeiou';
    //     geTAccountSummaryTypeBasicInfo.status = 'aeiou';
    //     geTAccountSummaryTypeBasicInfo.tags = 'aeiou';
    //     return geTAccountSummaryTypeBasicInfo;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_GETAccountSummaryTypeBasicInfo) {
            zc_GETAccountSummaryTypeBasicInfo geTAccountSummaryTypeBasicInfo = (zc_GETAccountSummaryTypeBasicInfo) obj;
            return this.classNS == geTAccountSummaryTypeBasicInfo.classNS
                && this.customerTypeNS == geTAccountSummaryTypeBasicInfo.customerTypeNS
                && this.departmentNS == geTAccountSummaryTypeBasicInfo.departmentNS
                && this.integrationIdNS == geTAccountSummaryTypeBasicInfo.integrationIdNS
                && this.integrationStatusNS == geTAccountSummaryTypeBasicInfo.integrationStatusNS
                && this.locationNS == geTAccountSummaryTypeBasicInfo.locationNS
                && this.subsidiaryNS == geTAccountSummaryTypeBasicInfo.subsidiaryNS
                && this.syncDateNS == geTAccountSummaryTypeBasicInfo.syncDateNS
                && this.synctoNetSuiteNS == geTAccountSummaryTypeBasicInfo.synctoNetSuiteNS
                && this.accountNumber == geTAccountSummaryTypeBasicInfo.accountNumber
                && this.additionalEmailAddresses == geTAccountSummaryTypeBasicInfo.additionalEmailAddresses
                && this.balance == geTAccountSummaryTypeBasicInfo.balance
                && this.batch == geTAccountSummaryTypeBasicInfo.batch
                && this.billCycleDay == geTAccountSummaryTypeBasicInfo.billCycleDay
                && this.currency2 == geTAccountSummaryTypeBasicInfo.currency2
                && this.defaultPaymentMethod == geTAccountSummaryTypeBasicInfo.defaultPaymentMethod
                && this.id == geTAccountSummaryTypeBasicInfo.id
                && this.invoiceDeliveryPrefsEmail == geTAccountSummaryTypeBasicInfo.invoiceDeliveryPrefsEmail
                && this.invoiceDeliveryPrefsPrint == geTAccountSummaryTypeBasicInfo.invoiceDeliveryPrefsPrint
                && this.lastInvoiceDate == geTAccountSummaryTypeBasicInfo.lastInvoiceDate
                && this.lastPaymentAmount == geTAccountSummaryTypeBasicInfo.lastPaymentAmount
                && this.lastPaymentDate == geTAccountSummaryTypeBasicInfo.lastPaymentDate
                && this.name == geTAccountSummaryTypeBasicInfo.name
                && this.status == geTAccountSummaryTypeBasicInfo.status
                && this.tags == geTAccountSummaryTypeBasicInfo.tags;
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
        hashCode = (17 * hashCode) + (additionalEmailAddresses == null ? 0 : System.hashCode(additionalEmailAddresses));
        hashCode = (17 * hashCode) + (balance == null ? 0 : System.hashCode(balance));
        hashCode = (17 * hashCode) + (batch == null ? 0 : System.hashCode(batch));
        hashCode = (17 * hashCode) + (billCycleDay == null ? 0 : System.hashCode(billCycleDay));
        hashCode = (17 * hashCode) + (currency2 == null ? 0 : System.hashCode(currency2));
        hashCode = (17 * hashCode) + (defaultPaymentMethod == null ? 0 : System.hashCode(defaultPaymentMethod));
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
        hashCode = (17 * hashCode) + (invoiceDeliveryPrefsEmail == null ? 0 : System.hashCode(invoiceDeliveryPrefsEmail));
        hashCode = (17 * hashCode) + (invoiceDeliveryPrefsPrint == null ? 0 : System.hashCode(invoiceDeliveryPrefsPrint));
        hashCode = (17 * hashCode) + (lastInvoiceDate == null ? 0 : System.hashCode(lastInvoiceDate));
        hashCode = (17 * hashCode) + (lastPaymentAmount == null ? 0 : System.hashCode(lastPaymentAmount));
        hashCode = (17 * hashCode) + (lastPaymentDate == null ? 0 : System.hashCode(lastPaymentDate));
        hashCode = (17 * hashCode) + (name == null ? 0 : System.hashCode(name));
        hashCode = (17 * hashCode) + (status == null ? 0 : System.hashCode(status));
        hashCode = (17 * hashCode) + (tags == null ? 0 : System.hashCode(tags));
        return hashCode;
    }
}