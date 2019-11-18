/**
 * Created by mouad on 11/11/2018.
 */

public with sharing class RTExceptionCode {

    private static final Map<String, RTExceptionCode> codes = new Map<String, RTExceptionCode>();

    public static final RTExceptionCode ERREUR_GENERIC_RUNPARSE2 = new RTExceptionCode('Erreur generic runParse2', 801);

    public static final RTExceptionCode ERREUR_COUPON_NON_TROUVE = new RTExceptionCode('NEW erreur coupon non trouve', 1001);
    public static final RTExceptionCode ERREUR_COUPON_DEJA_UTILISE = new RTExceptionCode('erreur coupon deja utilise', 1002);
    public static final RTExceptionCode ERREUR_COUPON = new RTExceptionCode('erreur coupon', 1003);
    public static final RTExceptionCode ERREUR_COUPON_EXPIRE = new RTExceptionCode('erreur coupon expire', 1004);
    public static final RTExceptionCode ERREUR_OFFRE_CYCLE_FERME = new RTExceptionCode('erreur Offre : contacter l administrateur du site', 1005);
    public static final RTExceptionCode ERREUR_OFFRE_AUCUN_COUPON1 = new RTExceptionCode('Aucune offre n est valable avec ce coupon', 1006);
    public static final RTExceptionCode ERREUR_OFFRE_CONTRAINTE_ABSENTE = new RTExceptionCode('Probleme de configuration de l offre: contrainte absente entre :', 1007);
    public static final RTExceptionCode ERREUR_OFFRE_COUPON_NON_CUMULABLE = new RTExceptionCode('Coupon non cumulable avec l offre commerciale en cours', 1008);
    public static final RTExceptionCode ERREUR_OFFRE_CONTRAINTE_NON_CONFIGURE = new RTExceptionCode('Probleme de configuration de l offre: contrainte non configure entre :', 1009);
    public static final RTExceptionCode ERREUR_OFFRE_COUPON_DEJA_UTILISE = new RTExceptionCode('erreur coupon deja utilise', 1010);
    public static final RTExceptionCode ERREUR_OFFRE_COUPON_EXPIRE = new RTExceptionCode('erreur coupon expire', 1011);
    public static final RTExceptionCode ERREUR_OFFRE_COUPON_NON_VALABLE_AGENT = new RTExceptionCode('erreur coupon non valable pour cet agent', 1012);
    public static final RTExceptionCode ERREUR_OFFRE_COUPON_NON_VALABLE_CLIENT = new RTExceptionCode('erreur coupon non valable pour ce client', 1013);
    public static final RTExceptionCode ERREUR_OFFRE_AUCUN_COUPON2 = new RTExceptionCode('Aucune offre n est valable avec ce coupon', 1014);
    public static final RTExceptionCode ERREUR_COUPON_MULTIPLE_NON_TROUVE = new RTExceptionCode('erreur coupon multiple non trouve', 1015);

    public static final RTExceptionCode ERREUR_GESTCO_CDD_PRODUIT_ABSENT = new RTExceptionCode('Pas de Product Rate Plan Charge trouvee pour le geste commercial', 1101);
    public static final RTExceptionCode ERREUR_GESTCO_APPLICATION_CDD = new RTExceptionCode('Erreur Application du Gestco sur un CDD', 1102);
    public static final RTExceptionCode ERREUR_GESTCO_CONTRAT_ABSENT_DDE = new RTExceptionCode('Abonnement absent de la demande: pas dabo, plusieurs ou inactif', 1103);
    //public static final RTExceptionCode ERREUR_GESTCO_APPLICATION_CDD = new RTExceptionCode('Erreur Application du Gestco sur un CDD', 1102);
    //public static final RTExceptionCode ERREUR_GESTCO_APPLICATION_CDD = new RTExceptionCode('Erreur Application du Gestco sur un CDD', 1102);
    

    public static final RTExceptionCode ERREUR_RETENTION_PRODUIT_ABSENT = new RTExceptionCode('Pas de Product Rate Plan Charge trouvee pour la retention', 1301);
    public static final RTExceptionCode ERREUR_RETENTION_APPLICATION = new RTExceptionCode('Erreur Application de la retention', 1302);    
    
    public static final RTExceptionCode ERREUR_DESABO_CDI_AVEC_FINCONTRAT = new RTExceptionCode('Ce contrat comprend deja une date fin contrat', 2001);
    public static final RTExceptionCode ERREUR_DESABO_CDD_AVEC_FINCONTRAT = new RTExceptionCode('Ce contrat comprend deja une date fin contrat', 2002);
    public static final RTExceptionCode ERREUR_DESABO_DATE_FINCONTRAT_OBLIGATOIRE = new RTExceptionCode('La date fin contrat est obligatoire', 2003);    
    public static final RTExceptionCode ERREUR_DESABO_COUPON_WELCOMEBACK = new RTExceptionCode('Erreur desabo: configuration coupon/offre welcome back', 2004);
    public static final RTExceptionCode ERREUR_DESABO_COUPON_ABOTIER = new RTExceptionCode('Erreur desabo: configuration coupon/offre abo tier', 2005);
    public static final RTExceptionCode ERREUR_DESABO_CONTRAT_ABSENT_DDE = new RTExceptionCode('Abonnement absent de la demande: pas dabo, plusieurs ou inactif', 2006);
    public static final RTExceptionCode ERREUR_DESABO_DDE_DEJA_TRAITE = new RTExceptionCode('Cette demande a deja ete traite', 2007);
    public static final RTExceptionCode ERREUR_DESABO_SSMOTIF_OBLIGATOIRE = new RTExceptionCode('Sous-Motif obligatoire', 2008);
    public static final RTExceptionCode ERREUR_DESABO_TYPEDESABO_OBLIGATOIRE = new RTExceptionCode('Type de désabonnement obligatoire', 2009);
    public static final RTExceptionCode ERREUR_DESABO_ABO_NONACTIF = new RTExceptionCode('L abonnement n est pas actif', 2010);
    public static final RTExceptionCode ERREUR_DESABO_ABO_NONACTIF2 = new RTExceptionCode('L abonnement n est pas actif', 2011);
    public static final RTExceptionCode ERREUR_DESABO_DATEDESABO_OBLIGATOIRE = new RTExceptionCode('Veuillez saisir une date de désabonnement', 2012);
    public static final RTExceptionCode ERREUR_DESABO_CDD_IMPOSSIBLE = new RTExceptionCode('Pas possible de desabonner un contrat CDD, le contrat sera automatique désabonné à la date de fin de contrat', 2013);
    public static final RTExceptionCode ERREUR_DESABO_SANSCASE_NONACTIF = new RTExceptionCode('Contrat Bilendi: L abonnement n est pas actif', 2014);
    public static final RTExceptionCode ERREUR_DESABO_SANSCASE_IMPOSSIBLE = new RTExceptionCode('Contrat Bilendi : desabonnement non possible pour les CDD', 2015);
    public static final RTExceptionCode ERREUR_DESABO_BATCH_NON_CONFORME = new RTExceptionCode('La souscription non conforme: CDI: non bilendi, sans case', 2016);
    public static final RTExceptionCode ERREUR_DESABO_APPLICATION_CANCEL1 = new RTExceptionCode('problem cancel de la souscription', 2017);
    public static final RTExceptionCode ERREUR_DESABO_APPLICATION_CANCEL2 = new RTExceptionCode('problem cancel de la souscription', 2018);
    public static final RTExceptionCode ERREUR_DESABO_APPLICATION_UPDATESUB = new RTExceptionCode('Erreur desabo: problem mise a jour de la souscription', 2019);
    public static final RTExceptionCode ERREUR_DESABO_APPLICATION_UPDATESUB2 = new RTExceptionCode('Erreur desabo: problem mise a jour de la souscription', 2020);
    public static final RTExceptionCode ERREUR_DESABO_APPLICATION_UPDATESUB3 = new RTExceptionCode('Erreur desabo: problem mise a jour de la souscription', 2021);
    
    

    public static final RTExceptionCode ERREUR_ANNUL_DESABO_CONTRAT_DEJA_ACTIF = new RTExceptionCode('Annulation desabo impossible: le contrat est deja actif', 2101);
    public static final RTExceptionCode ERREUR_ANNUL_DESABO_PERIODLATENCE_DEPASSE = new RTExceptionCode('Annulation desabo impossible: la periode de latence depasse', 2102);    
    public static final RTExceptionCode ERREUR_ANNUL_DESABO_AUCUN_CONTRAT_TROUVE = new RTExceptionCode('Erreur Annulation desabo: aucun contrat trouve a annule', 2103);
    public static final RTExceptionCode ERREUR_ANNUL_DESABO_DATEFINCONTRAT_VIDE = new RTExceptionCode('Erreur Annulation desabo: la date fin contrat est vide', 2104);
    public static final RTExceptionCode ERREUR_ANNUL_DESABO_STATUT_CONTRAT_NON_VALIDE = new RTExceptionCode('Erreur Annulation desabo: le statut du contrat est non valide', 2105);
    public static final RTExceptionCode ERREUR_ANNUL_DESABO_CDD_DEJA_INACTIF = new RTExceptionCode('Erreur Annulation desabo: ce CDD est deja inactif', 2106);
    public static final RTExceptionCode ERREUR_ANNUL_DESABO_UPDATE_SUB = new RTExceptionCode('Erreur Annulation desabo: pb mise jour contrat', 2107);
    public static final RTExceptionCode ERREUR_ANNUL_DESABO_UPDATE_SUB2 = new RTExceptionCode('Erreur Annulation desabo: pb mise jour contrat', 2108);    
    public static final RTExceptionCode ERREUR_ANNUL_DESABO_DELETE_SUB = new RTExceptionCode('Erreur Annulation desabo: pb suppression du cancel', 2109);        

    
    public static final RTExceptionCode ERREUR_IMPAYE_GET_SOUSCRITPION_NON_TROUVE = new RTExceptionCode('Erreur Affichage impaye: Contrat absent', 3101);
    public static final RTExceptionCode ERREUR_IMPAYE_GET_ACCOUNT_NON_TROUVE = new RTExceptionCode('Erreur Affichage impaye: Compte absent', 3102);
    public static final RTExceptionCode ERREUR_IMPAYE_GET_ACCOUNT_NON_TROUVE2 = new RTExceptionCode('Erreur Affichage impaye: Compte absent pour ce contrat', 3103);
    
    public static final RTExceptionCode ERREUR_IMPAYE_REGLER_SOUSCRITPION_NON_TROUVE = new RTExceptionCode('Erreur Reglement impaye: Contrat absent', 3201);
    public static final RTExceptionCode ERREUR_IMPAYE_REGLER_PAS_DE_DETTE = new RTExceptionCode('Erreur Reglement impaye: aucun impaye a regler', 3202);
    public static final RTExceptionCode ERREUR_IMPAYE_REGLER_DELETE_SUB = new RTExceptionCode('Erreur Reglement impaye: probleme dans le contrat', 3203);
    public static final RTExceptionCode ERREUR_IMPAYE_REGLER_PROBLEM_PREVIEW = new RTExceptionCode('Erreur Reglement impaye: probleme dans la preview de dette non echue', 3204);
    public static final RTExceptionCode ERREUR_IMPAYE_REGLER_PROBLEM_MONTANT = new RTExceptionCode('Erreur Reglement impaye: probleme dans le montant de l impaye', 3205);
    public static final RTExceptionCode ERREUR_IMPAYE_REGLER_MONTANT_DNE = new RTExceptionCode('Erreur Reglement impaye: probleme dans le montant de la dette non echue', 3206);
    public static final RTExceptionCode ERREUR_IMPAYE_REGLER_PRODUIT_ABSENT = new RTExceptionCode('Erreur Reglement impaye: produit frais de reactivation absent', 3207);
    public static final RTExceptionCode ERREUR_IMPAYE_REGLER_APPLICATION_FRAIS = new RTExceptionCode('Erreur Reglement impaye: probleme application frais de gestion', 3208);
    public static final RTExceptionCode ERREUR_IMPAYE_REGLER_APPLICATION_PAYMENT = new RTExceptionCode('Erreur Reglement impaye: probleme application payment', 3209);
    public static final RTExceptionCode ERREUR_IMPAYE_REGLER_TARGETDATE_STATUSCONTRAT = new RTExceptionCode('Erreur Reglement impaye: probleme incoherence target date et status contrat', 3210);
    public static final RTExceptionCode ERREUR_IMPAYE_REGLER_UPDATE_ACCOUNT = new RTExceptionCode('Erreur Reglement impaye: probleme mise a jour du compte', 3211);
    public static final RTExceptionCode ERREUR_IMPAYE_REGLER_UPDATE_INVOICE = new RTExceptionCode('Erreur Reglement impaye: probleme mise a jour facture', 3212);
    public static final RTExceptionCode ERREUR_IMPAYE_REGLER_UPDATE_SUBSCRIPTION = new RTExceptionCode('Erreur Reglement impaye: probleme mise a jour contrat', 3213);
    public static final RTExceptionCode ERREUR_IMPAYE_REGLER_INCOHERENCE_DATEFIN = new RTExceptionCode('Erreur Reglement impaye: probleme incoherence dans la date fin du contrat', 3214);
    public static final RTExceptionCode ERREUR_IMPAYE_REGLER_APPLICATION_BILL_DNE = new RTExceptionCode('Erreur Reglement impaye: probleme billing de la dette non echue', 3215);
    public static final RTExceptionCode ERREUR_IMPAYE_REGLER_APPLICATION_CANCEL = new RTExceptionCode('Erreur Reglement impaye: probleme billing de la dette non echue', 3216);
    public static final RTExceptionCode ERREUR_IMPAYE_REGLER_UPDATE_INVOICE2 = new RTExceptionCode('Erreur Reglement impaye: probleme maj invoice: aucune facture trouve avec une compteur rejet', 3217);    
    

    public static final RTExceptionCode ERREUR_ACQUISIT_GET_ZSUBSCRIPTION = new RTExceptionCode('Erreur Acquisition : probleme get subscription zuora', 4101);
    public static final RTExceptionCode ERREUR_ACQUISIT_GET_ACCOUNT = new RTExceptionCode('Erreur Acquisition : probleme get account zuora', 4102);
    public static final RTExceptionCode ERREUR_ACQUISIT_GET_PAYMENTMETHOD = new RTExceptionCode('Erreur Acquisition : probleme get payment method zuora', 4103);    
    
    public static final RTExceptionCode ERREUR_MIGRATION_GET_ZSUBSCRIPTION = new RTExceptionCode('Erreur Migration : probleme get subscription zuora', 4201);
    public static final RTExceptionCode ERREUR_REEDITION_GET_ZSUBSCRIPTION = new RTExceptionCode('Erreur Reedition : probleme get subscription zuora', 4301);
    public static final RTExceptionCode ERREUR_RENOUV_GET_ZSUBSCRIPTION = new RTExceptionCode('Erreur Renouvellement : probleme get subscription zuora', 4401);
    public static final RTExceptionCode ERREUR_CHGBANQUE_GET_ZSUBSCRIPTION = new RTExceptionCode('Erreur Changement Coord Bancaire : probleme get subscription zuora', 4501);
    

       

    //'Aucune offre n est valable avec ce coupon', 'ERREUR_COUPON_AUCUNE_OFFRE_VALABLE'

    public static final RTExceptionCode OPEN = new RTExceptionCode('Open', 30);
    public static final RTExceptionCode CLOSED = new RTExceptionCode('Closed', 60);

    public static RTExceptionCode valueOf(String name) {
        return codes.get(name);
    }

    public static RTExceptionCode[] values() {
        return codes.values();
    }

    public String libelle {get; private set;}
    public Integer code {get; private set;}

    public RTExceptionCode(String libelle, Integer code) {
        this.libelle = libelle;
        this.code = code;
        codes.put(libelle, this);
    }

/*    public override String toString() {
        return libelle;
    }

    public Boolean equals(Object o) {
        if (o instanceof RTExceptionCode) {
            RTExceptionCode that = ((RTExceptionCode) o);
            return this.libelle == that.libelle;
        }
        return false;
    }

    public Integer hashCode() {
        return libelle.hashCode();
    }*/

}