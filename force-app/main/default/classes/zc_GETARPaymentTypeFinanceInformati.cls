/**
 * Container for the finance information related to the payment.\n
 */
public class zc_GETARPaymentTypeFinanceInformati {
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

    /**
     * The type of the accounting code for the unapplied payment.\n
     * @return unappliedPaymentAccountingCodeType
     */
    public String unappliedPaymentAccountingCodeType { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'aa' => 'aa'
    };

    // public static zc_GETARPaymentTypeFinanceInformati getExample() {
    //     zc_GETARPaymentTypeFinanceInformati geTARPaymentTypeFinanceInformation = new zc_GETARPaymentTypeFinanceInformati();
    //     geTARPaymentTypeFinanceInformation.bankAccountAccountingCode = 'aeiou';
    //     geTARPaymentTypeFinanceInformation.bankAccountAccountingCodeType = 'aeiou';
    //     geTARPaymentTypeFinanceInformation.transferredToAccounting = TransferredToAccountingEnum.PROCESSING;
    //     geTARPaymentTypeFinanceInformation.unappliedPaymentAccountingCode = 'aeiou';
    //     geTARPaymentTypeFinanceInformation.unappliedPaymentAccountingCodeType = 'aeiou';
    //     return geTARPaymentTypeFinanceInformation;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_GETARPaymentTypeFinanceInformati) {
            zc_GETARPaymentTypeFinanceInformati geTARPaymentTypeFinanceInformation = (zc_GETARPaymentTypeFinanceInformati) obj;
            return this.bankAccountAccountingCode == geTARPaymentTypeFinanceInformation.bankAccountAccountingCode
                && this.bankAccountAccountingCodeType == geTARPaymentTypeFinanceInformation.bankAccountAccountingCodeType
                && this.transferredToAccounting == geTARPaymentTypeFinanceInformation.transferredToAccounting
                && this.unappliedPaymentAccountingCode == geTARPaymentTypeFinanceInformation.unappliedPaymentAccountingCode
                && this.unappliedPaymentAccountingCodeType == geTARPaymentTypeFinanceInformation.unappliedPaymentAccountingCodeType;
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