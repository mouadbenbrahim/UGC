trigger UpdateAccountReaboTrigger on Zuora__Subscription__c (After update, After insert ) {
    
    //Remontée du Code Fin de contrat et détermination du flag Réabonnement sur l'Account à partir des souscriptions de l'Account
    //RG1: Copier le Code Fin de contrat de la souscription dont la date de début de contrat est la plus récente et inférieure ou égale à aujourd'hui
    //RG2: Détérminer l'éligibilité du réabonnement sur l'Account à partir de la souscription en question : Flag Réabo = True si la date de fin de contrat + latence 1 mois est supérieure ou égale à aujourd'hui
    //	   Sinon False
/*  
    List<Account> accListToUpdate = New List<Account>();
    
    For(Zuora__Subscription__c sub : Trigger.New) {
            Boolean processTrigger = false;
            System.debug('Log Reabo Type: IsUpdate='+Trigger.IsUpdate+' IsInsert='+Trigger.IsInsert+ 'AccountId='+sub.Zuora__Account__c+' Date Debut='+sub.Date_de_debut_de_contrat__c);
            //si cas update et date debut de contrat not null et CodeFinContrat modifié => processTrigger= true
            if(Trigger.IsUpdate && sub.Date_de_debut_de_contrat__c != null){
            	if(sub.CodeFinContrat__c != Trigger.oldMap.get(sub.id).CodeFinContrat__c){
                	processTrigger= true; 
            	}       
            }
            
            //si cas insert et date debut de contrat not null => processTrigger= true
            if(Trigger.IsInsert && sub.Date_de_debut_de_contrat__c != null){
            	processTrigger= true;
            }
            
            if (processTrigger) {
                //Récupération de la souscription avec la date de début de contrat la plus récente de l'account
                List<Zuora__Subscription__c> sublist = [Select Name, Id, CodeFinContrat__c, Date_de_fin_de_contrat__c,Date_de_debut_de_contrat__c FROM Zuora__Subscription__c WHERE Zuora__Account__c =:sub.Zuora__Account__c and Date_de_debut_de_contrat__c<=TODAY ORDER BY Date_de_debut_de_contrat__c DESC LIMIT 1];
                if (sublist.size() > 0) {
                    Zuora__Subscription__c subchild = sublist[0];
                    Date latenceDate;
                    Boolean reaboFlag = false;
                    System.debug('Log Reabo Debut:'+subchild.Date_de_debut_de_contrat__c);
                    if(subchild.Date_de_fin_de_contrat__c!=null) {
                        //Calcul de la date de fin de contrat avec la latence d'un mois : Condition permettant d'avoir une date au dernier jour du mois si la date d'origine correspond au dernier jour du mois.
                        If(subchild.Date_de_fin_de_contrat__c==subchild.Date_de_fin_de_contrat__c.addMonths(1).toStartofMonth().addDays(-1)) {
                            latenceDate = subchild.Date_de_fin_de_contrat__c.addMonths(2).toStartofMonth().addDays(-1);
                        }
                        else{
                            latenceDate = subchild.Date_de_fin_de_contrat__c.addMonths(1);
                        }
                        if(Date.today()<=latenceDate)
                        reaboFlag = true;
                    }
                    
                    System.debug('Log Reabo:'+subchild.Name);
                    System.debug('Log Reabo:'+subchild.Date_de_fin_de_contrat__c);
                    System.debug('Log Reabo:'+latenceDate);  
                    System.debug('Log Reabo:'+reaboFlag);      
                    
                    List<Account> Acc = [Select Id, CodeFinContrat__c, 	Eligibilite_Reabo__c FROM Account WHERE Id =:sub.Zuora__Account__c];
                          
                    For(Account EveryAcc : Acc) {
                        EveryAcc.CodeFinContrat__c = subchild.CodeFinContrat__c;
                        EveryAcc.Eligibilite_Reabo__c = reaboFlag;
                        accListToUpdate.add(EveryAcc);
                    }
                    
                    system.debug('##MNE UpdateAccountReaboTrigger accListToUpdate >> '+accListToUpdate);
            	                    
                    If(accListToUpdate.Size() > 0){
                        update accListToUpdate;
                    }
                }
            }
        }
*/        
    }