public with sharing class LCC_IframeHercule {
	@AuraEnabled
    Public static IframeHerculeDto getParams(Id recordId) {
        
        IframeHerculeDto dto = new IframeHerculeDto();
        
        Global_Parameters__mdt param = Utils.getGlobalParameters('UGC_One_Parameters');
		System.debug('--####param = ' + param);

		dto.strBaseUrl = param.Base_Url_All_iFrame_Hercule__c;
        dto.strBaseUrlVlo = param.Base_Url_iFrame_VLO__c;
        
        
        
        //Id objectId = ApexPages.currentPage().getParameters().get('Id');
        System.debug('--#### Object Id = ' + recordId);
        System.debug('--#### Object Type = ' + recordId.getSobjectType());
        
        List<Case> cases = [SELECT Id, Account.Id, Account.IdMonCompte__c, Account.CodePays__c 
                       FROM CASE 
                      WHERE Id = :recordId LIMIT 1];
        
        if(cases.size() > 0){
            System.debug('--#### Object Name = Case');
            dto.strCodePays = cases.get(0).Account.CodePays__c;
            dto.strIdMonCompte = cases.get(0).Account.IdMonCompte__c;
            
        }else{
            System.debug('--#### Object Name = Account');
            List<Account> comptes = [SELECT Id, IdMonCompte__c, CodePays__c 
                             FROM Account 
                            WHERE Id = :recordId LIMIT 1];
            dto.strCodePays = comptes.get(0).CodePays__c;
            dto.strIdMonCompte = comptes.get(0).IdMonCompte__c;
        }
        
        if(dto.strCodePays == null) {
            System.debug('-- #### Code pays null');
            dto.strCodePays = 'FR';
        }
        
        System.debug('--#### Id Mon Compte (RCU) = ' + dto.strIdMonCompte);
        System.debug('--#### Code pays = ' + dto.strCodePays); 
        
        System.debug('dto' + dto);
        return dto;
    }
}