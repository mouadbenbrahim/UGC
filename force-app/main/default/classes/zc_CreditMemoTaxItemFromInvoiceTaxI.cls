/**
 * Container for the finance information related to the source taxation item.\n
 */
public class zc_CreditMemoTaxItemFromInvoiceTaxI {
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

    // public static zc_CreditMemoTaxItemFromInvoiceTaxI getExample() {
    //     zc_CreditMemoTaxItemFromInvoiceTaxI creditMemoTaxItemFromInvoiceTaxItemTypeFinanceInformation = new zc_CreditMemoTaxItemFromInvoiceTaxI();
    //     creditMemoTaxItemFromInvoiceTaxItemTypeFinanceInformation.onAccountAccountingCode = 'aeiou';
    //     creditMemoTaxItemFromInvoiceTaxItemTypeFinanceInformation.salesTaxPayableAccountingCode = 'aeiou';
    //     return creditMemoTaxItemFromInvoiceTaxItemTypeFinanceInformation;
    // }
    
    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Aaaa' => 'aaa',
        'Bbbb' => 'bbb'
    };

    public Boolean equals(Object obj) {
        if (obj instanceof zc_CreditMemoTaxItemFromInvoiceTaxI) {
            zc_CreditMemoTaxItemFromInvoiceTaxI creditMemoTaxItemFromInvoiceTaxItemTypeFinanceInformation = (zc_CreditMemoTaxItemFromInvoiceTaxI) obj;
            return this.onAccountAccountingCode == creditMemoTaxItemFromInvoiceTaxItemTypeFinanceInformation.onAccountAccountingCode
                && this.salesTaxPayableAccountingCode == creditMemoTaxItemFromInvoiceTaxItemTypeFinanceInformation.salesTaxPayableAccountingCode;
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