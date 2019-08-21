/**
 * Created by Alona Riabchenko on 20.10.2017.
 */

global class PostInstallClass implements InstallHandler{
	global void onInstall(InstallContext context) {
		if(context.previousVersion() == null) {
			initCredentialCustomSetting();
		}
		if(context.isUpgrade()) {
			initCredentialCustomSetting();
		}
	}

	global void initCredentialCustomSetting(){
		Credentials__c orgCredentials = Credentials__c.getOrgDefaults();
		orgCredentials.Access_Token__c = 'Basic N3lZNVJFS3M6RjY4QnJzNXdUTWFYQ1BTekdIN3lYVk5IQ2VZa3gyZng=N3lZNVJFS3M6RjY4QnJzNXdUTWFYQ1BTekdIN3lYVk5IQ2VZa3gyZng=';
		orgCredentials.Scope__c = 'salesforce-api';
		orgCredentials.Grant_Type__c = 'client_credentials';
		orgCredentials.Viadialog_Url__c = 'http://salesforce.viadialog.com/';
		orgCredentials.banerUrl__c = 'http://ccv.viatelecom.com/services/?';
		upsert orgCredentials;
	}

}