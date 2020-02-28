public class SM_QueueableRollback implements Queueable, Database.AllowsCallouts{

    private String  accessToken;
    private String zEntityId;
    private Map<String,List<Map<String,Object>>> mapIn;
    private String AccId;
    private ProcessLog__c plog;
    
    public  SM_QueueableRollback(String accessToken, String zEntityId,Map<String,List<Map<String,Object>>> mapIn,String AccId, ProcessLog__c plog){
        this.accessToken = accessToken;
        this.zEntityId = zEntityId;
        this.mapIn = mapIn;
        this.AccId = AccId;
        this.plog = plog;
    }
    
     public void execute(QueueableContext context){
         SM_Rollback.rollback( accessToken, zEntityId, mapIn, AccId, plog);
     }
    
}