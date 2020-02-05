/**
 * zc_ProxyCreatePaymentMethod
 */
public class zc_ProxyCreatePaymentMethod {
    /**
     * The ID of the customer account associated with this payment method.\n\n**Note:** You can create a payment method without assocating it with a customer account if you want. To do it and change the `AccountId` field to optional in this operation, submit a request at [Zuora Global Support](http://support.zuora.com/). 
     * @return accountId
     */
    public String accountId { get; set; }

    /**
     *  The nine-digit routing number or ABA number used by banks. This field is only required if the `Type` field is set to `ACH`.\n\n**Character limit**: 9 **Values**: a string of 9 characters or fewer 
     * @return achAbaCode
     */
    public String achAbaCode { get; set; }

    /**
     *  The name of the account holder, which can be either a person or a company. This field is only required if the `Type` field is set to `ACH`.\n\n**Character limit**: 70 **Values**: a string of 70 characters or fewer 
     * @return achAccountName
     */
    public String achAccountName { get; set; }

    /**
     * The bank account number associated with the ACH payment. This field is only required if the `Type` field is set to `ACH`.\n**Character limit**: 30 **Values**: a string of 30 numeric characters or fewer 
     * @return achAccountNumber
     */
    public String achAccountNumber { get; set; }

    /**
     *  The type of bank account associated with the ACH payment. This field is only required if the `Type` field is set to `ACH`.\n**Character limit**: 16 **Values**:\n- `BusinessChecking`\n- `Checking`\n- `Saving`\n
     * @return achAccountType
     */
    public String achAccountType { get; set; }

    /**
     *  Line 1 for the ACH address. This field is required for creating a payment method for the Vantiv payment gateway. **Character limit**: 255 **Values**: an address 
     * @return achAddress1
     */
    public String achAddress1 { get; set; }

    /**
     *  Line 2 for the ACH address. This field is required for creating a payment method for the Vantiv payment gateway. **Character limit**: 255 **Values**: an address 
     * @return achAddress2
     */
    public String achAddress2 { get; set; }

    /**
     *  The name of the bank where the ACH payment account is held. This field is only required if the `Type` field is set to `ACH`.\n**Character limit**: 70 **Values**: a string of 70 characters or fewer 
     * @return achBankName
     */
    public String achBankName { get; set; }

    /**
     * The city of the ACH address. Use this field for ACH payment methods. **Note**: This field is only specific to the NMI payment gateway.\n**Character limit**: 40 **Values**: a string of 40 characters or fewer 
     * @return achCity
     */
    public String achCity { get; set; }

    /**
     * The country of the ACH address. See [Country Names and Their ISO Standard 2- and 3-Digit Codes](https://knowledgecenter.zuora.com/BB_Introducing_Z_Business/D_Country%2C_State%2C_and_Province_Codes/A_Country_Names_and_Their_ISO_Codes) for the list of supported country names. Use this field for ACH methods. **Note**: This field is only specific to the NMI payment gateway.\n**Character limit**: 40 **Values**: a supported country name 
     * @return achCountry
     */
    public String achCountry { get; set; }

    /**
     * The billing address\'s zip code. This field is required only when you define an ACH payment method. **Note**: This field is only specific to the NMI payment gateway.\n**Character limit**: 20 **Values**: a string of 20 characters or fewer 
     * @return achPostalCode
     */
    public String achPostalCode { get; set; }

    /**
     * The billing address\'s state. Use this field is if the `ACHCountry` value is either `Canada` or the `US`. State names must be spelled in full. For more information, see the list of [supported state names](https://knowledgecenter.zuora.com/BB_Introducing_Z_Business/D_Country%2C_State%2C_and_Province_Codes/B_State_Names_and_2-Digit_Codes). This field is required only when you define an ACH payment method. **Note**: This field is only specific to the NMI payment gateway.\n**Character limit**: 50 **Values**: a valid state name 
     * @return achState
     */
    public String achState { get; set; }

    /**
     *  The branch code of the bank used for direct debit. Use this field for direct debit payment methods.\n**Character limit**: 10 **Values**: a string of 10 characters or fewer 
     * @return bankBranchCode
     */
    public String bankBranchCode { get; set; }

    /**
     * The check digit in the international bank account number, which confirms the validity of the account. Use this field for direct debit payment methods. **Character limit**: 4 **Values**: a string of 4 characters or fewer 
     * @return bankCheckDigit
     */
    public String bankCheckDigit { get; set; }

    /**
     * The name on the direct debit bank account. Use this field for direct debit payment methods.\n\n**Character limit**: 60\n**Values**: a string of 60 characters or fewer\n
     * @return bankTransferAccountName
     */
    public String bankTransferAccountName { get; set; }

    /**
     * The number of the customer\'s bank account. Use this field for direct debit payment methods.\n\n**Character limit**: 30\n**Values**: a string of 30 characters or fewer\n
     * @return bankTransferAccountNumber
     */
    public String bankTransferAccountNumber { get; set; }

    /**
     * \nThis is a masked displayable version of the ACH account number, used for security purposes. For example: `XXXXXXXXX54321`.\n\n**Character limit**: 32\n**Values**: automatically generated\n
     * @return bankTransferAccountNumberMask
     */
    public String bankTransferAccountNumberMask { get; set; }

