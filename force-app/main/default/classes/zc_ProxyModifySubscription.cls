/**
 * zc_ProxyModifySubscription
 */
public class zc_ProxyModifySubscription {
    /**
     * The Bundle product structures from Zuora Quotes if you utilize Bundling in Salesforce. Do not change the value in this field.\n
     * @return cpqBundleJsonIdQT
     */
    public String cpqBundleJsonIdQT { get; set; }

    /**
     * The closing date of the Opportunity. This field is used in Zuora data sources to report on Subscription metrics. If the subscription originated from Zuora Quotes, the value is populated with the value from Zuora Quotes.\n
     * @return opportunityCloseDateQT
     */
    public Date opportunityCloseDateQT { get; set; }

    /**
     * The unique identifier of the Opportunity. This field is used in Zuora data sources to report on Subscription metrics. If the subscription originated from Zuora Quotes, the value is populated with the value from Zuora Quotes.\n
     * @return opportunityNameQT
     */
    public String opportunityNameQT { get; set; }

    /**
     * The specific identifier for the type of business transaction the Quote represents such as New, Upsell, Downsell, Renewal or Churn. This field is used in Zuora data sources to report on Subscription metrics. If the subscription originated from Zuora Quotes, the value is populated with the value from Zuora Quotes.\n
     * @return quoteBusinessTypeQT
     */
    public String quoteBusinessTypeQT { get; set; }

    /**
     * The unique identifier of the Quote. This field is used in Zuora data sources to report on Subscription metrics. If the subscription originated from Zuora Quotes, the value is populated with the value from Zuora Quotes.\n
     * @return quoteNumberQT
     */
    public String quoteNumberQT { get; set; }

    /**
     * The Quote type that represents the subscription lifecycle stage such as New, Amendment, Renew or Cancel. This field is used in Zuora data sources to report on Subscription metrics. If the subscription originated from Zuora Quotes, the value is populated with the value from Zuora Quotes.\n
     * @return quoteTypeQT
     */
    public String quoteTypeQT { get; set; }

    /**
     * ID of the corresponding object in NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return integrationIdNS
     */
    public String integrationIdNS { get; set; }

    /**
     * Status of the subscription\'s synchronization with NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return integrationStatusNS
     */
    public String integrationStatusNS { get; set; }

    /**
     * The NetSuite project that the subscription was created from. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return projectNS
     */
    public String projectNS { get; set; }

    /**
     * The NetSuite sales order than the subscription was created from. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return salesOrderNS
     */
    public String salesOrderNS { get; set; }

    /**
     * Date when the subscription was synchronized with NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return syncDateNS
     */
    public String syncDateNS { get; set; }

    /**
     *  This field can be updated when **Status** is `Draft`. The ID of a valid account ID. 
     * @return accountId
     */
    public String accountId { get; set; }

    /**
     *  This field can be updated when **Status** is `Draft`. Indicates if the subscription automatically renews at the end of the term.\n**Values**: `true`, `false` 
     * @return autoRenew
     */
    public Boolean autoRenew { get; set; }

    /**
     *  The date of the Amendment object.\n**Values**: inherited from `Amendment.EffectiveDate` 
     * @return cancelledDate
     */
    public Date cancelledDate { get; set; }

    /**
     *  The date when the customer accepts the contract. This field can be updated when **Status** is `Draft`. 
     * @return contractAcceptanceDate
     */
    public Date contractAcceptanceDate { get; set; }

    /**
     *  The date when the contract takes effect. This field can be updated when **Status** is `Draft`.\n**Note**: This field is required in the Subscribe call. If you set the value of this field to null and both the ServiceActivationDate and ContractAcceptanceDate fields are not required, the Subscribe call still returns success, but the new subscription is in `DRAFT` status. To activate the subscription, you must set a valid date to this field. 
     * @return contractEffectiveDate
     */
    public Date contractEffectiveDate { get; set; }

    /**
     *  The period type for the current subscription term. This field is used with the CurrentTerm field to specify the current subscription term.\n**Values**:\n\n- `Month` (default)\n- `Year`\n- `Day`\n- `Week`\n
     * @return currentTermPeriodType
     */
    public String currentTermPeriodType { get; set; }

