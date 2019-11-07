/**
 * Container for account metrics.\n
 */
public class zc_GETAccountTypeMetrics {
    /**
     * The customer\'s total invoice balance minus credit balance.\n
     * @return balance
     */
    public String balance { get; set; }

    /**
     * Future expected MRR that accounts for future upgrades, downgrades, upsells and cancellations.\n
     * @return contractedMrr
     */
    public String contractedMrr { get; set; }

    /**
     * Current credit balance.\n
     * @return creditBalance
     */
    public String creditBalance { get; set; }

    /**
     * **Note**: This field is only available if you have the Invoice Settlement feature enabled. The Invoice Settlement feature is in **Limited Availability**. If you wish to have access to the feature, submit a request at [Zuora Global Support](http://support.zuora.com/).\n\nTotal balance of all posted debit memos.\n
     * @return totalDebitMemoBalance
     */
    public String totalDebitMemoBalance { get; set; }

    /**
     * Total balance of all posted invoices.\n
     * @return totalInvoiceBalance
     */
    public String totalInvoiceBalance { get; set; }

    /**
     * **Note**: This field is only available if you have the Invoice Settlement feature enabled. The Invoice Settlement feature is in **Limited Availability**. If you wish to have access to the feature, submit a request at [Zuora Global Support](http://support.zuora.com/).\n\nTotal unapplied amount of all posted credit memos.\n
     * @return unappliedCreditMemoAmount
     */
    public String unappliedCreditMemoAmount { get; set; }

    /**
     * **Note**: This field is only available if you have the Invoice Settlement feature enabled. The Invoice Settlement feature is in **Limited Availability**. If you wish to have access to the feature, submit a request at [Zuora Global Support](http://support.zuora.com/).\n\nTotal unapplied amount of all posted payments.\n
     * @return unappliedPaymentAmount
     */
    public String unappliedPaymentAmount { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Aaaa' => 'aaa',
        'Bbbb' => 'bbb'
    };

    // public static zc_GETAccountTypeMetrics getExample() {
    //     zc_GETAccountTypeMetrics geTAccountTypeMetrics = new zc_GETAccountTypeMetrics();
    //     geTAccountTypeMetrics.balance = 'aeiou';
    //     geTAccountTypeMetrics.contractedMrr = 'aeiou';
    //     geTAccountTypeMetrics.creditBalance = 'aeiou';
    //     geTAccountTypeMetrics.totalDebitMemoBalance = 'aeiou';
    //     geTAccountTypeMetrics.totalInvoiceBalance = 'aeiou';
    //     geTAccountTypeMetrics.unappliedCreditMemoAmount = 'aeiou';
    //     geTAccountTypeMetrics.unappliedPaymentAmount = 'aeiou';
    //     return geTAccountTypeMetrics;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_GETAccountTypeMetrics) {
            zc_GETAccountTypeMetrics geTAccountTypeMetrics = (zc_GETAccountTypeMetrics) obj;
            return this.balance == geTAccountTypeMetrics.balance
                && this.contractedMrr == geTAccountTypeMetrics.contractedMrr
                && this.creditBalance == geTAccountTypeMetrics.creditBalance
                && this.totalDebitMemoBalance == geTAccountTypeMetrics.totalDebitMemoBalance
                && this.totalInvoiceBalance == geTAccountTypeMetrics.totalInvoiceBalance
                && this.unappliedCreditMemoAmount == geTAccountTypeMetrics.unappliedCreditMemoAmount
                && this.unappliedPaymentAmount == geTAccountTypeMetrics.unappliedPaymentAmount;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (balance == null ? 0 : System.hashCode(balance));
        hashCode = (17 * hashCode) + (contractedMrr == null ? 0 : System.hashCode(contractedMrr));
        hashCode = (17 * hashCode) + (creditBalance == null ? 0 : System.hashCode(creditBalance));
        hashCode = (17 * hashCode) + (totalDebitMemoBalance == null ? 0 : System.hashCode(totalDebitMemoBalance));
        hashCode = (17 * hashCode) + (totalInvoiceBalance == null ? 0 : System.hashCode(totalInvoiceBalance));
        hashCode = (17 * hashCode) + (unappliedCreditMemoAmount == null ? 0 : System.hashCode(unappliedCreditMemoAmount));
        hashCode = (17 * hashCode) + (unappliedPaymentAmount == null ? 0 : System.hashCode(unappliedPaymentAmount));
        return hashCode;
    }
}