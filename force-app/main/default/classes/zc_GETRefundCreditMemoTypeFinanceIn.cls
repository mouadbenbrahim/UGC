/**
 * Container for the finance information related to the refund.\n
 */
public class zc_GETRefundCreditMemoTypeFinanceIn {
    /**
     * The accounting code that maps to a bank account in your accounting system.\n
     * @return bankAccountAccountingCode
     */
    public String bankAccountAccountingCode { get; set; }

    /**
     * The type of the accounting code that maps to a bank account in your accounting system.\n
     * @return bankAccountAccountingCodeType
     */
    public String bankAccountAccountingCodeType { get; set; }

    /**
     * Whether the refund was transferred to an external accounting system. Use this field for integration with accounting systems, such as NetSuite. \n
     */
    public enum TransferredToAccountingEnum {
        PROCESSING,
        YES,
        NO,
        ERROR,
        IGNORE
    }

    /**
     * Whether the refund was transferred to an external accounting system. Use this field for integration with accounting systems, such as NetSuite. \n
     * @return transferredToAccounting
     */
    public TransferredToAccountingEnum transferredToAccounting { get; set; }

    /**
     * The accounting code for the unapplied payment.\n
     * @return unappliedPaymentAccountingCode
     */
    public String unappliedPaymentAccountingCode { get; set; }

    /**
     * The type of the accounting code for the unapplied payment.\n
     * @return unappliedPaymentAccountingCodeType
     */
    public String unappliedPaymentAccountingCodeType { get; set; }


    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Aaaa' => 'aaa',
        'Bbbb' => 'bbb'
    };

    
    // public static zc_GETRefundCreditMemoTypeFinanceIn getExample() {
    //     zc_GETRefundCreditMemoTypeFinanceIn geTRefundCreditMemoTypeFinanceInformation = new zc_GETRefundCreditMemoTypeFinanceIn();
    //     geTRefundCreditMemoTypeFinanceInformation.bankAccountAccountingCode = 'aeiou';
    //     geTRefundCreditMemoTypeFinanceInformation.bankAccountAccountingCodeType = 'aeiou';
    //     geTRefundCreditMemoTypeFinanceInformation.transferredToAccounting = TransferredToAccountingEnum.PROCESSING;
    //     geTRefundCreditMemoTypeFinanceInformation.unappliedPaymentAccountingCode = 'aeiou';
    //     geTRefundCreditMemoTypeFinanceInformation.unappliedPaymentAccountingCodeType = 'aeiou';
    //     return geTRefundCreditMemoTypeFinanceInformation;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_GETRefundCreditMemoTypeFinanceIn) {
            zc_GETRefundCreditMemoTypeFinanceIn geTRefundCreditMemoTypeFinanceInformation = (zc_GETRefundCreditMemoTypeFinanceIn) obj;
            return this.bankAccountAccountingCode == geTRefundCreditMemoTypeFinanceInformation.bankAccountAccountingCode
                && this.bankAccountAccountingCodeType == geTRefundCreditMemoTypeFinanceInformation.bankAccountAccountingCodeType
                && this.transferredToAccounting == geTRefundCreditMemoTypeFinanceInformation.transferredToAccounting
                && this.unappliedPaymentAccountingCode == geTRefundCreditMemoTypeFinanceInformation.unappliedPaymentAccountingCode
                && this.unappliedPaymentAccountingCodeType == geTRefundCreditMemoTypeFinanceInformation.unappliedPaymentAccountingCodeType;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (bankAccountAccountingCode == null ? 0 : System.hashCode(bankAccountAccountingCode));
        hashCode = (17 * hashCode) + (bankAccountAccountingCodeType == null ? 0 : System.hashCode(bankAccountAccountingCodeType));
        hashCode = (17 * hashCode) + (transferredToAccounting == null ? 0 : System.hashCode(transferredToAccounting));
        hashCode = (17 * hashCode) + (unappliedPaymentAccountingCode == null ? 0 : System.hashCode(unappliedPaymentAccountingCode));
        hashCode = (17 * hashCode) + (unappliedPaymentAccountingCodeType == null ? 0 : System.hashCode(unappliedPaymentAccountingCodeType));
        return hashCode;
    }
}