/**
 * zc_PaymentDebitMemoApplicationCreat
 */
public class zc_PaymentDebitMemoApplicationCreat {
    /**
     * The amount of the payment associated with the debit memo.\n
     * @return amount
     */
    public Double amount { get; set; }

    /**
     * The unique ID of the debit memo that the payment is created on.\n
     * @return debitMemoId
     */
    public String debitMemoId { get; set; }

    /**
     * Container for debit memo items.\n\n**Note:** The Invoice Item Settlement feature is in **Limited Availability**. If you wish to have access to the feature, submit a request at [Zuora Global Support](http://support.zuora.com/).\n
     * @return items
     */
    public List<zc_PaymentDebitMemoApplicationItemC> items { get; set; }

    public zc_PaymentDebitMemoApplicationCreat() {
        items = new List<zc_PaymentDebitMemoApplicationItemC>();
    }

    // public static zc_PaymentDebitMemoApplicationCreat getExample() {
    //     zc_PaymentDebitMemoApplicationCreat paymentDebitMemoApplicationCreateRequestType = new zc_PaymentDebitMemoApplicationCreat();
    //     paymentDebitMemoApplicationCreateRequestType.amount = 1.3579;
    //     paymentDebitMemoApplicationCreateRequestType.debitMemoId = 'aeiou';
    //     paymentDebitMemoApplicationCreateRequestType.items = new List<zc_PaymentDebitMemoApplicationItemC>{zc_PaymentDebitMemoApplicationItemC.getExample()};
    //     return paymentDebitMemoApplicationCreateRequestType;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_PaymentDebitMemoApplicationCreat) {
            zc_PaymentDebitMemoApplicationCreat paymentDebitMemoApplicationCreateRequestType = (zc_PaymentDebitMemoApplicationCreat) obj;
            return this.amount == paymentDebitMemoApplicationCreateRequestType.amount
                && this.debitMemoId == paymentDebitMemoApplicationCreateRequestType.debitMemoId
                && this.items == paymentDebitMemoApplicationCreateRequestType.items;
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