public with sharing class WSZ_Acqu2 {

  
    public WSZ_Acqu2() {

    }

    @InvocableMethod
    public static List<ACQ2_Result> getAcqData(List<ACQ2_Request> lacqData){
        List<ACQ2_Result> acqRes = new List<ACQ2_Result>();
        return (acqRes);
    }

    public class ACQ2_Request { 
        @InvocableVariable @AuraEnabled
        public String boulevardIN;
        @InvocableVariable @AuraEnabled
        public ACQ2_RequestDetail boulevardObjIN2 = new ACQ2_RequestDetail();
    }


    public class ACQ2_Result { 
        @InvocableVariable @AuraEnabled
        public String boulevardOUT;  
        @InvocableVariable @AuraEnabled
        public ACQ2_ResultDetail boulevardObjOUT2 = new ACQ2_ResultDetail();                  
    }   

    public class ACQ2_RequestDetail { 
        @InvocableVariable @AuraEnabled
        public String boulevardIN2;            
    }  

    public class ACQ2_ResultDetail { 
        @InvocableVariable @AuraEnabled
        public String boulevardOUT2;            
    }      


}