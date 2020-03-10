/**
 * zc_CreditMemoResponseType
 */
public class zc_CreditMemoResponseType {
    /**
     * The ID of the generated credit memo.\n
     * @return id
     */
    public String id { get; set; }

    // public static zc_CreditMemoResponseType getExample() {
    //     zc_CreditMemoResponseType creditMemoResponseType = new zc_CreditMemoResponseType();
    //     creditMemoResponseType.id = 'aeiou';
    //     return creditMemoResponseType;
    // }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Aaaa' => 'aaaa'
    };
    
    public Boolean equals(Object obj) {
        if (obj instanceof zc_CreditMemoResponseType) {
            zc_CreditMemoResponseType creditMemoResponseType = (zc_CreditMemoResponseType) obj;
            return this.id == creditMemoResponseType.id;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
        return hashCode;
    }
}