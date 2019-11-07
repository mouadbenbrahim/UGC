/**
 * zc_ProxyGetPaymentMethod
 */
public class zc_ProxyGetPaymentMethod {
    /**
     *  The ID of the customer account associated with this payment method. This field is not required for the account ID. 
     * @return accountId
     */
    public String accountId { get; set; }

    /**
     *  The nine-digit routing number or ABA number used by banks. Use this field for ACH payment methods.\n**Character limit**: 9 **Values**: a string of 9 characters or fewer 
     * @return achAbaCode
     */
    public String achAbaCode { get; set; }

    /**
     *  The name of the account holder, which can be either a person or a company. Use this field for ACH payment methods.\n**Character limit**: 70 **Values**: a string of 70 characters or fewer 
     * @return achAccountName
     */
    public String achAccountName { get; set; }

    /**
     *  This is a masked displayable version of the ACH account number, used for security purposes. For example: `XXXXXXXXX54321`. Use this field for ACH payment methods.\n**Character limit**: 32 **Values**: automatically generated 
     * @return achAccountNumberMask
     */
    public String achAccountNumberMask { get; set; }

    /**
     *  The type of bank account associated with the ACH payment. Use this field for ACH payment methods.\n**Character limit**: 16 **Values**:\n\n- `BusinessChecking`\n- `Checking`\n- `Saving`\n
     * @return achAccountType
     */
    public String achAccountType { get; set; }

    /**
     *  Line 1 for the ACH address. Required on create for the Vantiv payment gateway. Optional for other gateways.\n**Character limit:** **Values:** an address 
     * @return achAddress1
     */
    public String achAddress1 { get; set; }

    /**
     *  Line 2 for the ACH address. Required on create for the Vantiv payment gateway. Optional for other gateways.\n**Character limit:** **Values:** an address 
     * @return achAddress2
     */
    public String achAddress2 { get; set; }

    /**
     *  The name of the bank where the ACH payment account is held. Use this field for ACH payment methods.\n**Character limit**: 70 **Values**: a string of 70 characters or fewer 
     * @return achBankName
     */
    public String achBankName { get; set; }

    /**
     *  Specifies whether a payment method is available in Zuora. This field is used to indicate if a payment method is loaded by the system or created by the customer.\n- `true`: System loaded payment method.\n- `false`: Customer created payment method.\n\nThe default value is `false`.\n**Character limit**: 5 **Values**: `true`, `false` 
     * @return active
     */
    public Boolean active { get; set; }

    /**
     *  The branch code of the bank used for direct debit. Use this field for direct debit payment methods.\n**Character limit**: 10 **Values**:  string of 10 characters or fewer 
     * @return bankBranchCode
     */
    public String bankBranchCode { get; set; }

    /**
     * The check digit in the international bank account number, which confirms the validity of the account. Use this field for direct debit payment methods. **Character limit**: 4 **Values**:  string of 4 characters or fewer 
     * @return bankCheckDigit
     */
    public String bankCheckDigit { get; set; }

    /**
     *  The city of the direct debit bank. Use this field for direct debit payment methods.\n**Character limit**:70 **Values**:  string of 70 characters or fewer 
     * @return bankCity
     */
    public String bankCity { get; set; }

    /**
     *  The sort code or number that identifies the bank. This is also known as the sort code. This field is required for direct debit payment methods.\n**Character limit**: 18 **Values**:  string of 18 characters or fewer 
     * @return bankCode
     */
    public String bankCode { get; set; }

    /**
     *  The first six digits of the payment method\'s number, such as the credit card number or account number. Banks use this number to identify a payment method.\n**Character limit**: 6 **Values**:  string of 6 characters or fewer 
     * @return bankIdentificationNumber
     */
    public String bankIdentificationNumber { get; set; }

    /**
     *  The name of the direct debit bank. Use this field for direct debit payment methods.\n**Character limit**:80 **Values**:  string of 80 characters or fewer 
     * @return bankName
     */
    public String bankName { get; set; }

    /**
     *  The zip code or postal code of the direct debit bank. Use this field for direct debit payment methods.\n**Character limit**:20 **Values**:  string of 20 characters or fewer 
     * @return bankPostalCode
     */
    public String bankPostalCode { get; set; }

    /**
     *  The name of the street of the direct debit bank. Use this field for direct debit payment methods.\n**Character limit**:60 **Values**:  string of 60 characters or fewer 
     * @return bankStreetName
     */
    public String bankStreetName { get; set; }

    /**
     *  The number of the direct debit bank. Use this field for direct debit payment methods.\n**Character limit**:10 **Values**:  string of 10 characters or fewer 
     * @return bankStreetNumber
     */
    public String bankStreetNumber { get; set; }

    /**
     *  The name on the direct debit bank account. Use this field for direct debit payment methods.\n**Character limit**: 60 **Values**:  string of 60 characters or fewer 
     * @return bankTransferAccountName
     */
    public String bankTransferAccountName { get; set; }

    /**
     * The number of the customer\'s bank account. Use this field for direct debit payment methods.\n\n**Character limit**: 30\n**Values**: a string of 30 characters or fewer\n
     * @return bankTransferAccountNumber
     */
    public String bankTransferAccountNumber { get; set; }

    /**
     *  This is a masked displayable version of the bank account number, used for security purposes. For example: `XXXXXXXXX54321`.\n**Character limit**: 32 **Values**: automatically generated 
     * @return bankTransferAccountNumberMask
     */
    public String bankTransferAccountNumberMask { get; set; }

