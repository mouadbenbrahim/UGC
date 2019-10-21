/**
 * zc_POSTBillingPreviewInvoiceItem
 */
public class zc_POSTBillingPreviewInvoiceItem {
    /**
     * The unique ID of the invoice item that the discount charge is applied to.\n
     * @return appliedToItemId
     */
    public String appliedToItemId { get; set; }

    /**
     * The amount of the charge. This amount doesn\'t include taxes regardless if the charge\'s tax mode is inclusive or exclusive.\n
     * @return chargeAmount
     */
    public String chargeAmount { get; set; }

    /**
     * The date when the invoice item was created.\n
     * @return chargeDate
     */
    public String chargeDate { get; set; }

    /**
     * Description of the charge.\n
     * @return chargeDescription
     */
    public String chargeDescription { get; set; }

    /**
     * Id of the charge.\n
     * @return chargeId
     */
    public String chargeId { get; set; }

    /**
     * Name of the charge.\n
     * @return chargeName
     */
    public String chargeName { get; set; }

    /**
     * Number of the charge.\n
     * @return chargeNumber
     */
    public String chargeNumber { get; set; }

    /**
     * The type of charge. \n\nPossible values are `OneTime`, `Recurring`, and `Usage`.\n
     * @return chargeType
     */
    public String chargeType { get; set; }

    /**
     * Invoice item ID.\n
     * @return id
     */
    public String id { get; set; }

    /**
     * Identifies the kind of charge. \n\nPossible values:\n* charge\n* discount\n* prepayment\n* tax
     * @return processingType
     */
    public String processingType { get; set; }

    /**
     * Name of the product associated with this item.\n
     * @return productName
     */
    public String productName { get; set; }

    /**
     * Quantity of this item, in the configured unit of measure for the charge.\n
     * @return quantity
     */
    public String quantity { get; set; }

    /**
     * End date of the service period for this item, i.e., the last day of the service period, in `yyyy-mm-dd` format.\n
     * @return serviceEndDate
     */
    public Date serviceEndDate { get; set; }

    /**
     * Start date of the service period for this item, in `yyyy-mm-dd` format. If the charge is a one-time fee, this is the date of that charge.\n
     * @return serviceStartDate
     */
    public Date serviceStartDate { get; set; }

    /**
     * ID of the subscription associated with this item.\n
     * @return subscriptionId
     */
    public String subscriptionId { get; set; }

    /**
     * Name of the subscription associated with this item.\n
     * @return subscriptionName
     */
    public String subscriptionName { get; set; }

    /**
     * Number of the subscription associated with this item.\n
     * @return subscriptionNumber
     */
    public String subscriptionNumber { get; set; }

    /**
     * Tax applied to the charge. This field returns `0` becasue the BillingPreview operation does not calculate taxes for charges in the subscription.\n
     * @return taxAmount
     */
    public String taxAmount { get; set; }

    /**
     * Unit used to measure consumption.\n
     * @return unitOfMeasure
     */
    public String unitOfMeasure { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Abb' => 'abb'
    };

