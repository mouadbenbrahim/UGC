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