({
	doInit : function(component, event, helper) {
		var action = component.get("c.getParams");
        console.log("recordId: " + JSON.stringify(component.get("v.recordId")));
        action.setParams({recordId: component.get("v.recordId")});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var dto = response.getReturnValue();
                console.log("dto: " + JSON.stringify(dto));
                component.set("v.dto", dto);
            } else if (state === "INCOMPLETE") {
                // do something
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
        console.log("init");
        $A.enqueueAction(action);
	},
    reinitTab : function(component, event, helper) {
        var selTabId = component.get("v.selTabId");
        var tabCmp = component.find(selTabId);
        console.log("selTabId: " + selTabId);
        var dto = component.get("v.dto");
        console.log("reinitTab: " + JSON.stringify(dto));
        if(dto && tabCmp) {
            if(selTabId != 'Vlo') {
                tabCmp.reinit(dto.strBaseUrl, dto.strCodePays, dto.strIdMonCompte);
            } else {
                tabCmp.reinitVlo(dto.strBaseUrlVlo, dto.strCodePays, dto.strIdMonCompte);
            }
            
            
        }
        
	}
})