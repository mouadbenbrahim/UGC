public without sharing class Utils {
	
	private static RecordType caseRecordType;
    private static RecordType accRecordType;
    private static Contact contactInconnu;
    
    public static Global_Parameters__mdt ugcGlobalParameters;
	// public static UGC_Generic_Param__mdt ugcGenericParams;
    
	public static Global_Parameters__mdt getGlobalParameters(String developerName){

        if(ugcGlobalParameters==null){
            ugcGlobalParameters = [SELECT Id, Seuil_Alerte_Par_Heure__c, 
                                          Nom_Groupe_Chatter__c, 
                                          Sous_Motifs__c, 
                                          EP_RCU_Account_Validation__c,
                                          Base_Url_All_iFrame_Hercule__c,
                                   	      Base_Url_iFrame_VLO__c,
                                   		  Deployment_Level__c,
                                   		  Email_Compte_Inconnu__c,
                                   		  Queues_Fran_aises__c,
                                   		  Queues_Belges__c
                                     FROM Global_Parameters__mdt
                                    WHERE DeveloperName = :developerName].get(0);
        }
		return ugcGlobalParameters;

	}
	
	public static RecordType getNouvelleDemandeClientCaseRecordType() {
		// RecordType d'un Case
		if(caseRecordType == null) {
			caseRecordType = [select id from RecordType where  IsActive = true and SobjectType ='case' and name ='Nouvelle Demande Client' ] ;
		} 
		return caseRecordType;
	}
	
	public static RecordType getComptePersonelAccountRecordType() {
		// RecordType d'un compte 
		if(accRecordType == null) {
	        accRecordType = [select id from RecordType where  IsActive =true and SobjectType ='account' and name ='Compte personnel' ] ;
		}
		return accRecordType;        
	}
	
	public static Contact getContactInconnu() {
		if(contactInconnu == null) {
			Global_Parameters__mdt param = Utils.getGlobalParameters('UGC_One_Parameters');
			system.debug('## Utils ## email inconnu ' + param.Email_Compte_Inconnu__c );
			contactInconnu = [SELECT Id, AccountId FROM Contact WHERE email = :param.Email_Compte_Inconnu__c ];
		}
		
		return contactInconnu;
	}
	
	public static void createContactInconnu() {
		Global_Parameters__mdt param = Utils.getGlobalParameters('UGC_One_Parameters');
		Account accountInconnu = new Account(LastName='inconnu', FirstName= 'client', PersonEmail= param.Email_Compte_Inconnu__c);
    	insert accountInconnu; 
	}
	
	public static List<String> getQueueNames(String pays) {
		Global_Parameters__mdt param = Utils.getGlobalParameters('UGC_One_Parameters');
    	String[] names;
    	if(pays == 'France') {
    		names = param.Queues_Fran_aises__c.split('\r\n');
    	} else {
    		names = param.Queues_Belges__c.split('\r\n');
    	}		
    	return names;
	}

	Public static UGC_Generic_Param__mdt getUgcGenericParam(String paramName, String entite){


		entite = (entite == null) ? 'N/A' : entite;

		List<UGC_Generic_Param__mdt> ugcGenericParams = [SELECT DeveloperName,Entite__c,ParamName__c,ParamValue__c FROM UGC_Generic_Param__mdt WHERE ParamName__c = :paramName and Entite__c = :entite LIMIT 1];
		UGC_Generic_Param__mdt ugcGenericParam = (ugcGenericParams.size() == 1) ? ugcGenericParams.get(0) : null;
		return ugcGenericParam;
	}

}