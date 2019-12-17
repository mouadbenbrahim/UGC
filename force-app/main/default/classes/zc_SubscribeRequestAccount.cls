/**
 *  This is the Account object containing the information for this particular subscription. It has all the information needed to create an account for a subscription.\n\n**Values:** A valid account.
 */
public class zc_SubscribeRequestAccount {
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
     * Unique account number assigned to the account.\n\n**Character limit**: 50\n\n\n**Values**: one of the following:\n\n- null to auto-generate\n- a string of 50 characters or fewer that doesn\'t begin with the default account number prefix\n
     * @return accountNumber
     */
    public String accountNumber { get; set; }

    /**
     * List of additional email addresses to receive emailed invoices.\n\n**Character limit**: 120\n\n\n**Values**: comma-separated list of email addresses 
     * @return additionalEmailAddresses
     */
    public String additionalEmailAddresses { get; set; }

    /**
     *  Indicates if associated invoices can be edited.\n\n\n**Character limit**: 5\n\n\n**Values**: `true`, `false` (default if left null) 
     * @return allowInvoiceEdit
     */
    public Boolean allowInvoiceEdit { get; set; }

    /**
     *  Indicates if future payments are automatically collected when they\'re due during a Payment Run.\n\n\n**Character limit**: 5\n\n\n**Values**: `true`, `false` (default) 
     * @return autoPay
     */
    public Boolean autoPay { get; set; }

    /**
     *  Organizes your customer accounts into groups to optimize your billing and payment operations.\n\n\n**Character limit**: 20\n\n\n**Values**:any system-defined batch (`Batch1` - `Batch50 `or by name). 
     * @return batch
     */
    public String batch { get; set; }

    /**
     * Billing cycle day setting option.\n\n**Character limit**: 9\n\n\n**Values**: `AutoSet`, `ManualSet` 
     * @return bcdSettingOption
     */
    public String bcdSettingOption { get; set; }

    /**
     * Billing cycle day (BCD) on which bill runs generate invoices for the account.\n\n**Character limit**: 2\n\n\n**Values**: any activated system-defined bill cycle day (`1` - `31`) 
     * @return billCycleDay
     */
    public Integer billCycleDay { get; set; }

    /**
     * Associates the account with a specified communication profile.\n\n**Character limit**: 32\n\n\n**Values**: a valid communication profile ID 
     * @return communicationProfileId
     */
    public String communicationProfileId { get; set; }

    /**
     * CRM account ID for the account. A CRM is a customer relationship management system, such as Salesforce.com.\n\n**Character limit**: 100\n\n\n**Values**: a string of 100 characters or fewer 
     * @return crmId
     */
    public String crmId { get; set; }

    /**
     *  Currency that the customer is billed in. See [a currency value defined in the Zuora Ui admin settings](https://knowledgecenter.zuora.com/CB_Billing/Billing_Settings/Customize_Currencies) 
     * @return currency
     */
    public String currency2 { get; set; }

    /**
     * Name of the account\'s customer service representative, if applicable.\n\n**Character limit**: 50\n\n\n**Values**: a string of 50 characters or fewer 
     * @return customerServiceRepName
     */
    public String customerServiceRepName { get; set; }

    /**
     * ID of the default payment method for the account. This field is only required if the `AutoPay` field is set to `true`.\n\n\n**Character limit**: 32\n\n\n**Values**: a valid ID for an existing payment method 
     * @return defaultPaymentMethodId
     */
    public String defaultPaymentMethodId { get; set; }

    /**
     * Internal identifier of an existing account. Only set this field if you want to assign the subscription to an existing account.
     * @return id
     */
    public String id { get; set; }

    /**
     * Indicates if the customer wants to receive invoices through email.\n**Character limit**: 5\n\n\n**Values**: `true`, `false` (default if left null) 
     * @return invoiceDeliveryPrefsEmail
     */
    public Boolean invoiceDeliveryPrefsEmail { get; set; }

