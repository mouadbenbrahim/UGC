/**
 * zc_CommonResponseType
 */
public class zc_CommonResponseType {
    /**
     * The Id of the process that handle the operation.\n
     * @return processId
     */
    public String processId { get; set; }

    /**
     * Get reasons
     * @return reasons
     */
    public List<zc_CommonResponseTypeReasons> reasons { get; set; }

    /**
     * Indicates whether the call succeeded.\n
     * @return success
     */
    public Boolean success { get; set; }

    public zc_CommonResponseType() {
        reasons = new List<zc_CommonResponseTypeReasons>();
    }

    // public static zc_CommonResponseType getExample() {
    //     zc_CommonResponseType commonResponseType = new zc_CommonResponseType();
    //     commonResponseType.processId = 'aeiou';
    //     commonResponseType.reasons = new List<zc_CommonResponseTypeReasons>{zc_CommonResponseTypeReasons.getExample()};
    //     commonResponseType.success = true;
    //     return commonResponseType;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_CommonResponseType) {
            zc_CommonResponseType commonResponseType = (zc_CommonResponseType) obj;
            return this.processId == commonResponseType.processId
                && this.reasons == commonResponseType.reasons
                && this.success == commonResponseType.success;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (processId == null ? 0 : System.hashCode(processId));
        hashCode = (17 * hashCode) + (reasons == null ? 0 : System.hashCode(reasons));
        hashCode = (17 * hashCode) + (success == null ? 0 : System.hashCode(success));
        return hashCode;
    }
}