// contratfile
WSZ.ContratFileIn wsIn = new WSZ.ContratFileIn();
wsIn.accountZID = null;
wsIn.accountSFID = '0010E00000bzVUFQA2';
wsIn.subscriptionName = 'F-S00009596';
wsIn.subscriptionNameAvenir = null;
WSZ.ContratFileOut wsOut = SM_Subscription.getContratFile(wsIn);
System.debug('MBEN: '+JSON.serialize(wsOut));


Select Id, Attachment_Id_Contrat__c, AccountId,SubscriptionZName__c from Case where AccountId = '0010E00000bzVUFQA2' AND SubscriptionZName__c = 'F-S00009596' 
        AND Attachment_Id_Contrat__c != null order by CreatedDate DESC limit 1


Select Id, Attachment_Id_Contrat__c, AccountId,SubscriptionZName__c from Case where 
         Attachment_Id_Contrat__c != null order by CreatedDate DESC

List<Attachment> li = [Select Id, Body from Attachment where id = '00P5E000004Jj9uUAC'];
System.debug('MBEN: '+ EncodingUtil.base64Encode(li.get(0).Body));


String toto = 'rrr';
System.debug(BLANKVALUE(toto,'AAA'));



zc_ProxyActionqueryRequest reqObj = new zc_ProxyActionqueryRequest();
reqObj.queryString = 'Select Id, Name as subscriptionNumber from Subscription where AccountId=\'8adcc59c6ea682ff016eb7b9f2f13a4d\'';
String accessToken = WS001_CallZuora.access_token;
String zEntityId = WS001_CallZuora.getZuoraEntityId('033');
zc_ProxyActionqueryResponse resp = zc_Api.actionQueryPOST(accessToken, zEntityId, reqObj, RTExceptionCode.ERREUR_DESABO_COUPON_ABOTIER, new ProcessLog__c());
System.debug('MBEN: '+ JSON.serialize(resp));

