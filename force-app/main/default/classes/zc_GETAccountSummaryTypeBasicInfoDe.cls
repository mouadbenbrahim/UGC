/**
 * 
 */
public class zc_GETAccountSummaryTypeBasicInfoDe {
    /**
     * Two-digit numeric card expiration month as `mm`.\n
     * @return creditCardExpirationMonth
     */
    public String creditCardExpirationMonth { get; set; }

    /**
     * Four-digit card expiration year as `yyyy`.\n
     * @return creditCardExpirationYear
     */
    public String creditCardExpirationYear { get; set; }

    /**
     * Credit card number, 16 characters or less, displayed in masked format (e.g., ************1234).\n
     * @return creditCardNumber
     */
    public String creditCardNumber { get; set; }

    /**
     * The type of the credit card.\n\nPossible values  include `Visa`, `MasterCard`, `AmericanExpress`, `Discover`, `JCB`, and `Diners`. For more information about credit card types supported by different payment gateways, see [Supported Payment Gateways](https://knowledgecenter.zuora.com/CB_Billing/M_Payment_Gateways/Supported_Payment_Gateways).\n
     * @return creditCardType
     */
    public String creditCardType { get; set; }

    /**
     * The ID of the credit card payment method associated with this account.\n
     * @return id
     */
    public String id { get; set; }

    /**
     * 
     * @return paymentMethodType
     */
    public String paymentMethodType { get; set; }

    // public static zc_GETAccountSummaryTypeBasicInfoDe getExample() {
    //     zc_GETAccountSummaryTypeBasicInfoDe geTAccountSummaryTypeBasicInfoDefaultPaymentMethod = new zc_GETAccountSummaryTypeBasicInfoDe();
    //     geTAccountSummaryTypeBasicInfoDefaultPaymentMethod.creditCardExpirationMonth = 'aeiou';
    //     geTAccountSummaryTypeBasicInfoDefaultPaymentMethod.creditCardExpirationYear = 'aeiou';
    //     geTAccountSummaryTypeBasicInfoDefaultPaymentMethod.creditCardNumber = 'aeiou';
    //     geTAccountSummaryTypeBasicInfoDefaultPaymentMethod.creditCardType = 'aeiou';
    //     geTAccountSummaryTypeBasicInfoDefaultPaymentMethod.id = 'aeiou';
    //     geTAccountSummaryTypeBasicInfoDefaultPaymentMethod.paymentMethodType = 'aeiou';
    //     return geTAccountSummaryTypeBasicInfoDefaultPaymentMethod;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_GETAccountSummaryTypeBasicInfoDe) {
            zc_GETAccountSummaryTypeBasicInfoDe geTAccountSummaryTypeBasicInfoDefaultPaymentMethod = (zc_GETAccountSummaryTypeBasicInfoDe) obj;
            return this.creditCardExpirationMonth == geTAccountSummaryTypeBasicInfoDefaultPaymentMethod.creditCardExpirationMonth
                && this.creditCardExpirationYear == geTAccountSummaryTypeBasicInfoDefaultPaymentMethod.creditCardExpirationYear
                && this.creditCardNumber == geTAccountSummaryTypeBasicInfoDefaultPaymentMethod.creditCardNumber
                && this.creditCardType == geTAccountSummaryTypeBasicInfoDefaultPaymentMethod.creditCardType
                && this.id == geTAccountSummaryTypeBasicInfoDefaultPaymentMethod.id
                && this.paymentMethodType == geTAccountSummaryTypeBasicInfoDefaultPaymentMethod.paymentMethodType;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (creditCardExpirationMonth == null ? 0 : System.hashCode(creditCardExpirationMonth));
        hashCode = (17 * hashCode) + (creditCardExpirationYear == null ? 0 : System.hashCode(creditCardExpirationYear));
        hashCode = (17 * hashCode) + (creditCardNumber == null ? 0 : System.hashCode(creditCardNumber));
        hashCode = (17 * hashCode) + (creditCardType == null ? 0 : System.hashCode(creditCardType));
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
        hashCode = (17 * hashCode) + (paymentMethodType == null ? 0 : System.hashCode(paymentMethodType));
        return hashCode;
    }
}