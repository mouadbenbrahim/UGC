public class zc_InvoiceDataInvoice implements zc_Zuc.MappedProperties {
//public class zc_InvoiceDataInvoice implements zc_InvoiceObjectNSFields, zc_InvoiceObjectCustomFields, zc_Zuc.MappedProperties {
    /**
     * ID of the corresponding object in NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return integrationIdNS
     */
    public String integrationIdNS { get; set; }

    /**
     * Status of the invoice\'s synchronization with NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return integrationStatusNS
     */
    public String integrationStatusNS { get; set; }

    /**
     * Date when the invoice was synchronized with NetSuite. Only available if you have installed the [Zuora Connector for NetSuite](https://www.zuora.com/connect/app/?appId=265).\n
     * @return syncDateNS
     */
    public String syncDateNS { get; set; }

    /**
     * 
     * @return accountId
     */
    public String accountId { get; set; }

    /**
     *  The amount of the invoice adjustments associated with the invoice. **Character limi**t: 16\n\n\n**Values**: a valid currency amount 
     * @return adjustmentAmount
     */
    public Double adjustmentAmount { get; set; }

    /**
     *  The sum of all charges and taxes associated with the invoice.\n\n\n**Character limit**: 16\n\n\n**Values**: automatically generated 
     * @return amount
     */
    public Double amount { get; set; }

    /**
     *  The sum of all charges associated with the invoice. Taxes are excluded from this value.\n\n\n**Character limit**: 16\n\n\n**Values**: automatically generated 
     * @return amountWithoutTax
     */
    public Double amountWithoutTax { get; set; }

    /**
     *  The remaining balance of the invoice after all payments, adjustments, and refunds are applied.\n\n\n**Character limit**: 16\n\n\n**Values**: automatically generated 
     * @return balance
     */
    public Double balance { get; set; }

    /**
     *  The ID of a Bill Run.\n\n\n**Character limit**: 32\n\n\n**Values**: a BillRun ID 
     * @return billRunId
     */
    public String billRunId { get; set; }

    /**
     *  Required 
     * @return body
     */
    public String body { get; set; }

    /**
     *  Additional information related to the invoice that a Zuora user added to the invoice.\n\n\n**Character limit**: 255 **Values:** a string of 255 characters or fewer 
     * @return comments
     */
    public String comments { get; set; }

    /**
     *  The user ID of the person who created the invoice. If a bill run generated the invoice, then the value is the user ID of person who created the bill run.\n\n\n**Character limit**: 32\n\n\n**Values**: automatically generated 
     * @return createdById
     */
    public String createdById { get; set; }

    /**
     *  The date when the invoice was generated.\n\n\n**Character limit**: 29\n\n\n**Values**: automatically generated 
     * @return createdDate
     */
    public Datetime createdDate { get; set; }

    /**
     *  The currency amount of the adjustment applied to the customer\'s credit balance.\n\n\n**Character limit**: 16\n\n\n**Values**: a valid currency amount This field is only available if the [Zuora Global Support](http://support.zuora.com/) to enable this feature.\n\n\n
     * @return creditBalanceAdjustmentAmount
     */
    public Double creditBalanceAdjustmentAmount { get; set; }

    /**
     *  The date by which the payment for this invoice is due.\n\n\n**Character limit**: 29 
     * @return dueDate
     */
    public Date dueDate { get; set; }

    /**
     *  Specifies whether the invoice includes one-time charges. You can use this field only with the `generate\n` call for the Invoice object.\n\n\n**Character limit**: 5\n\n\n**Values**: automatically generated from one of the following: `True` (default), `False` 
     * @return includesOneTime
     */
    public Boolean includesOneTime { get; set; }

    /**
     *  Specifies whether the invoice includes recurring charges. You can use this field only with the `generate\n`call for the Invoice object.\n\n\n**Character limit**: 5\n\n\n**Values**: automatically generated from one of the following: `True` (default), `False` 
     * @return includesRecurring
     */
    public Boolean includesRecurring { get; set; }

    /**
     *  Specifies whether the invoice includes usage charges. You can use this field only with the `generate\n`call for the Invoice object.\n\n\n**Character limit**: 5\n\n\n**Values**: automatically generated from one of the following: `True `(default), `False` 
     * @return includesUsage
     */
    public Boolean includesUsage { get; set; }

    /**
     *  Specifies the date on which to generate the invoice.\n\n\n**Character limit**: 29 
     * @return invoiceDate
     */
    public Date invoiceDate { get; set; }

    /**
     *  The unique identification number for the invoice. This number is returned as a string.\n\n\n**Character limit**: 32\n\n\n**Values**: automatically generated 
     * @return invoiceNumber
     */
    public String invoiceNumber { get; set; }

    /**
     *  The date when the invoice was last emailed.\n\n\n**Character limit**: 29\n\n\n**Values**: automatically generated 
     * @return lastEmailSentDate
     */
    public Datetime lastEmailSentDate { get; set; }

    /**
     *  The amount of payments applied to the invoice.\n\n\n**Character limit**: 16 **Value**s: automatically generated 
     * @return paymentAmount
     */
    public Double paymentAmount { get; set; }

    /**
     *  The user ID of the person who moved the invoice to Posted status.\n\n\n**Character limit**: 32\n\n\n**Values**: automatically generated 
     * @return postedBy
     */
    public String postedBy { get; set; }

    /**
     *  The date when the invoice was posted.\n**Character limit:** 29\n\n\n**Values**: automatically generated 
     * @return postedDate
     */
    public Datetime postedDate { get; set; }

    /**
     *  Specifies the amount of a refund that was applied against an earlier payment on the invoice.\n\n\n**Character limit**: 16\n\n\n**Values**: automatically generated 
     * @return refundAmount
     */
    public Double refundAmount { get; set; }

    /**
     *  Regenerates a PDF of an invoice that was already generated. Add this field to an `update\n` call to regenerate an invoice PDF. Note that when you set the `RegenerateInvoicePDF` field to `true`, you cannot update any other fields in the same `update\n` call. Otherwise, you will receive the following `INVALID_VALUE` error: &quot;When field RegenerateInvoicePDF is set to true to regenerate the invoice PDF file, changes on other fields of the invoice are not allowed.&quot;\n\n**Character limit**: 5\n\n\n**Values**: `True`, `False` 
     * @return regenerateInvoicePDF
     */
    public Boolean regenerateInvoicePDF { get; set; }

    /**
     *  The status of the invoice in the system. This status is not the status of the payment of the invoice, just the status of the invoice itself.\n\n\n**Character limit**: 8\n\n\n**Values**: one of the following:\n\n-  Draft (default, automatically set upon invoice creation)\n\n-  Posted\n\n-  Canceled\n\n
     * @return status
     */
    public String status { get; set; }

    /**
     *  This date is used to determine which charges are to be billed. All charges that are to be billed on this date or prior will be included in this bill run.\n\n\n**Character limit**: 29 
     * @return targetDate
     */
    public Date targetDate { get; set; }

    /**
     *  The total amount of the taxes applied to the invoice.\n\n\n**Character limit**: 16\n\n\n**Values**: automatically generated 
     * @return taxAmount
     */
    public Double taxAmount { get; set; }

    /**
     *  The total amount of the invoice that is exempt from taxation.\n\n\n**Character limit**: 16\n\n\n**Values**: automatically generated 
     * @return taxExemptAmount
     */
    public Double taxExemptAmount { get; set; }

    /**
     *  Specifies whether or not the invoice was transferred to an external accounting system, such as NetSuite.\n\n\n**Character limit**: 10\n\n\n**Values**: Processing, Yes, Error, Ignore 
     * @return transferredToAccounting
     */
    public String transferredToAccounting { get; set; }

    /**
     * 
     * @return updatedById
     */
    public String updatedById { get; set; }

    /**
     *  The date when the invoice was last updated.\n\n\n**Character limit**: 29\n\n\n**Values**: automatically generated 
     * @return updatedDate
     */
    public Datetime updatedDate { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'IntegrationId__NS' => 'integrationIdNS',
        'IntegrationStatus__NS' => 'integrationStatusNS',
        'SyncDate__NS' => 'syncDateNS',
        'AccountId' => 'accountId',
        'AdjustmentAmount' => 'adjustmentAmount',
        'Amount' => 'amount',
        'AmountWithoutTax' => 'amountWithoutTax',
        'Balance' => 'balance',
        'BillRunId' => 'billRunId',
        'Body' => 'body',
        'Comments' => 'comments',
        'CreatedById' => 'createdById',
        'CreatedDate' => 'createdDate',
        'CreditBalanceAdjustmentAmount' => 'creditBalanceAdjustmentAmount',
        'DueDate' => 'dueDate',
        'IncludesOneTime' => 'includesOneTime',
        'IncludesRecurring' => 'includesRecurring',
        'IncludesUsage' => 'includesUsage',
        'InvoiceDate' => 'invoiceDate',
        'InvoiceNumber' => 'invoiceNumber',
        'LastEmailSentDate' => 'lastEmailSentDate',
        'PaymentAmount' => 'paymentAmount',
        'PostedBy' => 'postedBy',
        'PostedDate' => 'postedDate',
        'RefundAmount' => 'refundAmount',
        'RegenerateInvoicePDF' => 'regenerateInvoicePDF',
        'Status' => 'status',
        'TargetDate' => 'targetDate',
        'TaxAmount' => 'taxAmount',
        'TaxExemptAmount' => 'taxExemptAmount',
        'TransferredToAccounting' => 'transferredToAccounting',
        'UpdatedById' => 'updatedById',
        'UpdatedDate' => 'updatedDate'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public static zc_InvoiceDataInvoice getExample() {
        zc_InvoiceDataInvoice invoiceDataInvoice = new zc_InvoiceDataInvoice();
        invoiceDataInvoice.integrationIdNS = 'aeiou';
        invoiceDataInvoice.integrationStatusNS = 'aeiou';
        invoiceDataInvoice.syncDateNS = 'aeiou';
        invoiceDataInvoice.accountId = 'aeiou';
        invoiceDataInvoice.adjustmentAmount = 1.3579;
        invoiceDataInvoice.amount = 1.3579;
        invoiceDataInvoice.amountWithoutTax = 1.3579;
        invoiceDataInvoice.balance = 1.3579;
        invoiceDataInvoice.billRunId = 'aeiou';
        invoiceDataInvoice.body = 'aeiou';
        invoiceDataInvoice.comments = 'aeiou';
        invoiceDataInvoice.createdById = 'aeiou';
        invoiceDataInvoice.createdDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
        invoiceDataInvoice.creditBalanceAdjustmentAmount = 1.3579;
        invoiceDataInvoice.dueDate = Date.newInstance(2000, 1, 23);
        invoiceDataInvoice.includesOneTime = true;
        invoiceDataInvoice.includesRecurring = true;
        invoiceDataInvoice.includesUsage = true;
        invoiceDataInvoice.invoiceDate = Date.newInstance(2000, 1, 23);
        invoiceDataInvoice.invoiceNumber = 'aeiou';
        invoiceDataInvoice.lastEmailSentDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
        invoiceDataInvoice.paymentAmount = 1.3579;
        invoiceDataInvoice.postedBy = 'aeiou';
        invoiceDataInvoice.postedDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
        invoiceDataInvoice.refundAmount = 1.3579;
        invoiceDataInvoice.regenerateInvoicePDF = true;
        invoiceDataInvoice.status = 'aeiou';
        invoiceDataInvoice.targetDate = Date.newInstance(2000, 1, 23);
        invoiceDataInvoice.taxAmount = 1.3579;
        invoiceDataInvoice.taxExemptAmount = 1.3579;
        invoiceDataInvoice.transferredToAccounting = 'aeiou';
        invoiceDataInvoice.updatedById = 'aeiou';
        invoiceDataInvoice.updatedDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
        return invoiceDataInvoice;
    }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_InvoiceDataInvoice) {
            zc_InvoiceDataInvoice invoiceDataInvoice = (zc_InvoiceDataInvoice) obj;
            return this.integrationIdNS == invoiceDataInvoice.integrationIdNS
                && this.integrationStatusNS == invoiceDataInvoice.integrationStatusNS
                && this.syncDateNS == invoiceDataInvoice.syncDateNS
                && this.accountId == invoiceDataInvoice.accountId
                && this.adjustmentAmount == invoiceDataInvoice.adjustmentAmount
                && this.amount == invoiceDataInvoice.amount
                && this.amountWithoutTax == invoiceDataInvoice.amountWithoutTax
                && this.balance == invoiceDataInvoice.balance
                && this.billRunId == invoiceDataInvoice.billRunId
                && this.body == invoiceDataInvoice.body
                && this.comments == invoiceDataInvoice.comments
                && this.createdById == invoiceDataInvoice.createdById
                && this.createdDate == invoiceDataInvoice.createdDate
                && this.creditBalanceAdjustmentAmount == invoiceDataInvoice.creditBalanceAdjustmentAmount
                && this.dueDate == invoiceDataInvoice.dueDate
                && this.includesOneTime == invoiceDataInvoice.includesOneTime
                && this.includesRecurring == invoiceDataInvoice.includesRecurring
                && this.includesUsage == invoiceDataInvoice.includesUsage
                && this.invoiceDate == invoiceDataInvoice.invoiceDate
                && this.invoiceNumber == invoiceDataInvoice.invoiceNumber
                && this.lastEmailSentDate == invoiceDataInvoice.lastEmailSentDate
                && this.paymentAmount == invoiceDataInvoice.paymentAmount
                && this.postedBy == invoiceDataInvoice.postedBy
                && this.postedDate == invoiceDataInvoice.postedDate
                && this.refundAmount == invoiceDataInvoice.refundAmount
                && this.regenerateInvoicePDF == invoiceDataInvoice.regenerateInvoicePDF
                && this.status == invoiceDataInvoice.status
                && this.targetDate == invoiceDataInvoice.targetDate
                && this.taxAmount == invoiceDataInvoice.taxAmount
                && this.taxExemptAmount == invoiceDataInvoice.taxExemptAmount
                && this.transferredToAccounting == invoiceDataInvoice.transferredToAccounting
                && this.updatedById == invoiceDataInvoice.updatedById
                && this.updatedDate == invoiceDataInvoice.updatedDate;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (integrationIdNS == null ? 0 : System.hashCode(integrationIdNS));
        hashCode = (17 * hashCode) + (integrationStatusNS == null ? 0 : System.hashCode(integrationStatusNS));
        hashCode = (17 * hashCode) + (syncDateNS == null ? 0 : System.hashCode(syncDateNS));
        hashCode = (17 * hashCode) + (accountId == null ? 0 : System.hashCode(accountId));
        hashCode = (17 * hashCode) + (adjustmentAmount == null ? 0 : System.hashCode(adjustmentAmount));
        hashCode = (17 * hashCode) + (amount == null ? 0 : System.hashCode(amount));
        hashCode = (17 * hashCode) + (amountWithoutTax == null ? 0 : System.hashCode(amountWithoutTax));
        hashCode = (17 * hashCode) + (balance == null ? 0 : System.hashCode(balance));
        hashCode = (17 * hashCode) + (billRunId == null ? 0 : System.hashCode(billRunId));
        hashCode = (17 * hashCode) + (body == null ? 0 : System.hashCode(body));
        hashCode = (17 * hashCode) + (comments == null ? 0 : System.hashCode(comments));
        hashCode = (17 * hashCode) + (createdById == null ? 0 : System.hashCode(createdById));
        hashCode = (17 * hashCode) + (createdDate == null ? 0 : System.hashCode(createdDate));
        hashCode = (17 * hashCode) + (creditBalanceAdjustmentAmount == null ? 0 : System.hashCode(creditBalanceAdjustmentAmount));
        hashCode = (17 * hashCode) + (dueDate == null ? 0 : System.hashCode(dueDate));
        hashCode = (17 * hashCode) + (includesOneTime == null ? 0 : System.hashCode(includesOneTime));
        hashCode = (17 * hashCode) + (includesRecurring == null ? 0 : System.hashCode(includesRecurring));
        hashCode = (17 * hashCode) + (includesUsage == null ? 0 : System.hashCode(includesUsage));
        hashCode = (17 * hashCode) + (invoiceDate == null ? 0 : System.hashCode(invoiceDate));
        hashCode = (17 * hashCode) + (invoiceNumber == null ? 0 : System.hashCode(invoiceNumber));
        hashCode = (17 * hashCode) + (lastEmailSentDate == null ? 0 : System.hashCode(lastEmailSentDate));
        hashCode = (17 * hashCode) + (paymentAmount == null ? 0 : System.hashCode(paymentAmount));
        hashCode = (17 * hashCode) + (postedBy == null ? 0 : System.hashCode(postedBy));
        hashCode = (17 * hashCode) + (postedDate == null ? 0 : System.hashCode(postedDate));
        hashCode = (17 * hashCode) + (refundAmount == null ? 0 : System.hashCode(refundAmount));
        hashCode = (17 * hashCode) + (regenerateInvoicePDF == null ? 0 : System.hashCode(regenerateInvoicePDF));
        hashCode = (17 * hashCode) + (status == null ? 0 : System.hashCode(status));
        hashCode = (17 * hashCode) + (targetDate == null ? 0 : System.hashCode(targetDate));
        hashCode = (17 * hashCode) + (taxAmount == null ? 0 : System.hashCode(taxAmount));
        hashCode = (17 * hashCode) + (taxExemptAmount == null ? 0 : System.hashCode(taxExemptAmount));
        hashCode = (17 * hashCode) + (transferredToAccounting == null ? 0 : System.hashCode(transferredToAccounting));
        hashCode = (17 * hashCode) + (updatedById == null ? 0 : System.hashCode(updatedById));
        hashCode = (17 * hashCode) + (updatedDate == null ? 0 : System.hashCode(updatedDate));
        return hashCode;
    }
}