/**
 *  This is the object defining the payment details for the Account. The Account will be updated with this payment as the default payment method.\nUse this field if you are associating an electronic payment method with the account. A payment gateway must be enabled.\nValues: A valid electronic PaymentMethod.
 */
public class zc_SubscribeRequestPaymentMethod {
    /**
     *  The ID of the customer account associated with this payment method. 
     * @return accountId
     */
    public String accountId { get; set; }

    /**
     *  The nine-digit routing number or ABA number used by banks.\nThis field is only required if the `Type` field is set to `ACH`.\n\n\n**Character limit**: 9\n\n\n**Values**: a string of 9 characters or fewer 
     * @return achAbaCode
     */
    public String achAbaCode { get; set; }

    /**
     *  The name of the account holder, which can be either a person or a company.\nThis field is only required if the `Type` field is set to `ACH`.\n\n\n**Character limit**: 70\n\n\n**Values**: a string of 70 characters or fewer 
     * @return achAccountName
     */
    public String achAccountName { get; set; }

    /**
     *  The bank account number associated with the ACH payment.\nThis field is only required if the `Type` field is set to `ACH`.\n\n\n**Character limit**: 30\n\n\n**Values**: a string of 30 numeric characters or fewer 
     * @return achAccountNumber
     */
    public String achAccountNumber { get; set; }

    /**
     *  This is a masked displayable version of the ACH account number, used for security purposes. For example: `XXXXXXXXX54321`. Use this field for ACH payment methods.\n\n\n**Character limit**: 32\n\n\n**Values**: automatically generated 
     * @return achAccountNumberMask
     */
    public String achAccountNumberMask { get; set; }

    /**
     *  The type of bank account associated with the ACH payment.\nThis field is only required if the `Type` field is set to `ACH`.\n\n\n**Character limit**: 16\n\n\n**Values**:\n\n- `BusinessChecking`\n- `Checking`\n- `Saving`\n
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
     *  The name of the bank where the ACH payment account is held. Use this field for ACH payment methods.\n\n\n**Character limit**: 70\n\n\n**Values**: a string of 70 characters or fewer 
     * @return achBankName
     */
    public String achBankName { get; set; }

    /**
     *  Specifies whether a payment method is available in Zuora. The default value is `false`.\n\n\n**Character limit**: 5\n\n\n**Values**: `true`, `false` 
     * @return active
     */
    public Boolean active { get; set; }

    /**
     *  The branch code of the bank used for direct debit. Use this field for direct debit payment methods.\n\n\n**Character limit**: 10\n\n\n**Values**:  string of 10 characters or fewer 
     * @return bankBranchCode
     */
    public String bankBranchCode { get; set; }

    /**
     * The check digit in the international bank account number, which confirms the validity of the account. Use this field for direct debit payment methods.\n\n**Character limit**: 4\n\n\n**Values**:  string of 4 characters or fewer 
     * @return bankCheckDigit
     */
    public String bankCheckDigit { get; set; }

    /**
     *  The city of the direct debit bank. Use this field for direct debit payment methods.\n\n\n**Character limit**:70\n\n\n**Values**:  string of 70 characters or fewer 
     * @return bankCity
     */
    public String bankCity { get; set; }

    /**
     *  The sort code or number that identifies the bank. This is also known as the sort code. This field is required for direct debit payment methods.\n\n\n**Character limit**: 18\n\n\n**Values**:  string of 18 characters or fewer 
     * @return bankCode
     */
    public String bankCode { get; set; }

    /**
     *  The first six digits of the payment method\'s number, such as the credit card number or account number. Banks use this number to identify a payment method.\n\n\n**Character limit**: 6\n\n\n**Values**:  string of 6 characters or fewer 
     * @return bankIdentificationNumber
     */
    public String bankIdentificationNumber { get; set; }

    /**
     *  The name of the direct debit bank. Use this field for direct debit payment methods.\n\n\n**Character limit**:80\n\n\n**Values**:  string of 80 characters or fewer 
     * @return bankName
     */
    public String bankName { get; set; }

    /**
     *  The zip code or postal code of the direct debit bank. Use this field for direct debit payment methods.\n\n\n**Character limit**:20\n\n\n**Values**:  string of 20 characters or fewer 
     * @return bankPostalCode
     */
    public String bankPostalCode { get; set; }

    /**
     *  The name of the street of the direct debit bank. Use this field for direct debit payment methods.\n\n\n**Character limit**:60\n\n\n**Values**:  string of 60 characters or fewer 
     * @return bankStreetName
     */
    public String bankStreetName { get; set; }

    /**
     *  The number of the direct debit bank. Use this field for direct debit payment methods.\n\n\n**Character limit**:10\n\n\n**Values**:  string of 10 characters or fewer 
     * @return bankStreetNumber
     */
    public String bankStreetNumber { get; set; }

