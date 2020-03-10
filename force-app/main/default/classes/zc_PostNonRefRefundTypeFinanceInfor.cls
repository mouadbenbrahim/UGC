/**
 * Container for the finance information related to the refund.\n
 */
public class zc_PostNonRefRefundTypeFinanceInfor {
    /**
     * The accounting code that maps to a bank account in your accounting system.\n
     * @return bankAccountAccountingCode
     */
    public String bankAccountAccountingCode { get; set; }

    /**
     * The accounting code that maps to an on account in your accounting system.\n
     * @return onAccountAccountingCode
     */
    public String onAccountAccountingCode { get; set; }

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


    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Aaaa' => 'aaa',
        'Bbbb' => 'bbb'
    };

    // public static zc_PostNonRefRefundTypeFinanceInfor getExample() {
    //     zc_PostNonRefRefundTypeFinanceInfor postNonRefRefundTypeFinanceInformation = new zc_PostNonRefRefundTypeFinanceInfor();
    //     postNonRefRefundTypeFinanceInformation.bankAccountAccountingCode = 'aeiou';
    //     postNonRefRefundTypeFinanceInformation.onAccountAccountingCode = 'aeiou';
    //     postNonRefRefundTypeFinanceInformation.transferredToAccounting = TransferredToAccountingEnum.PROCESSING;
    //     postNonRefRefundTypeFinanceInformation.unappliedPaymentAccountingCode = 'aeiou';
    //     return postNonRefRefundTypeFinanceInformation;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_PostNonRefRefundTypeFinanceInfor) {
            zc_PostNonRefRefundTypeFinanceInfor postNonRefRefundTypeFinanceInformation = (zc_PostNonRefRefundTypeFinanceInfor) obj;
            return this.bankAccountAccountingCode == postNonRefRefundTypeFinanceInformation.bankAccountAccountingCode
                && this.onAccountAccountingCode == postNonRefRefundTypeFinanceInformation.onAccountAccountingCode
                && this.transferredToAccounting == postNonRefRefundTypeFinanceInformation.transferredToAccounting
                && this.unappliedPaymentAccountingCode == postNonRefRefundTypeFinanceInformation.unappliedPaymentAccountingCode;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (bankAccountAccountingCode == null ? 0 : System.hashCode(bankAccountAccountingCode));
        hashCode = (17 * hashCode) + (onAccountAccountingCode == null ? 0 : System.hashCode(onAccountAccountingCode));
        hashCode = (17 * hashCode) + (transferredToAccounting == null ? 0 : System.hashCode(transferredToAccounting));
        hashCode = (17 * hashCode) + (unappliedPaymentAccountingCode == null ? 0 : System.hashCode(unappliedPaymentAccountingCode));
        return hashCode;
    }
}