    /**
     * The type of direct debit transfer. The value of this field is dependent on the country of the user. This field is only required if the `Type` field is set to `BankTransfer`.\n\n **Values**: \n\n   - `SEPA` \n   \n   - `AutomatischIncasso` (NL)\n\n   - `LastschriftDE` (Germany)\n\n   - `LastschriftAT` (Austria)\n\n   - `DemandeDePrelevement` (FR)\n\n   - `DirectDebitUK` (UK)\n\n   - `Domicil` (Belgium)\n\n   - `LastschriftCH` (CH)\n\n   - `RID` (Italy)\n\n   - `OrdenDeDomiciliacion` (Spain)\n   - `Autogiro` (Sweden)\n   - `Betalingsservice` (Denmark)\n
     * @return bankTransferType
     */
    public String bankTransferType { get; set; }

    /**
     *  The business identification code for Swiss direct payment methods that use the Global Collect payment gateway. Use this field only for direct debit payments in Switzerland with Global Collect.\n**Character limit**: 11 **Values**: a string of 11 characters or fewer 
     * @return businessIdentificationCode
     */
    public String businessIdentificationCode { get; set; }

    /**
     *  The city of the customer\'s address. Use this field for direct debit payment methods.\n**Character limit**:80 **Values**: a string of 80 characters or fewer 
     * @return city
     */
    public String city { get; set; }

    /**
     * The name of the company.\n\nZuora does not recommend that you use this field.\n
     * @return companyName
     */
    public String companyName { get; set; }

    /**
     *  The two-letter country code of the customer\'s address. This field is only required if the `Type` field is set to `BankTransfer`, and the `BankTransferType` field is set to either `DirectDebitUK`, `DirectEntryAU`, or `DirectDebitNZ`.\n**Character limit**: 2 **Values**: a valid country code 
     * @return country
     */
    public String country { get; set; }

    /**
     *  The first line of the card holder\'s address, which is often a street address or business name. Use this field for credit card and direct debit payment methods.\n**Character limit**: 255 **Values**: a string of 255 characters or fewer 
     * @return creditCardAddress1
     */
    public String creditCardAddress1 { get; set; }

    /**
     *  The second line of the card holder\'s address. Use this field for credit card and direct debit payment methods.\n**Character limit**: 255 **Values**: a string of 255 characters or fewer 
     * @return creditCardAddress2
     */
    public String creditCardAddress2 { get; set; }

    /**
     *  The city of the card holder\'s address. Use this field for credit card and direct debit payment methods **Character limit**: 40 **Values**: a string of 40 characters or fewer 
     * @return creditCardCity
     */
    public String creditCardCity { get; set; }

    /**
     *  The country of the card holder\'s address. 
     * @return creditCardCountry
     */
    public String creditCardCountry { get; set; }

    /**
     *  The expiration month of the credit card or debit card. This field is only required if the `Type` field is set to `CreditCard` or `DebitCard`.\n**Character limit**: 2 **Values**: a two-digit number, 01 - 12 
     * @return creditCardExpirationMonth
     */
    public Integer creditCardExpirationMonth { get; set; }

    /**
     *  The expiration month of the credit card or debit card. This field is only required if the `Type` field is set to `CreditCard` or `DebitCard`.\n**Character limit**: 4 **Values**: a four-digit number 
     * @return creditCardExpirationYear
     */
    public Integer creditCardExpirationYear { get; set; }

    /**
     *  The full name of the card holder. This field is only required if the `Type` field is set to `CreditCard` or `DebitCard`.\n\n**Character limit**: 50 **Values**: a string of 50 characters or fewer 
     * @return creditCardHolderName
     */
    public String creditCardHolderName { get; set; }

    /**
     * Credit card number, a string of up to 16 characters. This field can only be set when creating a new payment method; it cannot be queried or updated. 
     * @return creditCardNumber
     */
    public String creditCardNumber { get; set; }

    /**
     *  The billing address\'s zip code. **Character limit**: 20 **Values**: a string of 20 characters or fewer 
     * @return creditCardPostalCode
     */
    public String creditCardPostalCode { get; set; }

    /**
     * The CVV or CVV2 security code. See [How do I control what information Zuora sends over to the Payment Gateway?](https://knowledgecenter.zuora.com/kb/How_do_I_control_information_sent_to_payment_gateways_when_verifying_payment_methods%3F) for more information. To ensure PCI compliance, this value is not stored and cannot be queried. 
     * @return creditCardSecurityCode
     */
    public String creditCardSecurityCode { get; set; }

    /**
     *  The billing address\'s state. Use this field if the `CreditCardCountry` value is either Canada or the US. State names must be spelled in full. 
     * @return creditCardState
     */
    public String creditCardState { get; set; }

    /**
     * The type of the credit card.\n\nPossible values  include `Visa`, `MasterCard`, `AmericanExpress`, `Discover`, `JCB`, and `Diners`. For more information about credit card types supported by different payment gateways, see [Supported Payment Gateways](https://knowledgecenter.zuora.com/CB_Billing/M_Payment_Gateways/Supported_Payment_Gateways).\n
     * @return creditCardType
     */
    public String creditCardType { get; set; }

    /**
     *  The session ID of the user when the `PaymentMethod` was created or updated. Some gateways use this field for fraud prevention. If this field is passed to Zuora, then Zuora passes this field to supported gateways. Currently only Verifi supports this field.\n**Character limit**: 255 **Values**: 
     * @return deviceSessionId
     */
    public String deviceSessionId { get; set; }