    /**
     *  The name on the direct debit bank account. Use this field for direct debit payment methods.\n\n\n**Character limit**: 60\n\n\n**Values**:  string of 60 characters or fewer 
     * @return bankTransferAccountName
     */
    public String bankTransferAccountName { get; set; }

    /**
     *  The number of the customer\'s bank account.\nThis field is only required if the `Type` field is set to `BankTransfer`.\n\n\n**Character limit**:30\n\n\n**Values**:  string of 30 characters or fewer 
     * @return bankTransferAccountNumber
     */
    public String bankTransferAccountNumber { get; set; }

    /**
     *  This is a masked displayable version of the ACH account number, used for security purposes. For example: `XXXXXXXXX54321`.\n\n\n**Character limit**: 32\n\n\n**Values**: automatically generated 
     * @return bankTransferAccountNumberMask
     */
    public String bankTransferAccountNumberMask { get; set; }

    /**
     *  The type of the customer\'s bank account. Use this field for direct debit payment methods.\n\n\n**Character limit**: 11\n\n\n**Values**: `DirectDebit` 
     * @return bankTransferAccountType
     */
    public String bankTransferAccountType { get; set; }

    /**
     *  Specifies the type of direct debit transfer. The value of this field is dependent on the country of the user.\nThis field is only required if the `Type` field is set to `BankTransfer`.\n\n\n**Character limit**: 20\n\n\n**Values**:\n\n- `AutomatischIncasso` (NL)\n- `LastschriftDE` (Germany)\n- `LastschriftAT` (Austria)\n- `DemandeDePrelevement` (FR)\n- `DirectDebitUK` (UK)\n- `Domicil` (Belgium)\n- `LastschriftCH` (CH)\n- `RID` (Italy)\n- `OrdenDeDomiciliacion` (Spain)\n
     * @return bankTransferType
     */
    public String bankTransferType { get; set; }

    /**
     *  The business identification code for Swiss direct payment methods that use the Global Collect payment gateway. Use this field only for direct debit payments in Switzerland with Global Collect.\n\n\n**Character limit**: 11\n\n\n**Values**: string of 11 characters or fewer 
     * @return businessIdentificationCode
     */
    public String businessIdentificationCode { get; set; }

    /**
     *  The city of the customer\'s address. Use this field for direct debit payment methods.\n\n\n**Character limit**:80\n\n\n**Values**:  string of 80 characters or fewer 
     * @return city
     */
    public String city { get; set; }

    /**
     *  The two-letter country code of the customer\'s address.\nThis field is only required if the `Type` field is set to `BankTransfer`, and the `BankTransferType` field is set to either `DirectDebitUK`, `DirectEntryAU`, or `DirectDebitNZ`.\n\n\n**Character limit**: 2\n\n\n**Values**: a valid country code 
     * @return country
     */
    public String country { get; set; }

    /**
     *  The user ID of the person who created the `PaymentMethod` object when there is a login user in the user session. In Hosted Payment Method and Z-Checkout pages, this field is set to 3 as there is no login user to initiate a user session.\n\n\n**Character limit**: 32\n\n\n**Values**: automatically generated 
     * @return createdById
     */
    public String createdById { get; set; }

    /**
     *  The date when the `PaymentMethod` object was created in the Zuora system.\n\n\n**Character limit**: 29\n\n\n**Values**: automatically generated 
     * @return createdDate
     */
    public Datetime createdDate { get; set; }

    /**
     *  The first line of the card holder\'s address, which is often a street address or business name. Use this field for credit card and direct debit payment methods.\n\n\n**Character limit**: 255\n\n\n**Values**: a string of 255 characters or fewer 
     * @return creditCardAddress1
     */
    public String creditCardAddress1 { get; set; }

    /**
     *  The second line of the card holder\'s address. Use this field for credit card and direct debit payment methods.\n\n\n**Character limit**: 255\n\n\n**Values**: a string of 255 characters or fewer 
     * @return creditCardAddress2
     */
    public String creditCardAddress2 { get; set; }

    /**
     *  The city of the card holder\'s address. Use this field for credit card and direct debit payment methods\n\n**Character limit**: 40\n\n\n**Values**: a string of 40 characters or fewer 
     * @return creditCardCity
     */
    public String creditCardCity { get; set; }

    /**
     *  The country of the card holder\'s address.
     * @return creditCardCountry
     */
    public String creditCardCountry { get; set; }

    /**
     *  The expiration month of the credit card or debit card.\nThis field is only required if the `Type` field is set to `CreditCard` or `DebitCard`.\n\n**Character limit**: 2\n\n\n**Values**: a two-digit number, 01 - 12 
     * @return creditCardExpirationMonth
     */
    public Integer creditCardExpirationMonth { get; set; }

    /**
     *  The expiration month of the credit card or debit card.\nThis field is only required if the `Type` field is set to `CreditCard` or `DebitCard`.\n\n\n**Character limit**: 4\n\n\n**Values**: a four-digit number 
     * @return creditCardExpirationYear
     */
    public Integer creditCardExpirationYear { get; set; }