    /**
     * Indicates if the customer wants to receive printed invoices, such as through postal mail.\n\n**Character limit**: 5\n\n\n**Values**: `true`, `false` (default if left null) 
     * @return invoiceDeliveryPrefsPrint
     */
    public Boolean invoiceDeliveryPrefsPrint { get; set; }

    /**
     * The ID of the invoice template. Each customer account can use a specific invoice template for invoice generation.\n\n**Character limit**: 32\n\n\n**Values**: a[ valid template ID configured in Z-Billing Settings](https://knowledgecenter.zuora.com/CB_Billing/Billing_Settings/Manage_Invoice_Rules_and_Templates) To find the ID of your current invoice template: In Zuora, navigate to **Settings > Z-Billing > Manage Invoice Rules and Templates** and click **Show Id **next to the template you want to use.\n\n\n
     * @return invoiceTemplateId
     */
    public String invoiceTemplateId { get; set; }

    /**
     *  The date when the previous invoice was generated for the account. The field value is null if no invoice has ever been generated for the account.\n\n\n**Character limit**: 29\n\n\n**Values**: automatically generated 
     * @return lastInvoiceDate
     */
    public Date lastInvoiceDate { get; set; }

    /**
     * Name of the account as displayed in the Zuora UI.\n\n**Character limit**: 255\n\n\n**Values**: a string of 255 characters or fewer 
     * @return name
     */
    public String name { get; set; }

    /**
     *  Comments about the account.\n\n**Character limit**: 65,535\n\n\n**Values**: a string of 65,535 characters 
     * @return notes
     */
    public String notes { get; set; }

    /**
     * Identifier of the parent customer account for this Account object. Use this field if you have customer hierarchy enabled.\n\n**Character limit**: 32\n\n\n**Values**: a valid account ID 
     * @return parentId
     */
    public String parentId { get; set; }

    /**
     * Gateway used for processing electronic payments and refunds. This field is only required if there is no default payment gateway is defined in the tenant.\n\n**Character limit**: 40\n\n\n**Values**: one of the following:\n\n- a valid configured gateway name\n- Null to inherit the default value set in Z-Payment Settings\n
     * @return paymentGateway
     */
    public String paymentGateway { get; set; }

    /**
     * Indicates when the customer pays for subscriptions.\n\n**Character limit**: 100\n\n\n**Values**: [a valid, active payment term defined in the web-based UI administrative settings](https://knowledgecenter.zuora.com/CB_Billing/Billing_Settings/Define_Payment_Terms) 
     * @return paymentTerm
     */
    public String paymentTerm { get; set; }

    /**
     * The number of the purchase order associated with this account. Purchase order information generally comes from customers.\n\n**Character limit**: 100\n\n\n**Values**: a string of 100 characters or fewer 
     * @return purchaseOrderNumber
     */
    public String purchaseOrderNumber { get; set; }

    /**
     * The name of the sales representative associated with this account, if applicable.\n\n**Character limit**: 50\n\n\n**Values**: a string of 50 characters or fewer 
     * @return salesRepName
     */
    public String salesRepName { get; set; }

    /**
     *  Unique code that identifies a company account in Avalara. Use this field to calculate taxes based on origin and sold-to addresses in Avalara.\nThis feature is in **Limited Availability**. If you wish to have access to the feature, submit a request at [Zuora Global Support](http://support.zuora.com/).\n\n\n\n**Character limit**: 50\n\n\n**Values**: a valid company code 
     * @return taxCompanyCode
     */
    public String taxCompanyCode { get; set; }

    /**
     * ID of your customer\'s tax exemption certificate.\n\n**Character limit**: 32\n\n\n**Values**: a string of 32 characters or fewer 
     * @return taxExemptCertificateID
     */
    public String taxExemptCertificateID { get; set; }

    /**
     * Type of the tax exemption certificate that your customer holds.\n**Character limit**: 32\n\n\n**Values**: a string of 32 characters or fewer 
     * @return taxExemptCertificateType
     */
    public String taxExemptCertificateType { get; set; }

