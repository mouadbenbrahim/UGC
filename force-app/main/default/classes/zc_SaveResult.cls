/**
 * zc_SaveResult
 */
public class zc_SaveResult implements zc_Zuc.MappedProperties {
    /**
     * 
     * @return errors
     */
    public List<zc_ActionsErrorResponse> errors { get; set; }

    /**
     * 
     * @return id
     */
    public String id { get; set; }

    /**
     * 
     * @return success
     */
    public Boolean success { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Errors' => 'errors',
        'Id' => 'id',
        'Success' => 'success'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public zc_SaveResult() {
        errors = new List<zc_ActionsErrorResponse>{new zc_ActionsErrorResponse()};
    }

    // public static zc_SaveResult getExample() {
    //     zc_SaveResult saveResult = new zc_SaveResult();
    //     saveResult.errors = new List<zc_ActionsErrorResponse>{zc_ActionsErrorResponse.getExample()};
    //     saveResult.id = 'aeiou';
    //     saveResult.success = true;
    //     return saveResult;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_SaveResult) {
            zc_SaveResult saveResult = (zc_SaveResult) obj;
            return this.errors == saveResult.errors
                && this.id == saveResult.id
                && this.success == saveResult.success;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (errors == null ? 0 : System.hashCode(errors));
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
        hashCode = (17 * hashCode) + (success == null ? 0 : System.hashCode(success));
        return hashCode;
    }
}