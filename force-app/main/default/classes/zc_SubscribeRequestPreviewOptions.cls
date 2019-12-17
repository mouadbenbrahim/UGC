/**
 * Only used if you want to call this operation in preview mode. After a call in preview mode is completed, Zuora will roll back the subscription and return only the temporary invoice data.\n
 */
public class zc_SubscribeRequestPreviewOptions {
    /**
     * Specifies whether the call should create a subscription/amendment, or whether it should return a preview of the order. Used with either NumberOfPeriods or PreviewThroughTermEnd. \n\nIf the preview mode is enabled, Zuora recommends that you set the `subscribes` > `SubscribeOptions` > `ProcessPayments` field to `false` and skip setting the `subscribes` > `PaymentMethod` field in your request so that no charge occurs for payment method validation in a preview.\n
     * @return enablePreviewMode
     */
    public Boolean enablePreviewMode { get; set; }

    /**
     * The number of invoice periods to show in a preview.\n
     * @return numberOfPeriods
     */
    public Integer numberOfPeriods { get; set; }

    /**
     * Specifies whether to preview the charge through the end of the subscription term. Applicable to termed subscriptions only.\n
     * @return previewThroughTermEnd
     */
    public Boolean previewThroughTermEnd { get; set; }

    /**
     * The type of preview to return:\n\n * `InvoiceItem` - Return an invoice item preview\n * `ChargeMetrics` - Return a charge metrics preview\n * `InvoiceItemChargeMetrics` - Return an invoice item and charge metrics of that item\n
     */
    public enum PreviewTypeEnum {
        INVOICEITEM,
        CHARGEMETRICS,
        INVOICEITEMCHARGEMETRICS
    }

    /**
     * The type of preview to return:\n\n * `InvoiceItem` - Return an invoice item preview\n * `ChargeMetrics` - Return a charge metrics preview\n * `InvoiceItemChargeMetrics` - Return an invoice item and charge metrics of that item\n
     * @return previewType
     */
    public PreviewTypeEnum previewType { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'EnablePreviewMode' => 'enablePreviewMode',
        'NumberOfPeriods' => 'numberOfPeriods',
        'PreviewThroughTermEnd' => 'previewThroughTermEnd',
        'PreviewType' => 'previewType'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public zc_SubscribeRequestPreviewOptions() {
        previewType = PreviewTypeEnum.INVOICEITEM;
    }

    // public static zc_SubscribeRequestPreviewOptions getExample() {
    //     zc_SubscribeRequestPreviewOptions subscribeRequestPreviewOptions = new zc_SubscribeRequestPreviewOptions();
    //     subscribeRequestPreviewOptions.enablePreviewMode = true;
    //     subscribeRequestPreviewOptions.numberOfPeriods = 123;
    //     subscribeRequestPreviewOptions.previewThroughTermEnd = true;
    //     subscribeRequestPreviewOptions.previewType = PreviewTypeEnum.INVOICEITEM;
    //     return subscribeRequestPreviewOptions;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_SubscribeRequestPreviewOptions) {
            zc_SubscribeRequestPreviewOptions subscribeRequestPreviewOptions = (zc_SubscribeRequestPreviewOptions) obj;
            return this.enablePreviewMode == subscribeRequestPreviewOptions.enablePreviewMode
                && this.numberOfPeriods == subscribeRequestPreviewOptions.numberOfPeriods
                && this.previewThroughTermEnd == subscribeRequestPreviewOptions.previewThroughTermEnd
                && this.previewType == subscribeRequestPreviewOptions.previewType;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (enablePreviewMode == null ? 0 : System.hashCode(enablePreviewMode));
        hashCode = (17 * hashCode) + (numberOfPeriods == null ? 0 : System.hashCode(numberOfPeriods));
        hashCode = (17 * hashCode) + (previewThroughTermEnd == null ? 0 : System.hashCode(previewThroughTermEnd));
        hashCode = (17 * hashCode) + (previewType == null ? 0 : System.hashCode(previewType));
        return hashCode;
    }
}