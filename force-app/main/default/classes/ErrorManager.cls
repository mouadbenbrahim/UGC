/**
 * Created by Alona Riabchenko on 30.09.2017.
 */

public with sharing class ErrorManager {

	public static void defineErrorAfterLoginBanner(MyCustomException ex) {
		if (ex.getMessage() == Authorization.ERROR_BANER_CREDENTIALS) {
			ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, Label.InvalidCreds);
			ApexPages.addMessage(myMsg);
		}else if (ex.getMessage() == Authorization.ERROR_AGENT_ID_INCORRECT) {
			ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, ex.getMessage());
			ApexPages.addMessage(myMsg);
		}
		System.debug('ex.getMessage() = '+ex.getMessage());
		defineError(ex);
	}

	public static void defineErrorAfterLogin(MyCustomException ex) {
		if (ex.getMessage() == Authorization.ERROR_AUTHORIZATION_POLLING ) {
			ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, Label.InvalidCreds);
			ApexPages.addMessage(myMsg);
		}
		System.debug('ex.getMessage() = '+ex.getMessage());
		defineError(ex);
	}

	public static void defineError(MyCustomException ex) {
		System.debug('defineError +');
		TelephonyBoardController telephonyBoardControllerObj;
		if(ex.objWithError instanceof TelephonyBoardController) {
			telephonyBoardControllerObj = (TelephonyBoardController)ex.objWithError;
		}
		if(telephonyBoardControllerObj != null) {
			System.debug('telephonyBoardControllerObj != null');
			if (ex.getMessage() == Authorization.ERROR_AUTHORIZATION_POLLING) {
				System.debug('ERROR_AUTHORIZATION_POLLING +');
				telephonyBoardControllerObj.showLoginPagePolling = true;
			} else if (ex.getMessage() == Authorization.ERROR_BANER_CREDENTIALS ) {
			    telephonyBoardControllerObj.showLoginPageBanner = true;
				telephonyBoardControllerObj.showLoginPagePolling = false;
			}else if ( ex.getMessage() == Authorization.ERROR_AGENT_ID_INCORRECT) {
				System.debug('Authorization.ERROR_AGENT_ID_INCORRECT');
			    telephonyBoardControllerObj.showLoginPageBanner = true;
				telephonyBoardControllerObj.showLoginPagePolling = false;
			} else {
				telephonyBoardControllerObj.showLoginPageBanner = false;
				telephonyBoardControllerObj.showLoginPagePolling = false;
				telephonyBoardControllerObj.showMainErrorMessage = true;
				ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, ex.getMessage());
				ApexPages.addMessage(myMsg);
			}
		}else {
			telephonyBoardControllerObj.showMainErrorMessage = true;
			ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, ex.getMessage());
			ApexPages.addMessage(myMsg);
		}
	}

	public static void defineError(Exception ex) {
		System.debug('ex=' + ex.getMessage());
		ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, ex.getMessage());
		ApexPages.addMessage(myMsg);
	}
}