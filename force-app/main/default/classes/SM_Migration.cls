public with sharing class SM_Migration {

    //TODO OK: batch de cancel des anciens contrats: on utilise le meme batch de desabo: OK
    //TODO OK: batch d'activation des nouveaux contrats: workflow zuora: OK 
    
    public final static Set<String> FAMILLE_REMISES = new Set<String>{'REMFRAIDOSS', 'REMMENS', 'REMMONT'};
    public static String accessToken, zEntityId, codePays;
    
    public SM_Migration() {
    
    }
    
    public static Map<String,Object> migration(WSZ.SubOpeIn migIn, Boolean isPreview){
    
        Map<String,Object> returnObj = new Map<String,Object>();
        
        
        ProcessLog__c pLog = new ProcessLog__c(Process__c = 'migration', Account__c = migIn.accountSFID, SubscriptionName__c = migIn.subscriptionName ,Message__c = '');
            
  
        //FOR ROLLBACK : Input for rollback
        StepEnum ProcessStep;
        Map<String,List<Map<String,Object>>> mapRollBackProcess = new Map<String,List<Map<String,Object>>>();
        Boolean isDMLoperation = false;
        
        try{    
            
            String invoiceFileUrl, creditMemoId, currentSubId,typeDeMigration,elecPayMethodId, extPaymentMethodId;
            String fileImpId,payMethodId, invoiceId,caseId,cancelCaseId;
            List<String> paymentIds = new List<String>();
            Boolean compteBloque = false;
            Boolean rembourser = false;
            String intituleOffreFR,intituleOffreNL;
            Date dateDebutContrat,dateFinContrat;
            
            WSZ.Preview previewOut = new WSZ.Preview();
            WSZ.SubOpeOut migOut = new WSZ.SubOpeOut();
            Boolean isB2B;
            zc_ZObjectUpdate zObj;
            List<String> sDocjobIds = new List<String>{'idjob1','idjob2'};
            Map<String,WSZ.Paiement> mapPaiements;
            Map<String,WSZ.Paiement> mapPaiements2;
            
        
            String migInStr = JSON.serialize(migIn);
            pLog.Message__c = migInStr;
            String produit = migIn.produit; // migIn.produit.get(0);
            String typeContrat = produit.contains('CDI')?'CDI':'CDD';
            //Boolean isFutur = (migIn.dateDebutContrat == Date.today())?false:true;
            Boolean isNewMandate = (migIn.mandateId != null && migIn.iban != null);
        
        
            //###### get SF_AccountData SF_sub Data ######
            Account porteur = SM_Account.getAccountData(migIn.accountSFID);
            Account payeur = SM_Account.getAccountData(migIn.payeurSFID);
            Zuora__Subscription__c sub = SM_Subscription.getSubscriptionBySetName(new Set<String>{migIn.subscriptionName}).get(0);
            //currentSubId = sub.Zuora__External_Id__c;
            String originalSubId = sub.Zuora__External_Id__c;
            String accountZID = sub.Zuora__CustomerAccount__r.Zuora__External_Id__c;
            String typeContratActuel = sub.TypeContrat__c;
            String typeMigration = typeContratActuel+'-'+typeContrat;
            Boolean generateInvoice;
            codePays = porteur.CodePays__c;
            //String subscriptionName = sub.Name;
        
            // ###### check/calcul:
            // TODO: Abandoner: contrat actif , datedujour <= datefincontrat: c'est le mecanisme des autorisation qui doit le faire ou reutiliser le code.
        
            // calcul dateDebutContrat
            if (typeMigration == 'CDI-CDI') {
                dateFinContrat = Util.endOfMonth(Date.today());
                dateDebutContrat = Util.firstOfNextMonth(Date.today());
                generateInvoice = false;
            }else if (typeMigration == 'CDI-CDD'){ 
                dateFinContrat = Util.endOfMonth(Date.today());
                dateDebutContrat = Util.firstOfNextMonth(Date.today());
                generateInvoice = true;
            }else if (typeMigration == 'CDD-CDI'){ 
                    if (sub.DateFinContrat__c >= Util.endOfMonth(Date.today())) { // >= dernier jour du mois en cours
                        dateFinContrat = Util.endOfMonth(Date.today()); // le contrat se termine en avance
                        dateDebutContrat = Util.firstOfNextMonth(Date.today());
                        generateInvoice = false;
                    }else { // <= dernier  jour du mois en cours
                        dateFinContrat = sub.DateFinContrat__c; // le contrat se terminera a sa date prevu
                        dateDebutContrat = sub.DateFinContrat__c.addDays(1); 
                        generateInvoice = true;
                    }        
            }else if (typeMigration == 'CDD-CDD'){
                    if (sub.DateFinContrat__c >= Util.endOfMonth(Date.today())) { // > dernier  jour du mois en cours
                        dateFinContrat = Util.endOfMonth(Date.today()); // le contrat se termine en avance
                        dateDebutContrat = Util.firstOfNextMonth(Date.today());
                        generateInvoice = true;
                    }else { // <= dernier  jour du mois en cours
                        dateFinContrat = sub.DateFinContrat__c; // le contrat se terminera a sa date prevu
                        dateDebutContrat = sub.DateFinContrat__c.addDays(1);
                        generateInvoice = true;
                    }   
            }
            migIn.dateDebutContrat = (Datetime)dateDebutContrat;
            //if (isPreview) generateInvoice = true; //overrider dans subscribeMigration
        
            //###### get subOffres ######
            Map<String,Object> offreProxyOut = SM_Offre.getOffreProxy(migIn.dateDebutContrat, migIn.lieu, migIn.agent, migIn.coupon, migIn.accountSFID, 'migration', produit, migIn.codeLangue);
            WSZ.SubProduct subOffre = (WSZ.SubProduct)offreProxyOut.get('offre');
            List<zc_AmendmentRatePlanData> subOffreRatePlans = (List<zc_AmendmentRatePlanData>)offreProxyOut.get('offreRatePlans');
        
        
            // WSZ.SubProduct subOffre = SM_Offre.getSubOffres(new WSZ.SubOffreIn(migIn.dateDebutContrat, migIn.lieu, migIn.agent, migIn.coupon,migIn.accountSFID, 'migration', produit)).get(0);
            // List<zc_AmendmentRatePlanData> subOffreRatePlans = SM_Offre.convertRatePlan(subOffre.subscribeToRatePlans);
            
            // check:
            if (migIn.codeOffreCo != null && migIn.codeOffreCo != subOffre.CodeOffreCo) {
                throw new RTException(RTExceptionCode.ERREUR_MIGRATION_COUPON_ABOTIER,pLog);
            }
        
            // get offreCo RatePlans
            List<zc_AmendmentRatePlanData> offreCoRatePlans = new List<zc_AmendmentRatePlanData>();
            if (subOffre.CodeOffreCo != null) {
                offreCoRatePlans = SM_Offre.getOffreCoRatePlans(subOffreRatePlans);
            }
        
            //token/entity
            accessToken = WS001_CallZuora.access_token;
            zEntityId = WS001_CallZuora.getZuoraEntityId(codePays);  
            
        
            if (!isPreview){
        
                //map external payments
                if (migIn.paiements.size() > 0 ){
                    mapPaiements = new Map<String,WSZ.Paiement>();
                    mapPaiements2 = new Map<String,WSZ.Paiement>();
                    //List<Paiement> paiements = migIn.paiements;
                    for (WSZ.Paiement item:migIn.paiements){
                        WSZ.Paiement pai1 = new WSZ.Paiement();
                        WSZ.Paiement pai2 = new WSZ.Paiement();
                        pai1 = item.clone();
                        pai2 = item.clone();

                        mapPaiements.put(item.refCharge,pai1);

                        if (mapPaiements2.containsKey(item.methodePaiement)) {
                            mapPaiements2.get(item.methodePaiement).montant += (Double)item.montant;
                        }else {
                            mapPaiements2.put(item.methodePaiement,pai2);
                        }
                    }
                }  
                
                //throw new MyCustomException("RBTest Migration >> Erreur Create Payment Metod");

                //###### Create Elec PaymentMethod ######
                if (isNewMandate) {         
                    zc_ProxyCreatePaymentMethod reqObj = SM_Payment.paymentMethodElec(accountZID, migIn.iban, migIn.mandateId, payeur);
                    ProcessStep = StepEnum.PreCreatePaymentMethod;
                    zc_ProxyCreateOrModifyResponse resObj = zc_Api.objectPaymentMethodPOST(accessToken, zEntityId, reqObj, RTExceptionCode.ERREUR_MIGRATION_POST_PAYMENTMETHOD, pLog);
                    ProcessStep = StepEnum.PostCreatePaymentMethod;
                                    
                    elecPayMethodId = resObj.id;

                }
                
                //FOR ROLLBACK UPDATEACTION###### GET Account Data #####
                zc_ProxyActionupdateRequest actUpdateReqRollback = null;
                List<Zuora__CustomerAccount__c> billingAccounts =new List<Zuora__CustomerAccount__c>([SELECT Id, Zuora__Batch__c, Zuora__AutoPay__c, Zuora__Default_Payment_Method__c,Zuora__Default_Payment_Method__r.Zuora__External_Id__c,Zuora__DefaultPaymentMethod__c FROM Zuora__CustomerAccount__c WHERE Zuora__Account__c = :migIn.accountSFID LIMIT 1]);
                if(billingAccounts.size()>0){
                    actUpdateReqRollback = new zc_ProxyActionupdateRequest();
                    actUpdateReqRollback.r_type = 'Account';
                    zc_ZObjectUpdate zObjRollback = new zc_ZObjectUpdate();
                    zObjRollback.id = accountZID;
                    
                    if(billingAccounts[0].Zuora__Default_Payment_Method__c!=null)
                    zObjRollback.defaultPaymentMethodId = billingAccounts[0].Zuora__Default_Payment_Method__r.Zuora__External_Id__c;
                    
                    zObjRollback.batch = billingAccounts[0].Zuora__Batch__c;
                    zObjRollback.autoPay = billingAccounts[0].Zuora__AutoPay__c;
                    actUpdateReqRollback.objects.add(zObjRollback);
                }


                //###### Update Account, DefPaymentMethod, Batch..etc ######
                zc_ProxyActionupdateRequest accUpdateReq = new zc_ProxyActionupdateRequest();
                if (typeContrat == 'CDD') extPaymentMethodId = SM_Hermes.getExtPaymentMethodId(subOffre.IsB2B, mapPaiements.get('ABO').methodePaiement, porteur.CodePays__c);
                accUpdateReq.r_type = 'Account';
                zObj = new zc_ZObjectUpdate();
                zObj.id = accountZID;
                if (typeMigration == 'CDD-CDI') {zObj.batch = 'Batch1'; zObj.autoPay = true;}
                if (typeMigration == 'CDI-CDD') {zObj.batch = 'Batch21'; zObj.autoPay = false;} 
                //TODO: OK (Autorisations) pb si 1-5 du mois, le payment run ne va pas s'executer (mauvais batch et s'il est executer le payemnt Elec ne passera pas car ce n'est plus le default)
                // -->: (1)autorisation: empecher l operation, ou bien (2)laisser le moyenpaiement SEPA pour le CDD. --> Je prefere (2): impact reporting SF.
                if (isNewMandate) { //TODO: (Hors scope) (point Hermes a valider) traiter egalement le cas ou CDI-CDI sans changement de mandat (Evol cote Hermes Lot2)
                    zObj.defaultPaymentMethodId = elecPayMethodId;
                    payMethodId = elecPayMethodId;
                }else if (extPaymentMethodId !=null ) {
                    zObj.defaultPaymentMethodId = extPaymentMethodId;
                    payMethodId = extPaymentMethodId;
                }
                //TODOFUTUR si migration BTOB subAcc.invoiceTemplateId = SM_Hermes.getInvoiceTemplateId(isB2B, acc.CodePays__c, acc.Langue_parl_e_par_le_client__c);
                accUpdateReq.objects.add(zObj);
                ProcessStep = StepEnum.PreActionUpdate;
                zc_Api.actionUpdatePOST(accessToken, zEntityId, accUpdateReq, RTExceptionCode.ERREUR_MIGRATION_UPDATEACC_DEFPAYMETHOD,pLog);                
                ProcessStep = StepEnum.PostActionUpdate;

                //FOR ROLLBACK #### UPDATE mapRollBackProcess
                if(actUpdateReqRollback!= null){
                    if(!mapRollBackProcess.containsKey('06_UPDATEACTION')){
                        mapRollBackProcess.put('06_UPDATEACTION', new list<map<String, Object>>());
                    }
                    mapRollBackProcess.get('06_UPDATEACTION').add(new map<String, Object>{
                        'ACTIONUPDATEREQUEST' 			=> actUpdateReqRollback
                    });
                }

                //ThrowError('RBTest Migration >> Erreur Update Action');
                
                //FOR ROLLBACK UPDATE ACCOUNT ###### GET Account Data #####
                Account oldpayeur = SM_Account.getAccountData(sub.PayeurCRMID__c);
                zc_PUTAccountType accUpdateReqRollback = new zc_PUTAccountType();
                accUpdateReqRollback.billToContact = new zc_PUTAccountTypeBillToContact();
                accUpdateReqRollback.billToContact.address1 = oldpayeur.NoVoie__c + ' ' + oldpayeur.TypeVoie__c + ' ' + oldpayeur.NomVoie__c;
                accUpdateReqRollback.billToContact.city = oldpayeur.Ville__r.Name;
                accUpdateReqRollback.billToContact.country = oldpayeur.Ville__r.Pays__c;
                accUpdateReqRollback.billToContact.firstName = oldpayeur.FirstName;
                accUpdateReqRollback.billToContact.lastName = oldpayeur.LastName;
                accUpdateReqRollback.billToContact.zipCode = oldpayeur.Ville__r.CodePostal__c;
                accUpdateReqRollback.billToContact.personalEmail = oldpayeur.PersonEmail;
              
                
                //###### Update Account BillToContact ###### 
                // cette api ne permet pas la maj de la defpaymentmethod, c pour ca qu'on utitlise actionUpdate aussi.
                //TODO: OK: quand on paie par CB est ce que ca change le payeur ? a quel moment on fait un update billto et update payeurcrmId dans la subscription ?
                // ou bien on met a jour les information du billTo tout le temps ? --> on ecrase tout:
                zc_PUTAccountType reqObj = new zc_PUTAccountType();
                reqObj.billToContact = new zc_PUTAccountTypeBillToContact();
                reqObj.billToContact.address1 = payeur.NoVoie__c + ' ' + payeur.TypeVoie__c + ' ' + payeur.NomVoie__c;
                reqObj.billToContact.city = payeur.Ville__r.Name;
                reqObj.billToContact.country = payeur.Ville__r.Pays__c;
                reqObj.billToContact.firstName = payeur.FirstName;
                reqObj.billToContact.lastName = payeur.LastName;
                reqObj.billToContact.zipCode = payeur.Ville__r.CodePostal__c;
                reqObj.billToContact.personalEmail = payeur.PersonEmail;
                reqObj.soldToContact = new zc_PUTAccountTypeSoldToContact();
                reqObj.soldToContact.address1 = porteur.NoVoie__c + ' ' + porteur.TypeVoie__c + ' ' + porteur.NomVoie__c;
                reqObj.soldToContact.city = porteur.Ville__r.Name;
                reqObj.soldToContact.country = porteur.Ville__r.Pays__c;
                reqObj.soldToContact.firstName = porteur.FirstName;
                reqObj.soldToContact.lastName = porteur.LastName;
                reqObj.soldToContact.zipCode = porteur.Ville__r.CodePostal__c;
                reqObj.soldToContact.personalEmail = porteur.PersonEmail;        
                ProcessStep = StepEnum.PreAccountPUT;
                
                zc_CommonResponseType billToUpdResp = zc_Api.accountPUT(accessToken, zEntityId, accountZID, reqObj, RTExceptionCode.ERREUR_MIGRATION_UPDATE_BILLSOLDTO, pLog);
                ProcessStep = StepEnum.PostAccountPUT;

                //FOR ROLLBACK #### UPDATE mapRollBackProcess
                if(!mapRollBackProcess.containsKey('05_UPDATEACCOUNT')){
                    mapRollBackProcess.put('05_UPDATEACCOUNT', new list<map<String, Object>>());
                }
                mapRollBackProcess.get('05_UPDATEACCOUNT').add(new map<String, Object>{
                    'ACCUPDATEREQUEST' 			=> accUpdateReqRollback,
                    'accountZID'                => accountZID
                });

                //ThrowError('RBTest Migration >> Erreur Update Account');
                            
            } //end !ispreview
            
            //###### Subscribe ######
            Map<String,Object> customSub = new Map<String,Object>{
            'IsB2B'=>subOffre.IsB2B, 'isPreview'=>isPreview, 'codeOffreCo'=>subOffre.CodeOffreCo, 'accountZID'=>accountZID, 
            'typeMigration'=>typeMigration, 'dateFinContratInitial'=>sub.DateFinContrat__c, 'generateInvoice'=>generateInvoice
            };
            //customSub.put('IsB2B', subOffre.IsB2B);
            SM_Subscribe.SubscribeIn subIn = SM_Subscribe.mapToSubscribeIn(migIn);
            zc_ProxyActionsubscribeRequest subscribeReq = SM_Subscribe.subscribeMigration(subIn, isPreview, porteur, payeur, subOffreRatePlans, customSub);
            ProcessStep = StepEnum.PreSubscribe;
            zc_ProxySubscribeResult subRes = zc_Api.actionSubscribePOST(accessToken, zEntityId, subscribeReq, RTExceptionCode.ERREUR_MIGRATION_SUBSCRIBE, pLog);
            ProcessStep = StepEnum.PostSubscribe;
            
            //FOR ROLLBACK CANCEL SUB ###### GET Sub Data #####
            zc_POSTSubscriptionCancellationType subCancelReqRollback = new zc_POSTSubscriptionCancellationType();
            subCancelReqRollback.cancellationEffectiveDate = Date.newinstance(migIn.dateDebutContrat.year(), migIn.dateDebutContrat.month(), migIn.dateDebutContrat.day());         
            subCancelReqRollback.targetDate = Date.newinstance(migIn.dateDebutContrat.year(), migIn.dateDebutContrat.month(), migIn.dateDebutContrat.day()); 
            subCancelReqRollback.runBilling = true;
            subCancelReqRollback.cancellationPolicy = 'SpecificDate';  
            
            //FOR ROLLBACK #### UPDATE mapRollBackProcess
            if(!mapRollBackProcess.containsKey('04_CANCELSUB')){
                mapRollBackProcess.put('04_CANCELSUB', new list<map<String, Object>>());
            }
            mapRollBackProcess.get('04_CANCELSUB').add(new map<String, Object>{
                'SUBCANCELREQUEST' 			=> subCancelReqRollback,
                'SUBID'                     => subRes.results.get(0).subscriptionId,
                'DATEDEBUTCONTRAT'          => subIn.dateDebutContrat,
                'INVOICEID'                 => subRes.results.get(0).invoiceId
            });  
            
            //ThrowError('RBTest Migration >> Erreur Subscribe');

            System.debug('MBEN:resObj: ' + JSON.serialize(subRes,true));
            if (isPreview){
                previewOut = SM_Subscribe.parsePreview(subRes, offreProxyOut);        
                previewOut.dateDebutContrat = dateDebutContrat;
                zc_SubscribeRequestSubscriptionDataSub subDataSub = subscribeReq.subscribes.get(0).subscriptionData.subscription;
                if (subDataSub.termType == 'TERMED'){
                    if (subDataSub.initialTermPeriodType == 'Month' ) previewOut.dateFinContrat = subDataSub.termStartDate.addMonths(subDataSub.initialTerm).addDays(-1);             
                }else if (subDataSub.termType == 'EVERGREEN') {
                    previewOut.dateFinContrat = null;
                }        
            }else {
            //String accountZID = subRes.results.get(0).accountId;
            if (generateInvoice) invoiceId = subRes.results.get(0).invoiceId;
            String subscriptionZID = subRes.results.get(0).subscriptionId;
            String subscriptionName = subRes.results.get(0).subscriptionNumber;
        
            //###### update subscriptionOrigin : datefin/codefin ######
            //TODO: OK: il faut (1)mettre à jour le Case Migration avec la date fin + canselCaseID(extId) pour qu il soit traiter par le batchdesabo avec caseId
            // KO: ou bien (2)mettre a jour la zSub et utiliser batchdesabo sans caseID. 
            // le codefin pour la migration est L. (ticket #691)
            // KO: Proposer un nouveau code fin: LU(upgrade) LD(downgrade) qui permettra de traiter les desabo de type migration danns le batch desabonner_SansCase
            // KO: un champ sous-codefin ou bien on rempli le cancelCaseId avec le case de la migration
            zc_ProxyActionupdateRequest subUpdateReq = new zc_ProxyActionupdateRequest();   
            subUpdateReq.r_type = 'Subscription';
            zObj = new zc_ZObjectUpdate();
            zObj.id = sub.Zuora__External_Id__c;
            zObj.dateFinContrat = dateFinContrat;
            zObj.codeFinContrat = 'L';
            subUpdateReq.objects.add(zObj);
            
            ProcessStep = StepEnum.PreActionUpdate2;
            //throw new MyCustomException("RBTest Migration >> Erreur Update Sub");
            zc_Api.actionUpdatePOST(accessToken, zEntityId, subUpdateReq, RTExceptionCode.ERREUR_MIGRATION_UPDATE_ZSUBSCRIPTION,pLog);
            ProcessStep = StepEnum.PostActionUpdate2;

            //FOR ROLLBACK UPDATE OLD SUB ###### GET Sub Data #####
            zc_ProxyActionupdateRequest subUpdateReqRollback = new zc_ProxyActionupdateRequest();
            subUpdateReqRollback.r_type = 'Subscription';
            zObj = new zc_ZObjectUpdate();
            zObj.id = sub.Zuora__External_Id__c;
            
            if(sub.DateFinContrat__c!=null)
            zObj.fieldsToNull.add('DateFinContrat__c');
            else
            zObj.dateFinContrat = sub.DateFinContrat__c;


            if(String.isBlank(sub.CodeFinContrat__c))
            zObj.fieldsToNull.add('CodeFinContrat__c');
            else
            zObj.codeFinContrat = sub.CodeFinContrat__c;
            
            subUpdateReqRollback.objects.add(zObj);
                      
            //FOR ROLLBACK #### UPDATE mapRollBackProcess
            if(!mapRollBackProcess.containsKey('03_UPDATESUB')){
                mapRollBackProcess.put('03_UPDATESUB', new list<map<String, Object>>());
            }
            mapRollBackProcess.get('03_UPDATESUB').add(new map<String, Object>{
                'SUBUPDATEREQUEST' 			=> subUpdateReqRollback
            });      
            
            //ThrowError('RBTest Migration >> Erreur Update Sub');
            if (generateInvoice) {
                //###### get invoice ######
                zc_ProxyGetInvoice invRes = zc_Api.objectInvoiceGET(accessToken, zEntityId, invoiceId, RTExceptionCode.ERREUR_MIGRATION_GET_INVOICE, pLog);
                Double invAmount = invRes.amount;
        
                //###### get invoice File ###### //TODO: OK le doc est genere en retard, on enleve ce champ du retour ??
                // zc_GETInvoiceFilesResponse invFileRes = zc_Api.invoicesFilesGET(accessToken, zEntityId, invoiceId, RTExceptionCode.ERREUR_IMPAYE_REGLER_APPLICATION_FRAIS, pLog);
                // if (invFileRes.invoiceFiles.size() > 0 ) invoiceFileUrl = invFileRes.invoiceFiles.get(0).pdfFileUrl;
        
                //###### Creation paiement Zuora ######
                WSZ.Paiement paymentIn;
                zc_CreatePaymentType paymentReq;
                zc_GETARPaymentType paymentRes;
                ProcessStep = StepEnum.PreCreatePayment;
                if (migIn.paiements.size() > 0 || subOffre.IsB2B == true) {
                    //TODO A analyser: cette condition n est pas toujours valable: a voir en fonction des abo du 01 du mois. if (migIn.paiement.montant != invAmount) throw new RTException(RTExceptionCode.ERREUR_DESABO_COUPON_ABOTIER,pLog);
                    //TODO OK si deux lignes avec meme refPaiement alors il faut un seul paiement.
                    for(String key:mapPaiements2.keySet()){      //key=methodPaiement: CBL,ESP..etc.
                    //for(WSZ.Paiement itemPaiement:migIn.paiements){
                        paymentIn = new WSZ.Paiement(mapPaiements2.get(key).montant, mapPaiements2.get(key).refPaiement, mapPaiements2.get(key).methodePaiement, migIn.lieu, migIn.agent, mapPaiements2.get(key).dateVirement);
                        paymentReq = SM_Payment.createExtPayment(invoiceId, accountZID, paymentIn, codePays);
                        system.debug('##ECH SM_Migration Prepayment Post>>');
                        paymentRes = zc_Api.paymentsPOST2(accessToken, zEntityId, paymentReq, RTExceptionCode.ERREUR_MIGRATION_PAYMENT,pLog);
                        system.debug('##ECH SM_Migration Postpayment Post>>'+paymentRes);
                        paymentIds.add(paymentRes.id);


                        //FOR ROLLBACK CREATE REFUND ###### GET Payment Data #####
                        Map<String,String> retPayment = new Map<String,String>{'paymentId'=>null,'payMethodId'=>null};
                        retPayment.put('payMethodId',paymentRes.paymentMethodId);
                        retPayment.put('paymentId',paymentRes.id);
                        String paymentType = paymentRes.r_type == zc_GETARPaymentType.RTypeEnum.ELECTRONIC ? 'Electronic' : 'External';
                        retPayment.put('paymentType',paymentType);
                        retPayment.put('paymentAmount',String.valueOf(paymentRes.amount));
                        addRollBackActionRefund(mapRollBackProcess, invoiceId, retPayment, zEntityId, accessToken);
                    //}
                    }
                                
                }else {
                    paymentIn = new WSZ.Paiement(invAmount, null, null, null, null, null);
                    paymentReq = SM_Payment.createElecPayment(invoiceId, accountZID, paymentIn, codePays);
                    paymentRes = zc_Api.paymentsPOST2(accessToken, zEntityId, paymentReq, RTExceptionCode.ERREUR_MIGRATION_PAYMENT,pLog);
                    paymentIds.add(paymentRes.id);

                    //FOR ROLLBACK CREATE REFUND ###### GET Payment Data #####
                    Map<String,String> retPayment = new Map<String,String>{'paymentId'=>null,'payMethodId'=>null};
                    retPayment.put('payMethodId',paymentRes.paymentMethodId);
                    retPayment.put('paymentId',paymentRes.id);
                    String paymentType = paymentRes.r_type == zc_GETARPaymentType.RTypeEnum.ELECTRONIC ? 'Electronic' : 'External';
                    retPayment.put('paymentType',paymentType);
                    retPayment.put('paymentAmount',String.valueOf(paymentRes.amount));
                    addRollBackActionRefund(mapRollBackProcess, invoiceId, retPayment, zEntityId, accessToken);
                }
                ProcessStep = StepEnum.PostCreatePayment;
                
                //ThrowError('RBTest Migration >> Erreur Create Payment');
            }
            
        
            //###### Get Zuora Data (subscription) ######
            zc_GETSubscriptionTypeWithSuccess zSub = zc_Api.subscriptionGET(accessToken, zEntityId, subscriptionZID, RTExceptionCode.ERREUR_MIGRATION_GET_ZSUBSCRIPTION,pLog);
        
            //###### Get Zuora Data (Account) ######
            //zc_ProxyGetAccount zacc = zc_Api.objectAccountGET(accessToken, zEntityId, accountZID, RTExceptionCode.ERREUR_ACQUISIT_GET_ACCOUNT,pLog);
            //String payMethodId = zacc.defaultPaymentMethodId;
        
            //###### Get Zuora Data (PaymentMethod) ######
            zc_ProxyGetPaymentMethod pm = zc_Api.objectPaymentMethodGET(accessToken, zEntityId, payMethodId, RTExceptionCode.ERREUR_MIGRATION_GET_PAYMENTMETHOD,pLog);
        
            ProcessStep = StepEnum.PreAddZdocData;
            //###### insert zdocdata subscription ######
            Id zDocId = SM_Hermes.addZdocData(new Map<String,Object>{'ZSUB' => zSub,'ZPM' => pm,'ACC' => porteur});
            ProcessStep = StepEnum.PostAddZdocData;
            isDMLoperation = true;

            //ThrowError('RBTest Migration >> Erreur AddZdocData');
            //###### insert case ######
            String origin = SM_Hermes.lieuToOrigin(migIn.lieu);
            String commentairesInternes = 'Migration - ' + migIn.produit + ' - ' + subOffre.HermesIntituleOffre; 
            ProcessStep = StepEnum.PreCreateCase;
            Case c = SM_Hermes.newCase2(zDocId, subscriptionName, porteur.PersonContactId, origin, '1- Vie de l\'abonnement', '06- Migration UI 1/2/3', 'A- Action', 'Fermee', 
            migIn.lieu, commentairesInternes, migIn.accountSFID,typeDeMigration,creditMemoId,dateFinContrat,migIn.agent);
            ProcessStep = StepEnum.PostCreateCase;
            caseId = c.Id;
            //cancelCaseId = c.CaseExtId__c;
            //String subId2 = sub.Zuora__External_Id__c;
            
            
            //FOR ROLLBACK CANCEL CASE ###### GET Payment Data #####
            if(!mapRollBackProcess.containsKey('10_CANCELCASE')){
                mapRollBackProcess.put('10_CANCELCASE', new list<map<String, Object>>());
            }
            mapRollBackProcess.get('10_CANCELCASE').add(new map<String, Object>{
                'CASEID' 			=> caseId
            });   


            //ThrowError('RBTest Migration >> Erreur After Case');
            //###### update cancelCaseId in Zuora using futur
            ProcessStep = StepEnum.PreUpdateSubFutur;
            updateSubFutur(accessToken, zEntityId, sub.Zuora__External_Id__c, caseId);
            ProcessStep = StepEnum.PostUpdateSubFutur;
        
            //###### generate sDoc ######
            List<Case> cs = [SELECT Id,AccountId,TECHIdStatut__c FROM Case WHERE Id=:caseId];
            ProcessStep = StepEnum.PreSdocJobs;
            SM_SDoc.makeSdocJobs(cs);
            ProcessStep = StepEnum.PostSdocJobs;
            //###### insert Fil impression ######
            ZDocData__c zDoc = [Select Id, Payeur__r.FirstName, Payeur__r.LastName from ZDocData__c where Id = :zDocId];
            ProcessStep = StepEnum.PreCreateFI;
            fileImpId = SM_FileImpression.createFileImpressionCarte(null, (Id)migIn.accountSFID, null, (Id)caseId, subscriptionName, zSub.CodeOffrePrincipale, zDoc.Payeur__r.FirstName, zDoc.Payeur__r.LastName);
            ProcessStep = StepEnum.PostCreateFI;
            //###### create Case remboursement ###### //TODO: abandonne: c traite cree par le batch du cancel.
            
        
            //###### consomme coupon ######
            if (migIn.coupon != null) {
                ProcessStep = StepEnum.PreCoupon;
                SM_Coupon.consommer(migIn.coupon,dateDebutContrat);
                ProcessStep = StepEnum.PostCoupon;
            }
            //RETURN
            migOut = new WSZ.SubOpeOut(migIn.accountSFID, accountZID, subscriptionZID, subscriptionName, compteBloque,invoiceFileUrl, rembourser,
            paymentIds, caseId, payMethodId, invoiceId, fileImpId, sDocjobIds);
        
            // return migOut;
            } //if else !isPreview
        
            if (isPreview) {
                returnObj.put('preview', previewOut);
            }else {
                returnObj.put('migration', migOut);
            }
        
        }catch(Exception e){

            SM_Rollback.executeCatch(e, pLog, isDMLoperation, migIn.accountSFID, zEntityId, accessToken, mapRollBackProcess);
            
        }    

        return returnObj;    
    
    }
    
    @Future(callout=true)
    public static void updateSubFutur(String accessToken, String zEntityId, String subId, String caseId){
        zc_ProxyActionupdateRequest subUpdateReq = new zc_ProxyActionupdateRequest();   
        subUpdateReq.r_type = 'Subscription';
        zc_ZObjectUpdate zObj = new zc_ZObjectUpdate();
        zObj.id = subId; //sub.Zuora__External_Id__c;
        String cancelCaseId = [Select Id, CaseExtId__c from Case where Id = :caseId].get(0).CaseExtId__c;
        zObj.cancelCaseId = cancelCaseId;
        //zObj.codeFinContrat = 'L';
        subUpdateReq.objects.add(zObj);
        zc_Api.actionUpdatePOST(accessToken, zEntityId, subUpdateReq, RTExceptionCode.ERREUR_IMPAYE_REGLER_UPDATE_ACCOUNT,new ProcessLog__c());
    }

    public enum StepEnum {
        PreCreatePaymentMethod,
        PostCreatePaymentMethod,
        PreActionUpdate,
        PostActionUpdate,
        PreAccountPUT,
        PostAccountPUT,
        PreSubscribe,
        PostSubscribe,
        PreActionUpdate2,
        PostActionUpdate2,
        PreCreatePayment,
        PostCreatePayment,
        PreAddZdocData,
        PostAddZdocData,
        PreCreateCase,
        PostCreateCase,
        PreUpdateSubFutur,
        PostUpdateSubFutur,
        PreSdocJobs,
        PostSdocJobs,
        PreCreateFI,
        PostCreateFI,
        PreCoupon,
        PostCoupon

    }

    public static void addRollBackActionRefund(Map<String,List<Map<String,Object>>> mapRollBackProcess, String invoiceId, Map<String,String> retPayment, String zEntityId, String accessToken){
		if(!mapRollBackProcess.containsKey('02_REFUNDACTION')){
			mapRollBackProcess.put('02_REFUNDACTION', new list<map<String, Object>>());
		}
		String paymentMethodType = 'Other';
		if(retPayment.get('paymentType') == 'Electronic'){
			paymentMethodType = null;
		}
		mapRollBackProcess.get('02_REFUNDACTION').add(new map<String, Object>{
			'amount' 			=> Decimal.valueOf(retPayment.get('paymentAmount')),
			'zInvoiceId' 		=> invoiceId,
			'zPaymentId' 		=> retPayment.get('paymentId'),
			'zEntityId' 		=> zEntityId,
			'access_token' 		=> accessToken,
			'refundDate' 		=> Util.zDate(Date.today()),
			'paymentType' 		=> retPayment.get('paymentType'),
			'paymentMethodType' => paymentMethodType,
			'reasonCode' 		=> 'Standard Refund',
			'comment' 			=> 'RollBack'
		});
	}
    

    public static void ThrowError(String Err)
    {
        throw new MyCustomException(Err);
    }
    
}