    /**
     *  The length of the period for the first subscription term. This field can be updated when Status is `Draft`.\n**Required**: If TermType is Termed **Character limit**: 20 **Values**: any valid number. The default value is 0. 
     * @return initialTerm
     */
    public Integer initialTerm { get; set; }

    /**
     *  The period type for the first subscription term.\n**Values**:\n\n- `Month` (default)\n- `Year`\n- `Day`\n- `Week`\n**Note**:\n\n- This field can be updated when Status is `Draft`.\n- This field is used with the InitialTerm field to specify the initial subscription term.\n
     * @return initialTermPeriodType
     */
    public String initialTermPeriodType { get; set; }

    /**
     *  This field can be updated when **Status** is `Draft`. A valid account ID. 
     * @return invoiceOwnerId
     */
    public String invoiceOwnerId { get; set; }

    /**
     *  Determines if the subscription is invoiced separately. If `TRUE`, then all charges for this subscription are collected into the subscription\'s own invoice.\n**Values**: `TRUE`, `FALSE `(default) 
     * @return isInvoiceSeparate
     */
    public Boolean isInvoiceSeparate { get; set; }

    /**
     *  The unique identifier of the subscription. If you don\'t specify a value, then Zuora generates a name automatically. Whether auto-generated or manually specified, the subscription name must be unique. Otherwise an error will occur.\n**Character limit**: 100 **Values**: one of the following:\n\n- leave null to automatically generate\n- a string of 100 characters or fewer\n
     * @return name
     */
    public String name { get; set; }

    /**
     *  Use this field to record comments about the subscription.\n**Character limit**: 500 **Values**: a string of 500 characters or fewer 
     * @return notes
     */
    public String notes { get; set; }

    /**
     *  This field can be updated when **Status** is `Draft`. Specifies whether a termed subscription will remain termed or change to evergreen when it is renewed.\n**Required**: If TermType is Termed **Values**: `RENEW_WITH_SPECIFIC_TERM `(default), `RENEW_TO_EVERGREEN` 
     * @return renewalSetting
     */
    public String renewalSetting { get; set; }

    /**
     *  The length of the period for the subscription renewal term. This field can be updated when **Status** is `Draft`. **Required**: If TermType is Termed.\n**Character limit**: 20 **Values**: one of the following:\n\n- leave null to default to `0`\n- any number\n
     * @return renewalTerm
     */
    public Integer renewalTerm { get; set; }

    /**
     *  The period type for the subscription renewal term.\n**Values**:\n\n- `Month` (default)\n- `Year`\n- `Day`\n- `Week`\n**Note**:\n\n- This field is used with the RenewalTerm field to specify the subscription renewal term.\n- This field can be updated when Status is `Draft`.\n
     * @return renewalTermPeriodType
     */
    public String renewalTermPeriodType { get; set; }

    /**
     *  The date when the subscription is activated. This field can be updated when **Status** is `Draft`.\n**Character limit**: 29 
     * @return serviceActivationDate
     */
    public Date serviceActivationDate { get; set; }

    /**
     *  The status of the subscription.\n**Character limit**: 17 **Values**: automatically generated **Possible values**: one of the following:\n\n- `Draft`\n- `Pending Activation`\n- `Pending Acceptance`\n- `Active`\n- `Cancelled`\n- `Expired`\n- `Suspended` (This value is in **Limited Availability**.)\n
     * @return status
     */
    public String status { get; set; }

    /**
     *  This field can be updated when **Status** is `Draft`. The date when the subscription term begins. If this is a renewal subscription, then this date is different from the subscription start date.\n**Character limit**: 29 **Version notes**: -- 
     * @return termStartDate
     */
    public Date termStartDate { get; set; }

    /**
     *  This field can be updated when **Status** is `Draft`. Indicates if a subscription is termed or evergreen.\n**Character limit**: 9 **Values**: `TERMED`, `EVERGREEN` 
     * @return termType
     */
    public String termType { get; set; }

    /**
     *  The version number of the subscription.\n**Values**: automatically generated 
     * @return version
     */
    public Integer version { get; set; }

