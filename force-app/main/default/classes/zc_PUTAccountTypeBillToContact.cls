/**
 * Container for bill-to contact information for this account.\n
 */
public class zc_PUTAccountTypeBillToContact {
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
     * Country; must be a valid country name or abbreviation. If using Zuora Tax, you must specify a country in the sold-to contact to calculate tax. A bill-to contact may be used if no sold-to contact is provided.\n
     * @return country
     */
    public String country { get; set; }

    /**
     * County; 32 characters or less. May optionally be used by Zuora Tax to calculate county tax.\n
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
     * Nickname for this contact\n
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
     * State; must be a valid state or province name or 2-character abbreviation. If using Zuora Tax, be aware that Zuora Tax requires a state (in the US) or province (in Canada) in this field for the sold-to contact to calculate tax, and that a bill-to contact may be used if no sold-to contact is provided.\n
     * @return state
     */
    public String state { get; set; }

    /**
     * If using Zuora Tax, a region string as optionally defined in your tax rules. Not required.\n
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
        'Aaaa' => 'aaaa',
        'Bbbb' => 'bbbb'
    };    

    // public static zc_PUTAccountTypeBillToContact getExample() {
    //     zc_PUTAccountTypeBillToContact puTAccountTypeBillToContact = new zc_PUTAccountTypeBillToContact();
    //     puTAccountTypeBillToContact.address1 = 'aeiou';
    //     puTAccountTypeBillToContact.address2 = 'aeiou';
    //     puTAccountTypeBillToContact.city = 'aeiou';
    //     puTAccountTypeBillToContact.country = 'aeiou';
    //     puTAccountTypeBillToContact.county = 'aeiou';
    //     puTAccountTypeBillToContact.fax = 'aeiou';
    //     puTAccountTypeBillToContact.firstName = 'aeiou';
    //     puTAccountTypeBillToContact.homePhone = 'aeiou';
    //     puTAccountTypeBillToContact.lastName = 'aeiou';
    //     puTAccountTypeBillToContact.mobilePhone = 'aeiou';
    //     puTAccountTypeBillToContact.nickname = 'aeiou';
    //     puTAccountTypeBillToContact.otherPhone = 'aeiou';
    //     puTAccountTypeBillToContact.otherPhoneType = 'aeiou';
    //     puTAccountTypeBillToContact.personalEmail = 'aeiou';
    //     puTAccountTypeBillToContact.state = 'aeiou';
    //     puTAccountTypeBillToContact.taxRegion = 'aeiou';
    //     puTAccountTypeBillToContact.workEmail = 'aeiou';
    //     puTAccountTypeBillToContact.workPhone = 'aeiou';
    //     puTAccountTypeBillToContact.zipCode = 'aeiou';
    //     return puTAccountTypeBillToContact;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_PUTAccountTypeBillToContact) {
            zc_PUTAccountTypeBillToContact puTAccountTypeBillToContact = (zc_PUTAccountTypeBillToContact) obj;
            return this.address1 == puTAccountTypeBillToContact.address1
                && this.address2 == puTAccountTypeBillToContact.address2
                && this.city == puTAccountTypeBillToContact.city
                && this.country == puTAccountTypeBillToContact.country
                && this.county == puTAccountTypeBillToContact.county
                && this.fax == puTAccountTypeBillToContact.fax
                && this.firstName == puTAccountTypeBillToContact.firstName
                && this.homePhone == puTAccountTypeBillToContact.homePhone
                && this.lastName == puTAccountTypeBillToContact.lastName
                && this.mobilePhone == puTAccountTypeBillToContact.mobilePhone
                && this.nickname == puTAccountTypeBillToContact.nickname
                && this.otherPhone == puTAccountTypeBillToContact.otherPhone
                && this.otherPhoneType == puTAccountTypeBillToContact.otherPhoneType
                && this.personalEmail == puTAccountTypeBillToContact.personalEmail
                && this.state == puTAccountTypeBillToContact.state
                && this.taxRegion == puTAccountTypeBillToContact.taxRegion
                && this.workEmail == puTAccountTypeBillToContact.workEmail
                && this.workPhone == puTAccountTypeBillToContact.workPhone
                && this.zipCode == puTAccountTypeBillToContact.zipCode;
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