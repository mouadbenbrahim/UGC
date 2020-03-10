public with sharing class SM_TestHelper {
    public SM_TestHelper() {

    }


    public static Blob genRenewDataSample(RenewSampleIn objIn){

        Integer nbr = objIn.nbr;

        List<Zuora__Subscription__c> subDatas = new List<Zuora__Subscription__c>();
        blob file;

        Date mTodayP40 = Date.today().addDays(40);
        Date mTodayP30 = Date.today().addDays(30);
        String ts = DateTime.now().format('MM_dd_HHmmss');

        // List<Zuora__Subscription__c> sub1 = [Select Id, Zuora__SubscriptionNumber__c, Zuora__SubscriptionEndDate__c, Zuora__Status__c, Zuora__Account__c, 
        // PayeurCRMID__c, CodeOffrePrincipale__c, Source__c, TypeContrat__c
        // from Zuora__Subscription__c where Zuora__Status__c =  'Active' AND Zuora__SubscriptionEndDate__c < :mTodayP40 AND Zuora__SubscriptionEndDate__c > TODAY AND TypeContrat__c = 'CDD' limit :nbr];

        // //latence
        // List<Zuora__Subscription__c> sub2 = [Select Id, Zuora__SubscriptionNumber__c, Zuora__SubscriptionEndDate__c, Zuora__Status__c, Zuora__Account__c, 
        // PayeurCRMID__c, CodeOffrePrincipale__c, Source__c, TypeContrat__c
        // from Zuora__Subscription__c where Zuora__Status__c =  'Cancelled' AND Zuora__SubscriptionEndDate__c > TODAY AND Zuora__SubscriptionEndDate__c < :mTodayP30 AND TypeContrat__c = 'CDD' limit :nbr];


        //exemple
        List<Zuora__Subscription__c> sub = [Select Id, Zuora__SubscriptionNumber__c, Zuora__SubscriptionEndDate__c, Zuora__Status__c, Zuora__Account__c, 
        PayeurCRMID__c, CodeOffrePrincipale__c, Source__c, TypeContrat__c
        from Zuora__Subscription__c where Zuora__Status__c =  'Active' AND TypeContrat__c = 'CDD' limit :nbr];


        //if (sub1.size() > 0) subDatas.addAll(sub1);
        //if (sub2.size() > 0)  subDatas.addAll(sub2);
        if (sub.size() > 0) subDatas.addAll(sub);      

        //Map<String,Object> mp = new Map<String,Object>();
        String jsonStr = JSON.serialize(subDatas);

        //mp = (Map<String,Object>)JSON.deserializeUntyped(jsonStr);

        //String toto = String.valueOf(mp);
        Integer i = 0;
        String sBody='',sHeader='',sText='';
        for (Object obj:subDatas){
            i++;

            Map<String,Object> mp = new Map<String,Object>();
            String sLine = '';
            mp = (Map<String,Object>)JSON.deserializeUntyped(JSON.serialize(obj));                
            //System.debug('MBEN: ' + JSON.serialize(mp));
            for (String key:mp.keySet()){
                if (i == 1 && key != 'attributes') sHeader += key + ',';
                if(key != 'attributes') sLine += mp.get(key) + ',';
            }
            
            sBody += '\n' + sLine;
        }
        // System.debug('MBEN: ' + sHeader);
        // System.debug('MBEN: ' + sBody);
        sText = sHeader + sBody;
        System.debug('MBEN: ' + sText);
        


        if (subDatas.size() > 0) {
            //String sBody = JSON.serialize(subDatas);
            
            file = Blob.valueOf(sText);
            ContentVersion cv = new ContentVersion();
            cv.ContentLocation = 'S';
            //cv.ContentDocumentId = contentDocumentId;
            // cv.VersionData = EncodingUtil.base64Decode('bW91YWQgYmVuYnJhaGlt');
            cv.VersionData = file;
            cv.Title = 'renewTestData_'+ts;
            cv.PathOnClient = 'renewTestData_' + ts +  '.csv';
            //cv.FileExtension = 'csv'; //Field is not writeable
            //cv.FileType = 'CSV'; //Field is not writeable

            insert cv;
            //System.debug('MBEN: ContentDocumentId: '+ JSON.serialize(cv));
            //System.debug('MBEN: ContentDocumentId: '+ cv.VersionData);
        }
        //System.debug('MBEN: ContentDocumentId: '+ cv.ContentDocumentId);

        return file;
        
    }

    public class RenewSampleIn{
        Integer nbr; // limit dans le SOQL sample data
    }
}