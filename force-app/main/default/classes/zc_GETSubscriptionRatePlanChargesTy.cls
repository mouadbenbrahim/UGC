/**
 * zc_GETSubscriptionRatePlanChargesTy
 */
public class zc_GETSubscriptionRatePlanChargesTy {
    /**
     * Specifies the type of charges a specific discount applies to. \n\nThis field is only used when applied to a discount charge model. If you are not using a discount charge model, the value is null.\n\nPossible values:\n\n* `RECURRING`\n* `USAGE`\n* `ONETIMERECURRING`\n* `ONETIMEUSAGE`\n* `RECURRINGUSAGE`\n* `ONETIMERECURRINGUSAGE`\n
     * @return applyDiscountTo
     */
    public String applyDiscountTo { get; set; }

    /**
     * Billing cycle day (BCD), which is when bill runs generate invoices\nfor charges associated with the product rate plan charge or the account.  \n\nValues:\n\n* `DefaultFromCustomer`\n* `SpecificDayofMonth(#)`\n* `SubscriptionStartDay`\n* `ChargeTriggerDay`\n* `SpecificDayofWeek/dayofweek`: in which dayofweek is the day in the week you define your billing periods to start.\n\nIn the response data, a day-of-the-month value (`1`-`31`) appears in place of the hash sign above ("#"). If this value exceeds the number of days in a particular month, the last day of the month is used as the BCD.\n
     * @return billingDay
     */
    public String billingDay { get; set; }

    /**
     * Allows billing period to be overridden on the rate plan charge.\n
     * @return billingPeriod
     */
    public String billingPeriod { get; set; }

    /**
     * Possible values:\n\n* `AlignToCharge`\n* `AlignToSubscriptionStart`\n* `AlignToTermStart`\n
     * @return billingPeriodAlignment
     */
    public String billingPeriodAlignment { get; set; }

    /**
     * The billing timing for the charge. This field is only used if the `ratePlanChargeType` value is `Recurring`.\n\nPossible values are:\n\n* `In Advance`\n* `In Arrears`\n\n**Note:** This feature is in **Limited Availability**. If you wish to have access to the feature, submit a request at [Zuora Global Support](http://support.zuora.com/).\n
     * @return billingTiming
     */
    public String billingTiming { get; set; }

    /**
     * The date through which a customer has been billed for the charge.\n
     * @return chargedThroughDate
     */
    public Date chargedThroughDate { get; set; }

    /**
     * Currency used by the account. For example, `USD` or `EUR`.\n
     * @return currency
     */
    public String currency2 { get; set; }

    /**
     * Description of the rate plan charge.\n
     * @return description
     */
    public String description { get; set; }

    /**
     * The amount of the discount.\n
     * @return discountAmount
     */
    public String discountAmount { get; set; }

    /**
     * Container for the application details about a discount rate plan charge. \n\nOnly discount rate plan charges have values in this field.\n
     * @return discountApplyDetails
     */
    public List<zc_GETDiscountApplyDetailsType> discountApplyDetails { get; set; }

    /**
     * The class that the discount belongs to. The discount class defines the order in which discount rate plan charges are applied.\n\nFor more information, see [Manage Discount Classes](https://knowledgecenter.zuora.com/BC_Subscription_Management/Product_Catalog/B_Charge_Models/Manage_Discount_Classes).\n
     * @return discountClass
     */
    public String discountClass { get; set; }

    /**
     * The level of the discount. Values: `RatePlan`, `Subscription`, `Account`.\n
     * @return discountLevel
     */
    public String discountLevel { get; set; }

    /**
     * The amount of the discount as a percentage.\n
     * @return discountPercentage
     */
    public String discountPercentage { get; set; }

    /**
     * The change (delta) of monthly recurring charge exists when the change in monthly recurring revenue caused by an amendment or a new subscription.\n
     * @return dmrc
     */
    public String dmrc { get; set; }

    /**
     * A value of `true` indicates that an invoice for a charge segment has been completed. A value of `false` indicates that an invoice has not bee completed for the charge segment.\n
     * @return done
     */
    public Boolean done { get; set; }

    /**
     * After an amendment or an AutomatedPriceChange event, `dtcv` displays the change (delta) for the total contract value (TCV) amount for this charge, compared with its previous value with recurring charge types.\n
     * @return dtcv
     */
    public String dtcv { get; set; }

    /**
     * The effective end date of the rate plan charge.\n
     * @return effectiveEndDate
     */
    public Date effectiveEndDate { get; set; }

