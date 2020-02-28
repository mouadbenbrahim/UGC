public without sharing class SM_Autorisation {
	
	public class RTBlocageCode {
		public String message;
    	public Integer code;
    	
    	public RTBlocageCode(Integer code, String message) {
	        this.message = message;
	        this.code = code;
	    }
	}
	
	public static final RTBlocageCode BLOCAGE_AUTORISATION_WSIN_MANQUANT 							= new RTBlocageCode(01, 'Donnée en entrée non valide');	
	public static final RTBlocageCode BLOCAGE_AUTORISATION_WSIN_ACCOUNTMANQUANT 					= new RTBlocageCode(02, 'Pas de compte SFDC en entrée');	
	public static final RTBlocageCode BLOCAGE_AUTORISATION_WSIN_LIEU_MANQUANT 						= new RTBlocageCode(02, 'Pas de lieu en entrée');	
	public static final RTBlocageCode BLOCAGE_AUTORISATION_ACCOUNTMANQUANT 							= new RTBlocageCode(03, 'Pas de compte SFDC trouvé pour le compte renseigné');	
	public static final RTBlocageCode BLOCAGE_AUTORISATION_AUCUN_BILL_ACCOUNT 						= new RTBlocageCode(04, 'Aucun billing account trouvé');	
	public static final RTBlocageCode BLOCAGE_AUTORISATION_MULTIPLE_BILL_ACCOUNT 					= new RTBlocageCode(05, 'Plusieur billing account trouvé');	
	public static final RTBlocageCode BLOCAGE_AUTORISATION_GET_ACCOUNTSUMMARY 						= new RTBlocageCode(06, 'Probleme get account summary zuora');	
	//public static final RTBlocageCode BLOCAGE_AUTORISATION_GET_ACCOUNTSUMMARY_NOSUB 				= new RTBlocageCode(07, 'Pas de souscription trouvé dans zuora');
	public static final RTBlocageCode BLOCAGE_AUTORISATION_GET_ACCOUNTSUMMARY_MULTIPLE_SUB_CANCEL 	= new RTBlocageCode(08, 'Plusieur souscription cancelled et en periode latence trouvé dans zuora');
	public static final RTBlocageCode BLOCAGE_AUTORISATION_GET_ACCOUNTSUMMARY_MULTIPLE_SUB_ACTIVE 	= new RTBlocageCode(09, 'Plusieur souscription active trouvé dans zuora');
	public static final RTBlocageCode BLOCAGE_AUTORISATION_GET_ACCOUNTSUMMARY_MULTIPLE_SUB_PA 		= new RTBlocageCode(10, 'Plusieur souscription en pending activation trouvé dans zuora');
	
	//lieu
	public static final RTBlocageCode BLOCAGE_AUTORISATION_IMPOSSIBLE_SALFECARE 					= new RTBlocageCode(11, 'Action impossible en Salfecare');
	public static final RTBlocageCode BLOCAGE_AUTORISATION_IMPOSSIBLE_DRC 							= new RTBlocageCode(12, 'Action impossible en DRC');
	public static final RTBlocageCode BLOCAGE_AUTORISATION_IMPOSSIBLE_COMPLEXE 						= new RTBlocageCode(13, 'Action impossible en Complexe');
	
	//reglé impayé & get impayé
	public static final RTBlocageCode BLOCAGE_AUTORISATION_HAS_IMPAYE 								= new RTBlocageCode(14, 'Le client possède un impayé');
	public static final RTBlocageCode BLOCAGE_AUTORISATION_NO_IMPAYE 								= new RTBlocageCode(15, 'Le client ne possède pas d\' impayé');
	
	//aquisition
	public static final RTBlocageCode BLOCAGE_AUTORISATION_PAS_DE_SUB 								= new RTBlocageCode(16, 'Pas de souscription');
	public static final RTBlocageCode BLOCAGE_AUTORISATION_SUB_ACTIVE 								= new RTBlocageCode(17, 'Possède deja une souscription active');
	public static final RTBlocageCode BLOCAGE_AUTORISATION_SUB_PA 									= new RTBlocageCode(18, 'Possède déjà une souscription en Pending Activation');
	public static final RTBlocageCode BLOCAGE_AUTORISATION_SUB_CODE_X_OR_M  						= new RTBlocageCode(19, 'La souscription est codé ');
	
	//Renouvellement
	public static final RTBlocageCode BLOCAGE_AUTORISATION_OR_PERIODE_AVANT_FIN  					= new RTBlocageCode(20, 'En dehors de la periode : date du jour < j-40 date fin de contrat');
	public static final RTBlocageCode BLOCAGE_AUTORISATION_SUB_ACTIVE_SANS_DATE_DE_FIN  			= new RTBlocageCode(21, 'Souscription active sans date de fin');
	public static final RTBlocageCode BLOCAGE_AUTORISATION_SUB_NON_CDD  							= new RTBlocageCode(22, 'Souscription n\'est pas un CDD');
	public static final RTBlocageCode BLOCAGE_AUTORISATION_SUB_A_VENIR  							= new RTBlocageCode(23, 'Présence d\'une souscription à venir');
	public static final RTBlocageCode BLOCAGE_AUTORISATION_SUB_CODE_X_M_R_A_OR_E  					= new RTBlocageCode(24, 'La souscription est codé ');
	public static final RTBlocageCode BLOCAGE_AUTORISATION_OR_PERIODE_LATENCE_DEPASSE  				= new RTBlocageCode(25, 'Periode de latence dépassé');
	
	//Migrattion
	public static final RTBlocageCode BLOCAGE_AUTORISATION_SUB_NON_ACTIVE  							= new RTBlocageCode(26, 'La souscription n\'est pas active');
	public static final RTBlocageCode BLOCAGE_AUTORISATION_SUB_AVEC_CODE_FIN  						= new RTBlocageCode(27, 'La souscription est codé ');
	
	//Change banque
	public static final RTBlocageCode BLOCAGE_AUTORISATION_SUB_NON_ACTIVE_NON_PA  					= new RTBlocageCode(28, 'La souscription n\'est ni au statut active ni au staus Pending Activation');
	public static final RTBlocageCode BLOCAGE_AUTORISATION_MOYEN_PAYEMENT_NON_SEPA  				= new RTBlocageCode(29, 'Le moyen de payement n\'est pas SEPA');
	public static final RTBlocageCode BLOCAGE_AUTORISATION_SUB_CDD  								= new RTBlocageCode(30, 'La souscription est un CDD');
	
	//B2B
	public static final RTBlocageCode BLOCAGE_AUTORISATION_SUB_B2B  								= new RTBlocageCode(31, 'Souscription B2B');
	
	//Produit eligible
	public static final RTBlocageCode BLOCAGE_AUTORISATION_CODE_OFFRE_SUB_VIDE  					= new RTBlocageCode(32, 'Code offre non remplie');
	public static final RTBlocageCode BLOCAGE_AUTORISATION_AUCUN_PRODUIT_ELIGIBLE_TROUVE  			= new RTBlocageCode(33, 'Aucun produit eligible trouvé');
	public static final RTBlocageCode BLOCAGE_AUTORISATION_ACUN_PRODUIT_ELEGIBLE_POUR_CE_LIEU  		= new RTBlocageCode(34, 'Aucun produit eligible pour ce lieu');
	
	public static final RTBlocageCode BLOCAGE_AUTORISATION_SUB_NON_ACTIVE_SANS_DATE_DE_FIN  		= new RTBlocageCode(35, 'Souscription non active sans date de fin');
	
	//Migrattion
	public static final RTBlocageCode BLOCAGE_AUTORISATION_BALANCE_NOT_NULL  						= new RTBlocageCode(36, 'Le client doit être prélevé');
	
	//Status
	public static final String status_Active 			= 'Active';
	public static final String status_PendingActivation = 'Pending Activation';
	public static final String status_Cancelled 		= 'Cancelled';
	
	//Payment Method Type
	public static final String paymentMethodType_BankTransfer = 'BankTransfer';
	
	//Marché
	public static final String marche_BTOB = 'BTOB';
	
	public static final String opertion_Acquisition 	= 'acquisition';
	public static final String opertion_Renouvellement 	= 'renouvellement';
	public static final String opertion_Migration 		= 'migration';
	public static final String opertion_Reglerimpaye 	= 'reglerimpaye';
	public static final String opertion_Changebanque 	= 'changebanque';
	public static final String opertion_Reeditioncarte 	= 'reeditioncarte';
	public static final String opertion_Getimpaye 		= 'getimpaye';
	
	public static final list<String> listOpertions = new list<String>{
		opertion_Acquisition,
		opertion_Renouvellement,
		opertion_Migration,
		opertion_Reglerimpaye,
		opertion_Changebanque,
		opertion_Reeditioncarte,
		opertion_Getimpaye
	};
	
	public static final String lieu_Salfecare 	= 'Salfecare';
	public static final String lieu_DRC 		= 'DRC';
	public static final String lieu_Complexe 	= 'Complexe';
	
	public static final map<String, list<String>> mapListOpNonAutoriseByLieu = new map<String, list<String>>{
		lieu_Salfecare 	=> new list<String>{},
		lieu_DRC 		=> new list<String>{opertion_Reglerimpaye},
		lieu_Complexe 	=> new list<String>{opertion_Renouvellement, opertion_Migration, opertion_Reglerimpaye, opertion_Changebanque, opertion_Reeditioncarte, opertion_Getimpaye}
	};
	
	
	public static final String UI1CDI = 'UI1CDI';	
	public static final String UI2CDI = 'UI2CDI';
	public static final String UI3CDI = 'UI3CDI';
	public static final String UI1CDD = 'UI1CDD';	
	public static final String UI2CDD = 'UI2CDD';
	public static final String UI3CDD = 'UI3CDD';
	public static final String UUCDD  = 'UUCDD' ;
	public static final String UUCDI  = 'UUCDI' ;
	
	
	public static final map<String, map<String, set<String>>> maplistProdEligibleByProdCourantByLieuForMig = new map<String, map<String, set<String>>>{
		lieu_Salfecare 	=> new map<String, set<String>>{UI1CDI => new set<String>{UI2CDI, UI2CDD},
														UI2CDI => new set<String>{UI1CDI, UI3CDI, UI1CDD, UI3CDD},
														UI3CDI => new set<String>{UI2CDI, UI2CDD}},
		lieu_DRC 		=> new map<String, set<String>>{UI1CDI => new set<String>{UI2CDI},
														UI2CDI => new set<String>{UI1CDI, UI3CDI},
														UI3CDI => new set<String>{UI2CDI},
														UI1CDD => new set<String>{UI2CDI},
														UI2CDD => new set<String>{UI1CDI, UI3CDI},
														UI3CDD => new set<String>{UI2CDI}}											 
	};
	
	public static final map<String, map<String, set<String>>> maplistProdEligibleByProdCourantByLieuForRenew = new map<String, map<String, set<String>>>{
		lieu_Salfecare 	=> new map<String, set<String>>{UI1CDD => new set<String>{UI1CDD, UI1CDI},
														UI2CDD => new set<String>{UI2CDD, UI2CDI},
														UI3CDD => new set<String>{UI3CDD, UI3CDI},
														UUCDD  => new set<String>{UUCDD}},
		lieu_DRC 		=> new map<String, set<String>>{UI1CDD => new set<String>{UI1CDI},
														UI2CDD => new set<String>{UI2CDI},
														UI3CDD => new set<String>{UI3CDI},
														UUCDD  => new set<String>{UUCDD}}												 
	};
	

	
	public static WSZ.AuthorizeOut opeauthorize(WSZ.AuthorizeIn wsIn){
		system.debug('##MNE SM_Autorisation opeauthorize wsIn >> '+wsIn);
		WSZ.AuthorizeOut wsOut  = new WSZ.AuthorizeOut();
		
		if(wsIn == null){
			resultatCodeBloqueAll(wsOut , BLOCAGE_AUTORISATION_WSIN_MANQUANT.code, BLOCAGE_AUTORISATION_WSIN_MANQUANT.message);
			system.debug('##MNE SM_Autorisation sortie 1 opeauthorize wsOut >> '+wsOut);
			return wsOut;
		}
		if(String.isBlank(wsIn.accountSFID)){
			resultatCodeBloqueAll(wsOut , BLOCAGE_AUTORISATION_WSIN_ACCOUNTMANQUANT.code, BLOCAGE_AUTORISATION_WSIN_ACCOUNTMANQUANT.message);
			system.debug('##MNE SM_Autorisation sortie 2 opeauthorize wsOut >> '+wsOut);
			return wsOut;
		}
		if(String.isBlank(wsIn.lieu)){
			resultatCodeBloqueAll(wsOut , BLOCAGE_AUTORISATION_WSIN_LIEU_MANQUANT.code, BLOCAGE_AUTORISATION_WSIN_LIEU_MANQUANT.message);
			system.debug('##MNE SM_Autorisation sortie 3 opeauthorize wsOut >> '+wsOut);
			return wsOut;
		}
		
		Id accId = Id.valueOf(wsIn.accountSFID);
		String wsInStr = JSON.serialize(wsIn);
		ProcessLog__c pLog = new ProcessLog__c(Process__c = 'opeauthorize', Account__c = accId, Message__c = wsInStr); //AccountZID__c = hermesIn.accountZID, SubscriptionZID__c = hermesIn.subscriptionZID,
		
        Account acc = SM_Account.getAccount(accId);
        if(acc == null){
        	resultatCodeBloqueAll(wsOut , BLOCAGE_AUTORISATION_ACCOUNTMANQUANT.code, BLOCAGE_AUTORISATION_ACCOUNTMANQUANT.message);
        	system.debug('##MNE SM_Autorisation sortie 4 opeauthorize wsOut >> '+wsOut);
        	//A supprimé
			//openRenew(wsOut);
			return wsOut;
        }
        
        //recupérer zId du billing
        List<Zuora__CustomerAccount__c> billingAccounts = new List<Zuora__CustomerAccount__c>([SELECT Id, Zuora__BillToId__c, Zuora__SoldToId__c, Zuora__Account__r.ProduitUGC__c, Zuora__Account__r.CodePays__c, Zuora__External_Id__c FROM Zuora__CustomerAccount__c WHERE Zuora__Account__c = :accId]);
        if(billingAccounts.size() == 0){
        	//chercher dans zuora : call out get accout by CRMID ou by Id_MonCompte__c
			//pas de billing account
			//resultatCodeBloquePartiel(wsOut , BLOCAGE_AUTORISATION_AUCUN_BILL_ACCOUNT.code, BLOCAGE_AUTORISATION_AUCUN_BILL_ACCOUNT.message, new list<String>{opertion_Acquisition});
			resultatCodeBloquePartiel(wsOut , BLOCAGE_AUTORISATION_PAS_DE_SUB.code, BLOCAGE_AUTORISATION_PAS_DE_SUB.message, new list<String>{opertion_Acquisition});
			/*
			OUI	opertion_Acquisition,
			NON	opertion_Renouvellement,
			NON	opertion_Migration,
			NON	opertion_Reglerimpaye,
			NON	opertion_Changebanque,
			NON	opertion_Reeditioncarte,
			NON	opertion_Getimpaye
			*/
			wsOut.success = true;
			wsOut.compteBloque = false;
			wsOut.message = null;
	  		wsOut.errorCode = null;
			wsOut.accountSFID = acc.Id;
			wsOut.PersonEmail = acc.PersonEmail;
			wsOut.porteurSFID = acc.Id;
        	system.debug('##MNE SM_Autorisation sortie 5 opeauthorize wsOut >> '+wsOut);
        	//A supprimé
			//openRenew(wsOut);
			return wsOut;
        }else if (billingAccounts.size() > 1){
        	resultatCodeBloqueAll(wsOut , BLOCAGE_AUTORISATION_MULTIPLE_BILL_ACCOUNT.code, BLOCAGE_AUTORISATION_MULTIPLE_BILL_ACCOUNT.message);
        	system.debug('##MNE SM_Autorisation sortie 6 opeauthorize wsOut >> '+wsOut);
        	//A supprimé
			//openRenew(wsOut);
			return wsOut;
        }
        
        String zAccId = billingAccounts.get(0).Zuora__External_Id__c;

        // Zuora token
        String accessToken = WS001_CallZuora.access_token;
        String zEntityId = WS001_CallZuora.getZuoraEntityId(acc.CodePays__c);
		zc_GETAccountSummaryType res = zc_Api.accountSummaryGET(accessToken, zEntityId, zAccId, RTExceptionCode.ERREUR_AUTORISATION_GET_ACCOUNTSUMMARY, pLog);
		
		if(res == null || !res.success){
			resultatCodeBloqueAll(wsOut , BLOCAGE_AUTORISATION_GET_ACCOUNTSUMMARY.code, BLOCAGE_AUTORISATION_GET_ACCOUNTSUMMARY.message);
			system.debug('##MNE SM_Autorisation sortie 7 opeauthorize wsOut >> '+wsOut);
			//A supprimé
			//openRenew(wsOut);
			return wsOut;
		}

		wsOut.success = true;
		wsOut.compteBloque = false;
		wsOut.message = null;
  		wsOut.errorCode = null;
		wsOut.accountSFID = acc.Id;
		wsOut.PersonEmail = acc.PersonEmail;
		wsOut.accountZID = zAccId;
		wsOut.porteurSFID = acc.Id;
		
		if(acc.Payeur__c == null){
			wsOut.payeurSFID = acc.Id;
		} else {
			Account accPayeur = SM_Account.getAccount(acc.Payeur__c);
			wsOut.payeurSFID = accPayeur.Id;
		}
		
		//trouvé la sub courante et la sub a venir
		map<String, zc_GETAccountSummarySubscriptionTyp> mapResSubInByName = new map<String, zc_GETAccountSummarySubscriptionTyp>();
		Boolean hasBloacage = getSub(wsOut, res.subscriptions, mapResSubInByName);
		system.debug('##MNE SM_Autorisation opeauthorize hasBloacage >> '+hasBloacage);
		system.debug('##MNE SM_Autorisation opeauthorize mapResSubInByName >> '+mapResSubInByName);
		system.debug('##MNE SM_Autorisation opeauthorize wsOut.subscriptionName >> '+wsOut.subscriptionName);
		system.debug('##MNE SM_Autorisation opeauthorize wsOut.subscriptionZID >> '+wsOut.subscriptionZID);
		system.debug('##MNE SM_Autorisation opeauthorize wsOut.subscriptionNameAvenir >> '+wsOut.subscriptionNameAvenir);
		system.debug('##MNE SM_Autorisation opeauthorize wsOut.subscriptionZIDAvenir >> '+wsOut.subscriptionZIDAvenir);
		
		if(hasBloacage){
			system.debug('##MNE SM_Autorisation sortie 8 opeauthorize wsOut >> '+wsOut);
			//A supprimé
			//openRenew(wsOut);
			return wsOut;
		}
		
		calculAutorisation(wsOut, res, acc, zAccId, mapResSubInByName, wsIn.lieu);
		//A supprimé
		//openRenew(wsOut);
		
		system.debug('##MNE SM_Autorisation derniere sortie opeauthorize wsOut >> '+wsOut);
		return wsOut ; 
	}
	
	
	public static void resultatCodeBloqueAll(WSZ.AuthorizeOut wsOut , Integer codeBlocage, String messageBlocage){
		system.debug('##MNE SM_Autorisation resultatCodeBloque wsOut >> '+wsOut);
		system.debug('##MNE SM_Autorisation resultatCodeBloque codeBlocage >> '+codeBlocage);
		system.debug('##MNE SM_Autorisation resultatCodeBloque messageBlocage >> '+messageBlocage);
		
		wsOut.success = true;
		wsOut.compteBloque = true;
		wsOut.codeBlocage = codeBlocage;
		wsOut.messageCompteBloque = messageBlocage;
		for(WSZ.AuthorizeOut_Autorisation autorisation : wsOut.autorisations){
			autorisation.autorise 	= false;
			autorisation.visible 	= false;
			autorisation.code 		= codeBlocage;
			autorisation.message 	= messageBlocage;
		}
	}	
	
	
	public static void resultatCodeBloquePartiel(WSZ.AuthorizeOut wsOut , Integer codeBlocage, String messageBlocage, list<String> listOperationsAutorise){
		system.debug('##MNE SM_Autorisation resultatCodeBloque wsOut >> '+wsOut);
		system.debug('##MNE SM_Autorisation resultatCodeBloque codeBlocage >> '+codeBlocage);
		system.debug('##MNE SM_Autorisation resultatCodeBloque messageBlocage >> '+messageBlocage);
		system.debug('##MNE SM_Autorisation resultatCodeBloque listOperationsAutorise >> '+listOperationsAutorise);
		
		wsOut.success = true;
		wsOut.compteBloque = false;
		wsOut.codeBlocage = null;
		wsOut.messageCompteBloque = null;
		for(WSZ.AuthorizeOut_Autorisation autorisation : wsOut.autorisations){
			if(listOperationsAutorise.contains(autorisation.operation)){
				autorisation.autorise 	= true;
				autorisation.visible 	= true;
				autorisation.code 		= null;
				autorisation.message 	= null;
			} else {
				autorisation.autorise 	= false;
				autorisation.visible 	= false;
				autorisation.code 		= codeBlocage;
				autorisation.message 	= messageBlocage;
			}
		}
	}
	
	public static void resultatCodeBloqueByLieu(WSZ.AuthorizeOut wsOut, Boolean fromWEB, Boolean fromDRC, Boolean fromCompexe){
		system.debug('##MNE SM_Autorisation resultatCodeBloqueByLieu wsOut >> '+wsOut);
		system.debug('##MNE SM_Autorisation resultatCodeBloqueByLieu fromWEB >> '+fromWEB);
		system.debug('##MNE SM_Autorisation resultatCodeBloqueByLieu fromDRC >> '+fromDRC);
		system.debug('##MNE SM_Autorisation resultatCodeBloqueByLieu fromCompexe >> '+fromCompexe);
		
		list<String> listOpNonAutorise;
		Integer codeBlocage;
		String messageBlocage;

		if(fromWEB){
			listOpNonAutorise 	= mapListOpNonAutoriseByLieu.get(lieu_Salfecare);
			codeBlocage			= BLOCAGE_AUTORISATION_IMPOSSIBLE_SALFECARE.code;
			messageBlocage		= BLOCAGE_AUTORISATION_IMPOSSIBLE_SALFECARE.message;
		} else if(fromDRC){
			listOpNonAutorise 	= mapListOpNonAutoriseByLieu.get(lieu_DRC);
			codeBlocage			= BLOCAGE_AUTORISATION_IMPOSSIBLE_DRC.code;
			messageBlocage		= BLOCAGE_AUTORISATION_IMPOSSIBLE_DRC.message;
		} else {
			listOpNonAutorise 	= mapListOpNonAutoriseByLieu.get(lieu_Complexe);
			codeBlocage			= BLOCAGE_AUTORISATION_IMPOSSIBLE_COMPLEXE.code;
			messageBlocage		= BLOCAGE_AUTORISATION_IMPOSSIBLE_COMPLEXE.message;
		}
		
		if(listOpNonAutorise != null && listOpNonAutorise.size() > 0){
			for(WSZ.AuthorizeOut_Autorisation autorisation : wsOut.autorisations){
				if(listOpNonAutorise.contains(autorisation.operation)){
					autorisation.autorise 	= false;
					autorisation.visible 	= false;
					autorisation.code 		= codeBlocage;
					autorisation.message 	= messageBlocage;
				}
			}
		}
	}
	
	public static void getProduitEligible(WSZ.AuthorizeOut wsOut, Boolean fromWEB, Boolean fromDRC, Boolean fromCompexe, map<String, WSZ.AuthorizeOut_Autorisation> mapAutorisationByOpName, String codeOffrePrincipale, String zDateNaissance, Date dateNaissance){
		system.debug('##MNE SM_Autorisation getProduitEligible wsOut >> '+wsOut);
		system.debug('##MNE SM_Autorisation getProduitEligible fromWEB >> '+fromWEB);
		system.debug('##MNE SM_Autorisation getProduitEligible fromDRC >> '+fromDRC);
		system.debug('##MNE SM_Autorisation getProduitEligible fromCompexe >> '+fromCompexe);
		system.debug('##MNE SM_Autorisation getProduitEligible mapAutorisationByOpName >> '+mapAutorisationByOpName);
		system.debug('##MNE SM_Autorisation getProduitEligible codeOffrePrincipale >> '+codeOffrePrincipale);
		system.debug('##MNE SM_Autorisation getProduitEligible zDateNaissance >> '+zDateNaissance);
		system.debug('##MNE SM_Autorisation getProduitEligible dateNaissance >> '+dateNaissance);
		
		String lieu;
		Boolean canUI3 = false;
		Date dateNaissanceTMP = null;
		Date td = Date.today();
		
		if(fromWEB){
			lieu 	= lieu_Salfecare;
		} else if(fromDRC){
			lieu 	= lieu_DRC;
		} else {
			lieu 	= lieu_Complexe;
		}
		
		if(String.isNotBlank(zDateNaissance)){
			dateNaissanceTMP = Date.valueOf(zDateNaissance);
		} else if(dateNaissance != null){
			dateNaissanceTMP = dateNaissance;
		}
		
		if(dateNaissanceTMP != null && dateNaissanceTMP > td.addYears(-26)){
			canUI3 = true;
		}
		
		WSZ.AuthorizeOut_Autorisation autorisationMigration = mapAutorisationByOpName.get(opertion_Migration);
		WSZ.AuthorizeOut_Autorisation autorisationRenew 	= mapAutorisationByOpName.get(opertion_Renouvellement);
		
		//For Migration
		if(autorisationMigration.autorise && autorisationMigration.visible){
			if(String.isNotBlank(codeOffrePrincipale)){
				if(maplistProdEligibleByProdCourantByLieuForMig.containsKey(lieu)){
					map<String, set<String>> maplistProdEligibleByProdCourantMig = maplistProdEligibleByProdCourantByLieuForMig.get(lieu);
					if(maplistProdEligibleByProdCourantMig.containsKey(codeOffrePrincipale)){
						autorisationMigration.produitEligible.addAll(maplistProdEligibleByProdCourantMig.get(codeOffrePrincipale));
						if(!canUI3){
							autorisationMigration.produitEligible.remove(UI3CDI);
							autorisationMigration.produitEligible.remove(UI3CDD);
						}
					} else {
						autorisationMigration.autorise 	= false;
						autorisationMigration.visible 	= false;
						autorisationMigration.code 		= BLOCAGE_AUTORISATION_AUCUN_PRODUIT_ELIGIBLE_TROUVE.code;
						autorisationMigration.message 	= BLOCAGE_AUTORISATION_AUCUN_PRODUIT_ELIGIBLE_TROUVE.message;
					}
				}else {
					autorisationMigration.autorise 	= false;
					autorisationMigration.visible 	= false;
					autorisationMigration.code 		= BLOCAGE_AUTORISATION_ACUN_PRODUIT_ELEGIBLE_POUR_CE_LIEU.code;
					autorisationMigration.message 	= BLOCAGE_AUTORISATION_ACUN_PRODUIT_ELEGIBLE_POUR_CE_LIEU.message;
				}
			} else {
				autorisationMigration.autorise 	= false;
				autorisationMigration.visible 	= false;
				autorisationMigration.code 		= BLOCAGE_AUTORISATION_CODE_OFFRE_SUB_VIDE.code;
				autorisationMigration.message 	= BLOCAGE_AUTORISATION_CODE_OFFRE_SUB_VIDE.message;
			}
		}
		
		//For Renew
		if(autorisationRenew.autorise && autorisationRenew.visible){
			if(String.isNotBlank(codeOffrePrincipale)){
				if(maplistProdEligibleByProdCourantByLieuForRenew.containsKey(lieu)){
					map<String, set<String>> maplistProdEligibleByProdCourantRenew = maplistProdEligibleByProdCourantByLieuForRenew.get(lieu);
					if(maplistProdEligibleByProdCourantRenew.containsKey(codeOffrePrincipale)){
						autorisationRenew.produitEligible.addAll(maplistProdEligibleByProdCourantRenew.get(codeOffrePrincipale));
						if(!canUI3){
							autorisationRenew.produitEligible.remove(UI3CDI);
							autorisationRenew.produitEligible.remove(UI3CDD);
						}
					} else {
						autorisationRenew.autorise 	= false;
						autorisationRenew.visible 	= false;
						autorisationRenew.code 		= BLOCAGE_AUTORISATION_AUCUN_PRODUIT_ELIGIBLE_TROUVE.code;
						autorisationRenew.message 	= BLOCAGE_AUTORISATION_AUCUN_PRODUIT_ELIGIBLE_TROUVE.message;
					}
				}else {
					autorisationRenew.autorise 	= false;
					autorisationRenew.visible 	= false;
					autorisationRenew.code 		= BLOCAGE_AUTORISATION_ACUN_PRODUIT_ELEGIBLE_POUR_CE_LIEU.code;
					autorisationRenew.message 	= BLOCAGE_AUTORISATION_ACUN_PRODUIT_ELEGIBLE_POUR_CE_LIEU.message;
				}
			} else {
				autorisationRenew.autorise 	= false;
				autorisationRenew.visible 	= false;
				autorisationRenew.code 		= BLOCAGE_AUTORISATION_CODE_OFFRE_SUB_VIDE.code;
				autorisationRenew.message 	= BLOCAGE_AUTORISATION_CODE_OFFRE_SUB_VIDE.message;
			}
		}
	}
	
	public static Boolean getSub(WSZ.AuthorizeOut wsOut, list<zc_GETAccountSummarySubscriptionTyp> listSubIn , map<String, zc_GETAccountSummarySubscriptionTyp> mapResSubInByName){
		system.debug('##MNE SM_Autorisation getSub wsOut >> '+wsOut);
		system.debug('##MNE SM_Autorisation getSub listSubIn >> '+listSubIn);
		system.debug('##MNE SM_Autorisation getSub mapResSubInByName >> '+mapResSubInByName);
		
		Boolean hasBloacage = false;
		if(listSubIn == null || listSubIn.size() == 0){
			//resultatCodeBloqueAll(wsOut , BLOCAGE_AUTORISATION_GET_ACCOUNTSUMMARY_NOSUB.code, BLOCAGE_AUTORISATION_GET_ACCOUNTSUMMARY_NOSUB.message);
			//hasBloacage = true;
			return hasBloacage;
		}
		
		list<zc_GETAccountSummarySubscriptionTyp> listSubCanceledByName  					= new list<zc_GETAccountSummarySubscriptionTyp>();
		list<zc_GETAccountSummarySubscriptionTyp> listSubActiveByName 						= new list<zc_GETAccountSummarySubscriptionTyp>();
		list<zc_GETAccountSummarySubscriptionTyp> listSubPendingActivationByName  			= new list<zc_GETAccountSummarySubscriptionTyp>();
		zc_GETAccountSummarySubscriptionTyp subCanceled										= null;
		zc_GETAccountSummarySubscriptionTyp subActive										= null;
		zc_GETAccountSummarySubscriptionTyp subPendingActivation							= null;
		Date td = Date.today();
		
		for(zc_GETAccountSummarySubscriptionTyp sub : listSubIn){
			if(sub.status == status_Cancelled){
				Date dateFinContrat = Date.valueOf(sub.termEndDate);
				if(listSubCanceledByName.size() > 0){
					 Date dateFinContrat2 = Date.valueOf(listSubCanceledByName.get(0).termEndDate);
					 if(dateFinContrat > dateFinContrat2){
					 	listSubCanceledByName.clear();
					 	listSubCanceledByName.add(sub);
					 }
				} else {
					listSubCanceledByName.add(sub);
				}
			}
			if(sub.status == status_Active){
				listSubActiveByName.add(sub);
			}
			if(sub.status == status_PendingActivation){
				listSubPendingActivationByName.add(sub);
			}
		}
		
		if(listSubCanceledByName.size() > 1){
			resultatCodeBloqueAll(wsOut , BLOCAGE_AUTORISATION_GET_ACCOUNTSUMMARY_MULTIPLE_SUB_CANCEL.code, BLOCAGE_AUTORISATION_GET_ACCOUNTSUMMARY_MULTIPLE_SUB_CANCEL.message);
			hasBloacage = true;
			return hasBloacage;
		} else if(listSubCanceledByName.size() == 1){
			subCanceled = listSubCanceledByName.get(0);
		}
		
		if(listSubActiveByName.size() > 1){
			resultatCodeBloqueAll(wsOut , BLOCAGE_AUTORISATION_GET_ACCOUNTSUMMARY_MULTIPLE_SUB_ACTIVE.code, BLOCAGE_AUTORISATION_GET_ACCOUNTSUMMARY_MULTIPLE_SUB_ACTIVE.message);
			hasBloacage = true;
			return hasBloacage;
		} else if(listSubActiveByName.size() == 1){
			subActive = listSubActiveByName.get(0);
		}
		
		if(listSubPendingActivationByName.size() > 1){
			resultatCodeBloqueAll(wsOut , BLOCAGE_AUTORISATION_GET_ACCOUNTSUMMARY_MULTIPLE_SUB_PA.code, BLOCAGE_AUTORISATION_GET_ACCOUNTSUMMARY_MULTIPLE_SUB_PA.message);
			hasBloacage = true;
			return hasBloacage;
		} else if(listSubPendingActivationByName.size() == 1){
			subPendingActivation = listSubPendingActivationByName.get(0);
		}

		
		if(subActive != null && subPendingActivation != null) {
			wsOut.subscriptionName 			= subActive.subscriptionNumber;
			wsOut.subscriptionZID 			= subActive.id;
			wsOut.subscriptionNameAvenir 	= subPendingActivation.subscriptionNumber;
			wsOut.subscriptionZIDAvenir 	= subPendingActivation.id;
			mapResSubInByName.put(subActive.subscriptionNumber, subActive);
			mapResSubInByName.put(subPendingActivation.subscriptionNumber, subPendingActivation);
		} else if(subActive != null && subPendingActivation == null) {
			wsOut.subscriptionName 			= subActive.subscriptionNumber;
			wsOut.subscriptionZID 			= subActive.id;
			mapResSubInByName.put(subActive.subscriptionNumber, subActive);
		} else if(subCanceled != null && subPendingActivation != null) {
			wsOut.subscriptionName 	= subPendingActivation.subscriptionNumber;
			wsOut.subscriptionZID 	= subPendingActivation.id;
			mapResSubInByName.put(subPendingActivation.subscriptionNumber, subPendingActivation);
		} else if(subCanceled != null && subPendingActivation == null) {
			wsOut.subscriptionName 	= subCanceled.subscriptionNumber;
			wsOut.subscriptionZID 	= subCanceled.id;
			mapResSubInByName.put(subCanceled.subscriptionNumber, subCanceled);
		} else if(subActive != null){
			wsOut.subscriptionName 			= subActive.subscriptionNumber;
			wsOut.subscriptionZID 			= subActive.id;
			mapResSubInByName.put(subActive.subscriptionNumber, subActive);
		} else if(subPendingActivation != null){
			wsOut.subscriptionName 	= subPendingActivation.subscriptionNumber;
			wsOut.subscriptionZID 	= subPendingActivation.id;
			mapResSubInByName.put(subPendingActivation.subscriptionNumber, subPendingActivation);
		} else if(subCanceled != null) {
			wsOut.subscriptionName 	= subCanceled.subscriptionNumber;
			wsOut.subscriptionZID 	= subCanceled.id;
			mapResSubInByName.put(subCanceled.subscriptionNumber, subCanceled);
		}

		for(String subName : mapResSubInByName.keySet()){
			zc_GETAccountSummarySubscriptionTyp sub = mapResSubInByName.get(subName);
			
			String status 				= sub.status;
			String subscriptionName 	= sub.subscriptionNumber;
			Date dateDebutContrat 		= sub.subscriptionStartDate;
			Date dateFinContrat			= null;
			if(sub.status == status_Cancelled){
				dateFinContrat 		= Date.valueOf(sub.termEndDate);
			} else if(String.isNotBlank(sub.dateFinContrat)){
				dateFinContrat 		= Date.valueOf(sub.dateFinContrat);
			}
			
			wsOut.subscriptions.add(new WSZ.AuthorizeOut_Subscription(subscriptionName, dateDebutContrat, dateFinContrat, status));
		}
		return hasBloacage;
	}
	
	
	public static void calculAutorisation(WSZ.AuthorizeOut wsOut , zc_GETAccountSummaryType res, Account acc, String zAccId, map<String, zc_GETAccountSummarySubscriptionTyp> mapResSubInByName, String lieu){
		system.debug('##MNE SM_Autorisation calculAutorisation wsOut >> '+wsOut);
		system.debug('##MNE SM_Autorisation calculAutorisation res >> '+res);
		system.debug('##MNE SM_Autorisation calculAutorisation acc >> '+acc);
		system.debug('##MNE SM_Autorisation calculAutorisation zAccId >> '+zAccId);
		system.debug('##MNE SM_Autorisation calculAutorisation mapResSubInByName >> '+mapResSubInByName);
		system.debug('##MNE SM_Autorisation calculAutorisation lieu >> '+lieu);
		
		Date td = Date.today();
		Boolean fromWEB = lieu.containsIgnoreCase('web');
		Boolean fromDRC = lieu.containsIgnoreCase('drc');
		Boolean fromCompexe = !fromWEB && !fromDRC;
		Boolean fromBelgique;
		Boolean fromFrance;
		
		if (Util.BELGIQUE.contains(acc.CodePays__c)) {
            fromBelgique 	= true;
            fromFrance		= false;
        } else if (Util.FRANCE.contains(acc.CodePays__c)){
            fromBelgique 	= false;
            fromFrance		= true;
		}
		
		
		//A ce niveau, toute les operation sont ainsi :
		/*
		{  
		  "operation": "renouvellement",
		  "autorise": false,
		  "visible": false,
		  "code": null,
		  "message": null,
		  "DateFinEligibilite": null,
		  "produitEligible": []
		}
  		*/
  		
		//opertion_Acquisition
		if(mapResSubInByName.size() == 0 || String.isBlank(wsOut.subscriptionZID)){
			//pas de souscription
			resultatCodeBloquePartiel(wsOut , BLOCAGE_AUTORISATION_PAS_DE_SUB.code, BLOCAGE_AUTORISATION_PAS_DE_SUB.message, new list<String>{opertion_Acquisition});
			/*
			OUI	opertion_Acquisition,
			NON	opertion_Renouvellement,
			NON	opertion_Migration,
			NON	opertion_Reglerimpaye,
			NON	opertion_Changebanque,
			NON	opertion_Reeditioncarte,
			NON	opertion_Getimpaye
			*/
			resultatCodeBloqueByLieu(wsOut, fromWEB, fromDRC, fromCompexe);
			return;
		}
		
		zc_GETAccountSummarySubscriptionTyp subCourante = mapResSubInByName.get(wsOut.subscriptionName);
		map<String, WSZ.AuthorizeOut_Autorisation> mapAutorisationByOpName = new map<String, WSZ.AuthorizeOut_Autorisation>();
		WSZ.AuthorizeOut_Autorisation autorisation;
		for(WSZ.AuthorizeOut_Autorisation autorisationTMP : wsOut.autorisations){
			mapAutorisationByOpName.put(autorisationTMP.operation, autorisationTMP);
		}
		
		//opertion_Getimpaye
		//opertion_Reglerimpaye
		WSZ.ImpayeOut checkImpaye = SM_Impaye.getImpaye(zAccId, wsOut.subscriptionZID);
		system.debug('##MNE SM_Autorisation calculAutorisation hasImpaye >> '+checkImpaye.hasImpaye);
		if(checkImpaye.hasImpaye){
			resultatCodeBloquePartiel(wsOut , BLOCAGE_AUTORISATION_HAS_IMPAYE.code, BLOCAGE_AUTORISATION_HAS_IMPAYE.message, new list<String>{opertion_Reglerimpaye, opertion_Getimpaye});
			/*
			OUI	opertion_Reglerimpaye,
			OUI	opertion_Getimpaye
			NON	opertion_Acquisition,
			NON	opertion_Renouvellement,
			NON	opertion_Migration,
			NON	opertion_Changebanque,
			NON	opertion_Reeditioncarte,
			*/
			if(fromCompexe){
				/*
				OUI	opertion_Reglerimpaye,
				OUI	opertion_Getimpaye
				OUI	opertion_Acquisition,
				NON	opertion_Renouvellement,
				NON	opertion_Migration,
				NON	opertion_Changebanque,
				NON	opertion_Reeditioncarte,
				*/
				autorisation = mapAutorisationByOpName.get(opertion_Acquisition);
				autorisation.autorise 	= true;
				autorisation.visible 	= true;
				autorisation.code 		= null;
				autorisation.message 	= null;
			}
			if(fromDRC){
				/*
				OUI	opertion_Reglerimpaye,
				OUI	opertion_Getimpaye
				NON	opertion_Acquisition,
				NON	opertion_Renouvellement,
				NON	opertion_Migration,
				OUI	opertion_Changebanque,
				NON	opertion_Reeditioncarte,
				*/
				autorisation = mapAutorisationByOpName.get(opertion_Changebanque);
				autorisation.autorise 	= true;
				autorisation.visible 	= true;
				autorisation.code 		= null;
				autorisation.message 	= null;
			}
			resultatCodeBloqueByLieu(wsOut, fromWEB, fromDRC, fromCompexe);
			return;
		} else {
			autorisation = mapAutorisationByOpName.get(opertion_Getimpaye);
			autorisation.autorise 	= false;
			autorisation.visible 	= false;
			autorisation.code 		= BLOCAGE_AUTORISATION_NO_IMPAYE.code;
			autorisation.message 	= BLOCAGE_AUTORISATION_NO_IMPAYE.message;
			
			autorisation = mapAutorisationByOpName.get(opertion_Reglerimpaye);
			autorisation.autorise 	= false;
			autorisation.visible 	= false;
			autorisation.code 		= BLOCAGE_AUTORISATION_NO_IMPAYE.code;
			autorisation.message 	= BLOCAGE_AUTORISATION_NO_IMPAYE.message;
			/*
			NON	opertion_Reglerimpaye,
			NON	opertion_Getimpaye
			*/
		}
		
		//opertion_Acquisition
		system.debug('##MNE SM_Autorisation calculAutorisation subCourante >> '+subCourante);
		system.debug('##MNE SM_Autorisation calculAutorisation subCourante.statu >> '+subCourante.status);
		system.debug('##MNE SM_Autorisation calculAutorisation subCourante.codeFinContrat >> '+subCourante.codeFinContrat);
		if(subCourante.status != status_Active && subCourante.status != status_PendingActivation  && (subCourante.codeFinContrat !='X' && subCourante.codeFinContrat !='M') ){
			autorisation = mapAutorisationByOpName.get(opertion_Acquisition);
			autorisation.autorise 	= true;
			autorisation.visible 	= true;
			/*
			OUI	opertion_Acquisition
			*/
		} else {
			if(subCourante.status == status_Active){
				autorisation = mapAutorisationByOpName.get(opertion_Acquisition);
				autorisation.autorise 	= false;
				autorisation.visible 	= false;
				autorisation.code 		= BLOCAGE_AUTORISATION_SUB_ACTIVE.code;
				autorisation.message 	= BLOCAGE_AUTORISATION_SUB_ACTIVE.message;
				/*
				NON	opertion_Acquisition
				*/
			} else if(subCourante.status == status_PendingActivation){
				autorisation = mapAutorisationByOpName.get(opertion_Acquisition);
				autorisation.autorise 	= false;
				autorisation.visible 	= false;
				autorisation.code 		= BLOCAGE_AUTORISATION_SUB_PA.code;
				autorisation.message 	= BLOCAGE_AUTORISATION_SUB_PA.message;
				/*
				NON	opertion_Acquisition
				*/ 
			} else {
				autorisation = mapAutorisationByOpName.get(opertion_Acquisition);
				autorisation.autorise 	= false;
				autorisation.visible 	= false;
				autorisation.code 		= BLOCAGE_AUTORISATION_SUB_CODE_X_OR_M.code;
				autorisation.message 	= BLOCAGE_AUTORISATION_SUB_CODE_X_OR_M.message + subCourante.codeFinContrat;
				/*
				NON	opertion_Acquisition
				*/
			}
		}
		
		//opertion_Renouvellement + Produit eligible
		list<String> listCodesFin = new list<String>{'X', 'M', 'R', 'A', 'E'};
		if(subCourante.typeContrat == 'CDD' && String.isBlank(wsOut.subscriptionZIDAvenir) && subCourante.marche != marche_BTOB && !listCodesFin.contains(subCourante.codeFinContrat)){
			if(subCourante.status == status_Active){
				if(String.isNotBlank(subCourante.dateFinContrat)){
					Date dateFinContrat = Date.valueOf(subCourante.dateFinContrat);
					Date dateFinContratPeriode = dateFinContrat.addDays(-40);
					if(dateFinContratPeriode <= td && td <= dateFinContrat){
						autorisation = mapAutorisationByOpName.get(opertion_Renouvellement);
						autorisation.autorise 			= true;
						autorisation.visible 			= true;
						autorisation.DateFinEligibilite = String.valueOf(dateFinContrat.addDays(30));
						/*
						OUI opertion_Renouvellement
						*/
					} else {
						autorisation = mapAutorisationByOpName.get(opertion_Renouvellement);
						autorisation.autorise 	= false;
						autorisation.visible 	= false;
						autorisation.code 		= BLOCAGE_AUTORISATION_OR_PERIODE_AVANT_FIN.code;
						autorisation.message 	= BLOCAGE_AUTORISATION_OR_PERIODE_AVANT_FIN.message;
						/*
						NON opertion_Renouvellement
						*/
					}
				} else {
					autorisation = mapAutorisationByOpName.get(opertion_Renouvellement);
					autorisation.autorise 	= false;
					autorisation.visible 	= false;
					autorisation.code 		= BLOCAGE_AUTORISATION_SUB_ACTIVE_SANS_DATE_DE_FIN.code;
					autorisation.message 	= BLOCAGE_AUTORISATION_SUB_ACTIVE_SANS_DATE_DE_FIN.message;
					/*
					NON opertion_Renouvellement
					*/
				}
			} else {
				//sub cancel
				if(String.isNotBlank(subCourante.termEndDate)){
					Date dateFinContrat = Date.valueOf(subCourante.termEndDate);
					Date dateFinContratEtLatence = dateFinContrat.addDays(30);
					if(dateFinContrat <= td && td <= dateFinContratEtLatence){
						autorisation = mapAutorisationByOpName.get(opertion_Renouvellement);
						autorisation.autorise 			= true;
						autorisation.visible 			= true;
						autorisation.DateFinEligibilite = String.valueOf(dateFinContrat.addDays(30));
						
						/*
						OUI opertion_Renouvellement
						*/
					} else {
						autorisation = mapAutorisationByOpName.get(opertion_Renouvellement);
						autorisation.autorise 	= false;
						autorisation.visible 	= false;
						autorisation.code 		= BLOCAGE_AUTORISATION_OR_PERIODE_LATENCE_DEPASSE.code;
						autorisation.message 	= BLOCAGE_AUTORISATION_OR_PERIODE_LATENCE_DEPASSE.message;
						/*
						NON opertion_Renouvellement
						*/
					}
				} else {
					autorisation = mapAutorisationByOpName.get(opertion_Renouvellement);
					autorisation.autorise 	= false;
					autorisation.visible 	= false;
					autorisation.code 		= BLOCAGE_AUTORISATION_SUB_NON_ACTIVE_SANS_DATE_DE_FIN.code;
					autorisation.message 	= BLOCAGE_AUTORISATION_SUB_NON_ACTIVE_SANS_DATE_DE_FIN.message;
					/*
					NON opertion_Renouvellement
					*/
				}
			}
		} else {
			if(subCourante.typeContrat != 'CDD'){
				autorisation = mapAutorisationByOpName.get(opertion_Renouvellement);
				autorisation.autorise 	= false;
				autorisation.visible 	= false;
				autorisation.code 		= BLOCAGE_AUTORISATION_SUB_NON_CDD.code;
				autorisation.message 	= BLOCAGE_AUTORISATION_SUB_NON_CDD.message;
				/*
				NON opertion_Renouvellement
				*/
			} else if(String.isNotBlank(wsOut.subscriptionZIDAvenir)){
				autorisation = mapAutorisationByOpName.get(opertion_Renouvellement);
				autorisation.autorise 	= false;
				autorisation.visible 	= false;
				autorisation.code 		= BLOCAGE_AUTORISATION_SUB_A_VENIR.code;
				autorisation.message 	= BLOCAGE_AUTORISATION_SUB_A_VENIR.message;
				/*
				NON opertion_Renouvellement
				*/
			} else if(subCourante.marche == marche_BTOB){
				autorisation = mapAutorisationByOpName.get(opertion_Renouvellement);
				autorisation.autorise 	= false;
				autorisation.visible 	= false;
				autorisation.code 		= BLOCAGE_AUTORISATION_SUB_B2B.code;
				autorisation.message 	= BLOCAGE_AUTORISATION_SUB_B2B.message;
				/*
				NON opertion_Renouvellement
				*/
			} else {
				autorisation = mapAutorisationByOpName.get(opertion_Renouvellement);
				autorisation.autorise 	= false;
				autorisation.visible 	= false;
				autorisation.code 		= BLOCAGE_AUTORISATION_SUB_CODE_X_M_R_A_OR_E.code;
				autorisation.message 	= BLOCAGE_AUTORISATION_SUB_CODE_X_M_R_A_OR_E.message + subCourante.codeFinContrat;
				/*
				NON opertion_Renouvellement
				*/
			}
		}

		//opertion_Migration + Produit eligible
		Double balance = Double.valueOf(res.basicInfo.balance);
		if(subCourante.status == status_Active && String.isBlank(wsOut.subscriptionZIDAvenir) && balance == 0 && subCourante.marche != marche_BTOB && String.isBlank(subCourante.codeFinContrat)){
			autorisation = mapAutorisationByOpName.get(opertion_Migration);
			autorisation.autorise 			= true;
			autorisation.visible 			= true;
			autorisation.DateFinEligibilite = subCourante.dateFinContrat; 
			/*
			OUI opertion_Migration
			*/
		} else {
			if(subCourante.status != status_Active){
				autorisation = mapAutorisationByOpName.get(opertion_Migration);
				autorisation.autorise 	= false;
				autorisation.visible 	= false;
				autorisation.code 		= BLOCAGE_AUTORISATION_SUB_NON_ACTIVE.code;
				autorisation.message 	= BLOCAGE_AUTORISATION_SUB_NON_ACTIVE.message;
				/*
				NON opertion_Migration
				*/
			} else if(String.isNotBlank(wsOut.subscriptionZIDAvenir)){
				autorisation = mapAutorisationByOpName.get(opertion_Migration);
				autorisation.autorise 	= false;
				autorisation.visible 	= false;
				autorisation.code 		= BLOCAGE_AUTORISATION_SUB_A_VENIR.code;
				autorisation.message 	= BLOCAGE_AUTORISATION_SUB_A_VENIR.message;
				/*
				NON opertion_Migration
				*/
			} else if(balance != 0){
				autorisation = mapAutorisationByOpName.get(opertion_Migration);
				autorisation.autorise 	= false;
				autorisation.visible 	= false;
				autorisation.code 		= BLOCAGE_AUTORISATION_BALANCE_NOT_NULL.code;
				autorisation.message 	= BLOCAGE_AUTORISATION_BALANCE_NOT_NULL.message;
				/*
				NON opertion_Migration
				*/
			} else if(subCourante.marche == marche_BTOB){
				autorisation = mapAutorisationByOpName.get(opertion_Renouvellement);
				autorisation.autorise 	= false;
				autorisation.visible 	= false;
				autorisation.code 		= BLOCAGE_AUTORISATION_SUB_B2B.code;
				autorisation.message 	= BLOCAGE_AUTORISATION_SUB_B2B.message;
				/*
				NON opertion_Renouvellement
				*/
			} else { //sub with code fin contrat
				autorisation = mapAutorisationByOpName.get(opertion_Migration);
				autorisation.autorise 	= false;
				autorisation.visible 	= false;
				autorisation.code 		= BLOCAGE_AUTORISATION_SUB_AVEC_CODE_FIN.code;
				autorisation.message 	= BLOCAGE_AUTORISATION_SUB_AVEC_CODE_FIN.message + subCourante.codeFinContrat;
				/*
				NON opertion_Migration
				*/
			}
		}
		
		//opertion_Changebanque
		if(subCourante.typeContrat == 'CDI' && (subCourante.status == status_Active || subCourante.status == status_PendingActivation) &&
		   res.basicInfo.defaultPaymentMethod != null && String.isNotBlank(res.basicInfo.defaultPaymentMethod.paymentMethodType) && res.basicInfo.defaultPaymentMethod.paymentMethodType == paymentMethodType_BankTransfer){
			autorisation = mapAutorisationByOpName.get(opertion_Changebanque);
			autorisation.autorise 	= true;
			autorisation.visible 	= true;
			/*
			OUI	opertion_Changebanque,
			*/
		}
		else {
			if(subCourante.typeContrat != 'CDI'){
				autorisation = mapAutorisationByOpName.get(opertion_Changebanque);
				autorisation.autorise 	= false;
				autorisation.visible 	= false;
				autorisation.code 		= BLOCAGE_AUTORISATION_SUB_CDD.code;
				autorisation.message 	= BLOCAGE_AUTORISATION_SUB_CDD.message;
				/*
				NON opertion_Changebanque
				*/
			} else if(subCourante.status != status_Active && subCourante.status != status_PendingActivation){
				autorisation = mapAutorisationByOpName.get(opertion_Changebanque);
				autorisation.autorise 	= false;
				autorisation.visible 	= false;
				autorisation.code 		= BLOCAGE_AUTORISATION_SUB_NON_ACTIVE_NON_PA.code;
				autorisation.message 	= BLOCAGE_AUTORISATION_SUB_NON_ACTIVE_NON_PA.message;
				/*
				NON opertion_Changebanque
				*/
			} else {
				autorisation = mapAutorisationByOpName.get(opertion_Changebanque);
				autorisation.autorise 	= false;
				autorisation.visible 	= false;
				autorisation.code 		= BLOCAGE_AUTORISATION_MOYEN_PAYEMENT_NON_SEPA.code;
				autorisation.message 	= BLOCAGE_AUTORISATION_MOYEN_PAYEMENT_NON_SEPA.message;
				/*
				NON opertion_Changebanque
				*/
			}
		}
		
		//opertion_Reeditioncarte
		if(subCourante.status == status_Active || subCourante.status == status_PendingActivation){
			autorisation = mapAutorisationByOpName.get(opertion_Reeditioncarte);
			autorisation.autorise 	= true;
			autorisation.visible 	= true;
			/*
			OUI	opertion_Reeditioncarte,
			*/
		} else {
			autorisation = mapAutorisationByOpName.get(opertion_Reeditioncarte);
			autorisation.autorise 	= false;
			autorisation.visible 	= false;
			autorisation.code 		= BLOCAGE_AUTORISATION_SUB_NON_ACTIVE_NON_PA.code;
			autorisation.message 	= BLOCAGE_AUTORISATION_SUB_NON_ACTIVE_NON_PA.message;
			/*
			NON opertion_Changebanque
			*/
		}
		
		resultatCodeBloqueByLieu(wsOut, fromWEB, fromDRC, fromCompexe);
		getProduitEligible(wsOut, fromWEB, fromDRC, fromCompexe, mapAutorisationByOpName, subCourante.codeOffrePrincipale, res.basicInfo.DateNaissance, acc.PersonBirthdate);
	}
	
	//A supprimer, test chokri
	public static void openRenew(WSZ.AuthorizeOut wsOut){
		for(WSZ.AuthorizeOut_Autorisation autorisation : wsOut.autorisations){
			if(autorisation.operation == opertion_Renouvellement){
				autorisation.autorise 			= true;
				autorisation.visible 			= true;
				autorisation.code 				= null;
				autorisation.message 			= null;
				autorisation.DateFinEligibilite = String.valueOf(Date.today().addDays(30));
				set<String> setProdEligibleTMP = new set<String>{UI1CDD, UI2CDD, UI3CDD, UI1CDI, UI2CDI, UI3CDI, UUCDD};
				autorisation.produitEligible.addAll(setProdEligibleTMP);
			}
		}
	}
	
	

	
	
	
}