/**
 * 
 */
public class zc_SubscribeRequestSubscriptionDataSub {
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
     *  This field can be updated when `Status` is `Draft`. 
     * @return accountId
     */
    public String accountId { get; set; }

    /**
     *  A filter option for querying all subscriptions under the same account hierarchy.\n\n\n**Character limit**: 32\n\n\n**Values**: a valid account ID 
     * @return ancestorAccountId
     */
    public String ancestorAccountId { get; set; }

    /**
     *  This field can be updated when `Status` is `Draft`. Indicates if the subscription automatically renews at the end of the term. This field is only required if the `TermType` field is set to `TERMED`.\n\n\n\n**Values**: `true`, `false` 
     * @return autoRenew
     */
    public Boolean autoRenew { get; set; }

    /**
     *  The date of the amendment that canceled the subscription.\n\n\n\n**Values**: inherited from `Amendment`.`EffectiveDate` 
     * @return cancelledDate
     */
    public Date cancelledDate { get; set; }

    /**
     *  The date when the customer accepts the contract. This field can be updated when **Status** is `Draft`.\n\n\nThis field is only required if the [Require Service Activation of Orders?](https://knowledgecenter.zuora.com/CB_Billing/Billing_Settings/Define_Default_Subscription_Settings#Require_Service_Activation_of_Orders.3F) Setting is set to `Yes`. If this setting is set to `Yes`:\n\n- If ContractAcceptanceDate field is required, you must set this field, ContractAcceptanceDate, and ContractEffectiveDate fields in the subscribe call to activate a subscription.\n- If ContractAcceptanceDate field is not required, you must set both this field and the ContractEffectiveDate field in the subscribe call to activate a subscription. If you only set a valid date in the ContractEffectiveDate field, the subscribe call still returns success, but the subscription is in `DRAT` status.\n
     * @return contractAcceptanceDate
     */
    public Date contractAcceptanceDate { get; set; }

    /**
     *  The date when the contract takes effect. This field can be updated when **Status** is `Draft`.\n\n\n**Note**: This field is required in the subscribe call. If you set the value of this field to null and both the ServiceActivationDate and ContractAcceptanceDate fields are not required, the subscribe call still returns success, but the new subscription is in `DRAFT` status. To activate the subscription, you must set a valid date to this field. 
     * @return contractEffectiveDate
     */
    public Date contractEffectiveDate { get; set; }

    /**
     * The user ID of the person who created the subscription.\n\n**Character limit**: 32\n\n\n**Values**: automatically generated 
     * @return createdById
     */
    public String createdById { get; set; }

    /**
     *  The date the subscription was created. This value is the same as the OriginalCreatedDate value until the subscription is amended.\n\n\n\n**Values**: automatically generated 
     * @return createdDate
     */
    public Datetime createdDate { get; set; }

    /**
     *  The account ID that created the subscription or the amended subscription.\n\n\n**Character limit**: 32\n\n\n**Values**: automatically generated 
     * @return creatorAccountId
     */
    public String creatorAccountId { get; set; }

    /**
     * The account ID that owns the invoices associated with the subscription or the amended subscription.\n\n\n**Character limit**: 32\n\n\n**Values**: automatically generated 
     * @return creatorInvoiceOwnerId
     */
    public String creatorInvoiceOwnerId { get; set; }

    /**
     *  The length of the period for the current subscription term. This field is only required If the `TermType` field is set to `TERMED` and its value must be greater than `0`. If TermType is set to `EVERGREEN`, this value is ignored. Default is `0`.\n\n\n**Character limit**: 20\n\n\n**Values**: automatically generated 
     * @return currentTerm
     */
    public Integer currentTerm { get; set; }

    /**
     *  The period type for the current subscription term. This field is used with the CurrentTerm field to specify the current subscription term.\n\n\n\n**Values**:\n\n- `Month` (default)\n- `Year`\n- `Day`\n- `Week`\n
     * @return currentTermPeriodType
     */
    public String currentTermPeriodType { get; set; }

