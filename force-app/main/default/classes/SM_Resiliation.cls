/**
 * Created by mouad on 03/09/2018.
 */

public with sharing class SM_Resiliation {


    //Constructor
    //public SM_Desabonnement(){}
    public static Case dem = new Case();
    public static Zuora__Subscription__c sub = new Zuora__Subscription__c();
    public static Account acc = new Account();
    
    
    
    public static void resiliation(Id ddeId) {
        if(ddeId == null){
            throw new MyException('No Id Case found for Retractation');
        }
        Case c = [SELECT Id, Motif_de_R_siliation__c, Date_de_R_siliation__c FROM Case WHERE Id =:ddeId].get(0);
        
        if(String.isBlank(c.Motif_de_R_siliation__c)   || c.Date_de_R_siliation__c == null){
            throw new MyException('Veuillez renseigner les champs : "Motif de Résiliation" et "Date de Résiliation"');
        }
        SM_Desabonnement.desabonner(ddeId);
    }


/*    public static void resilier(Id ddeId) {
        //TODO gestion de la reprise sur erreur: savepoint.
        //TODO SFDC: on save: Date fin contrat = date du jour (pour ce sous Fam,motif,sous-motif)

        String policy = 'SpecificDate';
        String codeDesaCarte = null;
        String operation = 'resiliation';
        Id remboursementId = null;
        Case dem2 = new Case(); // objects to update
        Account acc2 = new Account();

        // Initialisation du contexte: dem: (demande)
        dem = SM_Demande.getDemande(ddeId);

        // Initialisation du contexte: sub: (souscription)
        if (dem.Subscription__c == null) {
            throw new MyException('Abonnement absent de la demande: pas dabo, plusieurs ou inactif');
        } else {
            Id subId = dem.Subscription__c;
        }
        sub = SM_Subscription.getSubscription(dem.Subscription__c);

        //Verifications
        preVerification();

        //Call WS Zuora: Cancel subscription
        WSZ.SubCancelOut rCancel = SM_Subscription.cancelSub(Util.zDate(dem.DateFinContrat__c), policy, sub.Zuora__Zuora_Id__c,false,''); //TODO a corriger les input params
        Id newSubId = rCancel.subscriptionId;

        System.debug((String) JSON.serialize(rCancel));

        // Mise a jour de la souscription dans Zuora
        //TODO: Mettre a jour le CodeFinContrat en fonction du SousMotif__c
        Zuora__Subscription__c newSub = new Zuora__Subscription__c();
        //TODO :  voir une fois la matrice etablit si besoin d utiliser le sous motif ou Fam/Mot suffit
        //if (dem.SousMotif__c == 'Mauvais comportement') {
        //    newSub.CodeFinContrat__c='E';}
        newSub.CodeFinContrat__c='M';
        WSZ.SubOut rUpdate =  SM_Subscription.updateSub(newSubId,newSub);

        //Desactivation de la carte
        codeDesaCarte = 'M';
        //SM_Carte.carteDesactivation(codeDesaCarte);
        SM_Carte.desactivation(codeDesaCarte);


        //Creation demande de remboursement
        if (dem.RemboursementFaire__c) {
            //Calculer le montant du remboursement: optionnelle

            Case demandeRemb = new Case(SousMotif__c = 'EF-Automatique', Origin = 'Courrier', AccountId = dem.AccountId,
                    ContactId = dem.ContactId, MontantRembourser__c = 999, //TODO MontantRembourser__c a calculer si possible
                    DateDemande__c = date.today());

            //SM_Remboursement remboursement = new SM_Remboursement();
            remboursementId = SM_Demande.creerRemboursement(demandeRemb);
        }

        //Mise a jour de la demande
        dem2.DemandeRemboursement2__c = remboursementId; // maj lookup remboursement
        dem2.Status = SM_Demande.getStatus('Fermee'); // close ticket
        update dem2;

        //Mise à jour du Client
        acc2.MauvaisComportement__c = true; //TODO voir si on met à jour depuis Trigger sur souscription
        acc2.CodeFinContrat__c = 'M'; //TODO voir si on met à jour depuis Trigger sur souscription
        update acc2;

        //ClientNotification
        clientNotification();
    }


    private static void preVerification() {

        Integer preavis = Util.PREAVIS(acc.ProduitUGC__c);

        //Check demande
        if (dem.Status == SM_Demande.getStatus('Fermee')) {
            throw new MyException('Cette demande a deja ete traite');
        }

        if (dem.SousMotif__c == null) { //TODO peut etre a mettre au niveau parametrage AVOIR
            throw new MyException('Sous-Motif obligatoire');
        }

        //Check Souscription Status
        if (sub.Zuora__Status__c != 'Active') {
            throw new MyException('L abonnement n est pas actif');
        }

        //Check Date Fin contrat
        if (dem.DateFinContrat__c != date.today()) {
            throw new MyException('Date fin contrat doit etre = date du jour');
        }

        if (dem.DateFinContrat__c < dem.DateDemande__c) {
            throw new MyException('Date fin contrat doit etre >= date demande');
        }



    }
*/

    private static void clientNotification(){

    }


    private class MyException extends Exception {
    }

}