    // public static zc_POSTBillingPreviewInvoiceItem getExample() {
    //     zc_POSTBillingPreviewInvoiceItem poSTBillingPreviewInvoiceItem = new zc_POSTBillingPreviewInvoiceItem();
    //     poSTBillingPreviewInvoiceItem.appliedToItemId = 'aeiou';
    //     poSTBillingPreviewInvoiceItem.chargeAmount = 'aeiou';
    //     poSTBillingPreviewInvoiceItem.chargeDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    //     poSTBillingPreviewInvoiceItem.chargeDescription = 'aeiou';
    //     poSTBillingPreviewInvoiceItem.chargeId = 'aeiou';
    //     poSTBillingPreviewInvoiceItem.chargeName = 'aeiou';
    //     poSTBillingPreviewInvoiceItem.chargeNumber = 'aeiou';
    //     poSTBillingPreviewInvoiceItem.chargeType = 'aeiou';
    //     poSTBillingPreviewInvoiceItem.id = 'aeiou';
    //     poSTBillingPreviewInvoiceItem.processingType = 'aeiou';
    //     poSTBillingPreviewInvoiceItem.productName = 'aeiou';
    //     poSTBillingPreviewInvoiceItem.quantity = 'aeiou';
    //     poSTBillingPreviewInvoiceItem.serviceEndDate = Date.newInstance(2000, 1, 23);
    //     poSTBillingPreviewInvoiceItem.serviceStartDate = Date.newInstance(2000, 1, 23);
    //     poSTBillingPreviewInvoiceItem.subscriptionId = 'aeiou';
    //     poSTBillingPreviewInvoiceItem.subscriptionName = 'aeiou';
    //     poSTBillingPreviewInvoiceItem.subscriptionNumber = 'aeiou';
    //     poSTBillingPreviewInvoiceItem.taxAmount = 'aeiou';
    //     poSTBillingPreviewInvoiceItem.unitOfMeasure = 'aeiou';
    //     return poSTBillingPreviewInvoiceItem;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_POSTBillingPreviewInvoiceItem) {
            zc_POSTBillingPreviewInvoiceItem poSTBillingPreviewInvoiceItem = (zc_POSTBillingPreviewInvoiceItem) obj;
            return this.appliedToItemId == poSTBillingPreviewInvoiceItem.appliedToItemId
                && this.chargeAmount == poSTBillingPreviewInvoiceItem.chargeAmount
                && this.chargeDate == poSTBillingPreviewInvoiceItem.chargeDate
                && this.chargeDescription == poSTBillingPreviewInvoiceItem.chargeDescription
                && this.chargeId == poSTBillingPreviewInvoiceItem.chargeId
                && this.chargeName == poSTBillingPreviewInvoiceItem.chargeName
                && this.chargeNumber == poSTBillingPreviewInvoiceItem.chargeNumber
                && this.chargeType == poSTBillingPreviewInvoiceItem.chargeType
                && this.id == poSTBillingPreviewInvoiceItem.id
                && this.processingType == poSTBillingPreviewInvoiceItem.processingType
                && this.productName == poSTBillingPreviewInvoiceItem.productName
                && this.quantity == poSTBillingPreviewInvoiceItem.quantity
                && this.serviceEndDate == poSTBillingPreviewInvoiceItem.serviceEndDate
                && this.serviceStartDate == poSTBillingPreviewInvoiceItem.serviceStartDate
                && this.subscriptionId == poSTBillingPreviewInvoiceItem.subscriptionId
                && this.subscriptionName == poSTBillingPreviewInvoiceItem.subscriptionName
                && this.subscriptionNumber == poSTBillingPreviewInvoiceItem.subscriptionNumber
                && this.taxAmount == poSTBillingPreviewInvoiceItem.taxAmount
                && this.unitOfMeasure == poSTBillingPreviewInvoiceItem.unitOfMeasure;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (appliedToItemId == null ? 0 : System.hashCode(appliedToItemId));
        hashCode = (17 * hashCode) + (chargeAmount == null ? 0 : System.hashCode(chargeAmount));
        hashCode = (17 * hashCode) + (chargeDate == null ? 0 : System.hashCode(chargeDate));
        hashCode = (17 * hashCode) + (chargeDescription == null ? 0 : System.hashCode(chargeDescription));
        hashCode = (17 * hashCode) + (chargeId == null ? 0 : System.hashCode(chargeId));
        hashCode = (17 * hashCode) + (chargeName == null ? 0 : System.hashCode(chargeName));
        hashCode = (17 * hashCode) + (chargeNumber == null ? 0 : System.hashCode(chargeNumber));
        hashCode = (17 * hashCode) + (chargeType == null ? 0 : System.hashCode(chargeType));
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
        hashCode = (17 * hashCode) + (processingType == null ? 0 : System.hashCode(processingType));
        hashCode = (17 * hashCode) + (productName == null ? 0 : System.hashCode(productName));
        hashCode = (17 * hashCode) + (quantity == null ? 0 : System.hashCode(quantity));
        hashCode = (17 * hashCode) + (serviceEndDate == null ? 0 : System.hashCode(serviceEndDate));
        hashCode = (17 * hashCode) + (serviceStartDate == null ? 0 : System.hashCode(serviceStartDate));
        hashCode = (17 * hashCode) + (subscriptionId == null ? 0 : System.hashCode(subscriptionId));
        hashCode = (17 * hashCode) + (subscriptionName == null ? 0 : System.hashCode(subscriptionName));
        hashCode = (17 * hashCode) + (subscriptionNumber == null ? 0 : System.hashCode(subscriptionNumber));
        hashCode = (17 * hashCode) + (taxAmount == null ? 0 : System.hashCode(taxAmount));
        hashCode = (17 * hashCode) + (unitOfMeasure == null ? 0 : System.hashCode(unitOfMeasure));
        return hashCode;
    }
}