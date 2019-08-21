({
	init: function(component) {
        //$A.get("e.force:closeQuickAction").fire();
        var currentId = component.get("v.recordId");
        var moisDebutRemise = component.get("v.CaseRecord.fields.Mois_de_d_but_remise__c.value");
        var montantRemise = component.get("v.CaseRecord.fields.MontantRemise__c.value");
        var nbDeMoisRemise = component.get("v.CaseRecord.fields.NombreDeMoisRemise__c.value");
        var pallier = component.get("v.CaseRecord.fields.Pallier__c.value");
        var dateDemande = component.get("v.CaseRecord.fields.DateDemande__c.value");
        var accId = component.get("v.CaseRecord.fields.AccountId.value");
        
        //var LiveCampaignCount = component.get("v.child").LiveCampaignCount_crm__c;
        console.log("##MNE currentId >> "+currentId);
        console.log("##MNE moisDebutRemise >> "+moisDebutRemise);
        console.log("##MNE montantRemise >> "+montantRemise);
        console.log("##MNE nbDeMoisRemise >> "+nbDeMoisRemise);
        console.log("##MNE pallier >> "+pallier);
        console.log("##MNE dateDemande >> "+dateDemande);
        console.log("##MNE accId >> "+accId);

        var action = component.get("c.executeGesteCommercial");
        action.setParams({
        	caseId 			: currentId,
        	accId			: accId,
            moisDebutRemise : moisDebutRemise,
            montantRemise 	: montantRemise,
            nbDeMoisRemise 	: nbDeMoisRemise,
            pallier 		: pallier,
            dateDemandeTMP 	: dateDemande
            });
        action.setCallback(this, function(response, component) {
            var functionResult = response.getReturnValue();
            var state = response.getState();
            console.log("##MNE init functionResult >> "+functionResult);
            console.log("##MNE init state >> "+state);
            console.log("##MNE init showMessage >> "+functionResult.showMessage);
            if (state === "SUCCESS") {
				if(functionResult.showMessage){
                    /*if(functionResult.isWarning){
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
                    }*/
                    $A.get("e.force:closeQuickAction").fire();
                    component.find('message').showNotice({
                        "variant": "warning",
                        "key" : 'warning',
                        "message": functionResult.messageToDisplay,
                        closeCallback: function() {
                    	}
                	});
                    
				}
                else {
                	$A.get("e.force:closeQuickAction").fire();
                    $A.get('e.force:refreshView').fire();
                    var resultsToast = $A.get("e.force:showToast");
                    resultsToast.setParams({
                        "type": "success",
                        "title": "Succes",
                        "message": "Success de du geste commercial"
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