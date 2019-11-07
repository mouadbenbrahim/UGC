/**
 * zc_ProxyGetAccount
 */
public class zc_ProxyGetAccount {
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
     * Unique account number assigned to the account. **Character limit**: 50 **Values**: one of the following:\n\n- null to auto-generate\n- a string of 50 characters or fewer that doesn\'t begin with the default account number prefix\n
     * @return accountNumber
     */
    public String accountNumber { get; set; }

    /**
     * List of additional email addresses to receive emailed invoices. **Character limit**: 120 **Values**: comma-separated list of email addresses 
     * @return additionalEmailAddresses
     */
    public String additionalEmailAddresses { get; set; }

    /**
     *  Indicates if associated invoices can be edited.\n**Character limit**: 5 **Values**: `true`, `false` (default if left null) 
     * @return allowInvoiceEdit
     */
    public Boolean allowInvoiceEdit { get; set; }

    /**
     *  Indicates if future payments are automatically collected when they\'re due during a Payment Run.\n**Character limit**: 5 **Values**: `true`, `false` (default) 
     * @return autoPay
     */
    public Boolean autoPay { get; set; }

    /**
     * Current outstanding balance for the account. **Character limit**: 16 **Values**: automatically generated 
     * @return balance
     */
    public Double balance { get; set; }

    /**
     *  Organizes your customer accounts into groups to optimize your billing and payment operations. Required if you use the Subscribe call\n**Character limit**: 20 **Values**:any system-defined batch (`Batch1` - `Batch50 `or by name). 
     * @return batch
     */
    public String batch { get; set; }

    /**
     * Billing cycle day setting option. **Character limit**: 9 **Values**: `AutoSet`, `ManualSet` 
     * @return bcdSettingOption
     */
    public String bcdSettingOption { get; set; }

    /**
     * Billing cycle day (BCD) on which bill runs generate invoices for the account. **Character limit**: 2 **Values**: any activated system-defined bill cycle day (`1` - `31`) 
     * @return billCycleDay
     */
    public Integer billCycleDay { get; set; }

    /**
     * ID of the person to bill for the account. **Character limit**: 32 **Values**: a valid contact ID for the account 
     * @return billToId
     */
    public String billToId { get; set; }

    /**
     * Associates the account with a specified communication profile. **Character limit**: 32 **Values**: a valid communication profile ID 
     * @return communicationProfileId
     */
    public String communicationProfileId { get; set; }

    /**
     * ID of the Zuora user who created the Account object. **Character limit**: 32 **Values**: automatically generated 
     * @return createdById
     */
    public String createdById { get; set; }

    /**
     * Date when the Account object was created. **Character limit**: 29 **Values**: automatically generated 
     * @return createdDate
     */
    public Datetime createdDate { get; set; }

    /**
     * Total credit balance for the account. **Character limit**: 16 **Values**: automatically generated 
     * @return creditBalance
     */
    public Double creditBalance { get; set; }

    /**
     * CRM account ID for the account. A CRM is a customer relationship management system, such as Salesforce.com. **Character limit**: 100 **Values**: a string of 100 characters or fewer 
     * @return crmId
     */
    public String crmId { get; set; }

    /**
     *  currency2 that the customer is billed in. 
     * @return currency2
     */
    public String currency2 { get; set; }

    /**
     * Name of the account\'s customer service representative, if applicable. **Character limit**: 50 **Values**: a string of 50 characters or fewer 
     * @return customerServiceRepName
     */
    public String customerServiceRepName { get; set; }

    /**
     * ID of the default payment method for the account. This field is required if the AutoPay field is set to `true`. **Character limit**: 32 **Values**: a valid ID for an existing payment method 
     * @return defaultPaymentMethodId
     */
    public String defaultPaymentMethodId { get; set; }

    /**
     * Object identifier.
     * @return id
     */
    public String id { get; set; }

    /**
     * Indicates if the customer wants to receive invoices through email.  **Character limit**: 5 **Values**: `true`, `false` (default if left null) 
     * @return invoiceDeliveryPrefsEmail
     */
    public Boolean invoiceDeliveryPrefsEmail { get; set; }

