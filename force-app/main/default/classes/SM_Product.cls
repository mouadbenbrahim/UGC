/**
 * Created by mouad on 28/10/2018.
 */

public with sharing class SM_Product {

    // public static String zEntityId = '8adce421-63ec-c07b-0163-f45782667179'; // France
    private static String zEntityId_FRA = WS001_CallZuora.getZuoraEntityId(WS001_CallZuora.ZuoraEntityCountry.FRA);
    private static String zEntityId_BEL = WS001_CallZuora.getZuoraEntityId(WS001_CallZuora.ZuoraEntityCountry.BEL);
    // public String zEntityId = '';


    private static List<ProdRatePlan__c> getZProdRatePlan(String zEntityId) {

        // Zuora init variables
        String endpoint = '/v1/action/query';
        String method = 'POST';
        String wsIn = '';
        String wsOut = '';

        // Retrieve Zuora token
        String accessToken = WS001_CallZuora.access_token;
        WSZ.Zquery wsInObj = new WSZ.Zquery();
        wsInObj.queryString = 'Select Id, CreatedById, CreatedDate, Description, EffectiveEndDate, EffectiveStartDate, ' +
                'Name, ProductId, UpdatedById, UpdatedDate, Reference__c, Famille__c, Produit__c, ReferenceCIC__c ' +
                'from ProductRatePlan where Reference__c != \'\'';
        wsIn = (String) JSON.serialize(wsInObj);
        //wsIn = wsIn.replace('xcollect','collect'); // resoud pb mot reserve

        // Zuora Call
        wsOut = WS001_CallZuora.sendRequest(accessToken, endpoint, zEntityId, method, wsIn, 'type2', null);
        wsOut = wsOut.replace('Famille__c','Famille_c');
        wsOut = wsOut.replace('Reference__c', 'Reference_c');
        wsOut = wsOut.replace('Produit__c', 'produit_c');
        wsOut = wsOut.replace('ReferenceCIC__c', 'ReferenceCIC_c');

        //return (WSZ.ProdRatePlanOut) JSON.deserializeStrict(wsOut, WSZ.ProdRatePlanOut.class);
        WSZ.ProdRatePlanOut prodRatePlanOut = new WSZ.ProdRatePlanOut();
        prodRatePlanOut = (WSZ.ProdRatePlanOut) JSON.deserializeStrict(wsOut, WSZ.ProdRatePlanOut.class);

        //Fill ProdRatePlan__c object
        List<ProdRatePlan__c> soRPlans = new List<ProdRatePlan__c>();
        for (WSZ.ProdRatePlan zRP : prodRatePlanOut.records)
        {
            ProdRatePlan__c soRP = new ProdRatePlan__c();
            //soRP.CreatedZDate__c = zRP.createdDate;
            soRP.Description__c = zRP.description;
            //soRP.EffectiveEndDate__c = zRP.effectiveEndDate;
            //soRP.EffectiveStartDate__c = zRP.effectiveStartDate;
            soRP.Famille__c = zRP.famille_c;
            soRP.Name__c = zRP.name;
            soRP.Name = zRP.name;
            soRP.ProductZID__c = zRP.productId;
            soRP.Reference__c = zRP.reference_c;
            //soRP.UpdatedZDate__c = zRP.updatedDate;
            soRP.zid__c = zRP.id;
            soRP.ReferenceCIC__c = zRP.referenceCIC_c;

            if (zRP.produit_c == 'True') {
                soRP.isProduit__c = true;
            } else {
                soRP.isProduit__c = false;
            }
            system.debug('MBEN: ' + zRP.produit_c);
            system.debug('MBEN: ' + soRP.isProduit__c);

            soRPlans.add(soRP);
        }
        return soRPlans;

    }

    private static List<ProdRatePlan__c> getProdRatePlanByZid(String zid)
    {
        return [SELECT Id, Name, zid__c FROM ProdRatePlan__c WHERE zid__c=:zid LIMIT 1];
    }

    private static List<ProdRatePlanCharge__c> getZProdRatePlanCharge(String zEntityId) {
        // Zuora init variable
        String endpoint = '/v1/action/query';
        String method = 'POST';
        String wsIn = '';
        String wsOut = '';

        // Retrieve Zuora token
        String accessToken = WS001_CallZuora.access_token;
        WSZ.Zquery wsInObj = new WSZ.Zquery();
        wsInObj.queryString = 'select Name, Id, ChargeModel, ChargeType, CreatedDate, UpdatedDate, Description,  ' +
                'ProductRatePlanId, Reference__c, FamilleRPC__c, EligibleOffre__c, ReferenceCIC__c ' +
                'from ProductRatePlanCharge where Reference__c != \'\'';
        wsIn = (String) JSON.serialize(wsInObj);
        //wsIn = wsIn.replace('xcollect','collect'); // resoud pb mot reserve

        // Zuora Call
        wsOut = WS001_CallZuora.sendRequest(accessToken, endpoint, zEntityId, method, wsIn, 'type2', null);
        wsOut = wsOut.replace('FamilleRPC__c','FamilleRPC_c');
        wsOut = wsOut.replace('Reference__c', 'Reference_c');
        wsOut = wsOut.replace('EligibleOffre__c', 'EligibleOffre_c');
        wsOut = wsOut.replace('ReferenceCIC__c', 'ReferenceCIC_c');
        //wsOut = wsOut.replace('Produit__c', 'produit_c');
        //return (WSZ.ProdRatePlanChargeOut) JSON.deserializeStrict(wsOut, WSZ.ProdRatePlanChargeOut.class);

        // fill ProdRatePlanCharge__c object
        WSZ.ProdRatePlanChargeOut rpcOut = new WSZ.ProdRatePlanChargeOut();
        rpcOut = (WSZ.ProdRatePlanChargeOut) JSON.deserializeStrict(wsOut, WSZ.ProdRatePlanChargeOut.class);
        List<ProdRatePlanCharge__c> soRPCs = new List<ProdRatePlanCharge__c>();
        for (WSZ.ProdRatePlanCharge zRPC : rpcOut.records)
        {
            ProdRatePlanCharge__c soRPC = new ProdRatePlanCharge__c();
            //soRP.CreatedZDate__c = zRP.createdDate;
            soRPC.Description__c = zRPC.description;
            soRPC.FamilleRPC__c = zRPC.familleRPC_c;
            soRPC.Name = zRPC.name;
            soRPC.Reference__c = zRPC.reference_c;
            //soRP.UpdatedZDate__c = zRP.updatedDate;
            soRPC.zid__c = zRPC.id;
            soRPC.ProductRatePlanZID__c = zRPC.productRatePlanId;
            soRPC.ChargeModel__c = zRPC.chargeModel;
            soRPC.ChargeType__c = zRPC.chargeType;
            soRPC.Description__c = zRPC.description;
            soRPC.EligibleOffre__c = zRPC.eligibleoffre_c == 'True' ? true : false;
            soRPC.ReferenceCIC__c = zRPC.referenceCIC_c;
            List<ProdRatePlan__c> rp = getProdRatePlanByZid(zRPC.productRatePlanId);
            if (!rp.isEmpty()) {
                soRPC.ProdRatePlan__c = rp[0].Id;
                soRPCs.add(soRPC);
            }
        }
        return soRPCs;
    }

    public static void sync(){

        List<ProdRatePlan__c> rps = getZProdRatePlan(zEntityId_FRA);
        List<ProdRatePlanCharge__c> rpcs = getZProdRatePlanCharge(zEntityId_FRA);


        List<ProdRatePlan__c> rps2 = getZProdRatePlan(zEntityId_BEL);
        List<ProdRatePlanCharge__c> rpcs2 = getZProdRatePlanCharge(zEntityId_BEL);

        for (ProdRatePlan__c rp:rps) {
            rp.Entite__c='France';
        }

        for (ProdRatePlanCharge__c rpc:rpcs) {
            rpc.Entite__c='France';
        }

        for (ProdRatePlan__c rp2:rps2) {
            rp2.Entite__c='Belgique';
        }

        for (ProdRatePlanCharge__c rpc2:rpcs2) {
            rpc2.Entite__c='Belgique';
        }

        upsert rps Reference__c;
        upsert rpcs Reference__c;
        upsert rps2 Reference__c;
        upsert rpcs2 Reference__c;


    }


    //SM_Product.
// il faut executer un par un
//SM_Product.

}