    /**
     * The effective start date of the rate plan charge.\n
     * @return effectiveStartDate
     */
    public Date effectiveStartDate { get; set; }

    /**
     * Defines when the charge ends after the charge trigger date.\n\nIf the subscription ends before the charge end date, the charge ends when the subscription ends. But if the subscription end date is subsequently changed through a Renewal, or Terms and Conditions amendment, the charge will end on the charge end date.\n\nValues:\n\n* `Subscription_End`\n* `Fixed_Period`\n* `Specific_End_Date`\n
     * @return endDateCondition
     */
    public String endDateCondition { get; set; }

    /**
     * Rate plan charge ID.\n
     * @return id
     */
    public String id { get; set; }

    /**
     * Specifies the number of units in the base set of units.\n
     * @return includedUnits
     */
    public String includedUnits { get; set; }

    /**
     * List price base; possible values are:\n\n* `Per_Billing_Period`\n* `Per_Month`\n* `Per_Week`\n
     * @return listPriceBase
     */
    public String listPriceBase { get; set; }

    /**
     * Charge model; possible values are:\n\n* `FlatFee`\n* `PerUnit`\n* `Overage`\n* `Volume`\n* `Tiered`\n* `TieredWithOverage`\n* `DiscountFixedAmount`\n* `DiscountPercentage`\n
     * @return model
     */
    public String model { get; set; }

    /**
     * Monthly recurring revenue of the rate plan charge.\n
     * @return mrr
     */
    public String mrr { get; set; }

    /**
     * Charge name.\n
     * @return name
     */
    public String name { get; set; }

    /**
     * Charge number.\n
     * @return r_number
     */
    public String r_number { get; set; }

    /**
     * Specifies the number of periods to use when calculating charges in an overage smoothing charge model.\n
     * @return numberOfPeriods
     */
    public Long numberOfPeriods { get; set; }

    /**
     * The original ID of the rate plan charge.\n
     * @return originalChargeId
     */
    public String originalChargeId { get; set; }

    /**
     * Determines when to calculate overage charges.\n
     * @return overageCalculationOption
     */
    public String overageCalculationOption { get; set; }

    /**
     * The price for units over the allowed amount.\n
     * @return overagePrice
     */
    public String overagePrice { get; set; }

    /**
     * Determines whether to credit the customer with unused units of usage.\n
     * @return overageUnusedUnitsCreditOption
     */
    public String overageUnusedUnitsCreditOption { get; set; }

    /**
     * The price associated with the rate plan charge expressed as a decimal.\n
     * @return price
     */
    public String price { get; set; }

    /**
     * When the following is true:\n\n1. AutomatedPriceChange setting is on\n\n2. Charge type is not one-time\n\n3. Charge model is not discount percentage\n\nThen an automatic price change can have a value for when a termed subscription is renewed. \n\nValues (one of the following):\n\n* `NoChange` (default)\n* `SpecificPercentageValue`\n* `UseLatestProductCatalogPricing`\n
     * @return priceChangeOption
     */
    public String priceChangeOption { get; set; }

    /**
     * A planned future price increase amount as a percentage.\n
     * @return priceIncreasePercentage
     */
    public String priceIncreasePercentage { get; set; }

    /**
     * Concise description of rate plan charge model.\n
     * @return pricingSummary
     */
    public String pricingSummary { get; set; }

    /**
     * The date until when charges have been processed. When billing in arrears, such as usage, this field value is the the same as the `ChargedThroughDate` value. This date is the earliest date when a charge can be amended.\n
     * @return processedThroughDate
     */
    public Date processedThroughDate { get; set; }

    /**
     * 
     * @return productRatePlanChargeId
     */
    public String productRatePlanChargeId { get; set; }

    /**
     * The quantity of units, such as the number of authors in a hosted wiki service. Valid for all charge models except for Flat Fee pricing.\n
     * @return quantity
     */
    public String quantity { get; set; }