    /**
     *  The length of the period for the first subscription term. This field can be updated when Status is `Draft`. If you use the subscribe\ncall, this field is required.\n\n\nThis field is only required if the `TermType` field is set to `TERMED`.\n\n**Character limit**: 20\n\n\n**Values**: any valid number. The default value is 0. 
     * @return initialTerm
     */
    public Integer initialTerm { get; set; }

    /**
     *  The period type for the first subscription term.\n\n\n\n**Values**:\n\n- `Month` (default)\n- `Year`\n- `Day`\n- `Week`\n\n\n**Note**:\n\n- This field can be updated when `Status` is `Draft`.\n- This field is used with the `InitialTerm` field to specify the initial subscription term.\n
     * @return initialTermPeriodType
     */
    public String initialTermPeriodType { get; set; }

    /**
     *  This field can be updated when `Status` is `Draft`. 
     * @return invoiceOwnerId
     */
    public String invoiceOwnerId { get; set; }

    /**
     *  Determines if the subscription is invoiced separately. If `TRUE`, then all charges for this subscription are collected into the subscription\'s own invoice.\n\n\n\n**Values**: `TRUE`, `FALSE `(default) 
     * @return isInvoiceSeparate
     */
    public Boolean isInvoiceSeparate { get; set; }

    /**
     *  The unique identifier of the subscription. If you don\'t specify a value, then Zuora generates a name automatically. Whether auto-generated or manually specified, the subscription name must be unique. Otherwise an error will occur. You can change this value only when the subscription is in `Draft` status. Once the subscription is activated, you can\'t change this value, nor can you use this value for a different subscription.\n\n\n**Character limit**: 100\n\n\n**Values**: one of the following:\n\n- leave null to automatically generate\n- a string of 100 characters or fewer\n
     * @return name
     */
    public String name { get; set; }

    /**
     *  Use this field to record comments about the subscription.\n\n\n**Character limit**: 500\n\n\n**Values**: a string of 500 characters or fewer 
     * @return notes
     */
    public String notes { get; set; }

    /**
     *  The date when the subscription was originally created. This value is the same as the CreatedDate value until the subscription is amended.\n\n\n\n**Values**: automatically generated 
     * @return originalCreatedDate
     */
    public Datetime originalCreatedDate { get; set; }

    /**
     *  The original ID of this subscription.\n\n\n\n**Values**: automatically generated 
     * @return originalId
     */
    public String originalId { get; set; }

    /**
     *  The subscription ID immediately prior to the current subscription.\n\n\n**Character limit**: 32\n\n\n**Values**: automatically generated 
     * @return previousSubscriptionId
     */
    public String previousSubscriptionId { get; set; }

    /**
     *  This field can be updated when **Status** is `Draft`. Specifies whether a termed subscription will remain termed or change to evergreen when it is renewed.\n\n\nThis field is only required if the `TermType` field is set to `TERMED`.\n\n\n**Values**: `RENEW_WITH_SPECIFIC_TERM `(default), `RENEW_TO_EVERGREEN` 
     * @return renewalSetting
     */
    public String renewalSetting { get; set; }

    /**
     *  The length of the period for the subscription renewal term. This field can be updated when **Status** is `Draft`. If you use the subscribe\ncall, this field is required.\n\n\nThis field is only required if the `TermType` field is set to `TERMED`.\n\n\n**Character limit**: 20\n\n\n**Values**: one of the following:\n\n- leave null to default to `0`\n- any number\n
     * @return renewalTerm
     */
    public Integer renewalTerm { get; set; }

    /**
     *  The period type for the subscription renewal term.\n\n\n\n**Values**:\n\n- `Month` (default)\n- `Year`\n- `Day`\n- `Week`\n\n\n**Note**:\n\n- This field is used with the RenewalTerm field to specify the subscription renewal term.\n- This field can be updated when Status is `Draft`.\n
     * @return renewalTermPeriodType
     */
    public String renewalTermPeriodType { get; set; }