    /**
     *  An email address for the payment method in addition to the bill to contact email address.\n**Character limit**: 80 **Values**: a string of 80 characters or fewer 
     * @return email
     */
    public String email { get; set; }

    /**
     *  Indicates if the customer has an existing mandate or a new mandate. A mandate is a signed authorization for UK and NL customers. When you are migrating mandates from another system, be sure to set this field correctly. If you indicate that a new mandate is an existing mandate or vice-versa, then transactions fail. This field is used only for the direct debit payment method.\n**Character limit**: 3 **Values**: `Yes`, `No` 
     * @return existingMandate
     */
    public String existingMandate { get; set; }

    /**
     *  The customer\'s first name. This field is used only for the direct debit payment method.\n**Character limit**: 30 **Values**: a string of 30 characters or fewer 
     * @return firstName
     */
    public String firstName { get; set; }

    /**
     * Get gatewayOptionData
     * @return gatewayOptionData
     */
    public zc_ProxyCreatePaymentGatewayOptionD gatewayOptionData { get; set; }

    /**
     *  The International Bank Account Number. This field is used only for the direct debit payment method.\n**Character limit**: 42 **Values**: a string of 42 characters or fewer 
     * @return IBAN
     */
    public String IBAN { get; set; }

    /**
     *  The IP address of the user when the payment method was created or updated. Some gateways use this field for fraud prevention. If this field is passed to Zuora, then Zuora passes this field to supported gateways. Currently PayPal, CyberSource, Authorize.Net, Verifi, and WorldPay support this field.\n**Character limit**: 15 **Values**: a string of 15 characters or fewer 
     * @return ipAddress
     */
    public String ipAddress { get; set; }

    /**
     * The unique identity number of the customer account. \n\nThis field is required only if the `BankTransferType` field is set to `Autogiro` or `Betalingsservice`. It is a string of 12 characters for a Swedish identity number, and a string of 10 characters for a Denish identity number.\n
     * @return identityNumber
     */
    public String identityNumber { get; set; }

    /**
     * Whether the customer account is a company.\n\nZuora does not recommend that you use this field. \n
     * @return isCompany
     */
    public Boolean isCompany { get; set; }

    /**
     *  The customer\'s last name. This field is used only for the direct debit payment method.\n**Character limit**: 70 **Values**: a string of 70 characters or fewer 
     * @return lastName
     */
    public String lastName { get; set; }

    /**
     *  The date of the most recent transaction.\n**Character limit**: 29 **Values**: a valid date and time value 
     * @return lastTransactionDateTime
     */
    public Datetime lastTransactionDateTime { get; set; }

    /**
     *  The date when the mandate was created, in `yyyy-mm-dd` format. A mandate is a signed authorization for UK and NL customers. This field is used only for the direct debit payment method.\n**Character limit**: 29 
     * @return mandateCreationDate
     */
    public Date mandateCreationDate { get; set; }

    /**
     *  The ID of the mandate. A mandate is a signed authorization for UK and NL customers. This field is used only for the direct debit payment method.\n**Character limit**: 36 **Values**: a string of 36 characters or fewer 
     * @return mandateID
     */
    public String mandateID { get; set; }

    /**
     *  Indicates if  the mandate was received. A mandate is a signed authorization for UK and NL customers. This field is used only for the direct debit payment method.\n**Character limit**: 3 **Values**: `Yes`, `No `(case-sensitive) 
     * @return mandateReceived
     */
    public String mandateReceived { get; set; }

    /**
     *  The date when the mandate was last updated, in `yyyy-mm-dd` format. A mandate is a signed authorization for UK and NL customers. This field is used only for the direct debit payment method.\n**Character limit**: 29 
     * @return mandateUpdateDate
     */
    public Date mandateUpdateDate { get; set; }

    /**
     *  Specifies the number of allowable consecutive failures Zuora attempts with the payment method before stopping. When the `UseDefaultRetryRule` field is set to `false`, this field is only required if the `PaymentRetryWindow` field is not defined.\n**Values**: a valid number 
     * @return maxConsecutivePaymentFailures
     */
    public Integer maxConsecutivePaymentFailures { get; set; }

    /**
     * The number of consecutive failed payments for this payment method. It is reset to `0` upon successful payment. \n
     * minimum: 0
     * maximum: 100
     * @return numConsecutiveFailures
     */
    public Integer numConsecutiveFailures { get; set; }

    /**
     *  The retry interval setting, which prevents making a payment attempt if the last failed attempt was within the last specified number of hours. When the `UseDefaultRetryRule` field is set to `false`, this field is only required if the `MaxConsecutivePaymentFailures` field is not defined.\n**Character limit**: 4 **Values**: a whole number between 1 and 1000, exclusive 
     * @return paymentRetryWindow
     */
    public Integer paymentRetryWindow { get; set; }

    /**
     *  The PayPal billing agreement ID, which is a contract between two PayPal accounts. Typically, the selling party initiates a request to create a BAID, and sends it to buying party for acceptance. The seller can keep track of the BAID and use it for future charges against the buyer. This field is only required if the `Type` field is set to `PayPal`.\n**Character limit**: 64 **Values**: a string of 64 characters or fewer 
     * @return paypalBaid
     */
    public String paypalBaid { get; set; }