    /**
     * Indicates if the customer wants to receive printed invoices, such as through postal mail. **Character limit**: 5 **Values**: `true`, `false` (default if left null) 
     * @return invoiceDeliveryPrefsPrint
     */
    public Boolean invoiceDeliveryPrefsPrint { get; set; }

    /**
     * The ID of the invoice template. Each customer account can use a specific invoice template for invoice generation. **Character limit**: 32 **Values**: a valid template ID configured in Zuora Billing Settings 
     * @return invoiceTemplateId
     */
    public String invoiceTemplateId { get; set; }

    /**
     *  The date when the previous invoice was generated for the account. The field value is null if no invoice has ever been generated for the account.\n**Character limit**: 29 **Values**: automatically generated 
     * @return lastInvoiceDate
     */
    public Date lastInvoiceDate { get; set; }

    /**
     * Name of the account as displayed in the Zuora UI. **Character limit**: 255 **Values**: a string of 255 characters or fewer 
     * @return name
     */
    public String name { get; set; }

    /**
     *  Comments about the account. **Character limit**: 65,535 **Values**: a string of 65,535 characters 
     * @return notes
     */
    public String notes { get; set; }

    /**
     * Identifier of the parent customer account for this Account object. Use this field if you have customer hierarchy enabled. **Character limit**: 32 **Values**: a valid account ID 
     * @return parentId
     */
    public String parentId { get; set; }

    /**
     * Gateway used for processing electronic payments and refunds. **Character limit**: 40 **Values**: one of the following:\n\n- a valid configured gateway name\n- Null to inherit the default value set in Payment Settings\n
     * @return paymentGateway
     */
    public String paymentGateway { get; set; }

    /**
     * Indicates when the customer pays for subscriptions. **Character limit**: 100 **Values**: a valid, active payment term defined in the web-based UI administrative settings 
     * @return paymentTerm
     */
    public String paymentTerm { get; set; }

    /**
     * The number of the purchase order associated with this account. Purchase order information generally comes from customers. **Character limit**: 100 **Values**: a string of 100 characters or fewer 
     * @return purchaseOrderNumber
     */
    public String purchaseOrderNumber { get; set; }

    /**
     * The name of the sales representative associated with this account, if applicable. **Character limit**: 50 **Values**: a string of 50 characters or fewer 
     * @return salesRepName
     */
    public String salesRepName { get; set; }

    /**
     * ID of the person who bought the subscription associated with the account. **Character limit**: 32 **Values**: a valid contact ID for the account 
     * @return soldToId
     */
    public String soldToId { get; set; }

    /**
     * Status of the account in the system.\n
     */
    public enum StatusEnum {
        DRAFT,
        ACTIVE,
        CANCELED
    }

    /**
     * Status of the account in the system.\n
     * @return status
     */
    public StatusEnum status { get; set; }

    /**
     *  Unique code that identifies a company account in Avalara. Use this field to calculate taxes based on origin and sold-to addresses in Avalara.\nThis feature is in **Limited Availability**. If you wish to have access to the feature, submit a request at [Zuora Global Support](http://support.zuora.com/).\n\n**Character limit**: 50 **Values**: a valid company code 
     * @return taxCompanyCode
     */
    public String taxCompanyCode { get; set; }

    /**
     * ID of your customer\'s tax exemption certificate. **Character limit**: 32 **Values**: a string of 32 characters or fewer 
     * @return taxExemptCertificateID
     */
    public String taxExemptCertificateID { get; set; }

    /**
     * Type of the tax exemption certificate that your customer holds.  **Character limit**: 32 **Values**: a string of 32 characters or fewer 
     * @return taxExemptCertificateType
     */
    public String taxExemptCertificateType { get; set; }

    /**
     * Description of the tax exemption certificate that your customer holds. **Character limit**: 500 **Values**: a string of 500 characters or fewer 
     * @return taxExemptDescription
     */
    public String taxExemptDescription { get; set; }

    /**
     * Date when the the customer\'s tax exemption starts. **Character limit**: 29 **Version notes**: requires Zuora Tax 
     * @return taxExemptEffectiveDate
     */
    public Date taxExemptEffectiveDate { get; set; }