    /**
     *  The date when the subscription is activated.\nThis field can be updated when **Status** is `Draft`. This field is only required if the [Require Service Activation of Orders?](https://knowledgecenter.zuora.com/CB_Billing/Billing_Settings/Define_Default_Subscription_Settings#Require_Service_Activation_of_Orders.3F) Setting is set to `Yes`.\nIf this setting is set to `Yes`:\n\n- If ContractAcceptanceDate field is required, you must set this field, ContractAcceptanceDate, and ContractEffectiveDate fields in the subscribe call to activate a subscription.\n- If ContractAcceptanceDate field is not required, you must set both this field and the ContractEffectiveDate field in the subscribe call to activate a subscription. If you only set a valid date in the ContractEffectiveDate field, the subscribe call still returns success, but the subscription is in `DRAT` status.\n\n\n**Character limit**: 29\n\n
     * @return serviceActivationDate
     */
    public Date serviceActivationDate { get; set; }

    /**
     *  The status of the subscription.\n\n\n**Character limit**: 17\n\n\n**Values**: automatically generated\n\n**Possible values**: one of the following:\n\n- `Draft`\n- `PendingActivation`\n- `PendingAcceptance`\n- `Active`\n- `Cancelled`\n- `Expired`\n- `Suspended` (This value is in **Limited Availability**.)\n
     * @return status
     */
    public String status { get; set; }

    /**
     *  The date when the subscription term ends, where the subscription ends at midnight the day before. For example, if the SubscriptionEndDate is 12/31/2016, the subscriptions ends at midnight (00:00:00 hours) on 12/30/2016. This date is the same as the term end date or the cancelation date, as appropriate.\n\n\n**Character limit**: 29\n\n\n**Values**: automatically generated 
     * @return subscriptionEndDate
     */
    public Date subscriptionEndDate { get; set; }

    /**
     *  The date when the subscription term starts. This date is the same as the start date of the original term, which isn\'t necessarily the start date of the current or new term.\n\n\n**Character limit**: 29\n\n\n**Values**: automatically generated 
     * @return subscriptionStartDate
     */
    public Date subscriptionStartDate { get; set; }

    /**
     *  This field can be updated when **Status** is `Draft`. The date when the subscription term ends. If the subscription is evergreen, the TermEndDate value is null or is the cancelation date, as appropriate.\n\n**Character limit**: 29\n\n\n**Values**: automatically generated 
     * @return termEndDate
     */
    public Date termEndDate { get; set; }

    /**
     *  This field can be updated when **Status** is `Draft`. The date when the subscription term begins. If this is a renewal subscription, then this date is different from the subscription start date. If you don\'t specify a value, then Zuora uses ContractEffectiveDate automatically.\n\n\n**Character limit**: 29 
     * @return termStartDate
     */
    public Date termStartDate { get; set; }

    /**
     *  This field can be updated when **Status** is `Draft`. Indicates if a subscription is [termed or evergreen](https://knowledgecenter.zuora.com/BC_Subscription_Management/Subscriptions#Termed_and_Evergreen_Subscriptions). A termed subscription has a specific end date and requires manual renewal. An evergreen subscription doesn\'t have an end date and doesn\'t need renewal. This field can be updated when the subscription status is Draft.\n\n\n**Character limit**: 9\n\n\n**Values**: `TERMED`, `EVERGREEN` 
     * @return termType
     */
    public String termType { get; set; }

    /**
     *  The ID of the user who last updated the subscription.\n**Character limit:** 32 **Values: **automatically generated 
     * @return updatedById
     */
    public String updatedById { get; set; }

    /**
     *  The date when the subscription was last updated.\n**Character limit:** 29\n\n\n**Values**: automatically generated 
     * @return updatedDate
     */
    public Datetime updatedDate { get; set; }

    /**
     *  The version number of the subscription.\n\n\n\n**Values**: automatically generated 
     * @return version
     */
    public Integer version { get; set; }

