/**
 * Container for billing and payment information for the account.\n
 */
public class zc_GETAccountTypeBillingAndPayment {
    /**
     * A list of additional email addresses to receive emailed invoices.\n
     * @return additionalEmailAddresses
     */
    public List<String> additionalEmailAddresses { get; set; }

    /**
     * Billing cycle day (BCD), the day of the month when a bill run generates invoices for the account.\n
     * @return billCycleDay
     */
    public String billCycleDay { get; set; }

    /**
     * A currency2 defined in the web-based UI administrative settings.\n
     * @return currency2
     */
    public String currency2 { get; set; }

    /**
     * Whether the customer wants to receive invoices through email. \n
     * @return invoiceDeliveryPrefsEmail
     */
    public Boolean invoiceDeliveryPrefsEmail { get; set; }

    /**
     * Whether the customer wants to receive printed invoices, such as through postal mail.\n
     * @return invoiceDeliveryPrefsPrint
     */
    public Boolean invoiceDeliveryPrefsPrint { get; set; }

    /**
     * The name of the payment gateway instance. If null or left unassigned, the Account will use the Default Gateway.\n
     * @return paymentGateway
     */
    public String paymentGateway { get; set; }

    /**
     * A payment-terms indicator defined in the web-based UI administrative settings, e.g., "Net 30".\n
     * @return paymentTerm
     */
    public String paymentTerm { get; set; }

    public zc_GETAccountTypeBillingAndPayment() {
        additionalEmailAddresses = new List<String>();
    }

    private static final Map<String, String> propertyMappings = new Map<String, String>{
        'currency' => 'currency2'
    };

    // public static zc_GETAccountTypeBillingAndPayment getExample() {
    //     zc_GETAccountTypeBillingAndPayment geTAccountTypeBillingAndPayment = new zc_GETAccountTypeBillingAndPayment();
    //     geTAccountTypeBillingAndPayment.additionalEmailAddresses = new List<String>{'aeiou'};
    //     geTAccountTypeBillingAndPayment.billCycleDay = 'aeiou';
    //     geTAccountTypeBillingAndPayment.currency2 = 'aeiou';
    //     geTAccountTypeBillingAndPayment.invoiceDeliveryPrefsEmail = true;
    //     geTAccountTypeBillingAndPayment.invoiceDeliveryPrefsPrint = true;
    //     geTAccountTypeBillingAndPayment.paymentGateway = 'aeiou';
    //     geTAccountTypeBillingAndPayment.paymentTerm = 'aeiou';
    //     return geTAccountTypeBillingAndPayment;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_GETAccountTypeBillingAndPayment) {
            zc_GETAccountTypeBillingAndPayment geTAccountTypeBillingAndPayment = (zc_GETAccountTypeBillingAndPayment) obj;
            return this.additionalEmailAddresses == geTAccountTypeBillingAndPayment.additionalEmailAddresses
                && this.billCycleDay == geTAccountTypeBillingAndPayment.billCycleDay
                && this.currency2 == geTAccountTypeBillingAndPayment.currency2
                && this.invoiceDeliveryPrefsEmail == geTAccountTypeBillingAndPayment.invoiceDeliveryPrefsEmail
                && this.invoiceDeliveryPrefsPrint == geTAccountTypeBillingAndPayment.invoiceDeliveryPrefsPrint
                && this.paymentGateway == geTAccountTypeBillingAndPayment.paymentGateway
                && this.paymentTerm == geTAccountTypeBillingAndPayment.paymentTerm;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (additionalEmailAddresses == null ? 0 : System.hashCode(additionalEmailAddresses));
        hashCode = (17 * hashCode) + (billCycleDay == null ? 0 : System.hashCode(billCycleDay));
        hashCode = (17 * hashCode) + (currency2 == null ? 0 : System.hashCode(currency2));
        hashCode = (17 * hashCode) + (invoiceDeliveryPrefsEmail == null ? 0 : System.hashCode(invoiceDeliveryPrefsEmail));
        hashCode = (17 * hashCode) + (invoiceDeliveryPrefsPrint == null ? 0 : System.hashCode(invoiceDeliveryPrefsPrint));
        hashCode = (17 * hashCode) + (paymentGateway == null ? 0 : System.hashCode(paymentGateway));
        hashCode = (17 * hashCode) + (paymentTerm == null ? 0 : System.hashCode(paymentTerm));
        return hashCode;
    }
}