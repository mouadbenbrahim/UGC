/**
 * 
 */
public class zc_SubscribeRequestSubscriptionData {


    public zc_SubscribeRequestSubscriptionDataSub subscription { get; set; }
    public List<zc_AmendmentRatePlanData> ratePlanData { get; set; }
    
    public zc_SubscribeRequestSubscriptionData(){
        ratePlanData = new List<zc_AmendmentRatePlanData>();
    }
    
    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Subscription' => 'subscription',
        'RatePlanData' => 'ratePlanData'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

}