    /**
     *  The type of the customer\'s bank account. Use this field for direct debit payment methods.\n**Character limit**: 11 **Values**: `DirectDebit` 
     * @return bankTransferAccountType
     */
    public String bankTransferAccountType { get; set; }

    /**
     * The type of direct debit transfer. The value of this field is dependent on the country of the user. This field is only required if the `Type` field is set to `BankTransfer`.\n\n **Values**: \n\n   - `SEPA`\n   \n   - `AutomatischIncasso` (NL)\n\n   - `LastschriftDE` (Germany)\n\n   - `LastschriftAT` (Austria)\n\n   - `DemandeDePrelevement` (FR)\n\n   - `DirectDebitUK` (UK)\n\n   - `Domicil` (Belgium)\n\n   - `LastschriftCH` (CH)\n\n   - `RID` (Italy)\n\n   - `OrdenDeDomiciliacion` (Spain)\n   - `Autogiro` (Sweden)\n   - `Betalingsservice` (Denmark)\n
     * @return bankTransferType
     */
    public String bankTransferType { get; set; }

    /**
     *  The business identification code for Swiss direct payment methods that use the Global Collect payment gateway. Use this field only for direct debit payments in Switzerland with Global Collect.\n**Character limit**: 11 **Values**: string of 11 characters or fewer 
     * @return businessIdentificationCode
     */
    public String businessIdentificationCode { get; set; }

    /**
     *  The city of the customer\'s address. Use this field for direct debit payment methods.\n**Character limit**:80 **Values**:  string of 80 characters or fewer 
     * @return city
     */
    public String city { get; set; }

    /**
     * The name of the company.\n
     * @return companyName
     */
    public String companyName { get; set; }

    /**
     *  The two-letter country code of the customer\'s address. Use this field for direct debit payment methods.\n**Character limit**: 2 **Values**: a valid country code 
     * @return country
     */
    public String country { get; set; }

    /**
     *  The user ID of the person who created the `PaymentMethod` object when there is a login user in the user session. In Hosted Payment Method and Zuora Checkout pages, this field is set to 3 as there is no login user to initiate a user session.\n**Character limit**: 32 **Values**: automatically generated 
     * @return createdById
     */
    public String createdById { get; set; }

    /**
     *  The date when the `PaymentMethod` object was created in the Zuora system.\n**Character limit**: 29 **Values**: automatically generated 
     * @return createdDate
     */
    public Datetime createdDate { get; set; }

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
     *  The expiration month of the credit card or debit card. Use this field for credit card and direct debit payment methods.\n**Character limit**: 2 **Values**: a two-digit number, 01 - 12 
     * @return creditCardExpirationMonth
     */
    public Integer creditCardExpirationMonth { get; set; }

    /**
     *  The expiration month of the credit card or debit card. Use this field for credit card and direct debit payment methods.\n**Character limit**: 4 **Values**: a four-digit number 
     * @return creditCardExpirationYear
     */
    public Integer creditCardExpirationYear { get; set; }

    /**
     *  The full name of the card holder. Use this field for credit card and direct debit payment methods.\n**Character limit**: 50 **Values**: a string of 50 characters or fewer 
     * @return creditCardHolderName
     */
    public String creditCardHolderName { get; set; }

    /**
     *  A masked version of the credit or debit card number.\n**Character limit**: 32 **Values**: automatically generated 
     * @return creditCardMaskNumber
     */
    public String creditCardMaskNumber { get; set; }

    /**
     *  The billing address\'s zip code. This field is required only when you define a debit card or credit card payment.\n**Character limit**: 20 **Values**: a string of 20 characters or fewer 
     * @return creditCardPostalCode
     */
    public String creditCardPostalCode { get; set; }

    /**
     *  The billing address\'s state. Use this field is if the `CreditCardCountry` value is either Canada or the US. State names must be spelled in full. 
     * @return creditCardState
     */
    public String creditCardState { get; set; }

    /**
     * The type of the credit card.\n    \nPossible values  include `Visa`, `MasterCard`, `AmericanExpress`, `Discover`, `JCB`, and `Diners`. For more information about credit card types supported by different payment gateways, see [Supported Payment Gateways](https://knowledgecenter.zuora.com/CB_Billing/M_Payment_Gateways/Supported_Payment_Gateways).\n
     * @return creditCardType
     */
    public String creditCardType { get; set; }

    /**
     *  The session ID of the user when the `PaymentMethod` was created or updated. Some gateways use this field for fraud prevention. If this field is passed to Zuora, then Zuora passes this field to supported gateways. Currently only Verifi supports this field.\n**Character limit**: 255 
     * @return deviceSessionId
     */
    public String deviceSessionId { get; set; }

    /**
     *  An email address for the payment method in addition to the bill to contact email address.\n**Character limit**: 80 **Values**: a string of 80 characters or fewer 
     * @return email
     */
    public String email { get; set; }

    /**
     *  Indicates if the customer has an existing mandate or a new mandate. A mandate is a signed authorization for UK and NL customers. When you are migrating mandates from another system, be sure to set this field correctly. If you indicate that a new mandate is an existing mandate or vice-versa, then transactions fail. This field is used only for the direct debit payment method.\n**Character limit**: 3 **Values**: `Yes` or `No` 
     * @return existingMandate
     */
    public String existingMandate { get; set; }

    /**
     *  The customer\'s first name. This field is used only for the direct debit payment method.\n**Character limit**: 30 **Values**: a string of 30 characters or fewer 
     * @return firstName
     */
    public String firstName { get; set; }

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
     * Object identifier.
     * @return id
     */
    public String id { get; set; }