    /**
     *  The full name of the card holder.\nThis field is only required if the `Type` field is set to `CreditCard` or `DebitCard`.\n\n\n**Character limit**: 50\n\n\n**Values**: a string of 50 characters or fewer 
     * @return creditCardHolderName
     */
    public String creditCardHolderName { get; set; }

    /**
     *  A masked version of the credit or debit card number.\n\n\n**Character limit**: 32\n\n\n**Values**: automatically generated 
     * @return creditCardMaskNumber
     */
    public String creditCardMaskNumber { get; set; }

    /**
     *  The credit card or debit card number. This is an insert-only field; it cannot be updated nor queried for security purposes.\nThis field is only required if the `Type` field is set to `CreditCard` or `DebitCard`.\n\n\n**Character limit**: 16\n\n\n**Values**: a string of 16 characters or fewer 
     * @return creditCardNumber
     */
    public String creditCardNumber { get; set; }

    /**
     *  The billing address\'s zip code. This field is required only when you define a debit card or credit card payment.\n\n\n**Character limit**: 20\n\n\n**Values**: a string of 20 characters or fewer 
     * @return creditCardPostalCode
     */
    public String creditCardPostalCode { get; set; }

    /**
     *  The CVV or CVV2 security code. See [How do I control what information Zuora sends over to the Payment Gateway?](https://knowledgecenter.zuora.com/kb/How_do_I_control_information_sent_to_payment_gateways_when_verifying_payment_methods%3F) for more information. To ensure PCI compliance, this value is not stored and cannot be queried.\n\n\n**Character limit**:\n\n\n**Values**: a valid CVV or CVV2 security code 
     * @return creditCardSecurityCode
     */
    public String creditCardSecurityCode { get; set; }

    /**
     *  The billing address\'s state. Use this field is if the `CreditCardCountry` value is either Canada or the US. State names must be spelled in full. 
     * @return creditCardState
     */
    public String creditCardState { get; set; }

    /**
     * The type of the credit card.\n\nPossible values  include `Visa`, `MasterCard`, `AmericanExpress`, `Discover`, `JCB`, and `Diners`. For more information about credit card types supported by different payment gateways, see [Supported Payment Gateways](https://knowledgecenter.zuora.com/CB_Billing/M_Payment_Gateways/Supported_Payment_Gateways).\n
     * @return creditCardType
     */
    public String creditCardType { get; set; }

    /**
     *  The session ID of the user when the `PaymentMethod` was created or updated. Some gateways use this field for fraud prevention. If this field is passed to Zuora, then Zuora passes this field to supported gateways. Currently only Verifi supports this field.\n\n\n**Character limit**: 255\n\n\n**Values**: 
     * @return deviceSessionId
     */
    public String deviceSessionId { get; set; }

    /**
     *  An email address for the payment method in addition to the bill to contact email address.\n\n\n**Character limit**: 80\n\n\n**Values**: a string of 80 characters or fewer 
     * @return email
     */
    public String email { get; set; }

    /**
     *  Indicates if the customer has an existing mandate or a new mandate. A mandate is a signed authorization for UK and NL customers. When you are migrating mandates from another system, be sure to set this field correctly. If you indicate that a new mandate is an existing mandate or vice-versa, then transactions fail. This field is used only for the direct debit payment method.\n\n\n**Character limit**: 3\n\n\n**Values**: `Yes`, `No` 
     * @return existingMandate
     */
    public String existingMandate { get; set; }

    /**
     *  The customer\'s first name. This field is used only for the direct debit payment method.\n\n\n**Character limit**: 30\n\n\n**Values**: a string of 30 characters or fewer 
     * @return firstName
     */
    public String firstName { get; set; }

    /**
     * Get gatewayOptionData
     * @return gatewayOptionData
     */
    public zc_SubscribeRequestPaymentMethodGat gatewayOptionData { get; set; }

    /**
     *  The International Bank Account Number. This field is used only for the direct debit payment method.\n\n\n**Character limit**: 42\n\n\n**Values**: a string of 42 characters or fewer 
     * @return IBAN
     */
    public String IBAN { get; set; }

    /**
     *  The IP address of the user when the payment method was created or updated. Some gateways use this field for fraud prevention. If this field is passed to Zuora, then Zuora passes this field to supported gateways. Currently PayPal, CyberSource, Authorize.Net, and Verifi support this field.\n\n\n**Character limit**: 15\n\n\n**Values**: a string of 15 characters or fewer 
     * @return ipAddress
     */
    public String ipAddress { get; set; }

    /**
     *  The ID of this object. Upon creation, the ID of this object is `PaymentMethodId`.\n\n\n**Character limit**: 32\n\n\n**Values**: automatically generated 
     * @return id
     */
    public String id { get; set; }

