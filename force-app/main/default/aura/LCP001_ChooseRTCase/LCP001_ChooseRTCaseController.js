({
	doInit: function(component, event, helper) {
   		helper.fetchPicklistValues(component, 'Famille__c', 'Motif__c');
   	},
    
	doValidate: function(component, event, helper) {
		var valueFamille = component.find("conCountry").get("v.value");
        var valueMotif   = component.find("conState").get("v.value");
        var valueOrigin  = component.get("v.caseRecord.Origin");
        var id 			 = component.get("v.recordId")
        if(valueFamille == undefined || valueFamille == '--- None ---' || 
           valueMotif   == undefined || valueMotif   == '--- None ---' || 
           valueOrigin  == undefined || valueOrigin  ==  '--None--'    || valueOrigin == ''){
			alert('Tous les champs sont obligatoires.');
        } else {
            /*var createRecordEvent = $A.get("e.force:createRecord");
            createRecordEvent.setParams({
                "entityApiName": "Case",
                //"recordTypeId": "",
                "defaultFieldValues": {
                    //"AccountId": ids.accountId,
                    //"ContactId": ids.contactId
                }
            });
            createRecordEvent.fire(); */   
			var action = component.get("c.createRecord");
            action.setParams({
                'recordId':     id,
                'valueFamille': valueFamille,
                'valueMotif':   valueMotif,
                'valueOrigin':  valueOrigin
            });  
            action.setCallback(this, function(response) {
                if (response.getState() == "SUCCESS") {
                    var res = response.getReturnValue();
                    /*var sObectEvent = $A.get("e.force:navigateToSObject");
                    sObectEvent .setParams({
                        "recordId":  res,
                        "slideDevName": "detail"
                    });
                    sObectEvent.fire(); */
                    var workspaceAPI = component.find("workspace");
                    workspaceAPI.openTab({
                    	url: '/lightning/r/Account/'+id+'/view', 
                        focus: true
                    }).then(function(response) {
                        workspaceAPI.openSubtab({
                            parentTabId: response,
                            url: '/lightning/r/Case/'+res+'/view',
                            focus: true
                        });
                    })
                    .catch(function(error) {
                        console.log(error);
                    });
                }
            });
            $A.enqueueAction(action); 
		}
	},
    
    onControllerFieldChange: function(component, event, helper) {
      //alert(event.getSource().get("v.value"));
      var controllerValueKey = event.getSource().get("v.value");
      var Map = component.get("v.depnedentFieldMap");
      if (controllerValueKey != '--- None ---') {
         var ListOfDependentFields = Map[controllerValueKey];
         helper.fetchDepValues(component, ListOfDependentFields);
 
      } else {
         var defaultVal = [{
            class: "optionClass",
            label: '--- None ---',
            value: '--- None ---'
         }];
         component.find('conState').set("v.options", defaultVal);
         component.set("v.isDependentDisable", true);
      }
   },
  
   onDependentFieldChange: function(component, event, helper) {
      //alert(event.getSource().get("v.value"));
   }
})