/**
 * zc_CreditMemoApplyDebitMemoRequestT
 */
public class zc_CreditMemoApplyDebitMemoRequestT {
    /**
     * The credit memo amount to be applied to the debit memo.\n
     * @return amount
     */
    public Double amount { get; set; }

    /**
     * The unique ID of the debit memo that the credit memo is applied to.\n
     * @return debitMemoId
     */
    public String debitMemoId { get; set; }

    /**
     * Container for items.\n
     * @return items
     */
    public List<zc_CreditMemoApplyDebitMemoItemRequ> items { get; set; }

    public zc_CreditMemoApplyDebitMemoRequestT() {
        items = new List<zc_CreditMemoApplyDebitMemoItemRequ>();
    }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Aaaa' => 'aaa'
    };

    
    // public static zc_CreditMemoApplyDebitMemoRequestT getExample() {
    //     zc_CreditMemoApplyDebitMemoRequestT creditMemoApplyDebitMemoRequestType = new zc_CreditMemoApplyDebitMemoRequestT();
    //     creditMemoApplyDebitMemoRequestType.amount = 1.3579;
    //     creditMemoApplyDebitMemoRequestType.debitMemoId = 'aeiou';
    //     creditMemoApplyDebitMemoRequestType.items = new List<zc_CreditMemoApplyDebitMemoItemRequ>{zc_CreditMemoApplyDebitMemoItemRequ.getExample()};
    //     return creditMemoApplyDebitMemoRequestType;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_CreditMemoApplyDebitMemoRequestT) {
            zc_CreditMemoApplyDebitMemoRequestT creditMemoApplyDebitMemoRequestType = (zc_CreditMemoApplyDebitMemoRequestT) obj;
            return this.amount == creditMemoApplyDebitMemoRequestType.amount
                && this.debitMemoId == creditMemoApplyDebitMemoRequestType.debitMemoId
                && this.items == creditMemoApplyDebitMemoRequestType.items;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (amount == null ? 0 : System.hashCode(amount));
        hashCode = (17 * hashCode) + (debitMemoId == null ? 0 : System.hashCode(debitMemoId));
        hashCode = (17 * hashCode) + (items == null ? 0 : System.hashCode(items));
        return hashCode;
    }
}