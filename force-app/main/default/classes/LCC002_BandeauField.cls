public without sharing class LCC002_BandeauField {
    
    public static final List<String> fieldsForQuerryAccount = new List<String> {
        'Note_Client__c',
        'ScoreAntichurn__c'
    };
    
    public static final List<String> fieldsForQuerrySubscription = new List<String> {
        'lien_porteur_payeur__c',//
        'CodeOffrePrincipale__c',//
        'Zuora__Status__c',//
        'Date_de_debut_de_contrat__c',//
        'Zuora__ContractEffectiveDate__c',//
        'DateFinContrat__c',//
        'CodeFinContrat__c',//
        'Marche__c',//
        'Lieu__c',//
        'TypeContrat__c',
        'Zuora__ContractAcceptanceDate__c'
    };
    
    public static final List<String> fieldsForQuerryCarte = new List<String> {
        'Name',
        'Statut__c'
    };
    
        
    /*public static final List<String> fieldsForQuerryCase = new List<String> {
        'AccountId',
        'Subscription__c',
        'SubscriptionZName__c'
    };*/
    
    
    @AuraEnabled 
    public static List<WRPFieldValues> getFieldValuesInAccout(Id accId){
        system.debug('##MNE getFieldValuesInAccout accId >> '+accId);
     
        String query = 'SELECT Id, '+String.join(fieldsForQuerryAccount, ', ')+ ' FROM Account WHERE Id = \'' + accId+ '\'';
        system.debug('##MNE getFieldValuesInAccout query >> '+query);
        
        list<Account> listAcc = (list<Account>) Database.query(query); 
        
        if(listAcc == null || listAcc.size() == 0){
            system.debug('##MNE getFieldValuesInAccout no data found');
            return null;
        }
        
        Account acc = listAcc.get(0); 
        
        list<WRPFieldValues> rep = new list<WRPFieldValues>();
        
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Schema.SObjectType accSchema = schemaMap.get('Account');
        Map<String, Schema.SObjectField> fieldMap = accSchema.getDescribe().fields.getMap();

        for(String field : fieldsForQuerryAccount){
            String label = fieldMap.get(field).getDescribe().getLabel();
            String value = String.valueof(acc.get(field));
            rep.add(new WRPFieldValues(label, value));
        }
        system.debug('##MNE getFieldValuesInAccout rep >> '+rep);
        return rep;

    }
    
    @AuraEnabled 
    public static List<WRPFieldValues> getFieldValuesInSubscription(Id accId){
        system.debug('##MNE getFieldValuesInSubscription accId >> '+accId);
     
        String query = 'SELECT Id, LastModifiedDate, '+String.join(fieldsForQuerrySubscription, ', ')+ ' FROM Zuora__Subscription__c WHERE Zuora__Account__c = \'' + accId + '\'  ORDER BY Zuora__OriginalCreated_Date__c DESC NULLS LAST LIMIT 1';
        system.debug('##MNE getFieldValuesInSubscription query >> '+query);
        
        list<Zuora__Subscription__c> listSub = (list<Zuora__Subscription__c>) Database.query(query); 
        
        if(listSub == null || listSub.size() == 0){
            system.debug('##MNE getFieldValuesInSubscription no data found');
            return null;
        }
        
        Zuora__Subscription__c sub = listSub.get(0); 
        
        list<WRPFieldValues> rep = new list<WRPFieldValues>();
        
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Schema.SObjectType accSchema = schemaMap.get('Zuora__Subscription__c');
        Map<String, Schema.SObjectField> fieldMap = accSchema.getDescribe().fields.getMap();

        for(String field : fieldsForQuerrySubscription){
            Schema.DisplayType typeTMP =  fieldMap.get(field).getDescribe().getType();
            String label = fieldMap.get(field).getDescribe().getLabel();
            String value = String.valueof(sub.get(field));
            if(typeTMP == Schema.DisplayType.DATE){
                Date d = Date.valueOf(sub.get(field));
                system.debug('##MNE getFieldValuesInSubscription date d >> '+d); 
                if(d == null){
                  value = null; 
                }else {
                  value = DateTime.newInstance(d.year(), d.month(), d.day()).format('dd-MM-yyyy');
                }
            }
            rep.add(new WRPFieldValues(label, value));
        }
        system.debug('##MNE getFieldValuesInSubscription rep >> '+rep);
        return rep;

    }
    
    @AuraEnabled 
    public static List<WRPFieldValues> getFieldValuesInCarte(Id accId){
        system.debug('##MNE getFieldValuesInCarte accId >> '+accId);
     
        String query = 'SELECT Id, LastModifiedDate, '+String.join(fieldsForQuerryCarte, ', ')+ ' FROM Carte__c WHERE Abonn__c = \'' + accId + '\' ORDER BY LastModifiedDate DESC NULLS LAST LIMIT 1';
        system.debug('##MNE getFieldValuesInCarte query >> '+query);
        
        list<Carte__c> listCarte = (list<Carte__c>) Database.query(query); 
        
        if(listCarte == null || listCarte.size() == 0){
            system.debug('##MNE getFieldValuesInCarte no data found');
            return null;
        }
        
        Carte__c carte = listCarte.get(0);
        
        list<WRPFieldValues> rep = new list<WRPFieldValues>();
        
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Schema.SObjectType accSchema = schemaMap.get('Carte__c');
        Map<String, Schema.SObjectField> fieldMap = accSchema.getDescribe().fields.getMap();

        for(String field : fieldsForQuerryCarte){
            String label = fieldMap.get(field).getDescribe().getLabel();
            String value = String.valueof(carte.get(field));
            rep.add(new WRPFieldValues(label, value));
        }
        system.debug('##MNE getFieldValuesInCarte rep >> '+rep);
        return rep;

    }
    
    
    
    
    @AuraEnabled 
    public static list<ListWRPFieldValues> initGetFieldValues(Id recordId){
        system.debug('##MNE initGetFieldValues recordId >> '+recordId);
        
        Id accId = recordId;
     
        if(recordId.getSObjectType() == Schema.Case.SObjectType) {
            String query = 'SELECT Id, AccountId, Account.Tech_IdMonCompte__c FROM Case WHERE Id = \'' + recordId + '\' LIMIT 1';
            system.debug('##MNE initGetFieldValues query Case >> '+query);
            Case c = (Case) Database.query(query)[0]; 
            accId = c.AccountId;
        }
        
        list<ListWRPFieldValues> repFinal = new list<ListWRPFieldValues>();
        
        list<WRPFieldValues> rep = new list<WRPFieldValues>();
           
        List<WRPFieldValues> repAcc = getFieldValuesInAccout(accId);
        List<WRPFieldValues> repSub = getFieldValuesInSubscription(accId);
        List<WRPFieldValues> repCarte = getFieldValuesInCarte(accId);
        
        if(repAcc != null){
            rep.addAll(repAcc);
        }
        if(repSub != null){
            rep.addAll(repSub);
        }
        if(repCarte != null){
            rep.addAll(repCarte);
        }
        
        list<WRPFieldValues> repTMP = new list<WRPFieldValues>();
        for(WRPFieldValues tmp : rep){
            Integer currentIndex = rep.indexOf(tmp);
            if(currentIndex != 0 && Math.mod(currentIndex,10) == 0){
                repFinal.add(new ListWRPFieldValues(repTMP));
                repTMP = new list<WRPFieldValues>();
            }
            repTMP.add(tmp);
        }
        if(repTMP.size() > 0){
            repFinal.add(new ListWRPFieldValues(repTMP));
        }
        system.debug('##MNE repFinal >> '+repFinal);
        return repFinal;
    }
    
    @AuraEnabled 
    public static String getPhotoSFDC (Id recordId){
        try{
            system.debug('##MNE LCC002_BandeauField getPhotoSFDC recordId >> '+recordId);
            
            String RCUId = null;
            String paysTMP = null;
            String pays = null;
         
            if(recordId.getSObjectType() == Schema.Case.SObjectType) {
                String query = 'SELECT Account.IdMonCompte__c, Account.ProduitUGC__c, Account.CodePays__c FROM Case WHERE Id = \'' + recordId + '\' LIMIT 1';
                system.debug('##MNE getPhotoSFDC query Case >> '+query);
                Case c = (Case) Database.query(query)[0]; 
                RCUId = c.Account.IdMonCompte__c;
                paysTMP = c.Account.CodePays__c;
            } else {
                String query = 'SELECT IdMonCompte__c, ProduitUGC__c, CodePays__c FROM Account WHERE Id = \'' + recordId + '\' LIMIT 1';
                system.debug('##MNE getPhotoSFDC query Account >> '+query);
                Account acc = (Account) Database.query(query)[0]; 
                RCUId = acc.IdMonCompte__c;
                paysTMP = acc.CodePays__c;
            }
            system.debug('##MNE LCC002_BandeauField getPhotoSFDC RCUId >> '+RCUId);
            system.debug('##MNE LCC002_BandeauField getPhotoSFDC paysTMP >> '+paysTMP);
            
            if (Util.FRANCE.contains(paysTMP)) {
              pays = '033';
          } else {
              pays = '032';
          }
          
          system.debug('##MNE LCC002_BandeauField getPhotoSFDC pays >> '+pays);
            
            String endpoint = '/Photos/GetPhoto/'+pays+'/'+RCUId;
            //String endpoint = '/Photos/GetPhoto/033/14538';
    
            Http h = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint('callout:HerculeAPI'+endpoint);
            //req.setEndpoint('https://moteur.ugc.fr/moncompte.api.preprod/api/Photos/GetPhoto/033/14538');
            req.setMethod('GET');
            req.setHeader('Content-Type', 'image/jpg');
            req.setCompressed(true);
            req.setTimeout(60000);
            
            HttpResponse res = h.send(req);
            blob image = res.getBodyAsBlob();
            String imageUrl = 'data:'+res.getHeader('Content-Type')+';base64,'+EncodingUtil.base64Encode(image);
            system.debug('##MNE LCC002_BandeauField getPhotoSFDC imageUrl >> '+imageUrl);
            return imageUrl;
        }catch(Exception e){
            return '';
        }
    }
    
    
    
    public without sharing class WRPFieldValues {
        @AuraEnabled public String  label    { get; set; }
        @AuraEnabled public String  value    { get; set; }

        public WRPFieldValues(String label, String value) {
            this.label      = label;
            this.value      = value;
        } 
    }
    
    public without sharing class ListWRPFieldValues {
        @AuraEnabled public list<WRPFieldValues>  listWRPFieldValues    { get; set; }

        public ListWRPFieldValues(list<WRPFieldValues> listWRPFieldValues) {
            this.listWRPFieldValues   = listWRPFieldValues;
        } 
    }

}