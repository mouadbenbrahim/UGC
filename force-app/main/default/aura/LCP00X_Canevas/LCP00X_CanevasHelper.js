({
	init: function(component) {
        var currentId = component.get("v.recordId");
        //var bttnOperation = component.get("v.bttnOperation");
        //console.log("##MBEN2 bttnOperation: " + bttnOperation);
        
        /*var child = component.get("v.child").RecordType.DeveloperName;
        var LiveCampaignCount = component.get("v.child").LiveCampaignCount_crm__c;
        var TechnicalFieldToday =  component.get("v.child").Technical_field_today__c;
        
        var AdvertiserStatus = component.get("v.CaseRecord.fields.AdvertiserStatus_crm__c.value");
        var LastStatusUpdateDate = component.get("v.CaseRecord.fields.LastStatusUpdateDate_crm__c.value");
        var CPOPId = component.get("v.CaseRecord.fields.CPOPId_crm__c.value");
        var UVInfoDate = component.get("v.CaseRecord.fields.UVInfoDate_crm__c.value");
        var Ownership = component.get("v.CaseRecord.fields.OwnerId.value");*/
         
        var action = component.get("c.initApexMethod");
        action.setParams({
            idCase : currentId,
            otherVar : component.get("v.otherVar"),
            bttnOperation : component.get("v.bttnOperation")
            });
        action.setCallback(this, function(response, component) {
            var functionResult = response.getReturnValue();
            var state = response.getState();
            if (state === "SUCCESS") {
				if(functionResult.showMessage){
                    if(functionResult.isWarning){
                        component.set("v.isWarning", true);
                        component.set("v.messageWarning", functionResult.messageToDisplay);
                    }
                    else if(functionResult.isError){
                        component.set("v.isError", true);
                        component.set("v.messageError", functionResult.messageToDisplay);
                    }
                    else if(functionResult.isInfo){
                        component.set("v.isInfo", true);
                        component.set("v.messageInfo", functionResult.messageToDisplay);
                    }
				}
                else {
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
                console.log("##MNE showMessage >> "+functionResult.showMessage);
            } else {
                console.log("##MNE initToCreateNewIntegrationRequest KO Exception"); 
            }
        });
        $A.enqueueAction(action);
	}
    
})