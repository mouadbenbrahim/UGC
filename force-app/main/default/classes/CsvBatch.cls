global class CsvBatch implements Database.Batchable<sObject>, Database.Stateful {

    	global Database.QueryLocator start(Database.BatchableContext BC){
	 	System.debug('Start method calling');
		String query = 'Select id, NbAppelsEntrants__c, NbCourriersEntrants__c, NbCritizr__c, NbFacebook__c, NbTwitter__c, NbFormulaireContact__c, NbEmailsEntrants__c, NbAppelsSortants__c, NbCourriersSortants__c, NbEmailsSortants__c, Motif__c from case';	
        System.debug('Start  calling');
    	return Database.getQueryLocator(query); 
    }    
    
    
    
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){

        System.debug('Execute method start');
        List<Case> l = (List<Case>)scope;
        List<Id> li = new List<Id>();
        for(Case c : l){
         li.add(c.id);  
        }
        List<Task> camp = [SELECT WhatId,Origine__c from Task WHERE WhatId in: li];

         for (Task t : camp){ 
            for(Case c : l){
             	
                if(c.id  == t.WhatId){
                  
                    if(t.Origine__c == 'Facebook'){
                        c.NbFacebook__c = 0; }
                    
                    else{if(t.Origine__c == 'Twitter'){
                        c.NbTwitter__c = 0; }
                    
                    else{if(t.Origine__c == 'Critizr'){
						c.NbCritizr__c = 0;}}}
                    
                    	if(t.Origine__c == 'Appel entrant'){
                        c.NbAppelsEntrants__c = 0; }
                    
                    else{if(t.Origine__c == 'Courrier entrant'){
                        c.NbCourriersEntrants__c = 0; }
                    
                    else{if(t.Origine__c == 'Email entrant'){
						c.NbEmailsEntrants__c = 0;}
                    
                    else{if(t.Origine__c == 'Formulaire de contact'){
                        c.NbFormulaireContact__c = 0;}}}}
                    
                     if(t.Origine__c == 'Appel sortant'){
                        c.NbAppelsSortants__c = 0; }
                    
                    else{if(t.Origine__c == 'Courrier sortant'){
                        c.NbCourriersSortants__c =0; }
                    
                    else{if(t.Origine__c == 'Email sortant'){
						c.NbEmailsSortants__c = 0;}}}}

                    
                } 
            }
        
        	update l;
        
        for (Task t : camp){ 
            for(Case c : l){
             	
                if(c.id  == t.WhatId){
                    
                     if(t.Origine__c == 'Facebook'){
                        c.NbFacebook__c = Integer.valueOf(c.NbFacebook__c) + 1; }
                    
                    else{if(t.Origine__c == 'Twitter'){
                        c.NbTwitter__c = Integer.valueOf(c.NbTwitter__c) + 1; }
                    
                    else{if(t.Origine__c == 'Critizr'){
						c.NbCritizr__c = Integer.valueOf(c.NbCritizr__c) + 1;}}}
                  
                    	if(t.Origine__c == 'Appel entrant'){
                        c.NbAppelsEntrants__c = Integer.valueOf(c.NbAppelsEntrants__c) + 1; }
                    
                    else{if(t.Origine__c == 'Courrier entrant'){
                        c.NbCourriersEntrants__c = Integer.valueOf(c.NbCourriersEntrants__c) + 1; }
                    
                    else{if(t.Origine__c == 'Email entrant'){
						c.NbEmailsEntrants__c = Integer.valueOf(c.NbEmailsEntrants__c) + 1;}
                    
                    else{if(t.Origine__c == 'Formulaire de contact'){
                        c.NbFormulaireContact__c = Integer.valueOf(c.NbFormulaireContact__c) + 1;}}}}
                    
                    if(t.Origine__c == 'Appel sortant'){
                        c.NbAppelsSortants__c = Integer.valueOf(c.NbAppelsSortants__c) + 1; }
                    
                    else{if(t.Origine__c == 'Courrier sortant'){
                        c.NbCourriersSortants__c = Integer.valueOf(c.NbCourriersSortants__c) + 1; }
                    
                    else{if(t.Origine__c == 'Email sortant'){
						c.NbEmailsSortants__c = Integer.valueOf(c.NbEmailsSortants__c) + 1;}}}}
                } 
            }
  
  		update l;
        
     
    }
    
    global void finish(Database.BatchableContext BC){
    	System.debug('number of fails');

    }
    
}