    /**
     *  The date of the last failed attempt to collect payment with this payment method.\n\n\n**Character limit**: 29\n\n\n**Values**: automatically generated 
     * @return lastFailedSaleTransactionDate
     */
    public Datetime lastFailedSaleTransactionDate { get; set; }

    /**
     *  The customer\'s last name. This field is used only for the direct debit payment method.\n\n\n**Character limit**: 70\n\n\n**Values**: a string of 70 characters or fewer 
     * @return lastName
     */
    public String lastName { get; set; }

    /**
     *  The date of the most recent transaction.\n\n\n**Character limit**: 29\n\n\n**Values**: a valid date and time value 
     * @return lastTransactionDateTime
     */
    public Datetime lastTransactionDateTime { get; set; }

    /**
     *  The status of the most recent transaction.\n\n\n**Character limit**: 39\n\n\n**Values**: automatically generated 
     * @return lastTransactionStatus
     */
    public String lastTransactionStatus { get; set; }

    /**
     *  The date when the mandate was created, in `yyyy-mm-dd` format. A mandate is a signed authorization for UK and NL customers. This field is used only for the direct debit payment method.\n\n\n**Character limit**: 29\n\n\n
     * @return mandateCreationDate
     */
    public Date mandateCreationDate { get; set; }

    /**
     *  The ID of the mandate. A mandate is a signed authorization for UK and NL customers. This field is used only for the direct debit payment method.\n\n\n**Character limit**: 36\n\n\n**Values**: a string of 36 characters or fewer 
     * @return mandateID
     */
    public String mandateID { get; set; }

    /**
     *  Indicates if  the mandate was received. A mandate is a signed authorization for UK and NL customers. This field is used only for the direct debit payment method.\n\n\n**Character limit**: 3\n\n\n**Values**: `Yes`, `No `(case-sensitive) 
     * @return mandateReceived
     */
    public String mandateReceived { get; set; }

    /**
     *  The date when the mandate was last updated, in `yyyy-mm-dd` format. A mandate is a signed authorization for UK and NL customers. This field is used only for the direct debit payment method.\n\n\n**Character limit**: 29\n\n\n
     * @return mandateUpdateDate
     */
    public Date mandateUpdateDate { get; set; }

    /**
     *  Specifies the number of allowable consecutive failures Zuora attempts with the payment method before stopping.\nWhen the `UseDefaultRetryRule` field is set to `false`, this field is only required if the `PaymentRetryWindow` field is not defined.\n\n\n\n**Values**: a valid number 
     * @return maxConsecutivePaymentFailures
     */
    public Integer maxConsecutivePaymentFailures { get; set; }

    /**
     *  Create Query Delete Filter 
     * @return name
     */
    public String name { get; set; }

    /**
     *  The number of consecutive failed payment for this payment method. It is reset to 0 upon successful payment. You can use the API to update the field value to 0.\n\n\n**Character limit**:\n\n\n**Values**: a positive whole number 
     * @return numConsecutiveFailures
     */
    public Integer numConsecutiveFailures { get; set; }

    /**
     *  Specifies the status of the payment method. It is set to Active on creation.\n\n\n**Character limit**: 6\n\n\n**Values**: `Active` or `Closed` PaymentMethodStatus should not be used in the `create\n` call. You can only set this field to **Closed** via the `update\n` call. 
     * @return paymentMethodStatus
     */
    public String paymentMethodStatus { get; set; }

    /**
     *  The retry interval setting, which prevents making a payment attempt if the last failed attempt was within the last specified number of hours.\nWhen the `UseDefaultRetryRule` field is set to `false`, this field is only required if the `MaxConsecutivePaymentFailures` field is not defined.\n\n\n**Character limit**: 4\n\n\n**Values**: a whole number between 1 and 1000, exclusive 
     * @return paymentRetryWindow
     */
    public Integer paymentRetryWindow { get; set; }

    /**
     *  The PayPal billing agreement ID, which is a contract between two PayPal accounts. Typically, the selling party initiates a request to create a BAID, and sends it to buying party for acceptance. The seller can keep track of the BAID and use it for future charges against the buyer.\nThis field is only required if the `Type` field is set to `PayPal`.\n\n\n**Character limit**: 64\n\n\n**Values**: a string of 64 characters or fewer 
     * @return paypalBaid
     */
    public String paypalBaid { get; set; }

    /**
     *  The email address associated with the account holder\'s PayPal account or of the PayPal account of the person paying for the service.\nThis field is only required if the `Type` field is set to `PayPal`.\n\n\n**Character limit**: 80\n\n\n**Values**: a string of 80 characters or fewer 
     * @return paypalEmail
     */
    public String paypalEmail { get; set; }

    /**
     *  PayPal\'s Adaptive Payments API key. Zuora does not create this key, nor does it call PayPal to generate it. You must use PayPal\'s Adaptive Payments\' API to generate this key, and then pass it to Zuora. Zuora uses this key to authorize future payments to PayPal\'s Adaptive Payments API.\nThis field is only required if you use PayPal Adaptive Payments gateway.\n\n\n**Character limit**: 32\n\n\n**Values**: a valid PayPal Adaptive Payment pre-approval key 
     * @return paypalPreapprovalKey
     */
    public String paypalPreapprovalKey { get; set; }

