({
	getActivities: function(component) {
        var caseId = component.get('v.caseId');
        // create a server side action. 
        var action = component.get("c.getActivities");
        action.setParams({
            "caseId": caseId
        });
        console.log('DisplayCases: ' + caseId);
        
        // set a call back   
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
	            component.set("v.activitiesRecord", result);
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
    willDisappear: function(component, delai) {
        console.log('DCPC will disappear');
        component.set('v.willDisappear', true);
        setTimeout(function() {
            if(component.get('v.willDisappear')) {
                component.set('v.show', false);
            }}, delai);
    }
    
})