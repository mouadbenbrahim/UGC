/**
 * zc_GETAccountSummarySubscriptionTyp
 */
public class zc_GETAccountSummarySubscriptionTyp {
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
     * If `true`, auto-renew is enabled. If `false`, auto-renew is disabled.\n
     * @return autoRenew
     */
    public Boolean autoRenew { get; set; }

    /**
     * Subscription ID.\n
     * @return id
     */
    public String id { get; set; }

    /**
     * Duration of the initial subscription term in whole months. \n
     * @return initialTerm
     */
    public String initialTerm { get; set; }

    /**
     * Container for rate plans for this subscription.\n
     * @return ratePlans
     */
    public List<zc_GETAccountSummarySubscriptionRat> ratePlans { get; set; }

    /**
     * Duration of the renewal term in whole months.\n
     * @return renewalTerm
     */
    public String renewalTerm { get; set; }

    /**
     * Subscription status; possible values are: `Draft`, `PendingActivation`, `PendingAcceptance`, `Active`, `Cancelled`, `Expired`.\n
     * @return status
     */
    public String status { get; set; }

    /**
     * Subscription Number.\n
     * @return subscriptionNumber
     */
    public String subscriptionNumber { get; set; }

    /**
     * Subscription start date.\n
     * @return subscriptionStartDate
     */
    public Date subscriptionStartDate { get; set; }

    /**
     * End date of the subscription term. If the subscription is evergreen, this is either null or equal to the cancellation date, as appropriate.\n
     * @return termEndDate
     */
    public String termEndDate { get; set; }

    /**
     * Start date of the subscription term. If this is a renewal subscription, this date is different than the subscription start date.\n
     * @return termStartDate
     */
    public Date termStartDate { get; set; }

    /**
     * Possible values are: `TERMED`, `EVERGREEN`.\n
     * @return termType
     */
    public String termType { get; set; }
    
    //MNE
    public String tech_DetteNonEchue { get; set; }
	public String tech_AvecRembouesement { get; set; }
	public String tech_DetteTargetDate { get; set; }
	public String dateDernierRejet { get; set; }
	public String dateTarifFacture { get; set; }
	public String detteVisibleHermes { get; set; }
	public String cancelCaseID { get; set; }
	public String dateDebutContratReel { get; set; }
	public String agent { get; set; }
	public String dateSignatureContrat { get; set; }
	public String tech_DetteFraisGestion { get; set; }
	public String lieu { get; set; }
	public String codePromo { get; set; }
	public String source { get; set; }
	public String idContratPrecedent { get; set; }
	public String typeContrat { get; set; }
	public String codeFinContrat { get; set; }
	public String numCarteParrain { get; set; }
	public String codeOffreCo { get; set; }
	public String marche { get; set; }
	public String payeurCRMID { get; set; }
	public String tarifFacture { get; set; }
	public String codeOffrePrincipale { get; set; }
	public String legacyExternalID { get; set; }
	public String modeLivraison { get; set; }
	public String dateFinContrat { get; set; }
	public String methodePaiement { get; set; }

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
        'Tech_DetteNonEchue__c' => 'tech_DetteNonEchue',
        'Tech_AvecRembouesement__c' => 'tech_AvecRembouesement',
        'Tech_DetteTargetDate__c' => 'tech_DetteTargetDate',
        'DateDernierRejet__c' => 'dateDernierRejet',
        'DateTarifFacture__c' => 'dateTarifFacture',
        'DetteVisibleHermes__c' => 'detteVisibleHermes',
        'CancelCaseID__c' => 'cancelCaseID',
        'DateDebutContratReel__c' => 'dateDebutContratReel',
        'Agent__c' => 'agent',
        'DateSignatureContrat__c' => 'dateSignatureContrat',
        'Tech_DetteFraisGestion__c' => 'tech_DetteFraisGestion',
        'Lieu__c' => 'lieu',
        'CodePromo__c' => 'codePromo',
        'Source__c' => 'source',
        'IdContratPrecedent__c' => 'idContratPrecedent',
        'TypeContrat__c' => 'typeContrat',
        'CodeFinContrat__c' => 'codeFinContrat',
        'NumCarteParrain__c' => 'numCarteParrain',
        'CodeOffreCo__c' => 'codeOffreCo',
        'Marche__c' => 'marche',
        'PayeurCRMID__c' => 'payeurCRMID',
        'TarifFacture__c' => 'tarifFacture',
        'CodeOffrePrincipale__c' => 'codeOffrePrincipale',
        'LegacyExternalID__c' => 'legacyExternalID',
        'ModeLivraison__c' => 'modeLivraison',
        'DateFinContrat__c' => 'dateFinContrat',
        'MethodePaiement__c' => 'methodePaiement'
        
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public zc_GETAccountSummarySubscriptionTyp() {
        ratePlans = new List<zc_GETAccountSummarySubscriptionRat>{new zc_GETAccountSummarySubscriptionRat()};
    }