    // MBEN 20191223
    public String codeOffrePrincipale { get; set; }
    public String modeLivraison { get; set; }
    public String marche { get; set; }
    public String codePromo { get; set; }
    public String methodePaiement { get; set; }
    public String codeOffreCo { get; set; }
    public String payeurCRMID { get; set; }
    public String lieu { get; set; }
    public String agent { get; set; }
    public String typeContrat { get; set; }
    public String parrainSFID { get; set; }
    public Date dateFinContrat { get; set; }


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
        'AncestorAccountId' => 'ancestorAccountId',
        'AutoRenew' => 'autoRenew',
        'CancelledDate' => 'cancelledDate',
        'ContractAcceptanceDate' => 'contractAcceptanceDate',
        'ContractEffectiveDate' => 'contractEffectiveDate',
        'CreatedById' => 'createdById',
        'CreatedDate' => 'createdDate',
        'CreatorAccountId' => 'creatorAccountId',
        'CreatorInvoiceOwnerId' => 'creatorInvoiceOwnerId',
        'CurrentTerm' => 'currentTerm',
        'CurrentTermPeriodType' => 'currentTermPeriodType',
        'InitialTerm' => 'initialTerm',
        'InitialTermPeriodType' => 'initialTermPeriodType',
        'InvoiceOwnerId' => 'invoiceOwnerId',
        'IsInvoiceSeparate' => 'isInvoiceSeparate',
        'Name' => 'name',
        'Notes' => 'notes',
        'OriginalCreatedDate' => 'originalCreatedDate',
        'OriginalId' => 'originalId',
        'PreviousSubscriptionId' => 'previousSubscriptionId',
        'RenewalSetting' => 'renewalSetting',
        'RenewalTerm' => 'renewalTerm',
        'RenewalTermPeriodType' => 'renewalTermPeriodType',
        'ServiceActivationDate' => 'serviceActivationDate',
        'Status' => 'status',
        'SubscriptionEndDate' => 'subscriptionEndDate',
        'SubscriptionStartDate' => 'subscriptionStartDate',
        'TermEndDate' => 'termEndDate',
        'TermStartDate' => 'termStartDate',
        'TermType' => 'termType',
        'UpdatedById' => 'updatedById',
        'UpdatedDate' => 'updatedDate',
        'Version' => 'version',
        'CodeOffrePrincipale__c' => 'codeOffrePrincipale',
        'ModeLivraison__c' => 'modeLivraison',
        'Marche__c' => 'marche',
        'CodePromo__c' => 'codePromo',
        'MethodePaiement__c' => 'methodePaiement',
        'CodeOffreCo__c' => 'codeOffreCo',
        'PayeurCRMID__c' => 'payeurCRMID',
        'Lieu__c' => 'lieu',
        'Agent__c' => 'agent',
        'TypeContrat__c' => 'typeContrat',
        'ParrainSFID__c' => 'parrainSFID',
        'DateFinContrat__c' => 'dateFinContrat'
    };


    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    // public static zc_SubscribeRequestSubscriptionData getExample() {
    //     zc_SubscribeRequestSubscriptionData subscribeRequestSubscriptionDataSubscription = new zc_SubscribeRequestSubscriptionData();
    //     subscribeRequestSubscriptionDataSubscription.cpqBundleJsonIdQT = 'aeiou';
    //     subscribeRequestSubscriptionDataSubscription.opportunityCloseDateQT = Date.newInstance(2000, 1, 23);
    //     subscribeRequestSubscriptionDataSubscription.opportunityNameQT = 'aeiou';
    //     subscribeRequestSubscriptionDataSubscription.quoteBusinessTypeQT = 'aeiou';
    //     subscribeRequestSubscriptionDataSubscription.quoteNumberQT = 'aeiou';
    //     subscribeRequestSubscriptionDataSubscription.quoteTypeQT = 'aeiou';
    //     subscribeRequestSubscriptionDataSubscription.integrationIdNS = 'aeiou';
    //     subscribeRequestSubscriptionDataSubscription.integrationStatusNS = 'aeiou';
    //     subscribeRequestSubscriptionDataSubscription.projectNS = 'aeiou';
    //     subscribeRequestSubscriptionDataSubscription.salesOrderNS = 'aeiou';
    //     subscribeRequestSubscriptionDataSubscription.syncDateNS = 'aeiou';
    //     subscribeRequestSubscriptionDataSubscription.accountId = 'aeiou';
    //     subscribeRequestSubscriptionDataSubscription.ancestorAccountId = 'aeiou';
    //     subscribeRequestSubscriptionDataSubscription.autoRenew = true;
    //     subscribeRequestSubscriptionDataSubscription.cancelledDate = Date.newInstance(2000, 1, 23);
    //     subscribeRequestSubscriptionDataSubscription.contractAcceptanceDate = Date.newInstance(2000, 1, 23);
    //     subscribeRequestSubscriptionDataSubscription.contractEffectiveDate = Date.newInstance(2000, 1, 23);
    //     subscribeRequestSubscriptionDataSubscription.createdById = 'aeiou';
    //     subscribeRequestSubscriptionDataSubscription.createdDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    //     subscribeRequestSubscriptionDataSubscription.creatorAccountId = 'aeiou';
    //     subscribeRequestSubscriptionDataSubscription.creatorInvoiceOwnerId = 'aeiou';
    //     subscribeRequestSubscriptionDataSubscription.currentTerm = 123;
    //     subscribeRequestSubscriptionDataSubscription.currentTermPeriodType = 'aeiou';
    //     subscribeRequestSubscriptionDataSubscription.initialTerm = 123;
    //     subscribeRequestSubscriptionDataSubscription.initialTermPeriodType = 'aeiou';
    //     subscribeRequestSubscriptionDataSubscription.invoiceOwnerId = 'aeiou';
    //     subscribeRequestSubscriptionDataSubscription.isInvoiceSeparate = true;
    //     subscribeRequestSubscriptionDataSubscription.name = 'aeiou';
    //     subscribeRequestSubscriptionDataSubscription.notes = 'aeiou';
    //     subscribeRequestSubscriptionDataSubscription.originalCreatedDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    //     subscribeRequestSubscriptionDataSubscription.originalId = 'aeiou';
    //     subscribeRequestSubscriptionDataSubscription.previousSubscriptionId = 'aeiou';
    //     subscribeRequestSubscriptionDataSubscription.renewalSetting = 'aeiou';
    //     subscribeRequestSubscriptionDataSubscription.renewalTerm = 123;
    //     subscribeRequestSubscriptionDataSubscription.renewalTermPeriodType = 'aeiou';
    //     subscribeRequestSubscriptionDataSubscription.serviceActivationDate = Date.newInstance(2000, 1, 23);
    //     subscribeRequestSubscriptionDataSubscription.status = 'aeiou';
    //     subscribeRequestSubscriptionDataSubscription.subscriptionEndDate = Date.newInstance(2000, 1, 23);
    //     subscribeRequestSubscriptionDataSubscription.subscriptionStartDate = Date.newInstance(2000, 1, 23);
    //     subscribeRequestSubscriptionDataSubscription.termEndDate = Date.newInstance(2000, 1, 23);
    //     subscribeRequestSubscriptionDataSubscription.termStartDate = Date.newInstance(2000, 1, 23);
    //     subscribeRequestSubscriptionDataSubscription.termType = 'aeiou';
    //     subscribeRequestSubscriptionDataSubscription.updatedById = 'aeiou';
    //     subscribeRequestSubscriptionDataSubscription.updatedDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    //     subscribeRequestSubscriptionDataSubscription.version = 123;
    //     return subscribeRequestSubscriptionDataSubscription;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_SubscribeRequestSubscriptionDataSub) {
            zc_SubscribeRequestSubscriptionDataSub subscribeRequestSubscriptionDataSubscription = (zc_SubscribeRequestSubscriptionDataSub) obj;
            return this.cpqBundleJsonIdQT == subscribeRequestSubscriptionDataSubscription.cpqBundleJsonIdQT
                && this.opportunityCloseDateQT == subscribeRequestSubscriptionDataSubscription.opportunityCloseDateQT
                && this.opportunityNameQT == subscribeRequestSubscriptionDataSubscription.opportunityNameQT
                && this.quoteBusinessTypeQT == subscribeRequestSubscriptionDataSubscription.quoteBusinessTypeQT
                && this.quoteNumberQT == subscribeRequestSubscriptionDataSubscription.quoteNumberQT
                && this.quoteTypeQT == subscribeRequestSubscriptionDataSubscription.quoteTypeQT
                && this.integrationIdNS == subscribeRequestSubscriptionDataSubscription.integrationIdNS
                && this.integrationStatusNS == subscribeRequestSubscriptionDataSubscription.integrationStatusNS
                && this.projectNS == subscribeRequestSubscriptionDataSubscription.projectNS
                && this.salesOrderNS == subscribeRequestSubscriptionDataSubscription.salesOrderNS
                && this.syncDateNS == subscribeRequestSubscriptionDataSubscription.syncDateNS
                && this.accountId == subscribeRequestSubscriptionDataSubscription.accountId
                && this.ancestorAccountId == subscribeRequestSubscriptionDataSubscription.ancestorAccountId
                && this.autoRenew == subscribeRequestSubscriptionDataSubscription.autoRenew
                && this.cancelledDate == subscribeRequestSubscriptionDataSubscription.cancelledDate
                && this.contractAcceptanceDate == subscribeRequestSubscriptionDataSubscription.contractAcceptanceDate
                && this.contractEffectiveDate == subscribeRequestSubscriptionDataSubscription.contractEffectiveDate
                && this.createdById == subscribeRequestSubscriptionDataSubscription.createdById
                && this.createdDate == subscribeRequestSubscriptionDataSubscription.createdDate
                && this.creatorAccountId == subscribeRequestSubscriptionDataSubscription.creatorAccountId
                && this.creatorInvoiceOwnerId == subscribeRequestSubscriptionDataSubscription.creatorInvoiceOwnerId
                && this.currentTerm == subscribeRequestSubscriptionDataSubscription.currentTerm
                && this.currentTermPeriodType == subscribeRequestSubscriptionDataSubscription.currentTermPeriodType
                && this.initialTerm == subscribeRequestSubscriptionDataSubscription.initialTerm
                && this.initialTermPeriodType == subscribeRequestSubscriptionDataSubscription.initialTermPeriodType
                && this.invoiceOwnerId == subscribeRequestSubscriptionDataSubscription.invoiceOwnerId
                && this.isInvoiceSeparate == subscribeRequestSubscriptionDataSubscription.isInvoiceSeparate
                && this.name == subscribeRequestSubscriptionDataSubscription.name
                && this.notes == subscribeRequestSubscriptionDataSubscription.notes
                && this.originalCreatedDate == subscribeRequestSubscriptionDataSubscription.originalCreatedDate
                && this.originalId == subscribeRequestSubscriptionDataSubscription.originalId
                && this.previousSubscriptionId == subscribeRequestSubscriptionDataSubscription.previousSubscriptionId
                && this.renewalSetting == subscribeRequestSubscriptionDataSubscription.renewalSetting
                && this.renewalTerm == subscribeRequestSubscriptionDataSubscription.renewalTerm
                && this.renewalTermPeriodType == subscribeRequestSubscriptionDataSubscription.renewalTermPeriodType
                && this.serviceActivationDate == subscribeRequestSubscriptionDataSubscription.serviceActivationDate
                && this.status == subscribeRequestSubscriptionDataSubscription.status
                && this.subscriptionEndDate == subscribeRequestSubscriptionDataSubscription.subscriptionEndDate
                && this.subscriptionStartDate == subscribeRequestSubscriptionDataSubscription.subscriptionStartDate
                && this.termEndDate == subscribeRequestSubscriptionDataSubscription.termEndDate
                && this.termStartDate == subscribeRequestSubscriptionDataSubscription.termStartDate
                && this.termType == subscribeRequestSubscriptionDataSubscription.termType
                && this.updatedById == subscribeRequestSubscriptionDataSubscription.updatedById
                && this.updatedDate == subscribeRequestSubscriptionDataSubscription.updatedDate
                && this.version == subscribeRequestSubscriptionDataSubscription.version;
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
        hashCode = (17 * hashCode) + (ancestorAccountId == null ? 0 : System.hashCode(ancestorAccountId));
        hashCode = (17 * hashCode) + (autoRenew == null ? 0 : System.hashCode(autoRenew));
        hashCode = (17 * hashCode) + (cancelledDate == null ? 0 : System.hashCode(cancelledDate));
        hashCode = (17 * hashCode) + (contractAcceptanceDate == null ? 0 : System.hashCode(contractAcceptanceDate));
        hashCode = (17 * hashCode) + (contractEffectiveDate == null ? 0 : System.hashCode(contractEffectiveDate));
        hashCode = (17 * hashCode) + (createdById == null ? 0 : System.hashCode(createdById));
        hashCode = (17 * hashCode) + (createdDate == null ? 0 : System.hashCode(createdDate));
        hashCode = (17 * hashCode) + (creatorAccountId == null ? 0 : System.hashCode(creatorAccountId));
        hashCode = (17 * hashCode) + (creatorInvoiceOwnerId == null ? 0 : System.hashCode(creatorInvoiceOwnerId));
        hashCode = (17 * hashCode) + (currentTerm == null ? 0 : System.hashCode(currentTerm));
        hashCode = (17 * hashCode) + (currentTermPeriodType == null ? 0 : System.hashCode(currentTermPeriodType));
        hashCode = (17 * hashCode) + (initialTerm == null ? 0 : System.hashCode(initialTerm));
        hashCode = (17 * hashCode) + (initialTermPeriodType == null ? 0 : System.hashCode(initialTermPeriodType));
        hashCode = (17 * hashCode) + (invoiceOwnerId == null ? 0 : System.hashCode(invoiceOwnerId));
        hashCode = (17 * hashCode) + (isInvoiceSeparate == null ? 0 : System.hashCode(isInvoiceSeparate));
        hashCode = (17 * hashCode) + (name == null ? 0 : System.hashCode(name));
        hashCode = (17 * hashCode) + (notes == null ? 0 : System.hashCode(notes));
        hashCode = (17 * hashCode) + (originalCreatedDate == null ? 0 : System.hashCode(originalCreatedDate));
        hashCode = (17 * hashCode) + (originalId == null ? 0 : System.hashCode(originalId));
        hashCode = (17 * hashCode) + (previousSubscriptionId == null ? 0 : System.hashCode(previousSubscriptionId));
        hashCode = (17 * hashCode) + (renewalSetting == null ? 0 : System.hashCode(renewalSetting));
        hashCode = (17 * hashCode) + (renewalTerm == null ? 0 : System.hashCode(renewalTerm));
        hashCode = (17 * hashCode) + (renewalTermPeriodType == null ? 0 : System.hashCode(renewalTermPeriodType));
        hashCode = (17 * hashCode) + (serviceActivationDate == null ? 0 : System.hashCode(serviceActivationDate));
        hashCode = (17 * hashCode) + (status == null ? 0 : System.hashCode(status));
        hashCode = (17 * hashCode) + (subscriptionEndDate == null ? 0 : System.hashCode(subscriptionEndDate));
        hashCode = (17 * hashCode) + (subscriptionStartDate == null ? 0 : System.hashCode(subscriptionStartDate));
        hashCode = (17 * hashCode) + (termEndDate == null ? 0 : System.hashCode(termEndDate));
        hashCode = (17 * hashCode) + (termStartDate == null ? 0 : System.hashCode(termStartDate));
        hashCode = (17 * hashCode) + (termType == null ? 0 : System.hashCode(termType));
        hashCode = (17 * hashCode) + (updatedById == null ? 0 : System.hashCode(updatedById));
        hashCode = (17 * hashCode) + (updatedDate == null ? 0 : System.hashCode(updatedDate));
        hashCode = (17 * hashCode) + (version == null ? 0 : System.hashCode(version));
        return hashCode;
    }
}