({
	init: function(component, event, helper) {
        var currentId = component.get("v.myRecordId");
        var otherVar = component.get("v.otherVar");
        var bttnOperation = component.get("v.bttnOperation");
        
        var confirmationAction = false;

        console.log("##MNE init currentId >> "+currentId); 
        console.log("##MNE init otherVar >> "+otherVar); 
        console.log("##MNE init bttnOperation >> "+bttnOperation); 
        
        if(bttnOperation == 'Anonymisation' || bttnOperation == 'AnonymisationAbonne'){
            confirmationAction = confirm('Etes-vous sûr de vouloir exécuter le droit à l’oubli ? Le processus est irréversible.');
        }else{
        	confirmationAction = true;
        }
        

        if(confirmationAction){
            var action = component.get("c.initApexMethod");
            action.setParams({
                currentId : currentId,
                otherVar : otherVar,
                bttnOperation : bttnOperation,
                confirmationAction : confirmationAction
            });
            action.setCallback(this, function(response, component) {
                var functionResult = response.getReturnValue();
                var state = response.getState();
                console.log("##MNE functionResult >> "+functionResult); 
                console.log("##MNE state >> "+state); 
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
        } else {
        	console.log("##MNE coucou"); 
        	component.set("v.isInfo", true);
            component.set("v.messageInfo", 'Action annulée');
        }
	}    
})

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