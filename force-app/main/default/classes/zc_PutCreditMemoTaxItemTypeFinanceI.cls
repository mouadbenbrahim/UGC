/**
 * Container for the finance information related to the taxation item in the credit memo item.\n
 */
public class zc_PutCreditMemoTaxItemTypeFinanceI {
    /**
     * The accounting code that maps to an on account in your accounting system.\n
     * @return onAccountAccountingCode
     */
    public String onAccountAccountingCode { get; set; }

    /**
     * The accounting code for the sales taxes payable.\n
     * @return salesTaxPayableAccountingCode
     */
    public String salesTaxPayableAccountingCode { get; set; }

    
    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Aaaa' => 'aaaa',
        'Bbbb' => 'bbbb'

    };

    // public static zc_PutCreditMemoTaxItemTypeFinanceI getExample() {
    //     zc_PutCreditMemoTaxItemTypeFinanceI putCreditMemoTaxItemTypeFinanceInformation = new zc_PutCreditMemoTaxItemTypeFinanceI();
    //     putCreditMemoTaxItemTypeFinanceInformation.onAccountAccountingCode = 'aeiou';
    //     putCreditMemoTaxItemTypeFinanceInformation.salesTaxPayableAccountingCode = 'aeiou';
    //     return putCreditMemoTaxItemTypeFinanceInformation;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_PutCreditMemoTaxItemTypeFinanceI) {
            zc_PutCreditMemoTaxItemTypeFinanceI putCreditMemoTaxItemTypeFinanceInformation = (zc_PutCreditMemoTaxItemTypeFinanceI) obj;
            return this.onAccountAccountingCode == putCreditMemoTaxItemTypeFinanceInformation.onAccountAccountingCode
                && this.salesTaxPayableAccountingCode == putCreditMemoTaxItemTypeFinanceInformation.salesTaxPayableAccountingCode;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (onAccountAccountingCode == null ? 0 : System.hashCode(onAccountAccountingCode));
        hashCode = (17 * hashCode) + (salesTaxPayableAccountingCode == null ? 0 : System.hashCode(salesTaxPayableAccountingCode));
        return hashCode;
    }
}