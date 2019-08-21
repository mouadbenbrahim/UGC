@IsTest(SeeAllData=true)
public class Batch_Surveillance_Test {

    @isTest static void alertOnCreatingCases(){
        
        

       	Global_Parameters__mdt ugcOneParam = Utils.getGlobalParameters('UGC_One_Parameters');
        String nomGroup = ugcOneParam.Nom_Groupe_Chatter__c;
        CollaborationGroup groupChatter;

        List<CollaborationGroup> groupes = [SELECT Id, Name FROM CollaborationGroup WHERE Name = :nomGroup];
        System.debug('--#### groupes = '+groupes);
        if(groupes.size() == 1){
            groupChatter = groupes.get(0);
        }else{        
            //créer un group chatter
            groupChatter = new CollaborationGroup(Name = nomGroup, CollaborationType = 'Public');
            insert groupChatter;
        }
        
        System.assertEquals(groupChatter.Id!=null, true);
        
        Case case1 = new Case(Famille__c = 	'2- Demande d\'infos générales', Motif__c = '1- Autres produits et services', 	SousMotif__c = '1- Cartes 5,5+');
        Case case2 = new Case(Famille__c = 	'2- Demande d\'infos générales', Motif__c = '1- Autres produits et services', 	SousMotif__c = '1- Cartes 5,5+');
        Case case3 = new Case(Famille__c = 	'2- Demande d\'infos générales', Motif__c = '1- Autres produits et services', 	SousMotif__c = '1- Cartes 5,5+');
        Case case4 = new Case(Famille__c = 	'2- Demande d\'infos générales', Motif__c = '1- Autres produits et services', 	SousMotif__c = '1- Cartes 5,5+');
        Case case5 = new Case(Famille__c = 	'2- Demande d\'infos générales', Motif__c = '1- Autres produits et services', 	SousMotif__c = '1- Cartes 5,5+');
        
        List<Case> caseList = new List<Case>();
        caseList.add(case1);
        caseList.add(case2);
        caseList.add(case3);
        caseList.add(case4);
        caseList.add(case5);
        
        insert caseList;
        
        System.assertEquals(caseList.get(0).id!=null, true);
        System.assertEquals(caseList.get(1).id!=null, true);
        System.assertEquals(caseList.get(2).id!=null, true);
        System.assertEquals(caseList.get(3).id!=null, true);
        System.assertEquals(caseList.get(4).id!=null, true);
        
        Test.startTest();
        
        Batch_SurveillanceEtAlerteSousMotifs batchLaunch = new Batch_SurveillanceEtAlerteSousMotifs();      
		Database.executebatch(batchLaunch);
        
        Test.stopTest();
        
        Case caseVerif = [SELECT Id, TECH_Alert__c FROM Case WHERE Id = :caseList.get(0).Id];
        
        System.assert(caseVerif.TECH_Alert__c);

        List<FeedItem> chatterFeedLst = [SELECT Id FROM FeedItem WHERE ParentId = :groupChatter.Id];
        System.assert( chatterFeedLst.size() > 0);
        
    }
}