public without sharing class LCC003_Dispatcher {

    @AuraEnabled
    public static MSGRep initApexMethod(Id currentId, String otherVar, String bttnOperation, Boolean confirmationAction){
        MSGRep rep = new MSGRep();
        System.debug('##MBEN LCC003_Dispatcher initApexMethod currentId: ' + currentId);
        System.debug('##MBEN LCC003_Dispatcher initApexMethod otherVar: ' + otherVar);
        System.debug('##MBEN LCC003_Dispatcher initApexMethod bttnOperation: ' + bttnOperation);
        System.debug('##MBEN LCC003_Dispatcher initApexMethod confirmationAction: ' + confirmationAction);
        
        Case caseToUpdate = new Case();
 
        // Case demande = getCase(currentId);
        if((bttnOperation == 'Anonymisation' || bttnOperation == 'AnonymisationAbonne') && !confirmationAction){
            return rep;
        }

        try{
            switch on bttnOperation {
                when 'Desabonnement' {
                    SM_Desabonnement.desabonner(currentId,false);
                }
                when 'Resiliation' {
                    SM_Resiliation.resiliation(currentId);
                    caseToUpdate.Id = currentId;
					caseToUpdate.Status = 'Fermee';
                }
                when 'getAccount' {
                    SM_Subscription subscription = new SM_Subscription();
                    //subscription.getAccount();
                }
                when 'Anonymisation' {
                    rep = SM002_Anonymisation.accountAnonymisationFromQuickAction(currentId, SM002_Anonymisation.AnonymisationType.ALL);
                }
                when 'RefreshContraintes' {
                    SM_Offre.refreshContraintes2(currentId);
                }
                when 'GenerateCouponItems' {
                    SM_Coupon.generateCouponItems(currentId);
                }
                when 'SyncProduct' {
                    SM_Product.sync();
                }
                when 'Retention' {
                    //TO do :
                    //partie Offre de rétention = "hausse tarifaire" => uniquement renouvellement de sub fait
                    // partie envoie de courrier
                    system.debug('##MNE LCC003_Dispatcher initApexMethod process >> Retention');
                    SM003_Retention.retention(currentId);
                }
                when 'AjoutLieux' {
                    SM_Offre.ajoutLieuAll(currentId);
                }
                when 'Retractation' {
                    SM_Retractation.retractation(currentId);
                }
                when 'AnnulationDemande' {
                     SM_Desabonnement.desabonner(currentId,false);
                }
                when 'AnonymisationAbonne' {
                     rep = SM002_Anonymisation.accountAnonymisationFromQuickAction(currentId, SM002_Anonymisation.AnonymisationType.ONLY_ZUORA);
                }
                when 'Remboursement' {
                     SM_Remboursement.Remboursement(currentId); 
                }
                when 'AnnulationDesabo' {
                     SM005_AnnulationDesabo.AnnulerDesabo(currentId); 
                }
                /*when 'RejetBRED' {
                     SM_Rejet.traiterFichier(currentId);  
                }*/
                when 'RejetBRED_Parser_STEP1' {
                     SM_Rejet.traiterFichier(currentId);  
                }
                when 'RejetBRED_Traiter_STEP2' {
                     SM_Rejet.getZSubRejetBredStep2(currentId);  
                }
                when 'GesteCommercial' {
                     LCC006_GesteCommercial.executeGesteCommercial(currentId);  
                }
                when 'DesactiverCarte' {
                    SM_Carte.desactivationFromCard(currentId, null);
                }
                when 'ActiverCarte' {
                	SM_Carte.activationFromCard(currentId);
                }
                when else {
                    System.debug('##MBEN : aucune operation n est transmise');
                }
            }
        }catch(Exception e){
            rep.showMessage = true;
            rep.messageToDisplay = e.getMessage();
            rep.isError = true;
            System.debug('##MNE LCC003_Dispatcher initApexMethod exception getMessage >> '+e.getMessage());
            System.debug('##MNE LCC003_Dispatcher initApexMethod exception getStackTraceString >> '+e.getStackTraceString());
            System.debug('##MNE LCC003_Dispatcher initApexMethod exception getTypeName >> ' + e.getTypeName());   
            System.debug('##MNE LCC003_Dispatcher initApexMethod exception getCause >> ' + e.getCause()); 
            System.debug('##MNE LCC003_Dispatcher initApexMethod exception getLineNumber >> ' + e.getLineNumber());  
            if(currentId.getSObjectType() == Schema.Case.SObjectType){
                Datetime dNow = Datetime.now();
                caseToUpdate.Id = currentId;
                String sDate = String.valueOf(dNow);
                String current_ExecMessage = [Select ExecMessage__c from Case where Id=:currentId].ExecMessage__c;
                String fullMessage = e.getMessage() + e.getStackTraceString() + e.getTypeName() + e.getCause() + e.getLineNumber();
                caseToUpdate.ExecMessage__c = sDate + fullMessage + '\n' + current_ExecMessage;
                caseToUpdate.ExecStatus__c = 'Erreur';
                caseToUpdate.ExecDate__c = dNow;
                update caseToUpdate;
            }
            return rep;
        }
        
        if(currentId.getSObjectType() == Schema.Case.SObjectType && currentId != null){
            Datetime dNow = Datetime.now();
            caseToUpdate.Id = currentId;
			caseToUpdate.ExecStatus__c = 'Success';
            caseToUpdate.ExecDate__c = dNow;
            caseToUpdate.ExecSuccessDate__c = dNow;
            update caseToUpdate;
		}

        return rep;

    }

    public static Case getCase(Id rId){
        return [SELECT Id, Status, DateDemandeAnnulation__c FROM Case
        WHERE Id = :rId ];
    }


    public without sharing class MSGRep {
        @AuraEnabled public Boolean showMessage                         { get; set; }
        @AuraEnabled public String  messageToDisplay                    { get; set; }
        @AuraEnabled public Boolean isWarning                           { get; set; }
        @AuraEnabled public Boolean isError                             { get; set; }
        @AuraEnabled public Boolean isInfo                              { get; set; }

        public MSGRep() {
            this.showMessage            = false;
            this.messageToDisplay       = '';
            this.isWarning              = false;
            this.isError                = false;
            this.isInfo                 = false;
        }
    }
}