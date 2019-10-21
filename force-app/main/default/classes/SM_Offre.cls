/**
 * Created by mouad on 02/11/2018.
 Test git
 */

public with sharing class SM_Offre {
//TODO SF:Offre:Operation : renommer les valeurs des API multipicklist
    public static void Trig_ContrainteAfterInsert(List<OffreContrainte__c> contraintes) {
    }

   public static  void Trig_OffreAfterDelete(Map<ID, Offre__c> offres){
/*//TODO supprimer les contraintes du mirroir
       List<OffreContrainte__c> OffreContraintes = [SELECT Id FROM OffreContrainte__c WHERE Offre__c in:offres.keySet()];
       delete OffreContraintes;

       List<OffreContrainte__c> OffreContraintes2 = [SELECT Id FROM OffreContrainte__c WHERE ContrainteSur__c in:offres.keySet()];
       delete OffreContraintes2;

       List<OffreLieu__c> offreLieux = [SELECT Id FROM OffreLieu__c WHERE Offre__c in:offres.keySet()];
       delete offreLieux;*/

   }

    public static  void Trig_OffreBeforeDelete(Map<ID, Offre__c> offres){
//TODO supprimer les contraintes du mirroir
        List<OffreContrainte__c> OffreContraintes = [SELECT Id FROM OffreContrainte__c WHERE Offre__c in:offres.keySet()];
        delete OffreContraintes;

        List<OffreContrainte__c> OffreContraintes2 = [SELECT Id FROM OffreContrainte__c WHERE ContrainteSur__c in:offres.keySet()];
        delete OffreContraintes2;

        List<OffreLieu__c> offreLieux = [SELECT Id FROM OffreLieu__c WHERE Offre__c in:offres.keySet()];
        delete offreLieux;

    }

    public static void Trig_OffreAfterInsert(List<Offre__c> offres) {
        //Add contraintes to offre
        for (Offre__c offre : offres) {
            if (offre.RecordType.Name == 'Offre commerciale' || offre.RecordType.Name == 'Offre coupon') {
                addContraintes(offre.Id);
            } // add default contraintes
        }
    }


    public static void Trig_ContrainteAfterUpdate(Map<ID, OffreContrainte__c> mapOldContraintes, List<OffreContrainte__c> contraintes) {
        // update opposite contraintes
        list<OffreContrainte__c> listContrainteToUpdate = new list<OffreContrainte__c>();
        for (OffreContrainte__c co : contraintes) {
            if (co.Action__c != mapOldContraintes.get(co.Id).Action__c) {
                OffreContrainte__c tgtCo = [
                        SELECT Id, Action__c, IncludeOffreCoupon__c
                        FROM OffreContrainte__c
                        WHERE Offre__c = :co.ContrainteSur__c AND ContrainteSur__c = :co.Offre__c
                        LIMIT 1
                ];
                tgtCo.Action__c = Util.oppositeAction(co.Action__c);
                tgtCo.IncludeOffreCoupon__c = co.IncludeOffreCoupon__c;
                //update tgtCo;
                listContrainteToUpdate.add(tgtCo);
            }
        }
        if(!listContrainteToUpdate.isEmpty()){
        	update listContrainteToUpdate;
        }
    }

    // Supprime et recree les contraintes de l offre: utilise depuis process builder
    @InvocableMethod(label='Refresh Contraintes' description='Refresh Contraintes de l offre')
    public static void refreshContraintes(List<ID> ids) {
        Id offId = ids[0];
        System.debug('MBEN: refreshContraintes');
        List<OffreContrainte__c> contraintes = [SELECT Id FROM OffreContrainte__c WHERE Offre__c = :offId];
        List<OffreContrainte__c> tgtcontraintes = [SELECT Id FROM OffreContrainte__c WHERE ContrainteSur__c = :offId];
        if (!contraintes.isEmpty()) {
            delete contraintes;
        }
        if (!contraintes.isEmpty()) {
            delete tgtcontraintes;
        }
        addContraintes(offId);
    }

    // Supprime et recree les contraintes de l offre: utilise depuis quickaction
    public static void refreshContraintes2(Id offId) {
        System.debug('MBEN: refreshContraintes');
        List<OffreContrainte__c> contraintes = [SELECT Id FROM OffreContrainte__c WHERE Offre__c = :offId];
        List<OffreContrainte__c> tgtcontraintes = [SELECT Id FROM OffreContrainte__c WHERE ContrainteSur__c = :offId];
        if (!contraintes.isEmpty()) {
            delete contraintes;
        }
        if (!contraintes.isEmpty()) {
            delete tgtcontraintes;
        }
        addContraintes(offId);
    }


    private static void addContraintes(Id offId) {

        Offre__c offre = [SELECT Id, DateDebut__c, DateFin__c, RecordType.Name, Promo__c FROM Offre__c WHERE Id = :offId];
        // Map<Id, String> lieus = new Map<Id, Id>([SELECT Complexe__c, Complexe__r.CodeComplexe__c FROM OffreLieu__c
        //WHERE Offre__c = :offId]);
        Set<Id> lieuSet = new Set<Id>();
        Set<Id> pdtSet = new Set<Id>();

        for (OffreLieu__c offreLieu : [SELECT Complexe__c FROM OffreLieu__c WHERE Offre__c = :offId]) {
            lieuSet.add(offreLieu.Complexe__c);
        }

        for (PromoProduit__c promoProduit : [SELECT Produit__c FROM PromoProduit__c where Promo__c = :offre.Promo__c]) {
            pdtSet.add(promoProduit.Produit__c);
        }

        if (offre.RecordType.Name == 'Offre commerciale' || offre.RecordType.Name == 'Offre coupon') {
            List<Offre__c> tgtOffres = [
                    SELECT Id, DateDebut__c, DateFin__c, Promo__c
                    FROM Offre__c
                    WHERE Id != :offId
                    AND (RecordType.Name = 'Offre commerciale' OR RecordType.Name = 'Offre coupon')
            ];

            List<OffreContrainte__c> contraintes = new List<OffreContrainte__c>();
            List<OffreContrainte__c> tgtContraintes = new List<OffreContrainte__c>();
            System.debug('MBEN offreSet: ' + lieuSet);

            for (Offre__c tgtOffre : tgtOffres) {

                Date maxDateDebut = Util.maxDate(tgtOffre.DateDebut__c, offre.DateDebut__c);
                Date minDateFin = Util.minDate(tgtOffre.DateFin__c, offre.DateFin__c);
                Set<Id> lieuTgtSet = new Set<Id>();
                Set<Id> pdtTgtSet = new Set<Id>();

                System.debug('MBEN tgt1: ' + tgtOffre.Id);

                //verifier s'ils offre et tgtOffre n ont pas des dates de chevauchement
                if (maxDateDebut <= minDateFin) {
                    System.debug('MBEN tgt2: ' + tgtOffre.Id);

                    for (OffreLieu__c offreLieu : [SELECT Complexe__c FROM OffreLieu__c WHERE Offre__c = :tgtOffre.Id]) {
                        lieuTgtSet.add(offreLieu.Complexe__c);
                    }
                    System.debug('MBEN lieuTgtSet: ' + lieuTgtSet);
                    lieuSet.retainAll(lieuTgtSet);

                    for (PromoProduit__c promoProduit : [SELECT Produit__c FROM PromoProduit__c where Promo__c = :tgtOffre.Promo__c]) {
                        pdtTgtSet.add(promoProduit.Produit__c);
                    }

                    pdtSet.retainAll(pdtTgtSet);


                    //verifier s'ils offre et tgtOffre n ont pas des lieux cinema en commun : pas de contraintes
                    if (!lieuSet.isEmpty() &&  !pdtSet.isEmpty() ) {
                        System.debug('MBEN tgt3: ' + tgtOffre.Id);
                    OffreContrainte__c co = new OffreContrainte__c();
                    OffreContrainte__c tgtco = new OffreContrainte__c();

                    co.Offre__c = offre.Id;
                    co.ContrainteSur__c = tgtOffre.Id;
                    co.DateDebut__c = maxDateDebut;
                    co.DateFin__c = minDateFin;
                    contraintes.add(co);

                    tgtco.Offre__c = tgtOffre.Id;
                    tgtco.ContrainteSur__c = offre.Id;
                    tgtco.DateDebut__c = maxDateDebut;
                    tgtco.DateFin__c = minDateFin;
                    tgtContraintes.add(tgtco);

                    }
                }
            }
            if (!contraintes.isEmpty()) {
                insert contraintes;
            }
            if (!tgtContraintes.isEmpty()) {
                insert tgtContraintes;
            }
        }
    }

    // Recupere toutes les remises (OffBase, OffCo, OffPromoCode de tous les produits)
    public static List<WSZ.SubProduct> getSubOffres(WSZ.SubOffreIn subIn) {

        subIn.dateSubscription = Date.valueOf(subIn.dateSub);
        List<WSZ.SubProduct> subProducts = new List<WSZ.SubProduct>();


        for (String prodRpRef : subIn.references) {
            System.debug('MBEN: Process getSubOffres - Produit: ' + prodRpRef);
            WSZ.SubProduct subProd = new WSZ.SubProduct();
            List<WSZ.SubscribeToRatePlan> ratePlansBase = null;
            List<WSZ.SubscribeToRatePlan> ratePlansCom = null;
            List<WSZ.SubscribeToRatePlan> ratePlansPc = null;
            List<WSZ.SubscribeToRatePlan> ratePlansChargeBase = null;
            List<WSZ.SubscribeToRatePlan> ratePlansAboBase = null;


            subProd.Reference = prodRpRef;
            subProd.Marche = 'BTOC';
            subProd.IsB2B = false;
            subProd.IsPrepaid = false;
            subProd.subscribeToRatePlans = new List<WSZ.SubscribeToRatePlan>();

            // Recupere le RP de l abonnement
            List<Offre__c> offAboBase = aboBaseEligible(prodRpRef, subIn);
            if (!offAboBase.isEmpty()) {
                ratePlansAboBase = getRemisesRatePlans(offAboBase.get(0), subIn);
                subProd.subscribeToRatePlans.addAll(ratePlansAboBase);
                subProd.HermesIntituleOffre = offAboBase.get(0).HermesIntituleOffre__c;
                subProd.HermesIntituleOffreNL = offAboBase.get(0).HermesIntituleOffreNL__c;                
                subProd.CodeOffreCo = offAboBase.get(0).Reference__c;
            }

            // Recupere le RP de la Frais de base: Frais dossier de l'abonnement
            List<Offre__c> offChargeBase = chargeBaseEligible(prodRpRef, subIn);
            if (!offChargeBase.isEmpty()) {
                ratePlansChargeBase = getRemisesRatePlans(offChargeBase.get(0), subIn);
                subProd.subscribeToRatePlans.addAll(ratePlansChargeBase);
                subProd.HermesIntituleOffre = offChargeBase.get(0).HermesIntituleOffre__c;
                subProd.HermesIntituleOffreNL = offChargeBase.get(0).HermesIntituleOffreNL__c;
                subProd.CodeOffreCo = offChargeBase.get(0).Reference__c;
            }

            // Recupere le RP de la remise en debut de periode de l'abonnement
            List<Offre__c> offBase = offreBaseEligible(prodRpRef, subIn);
            if (!offBase.isEmpty()) {
                ratePlansBase = getRemisesRatePlans(offBase.get(0), subIn);
                subProd.subscribeToRatePlans.addAll(ratePlansBase);
                subProd.HermesIntituleOffre = offBase.get(0).HermesIntituleOffre__c;
                subProd.HermesIntituleOffreNL = offBase.get(0).HermesIntituleOffreNL__c;
                subProd.CodeOffreCo = offBase.get(0).Reference__c;
            }

            // Recupere le RP de l offre commerciale
            List<Offre__c> offCo = offreCommercialEligible(prodRpRef, subIn);
            if (!offCo.isEmpty()) {
                ratePlansCom = getRemisesRatePlans(offCo.get(0), subIn);
                subProd.subscribeToRatePlans.addAll(ratePlansCom);
                subProd.HermesIntituleOffre += '|' + offCo.get(0).HermesIntituleOffre__c;
                subProd.HermesIntituleOffreNL += '|' + offCo.get(0).HermesIntituleOffreNL__c;
                subProd.CodeOffreCo = offCo.get(0).Reference__c;
            }

            // Recupere le RP associe au coupon: BtoC ou BtoB
            if (String.isNotEmpty(subIn.coupon)) {
                WSZ.CouponGeneric couponG = new WSZ.CouponGeneric();
                List<Offre__c> offPc = offrePromoCodeEligible(prodRpRef, subIn, offCo, couponG);
                System.debug('MBEN: couponG12 ' + couponG);
                if (!offPc.isEmpty()) {
                    if (offPc.get(0).RecordType.Name == 'Offre coupon') {
                        ratePlansPc = getRemisesRatePlans(offPc.get(0), subIn);
                        subProd.subscribeToRatePlans.addAll(ratePlansPc);
                        subProd.HermesIntituleOffre += '|' + offPc.get(0).HermesIntituleOffre__c;
                        subProd.HermesIntituleOffreNL += '|' + offPc.get(0).HermesIntituleOffreNL__c;
                        subProd.CodeOffreCo = offPc.get(0).Reference__c;
                    }
                    if (offPc.get(0).RecordType.Name == 'Offre BTOB') {
                        System.debug('MBEN: Offre BtoB: couponG15: ' + couponG);
                        ratePlansPc = getBtoBRatePlan(offPc.get(0), subIn, couponG);
                        subProd.Marche = 'BTOB';
                        subProd.HermesIntituleOffre = offPc.get(0).HermesIntituleOffre__c;
                        subProd.HermesIntituleOffreNL = offPc.get(0).HermesIntituleOffreNL__c;
                        subProd.CodeOffreCo =  offPc.get(0).Reference__c;
                        subProd.subscribeToRatePlans.clear(); //supprimer les anciens Rateplans si BtoB
                        subProd.subscribeToRatePlans.addAll(ratePlansPc);
                        subProd.IsB2B = true;
                        subProd.IsPrepaid = true;
                    }
                }
            }

            //subProd.Success = true;
            System.debug('MBEN: prod: ' + prodRpRef + ': ' + (String) JSON.serialize(subProd, true));
            subProducts.add(subProd);

        }

        return subProducts;
    }


    public static List<Offre__c> offreBaseEligible(String rpReference, WSZ.SubOffreIn subIn) {
        List<Offre__c> offBase = [
                SELECT Id, Name, Intitule__c, HermesIntituleOffre__c, HermesIntituleOffreNL__c, RecordType.Name, Reference__c
                FROM Offre__c
                WHERE RecordType.Name = 'Remise de base'
                AND DateDebut__c <= :subIn.dateSubscription AND DateFin__c >= :subIn.dateSubscription
                AND Promo__c IN (SELECT Promo__c FROM PromoProduit__c WHERE Produit__r.Reference__c = :rpReference)
                AND Operation__c includes (:subIn.operation)
                LIMIT 1
        ];

        return offBase;
    }

    //Eligibilite sur date offre, produit
    public static List<Offre__c> aboBaseEligible(String rpReference, WSZ.SubOffreIn subIn) {
        List<Offre__c> offBase = [
                SELECT Id, Name, Intitule__c, HermesIntituleOffre__c, HermesIntituleOffreNL__c, RecordType.Name, Reference__c
                FROM Offre__c
                WHERE RecordType.Name = 'Abonnement de base'
                AND DateDebut__c <= :subIn.dateSubscription AND DateFin__c >= :subIn.dateSubscription
                AND Promo__c IN (SELECT Promo__c FROM PromoProduit__c WHERE Produit__r.Reference__c = :rpReference)
                LIMIT 1
        ];

        return offBase;
    }



    public static List<Offre__c> chargeBaseEligible(String rpReference, WSZ.SubOffreIn subIn) {
        List<Offre__c> offBase = [
                SELECT Id, Name, Intitule__c, HermesIntituleOffre__c, HermesIntituleOffreNL__c, RecordType.Name, Reference__c
                FROM Offre__c
                WHERE RecordType.Name = 'Frais de base'
                AND DateDebut__c <= :subIn.dateSubscription AND DateFin__c >= :subIn.dateSubscription
                AND Promo__c IN (SELECT Promo__c FROM PromoProduit__c WHERE Produit__r.Reference__c = :rpReference)
                AND Operation__c includes (:subIn.operation)
                LIMIT 1
        ];

        return offBase;
    }

    //Recupere l offre commerciale eligible
    public static List<Offre__c> offreCommercialEligible(String prodRpRef, WSZ.SubOffreIn subIn) {

        // Offres selectionnables: Date, Lieu, Produit
        List<Offre__c> offCo1 = [
                SELECT Id, Name, Intitule__c, HermesIntituleOffre__c, HermesIntituleOffreNL__c, RecordType.Name, Reference__c
                FROM Offre__c
                WHERE RecordType.Name = 'Offre commerciale'
                AND DateDebut__c <= :subIn.dateSubscription AND DateFin__c >= :subIn.dateSubscription
                AND Promo__c IN (SELECT Promo__c FROM PromoProduit__c WHERE Produit__r.Reference__c = :prodRpRef)
                AND Id IN (SELECT Offre__c FROM OffreLieu__c WHERE CodeComplexe2__c = :subIn.lieu)
                AND Operation__c includes (:subIn.operation)
        ];

        //List<Offre__c> offCo = [SELECT Id, Name, Intitule__c from Offre__c WHERE Reference__c = :prodRpRef LIMIT 1]; //juste pour tester j utilise le champ reference.
        System.debug('MBEN: OffreCo Selectionnable: ' + offCo1);


        //Calculer Une seule Offre prioritaire
        List<Offre__c> offCo2 = new List<Offre__c>();
        System.debug('MBEN: Size: ' + offCo1.size());
        if (offCo1.size() == 1) {
            offCo2 = offCo1.clone();
        } else {
            offCo2 = [
                    SELECT Id, Name, Intitule__c, HermesIntituleOffre__c, HermesIntituleOffreNL__c, RecordType.Name, Reference__c
                    FROM Offre__c
                    WHERE
                    Id IN :offCo1 AND
                    Id IN (SELECT Offre__c FROM OffreContrainte__c WHERE ContrainteSur__r.Id IN :offCo1 AND Action__c = 'Non-Prioritaire') AND
                    Id NOT IN (SELECT ContrainteSur__c FROM OffreContrainte__c WHERE Offre__c IN :offCo1 AND Action__c = 'Non-Prioritaire')
            ];
        }

        System.debug('MBEN: OffreCo Prioritaire: ' + offCo2);
        if (!offCo1.isEmpty() && offCo2.isEmpty()) {
            throw new RTException(RTExceptionCode.ERREUR_OFFRE_CYCLE_FERME);
            // TODO optionnel: concevoir un batch (bouton ou schedule) qui fait les test pour tous les lieux et notifier si incompatibilité (optionnelle)
        }
        return offCo2;
    }

    public static List<Offre__c> offrePromoCodeEligible(String prodRpRef, WSZ.SubOffreIn subIn, List<Offre__c> offCo, WSZ.CouponGeneric couponG) {
        // A-Verifier Coupon present dans : Dans BtoC generique + validite
        // B-Verifier Coupon present : Dans BtoC plusieurs Usage unique + validite
        // C-Verifier exitence de le ou les offres correspondante au coupon: (A: code coupon, B: code coupon du parent)
        // D-Verifier l eligibilite de loffrecodepromo

        List<Offre__c> offPromoCodes = new List<Offre__c>();
        SM_Coupon.getCouponGbyRef(subIn.coupon, couponG);

        if (couponG.RecordType == 'BtoB') {
            prodRpRef = 'B2B' + prodRpRef;
        } //pour filtrer avec une reference en input = UI1CDD
        System.debug('MBEN: couponG11 ' + couponG);
        // Verifier quantite du coupon (quantite disponible)
        if (!couponG.isAvailable) {
            throw new RTException(RTExceptionCode.ERREUR_OFFRE_COUPON_DEJA_UTILISE);
        }
        // Verifier date du coupon
        if (!(couponG.DateDebut <= subIn.dateSubscription && couponG.DateFin >= subIn.dateSubscription)) {
            throw new RTException(RTExceptionCode.ERREUR_OFFRE_COUPON_EXPIRE);
        }
        //Verifier l agent
        if (couponG.RecordType == 'BtoC Nominatif Agent' && couponG.Agent != subIn.agent) {
            throw new RTException(RTExceptionCode.ERREUR_OFFRE_COUPON_NON_VALABLE_AGENT);
        }
        //Verifier le client
        if (couponG.RecordType == 'BtoC Nominatif Client' && couponG.Account != subIn.crmId) {
            throw new RTException(RTExceptionCode.ERREUR_OFFRE_COUPON_NON_VALABLE_CLIENT);
        }

        //Trouver une offre eligible: filtre: produit,lieu,operation
        offPromoCodes = [
                SELECT Id, Name, Intitule__c, HermesIntituleOffre__c, HermesIntituleOffreNL__c, RecordType.Name, Promo__c, Reference__c
                FROM Offre__c
                WHERE Coupon__c = :couponG.Id
                AND DateDebut__c <= :subIn.dateSubscription AND DateFin__c >= :subIn.dateSubscription
                AND Promo__c IN (SELECT Promo__c FROM PromoProduit__c WHERE Produit__r.Reference__c = :prodRpRef)
                AND Id IN (SELECT Offre__c FROM OffreLieu__c WHERE CodeComplexe2__c = :subIn.lieu)
                AND Operation__c includes (:subIn.operation)
                LIMIT 1
        ];

        if (offPromoCodes.isEmpty()) {
            throw new RTException(RTExceptionCode.ERREUR_OFFRE_AUCUN_COUPON1);
        } else if (offPromoCodes.get(0).RecordType.Name == 'Offre BTOB') {
            return offPromoCodes;
        } else if (offCo.isEmpty()) { // Traiter les contraintes de loffrecodepromo avec l offrecommercial eligible(etape precedente)
            return offPromoCodes;
        } else if (offPromoCodes.get(0).RecordType.Name == 'Offre coupon') {
            if (offCo.isEmpty()) {
                return offPromoCodes;
            } else {
                List<OffreContrainte__c> contraintes = [
                        SELECT Id, Action__c
                        FROM OffreContrainte__c
                        WHERE
                        Offre__c = :offPromoCodes.get(0).Id AND
                        ContrainteSur__c = :offCo.get(0).Id
                ];
                if (contraintes.isEmpty()) {
                    throw new RTException(new RTExceptionCode('Probleme de configuration de l offre: contrainte absente entre :' + offCo.get(0).Name + ' AND '
                            + offPromoCodes.get(0).Name, 1007));
                } else {
                    if (contraintes.get(0).Action__c == 'Cumulable') {
                        return offPromoCodes;
                    } else if (contraintes.get(0).Action__c == 'Non-Cumulable') {
                        throw new RTException(new RTExceptionCode('Coupon non cumulable avec l offre commerciale en cours: ' +
                                offCo.get(0).Name + 'AND' + offPromoCodes.get(0).Name, 1008));
                    } else {
                        throw new RTException(new RTExceptionCode('Probleme de configuration de l offre: contrainte non configure entre :' +
                                offCo.get(0).Name + 'AND' + offPromoCodes.get(0).Name, 1009));
                    }
                }
            }
        } else {
            throw new RTException(RTExceptionCode.ERREUR_OFFRE_AUCUN_COUPON2);
        }
    }



    //Recupere les remise d une offre et construite le flux de retour des RatePlans
    public static List<WSZ.SubscribeToRatePlan> getRemisesRatePlans(Offre__c offre, WSZ.SubOffreIn subIn) {
        List<PromoRemise__c> remises = [
                SELECT Charge__r.Name, Montant__c, Charge__r.zid__c, Charge__r.ProdRatePlan__r.zid__c,
                        Charge__r.FamilleRPC__c, Promo__c, NombreMensu__c, DebuteXmois__c, Charge__r.Reference__c,
                        Charge__r.ReferenceCIC__c
                FROM PromoRemise__c
                WHERE
                        Promo__c IN (SELECT Promo__c FROM Offre__c WHERE Id = :offre.Id)
        ];

        List<WSZ.SubscribeToRatePlan> rps = new List<WSZ.SubscribeToRatePlan>();

        for (PromoRemise__c rem : remises) {
            System.debug('MBEN: Process getRemisesRatePlans - remise de offre: ' + offre.Id + ' : ' + rem);
            WSZ.SubscribeToRatePlan rp = new WSZ.SubscribeToRatePlan();
            WSZ.ChargeOverride ch = new WSZ.ChargeOverride();
            rp.productRatePlanId = rem.Charge__r.ProdRatePlan__r.zid__c;
            ch.productRatePlanChargeId = rem.Charge__r.zid__c;
            ch.intitule_c = offre.Intitule__c;
            ch.agent_c = subIn.agent;
            ch.lieu_c = subIn.lieu;


            // Remise d abonnement sur les 12 premier mois
            if (rem.Charge__r.FamilleRPC__c == 'ABOREM') {
                ch.discountAmount = rem.Montant__c;
                ch.endDateCondition = 'Specific_End_Date';
                ch.specificEndDate = Util.zDate((Util.finMois(subIn.dateSubscription) + 1).addYears(1));
            }

            if (rem.Charge__r.ReferenceCIC__c == 'REMMENS') { //OK
                ch.discountPercentage = rem.Montant__c;
                ch.endDateCondition = 'Fixed_Period';
                ch.upToPeriods = (Integer) rem.NombreMensu__c;
                ch.triggerEvent = 'USD';
                ch.triggerDate = Util.zDate(subIn.dateSubscription.toStartOfMonth().addMonths((Integer) rem.DebuteXmois__c));
                //ch.triggerDate = rem.DebuteXmois__c;
            }

            if (rem.Charge__r.ReferenceCIC__c == 'REMMONTANNUAL') {
                ch.discountAmount = rem.Montant__c;
                // ch.endDateCondition = 'Fixed_Period';
                // ch.upToPeriods = (Integer) rem.NombreMensu__c;
                ch.triggerEvent = 'USD';
                ch.triggerDate = Util.zDate(subIn.dateSubscription.toStartOfMonth());
                //ch.triggerDate = Util.zDate(subIn.dateSubscription.toStartOfMonth().addMonths((Integer) rem.DebuteXmois__c));
            }

            if (rem.Charge__r.ReferenceCIC__c == 'REMMONT') {
                ch.discountAmount = rem.Montant__c;
                ch.endDateCondition = 'Fixed_Period';
                ch.upToPeriods = (Integer) rem.NombreMensu__c;
                ch.triggerEvent = 'USD';
                ch.triggerDate = Util.zDate(subIn.dateSubscription.toStartOfMonth().addMonths((Integer) rem.DebuteXmois__c));
            }

            if (rem.Charge__r.ReferenceCIC__c == 'REMFRAISDOS') {
                ch.discountAmount = rem.Montant__c;
                // ch.endDateCondition = 'Fixed_Period';
                // ch.upToPeriods = (Integer) rem.NombreMensu__c;
                // ch.triggerEvent = 'USD';
                // ch.triggerDate = Util.zDate(subIn.dateSubscription.toStartOfMonth().addMonths((Integer) rem.DebuteXmois__c));
            }

            if (rem.Charge__r.ReferenceCIC__c == 'REMFRAISDOSRED') {
                ch.triggerEvent = 'USD';
                ch.triggerDate = Util.zDate(subIn.dateSubscription.toStartOfMonth());                
                ch.discountAmount = rem.Montant__c;
                // ch.endDateCondition = 'Fixed_Period';
                // ch.upToPeriods = (Integer) rem.NombreMensu__c;
                // ch.triggerEvent = 'USD';
                // ch.triggerDate = Util.zDate(subIn.dateSubscription.toStartOfMonth().addMonths((Integer) rem.DebuteXmois__c));
            }

/*            if (rem.Charge__r.FamilleRPC__c == 'ABO') {   //Abonnement B2B ce n est pas une remise
                ch.discountAmount = rem.Montant__c;
                ch.endDateCondition = 'Fixed_Period';
                ch.upToPeriods = (Integer) rem.NombreMensu__c;
                ch.triggerEvent = 'USD';
                ch.triggerDate = Util.zDate(subIn.dateSubscription.toStartOfMonth().addMonths((Integer) rem.DebuteXmois__c));
            }*/
            rp.chargeOverrides.add(ch);
            rps.add(rp);
        }
        return rps;
    }

    //Recupere les remise d une offre et construite le flux de retour des RatePlans
    public static List<WSZ.SubscribeToRatePlan> getBtoBRatePlan(Offre__c offre, WSZ.SubOffreIn subIn, WSZ.CouponGeneric couponG) {

        List<ProdRatePlanCharge__c> charges = [
                SELECT Name, zid__c, ProdRatePlan__c, ProductRatePlanZID__c
                FROM ProdRatePlanCharge__c
                WHERE
                        ProdRatePlan__c IN (SELECT Produit__c FROM PromoProduit__c WHERE Promo__c = :offre.Promo__c)
        ];

        List<WSZ.SubscribeToRatePlan> rps = new List<WSZ.SubscribeToRatePlan>();

        for (ProdRatePlanCharge__c charge : charges) {
            System.debug('MBEN: Process getPromoRatePlans - charge des produits de l offre: ' + offre.Id + ' : ' + charge);
            WSZ.SubscribeToRatePlan rp = new WSZ.SubscribeToRatePlan();
            WSZ.ChargeOverride ch = new WSZ.ChargeOverride();
            rp.productRatePlanId = charge.ProductRatePlanZID__c;
            ch.productRatePlanChargeId = charge.zid__c;
            ch.intitule_c = offre.Intitule__c;
            ch.agent_c = subIn.agent;
            ch.lieu_c = subIn.lieu;
            ch.price = couponG.PrixVente;
            rp.chargeOverrides.add(ch);
            rps.add(rp);
        }
        return rps;
    }

    // Ajoute tous les loeux du cinema a l offre
    public static void ajoutLieuAll(Id offId) {

        List<GroupMember> gpMembers = [SELECT Group.DeveloperName FROM GroupMember WHERE
        GroupId IN (SELECT Id FROM Group WHERE DeveloperName IN ('Offre_Managers_France','Offre_Managers_Belgique'))
        AND UserOrGroupId IN (SELECT OwnerId FROM Offre__c WHERE Id = :offId) LIMIT 1];

        String countryCode='aucun';
        String gpName = gpMembers[0].Group.DeveloperName;

/* commente car gere par la visilibilite du user sur  l objet cinema
if (gpName == 'Offre_Managers_France')  {
            countryCode='033';
        } else if (gpName == 'Offre_Managers_Belgique') {
            countryCode='032';
        } else {
            System.debug('MBEN: utilisateur absent du public group offre managers xxx');
        }*/
// [SELECT Id, CodeComplexe__c FROM Complexe__c WHERE EstActif__c = TRUE AND CodePays__c = :countryCode
//        AND Point_vente_UI__c = TRUE]

        List<OffreLieu__c> offreLieux = new List<OffreLieu__c>();
        for (Complexe__c complexe : [SELECT Id, CodeComplexe__c FROM Complexe__c WHERE EstActif__c = TRUE
        AND Point_vente_UI__c = TRUE]) {
            offreLieux.add(new OffreLieu__c(Complexe__c = complexe.Id, CodeComplexe__c = complexe.CodeComplexe__c, Offre__c = offId));
        }
        delete [SELECT Id FROM OffreLieu__c WHERE Offre__c = :offId];
        insert offreLieux;
    }
}