({
	init: function(component) {
        var currentId = component.get("v.recordId");
         
        var action = component.get("c.initGetFieldValues");
        action.setParams({
            recordId : currentId,
        });
        action.setCallback(this, function(response, component) {
            var functionResult = response.getReturnValue();
            var state = response.getState();
            if (state === "SUCCESS") {
                if(functionResult){
                    component.set("v.fieldValues", functionResult);
            	} 
            }
        });
        $A.enqueueAction(action);
        
        var action = component.get("c.getPhotoSFDC");
        action.setParams({
        	 recordId : currentId
        });  
        action.setCallback(this, function(response) {
        	if (response.getState() == "SUCCESS") {
        		var res = response.getReturnValue();
        		component.set("v.image", res);          
        	}
        });
        $A.enqueueAction(action);
	}
})