    /**
     * Date when the customer\'s tax exemption certificate expires  **Character limit**: 29 **Version notes**: requires Zuora Tax 
     * @return taxExemptExpirationDate
     */
    public Date taxExemptExpirationDate { get; set; }

    /**
     * Indicates the jurisdiction in which the customer\'s tax exemption certificate was issued. **Character limit**: 32 **Values**: a string of 32 characters or fewer 
     * @return taxExemptIssuingJurisdiction
     */
    public String taxExemptIssuingJurisdiction { get; set; }

    /**
     *  Status of the account\'s tax exemption. Required if you use Zuora Tax.\n**Character limit**: 19 **Values**: one of the following:\n\n- `Yes`\n- `No`\n- `PendingVerification`\n
     * @return taxExemptStatus
     */
    public String taxExemptStatus { get; set; }

    /**
     * Total balance of the account\'s invoices. **Character limit**: 16 **Values**: a valid currency2 value 
     * @return totalInvoiceBalance
     */
    public Double totalInvoiceBalance { get; set; }

    /**
     * ID of the user who last updated the account. **Character limit**: 32 **Values**: automatically generated 
     * @return updatedById
     */
    public String updatedById { get; set; }

    /**
     * Date when the account was last updated. **Character limit**: 29 **Values**: automatically generated 
     * @return updatedDate
     */
    public Datetime updatedDate { get; set; }

