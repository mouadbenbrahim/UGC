public class zc_ActionsErrorResponse implements zc_Zuc.MappedProperties {
    /**
     * 
     * @return code
     */
    public String code { get; set; }

    /**
     * 
     * @return message
     */
    public String message { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Code' => 'code',
        'Message' => 'message'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public static zc_ActionsErrorResponse getExample() {
        zc_ActionsErrorResponse actionsErrorResponse = new zc_ActionsErrorResponse();
        actionsErrorResponse.code = 'aeiou';
        actionsErrorResponse.message = 'aeiou';
        return actionsErrorResponse;
    }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_ActionsErrorResponse) {
            zc_ActionsErrorResponse actionsErrorResponse = (zc_ActionsErrorResponse) obj;
            return this.code == actionsErrorResponse.code
                && this.message == actionsErrorResponse.message;
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