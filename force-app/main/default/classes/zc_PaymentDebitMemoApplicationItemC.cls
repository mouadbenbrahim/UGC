/**
 * zc_PaymentDebitMemoApplicationItemC
 */
public class zc_PaymentDebitMemoApplicationItemC {
    /**
     * The amount of the payment associated with the specific debit memo or taxation item.\n
     * @return amount
     */
    public Double amount { get; set; }

    /**
     * The ID of the specific debit memo item.\n
     * @return debitMemoItemId
     */
    public String debitMemoItemId { get; set; }

    /**
     * The ID of the specific taxation item.\n
     * @return taxItemId
     */
    public String taxItemId { get; set; }

    // public static zc_PaymentDebitMemoApplicationItemC getExample() {
    //     zc_PaymentDebitMemoApplicationItemC paymentDebitMemoApplicationItemCreateRequestType = new zc_PaymentDebitMemoApplicationItemC();
    //     paymentDebitMemoApplicationItemCreateRequestType.amount = 1.3579;
    //     paymentDebitMemoApplicationItemCreateRequestType.debitMemoItemId = 'aeiou';
    //     paymentDebitMemoApplicationItemCreateRequestType.taxItemId = 'aeiou';
    //     return paymentDebitMemoApplicationItemCreateRequestType;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_PaymentDebitMemoApplicationItemC) {
            zc_PaymentDebitMemoApplicationItemC paymentDebitMemoApplicationItemCreateRequestType = (zc_PaymentDebitMemoApplicationItemC) obj;
            return this.amount == paymentDebitMemoApplicationItemCreateRequestType.amount
                && this.debitMemoItemId == paymentDebitMemoApplicationItemCreateRequestType.debitMemoItemId
                && this.taxItemId == paymentDebitMemoApplicationItemCreateRequestType.taxItemId;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (amount == null ? 0 : System.hashCode(amount));
        hashCode = (17 * hashCode) + (debitMemoItemId == null ? 0 : System.hashCode(debitMemoItemId));
        hashCode = (17 * hashCode) + (taxItemId == null ? 0 : System.hashCode(taxItemId));
        return hashCode;
    }
}