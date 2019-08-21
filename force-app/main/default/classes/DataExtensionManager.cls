public class DataExtensionManager
{
    
    public String requestIDMore{get;set;}
    public Boolean moreData{get;set;}
    
    public DataExtensionManager()
    {     
         moreData=false;
    }       
    
    
    
    public List<MC_Campaign__c> getMCCampaignRecords(String DEName, String DEColumnNames,boolean more,string requestID)
    {
        transient Httprequest req = new HttpRequest();
        transient HttpResponse res = new HttpResponse();
        
        req.setEndpoint(label.MC_API_Endpoint);
        req.setMethod(label.MC_API_PostMethod);
        req.setHeader('Content-Type','text/xml; charset=utf-8');
        req.setHeader('SOAPAction','Retrieve'); 
        
        String username = label.MC_APICall_Username;
        String password = label.MC_APICall_Password;
        String body = [SELECT Id, Body FROM StaticResource WHERE Name = 'BodyRetrieveRequest' LIMIT 1].Body.toString();
        String retrieveRequest;
        List<String> parameters;
               
        if(!more)
        {
            String properties;   
            List<String> columnNames = DEColumnNames.split(';'); 
            for(String columnName : columnNames)
            {
                properties = properties+'<Properties>'+columnName+'</Properties>';
            }            
            
            retrieveRequest = '<ObjectType>DataExtensionObject['+DEName+']</ObjectType>'+properties;    
        }
        else
        {
            System.debug('MORE !!!!!');           
            retrieveRequest = '<ContinueRequest>'+requestID+'</ContinueRequest>';
        }
        
        parameters = new String[]{username,password,retrieveRequest};
        body = String.format(body,parameters);
        req.setBody(body);
        
        Http http = new Http();
        Integer statusCode;
        transient String responseBody;
        if(!test.isRunningTest())
        {
            res = http.send(req);
            statusCode = res.getStatusCode();
            responseBody = res.getBody();
            system.debug('ResponseBody' + responseBody);
        }
        else
        {
            StaticResource sr = [SELECT Id, Body FROM StaticResource WHERE Name = 'DEResponse' LIMIT 1];
            responsebody = sr.Body.toString();  
        }
        List<MC_Campaign__c> dataExtensionRecords;
        if(!(responseBody.contains('Error')))
        {   
            string name;
            string value;
            integer recordNumber = 0;
            transient Dom.XmlNode result;        
            transient Dom.Document doc = new Dom.Document();
            
            doc.load(responsebody);
            transient Dom.XMLNode Envelope = doc.getRootElement();
            transient Dom.XMLNode BodyNode= Envelope.getChildElements()[1];
            transient Dom.XmlNode RetrieveResponseMsg = BodyNode.getChildElements()[0];
            
            
            If(RetrieveResponseMsg.getChildElements()[0].getText() == 'MoreDataAvailable')
            {
                moreData = true;
                requestIDMore = RetrieveResponseMsg.getChildElements()[1].getText() ;  
            }
            else
            {
                moreData = false;
            }
            dataExtensionRecords = new list<MC_Campaign__c>();
            
            account client1 = null;
            if(Test.isrunningTest())
            {
                client1 = new account();
                client1.recordTypeId =  Schema.SObjectType.Account.getRecordTypeInfosByName().get('Compte personnel').getRecordTypeId();
                //client1.segmentation__c='1';
                client1.lastname = 'test1';
                client1.PersonEmail = 'test1@test1.com';
                PAD.ApexForcedBypass.add ('AP01_AccountAfterInsert'); 
        		PAD.ApexForcedBypass.add ('AP01_AccountAfterUpdate');
                PAD.ApexForcedBypass.add ('AP01_AccountBeforeInsert'); 
        		PAD.ApexForcedBypass.add ('AP01_AccountBeforeUpdate');
                insert client1;
                
                //deManager.respobj.campaignRecords.get(1).put('Contact__c',client1.personContactId );
                //deManager.respobj.campaignRecords.get(1).put('Account__c',client1.Id );
            }
            
            if (RetrieveResponseMsg.getChildElements().size() == 0)
            {
                moreData = false;
            }
            for(integer i = 2 ; i < RetrieveResponseMsg.getChildElements().size(); i++)
            {
                result = RetrieveResponseMsg.getChildElements()[i];
                
                recordNumber = recordNumber + 1;
                transient Map<string,string> campaignRecord=new Map<string,string>();
                transient Dom.XmlNode properties= result.getChildElements()[3];
                
                for(Dom.XmlNode property : properties.getChildElements())
                {
                    name = property.getChildElements()[0].getText();
                    value = property.getChildElements()[1].getText();
                    campaignRecord.put(name,value);                
                }
    			if(campaignrecord.get('Contact__c') != null  && campaignrecord.get('Contact__c').startsWith('003'))
                {   
                    transient MC_Campaign__c campaign = new MC_Campaign__c(); 
                    campaign.ExternalKey__c = campaignrecord.get('ExternalKey__c');
                    campaign.SendID__c = campaignrecord.get('SendID__c'); 
                    if(Test.isrunningTest())
            		{
                    	campaign.Account__c = client1.Id;
                    	campaign.Contact__c = client1.PersonContactId;
                    }
                    else
                    {
                    	campaign.Contact__c = campaignrecord.get('Contact__c');    
                        if(campaignrecord.get('Account__c') != null  && campaignrecord.get('Account__c').startsWith('001'))
                        {
                        	campaign.Account__c = campaignrecord.get('Account__c');     
                        }
                    }
                    campaign.Is_Clicked__c = Boolean.valueOf(campaignrecord.get('Is_Clicked__c'));
                    campaign.Is_Opened__c = Boolean.valueOf(campaignrecord.get('Is_Opened__c'));
                    campaign.Name = campaignrecord.get('Name');
                    campaign.EmailAddress__c = campaignrecord.get('EmailAddress__c');
                    if (campaignrecord.get('Send_Date__c')!='' && campaignrecord.get('Send_Date__c') != null)
                    {
                    	campaign.Send_Date__c = DateTime.valueOf(campaignrecord.get('Send_Date__c'));
                    }
                    if (campaignrecord.get('Last_click_date__c')!='' && campaignrecord.get('Last_click_date__c') != null)
                    {
                    	campaign.Last_click_date__c = DateTime.valueOf(campaignrecord.get('Last_click_date__c'));
                    }
                    if (campaignrecord.get('Last_opened_date__c')!='' && campaignrecord.get('Last_opened_date__c') != null)
                    {
                    	campaign.Last_opened_date__c = DateTime.valueOf(campaignrecord.get('Last_opened_date__c'));
                    }                                      
                    dataExtensionRecords.add(campaign); 
                }     
                
            }           
        }
        
        return dataExtensionRecords ;
    }
    
    
}