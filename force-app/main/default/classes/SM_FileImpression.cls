public with sharing class SM_FileImpression {
    public SM_FileImpression() {

    }

    public static String createFileImpressionCarte 
    (String numeroCarte, Id accountId, Id carteId, Id caseId, String subscriptionName, String codeOffrePrincipale, String payeurFirst, String payeurLast)  
    { 

        File_Impression__c fi   = new File_Impression__c();
        //fi.Subscription__c      = c.Contrat__c;
        if (numeroCarte != null) {fi.Name = numeroCarte;}
        fi.Account__c           = accountId;
        fi.IsCarte__c           = true;
        fi.Carte__c             = carteId;
        fi.Case__c              = caseId;
        fi.Statut__c            = 'A Imprimer';
        fi.SubscriptionZName__c    = subscriptionName;
        fi.CodeOffrePrincipale__c   = codeOffrePrincipale;
        fi.PayeurFirstName__c   =  payeurFirst; 
        fi.PayeurLastName__c    = payeurLast;

        insert fi;
        return fi.Id;

    }

}