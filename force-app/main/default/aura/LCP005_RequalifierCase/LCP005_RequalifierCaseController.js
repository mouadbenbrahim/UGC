({
	doInit: function(component, event, helper) {
   		helper.fetchPicklistValues(component, 'Famille__c', 'Motif__c');
   	},
    
	doValidate: function(component, event, helper) {
		var valueFamille = component.find("conCountry").get("v.value");
        var valueMotif   = component.find("conState").get("v.value");
        var id 			 = component.get("v.recordId")
        if(valueFamille == undefined || valueFamille == '--- None ---' || 
           valueMotif   == undefined || valueMotif   == '--- None ---' ){
			alert('Tous les champs sont obligatoires.');
        } else {
			var action = component.get("c.updateRecord");
            action.setParams({
                'recordId':     id,
                'valueFamille': valueFamille,
                'valueMotif':   valueMotif
            });  
            action.setCallback(this, function(response) {
                if (response.getState() == "SUCCESS") {
                    var res = response.getReturnValue();
                    $A.get("e.force:closeQuickAction").fire();
                    $A.get('e.force:refreshView').fire();
                    var resultsToast = $A.get("e.force:showToast");
                    resultsToast.setParams({
                        "type": "success",
                        "title": "Succes",
                        "message": "Success de l'action"
                    });
                    resultsToast.fire();
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