    /**
     *  Specifies the PayPal gateway: PayFlow Pro (Express Checkout) or Adaptive Payments.\nThis field is only required if you use PayPal Adaptive Payments or Payflow Pro (Express Checkout) gateways.\n\n\n**Character limit**: 32\n\n\n**Values**: `ExpressCheckout`, `AdaptivePayments` 
     * @return paypalType
     */
    public String paypalType { get; set; }

    /**
     *  The phone number that the account holder registered with the bank. This field is used for credit card validation when passing to a gateway.\n\n\n**Character limit**: 40\n\n\n**Values**: a string of 40 characters or fewer 
     * @return phone
     */
    public String phone { get; set; }

    /**
     *  The zip code of the customer\'s address. This field is used only for the direct debit payment method.\n\n\n**Character limit**: 20\n\n\n**Values**: a string of 20 characters or fewer 
     * @return postalCode
     */
    public String postalCode { get; set; }

    /**
     *  A gateway unique identifier that replaces sensitive payment method data. SecondTokenId is conditionally required only when TokenID is being used to represent a gateway customer profile. SecondTokenId is used in the CC Reference Transaction payment method.\n\n**Character limit**: 64\n\n\n**Values**: a string of 64 characters or fewer 
     * @return secondTokenId
     */
    public String secondTokenId { get; set; }

    /**
     *  Creates the payment method even if authorization fails with the payment gateway.\n\n\n**Character limit**: 5\n\n\n**Values**: `t``rue`, `false` 
     * @return skipValidation
     */
    public Boolean skipValidation { get; set; }

    /**
     *  The state of the customer\'s address. This field is used only for the direct debit payment method.\n\n\n**Character limit**: 70\n\n\n**Values**: a string of 70 characters or fewer 
     * @return state
     */
    public String state { get; set; }

    /**
     *  The street name of the customer\'s address. This field is used only for the direct debit payment method.\n\n\n**Character limit**: 100\n\n\n**Values**: a string of 100 characters or fewer 
     * @return streetName
     */
    public String streetName { get; set; }

    /**
     *  The street number of the customer\'s address. This field is used only for the direct debit payment method.\n\n\n**Character limit**: 30\n\n\n**Values**: a string of 30 characters or fewer 
     * @return streetNumber
     */
    public String streetNumber { get; set; }

    /**
     * A gateway unique identifier that replaces sensitive payment method data or represents a gateway\'s unique customer profile. If you want to create an Amazon Pay payment method, specify `AmazonBillingAgreementId` for this field. \n\nWhile `TokenId` is used to represent a customer profile, `SecondTokenId` is conditionally required for representing the underlying tokenized payment method. When the `Type` field is set to `CreditCardReferenceTransaction`, this field is required if the `CreditCardNumber` field is not specified. \n\n**Character limit**: 255\n**Values**: a string of 255 characters or fewer\n
     * @return tokenId
     */
    public String tokenId { get; set; }

    /**
     *  The number of error payments that used this payment method.\n\n\n**Character limit**:\n\n\n**Values**: automatically generated 
     * @return totalNumberOfErrorPayments
     */
    public Integer totalNumberOfErrorPayments { get; set; }

    /**
     *  The number of successful payments that used this payment method.\n\n\n**Character limit**:\n\n\n**Values**: automatically generated 
     * @return totalNumberOfProcessedPayments
     */
    public Integer totalNumberOfProcessedPayments { get; set; }

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
    public RTypeEnum r_type { get; set; }

    /**
     *  The ID of the user who last updated the payment method.\n\n\n**Character limit**: 32\n\n\n**Values**: automatically generated 
     * @return updatedById
     */
    public String updatedById { get; set; }

    /**
     *  The date when the payment method was last updated.\n\n\n**Character limit**: 29\n\n\n**Values**: automatically generated 
     * @return updatedDate
     */
    public Datetime updatedDate { get; set; }

