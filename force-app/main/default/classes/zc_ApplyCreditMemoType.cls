/**
 * zc_ApplyCreditMemoType
 */
public class zc_ApplyCreditMemoType {
    /**
     * Container for debit memos that the credit memo is applied to.\n
     * @return debitMemos
     */
    public List<zc_CreditMemoApplyDebitMemoRequestT> debitMemos { get; set; }

    /**
     * The date when the credit memo is applied.\n
     * @return effectiveDate
     */
    public Date effectiveDate { get; set; }

    /**
     * Container for invoices that the credit memo is applied to.\n
     * @return invoices
     */
    public List<zc_CreditMemoApplyInvoiceRequestTyp> invoices { get; set; }

    public zc_ApplyCreditMemoType() {
        debitMemos = new List<zc_CreditMemoApplyDebitMemoRequestT>();
        invoices = new List<zc_CreditMemoApplyInvoiceRequestTyp>();
    }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Aaaa' => 'aaa'
    };

    // public static zc_ApplyCreditMemoType getExample() {
    //     zc_ApplyCreditMemoType applyCreditMemoType = new zc_ApplyCreditMemoType();
    //     applyCreditMemoType.debitMemos = new List<zc_CreditMemoApplyDebitMemoRequestT>{zc_CreditMemoApplyDebitMemoRequestT.getExample()};
    //     applyCreditMemoType.effectiveDate = Date.newInstance(2000, 1, 23);
    //     applyCreditMemoType.invoices = new List<zc_CreditMemoApplyInvoiceRequestTyp>{zc_CreditMemoApplyInvoiceRequestTyp.getExample()};
    //     return applyCreditMemoType;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_ApplyCreditMemoType) {
            zc_ApplyCreditMemoType applyCreditMemoType = (zc_ApplyCreditMemoType) obj;
            return this.debitMemos == applyCreditMemoType.debitMemos
                && this.effectiveDate == applyCreditMemoType.effectiveDate
                && this.invoices == applyCreditMemoType.invoices;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (debitMemos == null ? 0 : System.hashCode(debitMemos));
        hashCode = (17 * hashCode) + (effectiveDate == null ? 0 : System.hashCode(effectiveDate));
        hashCode = (17 * hashCode) + (invoices == null ? 0 : System.hashCode(invoices));
        return hashCode;
    }
}