({
    doInit: function(component, event, helper) {
        
        // this function call on the component load first time     
        // get the page Number if it's not define, take 1 as default
        var page = component.get("v.page") || 1;
        // get the select option (drop-down) values.   
        var recordToDisplay = component.find("recordSize").get("v.value");        
        // call the helper function   
        helper.getCases(component, page, recordToDisplay);
        helper.getFieldLabels(component);
        helper.getOriginLabels(component);
     	helper.getCommentairesInternesLabel(component);
    },
   

    otherPage: function(component, event, helper) {
        // this function call on click on the previous page button  
        var page = component.get("v.page") || 1;
        // get the previous button label  
        var direction = event.getSource().get("v.label");
        // get the select option (drop-down) values.  
        var recordToDisplay = component.find("recordSize").get("v.value");
        // set the current page,(using ternary operator.)  
        page = direction;
        // call the helper function
        helper.getCases(component, page, recordToDisplay);
        
    },
    
    searchKeyChange: function(component, event,helper) {
    	console.log("search key change: " + event.target.value);
        component.set("v.keyword", event.target.value);    
        var page = 1;
        var recordToDisplay = component.find("recordSize").get("v.value");
        helper.getCases(component, page, recordToDisplay);
    },
    dateSearchChange: function(component, event,helper) {
    	console.log("date search change: " + component.get("v.dateSearch"));
        component.set("v.keyword", component.get("v.dateSearch"));    
        var page = 1;
        var recordToDisplay = component.find("recordSize").get("v.value");
        helper.getCases(component, page, recordToDisplay);
    },
    
    onFieldChange: function(component, event, helper) {
        component.set("v.keyword", "");
        component.set("v.searchField", event.getSource().get("v.value"));
        console.log("SF " + component.get("v.searchField"));
        //document.getElementById("filterFieldName").value = "";
        var page = 1;
        var recordToDisplay = component.find("recordSize").get("v.value");
        helper.getCases(component, page, recordToDisplay);
    },
    
    
    onSelectChange: function(component, event, helper) {
        // this function call on the select opetion change,
        var page = 1;
        var recordToDisplay = component.find("recordSize").get("v.value");		
        helper.getCases(component, page, recordToDisplay);
    },
    
    
    mouseover2 : function(component, event, helper){
        var caseNum = event.getSource().get("v.value");
        console.log('mousover ' + caseNum);
        component.set("v.lastCaseNumber", caseNum);
    },
    
    mouseout : function(component, event, helper){
        component.set("v.lastCaseNumber", 'None');
    },
    
    data-toggle : function(){
        ('[data-toggle="tooltip"]').tooltip()
    },       
    
    
    Sort:function(component, event, helper) {  
        var columnName = event.currentTarget.id;
        if(component.get("v.selectedTabsoft")!=columnName)
        {
            component.set("v.arrowDirection", 'arrowup'); 
            component.set("v.isAsc", true);
        }
        component.set("v.selectedTabsoft", columnName);
        var page = 1;
        var recordToDisplay = component.find("recordSize").get("v.value");
        helper.sortColumns(component, event);    
    },
    
    SortOwnerName:function(component, event, helper) {
        component.set("v.selectedTabsoft", 'Owner.Name');
        var page = 1;
        var recordToDisplay = component.find("recordSize").get("v.value");
        helper.sortColumns(component, event);
        
    },
    
    createRecord : function (component, event, helper) {
    	helper.getIdsAndCreateRecord(component);
        
    },
    
    OpenSubtab: function (id, name) 
    {
        preRecordId= id;
        
        alert('URL----->'+'{!$CurrentPage.URL}');
        
        if (sforce.console.isInConsole())
            sforce.console.getEnclosingPrimaryTabId(openSubtab);
        else
            window.top.location.href = '/' + id;
    }
    
    
})