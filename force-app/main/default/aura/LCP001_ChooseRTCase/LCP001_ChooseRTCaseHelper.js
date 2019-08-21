({
   fetchPicklistValues: function(component, controllerField, dependentField) {
      var action = component.get("c.getDependentOptionsImpl");
      action.setParams({
         'objApiName': component.get("v.objInfo"),
         'contrfieldApiName': controllerField,
         'depfieldApiName': dependentField
      });  
      action.setCallback(this, function(response) {
         if (response.getState() == "SUCCESS") {
            var res = response.getReturnValue();
            var StoreResponse = res.objResults;
            component.set("v.depnedentFieldMap", StoreResponse);
            component.set("v.caseRecord", res.caseRecord);
            var listOfkeys = []; 
            var ControllerField = []; 
            for (var singlekey in StoreResponse) {
               listOfkeys.push(singlekey);
            }
            if (listOfkeys != undefined && listOfkeys.length > 0) {
               ControllerField.push({
                  class: "optionClass",
                  label: "--- None ---",
                  value: "--- None ---"
               });
            }
            for (var i = 0; i < listOfkeys.length; i++) {
               ControllerField.push({
                  class: "optionClass",
                  label: listOfkeys[i],
                  value: listOfkeys[i]
               });
            }
            component.find('conCountry').set("v.options", ControllerField);
         }
      });
      $A.enqueueAction(action);
   },

   fetchDepValues: function(component, ListOfDependentFields) {
      var dependentFields = [];
      if (ListOfDependentFields != undefined && ListOfDependentFields.length > 0) {
         dependentFields.push({
            class: "optionClass",
            label: "--- None ---",
            value: "--- None ---"
         });
      }
      for (var i = 0; i < ListOfDependentFields.length; i++) {
         dependentFields.push({
            class: "optionClass",
            label: ListOfDependentFields[i],
            value: ListOfDependentFields[i]
         });
      }
      component.find('conState').set("v.options", dependentFields);
      component.set("v.isDependentDisable", false);
   }
})