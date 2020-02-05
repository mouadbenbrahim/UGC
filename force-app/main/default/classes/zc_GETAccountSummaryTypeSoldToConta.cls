/**
 * Container for sold-to contact information; uses the same structure as &#x60;billToContact&#x60;.\n
 */
public class zc_GETAccountSummaryTypeSoldToConta {
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
     * Contact ID.\n
     * @return id
     */
    public String id { get; set; }

    /**
     * Last name, 100 characters or less.\n
     * @return lastName
     */
    public String lastName { get; set; }

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
    
    //MNE
    public String source { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Source__c' => 'source' 
    };

    // public static zc_GETAccountSummaryTypeSoldToConta getExample() {
    //     zc_GETAccountSummaryTypeSoldToConta geTAccountSummaryTypeSoldToContact = new zc_GETAccountSummaryTypeSoldToConta();
    //     geTAccountSummaryTypeSoldToContact.address1 = 'aeiou';
    //     geTAccountSummaryTypeSoldToContact.address2 = 'aeiou';
    //     geTAccountSummaryTypeSoldToContact.city = 'aeiou';
    //     geTAccountSummaryTypeSoldToContact.country = 'aeiou';
    //     geTAccountSummaryTypeSoldToContact.county = 'aeiou';
    //     geTAccountSummaryTypeSoldToContact.fax = 'aeiou';
    //     geTAccountSummaryTypeSoldToContact.firstName = 'aeiou';
    //     geTAccountSummaryTypeSoldToContact.id = 'aeiou';
    //     geTAccountSummaryTypeSoldToContact.lastName = 'aeiou';
    //     geTAccountSummaryTypeSoldToContact.state = 'aeiou';
    //     geTAccountSummaryTypeSoldToContact.taxRegion = 'aeiou';
    //     geTAccountSummaryTypeSoldToContact.workEmail = 'aeiou';
    //     geTAccountSummaryTypeSoldToContact.workPhone = 'aeiou';
    //     geTAccountSummaryTypeSoldToContact.zipCode = 'aeiou';
    //     return geTAccountSummaryTypeSoldToContact;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_GETAccountSummaryTypeSoldToConta) {
            zc_GETAccountSummaryTypeSoldToConta geTAccountSummaryTypeSoldToContact = (zc_GETAccountSummaryTypeSoldToConta) obj;
            return this.address1 == geTAccountSummaryTypeSoldToContact.address1
                && this.address2 == geTAccountSummaryTypeSoldToContact.address2
                && this.city == geTAccountSummaryTypeSoldToContact.city
                && this.country == geTAccountSummaryTypeSoldToContact.country
                && this.county == geTAccountSummaryTypeSoldToContact.county
                && this.fax == geTAccountSummaryTypeSoldToContact.fax
                && this.firstName == geTAccountSummaryTypeSoldToContact.firstName
                && this.id == geTAccountSummaryTypeSoldToContact.id
                && this.lastName == geTAccountSummaryTypeSoldToContact.lastName
                && this.state == geTAccountSummaryTypeSoldToContact.state
                && this.taxRegion == geTAccountSummaryTypeSoldToContact.taxRegion
                && this.workEmail == geTAccountSummaryTypeSoldToContact.workEmail
                && this.workPhone == geTAccountSummaryTypeSoldToContact.workPhone
                && this.zipCode == geTAccountSummaryTypeSoldToContact.zipCode;
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
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
        hashCode = (17 * hashCode) + (lastName == null ? 0 : System.hashCode(lastName));
        hashCode = (17 * hashCode) + (state == null ? 0 : System.hashCode(state));
        hashCode = (17 * hashCode) + (taxRegion == null ? 0 : System.hashCode(taxRegion));
        hashCode = (17 * hashCode) + (workEmail == null ? 0 : System.hashCode(workEmail));
        hashCode = (17 * hashCode) + (workPhone == null ? 0 : System.hashCode(workPhone));
        hashCode = (17 * hashCode) + (zipCode == null ? 0 : System.hashCode(zipCode));
        return hashCode;
    }
}