public without sharing class SM003_Retention {
    
    public static void retention(String caseId){
        System.debug('##MNE SM003_Retention retention caseId >> ' + caseId);
        
        if(caseId == null){
            throw new MyException('No Id Case found for Retention');
        }
        Case c = [SELECT Id, Status, DateDemande__c, AccountId, Offre_de_r_tention__c, Mois_de_d_but_remise__c, Raison_de_d_sabonnement__c, Type_de_d_sabonnement__c, R_sultat_R_tention__c, Date_fin_engagement__c FROM Case WHERE Id =:caseId].get(0);
        
        if((c.Offre_de_r_tention__c == null   || c.Offre_de_r_tention__c == '')
        || (c.Raison_de_d_sabonnement__c == null   || c.Raison_de_d_sabonnement__c == '')
        || (c.R_sultat_R_tention__c == null || c.R_sultat_R_tention__c == '') ){
            System.debug('##MNE SM003_Retention retention field empty >> "Offre de rétention", "Raison de désabonnement" et "Résultat Rétention"');
            throw new MyException('Merci de renseigner les champ : "Offre de rétention", "Raison de désabonnement" et "Résultat Rétention"');
        }
        
        if(c.Offre_de_r_tention__c == 'Hausse tarifaire'){
            System.debug('##MNE SM003_Retention retention Offre de rétention "Hausse tarifaire" choisi');
            throw new MyException('Poduit non fonctionnel : "Hausse tarifaire"');
        }
        
        if(c.R_sultat_R_tention__c != null && (c.R_sultat_R_tention__c == 'Refuse sans desabonnement' || c.R_sultat_R_tention__c == 'Client indécis') ){
            c.Status = 'EnCours';
            update c;
            System.debug('##MNE SM003_Retention retention case closed EnCours');
            return;
        } else if(c.R_sultat_R_tention__c != null && c.R_sultat_R_tention__c == 'Accepté'){
            System.debug('##MNE SM003_Retention retention go to rentention in zuora');
            executeRetention(c);
            c.Status = 'EnCours';
            update c;
        } else if(c.R_sultat_R_tention__c != null && c.R_sultat_R_tention__c == 'Refuse avec desabonnement'){
            System.debug('##MNE SM003_Retention retention go to desabonnement');
            SM_Desabonnement.desabonner(c.Id);
            c.Status = 'EnCours';
            update c;
        }
    }
    
    public static void executeRetention(Case c){
        system.debug('##MNE SM003_Retention executeRetention case >> '+c);
        
        //mois obligatoir si l'offre proposé != Points fidélité && != Hausse tarifaire
        if( (c.Mois_de_d_but_remise__c == null || c.Mois_de_d_but_remise__c == '') 
        &&  (c.Offre_de_r_tention__c != 'Points fidélité' && c.Offre_de_r_tention__c != 'Hausse tarifaire') ){
            system.debug('##MNE SM003_Retention executeRetention field empty >> "Mois de début remise"');
            throw new MyException('Merci de renseigner le champ : "Mois de début remise"');
        }
        
        Id accId = c.AccountId;
        list<Zuora__Subscription__c> listSub = new list<Zuora__Subscription__c>([SELECT Zuora__External_Id__c, Zuora__Account__r.ProduitUGC__c, Zuora__Account__r.CodePays__c, TypeContrat__c FROM Zuora__Subscription__c WHERE Zuora__Account__c =:accId AND Zuora__Status__c = 'Active' ORDER BY CreatedDate DESC NULLS FIRST LIMIT 1]);
        
        if(listSub.size() == 0){
            system.debug('##MNE SM003_Retention executeRetention Pas de souscription trouvée.');
            throw new MyException('Pas de souscription trouvée.');
        }
        
        Zuora__Subscription__c sub = listSub.get(0);
        
        if(sub.TypeContrat__c == 'CDD'){
            system.debug('##MNE SM003_Retention executeRetention Pas possible pour CDD.');
            throw new MyException('La rétention n\'est pas possible pour un utilisateur en CDD.');
        }
        
        String zuoraSubId = listSub.get(0).Zuora__External_Id__c;
        String zEntityId = WS001_CallZuora.getZuoraEntityId(listSub.get(0).Zuora__Account__r.CodePays__c);
        String ProductRatePlanId;
        String ProductRatePlanChargeId;
        //SM001_GesteCommercial.Body res = new SM001_GesteCommercial.Body();
        list<SM001_GesteCommercial.Amendment> listAmendment = new list<SM001_GesteCommercial.Amendment>();
        
        if(c.Offre_de_r_tention__c != 'Points fidélité'){
        //if(c.Offre_de_r_tention__c != 'Points fidélité' && c.Offre_de_r_tention__c != 'Hausse tarifaire'){
            
            String prefixe = '';
            if(listSub.get(0).Zuora__Account__r.CodePays__c == '033'){
                prefixe = 'FR';
            }else if(listSub.get(0).Zuora__Account__r.CodePays__c == '032'){
                prefixe = 'BE';
            }
            
            String productRatePlanReference = prefixe + c.Offre_de_r_tention__c;
            list<ProdRatePlanCharge__c> listProdRatePlanCharge = new list<ProdRatePlanCharge__c>([SELECT Reference__c, zid__c, ProdRatePlan__r.zid__c FROM ProdRatePlanCharge__c WHERE Reference__c = :productRatePlanReference]);
            if(listProdRatePlanCharge.size() == 0){
                system.debug('##MNE SM003_Retention executeRetention Pas de Product Rate Plan Charge trouvée pour la remise de rétention');
                throw new MyException('Pas de Product Rate Plan Charge trouvée pour la remise de rétention.');
            }
            
            ProdRatePlanCharge__c prodRatePlanCharge = listProdRatePlanCharge.get(0);
            ProductRatePlanId = prodRatePlanCharge.ProdRatePlan__r.zid__c;
            ProductRatePlanChargeId = prodRatePlanCharge.zid__c;
            
            Integer moisDebutRemise = Integer.valueOf(c.Mois_de_d_but_remise__c);
            Date dateDebutRemise = SM_Demande.getRemiseDate(moisDebutRemise);
            
            system.debug('##MNE SM003_Retention executeRetention dateDebutRemise >> '+dateDebutRemise);
            
            //add product remise
            SM001_GesteCommercial.Amendment addPr = new SM001_GesteCommercial.Amendment(zuoraSubId, ProductRatePlanId, ProductRatePlanChargeId, dateDebutRemise);
            //res.requests.get(0).Amendments.add(addPr);
            listAmendment.add(addPr);
        }
        
        //Renew
        Date contractEffectiveDate;
        Date termStartDate;
        if(c.Date_fin_engagement__c >= Date.today() ){
            contractEffectiveDate = c.Date_fin_engagement__c;
            termStartDate = c.Date_fin_engagement__c;
        } else {
            contractEffectiveDate = Date.today();
            termStartDate = Date.today();
        }
        //SM001_GesteCommercial.Amendment renew = new SM001_GesteCommercial.Amendment(zuoraSubId);
        SM001_GesteCommercial.Amendment renew = new SM001_GesteCommercial.Amendment(zuoraSubId, contractEffectiveDate, termStartDate);
        //res.requests.get(0).Amendments.add(renew);
        listAmendment.add(0,renew);
        
        
        
        
        
        /*String inBody = JSON.serialize(res);
        inBody = inBody.replace('null','""');
        System.debug('##MNE SM003_Retention executeRetention inBody >> '+inBody);
        
        String repWS = SM001_GesteCommercial.sendAmendRequest(inBody, zEntityId);
        System.debug('##MNE SM003_Retention executeRetention repWS >> '+repWS);
        
        SM001_GesteCommercial.Resultat resApex =   (SM001_GesteCommercial.Resultat)System.JSON.deserialize(repWS, SM001_GesteCommercial.Resultat.class);
        System.debug('##MNE SM003_Retention executeRetention resApex >> '+resApex);
        
        Boolean success = true;
        String messageError = '';
        if(resApex != null && resApex.results != null  && resApex.results.size() > 0){
            for(SM001_GesteCommercial.Result r : resApex.results){
                if(!r.Success){
                    if(r.Errors != null && r.Errors.size() > 0){
                        throw new MyException(r.Errors.get(0).Message);
                    }
                }
            }
        }*/
        
        
        
        ////
        for(SM001_GesteCommercial.Amendment amend : listAmendment){
            SM001_GesteCommercial.Body res = new SM001_GesteCommercial.Body();
            res.requests.get(0).Amendments.add(amend);
            String inBody = JSON.serialize(res);
            inBody = inBody.replace('null','""');
            System.debug('##MNE SM003_Retention executeRetention inBody >> '+inBody);
            
            String repWS = SM001_GesteCommercial.sendAmendRequest(inBody, zEntityId);
            System.debug('##MNE SM003_Retention executeRetention repWS >> '+repWS);
            
            SM001_GesteCommercial.Resultat resApex =   (SM001_GesteCommercial.Resultat)System.JSON.deserialize(repWS, SM001_GesteCommercial.Resultat.class);
            System.debug('##MNE SM003_Retention executeRetention resApex >> '+resApex);
            
            Boolean success = true;
            String messageError = '';
            if(resApex != null && resApex.results != null  && resApex.results.size() > 0){
                for(SM001_GesteCommercial.Result r : resApex.results){
                    if(!r.Success){
                        if(r.Errors != null && r.Errors.size() > 0){
                            throw new MyException(r.Errors.get(0).Message);
                        }
                    }
                }
            }
        }
        
        
        
        
        
        
     }
     
    private class MyException extends Exception {
    }

}