@isTest
private class Utils_Test
{
	@isTest
	static void selectGlobalParam()
	{
		Global_Parameters__mdt ugcOneParam = Utils.getGlobalParameters('UGC_One_Parameters');
		System.assertEquals(ugcOneParam!=null, true);
        
        TestHttpCalloutMock mock = new TestHttpCalloutMock();
		Test.setMock(HttpCalloutMock.class, mock);

        Utils.createContactInconnu();
        
        RecordType rtc = Utils.getNouvelleDemandeClientCaseRecordType();
        
        RecordType rtc1 = Utils.getComptePersonelAccountRecordType();
        
        Contact ct  = Utils.getContactInconnu();
        
       List<String> lst =  Utils.getQueueNames('France');
        
        List<String> lst1 =  Utils.getQueueNames('Belgique');
        
	}
}