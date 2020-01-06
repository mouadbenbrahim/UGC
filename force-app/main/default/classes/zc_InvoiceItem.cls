public class zc_InvoiceItem implements zc_Zuc.MappedProperties {
// public class zc_InvoiceItem implements zc_InvoiceItemObjectNSFields, zc_InvoiceItemObjectCustomFields, zc_Zuc.MappedProperties {
    /**
     * ID of the corresponding object in NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return integrationIdNS
     */
    public String integrationIdNS { get; set; }

    /**
     * Status of the invoice item\'s synchronization with NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return integrationStatusNS
     */
    public String integrationStatusNS { get; set; }

    /**
     * Date when the invoice item was synchronized with NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return syncDateNS
     */
    public String syncDateNS { get; set; }

    /**
     * The unique ID of the invoice item that the discount charge is applied to.
     * @return appliedToItemId
     */
    public String appliedToItemId { get; set; }

    /**
     * The amount of the invoice item that is available to credit.        \n
     * @return availableToCreditAmount
     */
    public Double availableToCreditAmount { get; set; }

    /**
     * The balance of the invoice item.
     * @return balance
     */
    public String balance { get; set; }

    /**
     * The amount of the charge. This amount does not include taxes regardless if the charge\'s tax mode is inclusive or exclusive.
     * @return chargeAmount
     */
    public Double chargeAmount { get; set; }

    /**
     * Description of the charge.
     * @return chargeDescription
     */
    public String chargeDescription { get; set; }

    /**
     * ID of the charge.
     * @return chargeId
     */
    public String chargeId { get; set; }

    /**
     * Name of the charge.
     * @return chargeName
     */
    public String chargeName { get; set; }

    /**
     * Item ID.
     * @return id
     */
    public String id { get; set; }

    /**
     * Name of the product associated with this item.
     * @return productName
     */
    public String productName { get; set; }

    /**
     * Quantity of this item, in the configured unit of measure for the charge.
     * @return quantity
     */
    public String quantity { get; set; }

    /**
     * End date of the service period for this item, i.e., the last day of the service period, as _yyyy-mm-dd_.
     * @return serviceEndDate
     */
    public Date serviceEndDate { get; set; }

    /**
     * Start date of the service period for this item, as _yyyy-mm-dd_. For a one-time fee item, the date of the charge.
     * @return serviceStartDate
     */
    public Date serviceStartDate { get; set; }

    /**
     * ID of the subscription for this item.
     * @return subscriptionId
     */
    public String subscriptionId { get; set; }

    /**
     * Name of the subscription for this item.
     * @return subscriptionName
     */
    public String subscriptionName { get; set; }

    /**
     * Returns `true` if the request was processed successfully.
     * @return success
     */
    public Boolean success { get; set; }

    /**
     * Tax applied to the charge.
     * @return taxAmount
     */
    public Double taxAmount { get; set; }

    /**
     * Get taxationItems
     * @return taxationItems
     */
    public zc_InvoiceItemTaxationItems taxationItems { get; set; }

    /**
     * Unit used to measure. consumption.
     * @return unitOfMeasure
     */
    public String unitOfMeasure { get; set; }

    // MBEN Add
    public Double unitPrice { get; set; }

    public String productRatePlanChargeId { get; set; }

    public String productId { get; set; }

    public zc_InvoiceItem(){
        taxationItems = new zc_InvoiceItemTaxationItems();
    }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'IntegrationId__NS' => 'integrationIdNS',
        'IntegrationStatus__NS' => 'integrationStatusNS',
        'SyncDate__NS' => 'syncDateNS',
        'UnitPrice' => 'unitPrice',
        'ProductRatePlanChargeId' => 'productRatePlanChargeId',
        'ProductId' => 'productId'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public static zc_InvoiceItem getExample() {
        zc_InvoiceItem invoiceItem = new zc_InvoiceItem();
        invoiceItem.integrationIdNS = 'aeiou';
        invoiceItem.integrationStatusNS = 'aeiou';
        invoiceItem.syncDateNS = 'aeiou';
        invoiceItem.appliedToItemId = 'aeiou';
        invoiceItem.availableToCreditAmount = 1.3579;
        invoiceItem.balance = 'aeiou';
        invoiceItem.chargeAmount = 11;
        invoiceItem.chargeDescription = 'aeiou';
        invoiceItem.chargeId = 'aeiou';
        invoiceItem.chargeName = 'aeiou';
        invoiceItem.id = 'aeiou';
        invoiceItem.productName = 'aeiou';
        invoiceItem.quantity = 'aeiou';
        invoiceItem.serviceEndDate = Date.newInstance(2000, 1, 23);
        invoiceItem.serviceStartDate = Date.newInstance(2000, 1, 23);
        invoiceItem.subscriptionId = 'aeiou';
        invoiceItem.subscriptionName = 'aeiou';
        invoiceItem.success = true;
        invoiceItem.taxAmount =1;
        invoiceItem.taxationItems = zc_InvoiceItemTaxationItems.getExample();
        invoiceItem.unitOfMeasure = 'aeiou';
        return invoiceItem;
    }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_InvoiceItem) {
            zc_InvoiceItem invoiceItem = (zc_InvoiceItem) obj;
            return this.integrationIdNS == invoiceItem.integrationIdNS
                && this.integrationStatusNS == invoiceItem.integrationStatusNS
                && this.syncDateNS == invoiceItem.syncDateNS
                && this.appliedToItemId == invoiceItem.appliedToItemId
                && this.availableToCreditAmount == invoiceItem.availableToCreditAmount
                && this.balance == invoiceItem.balance
                && this.chargeAmount == invoiceItem.chargeAmount
                && this.chargeDescription == invoiceItem.chargeDescription
                && this.chargeId == invoiceItem.chargeId
                && this.chargeName == invoiceItem.chargeName
                && this.id == invoiceItem.id
                && this.productName == invoiceItem.productName
                && this.quantity == invoiceItem.quantity
                && this.serviceEndDate == invoiceItem.serviceEndDate
                && this.serviceStartDate == invoiceItem.serviceStartDate
                && this.subscriptionId == invoiceItem.subscriptionId
                && this.subscriptionName == invoiceItem.subscriptionName
                && this.success == invoiceItem.success
                && this.taxAmount == invoiceItem.taxAmount
                && this.taxationItems == invoiceItem.taxationItems
                && this.unitOfMeasure == invoiceItem.unitOfMeasure;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (integrationIdNS == null ? 0 : System.hashCode(integrationIdNS));
        hashCode = (17 * hashCode) + (integrationStatusNS == null ? 0 : System.hashCode(integrationStatusNS));
        hashCode = (17 * hashCode) + (syncDateNS == null ? 0 : System.hashCode(syncDateNS));
        hashCode = (17 * hashCode) + (appliedToItemId == null ? 0 : System.hashCode(appliedToItemId));
        hashCode = (17 * hashCode) + (availableToCreditAmount == null ? 0 : System.hashCode(availableToCreditAmount));
        hashCode = (17 * hashCode) + (balance == null ? 0 : System.hashCode(balance));
        hashCode = (17 * hashCode) + (chargeAmount == null ? 0 : System.hashCode(chargeAmount));
        hashCode = (17 * hashCode) + (chargeDescription == null ? 0 : System.hashCode(chargeDescription));
        hashCode = (17 * hashCode) + (chargeId == null ? 0 : System.hashCode(chargeId));
        hashCode = (17 * hashCode) + (chargeName == null ? 0 : System.hashCode(chargeName));
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
        hashCode = (17 * hashCode) + (productName == null ? 0 : System.hashCode(productName));
        hashCode = (17 * hashCode) + (quantity == null ? 0 : System.hashCode(quantity));
        hashCode = (17 * hashCode) + (serviceEndDate == null ? 0 : System.hashCode(serviceEndDate));
        hashCode = (17 * hashCode) + (serviceStartDate == null ? 0 : System.hashCode(serviceStartDate));
        hashCode = (17 * hashCode) + (subscriptionId == null ? 0 : System.hashCode(subscriptionId));
        hashCode = (17 * hashCode) + (subscriptionName == null ? 0 : System.hashCode(subscriptionName));
        hashCode = (17 * hashCode) + (success == null ? 0 : System.hashCode(success));
        hashCode = (17 * hashCode) + (taxAmount == null ? 0 : System.hashCode(taxAmount));
        hashCode = (17 * hashCode) + (taxationItems == null ? 0 : System.hashCode(taxationItems));
        hashCode = (17 * hashCode) + (unitOfMeasure == null ? 0 : System.hashCode(unitOfMeasure));
        return hashCode;
    }
}