    /**
     * The unique identity number of the customer account. \n
     * @return identityNumber
     */
    public String identityNumber { get; set; }

    /**
     * Whether the customer account is a company.\n
     * @return isCompany
     */
    public Boolean isCompany { get; set; }

    /**
     *  The date of the last failed attempt to collect payment with this payment method.\n**Character limit**: 29 **Values**: automatically generated 
     * @return lastFailedSaleTransactionDate
     */
    public Datetime lastFailedSaleTransactionDate { get; set; }

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
     *  The status of the most recent transaction.\n**Character limit**: 39 **Values**: automatically generated 
     * @return lastTransactionStatus
     */
    public String lastTransactionStatus { get; set; }

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
     *  Indicates if  the mandate was received. A mandate is a signed authorization for UK and NL customers. This field is used only for the direct debit payment method.\n**Character limit**: 3 **Values**: `Yes` or `No `(case-sensitive) 
     * @return mandateReceived
     */
    public String mandateReceived { get; set; }

    /**
     *  The date when the mandate was last updated, in `yyyy-mm-dd` format. A mandate is a signed authorization for UK and NL customers. This field is used only for the direct debit payment method.\n**Character limit**: 29 
     * @return mandateUpdateDate
     */
    public Date mandateUpdateDate { get; set; }

    /**
     *  Specifies the number of allowable consecutive failures Zuora attempts with the payment method before stopping.\n**Values**: a valid number 
     * @return maxConsecutivePaymentFailures
     */
    public Integer maxConsecutivePaymentFailures { get; set; }

    /**
     * The name of the payment method.
     * @return name
     */
    public String name { get; set; }

    /**
     * The number of consecutive failed payments for this payment method. It is reset to `0` upon successful payment. \n
     * minimum: 0
     * maximum: 100
     * @return numConsecutiveFailures
     */
    public Integer numConsecutiveFailures { get; set; }

    /**
     *  This field is used to indicate the status of the payment method created within an account. It is set to `Active` on creation.\n**Character limit**: 6 **Values**: `Active` or `Closed`\n
     * @return paymentMethodStatus
     */
    public String paymentMethodStatus { get; set; }

    /**
     *  The retry interval setting, which prevents making a payment attempt if the last failed attempt was within the last specified number of hours. This field is required if the `UseDefaultRetryRule` field value is set to `false`.\n**Character limit**: 4 **Values**: a whole number between 1 and 1000, exclusive 
     * @return paymentRetryWindow
     */
    public Integer paymentRetryWindow { get; set; }

    /**
     *  The PayPal billing agreement ID, which is a contract between two PayPal accounts. Typically, the selling party initiates a request to create a BAID, and sends it to buying party for acceptance. The seller can keep track of the BAID and use it for future charges against the buyer. This field is required when defining a PayPal payment method.\n**Character limit**: 64 **Values**: a string of 64 characters or fewer 
     * @return paypalBaid
     */
    public String paypalBaid { get; set; }

    /**
     *  The email address associated with the account holder\'s PayPal account or of the PayPal account of the person paying for the service. This field is required only when you define a PayPal payment method.\n**Character limit**: 80 **Values**: a string of 80 characters or fewer 
     * @return paypalEmail
     */
    public String paypalEmail { get; set; }

    /**
     *  PayPal\'s Adaptive Payments API key. Zuora does not create this key, nor does it call PayPal to generate it. You must use PayPal\'s Adaptive Payments\' API to generate this key, and then pass it to Zuora. Zuora uses this key to authorize future payments to PayPal\'s Adaptive Payments API. This field is required when you use PayPal Adaptive Payments gateway.\n**Character limit**: 32 **Values**: a valid PayPal Adaptive Payment pre-approval key 
     * @return paypalPreapprovalKey
     */
    public String paypalPreapprovalKey { get; set; }

    /**
     *  Specifies the PayPal gateway: PayFlow Pro (Express Checkout) or Adaptive Payments. This field is required when you use PayPal Adaptive Payments or Payflow Pro (Express Checkout) gateways.\n**Character limit**: 32 **Values**: `ExpressCheckout` or `AdaptivePayments` 
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
     *  A gateway unique identifier that replaces sensitive payment method data. SecondTokenId is conditionally required only when TokenID is being used to represent a gateway customer profile. SecondTokenId is used in the CC Reference Transaction payment method. **Character limit**: 64 **Values**: a string of 64 characters or fewer 
     * @return secondTokenId
     */
    public String secondTokenId { get; set; }

    /**
     *  The state of the customer\'s address. This field is used only for the direct debit payment method.\n**Character limit**: 70 **Values**: a string of 70 characters or fewer 
     * @return state
     */
    public String state { get; set; }

    /**
     *  The street name of the customer\'s address. This field is used only for the direct debit payment method.\n**Character limit**: 100 **Values**: a string of 100 characters or fewer 
     * @return streetName
     */
    public String streetName { get; set; }

    /**
     *  The street number of the customer\'s address. This field is used only for the direct debit payment method.\n**Character limit**: 30 **Values**: a string of 30 characters or fewer 
     * @return streetNumber
     */
    public String streetNumber { get; set; }

    /**
     *  A gateway unique identifier that replaces sensitive payment method data or represents a gateway\'s unique customer profile. `TokenId` is required for the CC Reference Transaction payment method.\n**Character limit**: 255 **Values**: a string of 255 characters or fewer 
     * @return tokenId
     */
    public String tokenId { get; set; }

