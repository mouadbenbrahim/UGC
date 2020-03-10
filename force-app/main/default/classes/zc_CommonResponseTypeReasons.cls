/**
 * zc_CommonResponseTypeReasons
 */
public class zc_CommonResponseTypeReasons {
    /**
     * The error code of response.\n
     * @return code
     */
    public String code { get; set; }

    /**
     * The detail information of the error response\n
     * @return message
     */
    public String message { get; set; }

    // public static zc_CommonResponseTypeReasons getExample() {
    //     zc_CommonResponseTypeReasons commonResponseTypeReasons = new zc_CommonResponseTypeReasons();
    //     commonResponseTypeReasons.code = 'aeiou';
    //     commonResponseTypeReasons.message = 'aeiou';
    //     return commonResponseTypeReasons;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_CommonResponseTypeReasons) {
            zc_CommonResponseTypeReasons commonResponseTypeReasons = (zc_CommonResponseTypeReasons) obj;
            return this.code == commonResponseTypeReasons.code
                && this.message == commonResponseTypeReasons.message;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (code == null ? 0 : System.hashCode(code));
        hashCode = (17 * hashCode) + (message == null ? 0 : System.hashCode(message));
        return hashCode;
    }
}