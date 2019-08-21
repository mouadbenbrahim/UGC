/**
 * Created by ext-dev-05 on 17/06/2019.
 */

global class Batch_SubscriptionTarifUpdate implements Database.Batchable<sObject>, Database.Stateful
{

    global Integer total;
    List<SObject> newScope;
    String codePays;
    Integer partition;

    global Batch_SubscriptionTarifUpdate(String codePays, Integer partition){
        total = 0;
        newScope = new List<SObject>();
        this.codePays = codePays;
        this.partition = partition;
    }

    global Database.QueryLocator start(Database.BatchableContext BC) {

        // KO: aggregate KO: String query = 'Select Zuora__Subscription__c, Zuora__Subscription__r.TarifFacture__c, sum(PriceCalc__c) newTarif from Zuora__SubscriptionProductCharge__c ' +
        // 'group by Zuora__Subscription__c, Zuora__Subscription__r.TarifFacture__c';
        // Zuora__Subscription__r.Zuora__Zuora_Id__c in('8adc9a416a57f1e8016a692354c6605e','8adc8f996a06ca08016a21a3c6b66e61')
        String zEntityId = WS001_CallZuora.getZuoraEntityId(codePays).replace('-','');
        Set<String> rpcSet = new Set<String>();
        // String sToday = Util.zDate(Date.Today());
        // Date mDate = Date.Today();

        for (ProdRatePlanCharge__c prodRatePlanCharge : [SELECT zid__c FROM ProdRatePlanCharge__c where FamilleRPC__c in ('ABO','ABOREM')]) {
            rpcSet.add(prodRatePlanCharge.zid__c);
        }
        // Tous les contrats et leurs charges effectives aujourdhui
        String query = 'Select Id,Zuora__Zuora_Id__c,Name,TarifFacture__c, DateTarifFacture__c,TypeContrat__c, ' +
                '(select Id, Name, Zuora__Price__c, PriceCalc__c,Zuora__EffectiveStartDate__c, Zuora__EffectiveEndDate__c ' +
                'from Zuora__Subscription_Product_Charges__r ' +
                'where Zuora__ProductRatePlanChargeId__c in :rpcSet) ' +
                'FROM Zuora__Subscription__c WHERE ' +
                'Zuora__CustomerAccount__r.Zuora__EntityID__c = :zEntityId ' +
                'AND Partition__c = :partition '
        ;

// 'Order by Zuora__Zuora_Id__c '
// 'limit 10000 '
// Zuora__Status__c != \'Expired\'
// 'order by CreatedDate desc limit 20'
//        + 'AND Zuora__Zuora_Id__c=\'8adcd9eb6b695a45016b6b6cd28f2f8e\' limit 1'  CDI
//8adcd9eb6b695a45016b6b6cd28f2f8e ou 8adc8f996a06ca08016a21a3c6b66e61 CDD
        System.debug('MBEN-start zEntityId: ' + zEntityId);
        System.debug('MBEN-start query: ' + Database.getQueryLocator(query).getQuery());

        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<Zuora__Subscription__c> scope) {
        // ID batchprocessid = Database.executeBatch(new Batch_SubscriptionTarifUpdate2(),200);   KO: First error: Database.executeBatch cannot be called from a batch start, batch execute, or future method.

        Date inDate = (Label.Batch_SubscriptionTarifUpdate_Date == 'UGC_TODAY') ? Date.today() : Date.valueOf(Label.Batch_SubscriptionTarifUpdate_Date);
        // Date inDate = Date.today(); // date pour laquelle on met a jour le tarif de la souscription, en general date du jour
        System.debug('MBEN-execute: scope: ' + scope.size());
        System.debug('MBEN-execute: dateExecution: ' + inDate);

        total = total + scope.size();

        //TODO traitement pour renvoyer que les records a modifier: la logique de verification des tarifs et le nouveaux tarif..etc.

        for (Zuora__Subscription__c sub: scope){

            // Decimal tarifFacture = (sub.TarifFacture__c == null) ? 0 : Decimal.Valueof(sub.TarifFacture__c);
            List<Zuora__SubscriptionProductCharge__c> charges = sub.Zuora__Subscription_Product_Charges__r;
            Map<Date, WSZ.price> prices = new Map<Date, WSZ.price>();

            createPrices(prices,charges); //in : charges, out : prices(KEYS: Date, VALUES: tarif, dateTarif, type(D/F))
            System.debug('MBEN-Sub prices: ' + sub.Zuora__Zuora_Id__c + ' ' + prices.values());

            if (prices.size() > 0){ // existe des prices pour la souscription, pour eviter des dereferenced null error

                // identifier la derniere date connu inferieur a la date fourni.
                // renvoi pour une date en input le dernier element(set) < date input.
                Date dernierElement = Util.prevElement(inDate,prices.keySet());
                if (!String.isBlank(String.valueOf(dernierElement))) {
                    Decimal dernierTarif = prices.get(dernierElement).tarif;
                    Date dateDernierTarif = prices.get(dernierElement).dateTarif;
                    System.debug('MBEN-dernierElement: ' + dernierElement + ' ' + prices.get(dernierElement).toString());
                    if (sub.TypeContrat__c == 'CDD') {dernierTarif = (dernierTarif/12).setScale(2);}
                    if (sub.DateTarifFacture__c != dateDernierTarif || Decimal.valueOf(sub.TarifFacture__c) != dernierTarif){
                        System.debug('sub.DateTarifFacture__c: ' + sub.DateTarifFacture__c + '-' + 'dateDernierTarif: '+ dateDernierTarif );
                        System.debug('sub.TarifFacture__c: ' + sub.TarifFacture__c + '-' + 'dernierTarif: '+ dernierTarif );
                        //construction du nouveau scope qui sera utilise dans un autre Apex Batch, contient les nouveaux tarifs
                        Zuora__Subscription__c sub2 = new Zuora__Subscription__c();
                        sub2.TarifFacture__c = String.valueOf(dernierTarif);
                        sub2.DateTarifFacture__c = dateDernierTarif;
                        sub2.Zuora__Zuora_Id__c = sub.Zuora__Zuora_Id__c;
                        newScope.add(sub2);
                        // System.debug('MBEN-execute-addsub2: '+ sub2.get('Zuora__Zuora_Id__c').toString());
                    }
                }


            }

        } //end for
        System.debug('MBEN-execute-newScope: '+ newScope.size());



    }

    global void finish(Database.BatchableContext BC) {
        ID batchprocessid = Database.executeBatch(new Batch_SubscriptionTarifUpdate2(newScope, codePays),50); // a terme scope = 50
        System.debug('MBEN-execute total initial : ' + total);
        System.debug('MBEN-execute total newScope: ' + newScope.size());

    }

    // calcul une MAP avec toutes les date de toutes les charges avec le tarif calcule a ces dates la.
    private void createPrices(Map<Date, WSZ.price> prices, List<Zuora__SubscriptionProductCharge__c> charges){

        Decimal chargePrice = 0;

        // ajouter dans une MAP prices toutes  differentes dates presentes dans toutes les charges de la souscription
        for (Zuora__SubscriptionProductCharge__c charge: charges){
            chargePrice = chargePrice + charge.PriceCalc__c;
            if (charge.Zuora__EffectiveStartDate__c != null) {prices.put(charge.Zuora__EffectiveStartDate__c,new WSZ.price('D',null,null));}
            if (charge.Zuora__EffectiveEndDate__c != null) {prices.put(charge.Zuora__EffectiveEndDate__c,new WSZ.price('F',null,null));}
        }
        Util.orderMap(prices);

        // MAJ prices MAP  avec le prix/date applique pour chaque de date(key).
        Date prevKey = null;
        for (Date key : prices.keySet()){
            chargePrice = 0;
            // calculer le prix pour la date selectionne: dans toutes les charges de la sub
            for (Zuora__SubscriptionProductCharge__c charge: charges){
                Date startDate = charge.Zuora__EffectiveStartDate__c;
                Date endDate = (charge.Zuora__EffectiveEndDate__c == null) ? key+1 : charge.Zuora__EffectiveEndDate__c; // evergreen charge

                if (startDate <= key && endDate > key){
                    chargePrice = chargePrice + charge.PriceCalc__c;
                }
            }
            if (chargePrice != 0 && charges.size() > 0) {  // au moins une charge avec prix
                prices.get(key).tarif =  chargePrice;
                if ( prevKey != null && prices.get(prevKey).tarif == prices.get(key).tarif ){ prices.get(key).dateTarif = prices.get(prevKey).dateTarif;}
                else {prices.get(key).dateTarif = key;}
                prevKey = key;
            }
            else {
                prices.remove(key); // cette date ne porte pas de charge: ex. date fin d'un CDD ou d'un CDI
            }
        }
    }



}