    /**
     *  The email address associated with the account holder\'s PayPal account or of the PayPal account of the person paying for the service. This field is only required if the `Type` field is set to `PayPal`.\n**Character limit**: 80 **Values**: a string of 80 characters or fewer 
     * @return paypalEmail
     */
    public String paypalEmail { get; set; }

    /**
     *  PayPal\'s Adaptive Payments API key. Zuora does not create this key, nor does it call PayPal to generate it. You must use PayPal\'s Adaptive Payments\' API to generate this key, and then pass it to Zuora. Zuora uses this key to authorize future payments to PayPal\'s Adaptive Payments API. This field is only required if you use PayPal Adaptive Payments gateway.\n**Character limit**: 32 **Values**: a valid PayPal Adaptive Payment pre-approval key 
     * @return paypalPreapprovalKey
     */
    public String paypalPreapprovalKey { get; set; }

    /**
     *  Specifies the PayPal gateway: PayFlow Pro (Express Checkout) or Adaptive Payments. This field is only required if you use PayPal Adaptive Payments or Payflow Pro (Express Checkout) gateways.\n**Character limit**: 32 **Values**: `ExpressCheckout`, `AdaptivePayments` 
     * @return paypalType
     */
    public String paypalType { get; set; }

    /**
     *  The phone number that the account holder registered with the bank. This field is used for credit card validation when passing to a gateway.\n**Character limit**: 40 **Values**: a string of 40 characters or fewer 
     * @return phone
     */
    public String phone { get; set; }

    /**
     *  The zip code of the customer\'s address. This field is used only for the direct debit payment method.\n**Character limit**: 20 **Values**: a string of 20 characters or fewer 
     * @return postalCode
     */
    public String postalCode { get; set; }

    /**
     *  A gateway unique identifier that replaces sensitive payment method data. `SecondTokenId` is conditionally required only when `TokenID` is being used to represent a gateway customer profile. `SecondTokenId` is used in the CC Reference Transaction payment method. **Character limit**: 64 **Values**: a string of 64 characters or fewer 
     * @return secondTokenId
     */
    public String secondTokenId { get; set; }

    /**
     * If you set this field to true, Zuora will create the payment method without making Authorization calls to the gateway. The static field value check will remain as is.\n**Character limit**: 5 **Values**: `true` or `false` 
     * @return skipValidation
     */
    public Boolean skipValidation { get; set; }

    /**
     * The state of the customer\'s address. This field is used only for the direct debit payment method.\n**Character limit**: 70 **Values**: a string of 70 characters or fewer 
     * @return state
     */
    public String state { get; set; }

    /**
     * The street name of the customer\'s address. This field is used only for the direct debit payment method.\n**Character limit**: 100 **Values**: a string of 100 characters or fewer 
     * @return streetName
     */
    public String streetName { get; set; }

    /**
     * The street number of the customer\'s address. This field is used only for the direct debit payment method.\n**Character limit**: 30 **Values**: a string of 30 characters or fewer 
     * @return streetNumber
     */
    public String streetNumber { get; set; }

    /**
     * A gateway unique identifier that replaces sensitive payment method data or represents a gateway\'s unique customer profile. When `TokenId` is used to represent a customer profile, `SecondTokenId` is conditionally required for representing the underlying tokenized payment method. `TokenId` is required for the CC Reference Transaction payment method.\n**Character limit**: 255 **Values**: a string of 255 characters or fewer 
     * @return tokenId
     */
    public String tokenId { get; set; }

    /**
     * The type of payment method. If you want to create an Amazon Pay payment method, specify `CreditCardReferenceTransaction` for this field.
     */
    public enum RTypeEnum {
        ACH,
        APPLEPAY,
        BANKTRANSFER,
        CASH,
        CHECK,
        CREDITCARD,
        CREDITCARDREFERENCETRANSACTION,
        DEBITCARD,
        OTHER,
        PAYPAL,
        WIRETRANSFER
    }

    /**
     * The type of payment method. If you want to create an Amazon Pay payment method, specify `CreditCardReferenceTransaction` for this field.
     * @return r_type
     */
    public String r_type { get; set; }

