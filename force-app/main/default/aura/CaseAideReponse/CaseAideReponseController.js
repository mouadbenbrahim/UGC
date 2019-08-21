({
	recordUpdated : function(component, event, helper) {
		var changeType = event.getParams().changeType;

	    if (changeType === "ERROR" || changeType === "REMOVED") { 
	    	component.set("v.url", ""); 
	    } else if (changeType === "LOADED" || changeType === "CHANGED") {
	    	var str = component.get("v.simpleRecord.AideReponseClient__c");
	    	console.log("str: " + str);
	    	if(str != null && str.startsWith("Pour répondre au client, veuillez cliquer sur le lien suivant")) {
		    	var re = /(.*« )(.*)( ».*)/;
                console.log(re.test(str));
				console.log("part 1: " + str.replace(re, "$1"));
                console.log("part 2: " + str.replace(re, "$2"));
                console.log("part 3: " + str.replace(re, "$3"));
                
                component.set("v.msgPart1", str.replace(re, "$1"));
                component.set("v.msgPart3", str.replace(re, "$3"));
				component.set("v.url", str.replace(re, "$2"));
	    	} else {
	    		component.set("v.url", "");
	    	}
        }
	}
})