    /**
     *  Determines whether to use the default retry rules configured in the [Z-Payments settings](https://knowledgecenter.zuora.com/CB_Billing/L_Payment_Methods/H_Configure_Payment_Method_Retry_Rules). Set this to `true` to use the default retry rules. Set this to `false` to set the specific rules for this payment method. If you set this value to `false`, then the fields, `PaymentRetryWindow` and `MaxConsecutivePaymentFailures`, are required.\n\n\n**Character limit**: 5\n\n\n**Values**: `t``rue`, `false` 
     * @return useDefaultRetryRule
     */
    public Boolean useDefaultRetryRule { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'AccountId' => 'accountId',
        'AchAbaCode' => 'achAbaCode',
        'AchAccountName' => 'achAccountName',
        'AchAccountNumber' => 'achAccountNumber',
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
        'Id' => 'id',
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
        'SkipValidation' => 'skipValidation',
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

    // public static zc_SubscribeRequestPaymentMethod getExample() {
    //     zc_SubscribeRequestPaymentMethod subscribeRequestPaymentMethod = new zc_SubscribeRequestPaymentMethod();
    //     subscribeRequestPaymentMethod.accountId = 'aeiou';
    //     subscribeRequestPaymentMethod.achAbaCode = 'aeiou';
    //     subscribeRequestPaymentMethod.achAccountName = 'aeiou';
    //     subscribeRequestPaymentMethod.achAccountNumber = 'aeiou';
    //     subscribeRequestPaymentMethod.achAccountNumberMask = 'aeiou';
    //     subscribeRequestPaymentMethod.achAccountType = 'aeiou';
    //     subscribeRequestPaymentMethod.achAddress1 = 'aeiou';
    //     subscribeRequestPaymentMethod.achAddress2 = 'aeiou';
    //     subscribeRequestPaymentMethod.achBankName = 'aeiou';
    //     subscribeRequestPaymentMethod.active = true;
    //     subscribeRequestPaymentMethod.bankBranchCode = 'aeiou';
    //     subscribeRequestPaymentMethod.bankCheckDigit = 'aeiou';
    //     subscribeRequestPaymentMethod.bankCity = 'aeiou';
    //     subscribeRequestPaymentMethod.bankCode = 'aeiou';
    //     subscribeRequestPaymentMethod.bankIdentificationNumber = 'aeiou';
    //     subscribeRequestPaymentMethod.bankName = 'aeiou';
    //     subscribeRequestPaymentMethod.bankPostalCode = 'aeiou';
    //     subscribeRequestPaymentMethod.bankStreetName = 'aeiou';
    //     subscribeRequestPaymentMethod.bankStreetNumber = 'aeiou';
    //     subscribeRequestPaymentMethod.bankTransferAccountName = 'aeiou';
    //     subscribeRequestPaymentMethod.bankTransferAccountNumber = 'aeiou';
    //     subscribeRequestPaymentMethod.bankTransferAccountNumberMask = 'aeiou';
    //     subscribeRequestPaymentMethod.bankTransferAccountType = 'aeiou';
    //     subscribeRequestPaymentMethod.bankTransferType = 'aeiou';
    //     subscribeRequestPaymentMethod.businessIdentificationCode = 'aeiou';
    //     subscribeRequestPaymentMethod.city = 'aeiou';
    //     subscribeRequestPaymentMethod.country = 'aeiou';
    //     subscribeRequestPaymentMethod.createdById = 'aeiou';
    //     subscribeRequestPaymentMethod.createdDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    //     subscribeRequestPaymentMethod.creditCardAddress1 = 'aeiou';
    //     subscribeRequestPaymentMethod.creditCardAddress2 = 'aeiou';
    //     subscribeRequestPaymentMethod.creditCardCity = 'aeiou';
    //     subscribeRequestPaymentMethod.creditCardCountry = 'aeiou';
    //     subscribeRequestPaymentMethod.creditCardExpirationMonth = 123;
    //     subscribeRequestPaymentMethod.creditCardExpirationYear = 123;
    //     subscribeRequestPaymentMethod.creditCardHolderName = 'aeiou';
    //     subscribeRequestPaymentMethod.creditCardMaskNumber = 'aeiou';
    //     subscribeRequestPaymentMethod.creditCardNumber = 'aeiou';
    //     subscribeRequestPaymentMethod.creditCardPostalCode = 'aeiou';
    //     subscribeRequestPaymentMethod.creditCardSecurityCode = 'aeiou';
    //     subscribeRequestPaymentMethod.creditCardState = 'aeiou';
    //     subscribeRequestPaymentMethod.creditCardType = 'aeiou';
    //     subscribeRequestPaymentMethod.deviceSessionId = 'aeiou';
    //     subscribeRequestPaymentMethod.email = 'aeiou';
    //     subscribeRequestPaymentMethod.existingMandate = 'aeiou';
    //     subscribeRequestPaymentMethod.firstName = 'aeiou';
    //     subscribeRequestPaymentMethod.gatewayOptionData = zc_SubscribeRequestPaymentMethodGat.getExample();
    //     subscribeRequestPaymentMethod.IBAN = 'aeiou';
    //     subscribeRequestPaymentMethod.ipAddress = 'aeiou';
    //     subscribeRequestPaymentMethod.id = 'aeiou';
    //     subscribeRequestPaymentMethod.lastFailedSaleTransactionDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    //     subscribeRequestPaymentMethod.lastName = 'aeiou';
    //     subscribeRequestPaymentMethod.lastTransactionDateTime = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    //     subscribeRequestPaymentMethod.lastTransactionStatus = 'aeiou';
    //     subscribeRequestPaymentMethod.mandateCreationDate = Date.newInstance(2000, 1, 23);
    //     subscribeRequestPaymentMethod.mandateID = 'aeiou';
    //     subscribeRequestPaymentMethod.mandateReceived = 'aeiou';
    //     subscribeRequestPaymentMethod.mandateUpdateDate = Date.newInstance(2000, 1, 23);
    //     subscribeRequestPaymentMethod.maxConsecutivePaymentFailures = 123;
    //     subscribeRequestPaymentMethod.name = 'aeiou';
    //     subscribeRequestPaymentMethod.numConsecutiveFailures = 123;
    //     subscribeRequestPaymentMethod.paymentMethodStatus = 'aeiou';
    //     subscribeRequestPaymentMethod.paymentRetryWindow = 123;
    //     subscribeRequestPaymentMethod.paypalBaid = 'aeiou';
    //     subscribeRequestPaymentMethod.paypalEmail = 'aeiou';
    //     subscribeRequestPaymentMethod.paypalPreapprovalKey = 'aeiou';
    //     subscribeRequestPaymentMethod.paypalType = 'aeiou';
    //     subscribeRequestPaymentMethod.phone = 'aeiou';
    //     subscribeRequestPaymentMethod.postalCode = 'aeiou';
    //     subscribeRequestPaymentMethod.secondTokenId = 'aeiou';
    //     subscribeRequestPaymentMethod.skipValidation = true;
    //     subscribeRequestPaymentMethod.state = 'aeiou';
    //     subscribeRequestPaymentMethod.streetName = 'aeiou';
    //     subscribeRequestPaymentMethod.streetNumber = 'aeiou';
    //     subscribeRequestPaymentMethod.tokenId = 'aeiou';
    //     subscribeRequestPaymentMethod.totalNumberOfErrorPayments = 123;
    //     subscribeRequestPaymentMethod.totalNumberOfProcessedPayments = 123;
    //     subscribeRequestPaymentMethod.r_type = RTypeEnum.ACH;
    //     subscribeRequestPaymentMethod.updatedById = 'aeiou';
    //     subscribeRequestPaymentMethod.updatedDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
    //     subscribeRequestPaymentMethod.useDefaultRetryRule = true;
    //     return subscribeRequestPaymentMethod;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_SubscribeRequestPaymentMethod) {
            zc_SubscribeRequestPaymentMethod subscribeRequestPaymentMethod = (zc_SubscribeRequestPaymentMethod) obj;
            return this.accountId == subscribeRequestPaymentMethod.accountId
                && this.achAbaCode == subscribeRequestPaymentMethod.achAbaCode
                && this.achAccountName == subscribeRequestPaymentMethod.achAccountName
                && this.achAccountNumber == subscribeRequestPaymentMethod.achAccountNumber
                && this.achAccountNumberMask == subscribeRequestPaymentMethod.achAccountNumberMask
                && this.achAccountType == subscribeRequestPaymentMethod.achAccountType
                && this.achAddress1 == subscribeRequestPaymentMethod.achAddress1
                && this.achAddress2 == subscribeRequestPaymentMethod.achAddress2
                && this.achBankName == subscribeRequestPaymentMethod.achBankName
                && this.active == subscribeRequestPaymentMethod.active
                && this.bankBranchCode == subscribeRequestPaymentMethod.bankBranchCode
                && this.bankCheckDigit == subscribeRequestPaymentMethod.bankCheckDigit
                && this.bankCity == subscribeRequestPaymentMethod.bankCity
                && this.bankCode == subscribeRequestPaymentMethod.bankCode
                && this.bankIdentificationNumber == subscribeRequestPaymentMethod.bankIdentificationNumber
                && this.bankName == subscribeRequestPaymentMethod.bankName
                && this.bankPostalCode == subscribeRequestPaymentMethod.bankPostalCode
                && this.bankStreetName == subscribeRequestPaymentMethod.bankStreetName
                && this.bankStreetNumber == subscribeRequestPaymentMethod.bankStreetNumber
                && this.bankTransferAccountName == subscribeRequestPaymentMethod.bankTransferAccountName
                && this.bankTransferAccountNumber == subscribeRequestPaymentMethod.bankTransferAccountNumber
                && this.bankTransferAccountNumberMask == subscribeRequestPaymentMethod.bankTransferAccountNumberMask
                && this.bankTransferAccountType == subscribeRequestPaymentMethod.bankTransferAccountType
                && this.bankTransferType == subscribeRequestPaymentMethod.bankTransferType
                && this.businessIdentificationCode == subscribeRequestPaymentMethod.businessIdentificationCode
                && this.city == subscribeRequestPaymentMethod.city
                && this.country == subscribeRequestPaymentMethod.country
                && this.createdById == subscribeRequestPaymentMethod.createdById
                && this.createdDate == subscribeRequestPaymentMethod.createdDate
                && this.creditCardAddress1 == subscribeRequestPaymentMethod.creditCardAddress1
                && this.creditCardAddress2 == subscribeRequestPaymentMethod.creditCardAddress2
                && this.creditCardCity == subscribeRequestPaymentMethod.creditCardCity
                && this.creditCardCountry == subscribeRequestPaymentMethod.creditCardCountry
                && this.creditCardExpirationMonth == subscribeRequestPaymentMethod.creditCardExpirationMonth
                && this.creditCardExpirationYear == subscribeRequestPaymentMethod.creditCardExpirationYear
                && this.creditCardHolderName == subscribeRequestPaymentMethod.creditCardHolderName
                && this.creditCardMaskNumber == subscribeRequestPaymentMethod.creditCardMaskNumber
                && this.creditCardNumber == subscribeRequestPaymentMethod.creditCardNumber
                && this.creditCardPostalCode == subscribeRequestPaymentMethod.creditCardPostalCode
                && this.creditCardSecurityCode == subscribeRequestPaymentMethod.creditCardSecurityCode
                && this.creditCardState == subscribeRequestPaymentMethod.creditCardState
                && this.creditCardType == subscribeRequestPaymentMethod.creditCardType
                && this.deviceSessionId == subscribeRequestPaymentMethod.deviceSessionId
                && this.email == subscribeRequestPaymentMethod.email
                && this.existingMandate == subscribeRequestPaymentMethod.existingMandate
                && this.firstName == subscribeRequestPaymentMethod.firstName
                && this.gatewayOptionData == subscribeRequestPaymentMethod.gatewayOptionData
                && this.IBAN == subscribeRequestPaymentMethod.IBAN
                && this.ipAddress == subscribeRequestPaymentMethod.ipAddress
                && this.id == subscribeRequestPaymentMethod.id
                && this.lastFailedSaleTransactionDate == subscribeRequestPaymentMethod.lastFailedSaleTransactionDate
                && this.lastName == subscribeRequestPaymentMethod.lastName
                && this.lastTransactionDateTime == subscribeRequestPaymentMethod.lastTransactionDateTime
                && this.lastTransactionStatus == subscribeRequestPaymentMethod.lastTransactionStatus
                && this.mandateCreationDate == subscribeRequestPaymentMethod.mandateCreationDate
                && this.mandateID == subscribeRequestPaymentMethod.mandateID
                && this.mandateReceived == subscribeRequestPaymentMethod.mandateReceived
                && this.mandateUpdateDate == subscribeRequestPaymentMethod.mandateUpdateDate
                && this.maxConsecutivePaymentFailures == subscribeRequestPaymentMethod.maxConsecutivePaymentFailures
                && this.name == subscribeRequestPaymentMethod.name
                && this.numConsecutiveFailures == subscribeRequestPaymentMethod.numConsecutiveFailures
                && this.paymentMethodStatus == subscribeRequestPaymentMethod.paymentMethodStatus
                && this.paymentRetryWindow == subscribeRequestPaymentMethod.paymentRetryWindow
                && this.paypalBaid == subscribeRequestPaymentMethod.paypalBaid
                && this.paypalEmail == subscribeRequestPaymentMethod.paypalEmail
                && this.paypalPreapprovalKey == subscribeRequestPaymentMethod.paypalPreapprovalKey
                && this.paypalType == subscribeRequestPaymentMethod.paypalType
                && this.phone == subscribeRequestPaymentMethod.phone
                && this.postalCode == subscribeRequestPaymentMethod.postalCode
                && this.secondTokenId == subscribeRequestPaymentMethod.secondTokenId
                && this.skipValidation == subscribeRequestPaymentMethod.skipValidation
                && this.state == subscribeRequestPaymentMethod.state
                && this.streetName == subscribeRequestPaymentMethod.streetName
                && this.streetNumber == subscribeRequestPaymentMethod.streetNumber
                && this.tokenId == subscribeRequestPaymentMethod.tokenId
                && this.totalNumberOfErrorPayments == subscribeRequestPaymentMethod.totalNumberOfErrorPayments
                && this.totalNumberOfProcessedPayments == subscribeRequestPaymentMethod.totalNumberOfProcessedPayments
                && this.r_type == subscribeRequestPaymentMethod.r_type
                && this.updatedById == subscribeRequestPaymentMethod.updatedById
                && this.updatedDate == subscribeRequestPaymentMethod.updatedDate
                && this.useDefaultRetryRule == subscribeRequestPaymentMethod.useDefaultRetryRule;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (accountId == null ? 0 : System.hashCode(accountId));
        hashCode = (17 * hashCode) + (achAbaCode == null ? 0 : System.hashCode(achAbaCode));
        hashCode = (17 * hashCode) + (achAccountName == null ? 0 : System.hashCode(achAccountName));
        hashCode = (17 * hashCode) + (achAccountNumber == null ? 0 : System.hashCode(achAccountNumber));
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
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
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
        hashCode = (17 * hashCode) + (skipValidation == null ? 0 : System.hashCode(skipValidation));
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