/**
 * zc_CreditMemoApplyInvoiceRequestTyp
 */
public class zc_CreditMemoApplyInvoiceRequestTyp {
    /**
     * The credit memo amount to be applied to the invoice.\n
     * @return amount
     */
    public Double amount { get; set; }

    /**
     * The unique ID of the invoice that the credit memo is applied to.\n
     * @return invoiceId
     */
    public String invoiceId { get; set; }

    /**
     * Container for items.\n
     * @return items
     */
    public List<zc_CreditMemoApplyInvoiceItemReques> items { get; set; }

    public zc_CreditMemoApplyInvoiceRequestTyp() {
        items = new List<zc_CreditMemoApplyInvoiceItemReques>();
    }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Aaaa' => 'aaa'
    };
        
    // public static zc_CreditMemoApplyInvoiceRequestTyp getExample() {
    //     zc_CreditMemoApplyInvoiceRequestTyp creditMemoApplyInvoiceRequestType = new zc_CreditMemoApplyInvoiceRequestTyp();
    //     creditMemoApplyInvoiceRequestType.amount = 1.3579;
    //     creditMemoApplyInvoiceRequestType.invoiceId = 'aeiou';
    //     creditMemoApplyInvoiceRequestType.items = new List<zc_CreditMemoApplyInvoiceItemReques>{zc_CreditMemoApplyInvoiceItemReques.getExample()};
    //     return creditMemoApplyInvoiceRequestType;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_CreditMemoApplyInvoiceRequestTyp) {
            zc_CreditMemoApplyInvoiceRequestTyp creditMemoApplyInvoiceRequestType = (zc_CreditMemoApplyInvoiceRequestTyp) obj;
            return this.amount == creditMemoApplyInvoiceRequestType.amount
                && this.invoiceId == creditMemoApplyInvoiceRequestType.invoiceId
                && this.items == creditMemoApplyInvoiceRequestType.items;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (amount == null ? 0 : System.hashCode(amount));
        hashCode = (17 * hashCode) + (invoiceId == null ? 0 : System.hashCode(invoiceId));
        hashCode = (17 * hashCode) + (items == null ? 0 : System.hashCode(items));
        return hashCode;
    }
}