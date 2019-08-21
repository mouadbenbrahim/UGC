/**
 * Created by Alona Riabchenko on 20.09.2017.
 */

public with sharing class CustomSettingManager {
	private static final String EMPTY_CREDS = Label.EmptyCredsInCustomSetting;
	private static Credentials__c userCred;
	private static Credentials__c orgCred;

	public static Credentials__c getCredentialsForUser(){
		if(userCred == null){
			userCred = Credentials__c.getInstance(UserInfo.getUserId());
		}
		return userCred;
	}

	public static Credentials__c getCredentialsForOrg(){
		if(orgCred == null){
			orgCred = Credentials__c.getOrgDefaults();
		}
		return orgCred;
	}

	public static void checkCredentialCustomSetting(){
		Credentials__c orgCredentials = getCredentialsForOrg();
		Boolean needUpdate = false;
		if(String.isBlank(orgCredentials.Access_Token__c) || String.isBlank(orgCredentials.Scope__c)
				|| String.isBlank(orgCredentials.Grant_Type__c) || String.isBlank(orgCredentials.Viadialog_Url__c)
				|| String.isBlank(orgCredentials.banerUrl__c)) {
			throw new MyCustomException(EMPTY_CREDS);
		}

	}
	/*
	public static void checkAndInitCredentialCustomSetting(){
		Credentials__c orgCredentials = Credentials__c.getOrgDefaults();
		Boolean needUpdate = false;
		if(String.isBlank(orgCredentials.Access_Token__c)) {
			needUpdate = true;
			orgCredentials.Access_Token__c = 'Basic N3lZNVJFS3M6RjY4QnJzNXdUTWFYQ1BTekdIN3lYVk5IQ2VZa3gyZng=N3lZNVJFS3M6RjY4QnJzNXdUTWFYQ1BTekdIN3lYVk5IQ2VZa3gyZng=';
		}
		if(String.isBlank(orgCredentials.Scope__c)) {
			needUpdate = true;
			orgCredentials.Scope__c = 'salesforce-api';
		}
		if(String.isBlank(orgCredentials.Grant_Type__c)) {
			needUpdate = true;
			orgCredentials.Grant_Type__c = 'client_credentials';
		}
		if(String.isBlank(orgCredentials.Viadialog_Url__c)) {
			needUpdate = true;
			orgCredentials.Viadialog_Url__c = 'http://salesforce.viadialog.com/';
		}
		if(String.isBlank(orgCredentials.banerUrl__c)) {
			needUpdate = true;
			orgCredentials.banerUrl__c = 'http://ccv.viatelecom.com/services/?';
		}
		if(needUpdate) {
			upsert orgCredentials;
		}
	}
*/
}