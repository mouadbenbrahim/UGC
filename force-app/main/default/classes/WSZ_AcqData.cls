public with sharing class WSZ_AcqData {
    
        @InvocableVariable @AuraEnabled // OK pas besoin de AuraEnabled pour les flow
        public Date dateDebutContrat1;
        @InvocableVariable @AuraEnabled
        public String lieu1;
        @InvocableVariable @AuraEnabled
        public String agent1;
        @InvocableVariable
        public String accountSFID1;
        @InvocableVariable
        public String accountRCUID1;
        @InvocableVariable
        public ACQDetails acqDetails;

        public class ACQDetails { //KO pour les flow input ou output, innerclass non autorise
            @InvocableVariable @AuraEnabled
            public String rue;            

        }


}