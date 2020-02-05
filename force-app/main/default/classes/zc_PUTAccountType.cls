/**
 * zc_PUTAccountType
 */
public class zc_PUTAccountType {
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
     * A list of additional email addresses to receive emailed invoices. Use a comma to separate each email address.\n\n**Note:** Invoices are emailed to the email addresses specified in this field only when the `invoiceDeliveryPrefsEmail` field is `true`.\n
     * @return additionalEmailAddresses
     */
    public List<String> additionalEmailAddresses { get; set; }

    /**
     * Whether future payments are to be automatically billed when they are due. \n
     * @return autoPay
     */
    public Boolean autoPay { get; set; }

    /**
     * The alias name given to a batch. A string of 50 characters or less.\n
     * @return batch
     */
    public String batch { get; set; }

    /**
     * Get billToContact
     * @return billToContact
     */
    public zc_PUTAccountTypeBillToContact billToContact { get; set; }

    /**
     * The ID of a communication profile.\n
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
     * **Note**: This field is only available if you have the Invoice Settlement feature enabled. The Invoice Settlement feature is in **Limited Availability**. If you wish to have access to the feature, submit a request at [Zuora Global Support](http://support.zuora.com/).\n\nThe unique ID of the debit memo template, configured in **Billing Settings** > **Manage Billing Document Configuration** through the Zuora UI. For example, 2c92c08d62470a8501626b19d24f19e2.\n
     * @return debitMemoTemplateId
     */
    public String debitMemoTemplateId { get; set; }

    /**
     * Whether the customer wants to receive invoices through email. \n\nThe default value is `false`.\n
     * @return invoiceDeliveryPrefsEmail
     */
    public Boolean invoiceDeliveryPrefsEmail { get; set; }

    /**
     * Whether the customer wants to receive printed invoices, such as through postal mail.\n\nThe default value is `false`.\n
     * @return invoiceDeliveryPrefsPrint
     */
    public Boolean invoiceDeliveryPrefsPrint { get; set; }

    /**
     * Invoice template ID, configured in Billing Settings in the Zuora UI.\n
     * @return invoiceTemplateId
     */
    public String invoiceTemplateId { get; set; }

    /**
     * Account name, up to 255 characters.\n
     * @return name
     */
    public String name { get; set; }

    /**
     * A string of up to 65,535 characters.\n
     * @return notes
     */
    public String notes { get; set; }

    /**
     * Identifier of the parent customer account for this Account object. The length is 32 characters. Use this field if you have customer hierarchy enabled.
     * @return parentId
     */
    public String parentId { get; set; }

    /**
     * The name of the payment gateway instance. If null or left unassigned, the Account will use the Default Gateway.\n
     * @return paymentGateway
     */
    public String paymentGateway { get; set; }

    /**
     * The name of the sales representative associated with this account, if applicable. Maximum of 50 characters.
     * @return salesRep
     */
    public String salesRep { get; set; }

    /**
     * The ID of the billing document sequence set to assign to the customer account. \n\nThe billing documents to generate for this account will adopt the prefix and starting document number configured in the sequence set.\n\nIf a customer account has no assigned billing document sequence set, billing documents generated for this account adopt the prefix and starting document number from the default sequence set.\n
     * @return sequenceSetId
     */
    public String sequenceSetId { get; set; }

    /**
     * Get soldToContact
     * @return soldToContact
     */
    public zc_PUTAccountTypeSoldToContact soldToContact { get; set; }

    /**
     * 
     * @return tagging
     */
    public String tagging { get; set; }

    /**
     * Get taxInfo
     * @return taxInfo
     */
    //MBEN public zc_POSTAccountTypeTaxInfo taxInfo { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Class__NS' => 'classNS',
        'CustomerType__NS' => 'customerTypeNS',
        'Department__NS' => 'departmentNS',
        'IntegrationId__NS' => 'integrationIdNS',
        'IntegrationStatus__NS' => 'integrationStatusNS',
        'Location__NS' => 'locationNS',
        'Subsidiary__NS' => 'subsidiaryNS',
        'SyncDate__NS' => 'syncDateNS',
        'SynctoNetSuite__NS' => 'synctoNetSuiteNS'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public zc_PUTAccountType() {
        additionalEmailAddresses = new List<String>();
    }

