({
    reinit : function(component, event, helper) {
		console.log("ReInit ");
        var params = event.getParam('arguments');

        var url = params.baseUrl + "/" + component.get("v.urlFragment") + "/" 
        	+ params.codePays + "/" + params.idMonCompte;
        console.log("url: " + url);
        
        if(params.baseUrl  ) {
            var d = new Date();
            var n = d.getTime();   
            component.set("v.ifmsrc", url + '?t=' + n);
            
        }
        
	},
    reinitVlo : function(component, event, helper) {
		console.log("ReInit ");
        var params = event.getParam('arguments');

        //var url = params.baseUrl + "/" + params.codePays + "/" + params.idMonCompte;
        var url = params.baseUrl + "/" + params.idMonCompte;
        console.log("url Vlo: " + url);
        
        if(params.baseUrl  ) {
            var d = new Date();
            var n = d.getTime();   
            component.set("v.ifmsrc", url + '?t=' + n);
            
        }
        
	}
})