/**
 * Created by Valera on 19.09.2017.
 */

global with sharing class Authorization {

//-------------------------------ERRORS---------------------------------//
    public static final String ERROR_AUTHORIZATION_POLLING = 'Empty credentials - authorizationPolling()';
    public static final String ERROR_BANER_CREDENTIALS = 'Empty credentials';
    public static final String ERROR_AGENT_ID_INCORRECT = Label.Agent_incorrect;
    public static final String ERROR_BANER_CREDENTIALS_API = Label.Error_Banner_Credentials_Api;
    public static final String ERROR_AUTHORIZATION_STATUS = Label.Error_Authorization_Status;
    public static final String ERROR_TOKEN_EMPTY = Label.Error_Token_Empty;
    public static final String ERROR_STATUS_CHECK_CREDENTIALS = Label.Error_Starus_Check_Credentials;
    public static final String ERROR_AGENT_ID_EMPTY = Label.Error_Agent_Id_Empty;
    public static final String BANNER_URL = 'BannerUrl';
    public static final String USER_NAME = 'Username';
    public static final String PASSWORD = 'Password';
    public static final String AGENT_ID = 'AgentId';
    public static final String TOKEN_ID = 'Token';


//--------------------------CREDENSIONALS--------------------------------//
    @TestVisible
    private Credentials__c orgCred = CustomSettingManager.getCredentialsForOrg();
    @TestVisible
    private Credentials__c orgUser = CustomSettingManager.getCredentialsForUser();
    private Integer counter = 0;
    @TestVisible
    private static String token { get; set; }
    @TestVisible
    private Boolean isNewToken { get; set; }
    private static Authorization authorization { get; set; }

    public Map<String, String> authorizatioVT(Credentials__c userCr, Credentials__c orgCr) {
        if (userCr != null) {
            this.orgUser = userCr;
        }
        if (orgCr != null) {
            this.orgCred = orgCr;
        }
        return authorizatioVT();
    }

    public Map<String, String> authorizatioVT() {
        if (!Test.isRunningTest()) {
            CustomSettingManager.checkCredentialCustomSetting();
        }
        Map<String, String> resultCreden = new Map<String, String>();
        this.isNewToken = getPollingTokenNEW();
        if (String.isEmpty(token)) {
            throw new MyCustomException(ERROR_TOKEN_EMPTY);
        }
        resultCreden.put(TOKEN_ID, token);
        resultCreden.putAll(getBanerCredentials());
        if (this.isNewToken) {
            setTokenInDB();//need to use there because before callouts we can't do DML operations
        }
        return resultCreden;
    }

    @TestVisible
    private Boolean getPollingTokenNEW() {
        if (!String.isEmpty(this.orgCred.Token_Part1__c) && (this.orgCred.Valid_To__c != null && this.orgCred.Valid_To__c.addSeconds(43199) >= Datetime.now())) {
            token = buildTokenAuthorization();
            return false;
        }
        if (String.isEmpty(this.orgCred.Slug_Polling__c) || String.isEmpty(this.orgCred.Password_Polling__c)) {
            throw new MyCustomException(ERROR_AUTHORIZATION_POLLING);
        }
        token = this.resetToken();
        return true;
    }

    private Map<String, String> getBanerCredentials() {
        Map<String, String> credentials = new Map<String, String>();
        if (orgUser != null) {
            if (String.isEmpty(this.orgUser.Password__c) || String.isEmpty(this.orgUser.Username__c)) {
                if (isNewToken) {
                    setTokenInDB();//need to use there because before callouts we can't do DML operations
                    upsert orgCred;
                }
                throw new MyCustomException(ERROR_BANER_CREDENTIALS);
            }
            User userWithAgentId = getUserWithAgentId();
            credentials.put(AGENT_ID, userWithAgentId.Agent_Id__c);
            HttpResponse response = CalloutService.checkBannerCredentals(this.orgUser.Username__c, this.orgUser.Password__c, token);
            response = this.handleResponseCheckBannerCredentials(response);
            this.handleResponse(response, userWithAgentId);
            credentials.put(PASSWORD, this.orgUser.Password__c);
            credentials.put(USER_NAME, this.orgUser.Username__c);
        }
        if (this.orgCred != null) {
            credentials.put(BANNER_URL, this.orgCred.banerUrl__c);
        }
        return credentials;
    }

    private void handleResponse(HttpResponse response, User userWithAgentId) {
        String responseBody = response.getBody();
        Map<String, Object> deserializedResponse = (Map<String, Object>) System.JSON.deserializeUntyped(responseBody);
        if (deserializedResponse.get('agentid') == null) {
            throw new MyCustomException(ERROR_BANER_CREDENTIALS);
        } else if (String.valueOf(deserializedResponse.get('agentid')) != userWithAgentId.Agent_Id__c) {
            throw new MyCustomException(ERROR_AGENT_ID_INCORRECT);
        }
    }


    private String resetToken() {
        HttpResponse responseBaner = CalloutService.authorizationPolling(this.orgCred.Slug_Polling__c, this.orgCred.Password_Polling__c);
        TokenResponseBody jsonBody = TokenResponseBody.parse(responseBaner.getBody());
        this.orgCred.Valid_To__c = Datetime.now().addSeconds(Integer.valueOf(jsonBody.expires_in));
        return jsonBody.access_token;
    }

    private User getUserWithAgentId() {
        Id userId = UserInfo.getUserId();
        List<User> serchUser = [
                SELECT Id
                        , Agent_Id__c
                FROM User
                WHERE Id = :userId AND Agent_Id__c != null
        ];
        if (serchUser.isEmpty()) {
            if (isNewToken) {
                this.setTokenInDB();//need to use there because before callouts we can't do DML operations
                upsert orgCred;
            }
            System.debug('getUser With Agent Id');
            throw new MyCustomException(ERROR_AGENT_ID_INCORRECT);
        }
        return serchUser[0];
    }

    private HttpResponse handleResponseCheckBannerCredentials(HttpResponse response) {
        if (response.getStatusCode() == 200) {
            return response;
        }
        if (response.getStatusCode() == 401 || response.getStatusCode() == 404) {
            this.orgCred.Token_Part1__c = null;
            token = this.resetToken();
            HttpResponse responseBannerCred = CalloutService.checkBannerCredentals(this.orgUser.Username__c, this.orgUser.Password__c, token);
            this.handleErrorHttpResponse(responseBannerCred);
            return responseBannerCred;
        }
        this.handleErrorHttpResponse(response);
        return response;
    }

    private void handleErrorHttpResponse(HttpResponse response) {
        if (response.getStatusCode() == 400) {
            this.orgUser.Password__c = null;
            upsert orgUser;
            throw new MyCustomException(ERROR_BANER_CREDENTIALS);
        } else if (response.getStatusCode() != 200) {
            throw new MyCustomException(Label.Code + ' : ' + response.getStatusCode() + Label.Status + ' : ' + response.getStatus());
        }
    }

    @TestVisible
    //Get part token from CS OrgDefault and collects the value into one
    private String buildTokenAuthorization() {
        return this.orgCred.Token_Part1__c + this.orgCred.Token_Part2__c + this.orgCred.Token_Part3__c;
    }

    //init record for OrgDefault in CS
    private void setTokenInDB() {
        Integer tokenPartLenght = token.length() / 3;
        String part1 = token.substring(0, tokenPartLenght);
        String part2 = token.substring(tokenPartLenght, tokenPartLenght * 2);
        String part3 = token.substring(tokenPartLenght * 2, token.length());

        this.orgCred.Token_Part1__c = part1;
        this.orgCred.Token_Part2__c = part2;
        this.orgCred.Token_Part3__c = part3;
        upsert this.orgCred;
    }
}