({
	doInit: function(component, event, helper) {       
        var newCase = {'sobjectType': 'Case',
                            'Payment__c': null,
                       		'MontantRembourser__c': null, 
                            'DateDeRemboursement__c': null
                           };
        component.set("v.caseRecord",newCase);
   	},
    
    valider: function(component, event, helper) {
        var c = component.get("v.caseRecord");
        var currentId = component.get("v.recordId");
        
        console.log("##MNE valider Payment >> "+c.Payment__c);
        console.log("##MNE valider MontantRembourser >> "+c.MontantRembourser__c);
        console.log("##MNE valider DateDeRemboursement >> "+c.DateDeRemboursement__c);
        
        var action = component.get("c.ongletRemboursement");
        action.setParams({
            caseRecord : c,
            caseId : currentId
        });
        action.setCallback(this, function(response, component) {
            var functionResult = response.getReturnValue();
            var state = response.getState();
            console.log("##MNE init functionResult >> "+functionResult);
            console.log("##MNE init state >> "+state);
            console.log("##MNE init showMessage >> "+functionResult.showMessage);
            if (state === "SUCCESS") {
				if(functionResult.showMessage){
                    //$A.get("e.force:closeQuickAction").fire();
                    component.find('message').showNotice({
                        "variant": "warning",
                        "key" : 'warning',
                        "message": functionResult.messageToDisplay,
                        closeCallback: function() {
                    	}
                	});
				}
                else {
                	//$A.get("e.force:closeQuickAction").fire();
                    //$A.get('e.force:refreshView').fire();
                    var newCase = {'sobjectType': 'Case',
                            'Payment__c': null,
                       		'MontantRembourser__c': null, 
                            'DateDeRemboursement__c': null
                           };
        			component.set("v.caseRecord",newCase);
                    
                    var resultsToast = $A.get("e.force:showToast");
                    resultsToast.setParams({
                        "type": "success",
                        "title": "Succes",
                        "message": "Success du remboursement"
                    });
                    resultsToast.fire();
                    
                     var workspaceAPI = component.find("workspace");
                    workspaceAPI.openTab({
                    	url: '/lightning/r/Account/'+functionResult.accountIdToRedirect+'/view', 
                        focus: true
                    }).then(function(response) {
                        workspaceAPI.openSubtab({
                            parentTabId: response,
                            url: '/lightning/r/Case/'+functionResult.caseIdToRedirect+'/view',
                            focus: true
                        });
                    })
                    .catch(function(error) {
                        console.log(error);
                    });
                     
                    
                }
                console.log("##MNE showMessage >> "+functionResult.showMessage);
            } else {
                console.log("##MNE initToCreateNewIntegrationRequest KO Exception"); 
            }
        });
        $A.enqueueAction(action);
        
    }
})