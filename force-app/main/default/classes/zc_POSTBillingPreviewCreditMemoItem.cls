/**
 * zc_POSTBillingPreviewCreditMemoItem
 */
public class zc_POSTBillingPreviewCreditMemoItem {
    /**
     * The amount of the credit memo item. For tax-inclusive credit memo items, the amount indicates the credit memo item amount including tax. For tax-exclusive credit memo items, the amount indicates the credit memo item amount excluding tax\n
     * @return amount
     */
    public Double amount { get; set; }

    /**
     * The credit memo item amount excluding tax.\n
     * @return amountWithoutTax
     */
    public Double amountWithoutTax { get; set; }

    /**
     * The unique ID of the credit memo item that the discount charge is applied to.\n
     * @return appliedToItemId
     */
    public String appliedToItemId { get; set; }

    /**
     * The date when the credit memo item is created.\n
     * @return chargeDate
     */
    public String chargeDate { get; set; }

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
     * Comment of the credit memo item.\n
     * @return comment
     */
    public String comment { get; set; }

    /**
     * Credit memo item id.\n
     * @return id
     */
    public String id { get; set; }

    /**
     * Identifies the kind of charge. \n\nPossible values:\n* charge\n* discount\n* prepayment\n* tax\n
     * @return processingType
     */
    public String processingType { get; set; }

    /**
     * Quantity of this item, in the configured unit of measure for the charge.\n
     * @return quantity
     */
    public String quantity { get; set; }

    /**
     * Id of the rate plan charge associated with this item.\n
     * @return ratePlanChargeId
     */
    public String ratePlanChargeId { get; set; }

    /**
     * End date of the service period for this item, i.e., the last day of the service period, in yyyy-mm-dd format.\n
     * @return serviceEndDate
     */
    public Date serviceEndDate { get; set; }

    /**
     * Start date of the service period for this item, in yyyy-mm-dd format. If the charge is a one-time fee, this is the date of that charge.\n
     * @return serviceStartDate
     */
    public Date serviceStartDate { get; set; }

    /**
     * Unique SKU for the product associated with this item.\n
     * @return sku
     */
    public String sku { get; set; }

    /**
     * Name of the unique SKU for the product associated with this item.\n
     * @return skuName
     */
    public String skuName { get; set; }

    /**
     * ID of the subscription associated with this item.\n
     * @return subscriptionId
     */
    public String subscriptionId { get; set; }

    /**
     * Name of the subscription associated with this item.\n
     * @return subscriptionNumber
     */
    public String subscriptionNumber { get; set; }

    /**
     * Unit used to measure consumption.\n
     * @return unitOfMeasure
     */
    public String unitOfMeasure { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Abb' => 'abb'
    };

