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
        SM_Desabonnement.desabonner(ddeId,false);
    }

    private static void clientNotification(){

    }


    private class MyException extends Exception {
    }

}