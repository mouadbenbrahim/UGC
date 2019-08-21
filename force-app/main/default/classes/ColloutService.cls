/**
 * Created by Alona Riabchenko on 21.09.2017.
 */

public with sharing class ColloutService {

	public static final String ERROR_EMPTY_REQ_FIELDS = 'Some requred fields are empty';

	public static final String POST_METHOD = 'POST';
	public static final String GET_METHOD = 'GET';
	public static final String CONTEXT_JSON = 'application/json';

	private static Credentials__c orgCred = CustomSettingManager.getCredentialsForOrg();

	//Viadialog_Url__c
	public static HttpResponse polling(String agentid, String token){
		if(!String.isBlank(orgCred.Viadialog_Url__c)|| !String.isBlank(agentid)|| !String.isBlank(token)) {
			String url = orgCred.Viadialog_Url__c + 'polling/?agentid=' + agentid;
			Http h = new Http();
			HttpRequest req = new HttpRequest();
			req.setEndpoint(url);
			req.setHeader('Authorization', token);
			req.setMethod(POST_METHOD);
			HttpResponse res = h.send(req);
			return res;
		}else {
			throw new MyCustomException(ERROR_EMPTY_REQ_FIELDS + 'polling');
		}
	}

	public static HttpResponse authorizationPolling(String slug, String password){
		if(!String.isBlank(orgCred.Grant_Type__c ) || !String.isBlank(orgCred.Scope__c)|| !String.isBlank(orgCred.Viadialog_Url__c)) {
			HttpRequest req = new HttpRequest();
			req.setMethod(POST_METHOD);
			req.setHeader('Content-Type', CONTEXT_JSON);
			req.setHeader('Accept', CONTEXT_JSON);
			req.setHeader('Authorization',orgCred.Access_Token__c);
			req.setEndpoint( orgCred.Viadialog_Url__c + 'uaa/oauth/token?grant_type=' + orgCred.Grant_Type__c + '&scope=' + orgCred.Scope__c + '&slug=' + slug + '&password=' + password);
			Http http = new Http();
			System.debug('ENDPOINT: '+req.getEndpoint());
			HTTPResponse res = http.send(req);
System.debug('+++++++ res = '+res);
			return res;
		}else{
			throw new MyCustomException(ERROR_EMPTY_REQ_FIELDS+' authorizationPolling');
		}
	}

	public static HttpResponse outboundCall(String agentid, String groupid, String serviceid, String phone, String token) {
		if(!String.isBlank(agentid) || !String.isBlank(groupid) || !String.isBlank(serviceid) || !String.isBlank(phone) || !String.isBlank(token) || !String.isBlank(orgCred.Viadialog_Url__c)) {
			String url = orgCred.Viadialog_Url__c + 'outbound/?agentid=' + agentid + '&groupid=' + groupid + '&serviceid=' + serviceid + '&phone=' + phone;
			Http h = new Http();
			HttpRequest req = new HttpRequest();
			req.setEndpoint(url);
			req.setHeader('Authorization', 'Berear ' + token);
			req.setMethod(POST_METHOD);
			HttpResponse res = h.send(req);
			return res;
		}else{
			throw new MyCustomException(ERROR_EMPTY_REQ_FIELDS);
		}
	}

	public static HttpResponse checkBannerCredentals(String login, String password, String token){
		String url = orgCred.Viadialog_Url__c + 'check/?login=' + login + '&pw=' + password;
		Http h = new Http();
		HttpRequest req = new HttpRequest();
		req.setEndpoint(url);
		req.setHeader('Authorization', 'Berear ' + token);
		req.setMethod(GET_METHOD);
		System.debug('ENDPONT TO:' + req.getEndpoint());
		HttpResponse res = h.send(req);
		System.debug('token ====> '+token);
		System.debug('res ====> '+res);
		return res;
	}
}