    /**
     *  EU Value Added Tax ID.\nThis feature is in **Limited Availability**. If you wish to have access to the feature, submit a request at [Zuora Global Support](http://support.zuora.com/).\n\n**Character limit**: 25 **Values**: a valid Value Added Tax ID 
     * @return vaTId
     */
    public String vaTId { get; set; }

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
        'AccountNumber' => 'accountNumber',
        'AdditionalEmailAddresses' => 'additionalEmailAddresses',
        'AllowInvoiceEdit' => 'allowInvoiceEdit',
        'AutoPay' => 'autoPay',
        'Balance' => 'balance',
        'Batch' => 'batch',
        'BcdSettingOption' => 'bcdSettingOption',
        'BillCycleDay' => 'billCycleDay',
        'BillToId' => 'billToId',
        'CommunicationProfileId' => 'communicationProfileId',
        'CreatedById' => 'createdById',
        'CreatedDate' => 'createdDate',
        'CreditBalance' => 'creditBalance',
        'CrmId' => 'crmId',
        'currency2' => 'currency2',
        'CustomerServiceRepName' => 'customerServiceRepName',
        'DefaultPaymentMethodId' => 'defaultPaymentMethodId',
        'Id' => 'id',
        'InvoiceDeliveryPrefsEmail' => 'invoiceDeliveryPrefsEmail',
        'InvoiceDeliveryPrefsPrint' => 'invoiceDeliveryPrefsPrint',
        'InvoiceTemplateId' => 'invoiceTemplateId',
        'LastInvoiceDate' => 'lastInvoiceDate',
        'Name' => 'name',
        'Notes' => 'notes',
        'ParentId' => 'parentId',
        'PaymentGateway' => 'paymentGateway',
        'PaymentTerm' => 'paymentTerm',
        'PurchaseOrderNumber' => 'purchaseOrderNumber',
        'SalesRepName' => 'salesRepName',
        'SoldToId' => 'soldToId',
        'Status' => 'status',
        'TaxCompanyCode' => 'taxCompanyCode',
        'TaxExemptCertificateID' => 'taxExemptCertificateID',
        'TaxExemptCertificateType' => 'taxExemptCertificateType',
        'TaxExemptDescription' => 'taxExemptDescription',
        'TaxExemptEffectiveDate' => 'taxExemptEffectiveDate',
        'TaxExemptExpirationDate' => 'taxExemptExpirationDate',
        'TaxExemptIssuingJurisdiction' => 'taxExemptIssuingJurisdiction',
        'TaxExemptStatus' => 'taxExemptStatus',
        'TotalInvoiceBalance' => 'totalInvoiceBalance',
        'UpdatedById' => 'updatedById',
        'UpdatedDate' => 'updatedDate',
        'VATId' => 'vaTId'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    // public static zc_ProxyGetAccount getExample() {
    //     zc_ProxyGetAccount proxyGetAccount = new zc_ProxyGetAccount();
    //     proxyGetAccount.classNS = 'aeiou';
    //     proxyGetAccount.customerTypeNS = CustomerTypeNSEnum.COMPANY;
    //     proxyGetAccount.departmentNS = 'aeiou';
    //     proxyGetAccount.integrationIdNS = 'aeiou';
    //     proxyGetAccount.integrationStatusNS = 'aeiou';
    //     proxyGetAccount.locationNS = 'aeiou';
    //     proxyGetAccount.subsidiaryNS = 'aeiou';
    //     proxyGetAccount.syncDateNS = 'aeiou';
    //     proxyGetAccount.synctoNetSuiteNS = SynctoNetSuiteNSEnum.YES;
    //     proxyGetAccount.accountNumber = 'aeiou';
    //     proxyGetAccount.additionalEmailAddresses = 'aeiou';
    //     proxyGetAccount.allowInvoiceEdit = true;
    //     proxyGetAccount.autoPay = true;
    //     proxyGetAccount.balance = 1.3579;
    //     proxyGetAccount.batch = 'aeiou';
    //     proxyGetAccount.bcdSettingOption = 'aeiou';
    //     proxyGetAccount.billCycleDay = 123;
    //     proxyGetAccount.billToId = 'aeiou';
    //     proxyGetAccount.communicationProfileId = 'aeiou';
    //     proxyGetAccount.createdById = 'aeiou';
    //     proxyGetAccount.createdDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    //     proxyGetAccount.creditBalance = 1.3579;
    //     proxyGetAccount.crmId = 'aeiou';
    //     proxyGetAccount.currency2 = 'aeiou';
    //     proxyGetAccount.customerServiceRepName = 'aeiou';
    //     proxyGetAccount.defaultPaymentMethodId = 'aeiou';
    //     proxyGetAccount.id = 'aeiou';
    //     proxyGetAccount.invoiceDeliveryPrefsEmail = true;
    //     proxyGetAccount.invoiceDeliveryPrefsPrint = true;
    //     proxyGetAccount.invoiceTemplateId = 'aeiou';
    //     proxyGetAccount.lastInvoiceDate = Date.newInstance(2000, 1, 23);
    //     proxyGetAccount.name = 'aeiou';
    //     proxyGetAccount.notes = 'aeiou';
    //     proxyGetAccount.parentId = 'aeiou';
    //     proxyGetAccount.paymentGateway = 'aeiou';
    //     proxyGetAccount.paymentTerm = 'aeiou';
    //     proxyGetAccount.purchaseOrderNumber = 'aeiou';
    //     proxyGetAccount.salesRepName = 'aeiou';
    //     proxyGetAccount.soldToId = 'aeiou';
    //     proxyGetAccount.status = StatusEnum.DRAFT;
    //     proxyGetAccount.taxCompanyCode = 'aeiou';
    //     proxyGetAccount.taxExemptCertificateID = 'aeiou';
    //     proxyGetAccount.taxExemptCertificateType = 'aeiou';
    //     proxyGetAccount.taxExemptDescription = 'aeiou';
    //     proxyGetAccount.taxExemptEffectiveDate = Date.newInstance(2000, 1, 23);
    //     proxyGetAccount.taxExemptExpirationDate = Date.newInstance(2000, 1, 23);
    //     proxyGetAccount.taxExemptIssuingJurisdiction = 'aeiou';
    //     proxyGetAccount.taxExemptStatus = 'aeiou';
    //     proxyGetAccount.totalInvoiceBalance = 1.3579;
    //     proxyGetAccount.updatedById = 'aeiou';
    //     proxyGetAccount.updatedDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    //     proxyGetAccount.vaTId = 'aeiou';
    //     return proxyGetAccount;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_ProxyGetAccount) {
            zc_ProxyGetAccount proxyGetAccount = (zc_ProxyGetAccount) obj;
            return this.classNS == proxyGetAccount.classNS
                && this.customerTypeNS == proxyGetAccount.customerTypeNS
                && this.departmentNS == proxyGetAccount.departmentNS
                && this.integrationIdNS == proxyGetAccount.integrationIdNS
                && this.integrationStatusNS == proxyGetAccount.integrationStatusNS
                && this.locationNS == proxyGetAccount.locationNS
                && this.subsidiaryNS == proxyGetAccount.subsidiaryNS
                && this.syncDateNS == proxyGetAccount.syncDateNS
                && this.synctoNetSuiteNS == proxyGetAccount.synctoNetSuiteNS
                && this.accountNumber == proxyGetAccount.accountNumber
                && this.additionalEmailAddresses == proxyGetAccount.additionalEmailAddresses
                && this.allowInvoiceEdit == proxyGetAccount.allowInvoiceEdit
                && this.autoPay == proxyGetAccount.autoPay
                && this.balance == proxyGetAccount.balance
                && this.batch == proxyGetAccount.batch
                && this.bcdSettingOption == proxyGetAccount.bcdSettingOption
                && this.billCycleDay == proxyGetAccount.billCycleDay
                && this.billToId == proxyGetAccount.billToId
                && this.communicationProfileId == proxyGetAccount.communicationProfileId
                && this.createdById == proxyGetAccount.createdById
                && this.createdDate == proxyGetAccount.createdDate
                && this.creditBalance == proxyGetAccount.creditBalance
                && this.crmId == proxyGetAccount.crmId
                && this.currency2 == proxyGetAccount.currency2
                && this.customerServiceRepName == proxyGetAccount.customerServiceRepName
                && this.defaultPaymentMethodId == proxyGetAccount.defaultPaymentMethodId
                && this.id == proxyGetAccount.id
                && this.invoiceDeliveryPrefsEmail == proxyGetAccount.invoiceDeliveryPrefsEmail
                && this.invoiceDeliveryPrefsPrint == proxyGetAccount.invoiceDeliveryPrefsPrint
                && this.invoiceTemplateId == proxyGetAccount.invoiceTemplateId
                && this.lastInvoiceDate == proxyGetAccount.lastInvoiceDate
                && this.name == proxyGetAccount.name
                && this.notes == proxyGetAccount.notes
                && this.parentId == proxyGetAccount.parentId
                && this.paymentGateway == proxyGetAccount.paymentGateway
                && this.paymentTerm == proxyGetAccount.paymentTerm
                && this.purchaseOrderNumber == proxyGetAccount.purchaseOrderNumber
                && this.salesRepName == proxyGetAccount.salesRepName
                && this.soldToId == proxyGetAccount.soldToId
                && this.status == proxyGetAccount.status
                && this.taxCompanyCode == proxyGetAccount.taxCompanyCode
                && this.taxExemptCertificateID == proxyGetAccount.taxExemptCertificateID
                && this.taxExemptCertificateType == proxyGetAccount.taxExemptCertificateType
                && this.taxExemptDescription == proxyGetAccount.taxExemptDescription
                && this.taxExemptEffectiveDate == proxyGetAccount.taxExemptEffectiveDate
                && this.taxExemptExpirationDate == proxyGetAccount.taxExemptExpirationDate
                && this.taxExemptIssuingJurisdiction == proxyGetAccount.taxExemptIssuingJurisdiction
                && this.taxExemptStatus == proxyGetAccount.taxExemptStatus
                && this.totalInvoiceBalance == proxyGetAccount.totalInvoiceBalance
                && this.updatedById == proxyGetAccount.updatedById
                && this.updatedDate == proxyGetAccount.updatedDate
                && this.vaTId == proxyGetAccount.vaTId;
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
        hashCode = (17 * hashCode) + (allowInvoiceEdit == null ? 0 : System.hashCode(allowInvoiceEdit));
        hashCode = (17 * hashCode) + (autoPay == null ? 0 : System.hashCode(autoPay));
        hashCode = (17 * hashCode) + (balance == null ? 0 : System.hashCode(balance));
        hashCode = (17 * hashCode) + (batch == null ? 0 : System.hashCode(batch));
        hashCode = (17 * hashCode) + (bcdSettingOption == null ? 0 : System.hashCode(bcdSettingOption));
        hashCode = (17 * hashCode) + (billCycleDay == null ? 0 : System.hashCode(billCycleDay));
        hashCode = (17 * hashCode) + (billToId == null ? 0 : System.hashCode(billToId));
        hashCode = (17 * hashCode) + (communicationProfileId == null ? 0 : System.hashCode(communicationProfileId));
        hashCode = (17 * hashCode) + (createdById == null ? 0 : System.hashCode(createdById));
        hashCode = (17 * hashCode) + (createdDate == null ? 0 : System.hashCode(createdDate));
        hashCode = (17 * hashCode) + (creditBalance == null ? 0 : System.hashCode(creditBalance));
        hashCode = (17 * hashCode) + (crmId == null ? 0 : System.hashCode(crmId));
        hashCode = (17 * hashCode) + (currency2 == null ? 0 : System.hashCode(currency2));
        hashCode = (17 * hashCode) + (customerServiceRepName == null ? 0 : System.hashCode(customerServiceRepName));
        hashCode = (17 * hashCode) + (defaultPaymentMethodId == null ? 0 : System.hashCode(defaultPaymentMethodId));
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
        hashCode = (17 * hashCode) + (invoiceDeliveryPrefsEmail == null ? 0 : System.hashCode(invoiceDeliveryPrefsEmail));
        hashCode = (17 * hashCode) + (invoiceDeliveryPrefsPrint == null ? 0 : System.hashCode(invoiceDeliveryPrefsPrint));
        hashCode = (17 * hashCode) + (invoiceTemplateId == null ? 0 : System.hashCode(invoiceTemplateId));
        hashCode = (17 * hashCode) + (lastInvoiceDate == null ? 0 : System.hashCode(lastInvoiceDate));
        hashCode = (17 * hashCode) + (name == null ? 0 : System.hashCode(name));
        hashCode = (17 * hashCode) + (notes == null ? 0 : System.hashCode(notes));
        hashCode = (17 * hashCode) + (parentId == null ? 0 : System.hashCode(parentId));
        hashCode = (17 * hashCode) + (paymentGateway == null ? 0 : System.hashCode(paymentGateway));
        hashCode = (17 * hashCode) + (paymentTerm == null ? 0 : System.hashCode(paymentTerm));
        hashCode = (17 * hashCode) + (purchaseOrderNumber == null ? 0 : System.hashCode(purchaseOrderNumber));
        hashCode = (17 * hashCode) + (salesRepName == null ? 0 : System.hashCode(salesRepName));
        hashCode = (17 * hashCode) + (soldToId == null ? 0 : System.hashCode(soldToId));
        hashCode = (17 * hashCode) + (status == null ? 0 : System.hashCode(status));
        hashCode = (17 * hashCode) + (taxCompanyCode == null ? 0 : System.hashCode(taxCompanyCode));
        hashCode = (17 * hashCode) + (taxExemptCertificateID == null ? 0 : System.hashCode(taxExemptCertificateID));
        hashCode = (17 * hashCode) + (taxExemptCertificateType == null ? 0 : System.hashCode(taxExemptCertificateType));
        hashCode = (17 * hashCode) + (taxExemptDescription == null ? 0 : System.hashCode(taxExemptDescription));
        hashCode = (17 * hashCode) + (taxExemptEffectiveDate == null ? 0 : System.hashCode(taxExemptEffectiveDate));
        hashCode = (17 * hashCode) + (taxExemptExpirationDate == null ? 0 : System.hashCode(taxExemptExpirationDate));
        hashCode = (17 * hashCode) + (taxExemptIssuingJurisdiction == null ? 0 : System.hashCode(taxExemptIssuingJurisdiction));
        hashCode = (17 * hashCode) + (taxExemptStatus == null ? 0 : System.hashCode(taxExemptStatus));
        hashCode = (17 * hashCode) + (totalInvoiceBalance == null ? 0 : System.hashCode(totalInvoiceBalance));
        hashCode = (17 * hashCode) + (updatedById == null ? 0 : System.hashCode(updatedById));
        hashCode = (17 * hashCode) + (updatedDate == null ? 0 : System.hashCode(updatedDate));
        hashCode = (17 * hashCode) + (vaTId == null ? 0 : System.hashCode(vaTId));
        return hashCode;
    }
}