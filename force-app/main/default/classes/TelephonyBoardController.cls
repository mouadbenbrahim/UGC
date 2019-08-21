public with sharing class TelephonyBoardController {
    public static final String ERROR_USER_CREDS_EMPTY = 'Please, full creds in User object';
    public static final String ERROR_SERVER_GROUP_AGENT_EMPTY = 'Please, fill Servre Id, Group Id, Agent Id in User ';
    public static final String ERROR_SERVER_GROUP_AGENT_INCCORRECT = 'Servre Id, Group Id or Agent Id in User is incorrect ';
    public static final String INVALID_LOGIN_TOKEN = 'Invalid login Id or token';
    public static final String INVALID_LOGIN_TOKEN_BANNER_URL = 'Invalid login Id, token, or incorect banner url';
    public static final String ERROR_EMPTY_BANNER_CREDS = 'Empty creds for banner';
    public static final String VD_PERMISSION_SET = 'Viadialog_permission_set';
    public static final String VD_PERMISSION_SET_FOR_ADMIN = 'Viadialog_permission_set_for_admin';
    public static final String VD_PERMISSION_IS_NOT_FOUND = Label.Permission_set_is_not_found;

    public static String json = '{'+
            '  \"sf\": {'+
            '    \"phone\": 7852416200,'+
            '    \"contacts\": ['+
            '        {'+
            '            \"type\": \"Account\",'+
            '            \"service_id\": null,'+
            '            \"id\": \"0010Y00000vNRO9\",'+
            '            \"group_id\": null,'+
            '            \"agent_id\": null'+
            '        }'+
            '    ],'+
            '    \"organization_id\": \"00D0Y000002iyaOUAQ\",'+
            '    \"user_id\": \"0050Y000002wveiQAA\"'+
            '  },'+
            '  \"agent\": {'+
            '    \"id\": \"1003203\",'+
            '    \"sda\": \"0123456789\",'+
            '    \"status\": \"8\",'+
            '    \"name\": \"John Doe\",'+
            '    \"change_time\": \"2017-09-08 17:51:38\"'+
            '  },'+
            '  \"call\": {'+
            '    \"callid\": \"V4420121712070101769\",'+
            '    \"start_time\": \"2017-09-08 17:51:38\",'+
            '    \"agent_uid\": \"1003203\",'+
            '    \"status\": \"13\",'+
            '    \"change_time\": \"2017-09-08 17:51:38\",'+
            '    \"service_uid\": \"11089\",'+
            '    \"group_uid\": \"55522\",'+
            '    \"product_uid\": \"2\",'+
            '    \"service_label\": \"Valerii\",' +
            '    \"sda\": \"7852416200\",'+
            '    \"ref\": \"Call test\"'+
            '  }'+
            '}';

    public String contactIdsParamValue { get; set; }
    public Event callEvent { get; set; }
    public List<SObject> contacts { get; set; }
    @TestVisible
    public String agentId { get; private set; }
    @TestVisible
    public String token { get; private set; }
    public String urlForBanner { get; private set; }
    public CaseIncomingCall infoCallForPage { get; set; }
    public String clickToDailResponse { get; set; }
    public Integer counter { get; set; }

    public Boolean showBaner { get; set; }
    public Boolean showBrand { get; set; }
    public Boolean showCallInfo { get; set; }
    public Boolean showCallInfoAvailable { get; set; }
    public Boolean showContactList { get; set; }
    public Boolean showEventPage { get; set; }
    public Boolean showOpenBanner { get; set; }
    public Boolean showError { get; set; } //String errorMessage;
    public Boolean showLoginPageBanner { get; set; }
    public Boolean showLoginPagePolling { get; set; }
    public Boolean showNoCallPage { get; set; }
    public Boolean isSuccessAuthorization { get; set; }
    public Boolean changeStatus { get; set; }
    public Boolean showMainErrorMessage { get; set; }

    public Boolean isAdmPermissionSet { get; set; }

    public Boolean isConsole { get; set; }
    public void fillIsConsole() {

    }

    public Boolean isContactListVisible {
        get {
            return callEvent != null && callEvent.id != null;
        }
        private set;
    }

    public Boolean isEventPageVisible {
        get {
            return callEvent != null && callEvent.id != null;
        }
        private set;
    }

    public TelephonyBoardController telephonyBoardCntr {
        get {
            return this;
        }
        set;
    }

    public Context statusContext { get; private set; }
    private Authorization authorizationObj;

    public Boolean isIntrusive { get; set; }

    public TelephonyBoardController() {
        init();
    }


    public PageReference authorization() {
        try {
            if (authorizationObj == null) {
                authorizationObj = new Authorization();
            }
            isAdmPermissionSet = isAdminPermissionSet();
            Map<String, String> dataFromAuthorization = authorizationObj.authorizatioVT();
            agentId = dataFromAuthorization.get(Authorization.AGENT_ID);
            token = dataFromAuthorization.get(Authorization.TOKEN_ID);
            urlForBanner = createUrlForBanner(dataFromAuthorization);
            if (agentId != null && token != null && urlForBanner != null) {
                isSuccessAuthorization = true;
                showComponentsForAvailable(); //start tracing
            } else {
                showError(INVALID_LOGIN_TOKEN_BANNER_URL);
            }
        } catch (MyCustomException myEx) {
            showError(myEx);
        } catch (Exception ex) {
            showError(ex);
        }
        return null;
    }

    //authorization in case when login or password is empty
    public PageReference authorization(Credentials__c userCr, Credentials__c orgCr) {
            Map<String, String> dataFromAuthorization = authorizationObj.authorizatioVT(userCr, orgCr);
            this.agentId = dataFromAuthorization.get(Authorization.AGENT_ID);
            this.token = dataFromAuthorization.get(Authorization.TOKEN_ID);
            this.urlForBanner = createUrlForBanner(dataFromAuthorization);
            this.isSuccessAuthorization = true;
            showComponentsForAvailable(); //start tracing
        return null;
    }

    public PageReference getStatusPolling() {
        try {
            if (agentId != null && token != null) {
                HttpResponse response = CalloutService.polling(agentid, token);
                System.debug('response = '+response.getBody());
                statusContext.setStatus(response.getBody());
//                statusContext.setStatus(json);
            }
        } catch (MyCustomException myEx) {
            showError(myEx);
        } catch (Exception ex) {
            showError(ex);
        }
        return null;
    }

    public void makeOutboundCall() {
        System.debug('### this.clickToDailResponse : ' + this.clickToDailResponse);
        try {
            ClickToDail clickToDailRes = ClickToDail.parse(this.clickToDailResponse);
            System.debug('### clickToDailRes : ' + clickToDailRes);
            if (statusContext.getStatus() instanceof StatusManager.Status1) {
                User user = this.getUserById();
                String phoneNumber = this.getClickedPhoneNumber(clickToDailRes.number_Z);
                CaseOutboundCall outboundCallBody = this.getBodyOutboundCall(user, phoneNumber);
                this.callEvent = EventManager.createOutboundCallevent(clickToDailRes, outboundCallBody);
                this.setMatchedContacts(clickToDailRes.objectId);
            }
        } catch (MyCustomException myEx) {
            System.debug('### custom exception : ' + myEx);
            showError(myEx);
        } catch (Exception ex) {
            System.debug('### exception : ' + ex);
            showError(ex);
        }
    }

    private Boolean isAdminPermissionSet(){
        List<PermissionSetAssignment> admPermissionList = getPermissionSetAssignment(VD_PERMISSION_SET_FOR_ADMIN);
        if(!admPermissionList.isEmpty()){
            return true;
        }
        List<PermissionSetAssignment> userPermissionList = getPermissionSetAssignment(VD_PERMISSION_SET);
        if(!userPermissionList.isEmpty()){
            return false;
        }
        throw new MyCustomException(VD_PERMISSION_IS_NOT_FOUND);
    }

    private List<PermissionSetAssignment> getPermissionSetAssignment(String name){
        List<PermissionSetAssignment> permissionList = [
        SELECT AssigneeId,PermissionSetId
        FROM PermissionSetAssignment
        WHERE AssigneeId=:UserInfo.getUserId()
                AND PermissionSetId IN
                (
                SELECT Id
                FROM PermissionSet
                WHERE Name = :name
                //AND NamespacePrefix = 'VTVD'
                //AND NamespacePrefix = 'VTVD_LEX__'
                )
                ];
        return permissionList;
    }
    private User getUserById() {
        Id idUser = UserInfo.getUserId();
        List<User> user = [
                SELECT
                        Group_Id_Outbound__c,
                          Id
                        , Service_Id__c
                        , Agent_Id__c
                FROM User
                WHERE Id = :idUser
        ];
        if (
                String.isEmpty(user.get(0).Group_Id_Outbound__c) ||
                        String.isEmpty(user.get(0).Service_Id__c)
                || String.isEmpty(user.get(0).Agent_Id__c)) {
            throw new MyCustomException(ERROR_SERVER_GROUP_AGENT_EMPTY);
        }
        return user.get(0);
    }

    private String parsenubmer(String phoneNumber) {
        return phoneNumber.replace('(', '').replace(')', '').replaceAll('-', '').replaceAll(' ', '');
    }

    private String getClickedPhoneNumber(String phoneNumber) {
        String phone = parsenubmer(phoneNumber);
        if (String.isEmpty(phone)) {
            throw new MyCustomException('Invalid phone number ' + phoneNumber);
        }
        return phone;
    }

    public CaseOutboundCall getBodyOutboundCall(User user, String phoneNumber) {
        HttpResponse response = CalloutService.outboundCall(
                user.Agent_Id__c
                , user.Group_Id_Outbound__c
                , user.Service_Id__c, phoneNumber, this.token);
        CaseOutboundCall responseObject;
        if (response.getStatusCode() == 400) {
            responseObject = handleResponseBody(response);
            throw new MyCustomException(responseObject.errormsg);
        } else if (response.getStatusCode() != 200) {
            throw new MyCustomException('Code : ' + response.getStatusCode() + ' Status : ' + response.getStatus());
        }
        responseObject = this.handleResponseBody(response);
        return responseObject;
    }

    private CaseOutboundCall handleResponseBody(HttpResponse response) {
        String strBody = response.getBody().substring(response.getBody().lastIndexOf('{'));
        CaseOutboundCall responseObject = CaseOutboundCall.parse(strBody);
        return responseObject;
    }

    @TestVisible
    private void setMatchedContacts(String contactIds) {
        contacts.clear();
        List<SObject> contactRecords = getRecords(new String[]{'Name','LastName','FirstName'},'Contact',contactIds);
        contacts.addAll((List<SObject>) contactRecords);

        List<SObject> leads = getRecords(new String[]{'Name','LastName','FirstName'},'Lead',contactIds);
        contacts.addAll(leads);

        if(Schema.sObjectType.Account.fields.getMap().containsKey( 'isPersonAccount' )){
            List<SObject> personAccountRecords = getRecords(new String[]{'Name',' PersonContactId', 'isPersonAccount'},'Account',contactIds);
            contacts.addAll((List<SObject>) personAccountRecords);
        }else{
            List<SObject> accountRecords = getRecords(new String[]{'Name'},'Account',contactIds);
            contacts.addAll((List<SObject>) accountRecords);
        }
    }

    private static List<SObject> getRecords(List<String> fieldList, String obj, String contactId) {
        String queryAllRecords = 'SELECT ' + String.join(fieldList,',') +' FROM ' + obj + ' WHERE Id = \''+contactId+'\'';
        return Database.query(queryAllRecords);
    }

//------------------------- visible of components --------------------------------//
    public void rerenderComponentsForInOutCall(String jsResponse) {
        if (infoCallForPage.sf.contacts == null) {
            showComponentsForIncommingCallWith0();
        } else if (infoCallForPage.sf.contacts.size() == 1) {
            showComponentsForIncommingCallWith1();
        } else if (infoCallForPage.sf.contacts.size() > 1) {
            showComponentsForIncommingCallWithMulty();
        }
    }

    private void init() {
        
        
        isIntrusive = false;
        String paramIsIntrusive = ApexPages.currentPage().getParameters().get('isIntrusive');
        if (paramIsIntrusive != null) {
            try {
                isIntrusive = Boolean.valueOf(paramIsIntrusive); 
            } catch (exception e) {}
        }

        callEvent = new Event();
        contacts = new List<SObject>();
        authorizationObj = new Authorization();
        statusContext = new Context(this);
    }

    public void showComponentsForAvailable() {
        callEvent = new Event();
        contacts = new List<SObject>();
        showCallInfoAvailable = true;
        showBaner = true;
        showBrand = true;
        showOpenBanner = true;
        showCallInfo = false;
        showContactList = false;
        showEventPage = false;
        showError = false;
        showLoginPageBanner = false;
    }

    public void showComponentsForNotAvailable() {
        callEvent = new Event();
        contacts = new List<SObject>();
        showCallInfoAvailable = false;
        showBaner = false;
        showBrand = false;
        showOpenBanner = false;
        showCallInfo = false;
        showContactList = false;
        showEventPage = false;
        showError = false;
        showLoginPageBanner = true;
    }

    @TestVisible
    private void showComponentsForIncommingCallWith0() {
        showCallInfoAvailable = false;
        showBaner = true;
        showBrand = true;
        showOpenBanner = true;
        showCallInfo = true;
        showContactList = true;
        showEventPage = true;
        showError = false;
        showLoginPageBanner = false;
    }
    @TestVisible
    private void showComponentsForIncommingCallWith1() {
        showCallInfoAvailable = false;
        showBaner = true;
        showBrand = true;
        showOpenBanner = true;
        showCallInfo = true;
        showContactList = true;
        showEventPage = true;
        showError = false;
        showLoginPageBanner = false;
    }
    @TestVisible
    private void showComponentsForIncommingCallWithMulty() {
        showCallInfoAvailable = false;
        showBaner = true;
        showBrand = true;
        showOpenBanner = true;
        showCallInfo = true;
        showContactList = true;
        showEventPage = true;
        showError = false;
        showLoginPageBanner = false;
    }
//------------------------- helper --------------------------------//
    @TestVisible
    private String createUrlForBanner(Map<String, String> dataFromCustomSetting) {
        String password = dataFromCustomSetting.get(Authorization.PASSWORD);
        String username = dataFromCustomSetting.get(Authorization.USER_NAME);
        String bannerUrl = dataFromCustomSetting.get(Authorization.BANNER_URL);
        if (String.isEmpty(password) || String.isEmpty(username) || String.isEmpty(bannerUrl)) {
            throw new MyCustomException(ERROR_EMPTY_BANNER_CREDS);
        }
        String isPop = 'false';
        String lang = 'en';
        String resUrl = bannerUrl + 'item=autolog&login=' + username + '&password=' + password + '&popup=' + isPop + '&lang=' + lang;
        return resUrl;
    }

//------------------------- errors --------------------------------//

    public void hideAllWhenError() {
        showLoginPageBanner = false;
        showLoginPagePolling = false;
    }

    @TestVisible
    private void showError(String msg) {
        hideAllWhenError();
        MyCustomException myEx = new MyCustomException(msg);//INVALID_LOGIN_TOKEN);
        myEx.objWithError = this;
        ErrorManager.defineError(myEx);
    }

    @TestVisible
    public void showError(MyCustomException myEx) {
        hideAllWhenError();
        myEx.objWithError = this;
        ErrorManager.defineError(myEx);
    }

    @TestVisible
    private void showError(Exception ex) {
        hideAllWhenError();
        showMainErrorMessage = true;
        ErrorManager.defineError(ex);
    }

    //----------------------- inner class -------------------------//
    @TestVisible
    private class Context {
        @TestVisible
        private TelephonyBoardController telephonyBoardCntr;
        @TestVisible
        private StatusManager.Status st;
        private String lastCallId;
        public String lastStatus { get; set; }

        public Context(){}

        public Context(TelephonyBoardController telephonyBoardCntr) {
            this.telephonyBoardCntr = telephonyBoardCntr;
        }
        public void setStatus(String jsResponce) {
            
            CaseIncomingCall inCall = CaseIncomingCall.parse(jsResponce);//can be outbound call
            
            System.debug('Name: ' + inCall.call.service_label);
            if(DataMaps.mapStatuses.containsKey(inCall.agent.status)){
                inCall.agent.statusColor = DataMaps.mapStatuses.get(inCall.agent.status);
            } else {
                inCall.agent.statusColor = DataMaps.getColor(inCall.call.product_uid);
            }
            telephonyBoardCntr.infoCallForPage = inCall;//CaseIncomingCall.parse(jsResponce);//can be outbound call
            if (lastStatus != inCall.agent.status
                    || lastCallId != inCall.call.callid) {
                lastStatus = inCall.agent.status;
                lastCallId = inCall.call.callid;
                applyStrategy(jsResponce);
                telephonyBoardCntr.changeStatus = true;
            } else {
                telephonyBoardCntr.changeStatus = false;
            }
        }

        public StatusManager.Status getStatus() {
            return st;
        }

        private void applyStrategy(String jsResponce) {
            String clName = DataMaps.mapStatusClasses.get(telephonyBoardCntr.infoCallForPage.agent.status);
            if (!String.isBlank(clName)) {
                Type t = Type.forName(clName);
                st = (StatusManager.Status) t.newInstance();
                st.setTelephonyBoardContr(telephonyBoardCntr);
                st.run(jsResponce);
            }
        }

    }


}