/**
 * Created by Alona Riabchenko on 01.10.2017.
 */

public with sharing class LoginPageController {
	public TelephonyBoardController telephonyBoard {get; set;}
	public Boolean isAdmin {get; set;}
	public Boolean isConsole {get; set;}
	public void fillIsConsole(){

	}
	private Credentials__c credentialsForLogin = CustomSettingManager.getCredentialsForUser();
	private Credentials__c credentialsForPolling = CustomSettingManager.getCredentialsForOrg();

	@TestVisible
	public String login {
		get {
			System.debug('credentialsForLogin.Username__c = '+credentialsForLogin.Username__c);
			return credentialsForLogin.Username__c;
		}
		set {
			credentialsForLogin.Username__c = value;
			System.debug('set credentialsForLogin.Username__c = '+credentialsForLogin.Username__c);
		}
	}

	public String viadialogDomain {
		get {
			String via = credentialsForPolling.Viadialog_Url__c;
			via = via.substringAfter('http://');
			via = via.substringBefore('.viadialog.com/');
			System.debug('DOMAINN: ' + via);
			return via;
		}
		set {
			credentialsForPolling.Viadialog_Url__c = value + '.viadoalog.com';
		}
	}

	@TestVisible
	public String password {
		get {
			return credentialsForLogin.Password__c;
		}
		set {
			credentialsForLogin.Password__c = value;
		}
	}

	@TestVisible
	public String loginPolling {
		get {
			return credentialsForPolling.Slug_Polling__c;
		}
		set {
			credentialsForPolling.Slug_Polling__c = value ;
		}
	}

	@TestVisible
	public String passwordPolling {
		get {
			return credentialsForPolling.Password_Polling__c;
		}
		set {
			credentialsForPolling.Password_Polling__c = value;
		}
	}

	public PageReference save() {
		try {
			if (password != null && login != null) {
				telephonyBoard.authorization(credentialsForLogin, null);
				upsert credentialsForLogin;
				telephonyBoard.hideAllWhenError();
			}
		} catch (MyCustomException myEx) {
			credentialsForLogin.Password__c = null;
			myEx.objWithError = telephonyBoard;
			ErrorManager.defineErrorAfterLoginBanner(myEx);
			return  null;
		} catch (Exception ex) {
			telephonyBoard.showMainErrorMessage = true;
			ErrorManager.defineError(ex);
			PageReference pr;
			List<ApexClass> cs = [ select NamespacePrefix from ApexClass where Name = :'LoginPageController' ];
			if (!cs.isEmpty() && cs[0].NamespacePrefix != null) {
				pr = new PageReference('/apex/' + cs[0].NamespacePrefix + '__TelephonyBoard');
			} else {
				pr = Page.TelephonyBoard;
			}
			pr.setRedirect(true);
			return  pr;
		}
		return null;
	}

	public PageReference savePolling() {
		try {
			if (loginPolling != null && passwordPolling != null) {
				telephonyBoard.authorization(null, credentialsForPolling);
				upsert credentialsForPolling;
				telephonyBoard.hideAllWhenError();
			}
		} catch (MyCustomException myEx) {
			credentialsForPolling.Password_Polling__c = null;
			myEx.objWithError = telephonyBoard;
			ErrorManager.defineErrorAfterLogin(myEx);
			return  null;
		} catch (Exception ex) {
			telephonyBoard.showMainErrorMessage = true;
			ErrorManager.defineError(ex);
			return  null;
		}
		return  null;
	}

	public PageReference saveViadialog() {
		try {
			if (viadialogDomain != null) {
				telephonyBoard.authorization(null, credentialsForPolling);
				upsert credentialsForPolling;
				telephonyBoard.hideAllWhenError();
			}
		} catch (MyCustomException myEx) {
			credentialsForPolling.Viadialog_Url__c = null;
			myEx.objWithError = telephonyBoard;
			ErrorManager.defineErrorAfterLogin(myEx);
			return  null;
		} catch (Exception ex) {
			telephonyBoard.showMainErrorMessage = true;
			ErrorManager.defineError(ex);
			return  null;
		}
		return  null;
	}

	public PageReference logOut(){
		if(isAdmin != null) {
			logOutOrg();
		}else {
			logOutUser();
		}
		return null;
	}
	private void logOutUser(){
		credentialsForLogin.Username__c = null;
		credentialsForLogin.Password__c = null;
		System.debug('logOutUser +');
		update credentialsForLogin;
	}

	private void logOutOrg(){
		credentialsForPolling.Slug_Polling__c = null;
		credentialsForPolling.Password_Polling__c = null;
		credentialsForPolling.Token_Part1__c = null;
		credentialsForPolling.Token_Part2__c = null;
		credentialsForPolling.Token_Part3__c = null;
		credentialsForPolling.Valid_To__c = null;
		System.debug('logOutOrg +');
		update credentialsForPolling;
	}

}