    /**
     * Specifies a rating group based on which usage records are rated.\n\n**Note:** This feature is in **Limited Availability**. If you wish to have access to the feature, submit a request at [Zuora Global Support](http://support.zuora.com/).\n\nPossible values:\n\n- `ByBillingPeriod` (default): The rating is based on all the usages in a billing period.\n- `ByUsageStartDate`: The rating is based on all the usages on the same usage start date. \n- `ByUsageRecord`: The rating is based on each usage record.\n- `ByUsageUpload`: The rating is based on all the  usages in a uploaded usage file (`.xls` or `.csv`).\n- `ByGroupId`: The rating is based on all the usages in a custom group.\n\n**Note:** \n- The `ByBillingPeriod` value can be applied for all charge models. \n- The `ByUsageStartDate`, `ByUsageRecord`, and `ByUsageUpload` values can only be applied for per unit, volume pricing, and tiered pricing charge models. \n- The `ByGroupId` value is only available if you have [Active Rating](https://knowledgecenter.zuora.com/CB_Billing/J_Billing_Operations/H_Active_Rating) feature enabled.\n- Use this field only for Usage charges. One-Time Charges and Recurring Charges return `NULL`.\n
     * @return ratingGroup
     */
    public String ratingGroup { get; set; }

    /**
     * The identifying number of the subscription rate plan segment. Segments are numbered sequentially, starting with 1.\n
     * @return segment
     */
    public Long segment { get; set; }

    /**
     * Specifies when revenue recognition begins. When charge model is `Overage` or `TieredWithOverage`, `smoothingModel` will be one of the following values:\n\n* `ContractEffectiveDate`\n* `ServiceActivationDate`\n* `CustomerAcceptanceDate`\n
     * @return smoothingModel
     */
    public String smoothingModel { get; set; }

    /**
     * Customizes the number of month or week for the charges billing period. This field is required if you set the value of the `BillingPeriod` field to `Specific_Months` or `Specific_Weeks`.\n
     * @return specificBillingPeriod
     */
    public Long specificBillingPeriod { get; set; }

    /**
     * The specific date on which the charge ends. If the subscription ends before the specific end date, the charge ends when the subscription ends. But if the subscription end date is subsequently changed through a Renewal, or Terms and Conditions amendment, the charge will end on the specific end date.\n
     * @return specificEndDate
     */
    public Date specificEndDate { get; set; }

    /**
     * The total contract value.\n
     * @return tcv
     */
    public String tcv { get; set; }

    /**
     * One or many defined ranges with distinct pricing.\n
     * @return tiers
     */
    public List<zc_GETTierType> tiers { get; set; }

    /**
     * The date that the rate plan charge will be triggered.\n
     * @return triggerDate
     */
    public Date triggerDate { get; set; }

    /**
     * The event that will cause the rate plan charge to be triggered.\n\nPossible values: \n\n* `ContractEffective`\n* `ServiceActivation`\n* `CustomerAcceptance`\n* `SpecificDate`\n
     * @return triggerEvent
     */
    public String triggerEvent { get; set; }

    /**
     * Charge type. Possible values are: `OneTime`, `Recurring`, `Usage`.\n
     * @return r_type
     */
    public String r_type { get; set; }

    /**
     * Specifies the rate to credit a customer for unused units of usage. This field is applicable only for overage charge models when the \n`OverageUnusedUnitsCreditOption` field value is `CreditBySpecificRate`.\n
     * @return unusedUnitsCreditRates
     */
    public String unusedUnitsCreditRates { get; set; }

    /**
     * Specifies the units to measure usage. \n
     * @return uom
     */
    public String uom { get; set; }

    /**
     * Specifies the length of the period during which the charge is active. If this period ends before the subscription ends, the charge ends when this period ends.\n\nIf the subscription end date is subsequently changed through a Renewal, or Terms and Conditions amendment, the charge end date will change accordingly up to the original period end.\n
     * @return upToPeriods
     */
    public String upToPeriods { get; set; }

    /**
     * The period type used to define when the charge ends. \n\nValues:\n\n* `Billing_Periods`\n* `Days`\n* `Weeks`\n* `Months`\n* `Years`\n
     * @return upToPeriodsType
     */
    public String upToPeriodsType { get; set; }

    /**
     * Determines how Zuora processes usage records for per-unit usage charges. \n
     * @return usageRecordRatingOption
     */
    public String usageRecordRatingOption { get; set; }

