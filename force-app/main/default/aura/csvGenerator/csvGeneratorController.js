({
    // ## function call on component load  
    loadCaseList: function(component, event, helper){
        helper.onLoad(component, event);
    },
    
    // ## function call on Click on the "Download As CSV" Button. 
    downloadCsv : function(component,event,helper){
    
    	component.set("v.message", null);
    	component.find("matrice-Id").set("v.errors", null);
    	component.find("openDate").set("v.errors", null);
    	component.find("closeDate").set("v.errors", null);
        
        // get the Records [contact] list from 'ListOfContact' attribute 
        
        var valeurPicklist = component.find("matrice-Id").get("v.value");
        console.log('Matrice: ' + valeurPicklist );
        console.log(valeurPicklist != "");
        var datedOuverture = component.find("openDate").get("v.value");
        var dateCloture = component.find("closeDate").get("v.value");
        
        var estAbonne = component.find("abonnee-Id").get("v.value");
        var produit = component.find("produit-Id").get("v.value");
        
        var dateOuvertureTostring = null;
        var dateClotureTostring = null;
        if(datedOuverture != null){
            dateOuvertureTostring = datedOuverture.toString();
            console.log('IN downloadCsv ## datedOuverture TO STRING = ' + dateOuvertureTostring);
        }
        if(dateCloture != null){
            dateClotureTostring = dateCloture.toString();
            console.log('IN downloadCsv ## dateCloture TO STRING = ' + dateClotureTostring);
        }
        
        
        if(valeurPicklist == "") {
        	component.find("matrice-Id").set("v.errors", [{message:"Veuillez choisir une matrice."}]);
        } else if(valeurPicklist == 'Calcul des primes') {
        	console.log("Calcul des primes");
        	if(! datedOuverture) {
        		component.find("openDate").set("v.errors", [{message:"Veuillez choisir une date de début."}]);
        	}
        	if(! dateCloture) {
        		component.find("closeDate").set("v.errors", [{message:"Veuillez choisir une date de fin."}]);
        	}
        	helper.getMatriceSelectionnee(component, valeurPicklist, dateOuvertureTostring, dateClotureTostring, estAbonne, produit);
        } else {
            
            console.log("Matrice defined");
            
            
            console.log('IN downloadCsv ## Picklist = ' + valeurPicklist);
            console.log('IN downloadCsv ## datedOuverture = ' + datedOuverture);
            console.log('IN downloadCsv ## dateCloture = ' + dateCloture);
            console.log('IN downloadCsv ## estAbonne = ' + estAbonne);
            console.log('IN downloadCsv ## produit = ' + produit);
            
            helper.getMatriceSelectionnee(component, valeurPicklist, dateOuvertureTostring, dateClotureTostring, estAbonne, produit);
        }
        
        
        console.log('FIN downloadcsv()'); 
    }, 
    changeMatrice : function(component, event, helper){
    	var valeurPicklist = component.find("matrice-Id").get("v.value");
    	component.set("v.matrice", valeurPicklist);
    	console.log("matrice: " + component.get("v.matrice"));
    }
})