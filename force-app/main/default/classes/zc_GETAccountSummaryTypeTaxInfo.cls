/**
 * Container for tax exempt information, used to establish the tax exempt status of a customer account.\n
 */
public class zc_GETAccountSummaryTypeTaxInfo {
    /**
     * EU Value Added Tax ID.\n
     * @return vaTId
     */
    public String vaTId { get; set; }

    /**
     * Unique code that identifies a company account in Avalara.\n
     * @return companyCode
     */
    public String companyCode { get; set; }

    /**
     * ID of the customer tax exemption certificate.\n
     * @return exemptCertificateId
     */
    public String exemptCertificateId { get; set; }

    /**
     * Type of tax exemption certificate that the customer holds.\n
     * @return exemptCertificateType
     */
    public String exemptCertificateType { get; set; }

    /**
     * Description of the tax exemption certificate that the customer holds.\n
     * @return exemptDescription
     */
    public String exemptDescription { get; set; }

    /**
     * Date when the customer tax exemption starts.\n
     * @return exemptEffectiveDate
     */
    public Date exemptEffectiveDate { get; set; }

    /**
     * A unique entity use code to apply exemptions in Avalara AvaTax.\n\nThis account-level field is required only when you choose Avalara as your tax engine. See [Exempt Transactions](https://developer.avalara.com/avatax/handling-tax-exempt-customers/)for more details.\n
     * @return exemptEntityUseCode
     */
    public String exemptEntityUseCode { get; set; }

    /**
     * Date when the customer tax exemption expires.\n
     * @return exemptExpirationDate
     */
    public Date exemptExpirationDate { get; set; }

    /**
     * Jurisdiction in which the customer tax exemption certificate was issued.\n
     * @return exemptIssuingJurisdiction
     */
    public String exemptIssuingJurisdiction { get; set; }

    /**
     * Status of the account tax exemption.\n
     * @return exemptStatus
     */
    public String exemptStatus { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'VATId' => 'vaTId'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    // public static zc_GETAccountSummaryTypeTaxInfo getExample() {
    //     zc_GETAccountSummaryTypeTaxInfo geTAccountSummaryTypeTaxInfo = new zc_GETAccountSummaryTypeTaxInfo();
    //     geTAccountSummaryTypeTaxInfo.vaTId = 'aeiou';
    //     geTAccountSummaryTypeTaxInfo.companyCode = 'aeiou';
    //     geTAccountSummaryTypeTaxInfo.exemptCertificateId = 'aeiou';
    //     geTAccountSummaryTypeTaxInfo.exemptCertificateType = 'aeiou';
    //     geTAccountSummaryTypeTaxInfo.exemptDescription = 'aeiou';
    //     geTAccountSummaryTypeTaxInfo.exemptEffectiveDate = Date.newInstance(2000, 1, 23);
    //     geTAccountSummaryTypeTaxInfo.exemptEntityUseCode = 'aeiou';
    //     geTAccountSummaryTypeTaxInfo.exemptExpirationDate = Date.newInstance(2000, 1, 23);
    //     geTAccountSummaryTypeTaxInfo.exemptIssuingJurisdiction = 'aeiou';
    //     geTAccountSummaryTypeTaxInfo.exemptStatus = 'aeiou';
    //     return geTAccountSummaryTypeTaxInfo;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_GETAccountSummaryTypeTaxInfo) {
            zc_GETAccountSummaryTypeTaxInfo geTAccountSummaryTypeTaxInfo = (zc_GETAccountSummaryTypeTaxInfo) obj;
            return this.vaTId == geTAccountSummaryTypeTaxInfo.vaTId
                && this.companyCode == geTAccountSummaryTypeTaxInfo.companyCode
                && this.exemptCertificateId == geTAccountSummaryTypeTaxInfo.exemptCertificateId
                && this.exemptCertificateType == geTAccountSummaryTypeTaxInfo.exemptCertificateType
                && this.exemptDescription == geTAccountSummaryTypeTaxInfo.exemptDescription
                && this.exemptEffectiveDate == geTAccountSummaryTypeTaxInfo.exemptEffectiveDate
                && this.exemptEntityUseCode == geTAccountSummaryTypeTaxInfo.exemptEntityUseCode
                && this.exemptExpirationDate == geTAccountSummaryTypeTaxInfo.exemptExpirationDate
                && this.exemptIssuingJurisdiction == geTAccountSummaryTypeTaxInfo.exemptIssuingJurisdiction
                && this.exemptStatus == geTAccountSummaryTypeTaxInfo.exemptStatus;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (vaTId == null ? 0 : System.hashCode(vaTId));
        hashCode = (17 * hashCode) + (companyCode == null ? 0 : System.hashCode(companyCode));
        hashCode = (17 * hashCode) + (exemptCertificateId == null ? 0 : System.hashCode(exemptCertificateId));
        hashCode = (17 * hashCode) + (exemptCertificateType == null ? 0 : System.hashCode(exemptCertificateType));
        hashCode = (17 * hashCode) + (exemptDescription == null ? 0 : System.hashCode(exemptDescription));
        hashCode = (17 * hashCode) + (exemptEffectiveDate == null ? 0 : System.hashCode(exemptEffectiveDate));
        hashCode = (17 * hashCode) + (exemptEntityUseCode == null ? 0 : System.hashCode(exemptEntityUseCode));
        hashCode = (17 * hashCode) + (exemptExpirationDate == null ? 0 : System.hashCode(exemptExpirationDate));
        hashCode = (17 * hashCode) + (exemptIssuingJurisdiction == null ? 0 : System.hashCode(exemptIssuingJurisdiction));
        hashCode = (17 * hashCode) + (exemptStatus == null ? 0 : System.hashCode(exemptStatus));
        return hashCode;
    }
}