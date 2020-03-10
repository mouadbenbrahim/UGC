public class zc_GETInvoiceTaxItemType {
    /**
     * The amount of the invoice taxation item that is available to credit.\n
     * @return availableToCreditAmount
     */
    public Double availableToCreditAmount { get; set; }

    /**
     * The balance of the taxation item.\n
     * @return balance
     */
    public Double balance { get; set; }

    /**
     * The amount of credit memos applied to the taxation item. \n
     * @return creditAmount
     */
    public Double creditAmount { get; set; }

    /**
     * The amount of taxes or VAT for which the customer has an exemption.\n
     * @return exemptAmount
     */
    public Double exemptAmount { get; set; }

    /**
     * The ID of the taxation item.\n
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
     * The name of the taxation item.\n
     * @return name
     */
    public String name { get; set; }

    /**
     * The amount of payments applied to the taxation item. \n
     * @return paymentAmount
     */
    public Double paymentAmount { get; set; }

    /**
     * The amount of taxation.\n
     * @return taxAmount
     */
    public Double taxAmount { get; set; }

    /**
     * The tax code identifies which tax rules and tax rates to apply to a specific invoice.\n
     * @return taxCode
     */
    public String taxCode { get; set; }

    /**
     * The description of the tax code.\n
     * @return taxCodeDescription
     */
    public String taxCodeDescription { get; set; }

    /**
     * The date that the tax is applied to the invoice, in `yyyy-mm-dd` format.\n
     * @return taxDate
     */
    public Date taxDate { get; set; }

    /**
     * The tax rate applied to the invoice.\n
     * @return taxRate
     */
    public Double taxRate { get; set; }

    /**
     * The description of the tax rate.\n
     * @return taxRateDescription
     */
    public String taxRateDescription { get; set; }

    /**
     * The type of the tax rate.\n
     */
    public enum TaxRateTypeEnum {
        PERCENTAGE,
        FLATFEE
    }

    /**
     * The type of the tax rate.\n
     * @return taxRateType
     */
    public TaxRateTypeEnum taxRateType { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Aaa' => 'aaa',
        'Bbb' => 'bbb'
    };    

    public static zc_GETInvoiceTaxItemType getExample() {
        zc_GETInvoiceTaxItemType geTInvoiceTaxItemType = new zc_GETInvoiceTaxItemType();
        geTInvoiceTaxItemType.availableToCreditAmount = 1.3579;
        geTInvoiceTaxItemType.balance = 1.3579;
        geTInvoiceTaxItemType.creditAmount = 1.3579;
        geTInvoiceTaxItemType.exemptAmount = 1.3579;
        geTInvoiceTaxItemType.id = 'aeiou';
        geTInvoiceTaxItemType.jurisdiction = 'aeiou';
        geTInvoiceTaxItemType.locationCode = 'aeiou';
        geTInvoiceTaxItemType.name = 'aeiou';
        geTInvoiceTaxItemType.paymentAmount = 1.3579;
        geTInvoiceTaxItemType.taxAmount = 1.3579;
        geTInvoiceTaxItemType.taxCode = 'aeiou';
        geTInvoiceTaxItemType.taxCodeDescription = 'aeiou';
        geTInvoiceTaxItemType.taxDate = Date.newInstance(2000, 1, 23);
        geTInvoiceTaxItemType.taxRate = 1.3579;
        geTInvoiceTaxItemType.taxRateDescription = 'aeiou';
        geTInvoiceTaxItemType.taxRateType = TaxRateTypeEnum.PERCENTAGE;
        return geTInvoiceTaxItemType;
    }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_GETInvoiceTaxItemType) {
            zc_GETInvoiceTaxItemType geTInvoiceTaxItemType = (zc_GETInvoiceTaxItemType) obj;
            return this.availableToCreditAmount == geTInvoiceTaxItemType.availableToCreditAmount
                && this.balance == geTInvoiceTaxItemType.balance
                && this.creditAmount == geTInvoiceTaxItemType.creditAmount
                && this.exemptAmount == geTInvoiceTaxItemType.exemptAmount
                && this.id == geTInvoiceTaxItemType.id
                && this.jurisdiction == geTInvoiceTaxItemType.jurisdiction
                && this.locationCode == geTInvoiceTaxItemType.locationCode
                && this.name == geTInvoiceTaxItemType.name
                && this.paymentAmount == geTInvoiceTaxItemType.paymentAmount
                && this.taxAmount == geTInvoiceTaxItemType.taxAmount
                && this.taxCode == geTInvoiceTaxItemType.taxCode
                && this.taxCodeDescription == geTInvoiceTaxItemType.taxCodeDescription
                && this.taxDate == geTInvoiceTaxItemType.taxDate
                && this.taxRate == geTInvoiceTaxItemType.taxRate
                && this.taxRateDescription == geTInvoiceTaxItemType.taxRateDescription
                && this.taxRateType == geTInvoiceTaxItemType.taxRateType;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (availableToCreditAmount == null ? 0 : System.hashCode(availableToCreditAmount));
        hashCode = (17 * hashCode) + (balance == null ? 0 : System.hashCode(balance));
        hashCode = (17 * hashCode) + (creditAmount == null ? 0 : System.hashCode(creditAmount));
        hashCode = (17 * hashCode) + (exemptAmount == null ? 0 : System.hashCode(exemptAmount));
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
        hashCode = (17 * hashCode) + (jurisdiction == null ? 0 : System.hashCode(jurisdiction));
        hashCode = (17 * hashCode) + (locationCode == null ? 0 : System.hashCode(locationCode));
        hashCode = (17 * hashCode) + (name == null ? 0 : System.hashCode(name));
        hashCode = (17 * hashCode) + (paymentAmount == null ? 0 : System.hashCode(paymentAmount));
        hashCode = (17 * hashCode) + (taxAmount == null ? 0 : System.hashCode(taxAmount));
        hashCode = (17 * hashCode) + (taxCode == null ? 0 : System.hashCode(taxCode));
        hashCode = (17 * hashCode) + (taxCodeDescription == null ? 0 : System.hashCode(taxCodeDescription));
        hashCode = (17 * hashCode) + (taxDate == null ? 0 : System.hashCode(taxDate));
        hashCode = (17 * hashCode) + (taxRate == null ? 0 : System.hashCode(taxRate));
        hashCode = (17 * hashCode) + (taxRateDescription == null ? 0 : System.hashCode(taxRateDescription));
        hashCode = (17 * hashCode) + (taxRateType == null ? 0 : System.hashCode(taxRateType));
        return hashCode;
    }
}