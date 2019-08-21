({
    onLoad: function(component, event) {
        //call apex class method
            var action = component.get('c.fetchCases');
            action.setCallback(this, function(response){
                //store state of response
                var state = response.getState();
                if (state === "SUCCESS") {
                    //set response value in ListOfContact attribute on component.
                    component.set('v.ListOfCase', response.getReturnValue());
                }
            });
            $A.enqueueAction(action);
        
    },
    
    convertArrayOfObjectsToCSV : function(objectRecords, valeurPicklist){
        // declare variables
        var csvStringResult, counter, colonnes, columnDivider, lineDivider, stringColonnes;
        
        // check if "objectRecords" parameter is null, then return from function
        if (objectRecords == null || !objectRecords.length) {
            return null;
        }
        // store ,[comma] in columnDivider variabel for sparate CSV values and 
        // for start next line use '\n' [new line] in lineDivider varaible  
        columnDivider = ',';
        lineDivider =  '\n';
        
        // in the keys valirable store fields API Names as a key 
        // this labels use in CSV file header  
        //keys = ['FirstName','LastName','Department','MobilePhone','Id' ];
        
        if(valeurPicklist === 'Contacts entrants'){
            colonnes = ['TECH_FamilleMatrice__c', 'TECH_MotifMatrice__c', 'TECH_SousMotifMatrice__c',
            	 //'Nombre de tickets', 'CourrierEntrant', 'EmailEntrant', 'AppelEntrant', 'FormulaireContact'];
            //stringColonnes = [0, 1, 2];
                 'Nombre de tickets', 'CourrierEntrant', 'EmailEntrant', 'AppelEntrant', 'FormulaireContact', 'Facebook', 'Twitter', 'GMB'];
            stringColonnes = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
        }
        if(valeurPicklist === 'Contacts sortants'){
            colonnes = ['TECH_FamilleMatrice__c', 'TECH_MotifMatrice__c', 'TECH_SousMotifMatrice__c',
            	 'Nombre de tickets', 'CourrierSortant','EmailSortant','AppelSortant'];
            //stringColonnes = [0, 1, 2];
            stringColonnes = [0, 1, 2, 3, 4, 5];
        }
        if(valeurPicklist === 'Flux internes'){
            colonnes = ['TECH_FamilleMatrice__c', 'TECH_MotifMatrice__c', 'TECH_SousMotifMatrice__c',
            	 //'Nombre de tickets', 'CourrierSortant', 'EmailSortant', 'AppelSortant'];
            //stringColonnes = [0, 1, 2];
            	 'Nombre de tickets'];
            stringColonnes = [0, 1, 2, 3];
            
        }
        if(valeurPicklist === 'Courriers automatiques sortants'){
            //colonnes = ['Template', 'Total', 'PND true'];
            //stringColonnes = [0];
            colonnes = ['Template', 'Format', 'nb'];
            stringColonnes = [0, 1, 2, 3];
        }
        if(valeurPicklist === 'Export'){
            colonnes = ['nb','Description', 'Id_media_type', 'Id_statut_cccc', 'direction', 'Contract type', 'Base', 'PND'];
            stringColonnes = [ 1, 2, 3, 4, 5, 6, 7];
        }
        if(valeurPicklist === 'Calcul des primes'){
        	colonnes = [];
        	stringColonnes = [];
        }
        //colonnes = ['TECH_FamilleMatrice__c','TECH_MotifMatrice__c','TECH_SousMotifMatrice__c','NbAppelsEntrants__c','NbCourriersEntrants__c','NbEmailsEntrants__c'];
        
        csvStringResult = '';
        if(colonnes.length > 0) {
        	csvStringResult += colonnes.join();
        	csvStringResult += lineDivider;
        }
        
        
        console.log('OBJECTRECORDS LENGTH= ' + objectRecords.length);
        console.log('OBJECTRECORDS = ' + objectRecords);
        
        for(var i=0; i < objectRecords.length; i++){   
            console.log('Object Record: ' + objectRecords[i][0]);
            for(var j= 0; j < stringColonnes.length; j++) {
            	if(objectRecords[i][stringColonnes[j]] != undefined) {
            		objectRecords[i][stringColonnes[j]] = '"' + objectRecords[i][stringColonnes[j]] + '"';
            	}
            	
            }
            
            csvStringResult += objectRecords[i].join(); 
                
            csvStringResult += lineDivider;
        }// outer main for loop close 
        
        // return the CSV formate String 
        console.log('CSV RESUTL =  ' + csvStringResult);
        return csvStringResult;        
    },
    
    getMatriceSelectionnee : function(component, valeurPicklist, dateOuvertureSelectionnee, dateClotureSelectionnee, abonnement, produit){

        console.log('IN getMatriceSelectionnee ## Picklist = ' + valeurPicklist);
        console.log('IN getMatriceSelectionnee ## dateOuvertureSelectionnee = ' + dateOuvertureSelectionnee);
        console.log('IN getMatriceSelectionnee ## dateClotureSelectionnee = ' + dateClotureSelectionnee);
        console.log('IN getMatriceSelectionnee ## abonnement = ' + abonnement);
        
        var action;
        if(valeurPicklist === 'Contacts entrants'){
            console.log("IN Contacts entrants");
            action = component.get('c.fetchCasesContactsEntrants');
        } 
        if(valeurPicklist === 'Contacts sortants'){
            console.log("IN Contacts sortants");
            action = component.get('c.fetchCasesContactsSortants');
        }
        if(valeurPicklist === 'Flux internes'){
            console.log("IN Flux internes");
            action = component.get('c.fetchCasesFluxInternes');
        }
        if(valeurPicklist === 'Courriers automatiques sortants'){
            console.log("IN Courriers automatiques sortants");
            action = component.get('c.fetchCourriersAutoSortants');
            
        }
        if(valeurPicklist === "Export"){
            console.log("IN Export");
            action = component.get("c.fetchExport");
            
        }
        if(valeurPicklist === "Calcul des primes"){
            console.log("IN Calcul des primes");
            action = component.get("c.fetchCompteursPrime");
            
        }
        action.setParams({
                dateOuverture : dateOuvertureSelectionnee,
                dateCloture : dateClotureSelectionnee,
                carte : abonnement,
                produit : produit
        });
        action.setCallback(this, function(response){
            //store state of response
            var state = response.getState();
            if (state === "SUCCESS") {
                //set response value in ListOfContact attribute on component.
                component.set('v.ListOfCase', response.getReturnValue());
                
                var listeCases = response.getReturnValue();
        
        
                console.log('IN downloadCsv ## listeCases = ' + listeCases);
                
                if(listeCases.length == 0) {
                	component.set("v.message", 'Aucun ticket ne correspond aux critères choisis.');
                } else {
                	// call the helper function which "return" the CSV data as a String   
	                var csv = this.convertArrayOfObjectsToCSV(listeCases, valeurPicklist);
                    console.log('#####' + csv);   
	                if (csv == null) {
	                	return;
	                } 
	                
	                // ####--code for create a temp. <a> html tag [link tag] for download the CSV file--####     
	                var hiddenElement = document.createElement('a');
	                hiddenElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(csv);
	                hiddenElement.target = '_self'; //
	                if(valeurPicklist === 'Contacts entrants'){
	                     hiddenElement.download = 'Contacts_entrants.csv';  // CSV file Name* you can change it.[only name not .csv]
	                }
	                if(valeurPicklist === 'Contacts sortants'){
	                     hiddenElement.download = 'Contacts_sortants.csv';  // CSV file Name* you can change it.[only name not .csv]
	                }
	                if(valeurPicklist === 'Flux internes'){
	                     hiddenElement.download = 'Flux_internes.csv';  // CSV file Name* you can change it.[only name not .csv]
	                }
	                if(valeurPicklist === 'Courriers automatiques sortants'){
	                     hiddenElement.download = 'Courriers_automatiques_sortants.csv';  // CSV file Name* you can change it.[only name not .csv]
	                }
	                if(valeurPicklist === 'Export'){
	                     hiddenElement.download = 'Export.csv';  // CSV file Name* you can change it.[only name not .csv]
	                }
	                if(valeurPicklist === 'Calcul des primes'){
	                     hiddenElement.download = 'Primes.csv';  // CSV file Name* you can change it.[only name not .csv]
	                }
	                console.log('IN downloadCsv ## hiddenElement.download = ' + hiddenElement.download);
	        
	                document.body.appendChild(hiddenElement); // Required for FireFox browser
	                hiddenElement.click(); // using click() js function to download csv file
	                
                }
                
                
                console.log('Fin download');
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
        $A.enqueueAction(action);
	}
})