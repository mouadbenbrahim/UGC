/**
 * Container for bill-to contact information.\n
 */
public class zc_GETAccountTypeBillToContact {
    /**
     * First address line, 255 characters or less.\n
     * @return address1
     */
    public String address1 { get; set; }

    /**
     * Second address line, 255 characters or less.\n
     * @return address2
     */
    public String address2 { get; set; }

    /**
     * City, 40 characters or less.\n
     * @return city
     */
    public String city { get; set; }

    /**
     * Full country name. This field does not contain the ISO-standard abbreviation of the country name.\n
     * @return country
     */
    public String country { get; set; }

    /**
     * County; 32 characters or less. Zuora Tax uses this information to calculate county taxation.          
     * @return county
     */
    public String county { get; set; }

    /**
     * Fax phone number, 40 characters or less.\n
     * @return fax
     */
    public String fax { get; set; }

    /**
     * First name, 100 characters or less.\n
     * @return firstName
     */
    public String firstName { get; set; }

    /**
     * Home phone number, 40 characters or less.\n
     * @return homePhone
     */
    public String homePhone { get; set; }

    /**
     * Last name, 100 characters or less.\n
     * @return lastName
     */
    public String lastName { get; set; }

    /**
     * Mobile phone number, 40 characters or less.\n
     * @return mobilePhone
     */
    public String mobilePhone { get; set; }

    /**
     * Nickname for this contact.\n
     * @return nickname
     */
    public String nickname { get; set; }

    /**
     * Other phone number, 40 characters or less.\n
     * @return otherPhone
     */
    public String otherPhone { get; set; }

    /**
     * Possible values are: `Work`, `Mobile`, `Home`, `Other`.\n
     * @return otherPhoneType
     */
    public String otherPhoneType { get; set; }

    /**
     * Personal email address, 80 characters or less.\n
     * @return personalEmail
     */
    public String personalEmail { get; set; }

    /**
     * Full state name. This field does not contain the ISO-standard abbreviation of the state name.\n
     * @return state
     */
    public String state { get; set; }

    /**
     * A region string, defined in your Zuora tax rules.\n
     * @return taxRegion
     */
    public String taxRegion { get; set; }

    /**
     * Work email address, 80 characters or less.\n
     * @return workEmail
     */
    public String workEmail { get; set; }

    /**
     * Work phone number, 40 characters or less.\n
     * @return workPhone
     */
    public String workPhone { get; set; }

    /**
     * Zip code, 20 characters or less.\n
     * @return zipCode
     */
    public String zipCode { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Aaaa' => 'aaa',
        'Bbbb' => 'bbb'
    };
    
    // public static zc_GETAccountTypeBillToContact getExample() {
    //     zc_GETAccountTypeBillToContact geTAccountTypeBillToContact = new zc_GETAccountTypeBillToContact();
    //     geTAccountTypeBillToContact.address1 = 'aeiou';
    //     geTAccountTypeBillToContact.address2 = 'aeiou';
    //     geTAccountTypeBillToContact.city = 'aeiou';
    //     geTAccountTypeBillToContact.country = 'aeiou';
    //     geTAccountTypeBillToContact.county = 'aeiou';
    //     geTAccountTypeBillToContact.fax = 'aeiou';
    //     geTAccountTypeBillToContact.firstName = 'aeiou';
    //     geTAccountTypeBillToContact.homePhone = 'aeiou';
    //     geTAccountTypeBillToContact.lastName = 'aeiou';
    //     geTAccountTypeBillToContact.mobilePhone = 'aeiou';
    //     geTAccountTypeBillToContact.nickname = 'aeiou';
    //     geTAccountTypeBillToContact.otherPhone = 'aeiou';
    //     geTAccountTypeBillToContact.otherPhoneType = 'aeiou';
    //     geTAccountTypeBillToContact.personalEmail = 'aeiou';
    //     geTAccountTypeBillToContact.state = 'aeiou';
    //     geTAccountTypeBillToContact.taxRegion = 'aeiou';
    //     geTAccountTypeBillToContact.workEmail = 'aeiou';
    //     geTAccountTypeBillToContact.workPhone = 'aeiou';
    //     geTAccountTypeBillToContact.zipCode = 'aeiou';
    //     return geTAccountTypeBillToContact;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_GETAccountTypeBillToContact) {
            zc_GETAccountTypeBillToContact geTAccountTypeBillToContact = (zc_GETAccountTypeBillToContact) obj;
            return this.address1 == geTAccountTypeBillToContact.address1
                && this.address2 == geTAccountTypeBillToContact.address2
                && this.city == geTAccountTypeBillToContact.city
                && this.country == geTAccountTypeBillToContact.country
                && this.county == geTAccountTypeBillToContact.county
                && this.fax == geTAccountTypeBillToContact.fax
                && this.firstName == geTAccountTypeBillToContact.firstName
                && this.homePhone == geTAccountTypeBillToContact.homePhone
                && this.lastName == geTAccountTypeBillToContact.lastName
                && this.mobilePhone == geTAccountTypeBillToContact.mobilePhone
                && this.nickname == geTAccountTypeBillToContact.nickname
                && this.otherPhone == geTAccountTypeBillToContact.otherPhone
                && this.otherPhoneType == geTAccountTypeBillToContact.otherPhoneType
                && this.personalEmail == geTAccountTypeBillToContact.personalEmail
                && this.state == geTAccountTypeBillToContact.state
                && this.taxRegion == geTAccountTypeBillToContact.taxRegion
                && this.workEmail == geTAccountTypeBillToContact.workEmail
                && this.workPhone == geTAccountTypeBillToContact.workPhone
                && this.zipCode == geTAccountTypeBillToContact.zipCode;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (address1 == null ? 0 : System.hashCode(address1));
        hashCode = (17 * hashCode) + (address2 == null ? 0 : System.hashCode(address2));
        hashCode = (17 * hashCode) + (city == null ? 0 : System.hashCode(city));
        hashCode = (17 * hashCode) + (country == null ? 0 : System.hashCode(country));
        hashCode = (17 * hashCode) + (county == null ? 0 : System.hashCode(county));
        hashCode = (17 * hashCode) + (fax == null ? 0 : System.hashCode(fax));
        hashCode = (17 * hashCode) + (firstName == null ? 0 : System.hashCode(firstName));
        hashCode = (17 * hashCode) + (homePhone == null ? 0 : System.hashCode(homePhone));
        hashCode = (17 * hashCode) + (lastName == null ? 0 : System.hashCode(lastName));
        hashCode = (17 * hashCode) + (mobilePhone == null ? 0 : System.hashCode(mobilePhone));
        hashCode = (17 * hashCode) + (nickname == null ? 0 : System.hashCode(nickname));
        hashCode = (17 * hashCode) + (otherPhone == null ? 0 : System.hashCode(otherPhone));
        hashCode = (17 * hashCode) + (otherPhoneType == null ? 0 : System.hashCode(otherPhoneType));
        hashCode = (17 * hashCode) + (personalEmail == null ? 0 : System.hashCode(personalEmail));
        hashCode = (17 * hashCode) + (state == null ? 0 : System.hashCode(state));
        hashCode = (17 * hashCode) + (taxRegion == null ? 0 : System.hashCode(taxRegion));
        hashCode = (17 * hashCode) + (workEmail == null ? 0 : System.hashCode(workEmail));
        hashCode = (17 * hashCode) + (workPhone == null ? 0 : System.hashCode(workPhone));
        hashCode = (17 * hashCode) + (zipCode == null ? 0 : System.hashCode(zipCode));
        return hashCode;
    }
}