    /**
     * Rate plan charge revision number.\n
     * @return version
     */
    public Long version { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'number' => 'r_number',
        'type' => 'r_type',
        'currency' => 'currency2'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public zc_GETSubscriptionRatePlanChargesTy() {
        discountApplyDetails = new List<zc_GETDiscountApplyDetailsType>{new zc_GETDiscountApplyDetailsType()};
        tiers = new List<zc_GETTierType>{new zc_GETTierType()};
    }

    // public static zc_GETSubscriptionRatePlanChargesTy getExample() {
    //     zc_GETSubscriptionRatePlanChargesTy geTSubscriptionRatePlanChargesType = new zc_GETSubscriptionRatePlanChargesTy();
    //     geTSubscriptionRatePlanChargesType.applyDiscountTo = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.billingDay = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.billingPeriod = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.billingPeriodAlignment = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.billingTiming = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.chargedThroughDate = Date.newInstance(2000, 1, 23);
    //     geTSubscriptionRatePlanChargesType.currency = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.description = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.discountAmount = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.discountApplyDetails = new List<zc_GETDiscountApplyDetailsType>{zc_GETDiscountApplyDetailsType.getExample()};
    //     geTSubscriptionRatePlanChargesType.discountClass = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.discountLevel = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.discountPercentage = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.dmrc = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.done = true;
    //     geTSubscriptionRatePlanChargesType.dtcv = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.effectiveEndDate = Date.newInstance(2000, 1, 23);
    //     geTSubscriptionRatePlanChargesType.effectiveStartDate = Date.newInstance(2000, 1, 23);
    //     geTSubscriptionRatePlanChargesType.endDateCondition = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.id = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.includedUnits = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.listPriceBase = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.model = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.mrr = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.name = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.r_number = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.numberOfPeriods = 123456789L;
    //     geTSubscriptionRatePlanChargesType.originalChargeId = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.overageCalculationOption = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.overagePrice = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.overageUnusedUnitsCreditOption = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.price = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.priceChangeOption = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.priceIncreasePercentage = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.pricingSummary = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.processedThroughDate = Date.newInstance(2000, 1, 23);
    //     geTSubscriptionRatePlanChargesType.productRatePlanChargeId = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.quantity = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.ratingGroup = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.segment = 123456789L;
    //     geTSubscriptionRatePlanChargesType.smoothingModel = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.specificBillingPeriod = 123456789L;
    //     geTSubscriptionRatePlanChargesType.specificEndDate = Date.newInstance(2000, 1, 23);
    //     geTSubscriptionRatePlanChargesType.tcv = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.tiers = new List<zc_GETTierType>{zc_GETTierType.getExample()};
    //     geTSubscriptionRatePlanChargesType.triggerDate = Date.newInstance(2000, 1, 23);
    //     geTSubscriptionRatePlanChargesType.triggerEvent = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.r_type = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.unusedUnitsCreditRates = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.uom = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.upToPeriods = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.upToPeriodsType = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.usageRecordRatingOption = 'aeiou';
    //     geTSubscriptionRatePlanChargesType.version = 123456789L;
    //     return geTSubscriptionRatePlanChargesType;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_GETSubscriptionRatePlanChargesTy) {
            zc_GETSubscriptionRatePlanChargesTy geTSubscriptionRatePlanChargesType = (zc_GETSubscriptionRatePlanChargesTy) obj;
            return this.applyDiscountTo == geTSubscriptionRatePlanChargesType.applyDiscountTo
                && this.billingDay == geTSubscriptionRatePlanChargesType.billingDay
                && this.billingPeriod == geTSubscriptionRatePlanChargesType.billingPeriod
                && this.billingPeriodAlignment == geTSubscriptionRatePlanChargesType.billingPeriodAlignment
                && this.billingTiming == geTSubscriptionRatePlanChargesType.billingTiming
                && this.chargedThroughDate == geTSubscriptionRatePlanChargesType.chargedThroughDate
                && this.currency2 == geTSubscriptionRatePlanChargesType.currency2
                && this.description == geTSubscriptionRatePlanChargesType.description
                && this.discountAmount == geTSubscriptionRatePlanChargesType.discountAmount
                && this.discountApplyDetails == geTSubscriptionRatePlanChargesType.discountApplyDetails
                && this.discountClass == geTSubscriptionRatePlanChargesType.discountClass
                && this.discountLevel == geTSubscriptionRatePlanChargesType.discountLevel
                && this.discountPercentage == geTSubscriptionRatePlanChargesType.discountPercentage
                && this.dmrc == geTSubscriptionRatePlanChargesType.dmrc
                && this.done == geTSubscriptionRatePlanChargesType.done
                && this.dtcv == geTSubscriptionRatePlanChargesType.dtcv
                && this.effectiveEndDate == geTSubscriptionRatePlanChargesType.effectiveEndDate
                && this.effectiveStartDate == geTSubscriptionRatePlanChargesType.effectiveStartDate
                && this.endDateCondition == geTSubscriptionRatePlanChargesType.endDateCondition
                && this.id == geTSubscriptionRatePlanChargesType.id
                && this.includedUnits == geTSubscriptionRatePlanChargesType.includedUnits
                && this.listPriceBase == geTSubscriptionRatePlanChargesType.listPriceBase
                && this.model == geTSubscriptionRatePlanChargesType.model
                && this.mrr == geTSubscriptionRatePlanChargesType.mrr
                && this.name == geTSubscriptionRatePlanChargesType.name
                && this.r_number == geTSubscriptionRatePlanChargesType.r_number
                && this.numberOfPeriods == geTSubscriptionRatePlanChargesType.numberOfPeriods
                && this.originalChargeId == geTSubscriptionRatePlanChargesType.originalChargeId
                && this.overageCalculationOption == geTSubscriptionRatePlanChargesType.overageCalculationOption
                && this.overagePrice == geTSubscriptionRatePlanChargesType.overagePrice
                && this.overageUnusedUnitsCreditOption == geTSubscriptionRatePlanChargesType.overageUnusedUnitsCreditOption
                && this.price == geTSubscriptionRatePlanChargesType.price
                && this.priceChangeOption == geTSubscriptionRatePlanChargesType.priceChangeOption
                && this.priceIncreasePercentage == geTSubscriptionRatePlanChargesType.priceIncreasePercentage
                && this.pricingSummary == geTSubscriptionRatePlanChargesType.pricingSummary
                && this.processedThroughDate == geTSubscriptionRatePlanChargesType.processedThroughDate
                && this.productRatePlanChargeId == geTSubscriptionRatePlanChargesType.productRatePlanChargeId
                && this.quantity == geTSubscriptionRatePlanChargesType.quantity
                && this.ratingGroup == geTSubscriptionRatePlanChargesType.ratingGroup
                && this.segment == geTSubscriptionRatePlanChargesType.segment
                && this.smoothingModel == geTSubscriptionRatePlanChargesType.smoothingModel
                && this.specificBillingPeriod == geTSubscriptionRatePlanChargesType.specificBillingPeriod
                && this.specificEndDate == geTSubscriptionRatePlanChargesType.specificEndDate
                && this.tcv == geTSubscriptionRatePlanChargesType.tcv
                && this.tiers == geTSubscriptionRatePlanChargesType.tiers
                && this.triggerDate == geTSubscriptionRatePlanChargesType.triggerDate
                && this.triggerEvent == geTSubscriptionRatePlanChargesType.triggerEvent
                && this.r_type == geTSubscriptionRatePlanChargesType.r_type
                && this.unusedUnitsCreditRates == geTSubscriptionRatePlanChargesType.unusedUnitsCreditRates
                && this.uom == geTSubscriptionRatePlanChargesType.uom
                && this.upToPeriods == geTSubscriptionRatePlanChargesType.upToPeriods
                && this.upToPeriodsType == geTSubscriptionRatePlanChargesType.upToPeriodsType
                && this.usageRecordRatingOption == geTSubscriptionRatePlanChargesType.usageRecordRatingOption
                && this.version == geTSubscriptionRatePlanChargesType.version;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (applyDiscountTo == null ? 0 : System.hashCode(applyDiscountTo));
        hashCode = (17 * hashCode) + (billingDay == null ? 0 : System.hashCode(billingDay));
        hashCode = (17 * hashCode) + (billingPeriod == null ? 0 : System.hashCode(billingPeriod));
        hashCode = (17 * hashCode) + (billingPeriodAlignment == null ? 0 : System.hashCode(billingPeriodAlignment));
        hashCode = (17 * hashCode) + (billingTiming == null ? 0 : System.hashCode(billingTiming));
        hashCode = (17 * hashCode) + (chargedThroughDate == null ? 0 : System.hashCode(chargedThroughDate));
        hashCode = (17 * hashCode) + (currency2 == null ? 0 : System.hashCode(currency2));
        hashCode = (17 * hashCode) + (description == null ? 0 : System.hashCode(description));
        hashCode = (17 * hashCode) + (discountAmount == null ? 0 : System.hashCode(discountAmount));
        hashCode = (17 * hashCode) + (discountApplyDetails == null ? 0 : System.hashCode(discountApplyDetails));
        hashCode = (17 * hashCode) + (discountClass == null ? 0 : System.hashCode(discountClass));
        hashCode = (17 * hashCode) + (discountLevel == null ? 0 : System.hashCode(discountLevel));
        hashCode = (17 * hashCode) + (discountPercentage == null ? 0 : System.hashCode(discountPercentage));
        hashCode = (17 * hashCode) + (dmrc == null ? 0 : System.hashCode(dmrc));
        hashCode = (17 * hashCode) + (done == null ? 0 : System.hashCode(done));
        hashCode = (17 * hashCode) + (dtcv == null ? 0 : System.hashCode(dtcv));
        hashCode = (17 * hashCode) + (effectiveEndDate == null ? 0 : System.hashCode(effectiveEndDate));
        hashCode = (17 * hashCode) + (effectiveStartDate == null ? 0 : System.hashCode(effectiveStartDate));
        hashCode = (17 * hashCode) + (endDateCondition == null ? 0 : System.hashCode(endDateCondition));
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
        hashCode = (17 * hashCode) + (includedUnits == null ? 0 : System.hashCode(includedUnits));
        hashCode = (17 * hashCode) + (listPriceBase == null ? 0 : System.hashCode(listPriceBase));
        hashCode = (17 * hashCode) + (model == null ? 0 : System.hashCode(model));
        hashCode = (17 * hashCode) + (mrr == null ? 0 : System.hashCode(mrr));
        hashCode = (17 * hashCode) + (name == null ? 0 : System.hashCode(name));
        hashCode = (17 * hashCode) + (r_number == null ? 0 : System.hashCode(r_number));
        hashCode = (17 * hashCode) + (numberOfPeriods == null ? 0 : System.hashCode(numberOfPeriods));
        hashCode = (17 * hashCode) + (originalChargeId == null ? 0 : System.hashCode(originalChargeId));
        hashCode = (17 * hashCode) + (overageCalculationOption == null ? 0 : System.hashCode(overageCalculationOption));
        hashCode = (17 * hashCode) + (overagePrice == null ? 0 : System.hashCode(overagePrice));
        hashCode = (17 * hashCode) + (overageUnusedUnitsCreditOption == null ? 0 : System.hashCode(overageUnusedUnitsCreditOption));
        hashCode = (17 * hashCode) + (price == null ? 0 : System.hashCode(price));
        hashCode = (17 * hashCode) + (priceChangeOption == null ? 0 : System.hashCode(priceChangeOption));
        hashCode = (17 * hashCode) + (priceIncreasePercentage == null ? 0 : System.hashCode(priceIncreasePercentage));
        hashCode = (17 * hashCode) + (pricingSummary == null ? 0 : System.hashCode(pricingSummary));
        hashCode = (17 * hashCode) + (processedThroughDate == null ? 0 : System.hashCode(processedThroughDate));
        hashCode = (17 * hashCode) + (productRatePlanChargeId == null ? 0 : System.hashCode(productRatePlanChargeId));
        hashCode = (17 * hashCode) + (quantity == null ? 0 : System.hashCode(quantity));
        hashCode = (17 * hashCode) + (ratingGroup == null ? 0 : System.hashCode(ratingGroup));
        hashCode = (17 * hashCode) + (segment == null ? 0 : System.hashCode(segment));
        hashCode = (17 * hashCode) + (smoothingModel == null ? 0 : System.hashCode(smoothingModel));
        hashCode = (17 * hashCode) + (specificBillingPeriod == null ? 0 : System.hashCode(specificBillingPeriod));
        hashCode = (17 * hashCode) + (specificEndDate == null ? 0 : System.hashCode(specificEndDate));
        hashCode = (17 * hashCode) + (tcv == null ? 0 : System.hashCode(tcv));
        hashCode = (17 * hashCode) + (tiers == null ? 0 : System.hashCode(tiers));
        hashCode = (17 * hashCode) + (triggerDate == null ? 0 : System.hashCode(triggerDate));
        hashCode = (17 * hashCode) + (triggerEvent == null ? 0 : System.hashCode(triggerEvent));
        hashCode = (17 * hashCode) + (r_type == null ? 0 : System.hashCode(r_type));
        hashCode = (17 * hashCode) + (unusedUnitsCreditRates == null ? 0 : System.hashCode(unusedUnitsCreditRates));
        hashCode = (17 * hashCode) + (uom == null ? 0 : System.hashCode(uom));
        hashCode = (17 * hashCode) + (upToPeriods == null ? 0 : System.hashCode(upToPeriods));
        hashCode = (17 * hashCode) + (upToPeriodsType == null ? 0 : System.hashCode(upToPeriodsType));
        hashCode = (17 * hashCode) + (usageRecordRatingOption == null ? 0 : System.hashCode(usageRecordRatingOption));
        hashCode = (17 * hashCode) + (version == null ? 0 : System.hashCode(version));
        return hashCode;
    }
}