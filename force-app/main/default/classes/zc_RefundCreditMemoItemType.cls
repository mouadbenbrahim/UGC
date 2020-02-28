/**
 * zc_RefundCreditMemoItemType
 */
public class zc_RefundCreditMemoItemType {
    /**
     * The amount of the refund on the specific item.\n
     * @return amount
     */
    public Double amount { get; set; }

    /**
     * The ID of the credit memo item that is refunded.\n
     * @return creditMemoItemId
     */
    public String creditMemoItemId { get; set; }

    /**
     * The ID of the credit memo taxation item that is refunded.\n
     * @return creditTaxItemId
     */
    public String creditTaxItemId { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Aaaa' => 'aaa',
        'Bbbb' => 'bbb'
    };
    
    // public static zc_RefundCreditMemoItemType getExample() {
    //     zc_RefundCreditMemoItemType refundCreditMemoItemType = new zc_RefundCreditMemoItemType();
    //     refundCreditMemoItemType.amount = 1.3579;
    //     refundCreditMemoItemType.creditMemoItemId = 'aeiou';
    //     refundCreditMemoItemType.creditTaxItemId = 'aeiou';
    //     return refundCreditMemoItemType;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_RefundCreditMemoItemType) {
            zc_RefundCreditMemoItemType refundCreditMemoItemType = (zc_RefundCreditMemoItemType) obj;
            return this.amount == refundCreditMemoItemType.amount
                && this.creditMemoItemId == refundCreditMemoItemType.creditMemoItemId
                && this.creditTaxItemId == refundCreditMemoItemType.creditTaxItemId;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (amount == null ? 0 : System.hashCode(amount));
        hashCode = (17 * hashCode) + (creditMemoItemId == null ? 0 : System.hashCode(creditMemoItemId));
        hashCode = (17 * hashCode) + (creditTaxItemId == null ? 0 : System.hashCode(creditTaxItemId));
        return hashCode;
    }
}