/**
 * zc_GETSubscriptionTypeWithSuccess
 */
public class zc_GETSubscriptionTypeWithSuccess {
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
     * The ID of the account associated with this subscription.
     * @return accountId
     */
    public String accountId { get; set; }

    /**
     * The name of the account associated with this subscription.
     * @return accountName
     */
    public String accountName { get; set; }

    /**
     * The number of the account associated with this subscription.
     * @return accountNumber
     */
    public String accountNumber { get; set; }

    /**
     * If `true`, the subscription automatically renews at the end of the term. Default is `false`.\n
     * @return autoRenew
     */
    public Boolean autoRenew { get; set; }

    /**
     * Effective contract date for this subscription, as yyyy-mm-dd.\n
     * @return contractEffectiveDate
     */
    public Date contractEffectiveDate { get; set; }

    /**
     * Monthly recurring revenue of the subscription.\n
     * @return contractedMrr
     */
    public String contractedMrr { get; set; }

    /**
     * The length of the period for the current subscription term.\n
     * @return currentTerm
     */
    public Long currentTerm { get; set; }

    /**
     * The period type for the current subscription term.\n\nValues are:\n\n* `Month` (default)\n* `Year`\n* `Day`\n* `Week`\n
     * @return currentTermPeriodType
     */
    public String currentTermPeriodType { get; set; }

    /**
     * The date on which the services or products within a subscription have been accepted by the customer, as yyyy-mm-dd.\n
     * @return customerAcceptanceDate
     */
    public Date customerAcceptanceDate { get; set; }

    /**
     * Subscription ID.\n
     * @return id
     */
    public String id { get; set; }

    /**
     * The length of the period for the first subscription term.\n
     * @return initialTerm
     */
    public Long initialTerm { get; set; }

    /**
     * The period type for the first subscription term.\n\nValues are:\n\n* `Month` (default)\n* `Year`\n* `Day`\n* `Week`\n
     * @return initialTermPeriodType
     */
    public String initialTermPeriodType { get; set; }

    /**
     * 
     * @return invoiceOwnerAccountId
     */
    public String invoiceOwnerAccountId { get; set; }

    /**
     * 
     * @return invoiceOwnerAccountName
     */
    public String invoiceOwnerAccountName { get; set; }

    /**
     * 
     * @return invoiceOwnerAccountNumber
     */
    public String invoiceOwnerAccountNumber { get; set; }

    /**
     * Separates a single subscription from other subscriptions and creates an invoice for the subscription. \n\nIf the value is `true`, the subscription is billed separately from other subscriptions. If the value is `false`, the subscription is included with other subscriptions in the account invoice.\n
     * @return invoiceSeparately
     */
    public String invoiceSeparately { get; set; }

    /**
     * A string of up to 65,535 characters.\n
     * @return notes
     */
    public String notes { get; set; }

    /**
     * The order number of the order in which the changes on the subscription are made. \n\n**Note:** This field is only available if you have the [Order Metrics](https://knowledgecenter.zuora.com/BC_Subscription_Management/Orders/AA_Overview_of_Orders#Order_Metrics) feature enabled. If you wish to have access to the feature, submit a request at [Zuora Global Support](http://support.zuora.com/). We will investigate your use cases and data before enabling this feature for you.\n
     * @return orderNumber
     */
    public String orderNumber { get; set; }

    /**
     * Container for rate plans.\n
     * @return ratePlans
     */
    public List<zc_GETSubscriptionRatePlanType> ratePlans { get; set; }

    /**
     * Specifies whether a termed subscription will remain `TERMED` or change to `EVERGREEN` when it is renewed. \n\nValues are:\n\n* `RENEW_WITH_SPECIFIC_TERM` (default)\n* `RENEW_TO_EVERGREEN`\n
     * @return renewalSetting
     */
    public String renewalSetting { get; set; }

    /**
     * The length of the period for the subscription renewal term.\n
     * @return renewalTerm
     */
    public Long renewalTerm { get; set; }

    /**
     * The period type for the subscription renewal term.\n\nValues are:\n\n* `Month` (default)\n* `Year`\n* `Day`\n* `Week`\n
     * @return renewalTermPeriodType
     */
    public String renewalTermPeriodType { get; set; }

