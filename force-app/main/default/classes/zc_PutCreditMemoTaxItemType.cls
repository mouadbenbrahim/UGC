/**
 * zc_PutCreditMemoTaxItemType
 */
public class zc_PutCreditMemoTaxItemType {
    /**
     * The amount of the taxation item in the credit memo item.\n
     * @return amount
     */
    public Double amount { get; set; }

    /**
     * Get financeInformation
     * @return financeInformation
     */
    public zc_PutCreditMemoTaxItemTypeFinanceI financeInformation { get; set; }

    /**
     * The ID of the taxation item in the credit memo item.\n
     * @return id
     */
    public String id { get; set; }

    /**
     * The jurisdiction that applies the tax or VAT. This value is typically a state, province, county, or city.\n
     * @return jurisdiction
     */
    public String jurisdiction { get; set; }

    /**
     * The identifier for the location based on the value of the `taxCode` field.\n
     * @return locationCode
     */
    public String locationCode { get; set; }

    /**
     * The tax code identifies which tax rules and tax rates to apply to a specific credit memo.\n
     * @return taxCode
     */
    public String taxCode { get; set; }

    /**
     * The description of the tax code.\n
     * @return taxCodeDescription
     */
    public String taxCodeDescription { get; set; }

    /**
     * The date that the tax is applied to the credit memo, in `yyyy-mm-dd` format.\n
     * @return taxDate
     */
    public Date taxDate { get; set; }

    /**
     * The amount of taxes or VAT for which the customer has an exemption.\n
     * @return taxExemptAmount
     */
    public Double taxExemptAmount { get; set; }

    /**
     * The name of taxation.\n
     * @return taxName
     */
    public String taxName { get; set; }

    /**
     * The tax rate applied to the credit memo.\n
     * @return taxRate
     */
    public Double taxRate { get; set; }

    /**
     * The description of the tax rate. \n
     * @return taxRateDescription
     */
    public String taxRateDescription { get; set; }

    /**
     * The type of the tax rate applied to the credit memo.\n
     */
    public enum TaxRateTypeEnum {
        PERCENTAGE,
        FLATFEE
    }

    /**
     * The type of the tax rate applied to the credit memo.\n
     * @return taxRateType
     */
    public TaxRateTypeEnum taxRateType { get; set; }


    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Aaaa' => 'aaaa',
        'Bbbb' => 'bbbb'

    };

    
    // public static zc_PutCreditMemoTaxItemType getExample() {
    //     zc_PutCreditMemoTaxItemType putCreditMemoTaxItemType = new zc_PutCreditMemoTaxItemType();
    //     putCreditMemoTaxItemType.amount = 1.3579;
    //     putCreditMemoTaxItemType.financeInformation = zc_PutCreditMemoTaxItemTypeFinanceI.getExample();
    //     putCreditMemoTaxItemType.id = 'aeiou';
    //     putCreditMemoTaxItemType.jurisdiction = 'aeiou';
    //     putCreditMemoTaxItemType.locationCode = 'aeiou';
    //     putCreditMemoTaxItemType.taxCode = 'aeiou';
    //     putCreditMemoTaxItemType.taxCodeDescription = 'aeiou';
    //     putCreditMemoTaxItemType.taxDate = Date.newInstance(2000, 1, 23);
    //     putCreditMemoTaxItemType.taxExemptAmount = 1.3579;
    //     putCreditMemoTaxItemType.taxName = 'aeiou';
    //     putCreditMemoTaxItemType.taxRate = 1.3579;
    //     putCreditMemoTaxItemType.taxRateDescription = 'aeiou';
    //     putCreditMemoTaxItemType.taxRateType = TaxRateTypeEnum.PERCENTAGE;
    //     return putCreditMemoTaxItemType;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_PutCreditMemoTaxItemType) {
            zc_PutCreditMemoTaxItemType putCreditMemoTaxItemType = (zc_PutCreditMemoTaxItemType) obj;
            return this.amount == putCreditMemoTaxItemType.amount
                && this.financeInformation == putCreditMemoTaxItemType.financeInformation
                && this.id == putCreditMemoTaxItemType.id
                && this.jurisdiction == putCreditMemoTaxItemType.jurisdiction
                && this.locationCode == putCreditMemoTaxItemType.locationCode
                && this.taxCode == putCreditMemoTaxItemType.taxCode
                && this.taxCodeDescription == putCreditMemoTaxItemType.taxCodeDescription
                && this.taxDate == putCreditMemoTaxItemType.taxDate
                && this.taxExemptAmount == putCreditMemoTaxItemType.taxExemptAmount
                && this.taxName == putCreditMemoTaxItemType.taxName
                && this.taxRate == putCreditMemoTaxItemType.taxRate
                && this.taxRateDescription == putCreditMemoTaxItemType.taxRateDescription
                && this.taxRateType == putCreditMemoTaxItemType.taxRateType;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (amount == null ? 0 : System.hashCode(amount));
        hashCode = (17 * hashCode) + (financeInformation == null ? 0 : System.hashCode(financeInformation));
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
        hashCode = (17 * hashCode) + (jurisdiction == null ? 0 : System.hashCode(jurisdiction));
        hashCode = (17 * hashCode) + (locationCode == null ? 0 : System.hashCode(locationCode));
        hashCode = (17 * hashCode) + (taxCode == null ? 0 : System.hashCode(taxCode));
        hashCode = (17 * hashCode) + (taxCodeDescription == null ? 0 : System.hashCode(taxCodeDescription));
        hashCode = (17 * hashCode) + (taxDate == null ? 0 : System.hashCode(taxDate));
        hashCode = (17 * hashCode) + (taxExemptAmount == null ? 0 : System.hashCode(taxExemptAmount));
        hashCode = (17 * hashCode) + (taxName == null ? 0 : System.hashCode(taxName));
        hashCode = (17 * hashCode) + (taxRate == null ? 0 : System.hashCode(taxRate));
        hashCode = (17 * hashCode) + (taxRateDescription == null ? 0 : System.hashCode(taxRateDescription));
        hashCode = (17 * hashCode) + (taxRateType == null ? 0 : System.hashCode(taxRateType));
        return hashCode;
    }
}