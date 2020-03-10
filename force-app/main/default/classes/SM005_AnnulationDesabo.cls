/**
 * Created by EasyFront on 20/05/2019.
 */

public without sharing class SM005_AnnulationDesabo {

    public static Case dem = new Case();
    public static Account acc = new Account();
    public static Zuora__Subscription__c sub = new Zuora__Subscription__c();
    
    public static ProcessLog__c pLog;
    public static zc_GETSubscriptionTypeWithSuccess subZdoc;
    public static zc_ProxyGetPaymentMethod pm;
    private static List<BillingOperation__c> billOpes = new List<BillingOperation__c>();
    private static String paysLibelle;


    public static void AnnulerDesabo(Id ddeId) {        

        

        try {
            

        //WSZ.GenericEmptyFields subEmpty = new WSZ.GenericEmptyFields();
        //subEmpty.fieldsToNull = new List<String>{'DateFinContrat__c','CodeFinContrat__c','CancelCaseID__c'};

        /** Initialisation du contexte: dem: (demande), Account */
        //setDem(ddeId);
        dem = SM_Demande.getDemande(ddeId);
        acc = SM_Account.getAccount(dem.AccountId);

        paysLibelle = Util.paysLibelle(acc.CodePays__c);
        
        //sub = SM_Subscription.getSubscription(lastSubscription[0].Id);
        sub = SM_Subscription.getActiveSubscriptionByNameORAccId(dem.SubscriptionZName__c, dem.AccountId);
        
        verifAnnulerDesabo();
        
        String recordTypeName = Schema.SObjectType.Case.getRecordTypeInfosById().get(dem.RecordTypeId).getname();
        String process = recordTypeName + '_AnnulerDesabo';
        pLog = new ProcessLog__c(Process__c = process, Account__c = dem.AccountId, SubscriptionName__c = dem.SubscriptionZName__c, Case__c = ddeId);
        

        /** Annuler desabonnement */
        String zEntityId = WS001_CallZuora.getZuoraEntityId(acc.CodePays__c);
        zc_ProxyActionupdateRequest reqObj = new zc_ProxyActionupdateRequest();
        zc_ZObjectUpdate zObj = new zc_ZObjectUpdate();
        reqObj.r_type = 'Subscription';
        reqObj.objects.add(zObj);
        String accessToken = WS001_CallZuora.access_token;


        if (sub.Zuora__Status__c == 'Active') { //contrat en desabo futur

            zObj.id = sub.Zuora__External_Id__c;
            if (sub.TypeContrat__c == 'CDD'){ 
                zObj.fieldsToNull = new List<String>{'CodeFinContrat__c','CancelCaseID__c'};
                zObj.dateFinContrat = sub.Zuora__SubscriptionEndDate__c.addDays(-1); //remettre la date fin standard du CDD
            }else { //CDI
                zObj.fieldsToNull = new List<String>{'DateFinContrat__c','CodeFinContrat__c','CancelCaseID__c'};
            }
            
            zc_ProxySaveResult resObj1 = zc_Api.actionUpdatePOST(accessToken, zEntityId, reqObj, RTExceptionCode.ERREUR_ANNUL_DESABO_UPDATE_SUB, pLog);

        }else {   // contract cancelled (que les CDIs)                
            //get amend informations before delete
            zc_GETAmendmentType amendRes = zc_Api.amendSubscriptionGET(accessToken, zEntityId, sub.Zuora__External_Id__c, RTExceptionCode.ERREUR_IMPAYE_REGLER_PROBLEM_PREVIEW, pLog);
            //zc_ProxyGetAmendment amendRes2 = zc_Api.objectAmendGET(accessToken, zEntityId, amendRes.id, RTExceptionCode.ERREUR_IMPAYE_REGLER_PROBLEM_PREVIEW, pLog); 
            
            // Suppression de la derniere subscription
            zc_SaveResult resObj2 = zc_Api.objectSubscriptionDELETE(accessToken, zEntityId, sub.Zuora__External_Id__c, RTExceptionCode.ERREUR_ANNUL_DESABO_DELETE_SUB, pLog);

            //TODO TRACKING AMEND
            //SM_Hermes.trackOperation('SUPPRESSION', Datetime.now(), 'Reactivation', 'DeleteCancel', amendRes.id, sub.Zuora__External_Id__c, sub.Name, acc.CodePays__c);
            billOpes.add(new BillingOperation__c(Action__c = 'SUPPRESSION', DateOperation__c = Datetime.now(), Operation__c='Reactivation', Zoperation__c = 'DeleteCancel', 
            AmendZID__c= amendRes.id, SubscriptionZID__c = sub.Zuora__External_Id__c, SubscriptionName__c = sub.Name, Pays__c=paysLibelle));


            // mise a jour subscription
            zObj.id = sub.Zuora__PreviousSubscriptionId__c;
            zObj.fieldsToNull = new List<String>{'DateFinContrat__c','CodeFinContrat__c','CancelCaseID__c'};
            zc_ProxySaveResult resObj3 = zc_Api.actionUpdatePOST(accessToken, zEntityId, reqObj, RTExceptionCode.ERREUR_ANNUL_DESABO_UPDATE_SUB2, pLog);
        }
        
        //Debut call out pour ZDOC
        
        // Get Zuora Data (subscription)
        subZdoc = zc_Api.subscriptionGET(accessToken, zEntityId, zObj.id, RTExceptionCode.ERREUR_ACQUISIT_GET_ZSUBSCRIPTION, pLog);
        // Get Zuora Data (Account)
        zc_ProxyGetAccount zacc = zc_Api.objectAccountGET(accessToken, zEntityId, sub.Zuora__CustomerAccount__r.Zuora__External_Id__c, RTExceptionCode.ERREUR_ACQUISIT_GET_ACCOUNT, pLog);
        String payMethodId = zacc.defaultPaymentMethodId;
        // Get Zuora Data (PaymentMethod)
        pm = zc_Api.objectPaymentMethodGET(accessToken, zEntityId, payMethodId, RTExceptionCode.ERREUR_ACQUISIT_GET_PAYMENTMETHOD, pLog);
        //Fin call out pour ZDOC

        SM_Carte.activation(dem.AccountId);

        /** cloture de la demande */ 
        Id zDocId = SM_Hermes.addZdocData(new Map<String,Object>{'ZSUB' => subZdoc,'ZPM' => pm,'ACC' => acc});
        dem.ZDocData__c = zDocId;       
        dem.Status = 'Fermee';       
        update dem;
        SM_SDoc.makeSdocJobs(new list<Case>{dem});

        } catch (RTException rte){
            throw rte;
        } catch (Exception e) {
            throw e;
        } finally {
            if (billOpes.size() > 0) insert billOpes;   
        }

        
    }
    
    private static void verifAnnulerDesabo() {

        Date dateLatence;

        if (sub == null) {
            throw new RTException(RTExceptionCode.ERREUR_ANNUL_DESABO_AUCUN_CONTRAT_TROUVE);
        }

        if (dem.Status == SM_Demande.getStatus('Fermee')) {
            throw new MyException('Cette demande a deja ete traite');
        }

        if (dem.SousMotif__c == null) {
            throw new MyException('Sous-Motif obligatoire');
        }
        
        // if(sub.Zuora__PreviousSubscriptionId__c == sub.Zuora__External_Id__c){
        //  throw new MyException('La souscription est l\'original, elle ne possède aucun desabonnement.');
        // }
        
        if(sub.Zuora__CustomerAccount__r.Zuora__Balance__c != 0){
            throw new MyException('La balance du compte zuora n\'est pas à 0');
        }
        
        if(sub.Tech_AvecRembouesement__c == 'true'){
            throw new MyException('Cet amend est suivie par un besoins de remboursement ou de payment');
        }


        if (sub.DateFinContrat__c == null) {
            throw new RTException(RTExceptionCode.ERREUR_ANNUL_DESABO_DATEFINCONTRAT_VIDE);
        }

        //Verifier si on a depasse le mois de latence et le statut du contrat
        Integer periodeLatence = Integer.valueOf(Utils.getUgcGenericParam('Periode de latence',acc.CodePays__c).ParamValue__c);

        // calcul dateLatence
        if (sub.Zuora__Status__c == 'Active' && sub.DateFinContrat__c != null){ //contrat en futur Cancel
            dateLatence = sub.DateFinContrat__c.addMonths(periodeLatence);
        }else if (sub.Zuora__Status__c == 'Cancelled') { // contrat deja cancelled
            dateLatence = sub.Zuora__CancelledDate__c.addMonths(periodeLatence);            
        }
        System.debug('MBEN dateLatence: ' + dateLatence);



        if (sub.Zuora__Status__c == 'Active') {
            if (sub.TypeContrat__c == 'CDI') {
            // continue
            }else if (sub.TypeContrat__c == 'CDD'){                
                // if (sub.DateFinContrat__c.addDays(1) == sub.Zuora__SubscriptionEndDate__c){ //aucun desabo n existe sur ce contrat 
                if (sub.CodeFinContrat__c == null){
                    throw new RTException(RTExceptionCode.ERREUR_ANNUL_DESABO_CONTRAT_DEJA_ACTIF);
                }else {
                // continue
                }
            }                                                     
        }else if (sub.Zuora__Status__c == 'Cancelled') {
            if (sub.TypeContrat__c == 'CDI'){
                if (Date.today() >= dateLatence){
                    throw new RTException(RTExceptionCode.ERREUR_ANNUL_DESABO_PERIODLATENCE_DEPASSE);
                }
            }else if (sub.TypeContrat__c == 'CDD'){
                // en premier annes: NON
                // CDD aterme: NON
                throw new RTException(RTExceptionCode.ERREUR_ANNUL_DESABO_CDD_DEJA_INACTIF);
            }                
        }else {
            throw new RTException(RTExceptionCode.ERREUR_ANNUL_DESABO_STATUT_CONTRAT_NON_VALIDE);
        }        
    }
    
    

    
    private class MyException extends Exception {
    }
    
    
}