public class AP03_Attachment {
    
    public static void processTriggerAfterInsert (List<Attachment> listAttachment)  { 
        createFileImpressionRecords (listAttachment);
    }
    
    public static void createFileImpressionRecords (List<Attachment> listAttachment)  { 
        system.debug('##MNE AP03_Attachment createFileImpressionRecords listAttachment >> '+listAttachment);
        
        //map<Id, Attachment> mapAttachmentById         = new map<Id, Attachment>();
        map<Id, Attachment> mapAttachmentBySDocId   = new map<Id, Attachment>();
        
        if(listAttachment == null || listAttachment.size() == 0){
            return;
        }
        
        system.debug('##MNE AP03_Attachment createFileImpressionRecords hello1');

        for(Attachment att : listAttachment){
            //mapAttachmentById.put(att.Id, att);
            if(String.isNotBlank(att.Description)){
                mapAttachmentBySDocId.put(Id.valueOf(att.Description), att);
            }
        }
        
        //system.debug('##MNE AP03_Attachment createFileImpressionRecords mapAttachmentById >> '+mapAttachmentById);
        system.debug('##MNE AP03_Attachment createFileImpressionRecords mapAttachmentBySDocId >> '+mapAttachmentBySDocId);

        //List<SDOC__SDoc__c> listSDoc = getSDocNotHTMLByAttachmentId(mapAttachmentById.keySet());
        List<SDOC__SDoc__c> listSDoc = getSDocNotHTMLBySDocId(mapAttachmentBySDocId.keySet());
        
        system.debug('##MNE AP03_Attachment listSDoc >> '+ listSDoc);
        if(listSDoc == null || listSDoc.size() == 0){
            system.debug('##MNE AP03_Attachment createFileImpressionRecords hello2');
            return;
        }
        
        set<Id> setCaseId = new set<Id>();
        for(SDOC__SDoc__c sDoc : listSDoc){
            setCaseId.add(sDoc.SDOC__ObjectID18__c);
        }

        map<Id, Case> mapCaseById = new map<Id, Case>([SELECT Id, AccountId, Subscription__c, SubscriptionZName__c FROM Case WHERE Id IN : setCaseId]);
        system.debug('##MNE AP03_Attachment createFileImpressionRecords mapCaseById >> '+mapCaseById);

        list<File_Impression__c> listFileImpressionToIsert = new list<File_Impression__c>();
        for(SDOC__SDoc__c sDoc : listSDoc){
            system.debug('##ECH AP03_Attachment sDoc.SDOC__Attachment_Name__c:'+sDoc.SDOC__Attachment_Name__c);
            if(sDoc.SDOC__Attachment_Name__c.left(3)!='UGC')
            {
                system.debug('##ECH AP03_Attachment createFileImpressionRecords hello3');
                system.debug('##MNE AP03_Attachment createFileImpressionRecords hello3');
                File_Impression__c fi = new File_Impression__c();
                Case caseTMP = mapCaseById.get(sDoc.SDOC__ObjectID18__c);
                fi.Name                 = sDoc.SDOC__Attachment_Name__c;
                fi.Subscription__c      = caseTMP.Subscription__c;
                fi.SubscriptionZName__c   = caseTMP.SubscriptionZName__c;
                fi.Account__c           = caseTMP.AccountId;
                //fi.Attachment_Id__c     = sDoc.SDOC__Attachment_ID__c;
                fi.Attachment_Id__c     = mapAttachmentBySDocId.get(sDoc.Id).Id;
                fi.Case__c              = caseTMP.Id;
                fi.SDoc__c              = sDoc.Id;
                fi.IsCarte__c           = false;
                fi.Statut__c            = 'A Imprimer';
                //fi.Attachment_Body__c     = EncodingUtil.base64Encode(mapAttachmentById.get(sDoc.SDOC__Attachment_ID__c).Body); 
                fi.Attachment_Body__c   = EncodingUtil.base64Encode(mapAttachmentBySDocId.get(sDoc.Id).Body); 
                listFileImpressionToIsert.add(fi);
            }
        }

        if(listFileImpressionToIsert.size() > 0){
            system.debug('##MNE AP03_Attachment createFileImpressionRecords hello4');
            insert listFileImpressionToIsert;
        }
    }
    