    /**
     * The date on which the services or products within a subscription have been activated and access has been provided to the customer, as yyyy-mm-dd\n
     * @return serviceActivationDate
     */
    public Date serviceActivationDate { get; set; }

    /**
     * Subscription status; possible values are:\n\n* `Draft`\n* `Pending Activation`\n* `Pending Acceptance`\n* `Active`\n* `Cancelled`\n* `Suspended` (This value is in Limited Availability.)\n
     * @return status
     */
    public String status { get; set; }

    /**
     * Subscription number.
     * @return subscriptionNumber
     */
    public String subscriptionNumber { get; set; }

    /**
     * Date the subscription becomes effective.\n
     * @return subscriptionStartDate
     */
    public Date subscriptionStartDate { get; set; }

    /**
     * Returns `true` if the request was processed successfully.\n
     * @return success
     */
    public Boolean success { get; set; }

    /**
     * Date the subscription term ends. If the subscription is evergreen, this is null or is the cancellation date (if one has been set).\n
     * @return termEndDate
     */
    public Date termEndDate { get; set; }

    /**
     * Date the subscription term begins. If this is a renewal subscription, this date is different from the subscription start date.\n
     * @return termStartDate
     */
    public Date termStartDate { get; set; }

    /**
     * Possible values are: `TERMED`, `EVERGREEN`.\n
     * @return termType
     */
    public String termType { get; set; }

    /**
     * Total contracted value of the subscription.\n
     * @return totalContractedValue
     */
    public String totalContractedValue { get; set; }

    // MBEN custom fields
    public String DetteVisibleHermes { get; set; }
    public Double Tech_DetteFraisGestion { get; set; }
    public Double Tech_DetteNonEchue { get; set; }
    public Date Tech_DetteTargetDate { get; set; }
    public String Tech_AvecRembouesement { get; set; }
    public Date DateTarifFacture { get; set; }
    public Double TarifFacture { get; set; }
    public String IdContratPrecedent { get; set; }
    public String Numerocarteparrain { get; set; }
    public Date Datedernierrejet { get; set; }
    public String CodePromo { get; set; }
    public String MethodePaiement { get; set; }
    public String Source { get; set; }
    public String TypeContrat { get; set; }
    public String CodeFinContrat { get; set; }
    public String ModeLivraison { get; set; }
    public String LegacyExternalID { get; set; }
    public String PayeurCRMID { get; set; }
    public String CodeOffreCo { get; set; }
    public String Agent { get; set; }
    public String Lieu { get; set; }
    public Date DateDebutContratReel { get; set; }
    public Date DateFinContrat { get; set; }
    public String CancelCaseID { get; set; }
    public String CodeOffrePrincipale { get; set; }
    public String Marche { get; set; }
    

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
        'DetteVisibleHermes__c' => 'DetteVisibleHermes',
        'Tech_DetteFraisGestion__c' => 'Tech_DetteFraisGestion',
        'Tech_DetteNonEchue__c' => 'Tech_DetteNonEchue',
        'Tech_DetteTargetDate__c' => 'Tech_DetteTargetDate',
        'Tech_AvecRembouesement__c' => 'Tech_AvecRembouesement',
        'DateTarifFacture__c' => 'DateTarifFacture',
        'TarifFacture__c' => 'TarifFacture',
        'IdContratPrecedent__c' => 'IdContratPrecedent',
        'Numerocarteparrain__c' => 'Numerocarteparrain',
        'Datedernierrejet__c' => 'Datedernierrejet',
        'CodePromo__c' => 'CodePromo',
        'MethodePaiement__c' => 'MethodePaiement',
        'Source__c' => 'Source',
        'TypeContrat__c' => 'TypeContrat',
        'CodeFinContrat__c' => 'CodeFinContrat',
        'ModeLivraison__c' => 'ModeLivraison',
        'LegacyExternalID__c' => 'LegacyExternalID',
        'PayeurCRMID__c' => 'PayeurCRMID',
        'CodeOffreCo__c' => 'CodeOffreCo',
        'Agent__c' => 'Agent',
        'Lieu__c' => 'Lieu',
        'DateDebutContratReel__c' => 'DateDebutContratReel',
        'DateFinContrat__c' => 'DateFinContrat',
        'CancelCaseID__c' => 'CancelCaseID',
        'CodeOffrePrincipale__c' => 'CodeOffrePrincipale',
        'Marche__c' => 'Marche'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public zc_GETSubscriptionTypeWithSuccess() {
        ratePlans = new List<zc_GETSubscriptionRatePlanType>{new zc_GETSubscriptionRatePlanType()};
    }

