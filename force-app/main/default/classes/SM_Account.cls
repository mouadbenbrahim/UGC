/**
 * Created by mouad on 03/09/2018.
 */

public with sharing class SM_Account {

    public static Account getAccount(Id accId){

        Account account = [
                SELECT Id, Name, MauvaisComportement__c, ProduitUGC__c, CodePays__c
                FROM Account
                WHERE Id = :accId
        ];
        return account; //TODO 5 voir si c une passage en reference ou en valeur ?

    }
    
    

}