    /**
     * Determines whether to use the default retry rules configured in the Z-Payments settings. Set this to `true` to use the default retry rules. Set this to `false` to set the specific rules for this payment method. If you set this value to `false`, then the fields, `PaymentRetryWindow` and `MaxConsecutivePaymentFailures`, are required.\n**Character limit**: 5 **Values**: `true` or `false` 
     * @return useDefaultRetryRule
     */
    public Boolean useDefaultRetryRule { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'AccountId' => 'accountId',
        'AchAbaCode' => 'achAbaCode',
        'AchAccountName' => 'achAccountName',
        'AchAccountNumber' => 'achAccountNumber',
        'AchAccountType' => 'achAccountType',
        'AchAddress1' => 'achAddress1',
        'AchAddress2' => 'achAddress2',
        'AchBankName' => 'achBankName',
        'AchCity' => 'achCity',
        'AchCountry' => 'achCountry',
        'AchPostalCode' => 'achPostalCode',
        'AchState' => 'achState',
        'BankBranchCode' => 'bankBranchCode',
        'BankCheckDigit' => 'bankCheckDigit',
        'BankTransferAccountName' => 'bankTransferAccountName',
        'BankTransferAccountNumber' => 'bankTransferAccountNumber',
        'BankTransferAccountNumberMask' => 'bankTransferAccountNumberMask',
        'BankTransferType' => 'bankTransferType',
        'BusinessIdentificationCode' => 'businessIdentificationCode',
        'City' => 'city',
        'CompanyName' => 'companyName',
        'Country' => 'country',
        'CreditCardAddress1' => 'creditCardAddress1',
        'CreditCardAddress2' => 'creditCardAddress2',
        'CreditCardCity' => 'creditCardCity',
        'CreditCardCountry' => 'creditCardCountry',
        'CreditCardExpirationMonth' => 'creditCardExpirationMonth',
        'CreditCardExpirationYear' => 'creditCardExpirationYear',
        'CreditCardHolderName' => 'creditCardHolderName',
        'CreditCardNumber' => 'creditCardNumber',
        'CreditCardPostalCode' => 'creditCardPostalCode',
        'CreditCardSecurityCode' => 'creditCardSecurityCode',
        'CreditCardState' => 'creditCardState',
        'CreditCardType' => 'creditCardType',
        'DeviceSessionId' => 'deviceSessionId',
        'Email' => 'email',
        'ExistingMandate' => 'existingMandate',
        'FirstName' => 'firstName',
        'GatewayOptionData' => 'gatewayOptionData',
        'IPAddress' => 'ipAddress',
        'IdentityNumber' => 'identityNumber',
        'IsCompany' => 'isCompany',
        'LastName' => 'lastName',
        'LastTransactionDateTime' => 'lastTransactionDateTime',
        'MandateCreationDate' => 'mandateCreationDate',
        'MandateID' => 'mandateID',
        'MandateReceived' => 'mandateReceived',
        'MandateUpdateDate' => 'mandateUpdateDate',
        'MaxConsecutivePaymentFailures' => 'maxConsecutivePaymentFailures',
        'NumConsecutiveFailures' => 'numConsecutiveFailures',
        'PaymentRetryWindow' => 'paymentRetryWindow',
        'PaypalBaid' => 'paypalBaid',
        'PaypalEmail' => 'paypalEmail',
        'PaypalPreapprovalKey' => 'paypalPreapprovalKey',
        'PaypalType' => 'paypalType',
        'Phone' => 'phone',
        'PostalCode' => 'postalCode',
        'SecondTokenId' => 'secondTokenId',
        'SkipValidation' => 'skipValidation',
        'State' => 'state',
        'StreetName' => 'streetName',
        'StreetNumber' => 'streetNumber',
        'TokenId' => 'tokenId',
        'Type' => 'r_type',
        'UseDefaultRetryRule' => 'useDefaultRetryRule'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public zc_ProxyCreatePaymentMethod() {
        isCompany = false;
    }

    // public static zc_ProxyCreatePaymentMethod getExample() {
    //     zc_ProxyCreatePaymentMethod proxyCreatePaymentMethod = new zc_ProxyCreatePaymentMethod();
    //     proxyCreatePaymentMethod.accountId = 'aeiou';
    //     proxyCreatePaymentMethod.achAbaCode = 'aeiou';
    //     proxyCreatePaymentMethod.achAccountName = 'aeiou';
    //     proxyCreatePaymentMethod.achAccountNumber = 'aeiou';
    //     proxyCreatePaymentMethod.achAccountType = 'aeiou';
    //     proxyCreatePaymentMethod.achAddress1 = 'aeiou';
    //     proxyCreatePaymentMethod.achAddress2 = 'aeiou';
    //     proxyCreatePaymentMethod.achBankName = 'aeiou';
    //     proxyCreatePaymentMethod.achCity = 'aeiou';
    //     proxyCreatePaymentMethod.achCountry = 'aeiou';
    //     proxyCreatePaymentMethod.achPostalCode = 'aeiou';
    //     proxyCreatePaymentMethod.achState = 'aeiou';
    //     proxyCreatePaymentMethod.bankBranchCode = 'aeiou';
    //     proxyCreatePaymentMethod.bankCheckDigit = 'aeiou';
    //     proxyCreatePaymentMethod.bankTransferAccountName = 'aeiou';
    //     proxyCreatePaymentMethod.bankTransferAccountNumber = 'aeiou';
    //     proxyCreatePaymentMethod.bankTransferAccountNumberMask = 'aeiou';
    //     proxyCreatePaymentMethod.bankTransferType = 'aeiou';
    //     proxyCreatePaymentMethod.businessIdentificationCode = 'aeiou';
    //     proxyCreatePaymentMethod.city = 'aeiou';
    //     proxyCreatePaymentMethod.companyName = 'aeiou';
    //     proxyCreatePaymentMethod.country = 'aeiou';
    //     proxyCreatePaymentMethod.creditCardAddress1 = 'aeiou';
    //     proxyCreatePaymentMethod.creditCardAddress2 = 'aeiou';
    //     proxyCreatePaymentMethod.creditCardCity = 'aeiou';
    //     proxyCreatePaymentMethod.creditCardCountry = 'aeiou';
    //     proxyCreatePaymentMethod.creditCardExpirationMonth = 123;
    //     proxyCreatePaymentMethod.creditCardExpirationYear = 123;
    //     proxyCreatePaymentMethod.creditCardHolderName = 'aeiou';
    //     proxyCreatePaymentMethod.creditCardNumber = 'aeiou';
    //     proxyCreatePaymentMethod.creditCardPostalCode = 'aeiou';
    //     proxyCreatePaymentMethod.creditCardSecurityCode = 'aeiou';
    //     proxyCreatePaymentMethod.creditCardState = 'aeiou';
    //     proxyCreatePaymentMethod.creditCardType = 'aeiou';
    //     proxyCreatePaymentMethod.deviceSessionId = 'aeiou';
    //     proxyCreatePaymentMethod.email = 'aeiou';
    //     proxyCreatePaymentMethod.existingMandate = 'aeiou';
    //     proxyCreatePaymentMethod.firstName = 'aeiou';
    //     proxyCreatePaymentMethod.gatewayOptionData = zc_ProxyCreatePaymentGatewayOptionD.getExample();
    //     proxyCreatePaymentMethod.IBAN = 'aeiou';
    //     proxyCreatePaymentMethod.ipAddress = 'aeiou';
    //     proxyCreatePaymentMethod.identityNumber = 'aeiou';
    //     proxyCreatePaymentMethod.isCompany = true;
    //     proxyCreatePaymentMethod.lastName = 'aeiou';
    //     proxyCreatePaymentMethod.lastTransactionDateTime = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    //     proxyCreatePaymentMethod.mandateCreationDate = Date.newInstance(2000, 1, 23);
    //     proxyCreatePaymentMethod.mandateID = 'aeiou';
    //     proxyCreatePaymentMethod.mandateReceived = 'aeiou';
    //     proxyCreatePaymentMethod.mandateUpdateDate = Date.newInstance(2000, 1, 23);
    //     proxyCreatePaymentMethod.maxConsecutivePaymentFailures = 123;
    //     proxyCreatePaymentMethod.numConsecutiveFailures = 123;
    //     proxyCreatePaymentMethod.paymentRetryWindow = 123;
    //     proxyCreatePaymentMethod.paypalBaid = 'aeiou';
    //     proxyCreatePaymentMethod.paypalEmail = 'aeiou';
    //     proxyCreatePaymentMethod.paypalPreapprovalKey = 'aeiou';
    //     proxyCreatePaymentMethod.paypalType = 'aeiou';
    //     proxyCreatePaymentMethod.phone = 'aeiou';
    //     proxyCreatePaymentMethod.postalCode = 'aeiou';
    //     proxyCreatePaymentMethod.secondTokenId = 'aeiou';
    //     proxyCreatePaymentMethod.skipValidation = true;
    //     proxyCreatePaymentMethod.state = 'aeiou';
    //     proxyCreatePaymentMethod.streetName = 'aeiou';
    //     proxyCreatePaymentMethod.streetNumber = 'aeiou';
    //     proxyCreatePaymentMethod.tokenId = 'aeiou';
    //     proxyCreatePaymentMethod.r_type = RTypeEnum.ACH;
    //     proxyCreatePaymentMethod.useDefaultRetryRule = true;
    //     return proxyCreatePaymentMethod;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_ProxyCreatePaymentMethod) {
            zc_ProxyCreatePaymentMethod proxyCreatePaymentMethod = (zc_ProxyCreatePaymentMethod) obj;
            return this.accountId == proxyCreatePaymentMethod.accountId
                && this.achAbaCode == proxyCreatePaymentMethod.achAbaCode
                && this.achAccountName == proxyCreatePaymentMethod.achAccountName
                && this.achAccountNumber == proxyCreatePaymentMethod.achAccountNumber
                && this.achAccountType == proxyCreatePaymentMethod.achAccountType
                && this.achAddress1 == proxyCreatePaymentMethod.achAddress1
                && this.achAddress2 == proxyCreatePaymentMethod.achAddress2
                && this.achBankName == proxyCreatePaymentMethod.achBankName
                && this.achCity == proxyCreatePaymentMethod.achCity
                && this.achCountry == proxyCreatePaymentMethod.achCountry
                && this.achPostalCode == proxyCreatePaymentMethod.achPostalCode
                && this.achState == proxyCreatePaymentMethod.achState
                && this.bankBranchCode == proxyCreatePaymentMethod.bankBranchCode
                && this.bankCheckDigit == proxyCreatePaymentMethod.bankCheckDigit
                && this.bankTransferAccountName == proxyCreatePaymentMethod.bankTransferAccountName
                && this.bankTransferAccountNumber == proxyCreatePaymentMethod.bankTransferAccountNumber
                && this.bankTransferAccountNumberMask == proxyCreatePaymentMethod.bankTransferAccountNumberMask
                && this.bankTransferType == proxyCreatePaymentMethod.bankTransferType
                && this.businessIdentificationCode == proxyCreatePaymentMethod.businessIdentificationCode
                && this.city == proxyCreatePaymentMethod.city
                && this.companyName == proxyCreatePaymentMethod.companyName
                && this.country == proxyCreatePaymentMethod.country
                && this.creditCardAddress1 == proxyCreatePaymentMethod.creditCardAddress1
                && this.creditCardAddress2 == proxyCreatePaymentMethod.creditCardAddress2
                && this.creditCardCity == proxyCreatePaymentMethod.creditCardCity
                && this.creditCardCountry == proxyCreatePaymentMethod.creditCardCountry
                && this.creditCardExpirationMonth == proxyCreatePaymentMethod.creditCardExpirationMonth
                && this.creditCardExpirationYear == proxyCreatePaymentMethod.creditCardExpirationYear
                && this.creditCardHolderName == proxyCreatePaymentMethod.creditCardHolderName
                && this.creditCardNumber == proxyCreatePaymentMethod.creditCardNumber
                && this.creditCardPostalCode == proxyCreatePaymentMethod.creditCardPostalCode
                && this.creditCardSecurityCode == proxyCreatePaymentMethod.creditCardSecurityCode
                && this.creditCardState == proxyCreatePaymentMethod.creditCardState
                && this.creditCardType == proxyCreatePaymentMethod.creditCardType
                && this.deviceSessionId == proxyCreatePaymentMethod.deviceSessionId
                && this.email == proxyCreatePaymentMethod.email
                && this.existingMandate == proxyCreatePaymentMethod.existingMandate
                && this.firstName == proxyCreatePaymentMethod.firstName
                && this.gatewayOptionData == proxyCreatePaymentMethod.gatewayOptionData
                && this.IBAN == proxyCreatePaymentMethod.IBAN
                && this.ipAddress == proxyCreatePaymentMethod.ipAddress
                && this.identityNumber == proxyCreatePaymentMethod.identityNumber
                && this.isCompany == proxyCreatePaymentMethod.isCompany
                && this.lastName == proxyCreatePaymentMethod.lastName
                && this.lastTransactionDateTime == proxyCreatePaymentMethod.lastTransactionDateTime
                && this.mandateCreationDate == proxyCreatePaymentMethod.mandateCreationDate
                && this.mandateID == proxyCreatePaymentMethod.mandateID
                && this.mandateReceived == proxyCreatePaymentMethod.mandateReceived
                && this.mandateUpdateDate == proxyCreatePaymentMethod.mandateUpdateDate
                && this.maxConsecutivePaymentFailures == proxyCreatePaymentMethod.maxConsecutivePaymentFailures
                && this.numConsecutiveFailures == proxyCreatePaymentMethod.numConsecutiveFailures
                && this.paymentRetryWindow == proxyCreatePaymentMethod.paymentRetryWindow
                && this.paypalBaid == proxyCreatePaymentMethod.paypalBaid
                && this.paypalEmail == proxyCreatePaymentMethod.paypalEmail
                && this.paypalPreapprovalKey == proxyCreatePaymentMethod.paypalPreapprovalKey
                && this.paypalType == proxyCreatePaymentMethod.paypalType
                && this.phone == proxyCreatePaymentMethod.phone
                && this.postalCode == proxyCreatePaymentMethod.postalCode
                && this.secondTokenId == proxyCreatePaymentMethod.secondTokenId
                && this.skipValidation == proxyCreatePaymentMethod.skipValidation
                && this.state == proxyCreatePaymentMethod.state
                && this.streetName == proxyCreatePaymentMethod.streetName
                && this.streetNumber == proxyCreatePaymentMethod.streetNumber
                && this.tokenId == proxyCreatePaymentMethod.tokenId
                && this.r_type == proxyCreatePaymentMethod.r_type
                && this.useDefaultRetryRule == proxyCreatePaymentMethod.useDefaultRetryRule;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (accountId == null ? 0 : System.hashCode(accountId));
        hashCode = (17 * hashCode) + (achAbaCode == null ? 0 : System.hashCode(achAbaCode));
        hashCode = (17 * hashCode) + (achAccountName == null ? 0 : System.hashCode(achAccountName));
        hashCode = (17 * hashCode) + (achAccountNumber == null ? 0 : System.hashCode(achAccountNumber));
        hashCode = (17 * hashCode) + (achAccountType == null ? 0 : System.hashCode(achAccountType));
        hashCode = (17 * hashCode) + (achAddress1 == null ? 0 : System.hashCode(achAddress1));
        hashCode = (17 * hashCode) + (achAddress2 == null ? 0 : System.hashCode(achAddress2));
        hashCode = (17 * hashCode) + (achBankName == null ? 0 : System.hashCode(achBankName));
        hashCode = (17 * hashCode) + (achCity == null ? 0 : System.hashCode(achCity));
        hashCode = (17 * hashCode) + (achCountry == null ? 0 : System.hashCode(achCountry));
        hashCode = (17 * hashCode) + (achPostalCode == null ? 0 : System.hashCode(achPostalCode));
        hashCode = (17 * hashCode) + (achState == null ? 0 : System.hashCode(achState));
        hashCode = (17 * hashCode) + (bankBranchCode == null ? 0 : System.hashCode(bankBranchCode));
        hashCode = (17 * hashCode) + (bankCheckDigit == null ? 0 : System.hashCode(bankCheckDigit));
        hashCode = (17 * hashCode) + (bankTransferAccountName == null ? 0 : System.hashCode(bankTransferAccountName));
        hashCode = (17 * hashCode) + (bankTransferAccountNumber == null ? 0 : System.hashCode(bankTransferAccountNumber));
        hashCode = (17 * hashCode) + (bankTransferAccountNumberMask == null ? 0 : System.hashCode(bankTransferAccountNumberMask));
        hashCode = (17 * hashCode) + (bankTransferType == null ? 0 : System.hashCode(bankTransferType));
        hashCode = (17 * hashCode) + (businessIdentificationCode == null ? 0 : System.hashCode(businessIdentificationCode));
        hashCode = (17 * hashCode) + (city == null ? 0 : System.hashCode(city));
        hashCode = (17 * hashCode) + (companyName == null ? 0 : System.hashCode(companyName));
        hashCode = (17 * hashCode) + (country == null ? 0 : System.hashCode(country));
        hashCode = (17 * hashCode) + (creditCardAddress1 == null ? 0 : System.hashCode(creditCardAddress1));
        hashCode = (17 * hashCode) + (creditCardAddress2 == null ? 0 : System.hashCode(creditCardAddress2));
        hashCode = (17 * hashCode) + (creditCardCity == null ? 0 : System.hashCode(creditCardCity));
        hashCode = (17 * hashCode) + (creditCardCountry == null ? 0 : System.hashCode(creditCardCountry));
        hashCode = (17 * hashCode) + (creditCardExpirationMonth == null ? 0 : System.hashCode(creditCardExpirationMonth));
        hashCode = (17 * hashCode) + (creditCardExpirationYear == null ? 0 : System.hashCode(creditCardExpirationYear));
        hashCode = (17 * hashCode) + (creditCardHolderName == null ? 0 : System.hashCode(creditCardHolderName));
        hashCode = (17 * hashCode) + (creditCardNumber == null ? 0 : System.hashCode(creditCardNumber));
        hashCode = (17 * hashCode) + (creditCardPostalCode == null ? 0 : System.hashCode(creditCardPostalCode));
        hashCode = (17 * hashCode) + (creditCardSecurityCode == null ? 0 : System.hashCode(creditCardSecurityCode));
        hashCode = (17 * hashCode) + (creditCardState == null ? 0 : System.hashCode(creditCardState));
        hashCode = (17 * hashCode) + (creditCardType == null ? 0 : System.hashCode(creditCardType));
        hashCode = (17 * hashCode) + (deviceSessionId == null ? 0 : System.hashCode(deviceSessionId));
        hashCode = (17 * hashCode) + (email == null ? 0 : System.hashCode(email));
        hashCode = (17 * hashCode) + (existingMandate == null ? 0 : System.hashCode(existingMandate));
        hashCode = (17 * hashCode) + (firstName == null ? 0 : System.hashCode(firstName));
        hashCode = (17 * hashCode) + (gatewayOptionData == null ? 0 : System.hashCode(gatewayOptionData));
        hashCode = (17 * hashCode) + (IBAN == null ? 0 : System.hashCode(IBAN));
        hashCode = (17 * hashCode) + (ipAddress == null ? 0 : System.hashCode(ipAddress));
        hashCode = (17 * hashCode) + (identityNumber == null ? 0 : System.hashCode(identityNumber));
        hashCode = (17 * hashCode) + (isCompany == null ? 0 : System.hashCode(isCompany));
        hashCode = (17 * hashCode) + (lastName == null ? 0 : System.hashCode(lastName));
        hashCode = (17 * hashCode) + (lastTransactionDateTime == null ? 0 : System.hashCode(lastTransactionDateTime));
        hashCode = (17 * hashCode) + (mandateCreationDate == null ? 0 : System.hashCode(mandateCreationDate));
        hashCode = (17 * hashCode) + (mandateID == null ? 0 : System.hashCode(mandateID));
        hashCode = (17 * hashCode) + (mandateReceived == null ? 0 : System.hashCode(mandateReceived));
        hashCode = (17 * hashCode) + (mandateUpdateDate == null ? 0 : System.hashCode(mandateUpdateDate));
        hashCode = (17 * hashCode) + (maxConsecutivePaymentFailures == null ? 0 : System.hashCode(maxConsecutivePaymentFailures));
        hashCode = (17 * hashCode) + (numConsecutiveFailures == null ? 0 : System.hashCode(numConsecutiveFailures));
        hashCode = (17 * hashCode) + (paymentRetryWindow == null ? 0 : System.hashCode(paymentRetryWindow));
        hashCode = (17 * hashCode) + (paypalBaid == null ? 0 : System.hashCode(paypalBaid));
        hashCode = (17 * hashCode) + (paypalEmail == null ? 0 : System.hashCode(paypalEmail));
        hashCode = (17 * hashCode) + (paypalPreapprovalKey == null ? 0 : System.hashCode(paypalPreapprovalKey));
        hashCode = (17 * hashCode) + (paypalType == null ? 0 : System.hashCode(paypalType));
        hashCode = (17 * hashCode) + (phone == null ? 0 : System.hashCode(phone));
        hashCode = (17 * hashCode) + (postalCode == null ? 0 : System.hashCode(postalCode));
        hashCode = (17 * hashCode) + (secondTokenId == null ? 0 : System.hashCode(secondTokenId));
        hashCode = (17 * hashCode) + (skipValidation == null ? 0 : System.hashCode(skipValidation));
        hashCode = (17 * hashCode) + (state == null ? 0 : System.hashCode(state));
        hashCode = (17 * hashCode) + (streetName == null ? 0 : System.hashCode(streetName));
        hashCode = (17 * hashCode) + (streetNumber == null ? 0 : System.hashCode(streetNumber));
        hashCode = (17 * hashCode) + (tokenId == null ? 0 : System.hashCode(tokenId));
        hashCode = (17 * hashCode) + (r_type == null ? 0 : System.hashCode(r_type));
        hashCode = (17 * hashCode) + (useDefaultRetryRule == null ? 0 : System.hashCode(useDefaultRetryRule));
        return hashCode;
    }
}