/**
 * zc_CreditMemoApplyDebitMemoItemRequ
 */
public class zc_CreditMemoApplyDebitMemoItemRequ {
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
     * The ID of the debit memo item that the credit memo item is applied to.\n
     * @return debitMemoItemId
     */
    public String debitMemoItemId { get; set; }

    /**
     * The ID of the debit memo taxation item that the credit memo taxation item is applied to.\n
     * @return taxItemId
     */
    public String taxItemId { get; set; }


    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Aaaa' => 'aaa'
    };
    
    // public static zc_CreditMemoApplyDebitMemoItemRequ getExample() {
    //     zc_CreditMemoApplyDebitMemoItemRequ creditMemoApplyDebitMemoItemRequestType = new zc_CreditMemoApplyDebitMemoItemRequ();
    //     creditMemoApplyDebitMemoItemRequestType.amount = 1.3579;
    //     creditMemoApplyDebitMemoItemRequestType.creditMemoItemId = 'aeiou';
    //     creditMemoApplyDebitMemoItemRequestType.creditTaxItemId = 'aeiou';
    //     creditMemoApplyDebitMemoItemRequestType.debitMemoItemId = 'aeiou';
    //     creditMemoApplyDebitMemoItemRequestType.taxItemId = 'aeiou';
    //     return creditMemoApplyDebitMemoItemRequestType;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_CreditMemoApplyDebitMemoItemRequ) {
            zc_CreditMemoApplyDebitMemoItemRequ creditMemoApplyDebitMemoItemRequestType = (zc_CreditMemoApplyDebitMemoItemRequ) obj;
            return this.amount == creditMemoApplyDebitMemoItemRequestType.amount
                && this.creditMemoItemId == creditMemoApplyDebitMemoItemRequestType.creditMemoItemId
                && this.creditTaxItemId == creditMemoApplyDebitMemoItemRequestType.creditTaxItemId
                && this.debitMemoItemId == creditMemoApplyDebitMemoItemRequestType.debitMemoItemId
                && this.taxItemId == creditMemoApplyDebitMemoItemRequestType.taxItemId;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (amount == null ? 0 : System.hashCode(amount));
        hashCode = (17 * hashCode) + (creditMemoItemId == null ? 0 : System.hashCode(creditMemoItemId));
        hashCode = (17 * hashCode) + (creditTaxItemId == null ? 0 : System.hashCode(creditTaxItemId));
        hashCode = (17 * hashCode) + (debitMemoItemId == null ? 0 : System.hashCode(debitMemoItemId));
        hashCode = (17 * hashCode) + (taxItemId == null ? 0 : System.hashCode(taxItemId));
        return hashCode;
    }
}