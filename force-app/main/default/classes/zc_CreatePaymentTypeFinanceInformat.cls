/**
 * Container for the finance information related to the payment.\n
 */
public class zc_CreatePaymentTypeFinanceInformat {
    /**
     * The accounting code that maps to a bank account in your accounting system.\n
     * @return bankAccountAccountingCode
     */
    public String bankAccountAccountingCode { get; set; }

    /**
     * Whether the payment was transferred to an external accounting system. Use this field for integration with accounting systems, such as NetSuite. \n
     */
    public enum TransferredToAccountingEnum {
        PROCESSING,
        YES,
        NO,
        ERROR,
        IGNORE
    }

    /**
     * Whether the payment was transferred to an external accounting system. Use this field for integration with accounting systems, such as NetSuite. \n
     * @return transferredToAccounting
     */
    public TransferredToAccountingEnum transferredToAccounting { get; set; }

    /**
     * The accounting code for the unapplied payment.\n
     * @return unappliedPaymentAccountingCode
     */
    public String unappliedPaymentAccountingCode { get; set; }

    // public static zc_CreatePaymentTypeFinanceInformat getExample() {
    //     zc_CreatePaymentTypeFinanceInformat createPaymentTypeFinanceInformation = new zc_CreatePaymentTypeFinanceInformat();
    //     createPaymentTypeFinanceInformation.bankAccountAccountingCode = 'aeiou';
    //     createPaymentTypeFinanceInformation.transferredToAccounting = TransferredToAccountingEnum.PROCESSING;
    //     createPaymentTypeFinanceInformation.unappliedPaymentAccountingCode = 'aeiou';
    //     return createPaymentTypeFinanceInformation;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_CreatePaymentTypeFinanceInformat) {
            zc_CreatePaymentTypeFinanceInformat createPaymentTypeFinanceInformation = (zc_CreatePaymentTypeFinanceInformat) obj;
            return this.bankAccountAccountingCode == createPaymentTypeFinanceInformation.bankAccountAccountingCode
                && this.transferredToAccounting == createPaymentTypeFinanceInformation.transferredToAccounting
                && this.unappliedPaymentAccountingCode == createPaymentTypeFinanceInformation.unappliedPaymentAccountingCode;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (bankAccountAccountingCode == null ? 0 : System.hashCode(bankAccountAccountingCode));
        hashCode = (17 * hashCode) + (transferredToAccounting == null ? 0 : System.hashCode(transferredToAccounting));
        hashCode = (17 * hashCode) + (unappliedPaymentAccountingCode == null ? 0 : System.hashCode(unappliedPaymentAccountingCode));
        return hashCode;
    }
}