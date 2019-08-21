/**
 * Created by Alona Riabchenko on 20.10.2017.
 */
@isTest
private with sharing class PostInstallClassTest {
	@isTest
	static void testInstallScript() {
		PostInstallClass postinstall = new PostInstallClass();
		Test.testInstall(postinstall, null);
		Credentials__c orgCredentials = Credentials__c.getOrgDefaults();
		System.assertNotEquals(null,orgCredentials.Access_Token__c);
		System.assertNotEquals(null,orgCredentials.Scope__c);
		System.assertNotEquals(null,orgCredentials.Grant_Type__c);
		System.assertNotEquals(null,orgCredentials.Viadialog_Url__c);
		System.assertNotEquals(null,orgCredentials.banerUrl__c);
	}
}