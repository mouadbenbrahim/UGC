({
	doInit: function(component, event, helper) {       
        var newCase = {'sobjectType': 'Case',
                            'MontantRemise__c': null,
                       		'NombreDeMoisRemise__c': null, 
                            'Mois_de_d_but_remise__c': null,
                            'Pallier__c': null
                           };
        component.set("v.caseRecord",newCase);
   	},
    
    valider: function(component, event, helper) {
        var c = component.get("v.caseRecord");
        var currentId = component.get("v.recordId");
        /*if($A.util.isEmpty(c.MontantRemise__c) || $A.util.isUndefined(c.MontantRemise__c)){
            alert('First Montant remise is Required');
            return;
        }  
        if($A.util.isEmpty(c.Mois_de_d_but_remise__c) || $A.util.isUndefined(c.Mois_de_d_but_remise__c)){
            alert('First Mois de début remise is Required');
            return;
        }
        if($A.util.isEmpty(c.NombreDeMoisRemise__c) || $A.util.isUndefined(c.NombreDeMoisRemise__c)){
            alert('First Nombre de mois remise is Required');
            return;
        }
        if($A.util.isEmpty(c.Pallier__c) || $A.util.isUndefined(c.Pallier__c)){
            alert('First Pallier is Required');
            return;
        }*/
        
        var action = component.get("c.ongletExecuteGesteCommercial");
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
                            'MontantRemise__c': null,
                       		'NombreDeMoisRemise__c': null, 
                            'Mois_de_d_but_remise__c': null,
                            'Pallier__c': null
                           };
        			component.set("v.caseRecord",newCase);
                    
                    var resultsToast = $A.get("e.force:showToast");
                    resultsToast.setParams({
                        "type": "success",
                        "title": "Succes",
                        "message": "Success de du geste commercial"
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