    public String tech_FlagRejetPaye { get; set; }
    public String codeFinContrat { get; set; }
    public Date dateFinContrat { get; set; }
    public String tech_AvecRembouesement { get; set; }
    public String cancelCaseID { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'CpqBundleJsonId__QT' => 'cpqBundleJsonIdQT',
        'OpportunityCloseDate__QT' => 'opportunityCloseDateQT',
        'OpportunityName__QT' => 'opportunityNameQT',
        'QuoteBusinessType__QT' => 'quoteBusinessTypeQT',
        'QuoteNumber__QT' => 'quoteNumberQT',
        'QuoteType__QT' => 'quoteTypeQT',
        'IntegrationId__NS' => 'integrationIdNS',
        'IntegrationStatus__NS' => 'integrationStatusNS',
        'Project__NS' => 'projectNS',
        'SalesOrder__NS' => 'salesOrderNS',
        'SyncDate__NS' => 'syncDateNS',
        'AccountId' => 'accountId',
        'AutoRenew' => 'autoRenew',
        'CancelledDate' => 'cancelledDate',
        'ContractAcceptanceDate' => 'contractAcceptanceDate',
        'ContractEffectiveDate' => 'contractEffectiveDate',
        'CurrentTermPeriodType' => 'currentTermPeriodType',
        'InitialTerm' => 'initialTerm',
        'InitialTermPeriodType' => 'initialTermPeriodType',
        'InvoiceOwnerId' => 'invoiceOwnerId',
        'IsInvoiceSeparate' => 'isInvoiceSeparate',
        'Name' => 'name',
        'Notes' => 'notes',
        'RenewalSetting' => 'renewalSetting',
        'RenewalTerm' => 'renewalTerm',
        'RenewalTermPeriodType' => 'renewalTermPeriodType',
        'ServiceActivationDate' => 'serviceActivationDate',
        'Status' => 'status',
        'TermStartDate' => 'termStartDate',
        'TermType' => 'termType',
        'Version' => 'version',
        'CodeFinContrat__c' => 'codeFinContrat',
        'DateFinContrat__c' => 'dateFinContrat',
        'Tech_AvecRembouesement__c' => 'tech_AvecRembouesement',
        'CancelCaseID__c' => 'cancelCaseID'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }


