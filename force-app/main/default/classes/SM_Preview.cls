public with sharing class SM_Preview {

    public final static Set<String> FAMILLE_REMISES = new Set<String>{'REMFRAIDOSS', 'REMMENS', 'REMMONT'};

    public SM_Preview() {

    }

    // public static WSZ.Preview getPreview(WSZ.PreviewIn previewIn){

    //     Boolean isPreview = true;

    //     WSZ.Preview preview = new WSZ.Preview();
    //     String intituleOffreFR,intituleOffreNL;
    //     Decimal abonnement=0,montantInitial=0,fraisAdhesion=0,fraisAdhesionRemise=0,fraisAdhesionApresRemise=0,prorata=0;

    //     String produit = previewIn.produits.get(0);
    //     String typeContrat = (produit.contains('CDI')?'CDI':'CDD');
    //     Boolean isFutur = (previewIn.dateDebutContrat == Date.today())?false:true;

    //     // get subOffres
    //     WSZ.SubProduct subOffre = SM_Offre.getSubOffres(new WSZ.SubOffreIn(previewIn.dateDebutContrat, previewIn.lieu, previewIn.agent, previewIn.coupon,previewIn.accountSFID, previewIn.operation,produit)).get(0);
    //     List<zc_AmendmentRatePlanData> subOffreRatePlans = SM_Offre.convertRatePlan(subOffre.subscribeToRatePlans);
        

    //     // get AccountData
    //     Account porteur = SM_Account.getAccountData(previewIn.accountSFID);
    //     Account payeur = SM_Account.getAccountData(previewIn.payeurSFID);

    //     //token/entity
    //     String accessToken = WS001_CallZuora.access_token;
    //     String zEntityId = WS001_CallZuora.getZuoraEntityId('033');  

    //     // subscribe
    //     SM_Subscribe.SubscribeIn subIn = SM_subscribe.mapToSubscribeIn(previewIn);
    //     Map<String,Object> customSub = new Map<String,Object>{'IsB2B'=>subOffre.IsB2B, 'isPreview'=>isPreview, 'codeOffreCo'=>subOffre.CodeOffreCo};
    //     zc_ProxyActionsubscribeRequest subscribeReq = SM_subscribe.subscribe(subIn, isPreview, porteur, payeur, subOffreRatePlans, customSub);
    //     // Call Zuora actionSubscribe 
    //     zc_ProxySubscribeResult resObj = zc_Api.actionSubscribePOST(accessToken, zEntityId, subscribeReq, RTExceptionCode.ERREUR_IMPAYE_REGLER_APPLICATION_FRAIS, new ProcessLog__c());
    //     System.debug('MBEN:resObj: ' + JSON.serialize(resObj,true));        

    //     //Parse zuora preview result: invoiceitems, prorata, montants.etc
    //     List<zc_InvoiceItem> invItems = resObj.results.get(0).invoiceData.get(0).invoiceItem;
    //     zc_InvoiceDataInvoice invoice = resObj.results.get(0).invoiceData.get(0).invoice;
    //         System.debug('MBEN:invItems: ' + JSON.serialize(invItems));
    //         System.debug('MBEN:invoice: ' + JSON.serialize(invoice));
    //     List<String> rpcIds = new List<String>();
    //     for (zc_InvoiceItem invItem : invItems) {
    //         System.debug('MBEN:invItem: ' + JSON.serialize(invItem));
    //         rpcIds.add(invItem.productRatePlanChargeId);
    //     }
    //     Map<String,ProdRatePlanCharge__c> rpcs = new Map<String,ProdRatePlanCharge__c>();
    //     for(ProdRatePlanCharge__c item : [Select Id, zid__c, Reference__c, FamilleRPC__c, Name from ProdRatePlanCharge__c where zid__c in :rpcIds])
    //     rpcs.put(item.zid__c, item);

    //     for (zc_InvoiceItem invItem : invItems) {
    //         //rpcIds.add(invItem.productRatePlanChargeId);
    //         String rpcZid = invItem.productRatePlanChargeId;
    //         if (rpcs.get(rpcZid).FamilleRPC__c == 'ABO'  ) abonnement += (Decimal)invItem.unitPrice;
    //         if (rpcs.get(rpcZid).FamilleRPC__c == 'FRAIDOSS') fraisAdhesion += (Decimal)invItem.TaxAmount + (Decimal)invItem.ChargeAmount;
    //         if (rpcs.get(rpcZid).FamilleRPC__c == 'REMFRAIDOSS') fraisAdhesionRemise += invItem.TaxAmount + invItem.ChargeAmount;
    //         if (rpcs.get(rpcZid).FamilleRPC__c == 'ABO' && produit.contains('CDI') && invItem.serviceStartDate.toStartOfMonth() != invItem.serviceStartDate) prorata += (Decimal)invItem.TaxAmount + (Decimal)invItem.ChargeAmount;
    //         // if(rpcs.get(rpcZid).FamilleRPC__c == 'REMFRAIDOSS', 'REMMENS', 'REMMONT')
    //     }
    //     fraisAdhesionApresRemise = fraisAdhesion + fraisAdhesionRemise;

    //     preview.abonnement = abonnement;
    //     preview.montantInitial = invoice.amount;
    //     preview.fraisAdhesion = fraisAdhesion;
    //     preview.fraisAdhesionApresRemise = fraisAdhesionApresRemise;
    //     preview.prorata = prorata;
    //     preview.intituleOffreFR = subOffre.HermesIntituleOffre;
    //     preview.intituleOffreNL = subOffre.HermesIntituleOffreNL;
    //     preview.isB2B = subOffre.IsB2B;
    //     preview.isPrepaid = subOffre.IsPrepaid;
    //     preview.produit = subOffre.Reference;
    //     preview.codeOffreCo = subOffre.CodeOffreCo;        

    //     // Parse les offre commerciales(offreDetail): (depuis suboffre)
    //     for (zc_AmendmentRatePlanData ratePlanData : subOffreRatePlans){
    //         zc_RatePlanChargeInRatePlanChargeData rpc2 = ratePlanData.ratePlanChargeData.get(0).ratePlanCharge;
    //         String rpcZid2 = rpc2.productRatePlanChargeId;
    //         String familleRPC = rpcs.get(rpcZid2).FamilleRPC__c;
    //         if (FAMILLE_REMISES.contains(familleRPC)) {
    //             preview.offreDetail.add(new WSZ.PreviewOffreDetail(rpc2.name, rpc2.name)); //TODO a remplace par intitule qui doit etre calcule dans SM_Offre dynamiquement.
    //         }
    //     }


    //     return preview;

    // }
    
}