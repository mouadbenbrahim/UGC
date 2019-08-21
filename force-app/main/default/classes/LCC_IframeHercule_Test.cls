@IsTest
public class LCC_IframeHercule_Test {
    private static Account accountEmail;
    private static Case cse;
    
    private static void init() {
        // Account test
        accountEmail = new Account(LastName='test', FirstName='test', RecordTypeId = Utils.getComptePersonelAccountRecordType().Id, 
                                   PersonEmail='test@test.test', CliEmailComplementaire__c='test@test.test', NPAIEMAIL__c = false,
                                   PNDADRESSE__c = false, ClientResident__c = 'Belgique', IdMonCompte__c = 'idMonCompte');
        insert accountEmail;
        
        system.debug ('### LOG ### accountEmail =' + accountEmail) ;
        
        cse = new Case () ;
        cse.RecordTypeId = Utils.getNouvelleDemandeClientCaseRecordType().id ;
        cse.AccountId = accountEmail.ID;
        cse.Status ='à traiter' ;
        
        insert cse ;
    }
    
    @IsTest
    public static void getParamsFromCaseTest() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
        init();
        IframeHerculeDto params = LCC_IframeHercule.getParams(cse.Id);
        system.assertEquals('032', params.strCodePays);
        system.assertEquals('idMonCompte', params.strIdMonCompte);
        
        Global_Parameters__mdt param = Utils.getGlobalParameters('UGC_One_Parameters');
        system.assertEquals(param.Base_Url_All_iFrame_Hercule__c, params.strBaseUrl);
        system.assertEquals(param.Base_Url_iFrame_VLO__c, params.strBaseUrlVlo);
        Test.stopTest();
    }
    
    @IsTest
    public static void getParamsFromAccountTest() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestHttpCalloutMock());
        init();
        IframeHerculeDto params = LCC_IframeHercule.getParams(accountEmail.Id);
        system.assertEquals('032', params.strCodePays);
        system.assertEquals('idMonCompte', params.strIdMonCompte);
        
        Global_Parameters__mdt param = Utils.getGlobalParameters('UGC_One_Parameters');
        system.assertEquals(param.Base_Url_All_iFrame_Hercule__c, params.strBaseUrl);
        system.assertEquals(param.Base_Url_iFrame_VLO__c, params.strBaseUrlVlo);
        Test.stopTest();
    }
}