/**
 * Created by Valera on 09.10.2017.
 */

public with sharing class CalloutService {
    public static final String ERROR_EMPTY_REQ_FIELDS = Label.Error_Empty_Req_Fields;
    public static final String SERVICE_ERROR_RESPONSE = Label.Service_Error_Response;
    public static final String ERROR_AUTHORIZATION_POLLING = 'Empty credentials - authorizationPolling()';
    public static final String POST_METHOD = 'POST';
    public static final String GET_METHOD = 'GET';
    public static final String CONTEXT_JSON = 'application/json';
    public static final String AUTHORIZATION = 'Authorization';
    public static final String BEREAR = 'Berear ';
    public static final String CONTENT_TYPE = 'Content-Type';
    public static final String ACCEPT = 'Accept';

    private static Credentials__c orgCred = CustomSettingManager.getCredentialsForOrg();

    private static void serverErrorChecking(HttpResponse response) {
        if ((response.getStatusCode() >= 100 && response.getStatusCode() < 200)
                || (response.getStatusCode() >= 300 && response.getStatusCode() < 600)) {
            System.debug('response = '+response);
            System.debug('response body = '+response.getBody());
            throw new MyCustomException(SERVICE_ERROR_RESPONSE
                    + ' '
                    + response.getStatusCode()
                    + ', ' + Label.message_error + ' : '
                    + response.getStatus());
        }
    }
    private static void serverErrorCheckingToken(HttpResponse response) {
        if (response.getStatusCode() == 401) {
            throw new MyCustomException(ERROR_AUTHORIZATION_POLLING);
        }
    }

    //Viadialog_Url__c
    public static HttpResponse polling(String agentid, String token) {
        if (!String.isEmpty(orgCred.Viadialog_Url__c)
                && !String.isEmpty(agentid)
                && !String.isEmpty(token)) {
            String url = orgCred.Viadialog_Url__c + 'polling/?agentid=' + agentid;
            Http h = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint(url);
            req.setHeader(AUTHORIZATION, token);
            req.setMethod(POST_METHOD);
            HttpResponse res = h.send(req);
            serverErrorChecking(res);
            return res;
        } else {
            throw new MyCustomException(ERROR_EMPTY_REQ_FIELDS + ' polling');
        }
    }

    public static HttpResponse authorizationPolling(String slug, String password) {
        if (!String.isEmpty(orgCred.Grant_Type__c)
                && !String.isEmpty(orgCred.Scope__c)
                && !String.isEmpty(orgCred.Viadialog_Url__c)) {
            HttpRequest req = new HttpRequest();
            req.setMethod(POST_METHOD);
            req.setHeader(CONTENT_TYPE, CONTEXT_JSON);
            req.setHeader(ACCEPT, CONTEXT_JSON);
            req.setHeader(AUTHORIZATION, orgCred.Access_Token__c);
            req.setEndpoint(orgCred.Viadialog_Url__c
                    + 'uaa/oauth/token?grant_type='
                    + orgCred.Grant_Type__c + '&scope='
                    + orgCred.Scope__c + '&slug='
                    + slug + '&password='
                    + password);
            Http http = new Http();
            HTTPResponse res = http.send(req);
            serverErrorCheckingToken(res);
            serverErrorChecking(res);
            return res;
        } else {
            throw new MyCustomException(ERROR_AUTHORIZATION_POLLING);
        }
    }

    public static HttpResponse outboundCall(String agentid, String groupid
            , String serviceid
            , String phone, String token) {
        if (
                !String.isEmpty(agentid)
                && !String.isEmpty(groupid)
                && !String.isEmpty(serviceid)
                && !String.isEmpty(phone)
                && !String.isEmpty(token)
                && !String.isEmpty(orgCred.Viadialog_Url__c)) {
            String url = orgCred.Viadialog_Url__c
                    + 'outbound/?agentid='
                    + agentid + '&groupid='
                    + groupid + '&serviceid='
                    + serviceid + '&phone='
                    + phone;
            Http h = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint(url);
            req.setHeader(AUTHORIZATION, BEREAR + token);
            req.setMethod(POST_METHOD);
            HttpResponse res = h.send(req);
//            serverErrorChecking(res);
            return res;
        } else {
            throw new MyCustomException(ERROR_EMPTY_REQ_FIELDS);
        }
    }

    public static HttpResponse checkBannerCredentals(String login, String password, String token) {
        String url = orgCred.Viadialog_Url__c
                + 'check/?login='
                + login + '&pw='
                + password;
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setHeader(AUTHORIZATION, BEREAR + token);
        req.setMethod(GET_METHOD);
        HttpResponse res = h.send(req);
//        serverErrorChecking(res);
        return res;
    }
}