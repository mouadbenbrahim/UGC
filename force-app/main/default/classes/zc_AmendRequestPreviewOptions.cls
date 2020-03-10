public class zc_AmendRequestPreviewOptions implements zc_Zuc.MappedProperties {
    /**
     *  Determines whether to create an amendment or display a preview of the change.
     * @return enablePreviewMode
     */
    public Boolean enablePreviewMode { get; set; }

    /**
     *  Specifies whether to include draft invoice items in amendment previews.
     * @return includeExistingDraftInvoiceItems
     */
    public Boolean includeExistingDraftInvoiceItems { get; set; }

    /**
     *  Indicates the number of invoice periods to show in a preview.
     * @return numberOfPeriods
     */
    public Integer numberOfPeriods { get; set; }

    /**
     *  Request to preview the charge through the end of the subscription term.
     * @return previewThroughTermEnd
     */
    public Boolean previewThroughTermEnd { get; set; }

    /**
     *  The type of preview you will receive from a preview request.
     * @return previewType
     */
    public String previewType { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'EnablePreviewMode' => 'enablePreviewMode',
        'IncludeExistingDraftInvoiceItems' => 'includeExistingDraftInvoiceItems',
        'NumberOfPeriods' => 'numberOfPeriods',
        'PreviewThroughTermEnd' => 'previewThroughTermEnd',
        'PreviewType' => 'previewType'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public static zc_AmendRequestPreviewOptions getExample() {
        zc_AmendRequestPreviewOptions amendRequestPreviewOptions = new zc_AmendRequestPreviewOptions();
        amendRequestPreviewOptions.enablePreviewMode = true;
        amendRequestPreviewOptions.includeExistingDraftInvoiceItems = true;
        amendRequestPreviewOptions.numberOfPeriods = 123;
        amendRequestPreviewOptions.previewThroughTermEnd = true;
        amendRequestPreviewOptions.previewType = 'aeiou';
        return amendRequestPreviewOptions;
    }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_AmendRequestPreviewOptions) {
            zc_AmendRequestPreviewOptions amendRequestPreviewOptions = (zc_AmendRequestPreviewOptions) obj;
            return this.enablePreviewMode == amendRequestPreviewOptions.enablePreviewMode
                && this.includeExistingDraftInvoiceItems == amendRequestPreviewOptions.includeExistingDraftInvoiceItems
                && this.numberOfPeriods == amendRequestPreviewOptions.numberOfPeriods
                && this.previewThroughTermEnd == amendRequestPreviewOptions.previewThroughTermEnd
                && this.previewType == amendRequestPreviewOptions.previewType;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (enablePreviewMode == null ? 0 : System.hashCode(enablePreviewMode));
        hashCode = (17 * hashCode) + (includeExistingDraftInvoiceItems == null ? 0 : System.hashCode(includeExistingDraftInvoiceItems));
        hashCode = (17 * hashCode) + (numberOfPeriods == null ? 0 : System.hashCode(numberOfPeriods));
        hashCode = (17 * hashCode) + (previewThroughTermEnd == null ? 0 : System.hashCode(previewThroughTermEnd));
        hashCode = (17 * hashCode) + (previewType == null ? 0 : System.hashCode(previewType));
        return hashCode;
    }
}