    /**
     * Description of the tax exemption certificate that your customer holds.\n\n**Character limit**: 500\n\n\n**Values**: a string of 500 characters or fewer 
     * @return taxExemptDescription
     */
    public String taxExemptDescription { get; set; }

    /**
     * Date when the the customer\'s tax exemption starts.\n\n**Character limit**: 29 **Version notes**: requires Z-Tax 
     * @return taxExemptEffectiveDate
     */
    public Date taxExemptEffectiveDate { get; set; }

    /**
     * Date when the customer\'s tax exemption certificate expires\n**Character limit**: 29 **Version notes**: requires Z-Tax 
     * @return taxExemptExpirationDate
     */
    public Date taxExemptExpirationDate { get; set; }

    /**
     * Indicates the jurisdiction in which the customer\'s tax exemption certificate was issued.\n\n**Character limit**: 32\n\n\n**Values**: a string of 32 characters or fewer 
     * @return taxExemptIssuingJurisdiction
     */
    public String taxExemptIssuingJurisdiction { get; set; }

    /**
     *  Status of the account\'s tax exemption. This field is only required if you use Zuora Tax. This field is not available if you do not use Zuora Tax.\n\n\n**Character limit**: 19\n\n\n**Values**: one of the following:\n\n- `Yes`\n- `No`\n- `PendingVerification`\n
     * @return taxExemptStatus
     */
    public String taxExemptStatus { get; set; }

    /**
     * Total balance of the account\'s invoices.\n\n**Character limit**: 16\n\n\n**Values**: a valid currency value 
     * @return totalInvoiceBalance
     */
    public Double totalInvoiceBalance { get; set; }

