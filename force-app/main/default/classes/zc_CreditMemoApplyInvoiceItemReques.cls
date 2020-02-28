/**
 * zc_CreditMemoApplyInvoiceItemReques
 */
public class zc_CreditMemoApplyInvoiceItemReques {
    /**
     * The amount that is applied to the specific item. \n
     * @return amount
     */
    public Double amount { get; set; }

    /**
     * The ID of the credit memo item.\n
     * @return creditMemoItemId
     */
    public String creditMemoItemId { get; set; }

    /**
     * The ID of the credit memo taxation item.\n
     * @return creditTaxItemId
     */
    public String creditTaxItemId { get; set; }

    /**
     * The ID of the invoice item that the credit memo item is applied to.\n
     * @return invoiceItemId
     */
    public String invoiceItemId { get; set; }

    /**
     * The ID of the invoice taxation item that the credit memo taxation item is applied to.\n
     * @return taxItemId
     */
    public String taxItemId { get; set; }

    
    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Aaaa' => 'aaa'
    };

    
    // public static zc_CreditMemoApplyInvoiceItemReques getExample() {
    //     zc_CreditMemoApplyInvoiceItemReques creditMemoApplyInvoiceItemRequestType = new zc_CreditMemoApplyInvoiceItemReques();
    //     creditMemoApplyInvoiceItemRequestType.amount = 1.3579;
    //     creditMemoApplyInvoiceItemRequestType.creditMemoItemId = 'aeiou';
    //     creditMemoApplyInvoiceItemRequestType.creditTaxItemId = 'aeiou';
    //     creditMemoApplyInvoiceItemRequestType.invoiceItemId = 'aeiou';
    //     creditMemoApplyInvoiceItemRequestType.taxItemId = 'aeiou';
    //     return creditMemoApplyInvoiceItemRequestType;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_CreditMemoApplyInvoiceItemReques) {
            zc_CreditMemoApplyInvoiceItemReques creditMemoApplyInvoiceItemRequestType = (zc_CreditMemoApplyInvoiceItemReques) obj;
            return this.amount == creditMemoApplyInvoiceItemRequestType.amount
                && this.creditMemoItemId == creditMemoApplyInvoiceItemRequestType.creditMemoItemId
                && this.creditTaxItemId == creditMemoApplyInvoiceItemRequestType.creditTaxItemId
                && this.invoiceItemId == creditMemoApplyInvoiceItemRequestType.invoiceItemId
                && this.taxItemId == creditMemoApplyInvoiceItemRequestType.taxItemId;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (amount == null ? 0 : System.hashCode(amount));
        hashCode = (17 * hashCode) + (creditMemoItemId == null ? 0 : System.hashCode(creditMemoItemId));
        hashCode = (17 * hashCode) + (creditTaxItemId == null ? 0 : System.hashCode(creditTaxItemId));
        hashCode = (17 * hashCode) + (invoiceItemId == null ? 0 : System.hashCode(invoiceItemId));
        hashCode = (17 * hashCode) + (taxItemId == null ? 0 : System.hashCode(taxItemId));
        return hashCode;
    }
}