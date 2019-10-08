/**
 * Created by mouad on 02/11/2018.
 */

public without sharing class SM_Coupon {

    /**
     * cree en masse les couponItems des coupon de type multiples
     * @param  coupId du parent (coupon__c)
     */
    public static void generateCouponItems(Id coupId){
        List<CouponItem__c> couponItems = new List<CouponItem__c>();
        // Coupon__c coupon = [SELECT Id, NombreCaracteres__c, Prefixe__c, Quantite__c, InclureChiffres__c, RecordType.Name
        //         FROM Coupon__c WHERE Id = :coupId LIMIT 1];
        List<Coupon__c> listCoupon = new List<Coupon__c>([SELECT Id, NombreCaracteres__c, Prefixe__c, Quantite__c, InclureChiffres__c, RecordType.Name
                FROM Coupon__c WHERE Id = :coupId and Type__c = 'Multiples' LIMIT 1]);
        if (listCoupon.size() == 0) {
            throw new RTException(RTExceptionCode.ERREUR_COUPON_MULTIPLE_NON_TROUVE);
        }
        Coupon__c coupon = listCoupon.get(0);

        String mCode = '';
        Id recTypeId = [SELECT Id FROM RecordType WHERE SobjectType='CouponItem__c' AND Name = :coupon.RecordType.Name LIMIT 1].Id;
        Integer qte = coupon.Quantite__c.intValue();
        Integer nbrCar = coupon.NombreCaracteres__c.intValue();        

        for (Integer i = 0; i < qte; i++){
            mCode = Util.generateRandomString(nbrCar, coupon.InclureChiffres__c);
            mCode = coupon.Prefixe__c + mCode;
            System.debug('MBEN: Code: ' + mCode);            
            System.debug('MBEN+ recTypeId: ' + recTypeId);
            couponItems.add(new CouponItem__c(Name=mCode, Coupon__c=coupId, RecordTypeId=recTypeId));
        }
        if (!couponItems.isEmpty()) {insert couponItems;}
    }

    /**
     * consommer description
     * @param  coup    coupon description
     * @param  dateSub date souscription description
     */
    public static void consommer(String coup, Date dateSub) {

        WSZ.CouponGeneric couponG = new WSZ.CouponGeneric();
        getCouponGbyRef(coup, couponG);

        switch on couponG.RecordType {
            when 'BtoB' {
                if (!couponG.isAvailable) {
                    throw new RTException(RTExceptionCode.ERREUR_COUPON_DEJA_UTILISE);
                } else if (!(couponG.DateDebut <= dateSub && couponG.DateFin >= dateSub)) {
                    throw new RTException(RTExceptionCode.ERREUR_COUPON_EXPIRE);
                } else {
                    CouponItem__c couponItem = [SELECT Id FROM CouponItem__c WHERE Name = :coup LIMIT 1];
                    couponItem.Utilise__c = true;
                    update couponItem;
                }
            }
            when 'BtoC generique' {
                if (!couponG.isAvailable) {
                    throw new RTException(RTExceptionCode.ERREUR_COUPON_DEJA_UTILISE);
                } else {
                    Coupon__c coupon = [SELECT Id,QuantiteUtilise__c FROM Coupon__c WHERE Name = :coup LIMIT 1];
                    coupon.QuantiteUtilise__c = coupon.QuantiteUtilise__c + 1;
                    update coupon;
                }
            }
            when 'BtoC multiples' {
                if (!couponG.isAvailable) {
                    throw new RTException(RTExceptionCode.ERREUR_COUPON_DEJA_UTILISE);
                } else {
                    CouponItem__c couponItem = [SELECT Id FROM CouponItem__c WHERE Name = :coup LIMIT 1];
                    couponItem.Utilise__c = true;
                    update couponItem;
                }
            }
            when else {
                throw new RTException(RTExceptionCode.ERREUR_COUPON);
            }
        }
    }

    public static WSZ.CouponGeneric getCouponGbyRef(String coup, WSZ.CouponGeneric couponG) {
        //couponG = getCouponG(coup);
        //WSZ.CouponGeneric couponG = new WSZ.CouponGeneric();

        // A-Verifier Coupon present dans : Dans BtoC generique / BTOC usage unique
        List<Coupon__c> coupons1 = [
                SELECT Id, Name, RecordTypeId, DateDebut__c, DateFin__c, QuantiteDisponible__c, PrixVente__c, QuantiteUtilise__c,Type__c,
                        RecordType.Name
                FROM Coupon__c
                WHERE Name = :coup AND Type__c IN ('Generique')
                LIMIT 1
        ];

        // B-Verifier Coupon present : Dans BtoC plusieurs Usage unique + validite
        List<CouponItem__c> coupons2 = [
                SELECT Id, Name, Coupon__r.Id, Coupon__r.RecordTypeId, Coupon__r.DateDebut__c, Coupon__r.DateFin__c, Utilise__c, Coupon__r.Type__c,
                        Coupon__r.RecordType.Name, PrixVente__c, Agent__r.Code__c, Account__c, DateDebut__c, DateFin__c
                FROM CouponItem__c
                WHERE Name = :coup AND Coupon__r.Type__c IN ('Multiples')
        ];


        if (coupons1.isEmpty() && coupons2.isEmpty()) {
            //throw new RTException('erreur coupon non trouve','ERREUR_COUPON_NON_TROUVE');
            throw new RTException(RTExceptionCode.ERREUR_COUPON_NON_TROUVE);
            //return null;
        } else {
            if (!coupons1.isEmpty()) {
                if (coupons1.get(0).RecordType.Name == 'BtoC generique') {
                    couponG.Id = coupons1.get(0).Id;
                    couponG.Name = coupons1.get(0).Name;
                    //couponG.RecordType = [SELECT Name FROM RecordType WHERE Id = :coupons1.get(0).RecordTypeId LIMIT 1].Name;
                    couponG.RecordType = coupons1.get(0).RecordType.Name;
                    couponG.DateDebut = coupons1.get(0).DateDebut__c;
                    couponG.DateFin = coupons1.get(0).DateFin__c;
                    couponG.QuantiteDisponible = coupons1.get(0).QuantiteDisponible__c;
                    couponG.QuantiteUtilise = coupons1.get(0).QuantiteUtilise__c;
                    //couponG.PrixVente = coupons1.get(0).PrixVente__c;
                    couponG.isAvailable = (couponG.QuantiteDisponible > 0);
                    System.debug('MBEN: couponG1: ' + couponG);
                    return couponG;
                }
            }
            if (!coupons2.isEmpty()) {
                couponG.Id = coupons2.get(0).Coupon__c;
                couponG.ItemId = coupons2.get(0).Id;
                couponG.Name = coupons2.get(0).Name;
                couponG.RecordType = coupons2.get(0).Coupon__r.RecordType.Name;
                //[SELECT Name FROM RecordType WHERE Id = :coupons2.get(0).Coupon__r.RecordTypeId LIMIT 1].Name;
                couponG.Utilise = coupons2.get(0).Utilise__c;
                couponG.isAvailable = (couponG.Utilise == false);

                if (couponG.RecordType == 'BtoC multiples') {
                    couponG.DateDebut = coupons2.get(0).Coupon__r.DateDebut__c; // date du parent
                    couponG.DateFin = coupons2.get(0).Coupon__r.DateFin__c;  // date du parent
                }
                if (couponG.RecordType == 'BtoC Nominatif Agent') {
                    couponG.DateDebut = coupons2.get(0).DateDebut__c;
                    couponG.DateFin = coupons2.get(0).DateFin__c;
                    couponG.Agent = coupons2.get(0).Agent__r.Code__c;
                }
                if (couponG.RecordType == 'BtoC Nominatif Client') {
                    couponG.DateDebut = coupons2.get(0).DateDebut__c;
                    couponG.DateFin = coupons2.get(0).DateFin__c;
                    couponG.Account = coupons2.get(0).Account__c;
                }
                if (couponG.RecordType == 'BtoB') {
                    couponG.DateDebut = coupons2.get(0).DateDebut__c;
                    couponG.DateFin = coupons2.get(0).DateFin__c;
                    couponG.PrixVente = coupons2.get(0).PrixVente__c; // prix vente
                }
                return couponG;
            }
        }
        return couponG;
    }

    /**
     * generateCouponItem cree 1 coupon Item pour le parent (coupon__c) pour welcome back
     * @param  coupId    Id du coupon parent
     * @param  accountId Id du compte SF pour les coupon welcome back
     * @param  dateDebut Date du coupon
     * @param  datefin   Date du coupon
     */
    public static String generateCouponItem(Id coupId, Id accountId, Date dateDebut, Date dateFin){
        String mCode = '';
        String recTypeId = '';
        List<CouponItem__c> couponItems = new List<CouponItem__c>();
        Coupon__c coupon = [SELECT Id, NombreCaracteres__c, Prefixe__c, Quantite__c, InclureChiffres__c, RecordType.Name
                FROM Coupon__c WHERE Id = :coupId LIMIT 1];
        // Integer qte = coupon.Quantite__c.intValue();        
        mCode = Util.generateRandomString(coupon.NombreCaracteres__c.intValue(), coupon.InclureChiffres__c);
        mCode = coupon.Prefixe__c + mCode;       
        recTypeId = [SELECT Id FROM RecordType WHERE SobjectType='CouponItem__c' AND Name = :coupon.RecordType.Name LIMIT 1].Id;
        if (recTypeId != null) {couponItems.add(new CouponItem__c(Name=mCode, Coupon__c=coupId, RecordTypeId=recTypeId, Account__c=accountId, DateDebut__c=dateDebut,DateFin__c=dateFin ));}        
        if (!couponItems.isEmpty()) {insert couponItems;}
        return mCode;
    }



/*    public static WSZ.CouponGeneric getCouponG(String coup){

            WSZ.CouponGeneric couponG = new WSZ.CouponGeneric();

            // A-Verifier Coupon present dans : Dans BtoC generique / BTOC usage unique
            List<Coupon__c> coupons1 = [
                    SELECT Id, Name, RecordTypeId, DateDebut__c, DateFin__c, QuantiteDisponible__c, PrixVente__c, QuantiteUtilise__c,Type__c
                    FROM Coupon__c
                    WHERE Name = :coup AND Type__c IN ('Usage unique', 'Usage multiple')
                    LIMIT 1
            ];

            // B-Verifier Coupon present : Dans BtoC plusieurs Usage unique + validite
            List<CouponItem__c> coupons2 = [
                    SELECT Id, Name, Coupon__r.Id, Coupon__r.RecordTypeId, Coupon__r.DateDebut__c, Coupon__r.DateFin__c, Utilise__c, Coupon__r.Type__c
                    FROM CouponItem__c
                    WHERE Name = :coup AND Coupon__r.Type__c IN ('Plusieurs usages uniques')
            ];

            // B-bis-Verifier Coupon present : Dans BTBO plusieurs Usage unique + validite
            List<CouponItem__c> coupons3 = [
                    SELECT Id, Name, Coupon__r.Id, Coupon__r.RecordTypeId, DateDebut__c, DateFin__c, Utilise__c, Coupon__r.Type__c, PrixVente__c
                    FROM CouponItem__c
                    WHERE Name = :coup AND Coupon__r.Type__c IN ('Plusieurs usages uniques - BtoB')
            ];


            if (coupons1.isEmpty() && coupons2.isEmpty() && coupons3.isEmpty()) {
                //throw new RTException('erreur coupon non trouve','ERREUR_COUPON_NON_TROUVE');
                throw new RTException(RTExceptionCode.ERREUR_COUPON_NON_TROUVE);
                //return null;
            } else {
                if (!coupons1.isEmpty()) {
                    couponG.Id = coupons1.get(0).Id;
                    couponG.Name = coupons1.get(0).Name;
                    couponG.RecordType = [SELECT Name FROM RecordType WHERE Id = :coupons1.get(0).RecordTypeId LIMIT 1].Name;
                    couponG.DateDebut = coupons1.get(0).DateDebut__c;
                    couponG.DateFin = coupons1.get(0).DateFin__c;
                    couponG.QuantiteDisponible = coupons1.get(0).QuantiteDisponible__c;
                    couponG.QuantiteUtilise = coupons1.get(0).QuantiteUtilise__c;
                    //couponG.PrixVente = coupons1.get(0).PrixVente__c;
                    couponG.isAvailable = (couponG.QuantiteDisponible > 0);
                    System.debug('MBEN: couponG1: ' + couponG);
                    return couponG;
                } else if (!coupons2.isEmpty()) {
                    couponG.Id = coupons2.get(0).Coupon__c;
                    couponG.ItemId = coupons2.get(0).Id;
                    couponG.Name = coupons2.get(0).Name;
                    couponG.RecordType = [SELECT Name FROM RecordType WHERE Id = :coupons2.get(0).Coupon__r.RecordTypeId LIMIT 1].Name;
                    couponG.DateDebut = coupons2.get(0).Coupon__r.DateDebut__c;
                    couponG.DateFin = coupons2.get(0).Coupon__r.DateFin__c;
                    couponG.Utilise = coupons2.get(0).Utilise__c;
                    couponG.PrixVente = coupons2.get(0).PrixVente__c;
                    //coupon.isAvailable = (coupon.Utilise == true) ? false : true;
                    couponG.isAvailable = (couponG.Utilise == false);
                    //coupon.isAvailable = (coupon.Utilise == false) ? true:false;
                    System.debug('MBEN: couponG2: ' + couponG);
                    return couponG;
                }else if (!coupons3.isEmpty()) {
                    couponG.Id = coupons3.get(0).Coupon__c;
                    couponG.ItemId = coupons3.get(0).Id;
                    couponG.Name = coupons3.get(0).Name;
                    couponG.RecordType = [SELECT Name FROM RecordType WHERE Id = :coupons3.get(0).Coupon__r.RecordTypeId LIMIT 1].Name;
                    couponG.DateDebut = coupons3.get(0).DateDebut__c;
                    couponG.DateFin = coupons3.get(0).DateFin__c;
                    couponG.Utilise = coupons3.get(0).Utilise__c;
                    couponG.PrixVente = coupons3.get(0).PrixVente__c;
                    //coupon.isAvailable = (coupon.Utilise == true) ? false : true;
                    couponG.isAvailable = (couponG.Utilise == false);
                    //coupon.isAvailable = (coupon.Utilise == false) ? true:false;
                    System.debug('MBEN: couponG3: ' + couponG);
                    return couponG;
                }else {
                    System.debug('MBEN: couponG: inconnu' + couponG);
                    return couponG;
                }
            }
    }*/

}