    // public static zc_PUTAccountType getExample() {
    //     zc_PUTAccountType puTAccountType = new zc_PUTAccountType();
    //     puTAccountType.classNS = 'aeiou';
    //     puTAccountType.customerTypeNS = CustomerTypeNSEnum.COMPANY;
    //     puTAccountType.departmentNS = 'aeiou';
    //     puTAccountType.integrationIdNS = 'aeiou';
    //     puTAccountType.integrationStatusNS = 'aeiou';
    //     puTAccountType.locationNS = 'aeiou';
    //     puTAccountType.subsidiaryNS = 'aeiou';
    //     puTAccountType.syncDateNS = 'aeiou';
    //     puTAccountType.synctoNetSuiteNS = SynctoNetSuiteNSEnum.YES;
    //     puTAccountType.additionalEmailAddresses = new List<String>{'aeiou'};
    //     puTAccountType.autoPay = true;
    //     puTAccountType.batch = 'aeiou';
    //     puTAccountType.billToContact = zc_PUTAccountTypeBillToContact.getExample();
    //     puTAccountType.communicationProfileId = 'aeiou';
    //     puTAccountType.creditMemoTemplateId = 'aeiou';
    //     puTAccountType.crmId = 'aeiou';
    //     puTAccountType.debitMemoTemplateId = 'aeiou';
    //     puTAccountType.invoiceDeliveryPrefsEmail = true;
    //     puTAccountType.invoiceDeliveryPrefsPrint = true;
    //     puTAccountType.invoiceTemplateId = 'aeiou';
    //     puTAccountType.name = 'aeiou';
    //     puTAccountType.notes = 'aeiou';
    //     puTAccountType.parentId = 'aeiou';
    //     puTAccountType.paymentGateway = 'aeiou';
    //     puTAccountType.salesRep = 'aeiou';
    //     puTAccountType.sequenceSetId = 'aeiou';
    //     puTAccountType.soldToContact = zc_PUTAccountTypeSoldToContact.getExample();
    //     puTAccountType.tagging = 'aeiou';
    //     puTAccountType.taxInfo = zc_POSTAccountTypeTaxInfo.getExample();
    //     return puTAccountType;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_PUTAccountType) {
            zc_PUTAccountType puTAccountType = (zc_PUTAccountType) obj;
            return this.classNS == puTAccountType.classNS
                && this.customerTypeNS == puTAccountType.customerTypeNS
                && this.departmentNS == puTAccountType.departmentNS
                && this.integrationIdNS == puTAccountType.integrationIdNS
                && this.integrationStatusNS == puTAccountType.integrationStatusNS
                && this.locationNS == puTAccountType.locationNS
                && this.subsidiaryNS == puTAccountType.subsidiaryNS
                && this.syncDateNS == puTAccountType.syncDateNS
                && this.synctoNetSuiteNS == puTAccountType.synctoNetSuiteNS
                && this.additionalEmailAddresses == puTAccountType.additionalEmailAddresses
                && this.autoPay == puTAccountType.autoPay
                && this.batch == puTAccountType.batch
                && this.billToContact == puTAccountType.billToContact
                && this.communicationProfileId == puTAccountType.communicationProfileId
                && this.creditMemoTemplateId == puTAccountType.creditMemoTemplateId
                && this.crmId == puTAccountType.crmId
                && this.debitMemoTemplateId == puTAccountType.debitMemoTemplateId
                && this.invoiceDeliveryPrefsEmail == puTAccountType.invoiceDeliveryPrefsEmail
                && this.invoiceDeliveryPrefsPrint == puTAccountType.invoiceDeliveryPrefsPrint
                && this.invoiceTemplateId == puTAccountType.invoiceTemplateId
                && this.name == puTAccountType.name
                && this.notes == puTAccountType.notes
                && this.parentId == puTAccountType.parentId
                && this.paymentGateway == puTAccountType.paymentGateway
                && this.salesRep == puTAccountType.salesRep
                && this.sequenceSetId == puTAccountType.sequenceSetId
                && this.soldToContact == puTAccountType.soldToContact
                && this.tagging == puTAccountType.tagging;
                //&& this.taxInfo == puTAccountType.taxInfo;
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
        hashCode = (17 * hashCode) + (additionalEmailAddresses == null ? 0 : System.hashCode(additionalEmailAddresses));
        hashCode = (17 * hashCode) + (autoPay == null ? 0 : System.hashCode(autoPay));
        hashCode = (17 * hashCode) + (batch == null ? 0 : System.hashCode(batch));
        hashCode = (17 * hashCode) + (billToContact == null ? 0 : System.hashCode(billToContact));
        hashCode = (17 * hashCode) + (communicationProfileId == null ? 0 : System.hashCode(communicationProfileId));
        hashCode = (17 * hashCode) + (creditMemoTemplateId == null ? 0 : System.hashCode(creditMemoTemplateId));
        hashCode = (17 * hashCode) + (crmId == null ? 0 : System.hashCode(crmId));
        hashCode = (17 * hashCode) + (debitMemoTemplateId == null ? 0 : System.hashCode(debitMemoTemplateId));
        hashCode = (17 * hashCode) + (invoiceDeliveryPrefsEmail == null ? 0 : System.hashCode(invoiceDeliveryPrefsEmail));
        hashCode = (17 * hashCode) + (invoiceDeliveryPrefsPrint == null ? 0 : System.hashCode(invoiceDeliveryPrefsPrint));
        hashCode = (17 * hashCode) + (invoiceTemplateId == null ? 0 : System.hashCode(invoiceTemplateId));
        hashCode = (17 * hashCode) + (name == null ? 0 : System.hashCode(name));
        hashCode = (17 * hashCode) + (notes == null ? 0 : System.hashCode(notes));
        hashCode = (17 * hashCode) + (parentId == null ? 0 : System.hashCode(parentId));
        hashCode = (17 * hashCode) + (paymentGateway == null ? 0 : System.hashCode(paymentGateway));
        hashCode = (17 * hashCode) + (salesRep == null ? 0 : System.hashCode(salesRep));
        hashCode = (17 * hashCode) + (sequenceSetId == null ? 0 : System.hashCode(sequenceSetId));
        hashCode = (17 * hashCode) + (soldToContact == null ? 0 : System.hashCode(soldToContact));
        hashCode = (17 * hashCode) + (tagging == null ? 0 : System.hashCode(tagging));
        //hashCode = (17 * hashCode) + (taxInfo == null ? 0 : System.hashCode(taxInfo));
        return hashCode;
    }
}