    /*public static List<SDOC__SDoc__c> getSDocNotHTMLByAttachmentId (set<Id> setAttachmentId){
        system.debug('##MNE AP03_Attachment getSDocNotHTMLByAttachmentId setAttachmentId >> '+ setAttachmentId);
        List<SDOC__SDoc__c> listSDocResult = new List<SDOC__SDoc__c>();
        if(setAttachmentId == null || setAttachmentId.size() == 0){
            system.debug('##MNE AP03_Attachment getSDocNotHTMLByAttachmentId hello1');
            return listSDocResult;
        }
        
        List<SDOC__SDoc__c> listSDoc = new List<SDOC__SDoc__c>([SELECT Id, SDOC__Attachment_ID__c, SDOC__RecordDataXML__c, SDOC__GD_Status__c, SDOC__ObjectID18__c,
                                                                SDOC__ObjectType__c, SDOC__Attachment_Name__c, SDOC__Status__c
                                                                FROM SDOC__SDoc__c WHERE SDOC__Attachment_ID__c IN :setAttachmentId AND SDOC__ObjectType__c = 'Case']);     
                                                                   
        system.debug('##MNE AP03_Attachment getSDocNotHTMLByAttachmentId listSDoc >> '+listSDoc);
        for(SDOC__SDoc__c sDoc : listSDoc){
            system.debug('##MNE AP03_Attachment getSDocNotHTMLByAttachmentId hello2 >> '+string.valueOf(sDoc.SDOC__RecordDataXML__c.contains('<DocumentFormat>HTML</DocumentFormat>')));
            if(!sDoc.SDOC__RecordDataXML__c.contains('<DocumentFormat>HTML</DocumentFormat>')){
                system.debug('##MNE AP03_Attachment getSDocNotHTMLByAttachmentId hello3');
                listSDocResult.add(sDoc);
            }
        }
        return listSDocResult;
    }*/
    
    
    public static List<SDOC__SDoc__c> getSDocNotHTMLBySDocId (set<Id> setSDocId){
        system.debug('##MNE AP03_Attachment getSDocNotHTMLBySDocId setSDocId >> '+ setSDocId);
        List<SDOC__SDoc__c> listSDocResult = new List<SDOC__SDoc__c>();
        if(setSDocId == null || setSDocId.size() == 0){
            system.debug('##MNE AP03_Attachment getSDocNotHTMLBySDocId hello1');
            return listSDocResult;
        }
                                                                
       List<SDOC__SDoc__c> listSDoc = new List<SDOC__SDoc__c>([SELECT Id, SDOC__Attachment_ID__c, SDOC__RecordDataXML__c, SDOC__GD_Status__c, SDOC__ObjectID18__c,
                                                                SDOC__ObjectType__c, SDOC__Attachment_Name__c, SDOC__Status__c
                                                                FROM SDOC__SDoc__c WHERE Id IN :setSDocId AND SDOC__ObjectType__c = 'Case']); 
                                                                   
        system.debug('##MNE AP03_Attachment getSDocNotHTMLBySDocId listSDoc >> '+listSDoc);
        for(SDOC__SDoc__c sDoc : listSDoc){
            system.debug('##MNE AP03_Attachment getSDocNotHTMLBySDocId hello2 >> '+string.valueOf(sDoc.SDOC__RecordDataXML__c.contains('<DocumentFormat>HTML</DocumentFormat>')));
            if(!sDoc.SDOC__RecordDataXML__c.contains('<DocumentFormat>HTML</DocumentFormat>')){
                system.debug('##MNE AP03_Attachment getSDocNotHTMLBySDocId hello3');
                listSDocResult.add(sDoc);
            }
        }
        return listSDocResult;
    }

}