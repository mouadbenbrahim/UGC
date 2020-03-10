/**
 * zc_CreditMemoItemFromWriteOffInvoic
 */
public class zc_CreditMemoItemFromWriteOffInvoic {
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
     * The ID of the invoice item.\n
     * @return invoiceItemId
     */
    public String invoiceItemId { get; set; }

    /**
     * The service end date of the credit memo item. \n
     * @return serviceEndDate
     */
    public Date serviceEndDate { get; set; }

    /**
     * The service start date of the credit memo item. \n
     * @return serviceStartDate
     */
    public Date serviceStartDate { get; set; }

    /**
     * The name of the SKU.\n
     * @return skuName
     */
    public String skuName { get; set; }

    /**
     * The definable unit that you measure when determining charges.\n
     * @return unitOfMeasure
     */
    public String unitOfMeasure { get; set; }


    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Aaaa' => 'aaaa',
        'Bbbb' => 'bbbb'

    };
    
    // public static zc_CreditMemoItemFromWriteOffInvoic getExample() {
    //     zc_CreditMemoItemFromWriteOffInvoic creditMemoItemFromWriteOffInvoice = new zc_CreditMemoItemFromWriteOffInvoic();
    //     creditMemoItemFromWriteOffInvoice.comment = 'aeiou';
    //     creditMemoItemFromWriteOffInvoice.financeInformation = zc_CreditMemoItemFromWriteOffInvoic.getExample();
    //     creditMemoItemFromWriteOffInvoice.invoiceItemId = 'aeiou';
    //     creditMemoItemFromWriteOffInvoice.serviceEndDate = Date.newInstance(2000, 1, 23);
    //     creditMemoItemFromWriteOffInvoice.serviceStartDate = Date.newInstance(2000, 1, 23);
    //     creditMemoItemFromWriteOffInvoice.skuName = 'aeiou';
    //     creditMemoItemFromWriteOffInvoice.unitOfMeasure = 'aeiou';
    //     return creditMemoItemFromWriteOffInvoice;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_CreditMemoItemFromWriteOffInvoic) {
            zc_CreditMemoItemFromWriteOffInvoic creditMemoItemFromWriteOffInvoice = (zc_CreditMemoItemFromWriteOffInvoic) obj;
            return this.comment == creditMemoItemFromWriteOffInvoice.comment
                && this.financeInformation == creditMemoItemFromWriteOffInvoice.financeInformation
                && this.invoiceItemId == creditMemoItemFromWriteOffInvoice.invoiceItemId
                && this.serviceEndDate == creditMemoItemFromWriteOffInvoice.serviceEndDate
                && this.serviceStartDate == creditMemoItemFromWriteOffInvoice.serviceStartDate
                && this.skuName == creditMemoItemFromWriteOffInvoice.skuName
                && this.unitOfMeasure == creditMemoItemFromWriteOffInvoice.unitOfMeasure;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (comment == null ? 0 : System.hashCode(comment));
        hashCode = (17 * hashCode) + (financeInformation == null ? 0 : System.hashCode(financeInformation));
        hashCode = (17 * hashCode) + (invoiceItemId == null ? 0 : System.hashCode(invoiceItemId));
        hashCode = (17 * hashCode) + (serviceEndDate == null ? 0 : System.hashCode(serviceEndDate));
        hashCode = (17 * hashCode) + (serviceStartDate == null ? 0 : System.hashCode(serviceStartDate));
        hashCode = (17 * hashCode) + (skuName == null ? 0 : System.hashCode(skuName));
        hashCode = (17 * hashCode) + (unitOfMeasure == null ? 0 : System.hashCode(unitOfMeasure));
        return hashCode;
    }
}