({
    getCases: function(component, page, recordToDisplay) {
            
        
        // create a server side action. 
        var action = component.get("c.getCases");
        // set the parameters to method 
        console.log("search field: " + component.get("v.searchField"));
        console.log("keyword: " + component.get("v.keyword"));
        
        action.setParams({
            "accountId": component.get("v.recordId"),
            "pageNumber": page,
            "recordToDisplay": recordToDisplay,
            "sortField" : component.get("v.selectedTabsoft"),
            "isAsc": component.get("v.isAsc"),
            "searchField": component.get("v.searchField"),
            "keyword": component.get("v.keyword")
        });
        // set a call back   
        action.setCallback(this, function(response) {
        	var state = response.getState();
            if (state === "SUCCESS") {
                // store the response return value (wrapper class instance)  
	            var result = response.getReturnValue();
	            console.log('result ---->' + JSON.stringify(result));
	            // set the component attributes value with wrapper class properties.   
	            
	            component.set("v.CaseRecords", result.cases);
	            component.set("v.page", result.page);
	            component.set("v.total", result.total);
	            component.set("v.pages", Math.ceil(result.total / recordToDisplay));
	            component.set("v.numberPages", result.numberPages);
            } else if (state === "INCOMPLETE") {
                // do something
                console.log('getCases incomplete');
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
            
            
            
        });
        // enqueue the action 
        $A.enqueueAction(action);
    },
    getFieldLabels: function(component) {
        
        // create a server side action. 
        var action = component.get("c.getCaseFieldsIdLabels");
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {                
                var custs = [];
                var conts = response.getReturnValue();
                for ( var key in conts ) {
                    custs.push({value:conts[key], key:key});
                }
                component.set("v.fieldLabels", custs);
            } 
        });  
        $A.enqueueAction(action);
    },
    
    
    sortColumns : function(component,event){
        var page = 1
        var recordToDisplay = component.find("recordSize").get("v.value");
        var currentDir = component.get("v.arrowDirection");
        if (currentDir == 'arrowdown') {
            component.set("v.arrowDirection", 'arrowup'); 
            component.set("v.isAsc", true);
        } else {
            component.set("v.arrowDirection", 'arrowdown');
            component.set("v.isAsc", false);
        }
        this.getCases(component, page, recordToDisplay);
    },
    
    searchKey: function(component, event) {           
        var input = document.getElementById("getCases");
        var filter = input.value.toUpperCase();
        
    },
    
    getOriginLabels: function(component){
        var action = component.get("c.getOriginLabels");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {                
                var mapLabels = response.getReturnValue();
                component.set("v.Email", mapLabels['E-mail']);
		        component.set("v.Telephone", mapLabels['Téléphone']);
		        component.set("v.FormulaireDeContact", mapLabels['Formulairedecontact']);
		        component.set("v.Courrier", mapLabels['Courrier']);	
		        component.set("v.Salle", mapLabels['Salle']);
		        component.set("v.Facebook", mapLabels['Facebook']);
		        component.set("v.Twitter", mapLabels['Twitter']);
		        component.set("v.Critizr", mapLabels['Critizr']);
		        component.set("v.Interne", mapLabels['Interne']);
            } 
        });  
        $A.enqueueAction(action);
    },
    
    getCommentairesInternesLabel: function(component){
        var action = component.get("c.getCommentairesInternesLabel");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {                
                var CommentairesInternesLabel = response.getReturnValue();
                component.set("v.CommentairesInternesLabel", CommentairesInternesLabel);
                
            } 
        });  
        $A.enqueueAction(action);
    },
    
    getIdsAndCreateRecord: function(component) {
    	var id = component.get("v.recordId")
    	var action = component.get("c.getContactIds");
    	action.setParams({"recordId": id})
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {     
            	var ids = response.getReturnValue();
                var createRecordEvent = $A.get("e.force:createRecord");
		        createRecordEvent.setParams({
		            "entityApiName": "Case",
		            "defaultFieldValues": {
		            	"AccountId": ids.accountId,
		            	"ContactId": ids.contactId
				     }
		        });
		        createRecordEvent.fire();
            } 
        });  
        $A.enqueueAction(action);
    }
    
    
})