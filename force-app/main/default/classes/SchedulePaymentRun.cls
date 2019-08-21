// Extension to schedule payment run of the selected objects
public with sharing class SchedulePaymentRun {

    ApexPages.StandardSetController setCon;
    public String error { get; set; }
    public PageReference originalUrl { get; set; }

    public SchedulePaymentRun(ApexPages.StandardSetController controller) {
        setCon = controller;
    }

    public String getMySelectedSize() {
        return setCon.getSelected().size() + '';
    }
    
    public PageReference scheduleRecords(){
        originalUrl = setCon.cancel();
        String paymentTime = '08:00:00';

        List<Payment_Run_Calendar__c> prId = (List<Payment_Run_Calendar__c>) setCon.getSelected();
        List<Payment_Run_Calendar__c> lstpr = [select Pays__c,Date_Execution__c, Batch_Numbers__c from Payment_Run_Calendar__c where id IN :prId AND Planned__c=false];
        List<Payment_Run_Calendar__c> prToUpdate = new List<Payment_Run_Calendar__c>();
        
        list<Global_Parameters__mdt> globalmdt = new list<Global_Parameters__mdt>([SELECT Payment_Run_Time__c FROM Global_Parameters__mdt LIMIT 1]);
        if(globalmdt.size()>0)
        {
            if(globalmdt[0].Payment_Run_Time__c<>null && globalmdt[0].Payment_Run_Time__c<>'')
            paymentTime = globalmdt[0].Payment_Run_Time__c;
        }


        for(Payment_Run_Calendar__c pr : lstpr)
        {
            String[] lstbatch = pr.Batch_Numbers__c.split(';');

            for(String bt : lstbatch)
            {
                schedulePR(pr.Date_Execution__c,paymentTime,bt,pr.Pays__c);
                
            }

            pr.Planned__c = true;
            prToUpdate.add(pr);

        }

        update prToUpdate;

        return originalUrl;
    }


    public static void schedulePR(Date runDate , String paymentTime, String batch, String codePays)
    {
        String endpoint = '/v1/payment-runs';
        String method = 'POST';
        String wsIn = '';
        String wsOut = '';

        // Retrieve Zuora token
        String accessToken = WS001_CallZuora.access_token;

        // Retrieve Entity code
        String zEntityId = WS001_CallZuora.getZuoraEntityId(codePays);

        System.debug('##ECH scheduleRecords schedulePR runDate >> ' + Util.zDate(runDate)+' '+paymentTime);
        // Call WS
        WSZ.PaymentRunIn wsInObj = new WSZ.PaymentRunIn();
        wsInObj.autoApplyCreditMemo = true;
        wsInObj.autoApplyUnappliedPayment = true;
        wsInObj.collectPayment = true;
        wsInObj.consolidatedPayment = false;
        wsInObj.processPaymentWithClosedPM = false;
        wsInObj.batch = batch;
        wsInObj.runDate = Util.zDate(runDate)+' '+paymentTime;
        
        wsIn = (String) JSON.serialize(wsInObj);

        System.debug('##ECH scheduleRecords schedulePR PaymentRunIn >> ' + wsIn);
        wsOut = WS001_CallZuora.sendRequest(accessToken, endpoint, zEntityId, method, wsIn, 'type1', '211.0');

        System.debug('##ECH scheduleRecords schedulePR wsOut >> ' + wsOut);

    }

}