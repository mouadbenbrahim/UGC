/**
 *  Unless otherwise specified, this field defaults to the information in the &#x60;BillToContact&#x60; field.\n\n**Values:** A valid contact. 
 */
public class zc_SubscribeRequestSoldToContact {
    /**
     *  The Zuora account ID associated with this contact. This field is not required when you use the subscribe\ncall. This field is required for all other calls.\n**Character limit: **32 **Values: **a valid account ID 
     * @return accountId
     */
    public String accountId { get; set; }

    /**
     *  The first line of the contact\'s address, which is often a street address or business name.\n\n\n**Character limit**: 255\n\n\n**Values**: a string of 255 characters or fewer 
     * @return address1
     */
    public String address1 { get; set; }

    /**
     *  The second line of the contact\'s address.\n\n\n**Character limit**: 255\n\n\n**Values**: a string of 255 characters or fewer 
     * @return address2
     */
    public String address2 { get; set; }

    /**
     *  The city of the contact\'s address.\n\n\n**Character limit**: 40 **Values: **a string of 40 characters or fewer 
     * @return city
     */
    public String city { get; set; }

    /**
     *  The country of the contact\'s address. 
     * @return country
     */
    public String country { get; set; }

    /**
     *  The country. May optionally be used by [Z-Tax](/C_Zuora_User_Guides/A_Billing_and_Payments/I_Taxes/Z-Tax) to calculate county tax.\n\n\n**Character limit**: 32\n\n\n**Values**: a string of 32 characters or fewer 
     * @return county
     */
    public String county { get; set; }

    /**
     * The ID of the Zuora user who created the contact.\n\n**Character limit**: 32\n\n\n**Values**: automatically generated 
     * @return createdById
     */
    public String createdById { get; set; }

    /**
     * The date when the contact was created.\n\n**Character limit**: 29\n\n\n**Values**: automatically generated 
     * @return createdDate
     */
    public Datetime createdDate { get; set; }

    /**
     *  A description for the contact.\n\n\n**Character limit**: 100\n\n\n**Values**: a string of 100 characters or fewer 
     * @return description
     */
    public String description { get; set; }

    /**
     *  The contact\'s fax number.\n\n\n**Character limit**: 40\n\n\n**Values**: a string of 40 characters or fewer 
     * @return fax
     */
    public String fax { get; set; }

    /**
     *  The contact\'s first name.\n\n\n**Character limit**: 100\n\n\n**Values**: a string of the contact\'s first name 
     * @return firstName
     */
    public String firstName { get; set; }

    /**
     *  The contact\'s home phone number.\n\n\n**Character limit**: 40\n\n\n**Values**: a string of 40 characters or fewer 
     * @return homePhone
     */
    public String homePhone { get; set; }

    /**
     *  The contact\'s last name.\n\n\n**Character limit**: 100\n\n\n**Values**: a string of 100 characters or fewer 
     * @return lastName
     */
    public String lastName { get; set; }

    /**
     *  The contact\'s mobile phone number.\n\n\n**Character limit**: 40\n\n\n**Values**: a string of 40 characters or fewer 
     * @return mobilePhone
     */
    public String mobilePhone { get; set; }

    /**
     *  A nickname for the contact.\n\n\n**Character limit**: 100\n\n\n**Values**: a string of 100 characters or fewer 
     * @return nickName
     */
    public String nickName { get; set; }

    /**
     *  An additional phone number for the contact.\n\n\n**Character limit**: 40\n\n\n**Values**: a string of 40 characters or fewer 
     * @return otherPhone
     */
    public String otherPhone { get; set; }

    /**
     * The type of the `OtherPhone`.\n\n**Character limit**: 20\n\n\n**Values**: `Work`, `Mobile`, `Home`, `Other` 
     * @return otherPhoneType
     */
    public String otherPhoneType { get; set; }

    /**
     *  The contact\'s personal email address.\n\n\n**Character limit**: 80\n\n\n**Values**: a string of 80 characters or fewer 
     * @return personalEmail
     */
    public String personalEmail { get; set; }

    /**
     *  The zip code for the contact\'s address.\n**Character limit:** 20 **Values: **a string of 20 characters or fewer 
     * @return postalCode
     */
    public String postalCode { get; set; }

    /**
     *  The state or province of the contact\'s address. 
     * @return state
     */
    public String state { get; set; }

