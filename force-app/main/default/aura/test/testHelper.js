({
	init: function(component) {
      var action = component.get("c.test");
      action.setParams({
      });  
      action.setCallback(this, function(response) {
         if (response.getState() == "SUCCESS") {
            var res = response.getReturnValue();
            component.set("v.image", res.image);          
         }
      });
      $A.enqueueAction(action);
    }
})