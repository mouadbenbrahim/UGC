/**
 * Created by ext-dev-05 on 04/07/2019.
 */

public with sharing class SM_Amendment {

    public static WSZ.AmendOut getAmendment(String subId, String zEntityId) {
        String endpoint = '/v1/amendments/subscriptions/' + subId;
        String method = 'GET';
        String wsIn = null;
        String wsOut = '';

        // Retrieve Zuora token
        String accessToken = WS001_CallZuora.access_token;

        wsOut = WS001_CallZuora.sendRequest(accessToken, endpoint, zEntityId, method, wsIn, 'type1', null);
        wsOut = wsOut.replace('type','typeX');
        return (WSZ.AmendOut) JSON.deserializeStrict(wsOut, WSZ.AmendOut.class);
    }

    public static WSZ.GenericOut2 updateAmendment(WSZ.AmendIn amend, String zEntityId) {
        String endpoint = '/v1/object/amendment/' + amend.id;
        String method = 'PUT';
        String wsIn = null;
        String wsOut = '';

        // WSZ.AmendIn wsInObj = amend.clone();
        wsIn = (String) JSON.serialize(amend);
        wsIn = wsIn.replace('operation_c','Operation__c');
        // Retrieve Zuora token
        String accessToken = WS001_CallZuora.access_token;

        wsOut = WS001_CallZuora.sendRequest(accessToken, endpoint, zEntityId, method, wsIn, 'type1', null);
        wsOut = wsOut.replace('type','typeX');
        return (WSZ.GenericOut2) JSON.deserializeStrict(wsOut, WSZ.GenericOut2.class);
    }

    // Example call:
    //SM_Amendment.AmendRequest c1 = new SM_Amendment.AmendRequest();
    //c1.amendments[0].autoRenew = true;

    public class AmendRequest {
        /**
        * Get amendOptions
        * @return amendOptions
        */
        // public AmendRequestAmendOptions amendOptions { get; set; }

        /**
        * The `Amendment` object holds the changes that you want to make to the Subscription specified by the `SubscriptionId`, \nincluding its `RatePlan`, `RatePlanCharge`, and `RatePlanChargeTier`.\n
        * @return amendments
        */
        public List<Amendment> amendments { get; set; }

        /**
        * Get previewOptions
        * @return previewOptions
        */
        // TODO MBE Activate public AmendRequestPreviewOptions previewOptions { get; set; }

        public AmendRequest() {
            amendments = new List<Amendment>{new Amendment()};
        }


    }


    public class Amendment {
        /**
        *  Determines whether the subscription is automatically renewed, or whether it expires at the end of the term and needs to be manually renewed. For amendment of type `TermsAndConditions`, this field is only required if you change the automatic renewal status of a subscription.\n\n\n**Values**: true, false 
        * @return autoRenew
        */
        public Boolean autoRenew { get; set; }

        /**
        *  A unique alphanumeric string that identifies the amendment.\n\n\n**Character limit**: 50\n\n**Values**: one of the following:\n\n- `null` generates a value automatically\n- A string\n
        * @return code
        */
        public String code { get; set; }

        /**
        *  The date when the amendment\'s changes become effective for billing purposes.\n
        * @return contractEffectiveDate
        */
        public Date contractEffectiveDate { get; set; }

        /**
        *  The user ID of the person who created the amendment.\n\n\n**Character limit**: 32\n\n**Values**: automatically generated 
        * @return createdById
        */
        public String createdById { get; set; }

        /**
        *  The date when the amendment was created.\n\n\n**Values**: automatically generated 
        * @return createdDate
        */
        public Datetime createdDate { get; set; }

        /**
        *  The length of the period for the current subscription term. This field can be updated when Status is `Draft`.\n\nThis field is only required if the `Type` field is set to `TermsAndConditions` and `TermType` is set to `TERMED`. This field is not required if `TermType` is set to `EVERGREEN`.\n\n\n**Values**: a valid number 
        * @return currentTerm
        */
        public Long currentTerm { get; set; }

        /**
        *  The period type for the current subscription term. This field is only required if the `Type` field is set to `TermsAndConditions` and `TermType` is set to `TERMED`. This field is not required if `TermType` is set to `EVERGREEN`.\n\n**Values**:\n\n- `Month` (default)\n- `Year`\n- `Day`\n- `Week`\n\n\n**Note**:\n\n- This field can be updated when Status is `Draft`.\n- This field is used with the CurrentTerm field to specify the current subscription term.\n
        * @return currentTermPeriodType
        */
        public String currentTermPeriodType { get; set; }

        /**
        * The date when the customer accepts the amendment\'s changes to the subscription.\n\nThis field is only required if [Zuora is configured to require customer acceptance in Z-Billing](https://knowledgecenter.zuora.com/CB_Billing/W_Billing_and_Payments_Settings/Define_Default_Subscription_Settings) and the subscription is currently in the Pending Acceptance status (the value of the `Status` field is currently `PendingAcceptance`).\n\nUse this field together with the `Status` field. When you set a date in this field as a customer acceptance date, you should also set the `Status` field as `Completed`.\n
        * @return customerAcceptanceDate
        */
        public Date customerAcceptanceDate { get; set; }

        /**
        *  A description of the amendment.\n\n\n**Character limit**: 500\n\n**Values**: maximum 500 characters 
        * @return description
        */
        public String description { get; set; }

        /**
        *  The ID of the subscription owner that the subscription is being transferred to.\n\n\n**Character limit**: 32\n\n**Values**: a valid account ID 
        * @return destinationAccountId
        */
        public String destinationAccountId { get; set; }

        /**
        *  The ID of the invoice owner that the subscription is being transferred to.\n\n\n**Character limit**: 32\n\n**Values**: a valid invoice ID 
        * @return destinationInvoiceOwnerId
        */
        public String destinationInvoiceOwnerId { get; set; }

        /**
        *  The date when the amendment\'s changes take effective. This field validates that the amendment\'s changes are within valid ranges of products and product rate plans.\nThis field is only required if the `Type` field is set to `Cancellation`.\n\n
        * @return effectiveDate
        */
        public Date effectiveDate { get; set; }

        /**
        *  The name of the amendment.\n\n\n**Character limit**: 100\n\n**Values**: a string of 100 characters or fewer 
        * @return name
        */
        public String name { get; set; }

        /**
        * Get ratePlanData
        * @return ratePlanData
        */
        // public AmendmentRatePlanData ratePlanData { get; set; }

        /**
        *  Specifies whether a termed subscription will remain termed or change to evergreen when it is renewed.\n\nThis field is only required if the `TermType` field is set to `Termed`.\n\n\n**Values**: RENEW_WITH_SPECIFIC_TERM (default), RENEW_TO_EVERGREEN 
        * @return renewalSetting
        */
        public String renewalSetting { get; set; }

        /**
        *  The term of renewal for the amended subscription. This field can be updated when Status is `Draft`.\nThis field is only required if the `Type` field is set to `TermsAndConditions`.\n\n\n**Values:** a valid number 
        * @return renewalTerm
        */
        public Long renewalTerm { get; set; }

        /**
        *  The period type for the subscription renewal term. This field can be updated when Status is `Draft`.\n**Required**: Only if the value of the Type field is set to `TermsAndConditions`. This field is used with the RenewalTerm field to specify the subscription renewal term.\n\n\n**Values**:\n\n- `Month` (default)\n- `Year`\n- `Day`\n- `Week`\n
        * @return renewalTermPeriodType
        */
        public String renewalTermPeriodType { get; set; }

        /**
        * The date when the subscription resumption takes effect. See [Resume Date](https://knowledgecenter.zuora.com/BC_Subscription_Management/Subscriptions/Resume_a_Subscription#Resume_Date) for more information.\n\nThis field is only required if you resume a suspended subscription.\n\n**Note:** This feature is in **Limited Availability**. If you want to have access to the feature, submit a request at [Zuora Global Support](http://support.zuora.com/).\n
        * @return resumeDate
        */
        public Date resumeDate { get; set; }

        /**
        * The date when service is activated.\n\nThis field is only required if [Zuora is configured to require service activation in Z-Billing](https://knowledgecenter.zuora.com/CB_Billing/W_Billing_and_Payments_Settings/Define_Default_Subscription_Settings) and the subscription is currently in the Pending Activation status (the value of the `Status` field is currently `PendingActivation`).\n\nUse this field together with the `Status` field. When you set a date in this field as a service activation date, you should also set the `Status` field as the expected next phase status: `Completed` or `PendingAcceptance`.\n
        * @return serviceActivationDate
        */
        public Date serviceActivationDate { get; set; }

        /**
        * The date when the UpdateProduct amendment takes effect. This field is only applicable if there is already a future-dated UpdateProduct amendment on the subscription.\n\n\nFor the UpdateProduct amendments, this field is only required if there is already a future-dated UpdateProduct amendment on the subscription.\n
        * @return specificUpdateDate
        */
        public Date specificUpdateDate { get; set; }

        /**
        *  The status of the amendment. Type: string (enum)\n\n\n\n**Values**: one of the following:\n\n- Draft (default, if left null)\n- Pending Activation\n- Pending Acceptance\n- Completed\n
        * @return status
        */
        public String status { get; set; }

        /**
        *  The ID of the subscription that the amendment changes.\n\n\n**Character limit**: 32\n\n**Values**: a valid subscription ID 
        * @return subscriptionId
        */
        public String subscriptionId { get; set; }

        /**
        * The date when the subscription suspension takes effect. See [Suspend Date](https://knowledgecenter.zuora.com/BC_Subscription_Management/Subscriptions/Suspend_a_Subscription#Suspend_Date) for more information.\n\nThis field is only required if you suspend an active subscription.\n\n**Note:** This feature is in **Limited Availability**. If you want to have access to the feature, submit a request at [Zuora Global Support](http://support.zuora.com/).\n
        * @return suspendDate
        */
        public Date suspendDate { get; set; }

        /**
        *  The date when the new terms and conditions take effect.\nThis field is only required if the `Type` field is set to `TermsAndConditions`.\n
        * @return termStartDate
        */
        public Date termStartDate { get; set; }

        /**
        *  Indicates if the subscription isTERMED or EVERGREEN.\n\n- A TERMED subscription has an expiration date, and must be manually renewed.\n- An EVERGREEN subscription doesn\'t have an expiration date, and must be manually ended.\n\nWhen as part of an amendment of type `TermsAndConditions`, this field is required to change the term type of a subscription.\n\n\n**Character limit**: 9\n\n**Values**: TERMED, EVERGREEN 
        * @return termType
        */
        public String termType { get; set; }

        /**
        *  The type of amendment.\n\n\n**Character limit**: 18\n\n\n\n**Values**: one of the following:\n\n- Cancellation\n- NewProduct\n- OwnerTransfer\n- RemoveProduct\n- Renewal\n- UpdateProduct\n- TermsAndConditions\n- SuspendSubscription (This value is in **Limited Availability**.)\n- ResumeSubscription (This value is in **Limited Availability**.)\n
        * @return r_type
        */
        public String r_type { get; set; }

        /**
        *  The ID of the user who last updated the amendment.\n\n\n**Character limit**: 32\n\n**Values**: automatically generated 
        * @return updatedById
        */
        public String updatedById { get; set; }

        /**
        *  The date when the amendment was last updated.\n\n\n**Values**: automatically generated 
        * @return updatedDate
        */
        public Datetime updatedDate { get; set; }

    }



        public static Amendment getExample() {
            Amendment amendment = new Amendment();
            amendment.autoRenew = true;
            amendment.code = 'aeiou';
            amendment.contractEffectiveDate = Date.newInstance(2000, 1, 23);
            amendment.createdById = 'aeiou';
            amendment.createdDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
            amendment.currentTerm = 123456789L;
            amendment.currentTermPeriodType = 'aeiou';
            amendment.customerAcceptanceDate = Date.newInstance(2000, 1, 23);
            amendment.description = 'aeiou';
            amendment.destinationAccountId = 'aeiou';
            amendment.destinationInvoiceOwnerId = 'aeiou';
            amendment.effectiveDate = Date.newInstance(2000, 1, 23);
            amendment.name = 'aeiou';
            // amendment.ratePlanData = AmendmentRatePlanData.getExample();
            amendment.renewalSetting = 'aeiou';
            amendment.renewalTerm = 123456789L;
            amendment.renewalTermPeriodType = 'aeiou';
            amendment.resumeDate = Date.newInstance(2000, 1, 23);
            amendment.serviceActivationDate = Date.newInstance(2000, 1, 23);
            amendment.specificUpdateDate = Date.newInstance(2000, 1, 23);
            amendment.status = 'aeiou';
            amendment.subscriptionId = 'aeiou';
            amendment.suspendDate = Date.newInstance(2000, 1, 23);
            amendment.termStartDate = Date.newInstance(2000, 1, 23);
            amendment.termType = 'aeiou';
            amendment.r_type = 'aeiou';
            amendment.updatedById = 'aeiou';
            amendment.updatedDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);            
            return amendment;
        }  

        public static AmendRequest getExample2() {
            AmendRequest amendRequest = new AmendRequest();            
            // TODO amendRequest.amendOptions = AmendRequestAmendOptions.getExample();
            amendRequest.amendments = new List<Amendment>{Amendment.getExample()};
            // amendRequest.previewOptions = AmendRequestPreviewOptions.getExample();
            return amendRequest;
        }

}