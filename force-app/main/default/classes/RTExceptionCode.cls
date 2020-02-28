/**
 * Created by mouad on 11/11/2018.
 */

public with sharing class RTExceptionCode {

    private static final Map<String, RTExceptionCode> codes = new Map<String, RTExceptionCode>();

    public static final RTExceptionCode ERREUR_GENERIC_RUNPARSE2 								= new RTExceptionCode('Erreur generic runParse2', 801);

    public static final RTExceptionCode ERREUR_COUPON_NON_TROUVE 								= new RTExceptionCode('NEW erreur coupon non trouve', 1001);
    public static final RTExceptionCode ERREUR_COUPON_DEJA_UTILISE 								= new RTExceptionCode('erreur coupon deja utilise', 1002);
    public static final RTExceptionCode ERREUR_COUPON 											= new RTExceptionCode('erreur coupon', 1003);
    public static final RTExceptionCode ERREUR_COUPON_EXPIRE 									= new RTExceptionCode('erreur coupon expire', 1004);
    public static final RTExceptionCode ERREUR_OFFRE_CYCLE_FERME 								= new RTExceptionCode('erreur Offre : contacter l administrateur du site', 1005);
    public static final RTExceptionCode ERREUR_OFFRE_AUCUN_COUPON1 								= new RTExceptionCode('Aucune offre n est valable avec ce coupon', 1006);
    public static final RTExceptionCode ERREUR_OFFRE_CONTRAINTE_ABSENTE 						= new RTExceptionCode('Probleme de configuration de l offre: contrainte absente entre :', 1007);
    public static final RTExceptionCode ERREUR_OFFRE_COUPON_NON_CUMULABLE 						= new RTExceptionCode('Coupon non cumulable avec l offre commerciale en cours', 1008);
    public static final RTExceptionCode ERREUR_OFFRE_CONTRAINTE_NON_CONFIGURE 					= new RTExceptionCode('Probleme de configuration de l offre: contrainte non configure entre :', 1009);
    public static final RTExceptionCode ERREUR_OFFRE_COUPON_DEJA_UTILISE 						= new RTExceptionCode('erreur coupon deja utilise', 1010);
    public static final RTExceptionCode ERREUR_OFFRE_COUPON_EXPIRE 								= new RTExceptionCode('erreur coupon expire', 1011);
    public static final RTExceptionCode ERREUR_OFFRE_COUPON_NON_VALABLE_AGENT 					= new RTExceptionCode('erreur coupon non valable pour cet agent', 1012);
    public static final RTExceptionCode ERREUR_OFFRE_COUPON_NON_VALABLE_CLIENT 					= new RTExceptionCode('erreur coupon non valable pour ce client', 1013);
    public static final RTExceptionCode ERREUR_OFFRE_AUCUN_COUPON2 								= new RTExceptionCode('Aucune offre n est valable avec ce coupon', 1014);
    public static final RTExceptionCode ERREUR_COUPON_MULTIPLE_NON_TROUVE 						= new RTExceptionCode('erreur coupon multiple non trouve', 1015);
    public static final RTExceptionCode ERREUR_OFFRE_PROBLEM 									= new RTExceptionCode('erreur offfre contacter l administrateur du site', 1016);

    public static final RTExceptionCode ERREUR_GESTCO_CDD_PRODUIT_ABSENT 						= new RTExceptionCode('Pas de Product Rate Plan Charge trouvee pour le geste commercial', 1101);
    public static final RTExceptionCode ERREUR_GESTCO_APPLICATION_CDD 							= new RTExceptionCode('Erreur Application du Gestco sur un CDD', 1102);
    public static final RTExceptionCode ERREUR_GESTCO_CONTRAT_ABSENT_DDE 						= new RTExceptionCode('Abonnement absent de la demande: pas dabo, plusieurs ou inactif', 1103);
    //public static final RTExceptionCode ERREUR_GESTCO_APPLICATION_CDD 						= new RTExceptionCode('Erreur Application du Gestco sur un CDD', 1102);
    //public static final RTExceptionCode ERREUR_GESTCO_APPLICATION_CDD 						= new RTExceptionCode('Erreur Application du Gestco sur un CDD', 1102);

    public static final RTExceptionCode ERREUR_PREVIEW_PROBLEM 									= new RTExceptionCode('erreur preview contacter l administrateur du site', 1201);

    public static final RTExceptionCode ERREUR_RETENTION_PRODUIT_ABSENT 						= new RTExceptionCode('Pas de Product Rate Plan Charge trouvee pour la retention', 1301);
    public static final RTExceptionCode ERREUR_RETENTION_APPLICATION 							= new RTExceptionCode('Erreur Application de la retention', 1302);    
    
    public static final RTExceptionCode ERREUR_DESABO_CDI_AVEC_FINCONTRAT 						= new RTExceptionCode('Ce contrat comprend deja une date fin contrat', 2001);
    public static final RTExceptionCode ERREUR_DESABO_CDD_AVEC_FINCONTRAT 						= new RTExceptionCode('Ce contrat comprend deja une date fin contrat', 2002);
    public static final RTExceptionCode ERREUR_DESABO_DATE_FINCONTRAT_OBLIGATOIRE 				= new RTExceptionCode('La date fin contrat est obligatoire', 2003);    
    public static final RTExceptionCode ERREUR_DESABO_COUPON_WELCOMEBACK 						= new RTExceptionCode('Erreur desabo: configuration coupon/offre welcome back', 2004);
    public static final RTExceptionCode ERREUR_DESABO_COUPON_ABOTIER 							= new RTExceptionCode('Erreur desabo: configuration coupon/offre abo tier', 2005);
    public static final RTExceptionCode ERREUR_DESABO_CONTRAT_ABSENT_DDE 						= new RTExceptionCode('Abonnement absent de la demande: pas dabo, plusieurs ou inactif', 2006);
    public static final RTExceptionCode ERREUR_DESABO_DDE_DEJA_TRAITE 							= new RTExceptionCode('Cette demande a deja ete traite', 2007);
    public static final RTExceptionCode ERREUR_DESABO_SSMOTIF_OBLIGATOIRE 						= new RTExceptionCode('Sous-Motif obligatoire', 2008);
    public static final RTExceptionCode ERREUR_DESABO_TYPEDESABO_OBLIGATOIRE 					= new RTExceptionCode('Type de désabonnement obligatoire', 2009);
    public static final RTExceptionCode ERREUR_DESABO_ABO_NONACTIF 								= new RTExceptionCode('L abonnement n est pas actif', 2010);
    public static final RTExceptionCode ERREUR_DESABO_ABO_NONACTIF2 							= new RTExceptionCode('L abonnement n est pas actif', 2011);
    public static final RTExceptionCode ERREUR_DESABO_DATEDESABO_OBLIGATOIRE 					= new RTExceptionCode('Veuillez saisir une date de désabonnement', 2012);
    public static final RTExceptionCode ERREUR_DESABO_CDD_IMPOSSIBLE 							= new RTExceptionCode('Pas possible de desabonner un contrat CDD, le contrat sera automatique désabonné à la date de fin de contrat', 2013);
    public static final RTExceptionCode ERREUR_DESABO_SANSCASE_NONACTIF 						= new RTExceptionCode('Contrat Bilendi: L abonnement n est pas actif', 2014);
    public static final RTExceptionCode ERREUR_DESABO_SANSCASE_IMPOSSIBLE 						= new RTExceptionCode('Contrat Bilendi : desabonnement non possible pour les CDD', 2015);
    public static final RTExceptionCode ERREUR_DESABO_BATCH_NON_CONFORME 						= new RTExceptionCode('La souscription non conforme: CDI: non bilendi, sans case', 2016);
    public static final RTExceptionCode ERREUR_DESABO_APPLICATION_CANCEL1 						= new RTExceptionCode('problem cancel de la souscription', 2017);
    public static final RTExceptionCode ERREUR_DESABO_APPLICATION_CANCEL2 						= new RTExceptionCode('problem cancel de la souscription', 2018);
    public static final RTExceptionCode ERREUR_DESABO_APPLICATION_UPDATESUB 					= new RTExceptionCode('Erreur desabo: problem mise a jour de la souscription', 2019);
    public static final RTExceptionCode ERREUR_DESABO_APPLICATION_UPDATESUB2 					= new RTExceptionCode('Erreur desabo: problem mise a jour de la souscription', 2020);
    public static final RTExceptionCode ERREUR_DESABO_APPLICATION_UPDATESUB3 					= new RTExceptionCode('Erreur desabo: problem mise a jour de la souscription', 2021);
    public static final RTExceptionCode ERREUR_DESABO_APPLICATION_UPDATESUB4 					= new RTExceptionCode('Erreur desabo: problem mise a jour de la souscription', 2025);
    public static final RTExceptionCode ERREUR_DESABO_BTOB_IMPOSSIBLE 							= new RTExceptionCode('Pas possible de desabonner un contrat BtoB', 2022);
    public static final RTExceptionCode ERREUR_DESABO_COUPON_WELCOMEBACK2 						= new RTExceptionCode('Erreur desabo: configuration coupon/offre welcome back', 2023);
    public static final RTExceptionCode ERREUR_DESABO_COUPON_ABOTIER2 							= new RTExceptionCode('Erreur desabo: configuration coupon/offre abo tier', 2024);
    public static final RTExceptionCode ERREUR_DESABO_GATEWAY_ZUORA 							= new RTExceptionCode('Erreur desabo: problème de connexion sur la gateway Zuora', 2025);
    public static final RTExceptionCode ERREUR_DESABO_UPDATE_CREDIT_MEMO 						= new RTExceptionCode('Erreur desabo: problème mise a jour du credit memo', 2026);
    public static final RTExceptionCode ERREUR_DESABO_REFUND_CREDIT_MEMO 						= new RTExceptionCode('Erreur desabo: problème de remboursement du credit memo', 2027);

    public static final RTExceptionCode ERREUR_ANNUL_DESABO_CONTRAT_DEJA_ACTIF 					= new RTExceptionCode('Annulation desabo impossible: le contrat est deja actif', 2101);
    public static final RTExceptionCode ERREUR_ANNUL_DESABO_PERIODLATENCE_DEPASSE 				= new RTExceptionCode('Annulation desabo impossible: la periode de latence depasse', 2102);    
    public static final RTExceptionCode ERREUR_ANNUL_DESABO_AUCUN_CONTRAT_TROUVE 				= new RTExceptionCode('Erreur Annulation desabo: aucun contrat trouve a annule', 2103);
    public static final RTExceptionCode ERREUR_ANNUL_DESABO_DATEFINCONTRAT_VIDE 				= new RTExceptionCode('Erreur Annulation desabo: la date fin contrat est vide', 2104);
    public static final RTExceptionCode ERREUR_ANNUL_DESABO_STATUT_CONTRAT_NON_VALIDE 			= new RTExceptionCode('Erreur Annulation desabo: le statut du contrat est non valide', 2105);
    public static final RTExceptionCode ERREUR_ANNUL_DESABO_CDD_DEJA_INACTIF 					= new RTExceptionCode('Erreur Annulation desabo: ce CDD est deja inactif', 2106);
    public static final RTExceptionCode ERREUR_ANNUL_DESABO_UPDATE_SUB 							= new RTExceptionCode('Erreur Annulation desabo: pb mise jour contrat', 2107);
    public static final RTExceptionCode ERREUR_ANNUL_DESABO_UPDATE_SUB2 						= new RTExceptionCode('Erreur Annulation desabo: pb mise jour contrat', 2108);    
    public static final RTExceptionCode ERREUR_ANNUL_DESABO_DELETE_SUB 							= new RTExceptionCode('Erreur Annulation desabo: pb suppression du cancel', 2109);        
    
    public static final RTExceptionCode ERREUR_IMPAYE_GET_SOUSCRITPION_NON_TROUVE 				= new RTExceptionCode('Erreur Affichage impaye: Contrat absent', 3101);
    public static final RTExceptionCode ERREUR_IMPAYE_GET_ACCOUNT_NON_TROUVE 					= new RTExceptionCode('Erreur Affichage impaye: Compte absent', 3102);
    public static final RTExceptionCode ERREUR_IMPAYE_GET_ACCOUNT_NON_TROUVE2 					= new RTExceptionCode('Erreur Affichage impaye: Compte absent pour ce contrat', 3103);
    public static final RTExceptionCode ERREUR_IMPAYE_REGLER_SOUSCRITPION_NON_TROUVE 			= new RTExceptionCode('Erreur Reglement impaye: Contrat absent', 3201);
    public static final RTExceptionCode ERREUR_IMPAYE_REGLER_PAS_DE_DETTE 						= new RTExceptionCode('Erreur Reglement impaye: aucun impaye a regler', 3202);
    public static final RTExceptionCode ERREUR_IMPAYE_REGLER_DELETE_SUB 						= new RTExceptionCode('Erreur Reglement impaye: probleme dans le contrat', 3203);
    public static final RTExceptionCode ERREUR_IMPAYE_REGLER_PROBLEM_PREVIEW 					= new RTExceptionCode('Erreur Reglement impaye: probleme dans la preview de dette non echue', 3204);
    public static final RTExceptionCode ERREUR_IMPAYE_REGLER_PROBLEM_MONTANT 					= new RTExceptionCode('Erreur Reglement impaye: probleme dans le montant de l impaye', 3205);
    public static final RTExceptionCode ERREUR_IMPAYE_REGLER_MONTANT_DNE 						= new RTExceptionCode('Erreur Reglement impaye: probleme dans le montant de la dette non echue', 3206);
    public static final RTExceptionCode ERREUR_IMPAYE_REGLER_PRODUIT_ABSENT 					= new RTExceptionCode('Erreur Reglement impaye: produit frais de reactivation absent', 3207);
    public static final RTExceptionCode ERREUR_IMPAYE_REGLER_APPLICATION_FRAIS 					= new RTExceptionCode('Erreur Reglement impaye: probleme application frais de gestion', 3208);
    public static final RTExceptionCode ERREUR_IMPAYE_REGLER_APPLICATION_PAYMENT 				= new RTExceptionCode('Erreur Reglement impaye: probleme application payment', 3209);
    public static final RTExceptionCode ERREUR_IMPAYE_REGLER_TARGETDATE_STATUSCONTRAT 			= new RTExceptionCode('Erreur Reglement impaye: probleme incoherence target date et status contrat', 3210);
    public static final RTExceptionCode ERREUR_IMPAYE_REGLER_UPDATE_ACCOUNT 					= new RTExceptionCode('Erreur Reglement impaye: probleme mise a jour du compte', 3211);
    public static final RTExceptionCode ERREUR_IMPAYE_REGLER_UPDATE_INVOICE 					= new RTExceptionCode('Erreur Reglement impaye: probleme mise a jour facture', 3212);
    public static final RTExceptionCode ERREUR_IMPAYE_REGLER_UPDATE_SUBSCRIPTION 				= new RTExceptionCode('Erreur Reglement impaye: probleme mise a jour contrat', 3213);
    public static final RTExceptionCode ERREUR_IMPAYE_REGLER_INCOHERENCE_DATEFIN 				= new RTExceptionCode('Erreur Reglement impaye: probleme incoherence dans la date fin du contrat', 3214);
    public static final RTExceptionCode ERREUR_IMPAYE_REGLER_APPLICATION_BILL_DNE 				= new RTExceptionCode('Erreur Reglement impaye: probleme billing de la dette non echue', 3215);
    public static final RTExceptionCode ERREUR_IMPAYE_REGLER_APPLICATION_CANCEL 				= new RTExceptionCode('Erreur Reglement impaye: probleme billing de la dette non echue', 3216);
    public static final RTExceptionCode ERREUR_IMPAYE_REGLER_UPDATE_INVOICE2 					= new RTExceptionCode('Erreur Reglement impaye: probleme maj invoice: aucune facture trouve avec une compteur rejet', 3217);    
       
    public static final RTExceptionCode ERREUR_CONTRATFILE_CASE_NONTROUVE 						= new RTExceptionCode('Erreur recuperation contratfile : aucun case record trouve avec attachementid', 4601);
    public static final RTExceptionCode ERREUR_CONTRATFILE_ATTACHMENT_NONTROUVE 				= new RTExceptionCode('Erreur recuperation contratfile : attachment record non trouve', 4602);
    
	public static final RTExceptionCode ERREUR_AUTORISATION_GET_ACCOUNTSUMMARY 					= new RTExceptionCode('Erreur autorisation : probleme get account summary zuora', 4704);	
    
    public static final RTExceptionCode ERREUR_ACQUISIT_GET_ZSUBSCRIPTION 						= new RTExceptionCode('Erreur Acquisition : probleme get subscription zuora', 5001);
    public static final RTExceptionCode ERREUR_ACQUISIT_GET_ACCOUNT 							= new RTExceptionCode('Erreur Acquisition : probleme get account zuora', 5002);
    public static final RTExceptionCode ERREUR_ACQUISIT_GET_PAYMENTMETHOD 						= new RTExceptionCode('Erreur Acquisition : probleme get payment method zuora', 5003); 
    public static final RTExceptionCode ERREUR_ACQUISIT_MULTIPLE_BILL_ACCOUNT 					= new RTExceptionCode('Erreur Acquisition : Plusieur billing account trouvé', 5004); 
    public static final RTExceptionCode ERREUR_ACQUISIT_PROBLEM_OFFRE 							= new RTExceptionCode('Erreur Acquisition : probleme recuperation offre', 5005);
    public static final RTExceptionCode ERREUR_ACQUISIT_PROBLEM_APPLICATION_OFFRE 				= new RTExceptionCode('Erreur Acquisition : probleme application offre', 5006);
    public static final RTExceptionCode ERREUR_ACQUISIT_SUBSCRIBE 								= new RTExceptionCode('Erreur Acquisition : probleme prise abonnement: subscribe', 5007);
    public static final RTExceptionCode ERREUR_ACQUISIT_UPDATEACC_DEFPAYMETHOD 					= new RTExceptionCode('Erreur Acquisition : probleme mise a jour account: payment method', 5008);
    public static final RTExceptionCode ERREUR_ACQUISIT_GET_INVOICE 							= new RTExceptionCode('Erreur Acquisition : probleme recuperation invoice', 5009);
    public static final RTExceptionCode ERREUR_ACQUISIT_PAYMENT 								= new RTExceptionCode('Erreur Acquisition : probleme application paiement', 5010);
    public static final RTExceptionCode ERREUR_ACQUISIT_UPDATE_BILLSOLDTO 						= new RTExceptionCode('Erreur Acquisition : probleme mise a jour bill sold to', 5011);
    public static final RTExceptionCode ERREUR_ACQUISIT_COUPON_ABOTIER	 						= new RTExceptionCode('Erreur Acquisition: configuration coupon/offre abo tier', 5012);
       
    public static final RTExceptionCode ERREUR_MIGRATION_GET_ZSUBSCRIPTION 						= new RTExceptionCode('Erreur Migration : probleme get subscription zuora', 5101);
    public static final RTExceptionCode ERREUR_MIGRATION_UPDATE_ZSUBSCRIPTION 					= new RTExceptionCode('Erreur Migration : probleme update subscription zuora', 5102);
    public static final RTExceptionCode ERREUR_MIGRATION_POST_PAYMENTMETHOD 					= new RTExceptionCode('Erreur Migration : probleme post payment method zuora', 5103);
    public static final RTExceptionCode ERREUR_MIGRATION_UPDATEACC_DEFPAYMETHOD 				= new RTExceptionCode('Erreur Migration : probleme mise a jour account: payment method', 5104);
    public static final RTExceptionCode ERREUR_MIGRATION_UPDATE_BILLSOLDTO 						= new RTExceptionCode('Erreur Migration : probleme mise a jour bill sold to', 5105);
    public static final RTExceptionCode ERREUR_MIGRATION_SUBSCRIBE 								= new RTExceptionCode('Erreur Migration : probleme prise abonnement: subscribe', 5106);
    public static final RTExceptionCode ERREUR_MIGRATION_GET_INVOICE 							= new RTExceptionCode('Erreur Migration : probleme recuperation invoice',5107);
    public static final RTExceptionCode ERREUR_MIGRATION_PAYMENT 								= new RTExceptionCode('Erreur Migration : probleme application paiement', 5108);
    public static final RTExceptionCode ERREUR_MIGRATION_GET_PAYMENTMETHOD 						= new RTExceptionCode('Erreur Migration : probleme get payment method zuora', 5110); 
    public static final RTExceptionCode ERREUR_MIGRATION_COUPON_ABOTIER 						= new RTExceptionCode('Erreur Migration: configuration coupon/offre abo tier', 5111);

	public static final RTExceptionCode ERREUR_CHANGEBANQUE_WSIN_MANQUANT 						= new RTExceptionCode('Erreur change banque : donnée en entrée non valide', 5201);	
	public static final RTExceptionCode ERREUR_CHANGEBANQUE_WSIN_ACCOUNTSFID_MANQUANT 			= new RTExceptionCode('Erreur change banque : champ accountSFID non valid', 5202);
	public static final RTExceptionCode ERREUR_CHANGEBANQUE_WSIN_PAYEURSFID_MANQUANT 			= new RTExceptionCode('Erreur change banque : champ payeurSFID non valid', 5203);
	public static final RTExceptionCode ERREUR_CHANGEBANQUE_WSIN_MANDATEID_MANQUANT 			= new RTExceptionCode('Erreur change banque : champ mandateId non valid', 5204);
	public static final RTExceptionCode ERREUR_CHANGEBANQUE_WSIN_iIBAN_MANQUANT 				= new RTExceptionCode('Erreur change banque : champ iban non valid', 5205);
	public static final RTExceptionCode ERREUR_CHANGEBANQUE_WSIN_SUBSCRIPTIONNAME_MANQUANT 		= new RTExceptionCode('Erreur change banque : champ subscriptionName non valid', 5206);
	//public static final RTExceptionCode ERREUR_CHANGEBANQUE_WSIN_LIEU_MANQUANT 					= new RTExceptionCode('Erreur change banque : champ lieu non valid', 4807);
	public static final RTExceptionCode ERREUR_CHANGEBANQUE_SUB_NON_TROUVE						= new RTExceptionCode('Erreur change banque : pas de contract trouvé', 5207);
	public static final RTExceptionCode ERREUR_CHANGEBANQUE_BILL_ACC_NON_TROUVE					= new RTExceptionCode('Erreur change banque : pas de billing account trouvé', 5207);
	public static final RTExceptionCode ERREUR_CHANGEBANQUE_PORTEUR_NON_TROUVE					= new RTExceptionCode('Erreur change banque : pas de porteur trouvé', 5208);
	public static final RTExceptionCode ERREUR_CHANGEBANQUE_PAYEUR_NON_TROUVE					= new RTExceptionCode('Erreur change banque : pas de payeur trouvé', 5209);
	public static final RTExceptionCode ERREUR_CHANGEBANQUE_CREATION_ZPAYMENT_METHOD			= new RTExceptionCode('Erreur change banque : erreur lors de la creation du zPaymentMethod', 5210);
	public static final RTExceptionCode ERREUR_CHANGEBANQUE_UPDATE_ZCOMPTE						= new RTExceptionCode('Erreur change banque : erreur lors de la mise à jour du zCompte', 5211);
	public static final RTExceptionCode ERREUR_CHANGEBANQUE_UPDATE_ZCONTACT						= new RTExceptionCode('Erreur change banque : erreur lors de la mise à jour du zContact', 5212);
	public static final RTExceptionCode ERREUR_CHANGEBANQUE_UPDATE_ZSUBSCRIPTION				= new RTExceptionCode('Erreur change banque : erreur lors de la mise à jour du zSouscription', 5213);
	public static final RTExceptionCode ERREUR_CHANGEBANQUE_GET_ZSUBSCRIPTION 					= new RTExceptionCode('Erreur change banque : erreur get subscription zuora', 5214);
	public static final RTExceptionCode ERREUR_CHANGEBANQUE_GET_ACCOUNT 						= new RTExceptionCode('Erreur change banque : erreur get account zuora', 5215);
	public static final RTExceptionCode ERREUR_CHANGEBANQUE_GET_PAYMENTMETHOD 					= new RTExceptionCode('Erreur change banque : erreur get payment method zuora', 5216);  
    
    public static final RTExceptionCode ERREUR_ROLLBACK_UPDATE_ZSUBSCRIPTION                    = new RTExceptionCode('Erreur Rollback : probleme update subscription zuora', 5301);
    public static final RTExceptionCode ERREUR_ROLLBACK_UPDATEACC_DEFPAYMETHOD                  = new RTExceptionCode('Erreur Rollback : probleme mise a jour account: payment method', 5302);
    public static final RTExceptionCode ERREUR_ROLLBACK_UPDATE_BILLSOLDTO                       = new RTExceptionCode('Erreur Rollback : probleme mise a jour bill sold to', 5303);
    public static final RTExceptionCode ERREUR_ROLLBACK_CANCEL_ZSUBSCRIPTION                    = new RTExceptionCode('Erreur Rollback : probleme cancel subscription', 5304);
    public static final RTExceptionCode ERREUR_ROLLBACK_APPLY_CREDITMEMO                        = new RTExceptionCode('Erreur Rollback : probleme apply credit memo', 5305);
    public static final RTExceptionCode ERREUR_ROLLBACK_CANCEL_INVOICE                          = new RTExceptionCode('Erreur Rollback : probleme cancel invoice',5306);
    public static final RTExceptionCode ERREUR_ROLLBACK_DELETE_ZSUBSCRIPTION                    = new RTExceptionCode('Erreur Rollback : probleme delete subscription',5307);

    public static final RTExceptionCode ERREUR_REEDITION_GET_ZSUBSCRIPTION                      = new RTExceptionCode('Erreur Reedition : probleme get subscription zuora', 5401);
    public static final RTExceptionCode ERREUR_REEDITION_POST_AMEND                             = new RTExceptionCode('Erreur Reedition : probleme post amend zuora', 5402);
    public static final RTExceptionCode ERREUR_REEDITION_GET_INVOICE 							= new RTExceptionCode('Erreur Reedition : probleme recuperation invoice',5403);
    public static final RTExceptionCode ERREUR_REEDITION_PAYMENT 								= new RTExceptionCode('Erreur Reedition : probleme application paiement', 5404);
    public static final RTExceptionCode ERREUR_REEDITION_GET_PAYMENTMETHOD 						= new RTExceptionCode('Erreur Reedition : probleme get payment method zuora', 5405); 
    public static final RTExceptionCode ERREUR_REEDITION_GET_ACCOUNT 							= new RTExceptionCode('Erreur Reedition : probleme get account zuora', 5406);
    
    public static final RTExceptionCode ERREUR_RENOUV_GET_ZSUBSCRIPTION 						= new RTExceptionCode('Erreur Renouvellement : probleme get subscription zuora', 4401);
       

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