    /**
     *  The number of error payments that used this payment method.\n**Character limit**: **Values**: automatically generated 
     * @return totalNumberOfErrorPayments
     */
    public Integer totalNumberOfErrorPayments { get; set; }

    /**
     *  The number of successful payments that used this payment method.\n**Character limit**: **Values**: automatically generated 
     * @return totalNumberOfProcessedPayments
     */
    public Integer totalNumberOfProcessedPayments { get; set; }

    /**
     * The type of payment method. 
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
     * The type of payment method. 
     * @return r_type
     */
    public RTypeEnum r_type { get; set; }

    /**
     *  The ID of the user who last updated the payment method.\n**Character limit**: 32 **Values**: automatically generated 
     * @return updatedById
     */
    public String updatedById { get; set; }

    /**
     *  The date when the payment method was last updated.\n**Character limit**: 29 **Values**: automatically generated 
     * @return updatedDate
     */
    public Datetime updatedDate { get; set; }

    /**
     *  Determines whether to use the default retry rules configured in the Zuora Payments settings. Set this to `true` to use the default retry rules. Set this to `false` to set the specific rules for this payment method. If you set this value to `false`, then the fields, `PaymentRetryWindow` and `MaxConsecutivePaymentFailures`, are required.\n**Character limit**: 5 **Values**: `t``rue`, `false` 
     * @return useDefaultRetryRule
     */
    public Boolean useDefaultRetryRule { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'AccountId' => 'accountId',
        'AchAbaCode' => 'achAbaCode',
        'AchAccountName' => 'achAccountName',
        'AchAccountNumberMask' => 'achAccountNumberMask',
        'AchAccountType' => 'achAccountType',
        'AchAddress1' => 'achAddress1',
        'AchAddress2' => 'achAddress2',
        'AchBankName' => 'achBankName',
        'Active' => 'active',
        'BankBranchCode' => 'bankBranchCode',
        'BankCheckDigit' => 'bankCheckDigit',
        'BankCity' => 'bankCity',
        'BankCode' => 'bankCode',
        'BankIdentificationNumber' => 'bankIdentificationNumber',
        'BankName' => 'bankName',
        'BankPostalCode' => 'bankPostalCode',
        'BankStreetName' => 'bankStreetName',
        'BankStreetNumber' => 'bankStreetNumber',
        'BankTransferAccountName' => 'bankTransferAccountName',
        'BankTransferAccountNumber' => 'bankTransferAccountNumber',
        'BankTransferAccountNumberMask' => 'bankTransferAccountNumberMask',
        'BankTransferAccountType' => 'bankTransferAccountType',
        'BankTransferType' => 'bankTransferType',
        'BusinessIdentificationCode' => 'businessIdentificationCode',
        'City' => 'city',
        'CompanyName' => 'companyName',
        'Country' => 'country',
        'CreatedById' => 'createdById',
        'CreatedDate' => 'createdDate',
        'CreditCardAddress1' => 'creditCardAddress1',
        'CreditCardAddress2' => 'creditCardAddress2',
        'CreditCardCity' => 'creditCardCity',
        'CreditCardCountry' => 'creditCardCountry',
        'CreditCardExpirationMonth' => 'creditCardExpirationMonth',
        'CreditCardExpirationYear' => 'creditCardExpirationYear',
        'CreditCardHolderName' => 'creditCardHolderName',
        'CreditCardMaskNumber' => 'creditCardMaskNumber',
        'CreditCardPostalCode' => 'creditCardPostalCode',
        'CreditCardState' => 'creditCardState',
        'CreditCardType' => 'creditCardType',
        'DeviceSessionId' => 'deviceSessionId',
        'Email' => 'email',
        'ExistingMandate' => 'existingMandate',
        'FirstName' => 'firstName',
        'IPAddress' => 'ipAddress',
        'Id' => 'id',
        'IdentityNumber' => 'identityNumber',
        'IsCompany' => 'isCompany',
        'LastFailedSaleTransactionDate' => 'lastFailedSaleTransactionDate',
        'LastName' => 'lastName',
        'LastTransactionDateTime' => 'lastTransactionDateTime',
        'LastTransactionStatus' => 'lastTransactionStatus',
        'MandateCreationDate' => 'mandateCreationDate',
        'MandateID' => 'mandateID',
        'MandateReceived' => 'mandateReceived',
        'MandateUpdateDate' => 'mandateUpdateDate',
        'MaxConsecutivePaymentFailures' => 'maxConsecutivePaymentFailures',
        'Name' => 'name',
        'NumConsecutiveFailures' => 'numConsecutiveFailures',
        'PaymentMethodStatus' => 'paymentMethodStatus',
        'PaymentRetryWindow' => 'paymentRetryWindow',
        'PaypalBaid' => 'paypalBaid',
        'PaypalEmail' => 'paypalEmail',
        'PaypalPreapprovalKey' => 'paypalPreapprovalKey',
        'PaypalType' => 'paypalType',
        'Phone' => 'phone',
        'PostalCode' => 'postalCode',
        'SecondTokenId' => 'secondTokenId',
        'State' => 'state',
        'StreetName' => 'streetName',
        'StreetNumber' => 'streetNumber',
        'TokenId' => 'tokenId',
        'TotalNumberOfErrorPayments' => 'totalNumberOfErrorPayments',
        'TotalNumberOfProcessedPayments' => 'totalNumberOfProcessedPayments',
        'Type' => 'r_type',
        'UpdatedById' => 'updatedById',
        'UpdatedDate' => 'updatedDate',
        'UseDefaultRetryRule' => 'useDefaultRetryRule'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    // public static zc_ProxyGetPaymentMethod getExample() {
    //     zc_ProxyGetPaymentMethod proxyGetPaymentMethod = new zc_ProxyGetPaymentMethod();
    //     proxyGetPaymentMethod.accountId = 'aeiou';
    //     proxyGetPaymentMethod.achAbaCode = 'aeiou';
    //     proxyGetPaymentMethod.achAccountName = 'aeiou';
    //     proxyGetPaymentMethod.achAccountNumberMask = 'aeiou';
    //     proxyGetPaymentMethod.achAccountType = 'aeiou';
    //     proxyGetPaymentMethod.achAddress1 = 'aeiou';
    //     proxyGetPaymentMethod.achAddress2 = 'aeiou';
    //     proxyGetPaymentMethod.achBankName = 'aeiou';
    //     proxyGetPaymentMethod.active = true;
    //     proxyGetPaymentMethod.bankBranchCode = 'aeiou';
    //     proxyGetPaymentMethod.bankCheckDigit = 'aeiou';
    //     proxyGetPaymentMethod.bankCity = 'aeiou';
    //     proxyGetPaymentMethod.bankCode = 'aeiou';
    //     proxyGetPaymentMethod.bankIdentificationNumber = 'aeiou';
    //     proxyGetPaymentMethod.bankName = 'aeiou';
    //     proxyGetPaymentMethod.bankPostalCode = 'aeiou';
    //     proxyGetPaymentMethod.bankStreetName = 'aeiou';
    //     proxyGetPaymentMethod.bankStreetNumber = 'aeiou';
    //     proxyGetPaymentMethod.bankTransferAccountName = 'aeiou';
    //     proxyGetPaymentMethod.bankTransferAccountNumber = 'aeiou';
    //     proxyGetPaymentMethod.bankTransferAccountNumberMask = 'aeiou';
    //     proxyGetPaymentMethod.bankTransferAccountType = 'aeiou';
    //     proxyGetPaymentMethod.bankTransferType = 'aeiou';
    //     proxyGetPaymentMethod.businessIdentificationCode = 'aeiou';
    //     proxyGetPaymentMethod.city = 'aeiou';
    //     proxyGetPaymentMethod.companyName = 'aeiou';
    //     proxyGetPaymentMethod.country = 'aeiou';
    //     proxyGetPaymentMethod.createdById = 'aeiou';
    //     proxyGetPaymentMethod.createdDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    //     proxyGetPaymentMethod.creditCardAddress1 = 'aeiou';
    //     proxyGetPaymentMethod.creditCardAddress2 = 'aeiou';
    //     proxyGetPaymentMethod.creditCardCity = 'aeiou';
    //     proxyGetPaymentMethod.creditCardCountry = 'aeiou';
    //     proxyGetPaymentMethod.creditCardExpirationMonth = 123;
    //     proxyGetPaymentMethod.creditCardExpirationYear = 123;
    //     proxyGetPaymentMethod.creditCardHolderName = 'aeiou';
    //     proxyGetPaymentMethod.creditCardMaskNumber = 'aeiou';
    //     proxyGetPaymentMethod.creditCardPostalCode = 'aeiou';
    //     proxyGetPaymentMethod.creditCardState = 'aeiou';
    //     proxyGetPaymentMethod.creditCardType = 'aeiou';
    //     proxyGetPaymentMethod.deviceSessionId = 'aeiou';
    //     proxyGetPaymentMethod.email = 'aeiou';
    //     proxyGetPaymentMethod.existingMandate = 'aeiou';
    //     proxyGetPaymentMethod.firstName = 'aeiou';
    //     proxyGetPaymentMethod.IBAN = 'aeiou';
    //     proxyGetPaymentMethod.ipAddress = 'aeiou';
    //     proxyGetPaymentMethod.id = 'aeiou';
    //     proxyGetPaymentMethod.identityNumber = 'aeiou';
    //     proxyGetPaymentMethod.isCompany = true;
    //     proxyGetPaymentMethod.lastFailedSaleTransactionDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    //     proxyGetPaymentMethod.lastName = 'aeiou';
    //     proxyGetPaymentMethod.lastTransactionDateTime = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    //     proxyGetPaymentMethod.lastTransactionStatus = 'aeiou';
    //     proxyGetPaymentMethod.mandateCreationDate = Date.newInstance(2000, 1, 23);
    //     proxyGetPaymentMethod.mandateID = 'aeiou';
    //     proxyGetPaymentMethod.mandateReceived = 'aeiou';
    //     proxyGetPaymentMethod.mandateUpdateDate = Date.newInstance(2000, 1, 23);
    //     proxyGetPaymentMethod.maxConsecutivePaymentFailures = 123;
    //     proxyGetPaymentMethod.name = 'aeiou';
    //     proxyGetPaymentMethod.numConsecutiveFailures = 123;
    //     proxyGetPaymentMethod.paymentMethodStatus = 'aeiou';
    //     proxyGetPaymentMethod.paymentRetryWindow = 123;
    //     proxyGetPaymentMethod.paypalBaid = 'aeiou';
    //     proxyGetPaymentMethod.paypalEmail = 'aeiou';
    //     proxyGetPaymentMethod.paypalPreapprovalKey = 'aeiou';
    //     proxyGetPaymentMethod.paypalType = 'aeiou';
    //     proxyGetPaymentMethod.phone = 'aeiou';
    //     proxyGetPaymentMethod.postalCode = 'aeiou';
    //     proxyGetPaymentMethod.secondTokenId = 'aeiou';
    //     proxyGetPaymentMethod.state = 'aeiou';
    //     proxyGetPaymentMethod.streetName = 'aeiou';
    //     proxyGetPaymentMethod.streetNumber = 'aeiou';
    //     proxyGetPaymentMethod.tokenId = 'aeiou';
    //     proxyGetPaymentMethod.totalNumberOfErrorPayments = 123;
    //     proxyGetPaymentMethod.totalNumberOfProcessedPayments = 123;
    //     proxyGetPaymentMethod.r_type = RTypeEnum.ACH;
    //     proxyGetPaymentMethod.updatedById = 'aeiou';
    //     proxyGetPaymentMethod.updatedDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    //     proxyGetPaymentMethod.useDefaultRetryRule = true;
    //     return proxyGetPaymentMethod;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_ProxyGetPaymentMethod) {
            zc_ProxyGetPaymentMethod proxyGetPaymentMethod = (zc_ProxyGetPaymentMethod) obj;
            return this.accountId == proxyGetPaymentMethod.accountId
                && this.achAbaCode == proxyGetPaymentMethod.achAbaCode
                && this.achAccountName == proxyGetPaymentMethod.achAccountName
                && this.achAccountNumberMask == proxyGetPaymentMethod.achAccountNumberMask
                && this.achAccountType == proxyGetPaymentMethod.achAccountType
                && this.achAddress1 == proxyGetPaymentMethod.achAddress1
                && this.achAddress2 == proxyGetPaymentMethod.achAddress2
                && this.achBankName == proxyGetPaymentMethod.achBankName
                && this.active == proxyGetPaymentMethod.active
                && this.bankBranchCode == proxyGetPaymentMethod.bankBranchCode
                && this.bankCheckDigit == proxyGetPaymentMethod.bankCheckDigit
                && this.bankCity == proxyGetPaymentMethod.bankCity
                && this.bankCode == proxyGetPaymentMethod.bankCode
                && this.bankIdentificationNumber == proxyGetPaymentMethod.bankIdentificationNumber
                && this.bankName == proxyGetPaymentMethod.bankName
                && this.bankPostalCode == proxyGetPaymentMethod.bankPostalCode
                && this.bankStreetName == proxyGetPaymentMethod.bankStreetName
                && this.bankStreetNumber == proxyGetPaymentMethod.bankStreetNumber
                && this.bankTransferAccountName == proxyGetPaymentMethod.bankTransferAccountName
                && this.bankTransferAccountNumber == proxyGetPaymentMethod.bankTransferAccountNumber
                && this.bankTransferAccountNumberMask == proxyGetPaymentMethod.bankTransferAccountNumberMask
                && this.bankTransferAccountType == proxyGetPaymentMethod.bankTransferAccountType
                && this.bankTransferType == proxyGetPaymentMethod.bankTransferType
                && this.businessIdentificationCode == proxyGetPaymentMethod.businessIdentificationCode
                && this.city == proxyGetPaymentMethod.city
                && this.companyName == proxyGetPaymentMethod.companyName
                && this.country == proxyGetPaymentMethod.country
                && this.createdById == proxyGetPaymentMethod.createdById
                && this.createdDate == proxyGetPaymentMethod.createdDate
                && this.creditCardAddress1 == proxyGetPaymentMethod.creditCardAddress1
                && this.creditCardAddress2 == proxyGetPaymentMethod.creditCardAddress2
                && this.creditCardCity == proxyGetPaymentMethod.creditCardCity
                && this.creditCardCountry == proxyGetPaymentMethod.creditCardCountry
                && this.creditCardExpirationMonth == proxyGetPaymentMethod.creditCardExpirationMonth
                && this.creditCardExpirationYear == proxyGetPaymentMethod.creditCardExpirationYear
                && this.creditCardHolderName == proxyGetPaymentMethod.creditCardHolderName
                && this.creditCardMaskNumber == proxyGetPaymentMethod.creditCardMaskNumber
                && this.creditCardPostalCode == proxyGetPaymentMethod.creditCardPostalCode
                && this.creditCardState == proxyGetPaymentMethod.creditCardState
                && this.creditCardType == proxyGetPaymentMethod.creditCardType
                && this.deviceSessionId == proxyGetPaymentMethod.deviceSessionId
                && this.email == proxyGetPaymentMethod.email
                && this.existingMandate == proxyGetPaymentMethod.existingMandate
                && this.firstName == proxyGetPaymentMethod.firstName
                && this.IBAN == proxyGetPaymentMethod.IBAN
                && this.ipAddress == proxyGetPaymentMethod.ipAddress
                && this.id == proxyGetPaymentMethod.id
                && this.identityNumber == proxyGetPaymentMethod.identityNumber
                && this.isCompany == proxyGetPaymentMethod.isCompany
                && this.lastFailedSaleTransactionDate == proxyGetPaymentMethod.lastFailedSaleTransactionDate
                && this.lastName == proxyGetPaymentMethod.lastName
                && this.lastTransactionDateTime == proxyGetPaymentMethod.lastTransactionDateTime
                && this.lastTransactionStatus == proxyGetPaymentMethod.lastTransactionStatus
                && this.mandateCreationDate == proxyGetPaymentMethod.mandateCreationDate
                && this.mandateID == proxyGetPaymentMethod.mandateID
                && this.mandateReceived == proxyGetPaymentMethod.mandateReceived
                && this.mandateUpdateDate == proxyGetPaymentMethod.mandateUpdateDate
                && this.maxConsecutivePaymentFailures == proxyGetPaymentMethod.maxConsecutivePaymentFailures
                && this.name == proxyGetPaymentMethod.name
                && this.numConsecutiveFailures == proxyGetPaymentMethod.numConsecutiveFailures
                && this.paymentMethodStatus == proxyGetPaymentMethod.paymentMethodStatus
                && this.paymentRetryWindow == proxyGetPaymentMethod.paymentRetryWindow
                && this.paypalBaid == proxyGetPaymentMethod.paypalBaid
                && this.paypalEmail == proxyGetPaymentMethod.paypalEmail
                && this.paypalPreapprovalKey == proxyGetPaymentMethod.paypalPreapprovalKey
                && this.paypalType == proxyGetPaymentMethod.paypalType
                && this.phone == proxyGetPaymentMethod.phone
                && this.postalCode == proxyGetPaymentMethod.postalCode
                && this.secondTokenId == proxyGetPaymentMethod.secondTokenId
                && this.state == proxyGetPaymentMethod.state
                && this.streetName == proxyGetPaymentMethod.streetName
                && this.streetNumber == proxyGetPaymentMethod.streetNumber
                && this.tokenId == proxyGetPaymentMethod.tokenId
                && this.totalNumberOfErrorPayments == proxyGetPaymentMethod.totalNumberOfErrorPayments
                && this.totalNumberOfProcessedPayments == proxyGetPaymentMethod.totalNumberOfProcessedPayments
                && this.r_type == proxyGetPaymentMethod.r_type
                && this.updatedById == proxyGetPaymentMethod.updatedById
                && this.updatedDate == proxyGetPaymentMethod.updatedDate
                && this.useDefaultRetryRule == proxyGetPaymentMethod.useDefaultRetryRule;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (accountId == null ? 0 : System.hashCode(accountId));
        hashCode = (17 * hashCode) + (achAbaCode == null ? 0 : System.hashCode(achAbaCode));
        hashCode = (17 * hashCode) + (achAccountName == null ? 0 : System.hashCode(achAccountName));
        hashCode = (17 * hashCode) + (achAccountNumberMask == null ? 0 : System.hashCode(achAccountNumberMask));
        hashCode = (17 * hashCode) + (achAccountType == null ? 0 : System.hashCode(achAccountType));
        hashCode = (17 * hashCode) + (achAddress1 == null ? 0 : System.hashCode(achAddress1));
        hashCode = (17 * hashCode) + (achAddress2 == null ? 0 : System.hashCode(achAddress2));
        hashCode = (17 * hashCode) + (achBankName == null ? 0 : System.hashCode(achBankName));
        hashCode = (17 * hashCode) + (active == null ? 0 : System.hashCode(active));
        hashCode = (17 * hashCode) + (bankBranchCode == null ? 0 : System.hashCode(bankBranchCode));
        hashCode = (17 * hashCode) + (bankCheckDigit == null ? 0 : System.hashCode(bankCheckDigit));
        hashCode = (17 * hashCode) + (bankCity == null ? 0 : System.hashCode(bankCity));
        hashCode = (17 * hashCode) + (bankCode == null ? 0 : System.hashCode(bankCode));
        hashCode = (17 * hashCode) + (bankIdentificationNumber == null ? 0 : System.hashCode(bankIdentificationNumber));
        hashCode = (17 * hashCode) + (bankName == null ? 0 : System.hashCode(bankName));
        hashCode = (17 * hashCode) + (bankPostalCode == null ? 0 : System.hashCode(bankPostalCode));
        hashCode = (17 * hashCode) + (bankStreetName == null ? 0 : System.hashCode(bankStreetName));
        hashCode = (17 * hashCode) + (bankStreetNumber == null ? 0 : System.hashCode(bankStreetNumber));
        hashCode = (17 * hashCode) + (bankTransferAccountName == null ? 0 : System.hashCode(bankTransferAccountName));
        hashCode = (17 * hashCode) + (bankTransferAccountNumber == null ? 0 : System.hashCode(bankTransferAccountNumber));
        hashCode = (17 * hashCode) + (bankTransferAccountNumberMask == null ? 0 : System.hashCode(bankTransferAccountNumberMask));
        hashCode = (17 * hashCode) + (bankTransferAccountType == null ? 0 : System.hashCode(bankTransferAccountType));
        hashCode = (17 * hashCode) + (bankTransferType == null ? 0 : System.hashCode(bankTransferType));
        hashCode = (17 * hashCode) + (businessIdentificationCode == null ? 0 : System.hashCode(businessIdentificationCode));
        hashCode = (17 * hashCode) + (city == null ? 0 : System.hashCode(city));
        hashCode = (17 * hashCode) + (companyName == null ? 0 : System.hashCode(companyName));
        hashCode = (17 * hashCode) + (country == null ? 0 : System.hashCode(country));
        hashCode = (17 * hashCode) + (createdById == null ? 0 : System.hashCode(createdById));
        hashCode = (17 * hashCode) + (createdDate == null ? 0 : System.hashCode(createdDate));
        hashCode = (17 * hashCode) + (creditCardAddress1 == null ? 0 : System.hashCode(creditCardAddress1));
        hashCode = (17 * hashCode) + (creditCardAddress2 == null ? 0 : System.hashCode(creditCardAddress2));
        hashCode = (17 * hashCode) + (creditCardCity == null ? 0 : System.hashCode(creditCardCity));
        hashCode = (17 * hashCode) + (creditCardCountry == null ? 0 : System.hashCode(creditCardCountry));
        hashCode = (17 * hashCode) + (creditCardExpirationMonth == null ? 0 : System.hashCode(creditCardExpirationMonth));
        hashCode = (17 * hashCode) + (creditCardExpirationYear == null ? 0 : System.hashCode(creditCardExpirationYear));
        hashCode = (17 * hashCode) + (creditCardHolderName == null ? 0 : System.hashCode(creditCardHolderName));
        hashCode = (17 * hashCode) + (creditCardMaskNumber == null ? 0 : System.hashCode(creditCardMaskNumber));
        hashCode = (17 * hashCode) + (creditCardPostalCode == null ? 0 : System.hashCode(creditCardPostalCode));
        hashCode = (17 * hashCode) + (creditCardState == null ? 0 : System.hashCode(creditCardState));
        hashCode = (17 * hashCode) + (creditCardType == null ? 0 : System.hashCode(creditCardType));
        hashCode = (17 * hashCode) + (deviceSessionId == null ? 0 : System.hashCode(deviceSessionId));
        hashCode = (17 * hashCode) + (email == null ? 0 : System.hashCode(email));
        hashCode = (17 * hashCode) + (existingMandate == null ? 0 : System.hashCode(existingMandate));
        hashCode = (17 * hashCode) + (firstName == null ? 0 : System.hashCode(firstName));
        hashCode = (17 * hashCode) + (IBAN == null ? 0 : System.hashCode(IBAN));
        hashCode = (17 * hashCode) + (ipAddress == null ? 0 : System.hashCode(ipAddress));
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
        hashCode = (17 * hashCode) + (identityNumber == null ? 0 : System.hashCode(identityNumber));
        hashCode = (17 * hashCode) + (isCompany == null ? 0 : System.hashCode(isCompany));
        hashCode = (17 * hashCode) + (lastFailedSaleTransactionDate == null ? 0 : System.hashCode(lastFailedSaleTransactionDate));
        hashCode = (17 * hashCode) + (lastName == null ? 0 : System.hashCode(lastName));
        hashCode = (17 * hashCode) + (lastTransactionDateTime == null ? 0 : System.hashCode(lastTransactionDateTime));
        hashCode = (17 * hashCode) + (lastTransactionStatus == null ? 0 : System.hashCode(lastTransactionStatus));
        hashCode = (17 * hashCode) + (mandateCreationDate == null ? 0 : System.hashCode(mandateCreationDate));
        hashCode = (17 * hashCode) + (mandateID == null ? 0 : System.hashCode(mandateID));
        hashCode = (17 * hashCode) + (mandateReceived == null ? 0 : System.hashCode(mandateReceived));
        hashCode = (17 * hashCode) + (mandateUpdateDate == null ? 0 : System.hashCode(mandateUpdateDate));
        hashCode = (17 * hashCode) + (maxConsecutivePaymentFailures == null ? 0 : System.hashCode(maxConsecutivePaymentFailures));
        hashCode = (17 * hashCode) + (name == null ? 0 : System.hashCode(name));
        hashCode = (17 * hashCode) + (numConsecutiveFailures == null ? 0 : System.hashCode(numConsecutiveFailures));
        hashCode = (17 * hashCode) + (paymentMethodStatus == null ? 0 : System.hashCode(paymentMethodStatus));
        hashCode = (17 * hashCode) + (paymentRetryWindow == null ? 0 : System.hashCode(paymentRetryWindow));
        hashCode = (17 * hashCode) + (paypalBaid == null ? 0 : System.hashCode(paypalBaid));
        hashCode = (17 * hashCode) + (paypalEmail == null ? 0 : System.hashCode(paypalEmail));
        hashCode = (17 * hashCode) + (paypalPreapprovalKey == null ? 0 : System.hashCode(paypalPreapprovalKey));
        hashCode = (17 * hashCode) + (paypalType == null ? 0 : System.hashCode(paypalType));
        hashCode = (17 * hashCode) + (phone == null ? 0 : System.hashCode(phone));
        hashCode = (17 * hashCode) + (postalCode == null ? 0 : System.hashCode(postalCode));
        hashCode = (17 * hashCode) + (secondTokenId == null ? 0 : System.hashCode(secondTokenId));
        hashCode = (17 * hashCode) + (state == null ? 0 : System.hashCode(state));
        hashCode = (17 * hashCode) + (streetName == null ? 0 : System.hashCode(streetName));
        hashCode = (17 * hashCode) + (streetNumber == null ? 0 : System.hashCode(streetNumber));
        hashCode = (17 * hashCode) + (tokenId == null ? 0 : System.hashCode(tokenId));
        hashCode = (17 * hashCode) + (totalNumberOfErrorPayments == null ? 0 : System.hashCode(totalNumberOfErrorPayments));
        hashCode = (17 * hashCode) + (totalNumberOfProcessedPayments == null ? 0 : System.hashCode(totalNumberOfProcessedPayments));
        hashCode = (17 * hashCode) + (r_type == null ? 0 : System.hashCode(r_type));
        hashCode = (17 * hashCode) + (updatedById == null ? 0 : System.hashCode(updatedById));
        hashCode = (17 * hashCode) + (updatedDate == null ? 0 : System.hashCode(updatedDate));
        hashCode = (17 * hashCode) + (useDefaultRetryRule == null ? 0 : System.hashCode(useDefaultRetryRule));
        return hashCode;
    }
}