    // public static zc_POSTBillingPreviewCreditMemoItem getExample() {
    //     zc_POSTBillingPreviewCreditMemoItem poSTBillingPreviewCreditMemoItem = new zc_POSTBillingPreviewCreditMemoItem();
    //     poSTBillingPreviewCreditMemoItem.amount = 1.3579;
    //     poSTBillingPreviewCreditMemoItem.amountWithoutTax = 1.3579;
    //     poSTBillingPreviewCreditMemoItem.appliedToItemId = 'aeiou';
    //     poSTBillingPreviewCreditMemoItem.chargeDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    //     poSTBillingPreviewCreditMemoItem.chargeNumber = 'aeiou';
    //     poSTBillingPreviewCreditMemoItem.chargeType = 'aeiou';
    //     poSTBillingPreviewCreditMemoItem.comment = 'aeiou';
    //     poSTBillingPreviewCreditMemoItem.id = 'aeiou';
    //     poSTBillingPreviewCreditMemoItem.processingType = 'aeiou';
    //     poSTBillingPreviewCreditMemoItem.quantity = 'aeiou';
    //     poSTBillingPreviewCreditMemoItem.ratePlanChargeId = 'aeiou';
    //     poSTBillingPreviewCreditMemoItem.serviceEndDate = Date.newInstance(2000, 1, 23);
    //     poSTBillingPreviewCreditMemoItem.serviceStartDate = Date.newInstance(2000, 1, 23);
    //     poSTBillingPreviewCreditMemoItem.sku = 'aeiou';
    //     poSTBillingPreviewCreditMemoItem.skuName = 'aeiou';
    //     poSTBillingPreviewCreditMemoItem.subscriptionId = 'aeiou';
    //     poSTBillingPreviewCreditMemoItem.subscriptionNumber = 'aeiou';
    //     poSTBillingPreviewCreditMemoItem.unitOfMeasure = 'aeiou';
    //     return poSTBillingPreviewCreditMemoItem;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_POSTBillingPreviewCreditMemoItem) {
            zc_POSTBillingPreviewCreditMemoItem poSTBillingPreviewCreditMemoItem = (zc_POSTBillingPreviewCreditMemoItem) obj;
            return this.amount == poSTBillingPreviewCreditMemoItem.amount
                && this.amountWithoutTax == poSTBillingPreviewCreditMemoItem.amountWithoutTax
                && this.appliedToItemId == poSTBillingPreviewCreditMemoItem.appliedToItemId
                && this.chargeDate == poSTBillingPreviewCreditMemoItem.chargeDate
                && this.chargeNumber == poSTBillingPreviewCreditMemoItem.chargeNumber
                && this.chargeType == poSTBillingPreviewCreditMemoItem.chargeType
                && this.comment == poSTBillingPreviewCreditMemoItem.comment
                && this.id == poSTBillingPreviewCreditMemoItem.id
                && this.processingType == poSTBillingPreviewCreditMemoItem.processingType
                && this.quantity == poSTBillingPreviewCreditMemoItem.quantity
                && this.ratePlanChargeId == poSTBillingPreviewCreditMemoItem.ratePlanChargeId
                && this.serviceEndDate == poSTBillingPreviewCreditMemoItem.serviceEndDate
                && this.serviceStartDate == poSTBillingPreviewCreditMemoItem.serviceStartDate
                && this.sku == poSTBillingPreviewCreditMemoItem.sku
                && this.skuName == poSTBillingPreviewCreditMemoItem.skuName
                && this.subscriptionId == poSTBillingPreviewCreditMemoItem.subscriptionId
                && this.subscriptionNumber == poSTBillingPreviewCreditMemoItem.subscriptionNumber
                && this.unitOfMeasure == poSTBillingPreviewCreditMemoItem.unitOfMeasure;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (amount == null ? 0 : System.hashCode(amount));
        hashCode = (17 * hashCode) + (amountWithoutTax == null ? 0 : System.hashCode(amountWithoutTax));
        hashCode = (17 * hashCode) + (appliedToItemId == null ? 0 : System.hashCode(appliedToItemId));
        hashCode = (17 * hashCode) + (chargeDate == null ? 0 : System.hashCode(chargeDate));
        hashCode = (17 * hashCode) + (chargeNumber == null ? 0 : System.hashCode(chargeNumber));
        hashCode = (17 * hashCode) + (chargeType == null ? 0 : System.hashCode(chargeType));
        hashCode = (17 * hashCode) + (comment == null ? 0 : System.hashCode(comment));
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
        hashCode = (17 * hashCode) + (processingType == null ? 0 : System.hashCode(processingType));
        hashCode = (17 * hashCode) + (quantity == null ? 0 : System.hashCode(quantity));
        hashCode = (17 * hashCode) + (ratePlanChargeId == null ? 0 : System.hashCode(ratePlanChargeId));
        hashCode = (17 * hashCode) + (serviceEndDate == null ? 0 : System.hashCode(serviceEndDate));
        hashCode = (17 * hashCode) + (serviceStartDate == null ? 0 : System.hashCode(serviceStartDate));
        hashCode = (17 * hashCode) + (sku == null ? 0 : System.hashCode(sku));
        hashCode = (17 * hashCode) + (skuName == null ? 0 : System.hashCode(skuName));
        hashCode = (17 * hashCode) + (subscriptionId == null ? 0 : System.hashCode(subscriptionId));
        hashCode = (17 * hashCode) + (subscriptionNumber == null ? 0 : System.hashCode(subscriptionNumber));
        hashCode = (17 * hashCode) + (unitOfMeasure == null ? 0 : System.hashCode(unitOfMeasure));
        return hashCode;
    }
}