    public Boolean equals(Object obj) {
        if (obj instanceof zc_ProxyModifySubscription) {
            zc_ProxyModifySubscription proxyModifySubscription = (zc_ProxyModifySubscription) obj;
            return this.cpqBundleJsonIdQT == proxyModifySubscription.cpqBundleJsonIdQT
                && this.opportunityCloseDateQT == proxyModifySubscription.opportunityCloseDateQT
                && this.opportunityNameQT == proxyModifySubscription.opportunityNameQT
                && this.quoteBusinessTypeQT == proxyModifySubscription.quoteBusinessTypeQT
                && this.quoteNumberQT == proxyModifySubscription.quoteNumberQT
                && this.quoteTypeQT == proxyModifySubscription.quoteTypeQT
                && this.integrationIdNS == proxyModifySubscription.integrationIdNS
                && this.integrationStatusNS == proxyModifySubscription.integrationStatusNS
                && this.projectNS == proxyModifySubscription.projectNS
                && this.salesOrderNS == proxyModifySubscription.salesOrderNS
                && this.syncDateNS == proxyModifySubscription.syncDateNS
                && this.accountId == proxyModifySubscription.accountId
                && this.autoRenew == proxyModifySubscription.autoRenew
                && this.cancelledDate == proxyModifySubscription.cancelledDate
                && this.contractAcceptanceDate == proxyModifySubscription.contractAcceptanceDate
                && this.contractEffectiveDate == proxyModifySubscription.contractEffectiveDate
                && this.currentTermPeriodType == proxyModifySubscription.currentTermPeriodType
                && this.initialTerm == proxyModifySubscription.initialTerm
                && this.initialTermPeriodType == proxyModifySubscription.initialTermPeriodType
                && this.invoiceOwnerId == proxyModifySubscription.invoiceOwnerId
                && this.isInvoiceSeparate == proxyModifySubscription.isInvoiceSeparate
                && this.name == proxyModifySubscription.name
                && this.notes == proxyModifySubscription.notes
                && this.renewalSetting == proxyModifySubscription.renewalSetting
                && this.renewalTerm == proxyModifySubscription.renewalTerm
                && this.renewalTermPeriodType == proxyModifySubscription.renewalTermPeriodType
                && this.serviceActivationDate == proxyModifySubscription.serviceActivationDate
                && this.status == proxyModifySubscription.status
                && this.termStartDate == proxyModifySubscription.termStartDate
                && this.termType == proxyModifySubscription.termType
                && this.version == proxyModifySubscription.version;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (cpqBundleJsonIdQT == null ? 0 : System.hashCode(cpqBundleJsonIdQT));
        hashCode = (17 * hashCode) + (opportunityCloseDateQT == null ? 0 : System.hashCode(opportunityCloseDateQT));
        hashCode = (17 * hashCode) + (opportunityNameQT == null ? 0 : System.hashCode(opportunityNameQT));
        hashCode = (17 * hashCode) + (quoteBusinessTypeQT == null ? 0 : System.hashCode(quoteBusinessTypeQT));
        hashCode = (17 * hashCode) + (quoteNumberQT == null ? 0 : System.hashCode(quoteNumberQT));
        hashCode = (17 * hashCode) + (quoteTypeQT == null ? 0 : System.hashCode(quoteTypeQT));
        hashCode = (17 * hashCode) + (integrationIdNS == null ? 0 : System.hashCode(integrationIdNS));
        hashCode = (17 * hashCode) + (integrationStatusNS == null ? 0 : System.hashCode(integrationStatusNS));
        hashCode = (17 * hashCode) + (projectNS == null ? 0 : System.hashCode(projectNS));
        hashCode = (17 * hashCode) + (salesOrderNS == null ? 0 : System.hashCode(salesOrderNS));
        hashCode = (17 * hashCode) + (syncDateNS == null ? 0 : System.hashCode(syncDateNS));
        hashCode = (17 * hashCode) + (accountId == null ? 0 : System.hashCode(accountId));
        hashCode = (17 * hashCode) + (autoRenew == null ? 0 : System.hashCode(autoRenew));
        hashCode = (17 * hashCode) + (cancelledDate == null ? 0 : System.hashCode(cancelledDate));
        hashCode = (17 * hashCode) + (contractAcceptanceDate == null ? 0 : System.hashCode(contractAcceptanceDate));
        hashCode = (17 * hashCode) + (contractEffectiveDate == null ? 0 : System.hashCode(contractEffectiveDate));
        hashCode = (17 * hashCode) + (currentTermPeriodType == null ? 0 : System.hashCode(currentTermPeriodType));
        hashCode = (17 * hashCode) + (initialTerm == null ? 0 : System.hashCode(initialTerm));
        hashCode = (17 * hashCode) + (initialTermPeriodType == null ? 0 : System.hashCode(initialTermPeriodType));
        hashCode = (17 * hashCode) + (invoiceOwnerId == null ? 0 : System.hashCode(invoiceOwnerId));
        hashCode = (17 * hashCode) + (isInvoiceSeparate == null ? 0 : System.hashCode(isInvoiceSeparate));
        hashCode = (17 * hashCode) + (name == null ? 0 : System.hashCode(name));
        hashCode = (17 * hashCode) + (notes == null ? 0 : System.hashCode(notes));
        hashCode = (17 * hashCode) + (renewalSetting == null ? 0 : System.hashCode(renewalSetting));
        hashCode = (17 * hashCode) + (renewalTerm == null ? 0 : System.hashCode(renewalTerm));
        hashCode = (17 * hashCode) + (renewalTermPeriodType == null ? 0 : System.hashCode(renewalTermPeriodType));
        hashCode = (17 * hashCode) + (serviceActivationDate == null ? 0 : System.hashCode(serviceActivationDate));
        hashCode = (17 * hashCode) + (status == null ? 0 : System.hashCode(status));
        hashCode = (17 * hashCode) + (termStartDate == null ? 0 : System.hashCode(termStartDate));
        hashCode = (17 * hashCode) + (termType == null ? 0 : System.hashCode(termType));
        hashCode = (17 * hashCode) + (version == null ? 0 : System.hashCode(version));
        return hashCode;
    }
}