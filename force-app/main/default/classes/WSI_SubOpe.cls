public with sharing class WSI_SubOpe {

        @InvocableVariable @AuraEnabled 
        public Date dateDebutContrat; //RENOUV
        @InvocableVariable @AuraEnabled
        public String subscriptionName; //RENOUV, MIG
        @InvocableVariable @AuraEnabled
        public String lieu; // ACQ, RENOUV, MIG, PREV
        @InvocableVariable @AuraEnabled
        public String agent; // ACQ, RENOUV, MIG, PREV
        @InvocableVariable @AuraEnabled
        public String coupon; // ACQ, RENOUV, MIG, PREV
        @InvocableVariable @AuraEnabled
        public String operation; // ACQ, RENOUV, MIG, PREV
        @InvocableVariable @AuraEnabled
        public String accountSFID; // ACQ, RENOUV, MIG, PREV
        @InvocableVariable @AuraEnabled
        public String accountRCUID; // ACQ, RENOUV, MIG, PREV
        @InvocableVariable @AuraEnabled
        public String payeurSFID; // ACQ, RENOUV, MIG, PREV
        @InvocableVariable @AuraEnabled
        public String payeurRCUID; // ACQ, RENOUV, MIG, PREV
        @InvocableVariable @AuraEnabled
        public String produit; // ACQ, RENOUV, MIG
        @InvocableVariable @AuraEnabled
        public String produitActuel; //RENOUV, MIG
        @InvocableVariable @AuraEnabled
        public String codeOffreCo; // ACQ, RENOUV, MIG, PREV
        @InvocableVariable @AuraEnabled
        public String modeLivraison;  // ACQ, RENOUV, MIG
        @InvocableVariable @AuraEnabled
        public String numCarteParrain; // ACQ, RENOUV, MIG
        @InvocableVariable @AuraEnabled
        public String iban; // ACQ, RENOUV, MIG
        @InvocableVariable @AuraEnabled
        public String mandateId; // ACQ, RENOUV, MIG
        @InvocableVariable @AuraEnabled
        public WSI_Paiement paiement;

    public WSI_SubOpe() {

    }


    @InvocableMethod
    public static List<String> toto(List<String> lacqData){
        List<String> acqRes = new List<String>();
        return (acqRes);
    }    

    public static List<WSI_SubOpe> deserialiser(List<String> subOpeJSON){
        List<WSI_SubOpe> retour = new  List<WSI_SubOpe>();
        WSI_SubOpe subOpe = (WSI_SubOpe)JSON.deserialize(subOpeJSON.get(0), WSI_SubOpe.class);
        
        retour.add(subOpe);
        return (retour);
    }    

    // public class SubOpeIn {
    //     @InvocableVariable @AuraEnabled 
    //     public Date dateDebutContrat; //RENOUV
    //     @InvocableVariable @AuraEnabled
    //     public String subscriptionName; //RENOUV, MIG
    //     @InvocableVariable @AuraEnabled
    //     public String lieu; // ACQ, RENOUV, MIG, PREV
    //     @InvocableVariable @AuraEnabled
    //     public String agent; // ACQ, RENOUV, MIG, PREV
    //     @InvocableVariable @AuraEnabled
    //     public String coupon; // ACQ, RENOUV, MIG, PREV
    //     @InvocableVariable @AuraEnabled
    //     public String operation; // ACQ, RENOUV, MIG, PREV
    //     @InvocableVariable @AuraEnabled
    //     public String accountSFID; // ACQ, RENOUV, MIG, PREV
    //     @InvocableVariable @AuraEnabled
    //     public String accountRCUID; // ACQ, RENOUV, MIG, PREV
    //     @InvocableVariable @AuraEnabled
    //     public String payeurSFID; // ACQ, RENOUV, MIG, PREV
    //     @InvocableVariable @AuraEnabled
    //     public String payeurRCUID; // ACQ, RENOUV, MIG, PREV
    //     @InvocableVariable @AuraEnabled
    //     public String produit; // ACQ, RENOUV, MIG
    //     @InvocableVariable @AuraEnabled
    //     public String produitActuel; //RENOUV, MIG
    //     @InvocableVariable @AuraEnabled
    //     public String codeOffreCo; // ACQ, RENOUV, MIG, PREV
    //     @InvocableVariable @AuraEnabled
    //     public String modeLivraison;  // ACQ, RENOUV, MIG
    //     @InvocableVariable @AuraEnabled
    //     public String numCarteParrain; // ACQ, RENOUV, MIG
    //     @InvocableVariable @AuraEnabled
    //     public String iban; // ACQ, RENOUV, MIG
    //     @InvocableVariable @AuraEnabled
    //     public String mandateId; // ACQ, RENOUV, MIG
    //     // @InvocableVariable @AuraEnabled
    //     // public Paiement paiement = new Paiement(); // ACQ, RENOUV, MIG
    //     // @InvocableVariable @AuraEnabled
    //     // public List<String> produits = new List<String>(); // PREV
    // }

    // public class Paiement {
    //     @InvocableVariable @AuraEnabled 
    //     public Double montant;
    //     @InvocableVariable @AuraEnabled
    //     public String refPaiement;
    //     @InvocableVariable @AuraEnabled
    //     public String methodePaiement;
    //     @InvocableVariable @AuraEnabled
    //     public String lieu;
    //     @InvocableVariable @AuraEnabled
    //     public String agent;
    //     @InvocableVariable @AuraEnabled
    //     public Date dateVirement;
    // }

    public class SubOpeOut {
        @InvocableVariable @AuraEnabled
        public String accountSFID; //ID Salesforce : [Obligatoire]
        @InvocableVariable @AuraEnabled
        public String accountZID; // -- ajoutee. [Obligatoire]
        @InvocableVariable @AuraEnabled
        public String accountRCUID;
        @InvocableVariable @AuraEnabled
        public String subscriptionZID; //Id Zuora. [Obligatoire]
        @InvocableVariable @AuraEnabled
        public String subscriptionName;
        @InvocableVariable @AuraEnabled
        public Boolean compteBloque;
        @InvocableVariable @AuraEnabled
        //public String caseId;
        public String invoiceFileUrl;
        @InvocableVariable @AuraEnabled
        public Boolean rembourser;
        @InvocableVariable @AuraEnabled
        public Boolean success;
        @InvocableVariable @AuraEnabled
        public String message;
        @InvocableVariable @AuraEnabled
        public Integer errorCode;    
    }
}