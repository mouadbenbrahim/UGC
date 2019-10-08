/**
 * Created by mouad on 11/11/2018.
 */

public with sharing class RTExceptionCode {

    private static final Map<String, RTExceptionCode> codes = new Map<String, RTExceptionCode>();

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
    public static final RTExceptionCode ERREUR_GESTCO_CDD_PRODUIT_ABSENT = new RTExceptionCode('Pas de Product Rate Plan Charge trouvee pour le geste commercial', 1016);
    public static final RTExceptionCode ERREUR_GESTCO_APPLICATION_CDD = new RTExceptionCode('Erreur Application du Gestco sur un CDD', 1017);
    
    public static final RTExceptionCode ERREUR_DESABO_CDI_AVEC_FINCONTRAT = new RTExceptionCode('Ce contrat comprend deja une date fin contrat', 2001);
    public static final RTExceptionCode ERREUR_DESABO_CDD_AVEC_FINCONTRAT = new RTExceptionCode('Ce contrat comprend deja une date fin contrat', 2002);
    public static final RTExceptionCode ERREUR_DESABO_DATE_FINCONTRAT_OBLIGATOIRE = new RTExceptionCode('La date fin contrat est obligatoire', 2003);    
    public static final RTExceptionCode ERREUR_DESABO_BATCH_CASE_ABSENT = new RTExceptionCode('La souscription n a pas de demande desabo rattache', 2003);

    public static final RTExceptionCode ERREUR_ANNUL_DESABO_CONTRAT_DEJA_ACTIF = new RTExceptionCode('Annulation desabo impossible: le contrat est deja actif', 2101);
    public static final RTExceptionCode ERREUR_ANNUL_DESABO_PERIODLATENCE_DEPASSE = new RTExceptionCode('Annulation desabo impossible: la periode de latence depasse', 2102);    
    public static final RTExceptionCode ERREUR_ANNUL_DESABO_AUCUN_CONTRAT_TROUVE = new RTExceptionCode('Erreur Annulation desabo: aucun contrat trouve a annule', 2103);
    public static final RTExceptionCode ERREUR_ANNUL_DESABO_DATEFINCONTRAT_VIDE = new RTExceptionCode('Erreur Annulation desabo: la date fin contrat est vide', 2104);
    public static final RTExceptionCode ERREUR_ANNUL_DESABO_STATUT_CONTRAT_NON_VALIDE = new RTExceptionCode('Erreur Annulation desabo: le statut du contrat est non valide', 2105);
    public static final RTExceptionCode ERREUR_ANNUL_DESABO_CDD_DEJA_INACTIF = new RTExceptionCode('Erreur Annulation desabo: ce CDD est deja inactif', 2106);          
       

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