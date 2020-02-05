public with sharing class WSZ_AcquisitionIn {

        @InvocableVariable @AuraEnabled
        public Date dateDebutContrat;
        @InvocableVariable @AuraEnabled
        public String lieu;
        @InvocableVariable
        public String agent;
        @InvocableVariable
        public String coupon;
        @InvocableVariable
        public String operation;
        @InvocableVariable
        public String accountSFID;
        @InvocableVariable
        public String accountRCUID;
        @InvocableVariable
        public String payeurSFID;
        @InvocableVariable
        public String payeurRCUID;
        @InvocableVariable
        public String produit;
        @InvocableVariable
        public String codeOffreCo;
        @InvocableVariable
        public String modeLivraison;
        @InvocableVariable
        public String numCarteParrain;
        @InvocableVariable
        public String iban;
        @InvocableVariable
        public String mandateId;    
    
    public WSZ_AcquisitionIn() {

    }

    @InvocableMethod
    public static List<WSZ_AcquisitionIn> deserialiser(List<String> ljsonStr){
        WSZ_AcquisitionIn acqIn = (WSZ_AcquisitionIn)JSON.deserialize(ljsonStr.get(0), WSZ_AcquisitionIn.class);
        List<WSZ_AcquisitionIn> lacqIn = new  List<WSZ_AcquisitionIn>();
        lacqIn.add(acqIn);
        return (lacqIn);
    }



}