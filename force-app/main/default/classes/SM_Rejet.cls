/**
 * Created by mouad on 02/12/2018.
 */

public with sharing class SM_Rejet {



    //traite les rejets Zuora/Slimpay
    public static void processRejet() {

        List<Zuora__Refund__c> refunds = new List<Zuora__Refund__c>();

        for (Zuora__Refund__c refund : refunds) {
            System.debug('lkjlkj');


        Switch on refund.Name {
            when 'AM04' {

                // Vérifier si premier rejet en l'espace de 6 mois,
                    // Desactivation carte
                    // Ajout Dette FG (Reglable client=True, Statut: En cours)
                    // J+3 : Representation prelevement
                    //

                // Verifier si deuxieme rejet en l'espace de 6 mois.



            }
            when 'AC04' {

            }
            when else {

            }


        }

        }

    }

    /*//Parse les rejets BRED
    public static void processRejetBred(){
        // 01- Recuperer fichier BRED depuis ContentDocument/Attachment
        Id docId = [SELECT ContentDocumentId, LinkedEntityId  FROM ContentDocumentLink
        where LinkedEntityId in ( SELECT Id FROM RejetExterne__c ) and LinkedEntity.Type='RejetExterne__c' LIMIT 1].ContentDocumentId;
        Blob body = [SELECT VersionData FROM ContentVersion WHERE ContentDocumentId = :docId AND IsLatest = true].VersionData;
        // 02- Parse document XML
        String rejet = body.toString();
        List<String> lignes = new List<String>();
        System.debug('MBEN rejet:' + rejet.length());
        System.debug('MBEN body' + body.size());
        DOM.Document doc=new DOM.Document();
        doc.load(rejet);
        DOM.XmlNode rootNode = doc.getRootElement();
        String result = Util.parseXML(rootNode, rootNode.getName(),lignes);
        // 03- Insert document parse dans RejetExterne et RejetExtItem
        // TODO inserer les header dans RejetExterne
        // TODO inserer les rejets des lignes dans  RejetExtItem
        // test dans un seul champ cumule
        RejetExtItem__c rejItem = new RejetExtItem__c(Contenu__c = result);
        insert rejItem;
        // 04- Unapply Zuora payment
        // 05- Create Zuora refund with Reject Code..etc
        // 06- existing tigger or batch on Zuora_Refund__c should process la gestion des impayes comme prévu
    }*/
    
    
    public static void traiterFichier(Id rejetExterneId) {
        system.debug('##MNE SM_Rejet traiterFichier rejetExterneId >> '+rejetExterneId);
        
        list<ContentDocumentLink> listDoc = new list<ContentDocumentLink>([SELECT ContentDocumentId, LinkedEntityId, ContentDocument.FileExtension, ContentDocument.FileType  FROM ContentDocumentLink
        WHERE LinkedEntityId = :rejetExterneId AND LinkedEntity.Type='RejetExterne__c' AND ContentDocument.FileType = 'XML']);
        
        if(listDoc.size() == 0){
            throw new MyException('Pas de fichié de type XML trouvé');
        }
        
        if(listDoc.size() > 1){
            throw new MyException('Plusieur fichié de type XML trouvé');
        }
        
        Id docId = listDoc.get(0).ContentDocumentId;
        
        processRejetBred(rejetExterneId, docId);
    }
    
    
    //Parse les rejets BRED
    public static void processRejetBred(Id rejetExterneId, Id docId){
        system.debug('##MNE SM_Rejet processRejetBred rejetExterneId >> '+rejetExterneId);
        system.debug('##MNE SM_Rejet processRejetBred docId >> '+docId);
        
        if(docId == null){
            throw new MyException('Pas de fichier trouver');
        }

        Blob body = [SELECT VersionData FROM ContentVersion WHERE ContentDocumentId = :docId AND IsLatest = true].VersionData;

        String rejet = body.toString();
        List<String> lignes = new List<String>();
        DOM.Document doc=new DOM.Document();
        doc.load(rejet);
        DOM.XmlNode rootNode = doc.getRootElement();
        
        list<RejetExtItem__c> listNtry = new List<RejetExtItem__c>();
        Util.parseXML(rootNode, listNtry, rejetExterneId);
        
        if(listNtry.size() > 0){
            insert listNtry;
        }
    }
    
    private class MyException extends Exception {
    }


}