/**
 * Created by ext-dev-05 on 17/06/2019.
 */

global class Batch_SubscriptionTarifUpdate2 implements Database.Batchable<SObject>, Database.Stateful, Database.AllowsCallouts {

    List<SObject> mScope;
    String codePays;


    global Batch_SubscriptionTarifUpdate2(List<SObject> iScope, String codePays){
        mScope = iScope.clone();
        this.codePays = codePays;
    }

    global Iterable<SObject> start(Database.BatchableContext BC) {
        // on utilise un iterate pour limiter le scope au donnees dont le tarif a change

        // List<Zuora__Subscription__c> subs = [SELECT Id FROM Zuora__Subscription__c Limit 20];
        return mScope;
    }

    global void execute(Database.BatchableContext BC, List<SObject> scope) {
        System.debug('MBEN-execute newScope: ' + scope.size());
        String zEntityId = WS001_CallZuora.getZuoraEntityId(codePays);
        List<WSZ.SubOut> res = SM_Subscription.updateSub2(scope,zEntityId);
    }

    global void finish(Database.BatchableContext BC) {
    }


}