    /**
     *  EU Value Added Tax ID.\nThis feature is in **Limited Availability**. If you wish to have access to the feature, submit a request at [Zuora Global Support](http://support.zuora.com/).\n\n\n\n**Character limit**: 25\n\n\n**Values**: a valid Value Added Tax ID 
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
        'Batch' => 'batch',
        'BcdSettingOption' => 'bcdSettingOption',
        'BillCycleDay' => 'billCycleDay',
        'CommunicationProfileId' => 'communicationProfileId',
        'CrmId' => 'crmId',
        'Currency' => 'currency2',
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
        'TaxCompanyCode' => 'taxCompanyCode',
        'TaxExemptCertificateID' => 'taxExemptCertificateID',
        'TaxExemptCertificateType' => 'taxExemptCertificateType',
        'TaxExemptDescription' => 'taxExemptDescription',
        'TaxExemptEffectiveDate' => 'taxExemptEffectiveDate',
        'TaxExemptExpirationDate' => 'taxExemptExpirationDate',
        'TaxExemptIssuingJurisdiction' => 'taxExemptIssuingJurisdiction',
        'TaxExemptStatus' => 'taxExemptStatus',
        'TotalInvoiceBalance' => 'totalInvoiceBalance',
        'VATId' => 'vaTId',
        'Aaaa' => 'vaTaaaId'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    // public static zc_SubscribeRequestAccount getExample() {
    //     zc_SubscribeRequestAccount subscribeRequestAccount = new zc_SubscribeRequestAccount();
    //     subscribeRequestAccount.classNS = 'aeiou';
    //     subscribeRequestAccount.customerTypeNS = CustomerTypeNSEnum.COMPANY;
    //     subscribeRequestAccount.departmentNS = 'aeiou';
    //     subscribeRequestAccount.integrationIdNS = 'aeiou';
    //     subscribeRequestAccount.integrationStatusNS = 'aeiou';
    //     subscribeRequestAccount.locationNS = 'aeiou';
    //     subscribeRequestAccount.subsidiaryNS = 'aeiou';
    //     subscribeRequestAccount.syncDateNS = 'aeiou';
    //     subscribeRequestAccount.synctoNetSuiteNS = SynctoNetSuiteNSEnum.YES;
    //     subscribeRequestAccount.accountNumber = 'aeiou';
    //     subscribeRequestAccount.additionalEmailAddresses = 'aeiou';
    //     subscribeRequestAccount.allowInvoiceEdit = true;
    //     subscribeRequestAccount.autoPay = true;
    //     subscribeRequestAccount.batch = 'aeiou';
    //     subscribeRequestAccount.bcdSettingOption = 'aeiou';
    //     subscribeRequestAccount.billCycleDay = 123;
    //     subscribeRequestAccount.communicationProfileId = 'aeiou';
    //     subscribeRequestAccount.crmId = 'aeiou';
    //     subscribeRequestAccount.currency = 'aeiou';
    //     subscribeRequestAccount.customerServiceRepName = 'aeiou';
    //     subscribeRequestAccount.defaultPaymentMethodId = 'aeiou';
    //     subscribeRequestAccount.id = 'aeiou';
    //     subscribeRequestAccount.invoiceDeliveryPrefsEmail = true;
    //     subscribeRequestAccount.invoiceDeliveryPrefsPrint = true;
    //     subscribeRequestAccount.invoiceTemplateId = 'aeiou';
    //     subscribeRequestAccount.lastInvoiceDate = Date.newInstance(2000, 1, 23);
    //     subscribeRequestAccount.name = 'aeiou';
    //     subscribeRequestAccount.notes = 'aeiou';
    //     subscribeRequestAccount.parentId = 'aeiou';
    //     subscribeRequestAccount.paymentGateway = 'aeiou';
    //     subscribeRequestAccount.paymentTerm = 'aeiou';
    //     subscribeRequestAccount.purchaseOrderNumber = 'aeiou';
    //     subscribeRequestAccount.salesRepName = 'aeiou';
    //     subscribeRequestAccount.taxCompanyCode = 'aeiou';
    //     subscribeRequestAccount.taxExemptCertificateID = 'aeiou';
    //     subscribeRequestAccount.taxExemptCertificateType = 'aeiou';
    //     subscribeRequestAccount.taxExemptDescription = 'aeiou';
    //     subscribeRequestAccount.taxExemptEffectiveDate = Date.newInstance(2000, 1, 23);
    //     subscribeRequestAccount.taxExemptExpirationDate = Date.newInstance(2000, 1, 23);
    //     subscribeRequestAccount.taxExemptIssuingJurisdiction = 'aeiou';
    //     subscribeRequestAccount.taxExemptStatus = 'aeiou';
    //     subscribeRequestAccount.totalInvoiceBalance = 1.3579;
    //     subscribeRequestAccount.vaTId = 'aeiou';
    //     return subscribeRequestAccount;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_SubscribeRequestAccount) {
            zc_SubscribeRequestAccount subscribeRequestAccount = (zc_SubscribeRequestAccount) obj;
            return this.classNS == subscribeRequestAccount.classNS
                && this.customerTypeNS == subscribeRequestAccount.customerTypeNS
                && this.departmentNS == subscribeRequestAccount.departmentNS
                && this.integrationIdNS == subscribeRequestAccount.integrationIdNS
                && this.integrationStatusNS == subscribeRequestAccount.integrationStatusNS
                && this.locationNS == subscribeRequestAccount.locationNS
                && this.subsidiaryNS == subscribeRequestAccount.subsidiaryNS
                && this.syncDateNS == subscribeRequestAccount.syncDateNS
                && this.synctoNetSuiteNS == subscribeRequestAccount.synctoNetSuiteNS
                && this.accountNumber == subscribeRequestAccount.accountNumber
                && this.additionalEmailAddresses == subscribeRequestAccount.additionalEmailAddresses
                && this.allowInvoiceEdit == subscribeRequestAccount.allowInvoiceEdit
                && this.autoPay == subscribeRequestAccount.autoPay
                && this.batch == subscribeRequestAccount.batch
                && this.bcdSettingOption == subscribeRequestAccount.bcdSettingOption
                && this.billCycleDay == subscribeRequestAccount.billCycleDay
                && this.communicationProfileId == subscribeRequestAccount.communicationProfileId
                && this.crmId == subscribeRequestAccount.crmId
                && this.currency2 == subscribeRequestAccount.currency2
                && this.customerServiceRepName == subscribeRequestAccount.customerServiceRepName
                && this.defaultPaymentMethodId == subscribeRequestAccount.defaultPaymentMethodId
                && this.id == subscribeRequestAccount.id
                && this.invoiceDeliveryPrefsEmail == subscribeRequestAccount.invoiceDeliveryPrefsEmail
                && this.invoiceDeliveryPrefsPrint == subscribeRequestAccount.invoiceDeliveryPrefsPrint
                && this.invoiceTemplateId == subscribeRequestAccount.invoiceTemplateId
                && this.lastInvoiceDate == subscribeRequestAccount.lastInvoiceDate
                && this.name == subscribeRequestAccount.name
                && this.notes == subscribeRequestAccount.notes
                && this.parentId == subscribeRequestAccount.parentId
                && this.paymentGateway == subscribeRequestAccount.paymentGateway
                && this.paymentTerm == subscribeRequestAccount.paymentTerm
                && this.purchaseOrderNumber == subscribeRequestAccount.purchaseOrderNumber
                && this.salesRepName == subscribeRequestAccount.salesRepName
                && this.taxCompanyCode == subscribeRequestAccount.taxCompanyCode
                && this.taxExemptCertificateID == subscribeRequestAccount.taxExemptCertificateID
                && this.taxExemptCertificateType == subscribeRequestAccount.taxExemptCertificateType
                && this.taxExemptDescription == subscribeRequestAccount.taxExemptDescription
                && this.taxExemptEffectiveDate == subscribeRequestAccount.taxExemptEffectiveDate
                && this.taxExemptExpirationDate == subscribeRequestAccount.taxExemptExpirationDate
                && this.taxExemptIssuingJurisdiction == subscribeRequestAccount.taxExemptIssuingJurisdiction
                && this.taxExemptStatus == subscribeRequestAccount.taxExemptStatus
                && this.totalInvoiceBalance == subscribeRequestAccount.totalInvoiceBalance
                && this.vaTId == subscribeRequestAccount.vaTId;
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
        hashCode = (17 * hashCode) + (batch == null ? 0 : System.hashCode(batch));
        hashCode = (17 * hashCode) + (bcdSettingOption == null ? 0 : System.hashCode(bcdSettingOption));
        hashCode = (17 * hashCode) + (billCycleDay == null ? 0 : System.hashCode(billCycleDay));
        hashCode = (17 * hashCode) + (communicationProfileId == null ? 0 : System.hashCode(communicationProfileId));
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
        hashCode = (17 * hashCode) + (taxCompanyCode == null ? 0 : System.hashCode(taxCompanyCode));
        hashCode = (17 * hashCode) + (taxExemptCertificateID == null ? 0 : System.hashCode(taxExemptCertificateID));
        hashCode = (17 * hashCode) + (taxExemptCertificateType == null ? 0 : System.hashCode(taxExemptCertificateType));
        hashCode = (17 * hashCode) + (taxExemptDescription == null ? 0 : System.hashCode(taxExemptDescription));
        hashCode = (17 * hashCode) + (taxExemptEffectiveDate == null ? 0 : System.hashCode(taxExemptEffectiveDate));
        hashCode = (17 * hashCode) + (taxExemptExpirationDate == null ? 0 : System.hashCode(taxExemptExpirationDate));
        hashCode = (17 * hashCode) + (taxExemptIssuingJurisdiction == null ? 0 : System.hashCode(taxExemptIssuingJurisdiction));
        hashCode = (17 * hashCode) + (taxExemptStatus == null ? 0 : System.hashCode(taxExemptStatus));
        hashCode = (17 * hashCode) + (totalInvoiceBalance == null ? 0 : System.hashCode(totalInvoiceBalance));
        hashCode = (17 * hashCode) + (vaTId == null ? 0 : System.hashCode(vaTId));
        return hashCode;
    }
}