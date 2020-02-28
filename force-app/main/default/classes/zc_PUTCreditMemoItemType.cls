/**
 * zc_PUTCreditMemoItemType
 */
public class zc_PUTCreditMemoItemType {
    /**
     * The amount of the credit memo item. For tax-inclusive credit memo items, the amount indicates the credit memo item amount including tax. For tax-exclusive credit memo items, the amount indicates the credit memo item amount excluding tax\n
     * @return amount
     */
    public Double amount { get; set; }

    /**
     * Comments about the credit memo item.\n
     * @return comment
     */
    public String comment { get; set; }

    /**
     * Get financeInformation
     * @return financeInformation
     */
    public zc_CreditMemoItemFromWriteOffInvoic financeInformation { get; set; }

    /**
     * The ID of the credit memo item.\n
     * @return id
     */
    public String id { get; set; }

    /**
     * The service end date of the credit memo item.\n
     * @return serviceEndDate
     */
    public Date serviceEndDate { get; set; }

    /**
     * The service start date of the credit memo item.\n
     * @return serviceStartDate
     */
    public Date serviceStartDate { get; set; }

    /**
     * The name of the SKU.\n
     * @return skuName
     */
    public String skuName { get; set; }

    /**
     * Container for credit memo taxation items.\n
     * @return taxItems
     */
    public List<zc_PutCreditMemoTaxItemType> taxItems { get; set; }

    /**
     * The definable unit that you measure when determining charges.\n
     * @return unitOfMeasure
     */
    public String unitOfMeasure { get; set; }

    public zc_PUTCreditMemoItemType() {
        taxItems = new List<zc_PutCreditMemoTaxItemType>();
    }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Aaaa' => 'aaaa',
        'Bbbb' => 'bbbb'

    };

    // public static zc_PUTCreditMemoItemType getExample() {
    //     zc_PUTCreditMemoItemType puTCreditMemoItemType = new zc_PUTCreditMemoItemType();
    //     puTCreditMemoItemType.amount = 1.3579;
    //     puTCreditMemoItemType.comment = 'aeiou';
    //     puTCreditMemoItemType.financeInformation = zc_CreditMemoItemFromWriteOffInvoic.getExample();
    //     puTCreditMemoItemType.id = 'aeiou';
    //     puTCreditMemoItemType.serviceEndDate = Date.newInstance(2000, 1, 23);
    //     puTCreditMemoItemType.serviceStartDate = Date.newInstance(2000, 1, 23);
    //     puTCreditMemoItemType.skuName = 'aeiou';
    //     puTCreditMemoItemType.taxItems = new List<zc_PutCreditMemoTaxItemType>{zc_PutCreditMemoTaxItemType.getExample()};
    //     puTCreditMemoItemType.unitOfMeasure = 'aeiou';
    //     return puTCreditMemoItemType;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_PUTCreditMemoItemType) {
            zc_PUTCreditMemoItemType puTCreditMemoItemType = (zc_PUTCreditMemoItemType) obj;
            return this.amount == puTCreditMemoItemType.amount
                && this.comment == puTCreditMemoItemType.comment
                && this.financeInformation == puTCreditMemoItemType.financeInformation
                && this.id == puTCreditMemoItemType.id
                && this.serviceEndDate == puTCreditMemoItemType.serviceEndDate
                && this.serviceStartDate == puTCreditMemoItemType.serviceStartDate
                && this.skuName == puTCreditMemoItemType.skuName
                && this.taxItems == puTCreditMemoItemType.taxItems
                && this.unitOfMeasure == puTCreditMemoItemType.unitOfMeasure;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (amount == null ? 0 : System.hashCode(amount));
        hashCode = (17 * hashCode) + (comment == null ? 0 : System.hashCode(comment));
        hashCode = (17 * hashCode) + (financeInformation == null ? 0 : System.hashCode(financeInformation));
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
        hashCode = (17 * hashCode) + (serviceEndDate == null ? 0 : System.hashCode(serviceEndDate));
        hashCode = (17 * hashCode) + (serviceStartDate == null ? 0 : System.hashCode(serviceStartDate));
        hashCode = (17 * hashCode) + (skuName == null ? 0 : System.hashCode(skuName));
        hashCode = (17 * hashCode) + (taxItems == null ? 0 : System.hashCode(taxItems));
        hashCode = (17 * hashCode) + (unitOfMeasure == null ? 0 : System.hashCode(unitOfMeasure));
        return hashCode;
    }
}