    // public static zc_GETSubscriptionTypeWithSuccess getExample() {
    //     zc_GETSubscriptionTypeWithSuccess geTSubscriptionTypeWithSuccess = new zc_GETSubscriptionTypeWithSuccess();
    //     geTSubscriptionTypeWithSuccess.cpqBundleJsonIdQT = 'aeiou';
    //     geTSubscriptionTypeWithSuccess.opportunityCloseDateQT = Date.newInstance(2000, 1, 23);
    //     geTSubscriptionTypeWithSuccess.opportunityNameQT = 'aeiou';
    //     geTSubscriptionTypeWithSuccess.quoteBusinessTypeQT = 'aeiou';
    //     geTSubscriptionTypeWithSuccess.quoteNumberQT = 'aeiou';
    //     geTSubscriptionTypeWithSuccess.quoteTypeQT = 'aeiou';
    //     geTSubscriptionTypeWithSuccess.integrationIdNS = 'aeiou';
    //     geTSubscriptionTypeWithSuccess.integrationStatusNS = 'aeiou';
    //     geTSubscriptionTypeWithSuccess.projectNS = 'aeiou';
    //     geTSubscriptionTypeWithSuccess.salesOrderNS = 'aeiou';
    //     geTSubscriptionTypeWithSuccess.syncDateNS = 'aeiou';
    //     geTSubscriptionTypeWithSuccess.accountId = 'aeiou';
    //     geTSubscriptionTypeWithSuccess.accountName = 'aeiou';
    //     geTSubscriptionTypeWithSuccess.accountNumber = 'aeiou';
    //     geTSubscriptionTypeWithSuccess.autoRenew = true;
    //     geTSubscriptionTypeWithSuccess.contractEffectiveDate = Date.newInstance(2000, 1, 23);
    //     geTSubscriptionTypeWithSuccess.contractedMrr = 'aeiou';
    //     geTSubscriptionTypeWithSuccess.currentTerm = 123456789L;
    //     geTSubscriptionTypeWithSuccess.currentTermPeriodType = 'aeiou';
    //     geTSubscriptionTypeWithSuccess.customerAcceptanceDate = Date.newInstance(2000, 1, 23);
    //     geTSubscriptionTypeWithSuccess.id = 'aeiou';
    //     geTSubscriptionTypeWithSuccess.initialTerm = 123456789L;
    //     geTSubscriptionTypeWithSuccess.initialTermPeriodType = 'aeiou';
    //     geTSubscriptionTypeWithSuccess.invoiceOwnerAccountId = 'aeiou';
    //     geTSubscriptionTypeWithSuccess.invoiceOwnerAccountName = 'aeiou';
    //     geTSubscriptionTypeWithSuccess.invoiceOwnerAccountNumber = 'aeiou';
    //     geTSubscriptionTypeWithSuccess.invoiceSeparately = 'aeiou';
    //     geTSubscriptionTypeWithSuccess.notes = 'aeiou';
    //     geTSubscriptionTypeWithSuccess.orderNumber = 'aeiou';
    //     geTSubscriptionTypeWithSuccess.ratePlans = new List<zc_GETSubscriptionRatePlanType>{zc_GETSubscriptionRatePlanType.getExample()};
    //     geTSubscriptionTypeWithSuccess.renewalSetting = 'aeiou';
    //     geTSubscriptionTypeWithSuccess.renewalTerm = 123456789L;
    //     geTSubscriptionTypeWithSuccess.renewalTermPeriodType = 'aeiou';
    //     geTSubscriptionTypeWithSuccess.serviceActivationDate = Date.newInstance(2000, 1, 23);
    //     geTSubscriptionTypeWithSuccess.status = 'aeiou';
    //     geTSubscriptionTypeWithSuccess.subscriptionNumber = 'aeiou';
    //     geTSubscriptionTypeWithSuccess.subscriptionStartDate = Date.newInstance(2000, 1, 23);
    //     geTSubscriptionTypeWithSuccess.success = true;
    //     geTSubscriptionTypeWithSuccess.termEndDate = Date.newInstance(2000, 1, 23);
    //     geTSubscriptionTypeWithSuccess.termStartDate = Date.newInstance(2000, 1, 23);
    //     geTSubscriptionTypeWithSuccess.termType = 'aeiou';
    //     geTSubscriptionTypeWithSuccess.totalContractedValue = 'aeiou';
    //     return geTSubscriptionTypeWithSuccess;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_GETSubscriptionTypeWithSuccess) {
            zc_GETSubscriptionTypeWithSuccess geTSubscriptionTypeWithSuccess = (zc_GETSubscriptionTypeWithSuccess) obj;
            return this.cpqBundleJsonIdQT == geTSubscriptionTypeWithSuccess.cpqBundleJsonIdQT
                && this.opportunityCloseDateQT == geTSubscriptionTypeWithSuccess.opportunityCloseDateQT
                && this.opportunityNameQT == geTSubscriptionTypeWithSuccess.opportunityNameQT
                && this.quoteBusinessTypeQT == geTSubscriptionTypeWithSuccess.quoteBusinessTypeQT
                && this.quoteNumberQT == geTSubscriptionTypeWithSuccess.quoteNumberQT
                && this.quoteTypeQT == geTSubscriptionTypeWithSuccess.quoteTypeQT
                && this.integrationIdNS == geTSubscriptionTypeWithSuccess.integrationIdNS
                && this.integrationStatusNS == geTSubscriptionTypeWithSuccess.integrationStatusNS
                && this.projectNS == geTSubscriptionTypeWithSuccess.projectNS
                && this.salesOrderNS == geTSubscriptionTypeWithSuccess.salesOrderNS
                && this.syncDateNS == geTSubscriptionTypeWithSuccess.syncDateNS
                && this.accountId == geTSubscriptionTypeWithSuccess.accountId
                && this.accountName == geTSubscriptionTypeWithSuccess.accountName
                && this.accountNumber == geTSubscriptionTypeWithSuccess.accountNumber
                && this.autoRenew == geTSubscriptionTypeWithSuccess.autoRenew
                && this.contractEffectiveDate == geTSubscriptionTypeWithSuccess.contractEffectiveDate
                && this.contractedMrr == geTSubscriptionTypeWithSuccess.contractedMrr
                && this.currentTerm == geTSubscriptionTypeWithSuccess.currentTerm
                && this.currentTermPeriodType == geTSubscriptionTypeWithSuccess.currentTermPeriodType
                && this.customerAcceptanceDate == geTSubscriptionTypeWithSuccess.customerAcceptanceDate
                && this.id == geTSubscriptionTypeWithSuccess.id
                && this.initialTerm == geTSubscriptionTypeWithSuccess.initialTerm
                && this.initialTermPeriodType == geTSubscriptionTypeWithSuccess.initialTermPeriodType
                && this.invoiceOwnerAccountId == geTSubscriptionTypeWithSuccess.invoiceOwnerAccountId
                && this.invoiceOwnerAccountName == geTSubscriptionTypeWithSuccess.invoiceOwnerAccountName
                && this.invoiceOwnerAccountNumber == geTSubscriptionTypeWithSuccess.invoiceOwnerAccountNumber
                && this.invoiceSeparately == geTSubscriptionTypeWithSuccess.invoiceSeparately
                && this.notes == geTSubscriptionTypeWithSuccess.notes
                && this.orderNumber == geTSubscriptionTypeWithSuccess.orderNumber
                && this.ratePlans == geTSubscriptionTypeWithSuccess.ratePlans
                && this.renewalSetting == geTSubscriptionTypeWithSuccess.renewalSetting
                && this.renewalTerm == geTSubscriptionTypeWithSuccess.renewalTerm
                && this.renewalTermPeriodType == geTSubscriptionTypeWithSuccess.renewalTermPeriodType
                && this.serviceActivationDate == geTSubscriptionTypeWithSuccess.serviceActivationDate
                && this.status == geTSubscriptionTypeWithSuccess.status
                && this.subscriptionNumber == geTSubscriptionTypeWithSuccess.subscriptionNumber
                && this.subscriptionStartDate == geTSubscriptionTypeWithSuccess.subscriptionStartDate
                && this.success == geTSubscriptionTypeWithSuccess.success
                && this.termEndDate == geTSubscriptionTypeWithSuccess.termEndDate
                && this.termStartDate == geTSubscriptionTypeWithSuccess.termStartDate
                && this.termType == geTSubscriptionTypeWithSuccess.termType
                && this.totalContractedValue == geTSubscriptionTypeWithSuccess.totalContractedValue;
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
        hashCode = (17 * hashCode) + (accountName == null ? 0 : System.hashCode(accountName));
        hashCode = (17 * hashCode) + (accountNumber == null ? 0 : System.hashCode(accountNumber));
        hashCode = (17 * hashCode) + (autoRenew == null ? 0 : System.hashCode(autoRenew));
        hashCode = (17 * hashCode) + (contractEffectiveDate == null ? 0 : System.hashCode(contractEffectiveDate));
        hashCode = (17 * hashCode) + (contractedMrr == null ? 0 : System.hashCode(contractedMrr));
        hashCode = (17 * hashCode) + (currentTerm == null ? 0 : System.hashCode(currentTerm));
        hashCode = (17 * hashCode) + (currentTermPeriodType == null ? 0 : System.hashCode(currentTermPeriodType));
        hashCode = (17 * hashCode) + (customerAcceptanceDate == null ? 0 : System.hashCode(customerAcceptanceDate));
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
        hashCode = (17 * hashCode) + (initialTerm == null ? 0 : System.hashCode(initialTerm));
        hashCode = (17 * hashCode) + (initialTermPeriodType == null ? 0 : System.hashCode(initialTermPeriodType));
        hashCode = (17 * hashCode) + (invoiceOwnerAccountId == null ? 0 : System.hashCode(invoiceOwnerAccountId));
        hashCode = (17 * hashCode) + (invoiceOwnerAccountName == null ? 0 : System.hashCode(invoiceOwnerAccountName));
        hashCode = (17 * hashCode) + (invoiceOwnerAccountNumber == null ? 0 : System.hashCode(invoiceOwnerAccountNumber));
        hashCode = (17 * hashCode) + (invoiceSeparately == null ? 0 : System.hashCode(invoiceSeparately));
        hashCode = (17 * hashCode) + (notes == null ? 0 : System.hashCode(notes));
        hashCode = (17 * hashCode) + (orderNumber == null ? 0 : System.hashCode(orderNumber));
        hashCode = (17 * hashCode) + (ratePlans == null ? 0 : System.hashCode(ratePlans));
        hashCode = (17 * hashCode) + (renewalSetting == null ? 0 : System.hashCode(renewalSetting));
        hashCode = (17 * hashCode) + (renewalTerm == null ? 0 : System.hashCode(renewalTerm));
        hashCode = (17 * hashCode) + (renewalTermPeriodType == null ? 0 : System.hashCode(renewalTermPeriodType));
        hashCode = (17 * hashCode) + (serviceActivationDate == null ? 0 : System.hashCode(serviceActivationDate));
        hashCode = (17 * hashCode) + (status == null ? 0 : System.hashCode(status));
        hashCode = (17 * hashCode) + (subscriptionNumber == null ? 0 : System.hashCode(subscriptionNumber));
        hashCode = (17 * hashCode) + (subscriptionStartDate == null ? 0 : System.hashCode(subscriptionStartDate));
        hashCode = (17 * hashCode) + (success == null ? 0 : System.hashCode(success));
        hashCode = (17 * hashCode) + (termEndDate == null ? 0 : System.hashCode(termEndDate));
        hashCode = (17 * hashCode) + (termStartDate == null ? 0 : System.hashCode(termStartDate));
        hashCode = (17 * hashCode) + (termType == null ? 0 : System.hashCode(termType));
        hashCode = (17 * hashCode) + (totalContractedValue == null ? 0 : System.hashCode(totalContractedValue));
        return hashCode;
    }
}