    /**
     * If using [Z-Tax](https://knowledgecenter.zuora.com/CB_Billing/J_Billing_Operations/L_Taxes/A_Z-Tax) tax rules 
     * @return taxRegion
     */
    public String taxRegion { get; set; }

    /**
     *  The ID of the user who lasted updated the contact.\n\n\n**Character limit**: 32\n\n\n**Values**: automatically generated 
     * @return updatedById
     */
    public String updatedById { get; set; }

    /**
     *  The date when the contact was last updated.\n\n\n**Character limit**: 29\n\n\n**Values**: automatically generated 
     * @return updatedDate
     */
    public Datetime updatedDate { get; set; }

    /**
     *  The contact\'s business email address.\n\n\n**Character limit**: 80\n\n\n**Values**: a string of 80 characters or fewer 
     * @return workEmail
     */
    public String workEmail { get; set; }

    /**
     *  The contact\'s business phone number.\n\n\n**Character limit**: 40 **notes**: --\n\n\n**Values**: a string of 40 characters or fewer 
     * @return workPhone
     */
    public String workPhone { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'AccountId' => 'accountId',
        'Address1' => 'address1',
        'Address2' => 'address2',
        'City' => 'city',
        'Country' => 'country',
        'County' => 'county',
        'CreatedById' => 'createdById',
        'CreatedDate' => 'createdDate',
        'Description' => 'description',
        'Fax' => 'fax',
        'FirstName' => 'firstName',
        'HomePhone' => 'homePhone',
        'LastName' => 'lastName',
        'MobilePhone' => 'mobilePhone',
        'NickName' => 'nickName',
        'OtherPhone' => 'otherPhone',
        'OtherPhoneType' => 'otherPhoneType',
        'PersonalEmail' => 'personalEmail',
        'PostalCode' => 'postalCode',
        'State' => 'state',
        'TaxRegion' => 'taxRegion',
        'UpdatedById' => 'updatedById',
        'UpdatedDate' => 'updatedDate',
        'WorkEmail' => 'workEmail',
        'WorkPhone' => 'workPhone'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    // public static zc_SubscribeRequestSoldToContact getExample() {
    //     zc_SubscribeRequestSoldToContact subscribeRequestSoldToContact = new zc_SubscribeRequestSoldToContact();
    //     subscribeRequestSoldToContact.accountId = 'aeiou';
    //     subscribeRequestSoldToContact.address1 = 'aeiou';
    //     subscribeRequestSoldToContact.address2 = 'aeiou';
    //     subscribeRequestSoldToContact.city = 'aeiou';
    //     subscribeRequestSoldToContact.country = 'aeiou';
    //     subscribeRequestSoldToContact.county = 'aeiou';
    //     subscribeRequestSoldToContact.createdById = 'aeiou';
    //     subscribeRequestSoldToContact.createdDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    //     subscribeRequestSoldToContact.description = 'aeiou';
    //     subscribeRequestSoldToContact.fax = 'aeiou';
    //     subscribeRequestSoldToContact.firstName = 'aeiou';
    //     subscribeRequestSoldToContact.homePhone = 'aeiou';
    //     subscribeRequestSoldToContact.lastName = 'aeiou';
    //     subscribeRequestSoldToContact.mobilePhone = 'aeiou';
    //     subscribeRequestSoldToContact.nickName = 'aeiou';
    //     subscribeRequestSoldToContact.otherPhone = 'aeiou';
    //     subscribeRequestSoldToContact.otherPhoneType = 'aeiou';
    //     subscribeRequestSoldToContact.personalEmail = 'aeiou';
    //     subscribeRequestSoldToContact.postalCode = 'aeiou';
    //     subscribeRequestSoldToContact.state = 'aeiou';
    //     subscribeRequestSoldToContact.taxRegion = 'aeiou';
    //     subscribeRequestSoldToContact.updatedById = 'aeiou';
    //     subscribeRequestSoldToContact.updatedDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    //     subscribeRequestSoldToContact.workEmail = 'aeiou';
    //     subscribeRequestSoldToContact.workPhone = 'aeiou';
    //     return subscribeRequestSoldToContact;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_SubscribeRequestSoldToContact) {
            zc_SubscribeRequestSoldToContact subscribeRequestSoldToContact = (zc_SubscribeRequestSoldToContact) obj;
            return this.accountId == subscribeRequestSoldToContact.accountId
                && this.address1 == subscribeRequestSoldToContact.address1
                && this.address2 == subscribeRequestSoldToContact.address2
                && this.city == subscribeRequestSoldToContact.city
                && this.country == subscribeRequestSoldToContact.country
                && this.county == subscribeRequestSoldToContact.county
                && this.createdById == subscribeRequestSoldToContact.createdById
                && this.createdDate == subscribeRequestSoldToContact.createdDate
                && this.description == subscribeRequestSoldToContact.description
                && this.fax == subscribeRequestSoldToContact.fax
                && this.firstName == subscribeRequestSoldToContact.firstName
                && this.homePhone == subscribeRequestSoldToContact.homePhone
                && this.lastName == subscribeRequestSoldToContact.lastName
                && this.mobilePhone == subscribeRequestSoldToContact.mobilePhone
                && this.nickName == subscribeRequestSoldToContact.nickName
                && this.otherPhone == subscribeRequestSoldToContact.otherPhone
                && this.otherPhoneType == subscribeRequestSoldToContact.otherPhoneType
                && this.personalEmail == subscribeRequestSoldToContact.personalEmail
                && this.postalCode == subscribeRequestSoldToContact.postalCode
                && this.state == subscribeRequestSoldToContact.state
                && this.taxRegion == subscribeRequestSoldToContact.taxRegion
                && this.updatedById == subscribeRequestSoldToContact.updatedById
                && this.updatedDate == subscribeRequestSoldToContact.updatedDate
                && this.workEmail == subscribeRequestSoldToContact.workEmail
                && this.workPhone == subscribeRequestSoldToContact.workPhone;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (accountId == null ? 0 : System.hashCode(accountId));
        hashCode = (17 * hashCode) + (address1 == null ? 0 : System.hashCode(address1));
        hashCode = (17 * hashCode) + (address2 == null ? 0 : System.hashCode(address2));
        hashCode = (17 * hashCode) + (city == null ? 0 : System.hashCode(city));
        hashCode = (17 * hashCode) + (country == null ? 0 : System.hashCode(country));
        hashCode = (17 * hashCode) + (county == null ? 0 : System.hashCode(county));
        hashCode = (17 * hashCode) + (createdById == null ? 0 : System.hashCode(createdById));
        hashCode = (17 * hashCode) + (createdDate == null ? 0 : System.hashCode(createdDate));
        hashCode = (17 * hashCode) + (description == null ? 0 : System.hashCode(description));
        hashCode = (17 * hashCode) + (fax == null ? 0 : System.hashCode(fax));
        hashCode = (17 * hashCode) + (firstName == null ? 0 : System.hashCode(firstName));
        hashCode = (17 * hashCode) + (homePhone == null ? 0 : System.hashCode(homePhone));
        hashCode = (17 * hashCode) + (lastName == null ? 0 : System.hashCode(lastName));
        hashCode = (17 * hashCode) + (mobilePhone == null ? 0 : System.hashCode(mobilePhone));
        hashCode = (17 * hashCode) + (nickName == null ? 0 : System.hashCode(nickName));
        hashCode = (17 * hashCode) + (otherPhone == null ? 0 : System.hashCode(otherPhone));
        hashCode = (17 * hashCode) + (otherPhoneType == null ? 0 : System.hashCode(otherPhoneType));
        hashCode = (17 * hashCode) + (personalEmail == null ? 0 : System.hashCode(personalEmail));
        hashCode = (17 * hashCode) + (postalCode == null ? 0 : System.hashCode(postalCode));
        hashCode = (17 * hashCode) + (state == null ? 0 : System.hashCode(state));
        hashCode = (17 * hashCode) + (taxRegion == null ? 0 : System.hashCode(taxRegion));
        hashCode = (17 * hashCode) + (updatedById == null ? 0 : System.hashCode(updatedById));
        hashCode = (17 * hashCode) + (updatedDate == null ? 0 : System.hashCode(updatedDate));
        hashCode = (17 * hashCode) + (workEmail == null ? 0 : System.hashCode(workEmail));
        hashCode = (17 * hashCode) + (workPhone == null ? 0 : System.hashCode(workPhone));
        return hashCode;
    }
}