    // public static zc_GETAccountSummarySubscriptionTyp getExample() {
    //     zc_GETAccountSummarySubscriptionTyp geTAccountSummarySubscriptionType = new zc_GETAccountSummarySubscriptionTyp();
    //     geTAccountSummarySubscriptionType.cpqBundleJsonIdQT = 'aeiou';
    //     geTAccountSummarySubscriptionType.opportunityCloseDateQT = Date.newInstance(2000, 1, 23);
    //     geTAccountSummarySubscriptionType.opportunityNameQT = 'aeiou';
    //     geTAccountSummarySubscriptionType.quoteBusinessTypeQT = 'aeiou';
    //     geTAccountSummarySubscriptionType.quoteNumberQT = 'aeiou';
    //     geTAccountSummarySubscriptionType.quoteTypeQT = 'aeiou';
    //     geTAccountSummarySubscriptionType.integrationIdNS = 'aeiou';
    //     geTAccountSummarySubscriptionType.integrationStatusNS = 'aeiou';
    //     geTAccountSummarySubscriptionType.projectNS = 'aeiou';
    //     geTAccountSummarySubscriptionType.salesOrderNS = 'aeiou';
    //     geTAccountSummarySubscriptionType.syncDateNS = 'aeiou';
    //     geTAccountSummarySubscriptionType.autoRenew = true;
    //     geTAccountSummarySubscriptionType.id = 'aeiou';
    //     geTAccountSummarySubscriptionType.initialTerm = 'aeiou';
    //     geTAccountSummarySubscriptionType.ratePlans = new List<zc_GETAccountSummarySubscriptionRat>{zc_GETAccountSummarySubscriptionRat.getExample()};
    //     geTAccountSummarySubscriptionType.renewalTerm = 'aeiou';
    //     geTAccountSummarySubscriptionType.status = 'aeiou';
    //     geTAccountSummarySubscriptionType.subscriptionNumber = 'aeiou';
    //     geTAccountSummarySubscriptionType.subscriptionStartDate = Date.newInstance(2000, 1, 23);
    //     geTAccountSummarySubscriptionType.termEndDate = Date.newInstance(2000, 1, 23);
    //     geTAccountSummarySubscriptionType.termStartDate = Date.newInstance(2000, 1, 23);
    //     geTAccountSummarySubscriptionType.termType = 'aeiou';
    //     return geTAccountSummarySubscriptionType;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_GETAccountSummarySubscriptionTyp) {
            zc_GETAccountSummarySubscriptionTyp geTAccountSummarySubscriptionType = (zc_GETAccountSummarySubscriptionTyp) obj;
            return this.cpqBundleJsonIdQT == geTAccountSummarySubscriptionType.cpqBundleJsonIdQT
                && this.opportunityCloseDateQT == geTAccountSummarySubscriptionType.opportunityCloseDateQT
                && this.opportunityNameQT == geTAccountSummarySubscriptionType.opportunityNameQT
                && this.quoteBusinessTypeQT == geTAccountSummarySubscriptionType.quoteBusinessTypeQT
                && this.quoteNumberQT == geTAccountSummarySubscriptionType.quoteNumberQT
                && this.quoteTypeQT == geTAccountSummarySubscriptionType.quoteTypeQT
                && this.integrationIdNS == geTAccountSummarySubscriptionType.integrationIdNS
                && this.integrationStatusNS == geTAccountSummarySubscriptionType.integrationStatusNS
                && this.projectNS == geTAccountSummarySubscriptionType.projectNS
                && this.salesOrderNS == geTAccountSummarySubscriptionType.salesOrderNS
                && this.syncDateNS == geTAccountSummarySubscriptionType.syncDateNS
                && this.autoRenew == geTAccountSummarySubscriptionType.autoRenew
                && this.id == geTAccountSummarySubscriptionType.id
                && this.initialTerm == geTAccountSummarySubscriptionType.initialTerm
                && this.ratePlans == geTAccountSummarySubscriptionType.ratePlans
                && this.renewalTerm == geTAccountSummarySubscriptionType.renewalTerm
                && this.status == geTAccountSummarySubscriptionType.status
                && this.subscriptionNumber == geTAccountSummarySubscriptionType.subscriptionNumber
                && this.subscriptionStartDate == geTAccountSummarySubscriptionType.subscriptionStartDate
                && this.termEndDate == geTAccountSummarySubscriptionType.termEndDate
                && this.termStartDate == geTAccountSummarySubscriptionType.termStartDate
                && this.termType == geTAccountSummarySubscriptionType.termType;
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
        hashCode = (17 * hashCode) + (autoRenew == null ? 0 : System.hashCode(autoRenew));
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
        hashCode = (17 * hashCode) + (initialTerm == null ? 0 : System.hashCode(initialTerm));
        hashCode = (17 * hashCode) + (ratePlans == null ? 0 : System.hashCode(ratePlans));
        hashCode = (17 * hashCode) + (renewalTerm == null ? 0 : System.hashCode(renewalTerm));
        hashCode = (17 * hashCode) + (status == null ? 0 : System.hashCode(status));
        hashCode = (17 * hashCode) + (subscriptionNumber == null ? 0 : System.hashCode(subscriptionNumber));
        hashCode = (17 * hashCode) + (subscriptionStartDate == null ? 0 : System.hashCode(subscriptionStartDate));
        hashCode = (17 * hashCode) + (termEndDate == null ? 0 : System.hashCode(termEndDate));
        hashCode = (17 * hashCode) + (termStartDate == null ? 0 : System.hashCode(termStartDate));
        hashCode = (17 * hashCode) + (termType == null ? 0 : System.hashCode(termType));
        return hashCode;
    }
}