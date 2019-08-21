public with sharing class DisplayCases_CC {
    
    @AuraEnabled
    public static CasePageWrapper getCases(Id accountId, Decimal pageNumber, Integer recordToDisplay, 
    	String sortField, Boolean isAsc, String searchField, String keyword) 
    {        
    	Id recordId = Id.valueOf(accountId); 
    	
        if(recordId.getSObjectType() == Schema.Case.SObjectType) {
        	Case cse = [SELECT accountId FROM Case WHERE id = :recordId];
        	recordId = cse.accountId;
        }
        
        Integer pageSize = recordToDisplay;
        Integer offset = ((Integer)pageNumber - 1) * pageSize;
        
        
        // create a instance of wrapper class.
        CasePageWrapper caseWrap =  new CasePageWrapper();  
        caseWrap.pageSize = pageSize;
        caseWrap.page = (Integer) pageNumber;
        
        String selectClause = 'SELECT Id, CaseNumber, Owner.Name, Date_de_creation__c , Famille__c, Motif__c, SousMotif__c, tolabel(Origin), CommentairesInternes__c, Status, ProvenanceDemande__c';
        
        String fromWhereClause = ' From Case where AccountId = :recordId';
        
        Date date1 = null;
        Date date2 = null;
        
        if(!String.isBlank(searchField)  &&  !String.isBlank(keyword) ) {
        	if(searchField == 'Date_de_creation__c') {
        		try {
	        		date1 = Date.valueOf(keyword);
	        		date2 = date1.addDays(1);
	        		fromWhereClause += ' AND Date_de_creation__c >= :date1 AND Date_de_creation__c < :date2 ';
        		} catch(System.TypeException e) {
        			
        		}
        	} else {
        		keyword = '%' + keyword + '%';
            	fromWhereClause += ' AND ' + searchField + ' like :keyword ';
        	}
        }
          
        String orderClause = ' order by ' + sortField;
        
        if (isAsc) { 
            orderClause += ' asc';
        } else {
            orderClause += ' desc';
        }
        
        orderClause += ' LIMIT :recordToDisplay OFFSET :offset';  
        
        String soql = selectClause + fromWhereClause + orderClause;   
        system.debug('## DisplayCases_CC ## query: ' + soql);   
        caseWrap.cases = Database.query(soql);      
            
        caseWrap.total = Database.countQuery('SELECT count() ' + fromWhereClause);
        caseWrap.numberPages = new List<Integer>();
        
        Integer totalPage = (Integer)Math.ceil((Double)caseWrap.total/(Double)caseWrap.pageSize);
        for(Integer i = 0;i<totalPage;i++){
            caseWrap.numberPages.add(i+1);          
        }
        // return the wrapper class instance .
        return caseWrap;
    }
    
    // create a wrapper class with @AuraEnabled Properties    
    public class CasePageWrapper {
        @AuraEnabled public Integer pageSize {get;set;}
        @AuraEnabled public Integer page {get;set;}
        @AuraEnabled public Integer total {get;set;}
        @AuraEnabled public List<Integer> numberPages {get;set;}
        @AuraEnabled public List<Case> cases {get;set;}
    }
    
    
    @AuraEnabled
    public static Map<string,string> getCaseFieldsIdLabels() {
        
        Map<string,string> retVal = new Map<string,string>();
        List<String> apiNames = new List<String>();
        apiNames.add('CaseNumber');
        apiNames.add('Origin');
        apiNames.add('Date_de_creation__c');
        apiNames.add('Famille__c');
        apiNames.add('Motif__c');
        apiNames.add('SousMotif__c');
        // apiNames.add('CommentairesInternes__c');
        Map<String, Schema.SObjectType> GlobalMap = Schema.getGlobalDescribe();
        Schema.DescribeSObjectResult obj = GlobalMap.get('Case').getDescribe();
        for(String s : apiNames){
            Schema.SObjectField field = obj.Fields.getMap().get(s);
            Schema.DescribeFieldResult describeFieldResult = field.getDescribe();
            String fieldLabel = describeFieldResult.getLabel();
            
            retVal.put(s, fieldLabel);
            
        }
        
        return retVal;
        
    }
    
    @AuraEnabled
    public static List<Task> getActivities(String caseId) {
        List<Task> activities = [SELECT Id, Type, TECH_Type__c, Subject, WhoId, Who.Name, ActivityDate, Description,
                              Commentaire__c, WhatId, What.Name, OwnerId, Owner.Name, IconeCanalOrigine__c,
                              (Select Name, Id from Attachments) FROM Task 
                              WHERE WhatId = :caseId AND origine__c != null
                              ORDER BY CreatedDate, ActivityDate];
        return activities;
    }
    
    
    @AuraEnabled
    public static Map<String, String> getOriginLabels(){
        Map<String, String> retval = new Map<String, String>();
        Schema.DescribeFieldResult fieldResult = Case.Origin.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry f: ple) {
        	retVal.put(f.getValue(), f.getLabel());
        }
        return retval;
    }
    
    @AuraEnabled
    public static String getCommentairesInternesLabel() {
        Map<String, Schema.SObjectType> GlobalMap = Schema.getGlobalDescribe();
        Schema.DescribeSObjectResult obj = GlobalMap.get('Case').getDescribe();
        Schema.SObjectField field = obj.Fields.getMap().get('CommentairesInternes__c');
        Schema.DescribeFieldResult describeFieldResult = field.getDescribe();
        return  describeFieldResult.getLabel();
    }
    
    public class IdsDto {
    	@AuraEnabled
    	public String accountId { get; set; }
    	
    	@AuraEnabled
    	public String contactId { get; set; }
    	 
    }
    
    @AuraEnabled
    public static IdsDto getContactIds(Id recordId) {
    	if(recordId.getSObjectType() == Schema.Case.SObjectType) {
        	Case cse = [SELECT accountId FROM Case WHERE id = :recordId];
        	recordId = cse.accountId;
        }
        
        Contact contact = [SELECT id FROM Contact WHERE accountId = :recordId];
        
        IdsDto res = new IdsDto();
        res.accountId = recordId;
        res.contactId = contact.Id;
        
        return res;
        
    }
}