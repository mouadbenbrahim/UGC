public with sharing class zc_RatePlanChargeInRatePlanChargeData {
/**
     * The accounting code for the charge. Accounting codes group transactions that contain similar accounting attributes.\n\n**Character limit**: 100\n\n\n**Values**: inherited from `ProductRatePlanCharge.AccountingCode` 
     * @return accountingCode
     */
    public String accountingCode { get; set; }

    /**
     *  Specifies the type of charges a specific discount applies to.\n\n**Character limit**: 21\n\n\n**Values**: inherited from `ProductRatePlanCharge.ApplyDiscountTo` 
     * @return applyDiscountTo
     */
    public String applyDiscountTo { get; set; }

    /**
     *  Indicates the charge\'s billing cycle day (BCD), which is when bill runs generate invoices for charges associated with the product rate plan charge or the account.\n\n\n**Character limit**: 2\n\n\n**Values**: inherited from `ProductRatePlanCharge.BillCycleDay` 
     * @return billCycleDay
     */
    public Integer billCycleDay { get; set; }

    /**
     *  Specifies how to determine the billing day for the charge.\n\n\n**Character limit**: 20\n\n\n**Values**: inherited from `ProductRatePlanCharge.BillCycleType` **Note:** You can override the value inherited from the Product Rate Plan Charge, but only when creating a new subscription or a New Product amendment. 
     * @return billCycleType
     */
    public String billCycleType { get; set; }

    /**
     *  Allows billing period to be overridden on rate plan charge.\n\n\n\n**Values**: inherited from `ProductRatePlanCharge.BillingPeriod` **Note:** You can override the value inherited from the Product Rate Plan Charge, but only when creating a new subscription or a New Product amendment. 
     * @return billingPeriod
     */
    public String billingPeriod { get; set; }

    /**
     *  Aligns charges within the same subscription if multiple charges begin on different dates.\n\n\n**Character limit**: 24\n\n\n**Values**: inherited from `ProductRatePlanCharge.BillingPeriodAlignment` 
     * @return billingPeriodAlignment
     */
    public String billingPeriodAlignment { get; set; }

    /**
     *  The billing timing for the charge. You can choose to bill in advance or in arrears for recurring charge types. This field is not used in one-time or usage based charge types.\n\n\n**Character limit**:\n\n\n**Values**: one of the following:\n\n- `In Advance`\n- `In Arrears`\n**Note:** You can override the value inherited from the Product Rate Plan Charge when a subscription has a recurring charge type.\nThis feature is in **Limited Availability**. If you wish to have access to the feature, submit a request at [Zuora Global Support](http://support.zuora.com/).\n\n
     * @return billingTiming
     */
    public String billingTiming { get; set; }

    /**
     *  Determines how to evaluate charges. Charge models must be individually activated in the web-based UI.\n\n\n**Character limit**: 29\n\n\n**Values**: inherited from `ProductRatePlanCharge.ChargeModel` 
     * @return chargeModel
     */
    public String chargeModel { get; set; }

    /**
     *  A unique number that identifies the charge. This number is returned as a string.\n\n\n**Character limit**: 50\n\n\n**Values**: one of the following:\n\n- automatically generated if left null\n- a unique number of 50 characters or fewer\n
     * @return chargeNumber
     */
    public String chargeNumber { get; set; }

    /**
     *  Specifies the type of charge.\n\n\n**Character limit**: 9\n\n\n**Values**: inherited from `ProductRatePlanCharge.ChargeType` 
     * @return chargeType
     */
    public String chargeType { get; set; }

    /**
     *  The date through which a customer has been billed for the charge.\n\n\n**Character limit**: 29\n\n\n**Values**: automatically generated 
     * @return chargedThroughDate
     */
    public Date chargedThroughDate { get; set; }

    /**
     * The ID of the Zuora user who created the `RatePlanCharge` object.\n\n**Character limit**: 32\n\n\n**Values**: automatically generated 
     * @return createdById
     */
    public String createdById { get; set; }

    /**
     *  The date when the `RatePlanCharge` object was created.\n\n\n**Character limit**: 29\n\n\n**Values**: automatically generated 
     * @return createdDate
     */
    public Datetime createdDate { get; set; }

    /**
     * A delta monthly recurring charge is the change in monthly recurring revenue caused by an amendment or a new subscription.\n\n**Character limit**: 16\n\n\n**Values**: automatically generated 
     * @return DMRC
     */
    public Double DMRC { get; set; }

    /**
     *  After an Amendment, the change in the total contract value (TCV) amount for this charge, compared with its previous value.\n\n\n**Character limit**: 16\n\n\n**Values**: automatically generated 
     * @return DTCV
     */
    public Double DTCV { get; set; }

    /**
     *  A description of the charge.\n\n\n**Character limit**: 500\n\n\n**Values**: inherited from `ProductRatePlanCharge.Description` 
     * @return description
     */
    public String description { get; set; }

    /**
     *  Specifies the amount of a fixed-amount discount. You can provide a value for this field if the `ChargeModel` field value is `Discount-Fixed Amount`. If this field is included in a query, the query will filter out the rate plans whose `ChargeModel` field is not of a Discount type. You cannot query this field with the following fields in a single query:\n\n- Price\n- IncludedUnits\n- DiscountPercentage\n- OveragePrice\n\n\n**Character limit**: 16\n\n\n**Values**: a valid currency amount 
     * @return discountAmount
     */
    public Double discountAmount { get; set; }

    /**
     * Specifies if the discount applies to just the product rate plan, the entire subscription, or to any activity in the account. This field is only required if the `ChargeModel` field is set to `DiscountFixedAmount` or `DiscountPercentage`.\n\n**Character limit**: 12\n\n\n**Values**: inherited from `ProductRatePlanCharge.DiscountLevel` 
     * @return discountLevel
     */
    public String discountLevel { get; set; }

    /**
     *  Query Filter 
     * @return discountPercentage
     */
    public Double discountPercentage { get; set; }

    /**
     *  The date when the segmented charge ends or ended.\n\n\n**Character limit**: 16\n\n\n**Values**: automatically generated 
     * @return effectiveEndDate
     */
    public Date effectiveEndDate { get; set; }

    /**
     *  The date when the segmented charge starts or started.\n\n\n**Character limit**: 16\n\n\n**Values**: automatically generated 
     * @return effectiveStartDate
     */
    public Date effectiveStartDate { get; set; }

    /**
     *  Defines when the charge ends after the charge trigger date. This field can be updated when **Status** is `Draft`.\n\n\n\n**Values**: one of the following:\n\n- `SubscriptionEnd`: The charge ends on the subscription end date after the charge trigger date. This is the default value.\n- `FixedPeriod`: The charge ends after a specified period based on the trigger date of the charge. If you set this field to `FixedPeriod`, you must specify the length of the period and a period type by defining the `UpToPeriods` and `UpToPeriodsType` fields.\n- `SpecificEndDate`: The specific date on which the charge ends. If you set this field to `SpecificEndDate`, you must specify the specific date by defining the `SpecificEndDate` field.\n\n\n\n**Note**: If the subscription ends before the charge end date, the charge ends when the subscription ends. But if the subscription end date is subsequently changed through a Renewal, or Terms and Conditions amendment, the charge will end on the charge end date. 
     * @return endDateCondition
     */
    public String endDateCondition { get; set; }

    /**
     *  Query Filter 
     * @return includedUnits
     */
    public Double includedUnits { get; set; }

    /**
     * Indicates if the segment of the rate plan charge is the most recent segment.\n\n**Character limit**: 5\n\n\n**Values**: automatically generated: `true`, `false` 
     * @return isLastSegment
     */
    public Boolean isLastSegment { get; set; }

    /**
     * The list price base for the product rate plan charge.\n\nYou can only change the value of this field if the amendment type is NewProduct.\n\n**Values**: one of the following:\n\n- `Per Month`\n- `Per Billing Period`\n- `Per Week`\n
     * @return listPriceBase
     */
    public String listPriceBase { get; set; }

    /**
     * Monthly recurring revenue (MRR) is the amount of recurring charges in a given month. The MRR calculation doesn\'t include one-time charges nor usage charges.\n\n**Character limit**: 16\n\n\n**Values**: automatically generated 
     * @return MRR
     */
    public Double MRR { get; set; }

    /**
     * The name of the rate plan charge.\n\n**Character limit**: 100\n\n\n**Values**: automatically generated 
     * @return name
     */
    public String name { get; set; }

    /**
     * Specifies the number of periods to use when calculating charges in an overage smoothing charge model.\n\n**Character limit**: 5\n\n\n**Values**: inherited from `ProductRatePlanCharge.NumberOfPeriod` 
     * @return numberOfPeriods
     */
    public Long numberOfPeriods { get; set; }

    /**
     * The original ID of the rate plan charge.\n\n**Character limit**: 32\n\n\n**Values**: automatically generated 
     * @return originalId
     */
    public String originalId { get; set; }

    /**
     * Determines when to calculate overage charges. If the value of the SmoothingMode field is null (not specified and not inherited from ProductRatePlanCharge.SmoothingMode), the value of this field is ignored.\n\n**Character limit**: 20\n\n\n**Values**: inherited from `ProductRatePlanCharge.OverageCalculationOption` 
     * @return overageCalculationOption
     */
    public String overageCalculationOption { get; set; }

    /**
     *  Query Filter 
     * @return overagePrice
     */
    public Double overagePrice { get; set; }

    /**
     *  Determines whether to credit the customer with unused units of usage.\n\n\n**Character limit**: 20\n\n\n**Values**: inherited from `ProductRatePlanCharge.OverageUnusedUnitsCreditOption` 
     * @return overageUnusedUnitsCreditOption
     */
    public String overageUnusedUnitsCreditOption { get; set; }

    /**
     *  Query Filter 
     * @return price
     */
    public Double price { get; set; }

    /**
     *  Applies an automatic price change when a termed subscription is renewed.\n\n\n**Character limit**:\n\n\n**Values**: one of the following:\n\n- `NoChange` (default)\n- `SpecificPercentageValue`\n- `UseLatestProductCatalogPricing`\n
     * @return priceChangeOption
     */
    public String priceChangeOption { get; set; }

    /**
     *  Specifies the percentage to increase or decrease the price of renewed subscriptions. Use this field if the `ProductRatePlanCharge`.`PriceChangeOption` value is set to `SpecificPercentageValue`.\n\n\n**Character limit**: 16\n\n\n**Values**: a decimal value between -100 and 100 
     * @return priceIncreasePercentage
     */
    public Double priceIncreasePercentage { get; set; }

    /**
     *  The date until when charges have been processed. When billing in arrears, such as usage, this field value is the the same as the `ChargedThroughDate` value. This date is the earliest date when a charge can be amended.\n\n\n**Character limit**: 29\n\n\n**Values**: automatically generated 
     * @return processedThroughDate
     */
    public Date processedThroughDate { get; set; }

    /**
     *  The ID of the product rate plan charge associated with the subscription rate plan charge,\n\n**Character limit**: 32\n\n\n**Values**: inherited from `ProductRatePlanCharge.Id` 
     * @return productRatePlanChargeId
     */
    public String productRatePlanChargeId { get; set; }

    /**
     *  The default quantity of units, such as the number of authors in a hosted wiki service. Valid for all charge models except for Flat Fee pricing. This field is only rquired if the charge model is tiered pricing or volume pricing.\n\n\n\n**Character limit**: 16\n\n\n**Values**: a valid quantity value 
     * @return quantity
     */
    public Double quantity { get; set; }

    /**
     *  The ID of the rate plan associated with the rate plan charge.\n\n\n**Character limit**: 32\n\n\n**Values**: inherited from `RatePlan.Id` 
     * @return ratePlanId
     */
    public String ratePlanId { get; set; }

    /**
     *  Associates this product rate plan charge with a specific revenue recognition code.\n\n\n**Character limit**: 70\n\n\n**Values**: a valid revenue recognition code 
     * @return revRecCode
     */
    public String revRecCode { get; set; }

    /**
     *  Specifies when revenue recognition begins.\n\n\n**Character limit**: 22\n\n\n**Values**: one of the following:\n\n-  `ContractEffectiveDate`\n\n-  `ServiceActivationDate`\n\n-  `CustomerAcceptanceDate`\n\n
     * @return revRecTriggerCondition
     */
    public String revRecTriggerCondition { get; set; }

    /**
     *  Specifies the Revenue Recognition Rule that you want the Rate Plan Charge to use. This field can be updated when **Status** is `Draft`. By default, the Revenue Recognition Rule is inherited from the Product Rate Plan Charge. For Amend\ncalls, you can use this field only for NewProduct amendments. For Update\ncalls, you can use this field only to update subscriptions in draft status. Note that if you use this field to specify a Revenue Recognition Rule for the Rate Plan Charge, the rule will remain as specified even if you later change the rule used by the corresponding Product Rate Plan Charge. See [Z-Billing User Role](https://knowledgecenter.zuora.com/CF_Users_and_Administrators/A_Administrator_Settings/User_Roles/d_Billing_Roles) permission enabled to use this field.\n\n\n\n**Character limit**: n/a\n\n\n**Values**: name of an active Revenue Recognition Rule 
     * @return revenueRecognitionRuleName
     */
    public String revenueRecognitionRuleName { get; set; }

    /**
     *  Specifies the number of units of measure (UOM) rolled over from previous periods. This field is applicable only to usage charges with overage models.\n\n\n**Character limit**: 16\n\n\n**Values**: automatically generated\n\n**Note**:\n\n- You cannot query or filter this field with other fields in a single query.\n- To query or filter this field, you must specify and only specify the rate plan charge Id in the condition.\n- You cannot use this field in the query or filter condition.\n
     * @return rolloverBalance
     */
    public Double rolloverBalance { get; set; }

    /**
     *  The identifying number of the subscription rate plan segment. Segments are numbered sequentially, starting with 1.\n\n\n**Character limit**: 2\n\n\n**Values**: automatically generated 
     * @return segment
     */
    public Integer segment { get; set; }

    /**
     *  Customizes the number of months or weeks for the charges billing period. This field is only required if you set the value of the `BillingPeriod` field to `Specific Months` or `Specific Weeks`.\n\n\n**Character limit**: 5\n\n\n**Values**: inherited from `ProductRatePlanCharge.BillingPeriod` **Note:** You can override the value inherited from the Product Rate Plan Charge, but only when creating a new subscription or a New Product amendment. 
     * @return specificBillingPeriod
     */
    public Long specificBillingPeriod { get; set; }

    /**
     *  The specific date on which the charge ends, in `yyyy-mm-dd` format.\n\n\n**Character limit**: 29\n\n\n\n**Note**:\n\n- This field is only applicable when the `EndDateCondition` field is set to `SpecificEndDate`.\n- If the subscription ends before the specific end date, the charge ends when the subscription ends. But if the subscription end date is subsequently changed through a Renewal, or Terms and Conditions amendment, the charge will end on the specific end date.\n
     * @return specificEndDate
     */
    public Date specificEndDate { get; set; }

    /**
     *  The total contract value (TCV) is the value of a single rate plan charge in a subscription over the lifetime of the subscription. This value does not represent all charges on the subscription. The TCV includes recurring charges and one-time charges, but it doesn\'t include usage charge.\n\n\n**Character limit**: 16\n\n\n**Values**: automatically generated 
     * @return TCV
     */
    public Double TCV { get; set; }

    /**
     *  The date when the charge becomes effective and billing begins, in `yyyy-mm-dd` format. This field is only required if the `TriggerEvent` field is set to `SpecificDate`.\n\n\n**Character limit**: 29\n\n
     * @return triggerDate
     */
    public Date triggerDate { get; set; }

    /**
     *  Specifies when to start billing the customer for the charge.\n**Note: **This field can be passed through the subscribe\nand amend\ncalls and will override the default value set on the Product Rate Plan Charge.\n\n\n**Character limit**: 18\n\n\n**Values**: inherited from `ProductRatePlanCharge.TriggerEvent` and can be one of the following values:\n\n- `ContractEffective `is the date when the subscription\'s contract goes into effect and the charge is ready to be billed.\n- `ServiceActivationDate `is when the services or products for a subscription have been activated and the customers have access.\n- `CustomerAcceptance `is when the customer accepts the services or products for a subscription.\n- SpecificDate is valid only on the RatePlanCharge.\n
     * @return triggerEvent
     */
    public String triggerEvent { get; set; }

    /**
     *  Specifies the units to measure usage. Units of measure are configured in the web-based UI: **Z-Billing > Settings**.\n\n\n**Character limit**: 25\n\n\n**Values**: inherited from `ProductRatePlanCharge.UOM` 
     * @return UOM
     */
    public String UOM { get; set; }

    /**
     *  Specifies the rate to credit a customer for unused units of usage. This field is applicable only for overage charge models when the `OverageUnusedUnitsCreditOption` field value is CreditBySpecificRate.\n\n\n**Character limit**: 16\n\n\n**Values**: a valid decimal value 
     * @return unusedUnitsCreditRates
     */
    public Double unusedUnitsCreditRates { get; set; }

    /**
     *  Specifies the length of the period during which the charge is active. If this period ends before the subscription ends, the charge ends when this period ends.\n\n\n**Character limit**: 5\n\n\n**Values**: inherited from `ProductRatePlanCharge.UpToPeriods`\n\n**Note**:\n\n- You must use this field together with the `UpToPeriodsType` field to specify the time period. This field is only applicable only when the `EndDateCondition` field is set to `FixedPeriod`.\n- You can override the value inherited from the Product Rate Plan Charge, but only when creating a new subscription or a New Product amendment.\n- Use this field to override the value in `ProductRatePlanCharge.UpToPeriod`.\n- If you override the value in this field, enter a whole number between 0 and 65535, exclusive.\n- If the subscription end date is subsequently changed through a Renewal, or Terms and Conditions amendment, the charge end date will change accordingly up to the original period end.\n
     * @return upToPeriods
     */
    public Long upToPeriods { get; set; }

    /**
     *  The period type used to define when the charge ends. This field can be updated when **Status** is `Draft`.\n\n\n**Values**: one of the following:\n\n- `Billing Periods` (default)\n- `Days`\n- `Weeks`\n- `Months`\n- `Years`\n\n\n**Note**:\n\n- You must use this field together with the `UpToPeriods` field to specify the time period.\n- This field is only applicable only when the `EndDateCondition` field is set to `FixedPeriod`.\n
     * @return upToPeriodsType
     */
    public String upToPeriodsType { get; set; }

    /**
     * The ID of the last user to update the object.\n\n**Character limit**: 32\n\n\n**Values**: automatically generated 
     * @return updatedById
     */
    public String updatedById { get; set; }

    /**
     *  The date when the object was last updated.\n\n\n**Character limit**: 29\n\n\n**Values**: automatically generated 
     * @return updatedDate
     */
    public Datetime updatedDate { get; set; }

    /**
     *  Determines how Zuora processes usage records for per-unit usage charges.\n\n**Character limit**: 18\n\n\n**Values**: automatically generated 
     * @return usageRecordRatingOption
     */
    public String usageRecordRatingOption { get; set; }

    /**
     *  Determines whether to define a new accounting code for the new discount charge.\n\n\n**Character limit**: 5\n\n\n**Values**: inherited from `ProductRatePlanCharge.UseDiscountSpecificAccountingCode` 
     * @return useDiscountSpecificAccountingCode
     */
    public Boolean useDiscountSpecificAccountingCode { get; set; }

    /**
     *  The version of the rate plan charge. Each time a charge is amended, Zuora creates a new version of the rate plan charge.\n\n**Character limit**: 5\n\n\n**Values**: automatically generated 
     * @return version
     */
    public Long version { get; set; }

    /**
     *  Specifies which day of the week as the bill cycle day (BCD) for the charge.\nThis feature is in **Limited Availability**. If you wish to have access to the feature, submit a request at [Zuora Global Support](http://support.zuora.com/).\n\n\n\n\n**Values**: one of the following:\n\n- `Sunday`\n- `Monday`\n- `Tuesday`\n- `Wednesday`\n- `Thursday`\n- `Friday`\n- `Saturday`\n
     * @return weeklyBillCycleDay
     */
    public String weeklyBillCycleDay { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'AccountingCode' => 'accountingCode',
        'ApplyDiscountTo' => 'applyDiscountTo',
        'BillCycleDay' => 'billCycleDay',
        'BillCycleType' => 'billCycleType',
        'BillingPeriod' => 'billingPeriod',
        'BillingPeriodAlignment' => 'billingPeriodAlignment',
        'BillingTiming' => 'billingTiming',
        'ChargeModel' => 'chargeModel',
        'ChargeNumber' => 'chargeNumber',
        'ChargeType' => 'chargeType',
        'ChargedThroughDate' => 'chargedThroughDate',
        'CreatedById' => 'createdById',
        'CreatedDate' => 'createdDate',
        'Description' => 'description',
        'DiscountAmount' => 'discountAmount',
        'DiscountLevel' => 'discountLevel',
        'DiscountPercentage' => 'discountPercentage',
        'EffectiveEndDate' => 'effectiveEndDate',
        'EffectiveStartDate' => 'effectiveStartDate',
        'EndDateCondition' => 'endDateCondition',
        'IncludedUnits' => 'includedUnits',
        'IsLastSegment' => 'isLastSegment',
        'ListPriceBase' => 'listPriceBase',
        'Name' => 'name',
        'NumberOfPeriods' => 'numberOfPeriods',
        'OriginalId' => 'originalId',
        'OverageCalculationOption' => 'overageCalculationOption',
        'OveragePrice' => 'overagePrice',
        'OverageUnusedUnitsCreditOption' => 'overageUnusedUnitsCreditOption',
        'Price' => 'price',
        'PriceChangeOption' => 'priceChangeOption',
        'PriceIncreasePercentage' => 'priceIncreasePercentage',
        'ProcessedThroughDate' => 'processedThroughDate',
        'ProductRatePlanChargeId' => 'productRatePlanChargeId',
        'Quantity' => 'quantity',
        'RatePlanId' => 'ratePlanId',
        'RevRecCode' => 'revRecCode',
        'RevRecTriggerCondition' => 'revRecTriggerCondition',
        'RevenueRecognitionRuleName' => 'revenueRecognitionRuleName',
        'RolloverBalance' => 'rolloverBalance',
        'Segment' => 'segment',
        'SpecificBillingPeriod' => 'specificBillingPeriod',
        'SpecificEndDate' => 'specificEndDate',
        'TriggerDate' => 'triggerDate',
        'TriggerEvent' => 'triggerEvent',
        'UnusedUnitsCreditRates' => 'unusedUnitsCreditRates',
        'UpToPeriods' => 'upToPeriods',
        'UpToPeriodsType' => 'upToPeriodsType',
        'UpdatedById' => 'updatedById',
        'UpdatedDate' => 'updatedDate',
        'UsageRecordRatingOption' => 'usageRecordRatingOption',
        'UseDiscountSpecificAccountingCode' => 'useDiscountSpecificAccountingCode',
        'Version' => 'version',
        'WeeklyBillCycleDay' => 'weeklyBillCycleDay'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public static zc_RatePlanChargeInRatePlanChargeData getExample() {
        zc_RatePlanChargeInRatePlanChargeData ratePlanChargeDataInRatePlanDataRatePlanCharge = new zc_RatePlanChargeInRatePlanChargeData();
        ratePlanChargeDataInRatePlanDataRatePlanCharge.accountingCode = 'aeiou';
        ratePlanChargeDataInRatePlanDataRatePlanCharge.applyDiscountTo = 'aeiou';
        ratePlanChargeDataInRatePlanDataRatePlanCharge.billCycleDay = 123;
        ratePlanChargeDataInRatePlanDataRatePlanCharge.billCycleType = 'aeiou';
        ratePlanChargeDataInRatePlanDataRatePlanCharge.billingPeriod = 'aeiou';
        ratePlanChargeDataInRatePlanDataRatePlanCharge.billingPeriodAlignment = 'aeiou';
        ratePlanChargeDataInRatePlanDataRatePlanCharge.billingTiming = 'aeiou';
        ratePlanChargeDataInRatePlanDataRatePlanCharge.chargeModel = 'aeiou';
        ratePlanChargeDataInRatePlanDataRatePlanCharge.chargeNumber = 'aeiou';
        ratePlanChargeDataInRatePlanDataRatePlanCharge.chargeType = 'aeiou';
        ratePlanChargeDataInRatePlanDataRatePlanCharge.chargedThroughDate = Date.newInstance(2000, 1, 23);
        ratePlanChargeDataInRatePlanDataRatePlanCharge.createdById = 'aeiou';
        ratePlanChargeDataInRatePlanDataRatePlanCharge.createdDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
        ratePlanChargeDataInRatePlanDataRatePlanCharge.DMRC = 1.3579;
        ratePlanChargeDataInRatePlanDataRatePlanCharge.DTCV = 1.3579;
        ratePlanChargeDataInRatePlanDataRatePlanCharge.description = 'aeiou';
        ratePlanChargeDataInRatePlanDataRatePlanCharge.discountAmount = 1.3579;
        ratePlanChargeDataInRatePlanDataRatePlanCharge.discountLevel = 'aeiou';
        ratePlanChargeDataInRatePlanDataRatePlanCharge.discountPercentage = 1.3579;
        ratePlanChargeDataInRatePlanDataRatePlanCharge.effectiveEndDate = Date.newInstance(2000, 1, 23);
        ratePlanChargeDataInRatePlanDataRatePlanCharge.effectiveStartDate = Date.newInstance(2000, 1, 23);
        ratePlanChargeDataInRatePlanDataRatePlanCharge.endDateCondition = 'aeiou';
        ratePlanChargeDataInRatePlanDataRatePlanCharge.includedUnits = 1.3579;
        ratePlanChargeDataInRatePlanDataRatePlanCharge.isLastSegment = true;
        ratePlanChargeDataInRatePlanDataRatePlanCharge.listPriceBase = 'aeiou';
        ratePlanChargeDataInRatePlanDataRatePlanCharge.MRR = 1.3579;
        ratePlanChargeDataInRatePlanDataRatePlanCharge.name = 'aeiou';
        ratePlanChargeDataInRatePlanDataRatePlanCharge.numberOfPeriods = 123456789L;
        ratePlanChargeDataInRatePlanDataRatePlanCharge.originalId = 'aeiou';
        ratePlanChargeDataInRatePlanDataRatePlanCharge.overageCalculationOption = 'aeiou';
        ratePlanChargeDataInRatePlanDataRatePlanCharge.overagePrice = 1.3579;
        ratePlanChargeDataInRatePlanDataRatePlanCharge.overageUnusedUnitsCreditOption = 'aeiou';
        ratePlanChargeDataInRatePlanDataRatePlanCharge.price = 1.3579;
        ratePlanChargeDataInRatePlanDataRatePlanCharge.priceChangeOption = 'aeiou';
        ratePlanChargeDataInRatePlanDataRatePlanCharge.priceIncreasePercentage = 1.3579;
        ratePlanChargeDataInRatePlanDataRatePlanCharge.processedThroughDate = Date.newInstance(2000, 1, 23);
        ratePlanChargeDataInRatePlanDataRatePlanCharge.productRatePlanChargeId = 'aeiou';
        ratePlanChargeDataInRatePlanDataRatePlanCharge.quantity = 1.3579;
        ratePlanChargeDataInRatePlanDataRatePlanCharge.ratePlanId = 'aeiou';
        ratePlanChargeDataInRatePlanDataRatePlanCharge.revRecCode = 'aeiou';
        ratePlanChargeDataInRatePlanDataRatePlanCharge.revRecTriggerCondition = 'aeiou';
        ratePlanChargeDataInRatePlanDataRatePlanCharge.revenueRecognitionRuleName = 'aeiou';
        ratePlanChargeDataInRatePlanDataRatePlanCharge.rolloverBalance = 1.3579;
        ratePlanChargeDataInRatePlanDataRatePlanCharge.segment = 123;
        ratePlanChargeDataInRatePlanDataRatePlanCharge.specificBillingPeriod = 123456789L;
        ratePlanChargeDataInRatePlanDataRatePlanCharge.specificEndDate = Date.newInstance(2000, 1, 23);
        ratePlanChargeDataInRatePlanDataRatePlanCharge.TCV = 1.3579;
        ratePlanChargeDataInRatePlanDataRatePlanCharge.triggerDate = Date.newInstance(2000, 1, 23);
        ratePlanChargeDataInRatePlanDataRatePlanCharge.triggerEvent = 'aeiou';
        ratePlanChargeDataInRatePlanDataRatePlanCharge.UOM = 'aeiou';
        ratePlanChargeDataInRatePlanDataRatePlanCharge.unusedUnitsCreditRates = 1.3579;
        ratePlanChargeDataInRatePlanDataRatePlanCharge.upToPeriods = 123456789L;
        ratePlanChargeDataInRatePlanDataRatePlanCharge.upToPeriodsType = 'aeiou';
        ratePlanChargeDataInRatePlanDataRatePlanCharge.updatedById = 'aeiou';
        ratePlanChargeDataInRatePlanDataRatePlanCharge.updatedDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
        ratePlanChargeDataInRatePlanDataRatePlanCharge.usageRecordRatingOption = 'aeiou';
        ratePlanChargeDataInRatePlanDataRatePlanCharge.useDiscountSpecificAccountingCode = true;
        ratePlanChargeDataInRatePlanDataRatePlanCharge.version = 123456789L;
        ratePlanChargeDataInRatePlanDataRatePlanCharge.weeklyBillCycleDay = 'aeiou';
        return ratePlanChargeDataInRatePlanDataRatePlanCharge;
    }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_RatePlanChargeInRatePlanChargeData) {
            zc_RatePlanChargeInRatePlanChargeData ratePlanChargeDataInRatePlanDataRatePlanCharge = (zc_RatePlanChargeInRatePlanChargeData) obj;
            return this.accountingCode == ratePlanChargeDataInRatePlanDataRatePlanCharge.accountingCode
                && this.applyDiscountTo == ratePlanChargeDataInRatePlanDataRatePlanCharge.applyDiscountTo
                && this.billCycleDay == ratePlanChargeDataInRatePlanDataRatePlanCharge.billCycleDay
                && this.billCycleType == ratePlanChargeDataInRatePlanDataRatePlanCharge.billCycleType
                && this.billingPeriod == ratePlanChargeDataInRatePlanDataRatePlanCharge.billingPeriod
                && this.billingPeriodAlignment == ratePlanChargeDataInRatePlanDataRatePlanCharge.billingPeriodAlignment
                && this.billingTiming == ratePlanChargeDataInRatePlanDataRatePlanCharge.billingTiming
                && this.chargeModel == ratePlanChargeDataInRatePlanDataRatePlanCharge.chargeModel
                && this.chargeNumber == ratePlanChargeDataInRatePlanDataRatePlanCharge.chargeNumber
                && this.chargeType == ratePlanChargeDataInRatePlanDataRatePlanCharge.chargeType
                && this.chargedThroughDate == ratePlanChargeDataInRatePlanDataRatePlanCharge.chargedThroughDate
                && this.createdById == ratePlanChargeDataInRatePlanDataRatePlanCharge.createdById
                && this.createdDate == ratePlanChargeDataInRatePlanDataRatePlanCharge.createdDate
                && this.DMRC == ratePlanChargeDataInRatePlanDataRatePlanCharge.DMRC
                && this.DTCV == ratePlanChargeDataInRatePlanDataRatePlanCharge.DTCV
                && this.description == ratePlanChargeDataInRatePlanDataRatePlanCharge.description
                && this.discountAmount == ratePlanChargeDataInRatePlanDataRatePlanCharge.discountAmount
                && this.discountLevel == ratePlanChargeDataInRatePlanDataRatePlanCharge.discountLevel
                && this.discountPercentage == ratePlanChargeDataInRatePlanDataRatePlanCharge.discountPercentage
                && this.effectiveEndDate == ratePlanChargeDataInRatePlanDataRatePlanCharge.effectiveEndDate
                && this.effectiveStartDate == ratePlanChargeDataInRatePlanDataRatePlanCharge.effectiveStartDate
                && this.endDateCondition == ratePlanChargeDataInRatePlanDataRatePlanCharge.endDateCondition
                && this.includedUnits == ratePlanChargeDataInRatePlanDataRatePlanCharge.includedUnits
                && this.isLastSegment == ratePlanChargeDataInRatePlanDataRatePlanCharge.isLastSegment
                && this.listPriceBase == ratePlanChargeDataInRatePlanDataRatePlanCharge.listPriceBase
                && this.MRR == ratePlanChargeDataInRatePlanDataRatePlanCharge.MRR
                && this.name == ratePlanChargeDataInRatePlanDataRatePlanCharge.name
                && this.numberOfPeriods == ratePlanChargeDataInRatePlanDataRatePlanCharge.numberOfPeriods
                && this.originalId == ratePlanChargeDataInRatePlanDataRatePlanCharge.originalId
                && this.overageCalculationOption == ratePlanChargeDataInRatePlanDataRatePlanCharge.overageCalculationOption
                && this.overagePrice == ratePlanChargeDataInRatePlanDataRatePlanCharge.overagePrice
                && this.overageUnusedUnitsCreditOption == ratePlanChargeDataInRatePlanDataRatePlanCharge.overageUnusedUnitsCreditOption
                && this.price == ratePlanChargeDataInRatePlanDataRatePlanCharge.price
                && this.priceChangeOption == ratePlanChargeDataInRatePlanDataRatePlanCharge.priceChangeOption
                && this.priceIncreasePercentage == ratePlanChargeDataInRatePlanDataRatePlanCharge.priceIncreasePercentage
                && this.processedThroughDate == ratePlanChargeDataInRatePlanDataRatePlanCharge.processedThroughDate
                && this.productRatePlanChargeId == ratePlanChargeDataInRatePlanDataRatePlanCharge.productRatePlanChargeId
                && this.quantity == ratePlanChargeDataInRatePlanDataRatePlanCharge.quantity
                && this.ratePlanId == ratePlanChargeDataInRatePlanDataRatePlanCharge.ratePlanId
                && this.revRecCode == ratePlanChargeDataInRatePlanDataRatePlanCharge.revRecCode
                && this.revRecTriggerCondition == ratePlanChargeDataInRatePlanDataRatePlanCharge.revRecTriggerCondition
                && this.revenueRecognitionRuleName == ratePlanChargeDataInRatePlanDataRatePlanCharge.revenueRecognitionRuleName
                && this.rolloverBalance == ratePlanChargeDataInRatePlanDataRatePlanCharge.rolloverBalance
                && this.segment == ratePlanChargeDataInRatePlanDataRatePlanCharge.segment
                && this.specificBillingPeriod == ratePlanChargeDataInRatePlanDataRatePlanCharge.specificBillingPeriod
                && this.specificEndDate == ratePlanChargeDataInRatePlanDataRatePlanCharge.specificEndDate
                && this.TCV == ratePlanChargeDataInRatePlanDataRatePlanCharge.TCV
                && this.triggerDate == ratePlanChargeDataInRatePlanDataRatePlanCharge.triggerDate
                && this.triggerEvent == ratePlanChargeDataInRatePlanDataRatePlanCharge.triggerEvent
                && this.UOM == ratePlanChargeDataInRatePlanDataRatePlanCharge.UOM
                && this.unusedUnitsCreditRates == ratePlanChargeDataInRatePlanDataRatePlanCharge.unusedUnitsCreditRates
                && this.upToPeriods == ratePlanChargeDataInRatePlanDataRatePlanCharge.upToPeriods
                && this.upToPeriodsType == ratePlanChargeDataInRatePlanDataRatePlanCharge.upToPeriodsType
                && this.updatedById == ratePlanChargeDataInRatePlanDataRatePlanCharge.updatedById
                && this.updatedDate == ratePlanChargeDataInRatePlanDataRatePlanCharge.updatedDate
                && this.usageRecordRatingOption == ratePlanChargeDataInRatePlanDataRatePlanCharge.usageRecordRatingOption
                && this.useDiscountSpecificAccountingCode == ratePlanChargeDataInRatePlanDataRatePlanCharge.useDiscountSpecificAccountingCode
                && this.version == ratePlanChargeDataInRatePlanDataRatePlanCharge.version
                && this.weeklyBillCycleDay == ratePlanChargeDataInRatePlanDataRatePlanCharge.weeklyBillCycleDay;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (accountingCode == null ? 0 : System.hashCode(accountingCode));
        hashCode = (17 * hashCode) + (applyDiscountTo == null ? 0 : System.hashCode(applyDiscountTo));
        hashCode = (17 * hashCode) + (billCycleDay == null ? 0 : System.hashCode(billCycleDay));
        hashCode = (17 * hashCode) + (billCycleType == null ? 0 : System.hashCode(billCycleType));
        hashCode = (17 * hashCode) + (billingPeriod == null ? 0 : System.hashCode(billingPeriod));
        hashCode = (17 * hashCode) + (billingPeriodAlignment == null ? 0 : System.hashCode(billingPeriodAlignment));
        hashCode = (17 * hashCode) + (billingTiming == null ? 0 : System.hashCode(billingTiming));
        hashCode = (17 * hashCode) + (chargeModel == null ? 0 : System.hashCode(chargeModel));
        hashCode = (17 * hashCode) + (chargeNumber == null ? 0 : System.hashCode(chargeNumber));
        hashCode = (17 * hashCode) + (chargeType == null ? 0 : System.hashCode(chargeType));
        hashCode = (17 * hashCode) + (chargedThroughDate == null ? 0 : System.hashCode(chargedThroughDate));
        hashCode = (17 * hashCode) + (createdById == null ? 0 : System.hashCode(createdById));
        hashCode = (17 * hashCode) + (createdDate == null ? 0 : System.hashCode(createdDate));
        hashCode = (17 * hashCode) + (DMRC == null ? 0 : System.hashCode(DMRC));
        hashCode = (17 * hashCode) + (DTCV == null ? 0 : System.hashCode(DTCV));
        hashCode = (17 * hashCode) + (description == null ? 0 : System.hashCode(description));
        hashCode = (17 * hashCode) + (discountAmount == null ? 0 : System.hashCode(discountAmount));
        hashCode = (17 * hashCode) + (discountLevel == null ? 0 : System.hashCode(discountLevel));
        hashCode = (17 * hashCode) + (discountPercentage == null ? 0 : System.hashCode(discountPercentage));
        hashCode = (17 * hashCode) + (effectiveEndDate == null ? 0 : System.hashCode(effectiveEndDate));
        hashCode = (17 * hashCode) + (effectiveStartDate == null ? 0 : System.hashCode(effectiveStartDate));
        hashCode = (17 * hashCode) + (endDateCondition == null ? 0 : System.hashCode(endDateCondition));
        hashCode = (17 * hashCode) + (includedUnits == null ? 0 : System.hashCode(includedUnits));
        hashCode = (17 * hashCode) + (isLastSegment == null ? 0 : System.hashCode(isLastSegment));
        hashCode = (17 * hashCode) + (listPriceBase == null ? 0 : System.hashCode(listPriceBase));
        hashCode = (17 * hashCode) + (MRR == null ? 0 : System.hashCode(MRR));
        hashCode = (17 * hashCode) + (name == null ? 0 : System.hashCode(name));
        hashCode = (17 * hashCode) + (numberOfPeriods == null ? 0 : System.hashCode(numberOfPeriods));
        hashCode = (17 * hashCode) + (originalId == null ? 0 : System.hashCode(originalId));
        hashCode = (17 * hashCode) + (overageCalculationOption == null ? 0 : System.hashCode(overageCalculationOption));
        hashCode = (17 * hashCode) + (overagePrice == null ? 0 : System.hashCode(overagePrice));
        hashCode = (17 * hashCode) + (overageUnusedUnitsCreditOption == null ? 0 : System.hashCode(overageUnusedUnitsCreditOption));
        hashCode = (17 * hashCode) + (price == null ? 0 : System.hashCode(price));
        hashCode = (17 * hashCode) + (priceChangeOption == null ? 0 : System.hashCode(priceChangeOption));
        hashCode = (17 * hashCode) + (priceIncreasePercentage == null ? 0 : System.hashCode(priceIncreasePercentage));
        hashCode = (17 * hashCode) + (processedThroughDate == null ? 0 : System.hashCode(processedThroughDate));
        hashCode = (17 * hashCode) + (productRatePlanChargeId == null ? 0 : System.hashCode(productRatePlanChargeId));
        hashCode = (17 * hashCode) + (quantity == null ? 0 : System.hashCode(quantity));
        hashCode = (17 * hashCode) + (ratePlanId == null ? 0 : System.hashCode(ratePlanId));
        hashCode = (17 * hashCode) + (revRecCode == null ? 0 : System.hashCode(revRecCode));
        hashCode = (17 * hashCode) + (revRecTriggerCondition == null ? 0 : System.hashCode(revRecTriggerCondition));
        hashCode = (17 * hashCode) + (revenueRecognitionRuleName == null ? 0 : System.hashCode(revenueRecognitionRuleName));
        hashCode = (17 * hashCode) + (rolloverBalance == null ? 0 : System.hashCode(rolloverBalance));
        hashCode = (17 * hashCode) + (segment == null ? 0 : System.hashCode(segment));
        hashCode = (17 * hashCode) + (specificBillingPeriod == null ? 0 : System.hashCode(specificBillingPeriod));
        hashCode = (17 * hashCode) + (specificEndDate == null ? 0 : System.hashCode(specificEndDate));
        hashCode = (17 * hashCode) + (TCV == null ? 0 : System.hashCode(TCV));
        hashCode = (17 * hashCode) + (triggerDate == null ? 0 : System.hashCode(triggerDate));
        hashCode = (17 * hashCode) + (triggerEvent == null ? 0 : System.hashCode(triggerEvent));
        hashCode = (17 * hashCode) + (UOM == null ? 0 : System.hashCode(UOM));
        hashCode = (17 * hashCode) + (unusedUnitsCreditRates == null ? 0 : System.hashCode(unusedUnitsCreditRates));
        hashCode = (17 * hashCode) + (upToPeriods == null ? 0 : System.hashCode(upToPeriods));
        hashCode = (17 * hashCode) + (upToPeriodsType == null ? 0 : System.hashCode(upToPeriodsType));
        hashCode = (17 * hashCode) + (updatedById == null ? 0 : System.hashCode(updatedById));
        hashCode = (17 * hashCode) + (updatedDate == null ? 0 : System.hashCode(updatedDate));
        hashCode = (17 * hashCode) + (usageRecordRatingOption == null ? 0 : System.hashCode(usageRecordRatingOption));
        hashCode = (17 * hashCode) + (useDiscountSpecificAccountingCode == null ? 0 : System.hashCode(useDiscountSpecificAccountingCode));
        hashCode = (17 * hashCode) + (version == null ? 0 : System.hashCode(version));
        hashCode = (17 * hashCode) + (weeklyBillCycleDay == null ? 0 : System.hashCode(weeklyBillCycleDay));
        return hashCode;
    }
}