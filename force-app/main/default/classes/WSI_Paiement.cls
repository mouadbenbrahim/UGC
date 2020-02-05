public with sharing class WSI_Paiement {

    @InvocableVariable @AuraEnabled 
    public Double montant;
    @InvocableVariable @AuraEnabled
    public String refPaiement;
    @InvocableVariable @AuraEnabled
    public String methodePaiement;
    @InvocableVariable @AuraEnabled
    public String lieu;
    @InvocableVariable @AuraEnabled
    public String agent;
    @InvocableVariable @AuraEnabled
    public Date dateVirement;

}