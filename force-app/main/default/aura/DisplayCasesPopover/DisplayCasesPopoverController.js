({
    doInit : function(component, event, helper) {
		var caseId = component.get('v.caseId');
        console.log("init show " + component.get('v.caseId') + ": " +  component.get('v.showable'));
	},
    
	showableChanged: function(component, event, helper) {
        console.log("DCPC showable changed: " + component.get('v.caseId')+ ": " +  component.get('v.showable')+ ": " +  component.get('v.show'));
        if(component.get('v.showable')) {
            component.set('v.show', true);
        } else {
            helper.willDisappear(component, 100);
        }
                
    },
    
    showChanged: function(component, event, helper) {
        console.log("DCPC show " + component.get('v.caseId') + ": " +  component.get('v.show'));
        if(component.get('v.show')) {
            var toggleText = component.find("tooltip");
           
            if(component.get('v.activitiesRecord').length == 0) {
                console.log('call getActivities');
                helper.getActivities(component);
            }
            component.set('v.willDisappear', false);
            
        }
        
    },
    
    mouseleave: function(component, event, helper) {
        // component.set('v.show', false);
        // Si on veut un délai:
        event.stopPropagation();
        helper.willDisappear(component, 500);
    },
    mouseover: function(component, event, helper) {
        console.log("DCPC mouseover");
        component.set('v.willDisappear', false);
    }
    
})