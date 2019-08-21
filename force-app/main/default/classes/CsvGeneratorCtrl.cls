public class CsvGeneratorCtrl {
    
   
        private static List<String> Tableau() {
            List<String> phrase = new  List<String>();
        String s1 = '0- Commentaires'+'|0- Commentaires'+'|0- Commentaires';
            
		String s2 = '9- Supports Digitaux'+'|1- Web, applis, réseaux sociaux'+'|1- Contenu Ergonomie site Web';
        String s3 = '9- Supports Digitaux'+'|1- Web, applis, réseaux sociaux'+'|21- Réclamation Twiter';
        String s4 = '9- Supports Digitaux'+'|1- Web, applis, réseaux sociaux'+'|2- Information Twiter';
        String s5 = '9- Supports Digitaux'+'|1- Web, applis, réseaux sociaux'+'|31- Réclamation Applis Hors UGC';
        String s6 = '9- Supports Digitaux'+'|1- Web, applis, réseaux sociaux'+'|3- Applis Hors UGC';
        String s7 = '9- Supports Digitaux'+'|1- Web, applis, réseaux sociaux'+'|4- Autres';
        String s8 = '9- Supports Digitaux'+'|1- Web, applis, réseaux sociaux'+'|51- Réclamation UGC Direct';
        String s9 = '9- Supports Digitaux'+'|1- Web, applis, réseaux sociaux'+'|5- UGC Direct';
        String s10 = '9- Supports Digitaux'+'|1- Web, applis, réseaux sociaux'+'|61- Réclamation Facebook';
        String s11 = '9- Supports Digitaux'+'|1- Web, applis, réseaux sociaux'+'|6- Information Facebook';
         phrase.add(s1);
         phrase.add(s2);
         phrase.add(s3);
         phrase.add(s4);
         phrase.add(s5);
         phrase.add(s6);
         phrase.add(s7);
         phrase.add(s8);
         phrase.add(s9);
         phrase.add(s10);
         phrase.add(s11);
        
            
        String s12 = '9- Supports Digitaux'+'|2- Espace Mon Compte'+'|1- Renseignements inscription';
        String s13 = '9- Supports Digitaux'+'|2- Espace Mon Compte'+'|2- Problème inscription';
        String s14 = '9- Supports Digitaux'+'|2- Espace Mon Compte'+'|3- Demande désinscription';
        String s15 = '9- Supports Digitaux'+'|2- Espace Mon Compte'+'|4- Réclamation-autres';
        String s16 = '9- Supports Digitaux'+'|2- Espace Mon Compte'+'|5- Jeux';
        String s17 = '9- Supports Digitaux'+'|2- Espace Mon Compte'+'|6- Autres';
         phrase.add(s12);
         phrase.add(s13);
         phrase.add(s14);
         phrase.add(s15);
         phrase.add(s16);
         phrase.add(s17);
            
 		String s18 ='9- Supports Digitaux'+'|3- UGC fidélité'+'|11- Mise à jour identifiant UI+';
        String s19 ='9- Supports Digitaux'+'|3- UGC fidélité'+'|1- Fonctionnement UGC fidélité';
        String s20 ='9- Supports Digitaux'+'|3- UGC fidélité'+'|21- Renvoi courriel activation';
        String s21 ='9- Supports Digitaux'+'|3- UGC fidélité'+'|2- Problème inscription fidélité';
        String s22 ='9- Supports Digitaux'+'|3- UGC fidélité'+'|3- Informations UGC Fidélité autres';
        String s23 ='9- Supports Digitaux'+'|3- UGC fidélité'+'|4- Réclamation - autres';
        String s24 ='9- Supports Digitaux'+'|3- UGC fidélité'+'|4- Réclamation fonctionnement UGC fidélité';
        String s25 ='9- Supports Digitaux'+'|3- UGC fidélité'+'|5- Jeux';
		String s26 ='9- Supports Digitaux'+'|3- UGC fidélité'+'|5- Réclamation solde de points';
        String s27 ='9- Supports Digitaux'+'|3- UGC fidélité'+'|6- Autres';
        String s28 ='9- Supports Digitaux'+'|3- UGC fidélité'+'|6- Réclamations Autres';
        String s29 ='9- Supports Digitaux'+'|3- UGC fidélité'+'|71- Débit de points';
        String s30 ='9- Supports Digitaux'+'|3- UGC fidélité'+'|7- Crédit de points';
		String s31 ='9- Supports Digitaux'+'|3- UGC fidélité'+'|8- Désabonnement Compte UI+';
         phrase.add(s18);
         phrase.add(s19);
         phrase.add(s20);
         phrase.add(s21);
         phrase.add(s22);
         phrase.add(s23);
         phrase.add(s24);
         phrase.add(s25);
         phrase.add(s26);
         phrase.add(s27);
         phrase.add(s28); 
         phrase.add(s29);
         phrase.add(s30);
         phrase.add(s31);
        
            
        String s32='8- Autres types de réclamations'+'|1- Réclamations Réservations'+'|10- Autres';
 		String s33='8- Autres types de réclamations'+'|1- Réclamations Réservations'+'|1- Carte UI/UU non reconnue';
		String s34='8- Autres types de réclamations'+'|1- Réclamations Réservations'+'|2- Réclamation Viva L\'opera!';
		String s35='8- Autres types de réclamations'+'|1- Réclamations Réservations'+'|31- en bornes';
		String s36='8- Autres types de réclamations'+'|1- Réclamations Réservations'+'|3- Système inaccessible';
		String s37='8- Autres types de réclamations'+'|1- Réclamations Réservations'+'|4- Réservation inexistante';
		String s38='8- Autres types de réclamations'+'|1- Réclamations Réservations'+'|5- Fonctionnement informatique';
		String s39='8- Autres types de réclamations'+'|1- Réclamations Réservations'+'|6- Annulation réservation';
		String s40='8- Autres types de réclamations'+'|1- Réclamations Réservations'+'|7- Demande de confirmation';
		String s41='8- Autres types de réclamations'+'|1- Réclamations Réservations'+'|8- Réservation assistée';
		String s42='8- Autres types de réclamations'+'|1- Réclamations Réservations'+'|9- Tarifs spéciaux';
		 phrase.add(s32);
         phrase.add(s33);
         phrase.add(s34);
         phrase.add(s35);
         phrase.add(s36);
         phrase.add(s37);
         phrase.add(s38);
         phrase.add(s39);
         phrase.add(s40);
         phrase.add(s41);
         phrase.add(s42); 
        

        String s43='8- Autres types de réclamations'+'|2- Réclamation salles'+'|1- Accueil salle';
		String s44='8- Autres types de réclamations'+'|2- Réclamation salles'+'|2- Fonctionnement des Bornes';
		String s45='8- Autres types de réclamations'+'|2- Réclamation salles'+'|3- Projection';
		String s46='8- Autres types de réclamations'+'|2- Réclamation salles'+'|4- Confort, propreté';
		String s47='8- Autres types de réclamations'+'|2- Réclamation salles'+'|5- Sécurité';
		String s48='8- Autres types de réclamations'+'|2- Réclamation salles'+'|61- Contenu Inapproprié (Films annonces, pubs, …)';
		String s49='8- Autres types de réclamations'+'|2- Réclamation salles'+'|6- Programmation';
		String s50='8- Autres types de réclamations'+'|2- Réclamation salles'+'|7- Autres';
		String s51='8- Autres types de réclamations'+'|2- Réclamation salles'+'|8- Numérotation des places';
		 phrase.add(s43);
         phrase.add(s44);
         phrase.add(s45);
         phrase.add(s46);
         phrase.add(s47);
         phrase.add(s48);
         phrase.add(s49);
         phrase.add(s50);
         phrase.add(s51);
        

        String s52='8- Autres types de réclamations'+'|3- Réclamations divers'+'|11- E-carte 5/5+';
		String s53='8- Autres types de réclamations'+'|3- Réclamations divers'+'|1- Carte 5/5+ périmées';
		String s54='8- Autres types de réclamations'+'|3- Réclamations divers'+'|2- Carte UGC Solo périmées';
		String s55='8- Autres types de réclamations'+'|3- Réclamations divers'+'|3- Autres';
		String s56='8- Autres types de réclamations'+'|3- Réclamations divers'+'|4- Carte UGC Blue';
		String s57='8- Autres types de réclamations'+'|3- Réclamations divers'+'|5- UGC+';
            
        string s58='7- Réclamations UI'+'|1- Réclamations paiement UI'+'|10- Frais de gestion';
		string s59='7- Réclamations UI'+'|1- Réclamations paiement UI'+'|1- Frais de dossier';
		string s60='7- Réclamations UI'+'|1- Réclamations paiement UI'+'|2- prélèvement,doms multiples';
		string s61='7- Réclamations UI'+'|1- Réclamations paiement UI'+'|3- Prélevé après résiliation';
		string s62='7- Réclamations UI'+'|1- Réclamations paiement UI'+'|4- Remboursement solde abo';
		string s63='7- Réclamations UI'+'|1- Réclamations paiement UI'+'|5- Aménagement règlement dette';
		string s64='7- Réclamations UI'+'|1- Réclamations paiement UI'+'|6- Impayés';
		string s65='7- Réclamations UI'+'|1- Réclamations paiement UI'+'|7- Autres';

        string s66='7- Réclamations UI'+'|2- Réclamation compte UI'+'|1- Changement coordonnées bancaires';
		string s67='7- Réclamations UI'+'|2- Réclamation compte UI'+'|2- Changement coordonnées perso .';
		string s68='7- Réclamations UI'+'|2- Réclamation compte UI'+'|3- Continuation d\'abonnement';
		string s69='7- Réclamations UI'+'|2- Réclamation compte UI'+'|4- Plus UI';
		string s70='7- Réclamations UI'+'|2- Réclamation compte UI'+'|5- Avertissement';
		string s71='7- Réclamations UI'+'|2- Réclamation compte UI'+'|6- Service Clientèle';
		string s72='7- Réclamations UI'+'|2- Réclamation compte UI'+'|7- B2B';
		string s73='7- Réclamations UI'+'|2- Réclamation compte UI'+'|8- Autres';
		string s74='7- Réclamations UI'+'|2- Réclamation compte UI'+'|91- Annulation suite passage autre formule UI';
		string s75='7- Réclamations UI'+'|2- Réclamation compte UI'+'|9- Changement tarifiaire';
		phrase.add(s52);
         phrase.add(s53);
         phrase.add(s54);
         phrase.add(s55);
         phrase.add(s56);
         phrase.add(s57);
         phrase.add(s58);
         phrase.add(s59);
         phrase.add(s60);
         phrase.add(s61);
         phrase.add(s62); 
         phrase.add(s63);
         phrase.add(s64);
         phrase.add(s65);
         phrase.add(s66);
         phrase.add(s67);
         phrase.add(s68);
         phrase.add(s69);
         phrase.add(s70);
         phrase.add(s71);
         phrase.add(s72);
         phrase.add(s73);
         phrase.add(s74);
         phrase.add(s75);
         

        string s76='7- Réclamations UI'+'|3- Réclamation carte UI'+'|1- Délais de reception';
		string s77='7- Réclamations UI'+'|3- Réclamation carte UI'+'|2- Carte non reçue';
		string s78='7- Réclamations UI'+'|3- Réclamation carte UI'+'|3- Carte démagnétisée';
		string s79='7- Réclamations UI'+'|3- Réclamation carte UI'+'|4- Carte confisquée';
		string s80='7- Réclamations UI'+'|3- Réclamation carte UI'+'|5- Carte abîmée';
		string s81='7- Réclamations UI'+'|3- Réclamation carte UI'+'|6- Carte non reconnue en caisse';
		string s82='7- Réclamations UI'+'|3- Réclamation carte UI'+'|7- Autres';

		string s83='7- Réclamations UI'+'|3- Réclamations divers'+'|11- E-carte 5/5+';
		string s84='7- Réclamations UI'+'|3- Réclamations divers'+'|1- Carte 5/5+ périmées';
		string s85='7- Réclamations UI'+'|3- Réclamations divers'+'|2- Carte UGC Solo périmées';
		string s86='7- Réclamations UI'+'|3- Réclamations divers'+'|3- Autres';
		string s87='7- Réclamations UI'+'|3- Réclamations divers'+'|4- Carte UGC Blue';
		string s88='7- Réclamations UI'+'|3- Réclamations divers'+'|5- UGC +';

		string s89='7- Réclamations UI'+'|4- Réclamation résiliatio désabonnement UI'+'|1- Résiliation - Impayé';
		string s90='7- Réclamations UI'+'|4- Réclamation résiliatio désabonnement UI'+'|2- Résiliation - Code M réactivation refusée';
		string s91='7- Réclamations UI'+'|4- Réclamation résiliatio désabonnement UI'+'|3- Résiliations - Autres raisons';
		string s92='7- Réclamations UI'+'|4- Réclamation résiliatio désabonnement UI'+'|4- Désabonnement';
		string s93='7- Réclamations UI'+'|4- Réclamation résiliatio désabonnement UI'+'|5- Avertissement';
		string s94='7- Réclamations UI'+'|4- Réclamation résiliatio désabonnement UI'+'|6- Autres';
		string s95='7- Réclamations UI'+'|4- Réclamation résiliatio désabonnement UI'+'|7- Résiliation – Code M réactivation acceptée';
        
            
        string s96='6- GestionCompteUI'+'|0- Commentaires'+'|0- Commentaires';

        string s97='6- GestionCompteUI'+'|0- Demande de réédition de carte'+'|1- Carte démagnétisée / photo illisible';
		string s98='6- GestionCompteUI'+'|0- Demande de réédition de carte'+'|2- Carte défectueuse du fait du client';
		string s99='6- GestionCompteUI'+'|0- Demande de réédition de carte'+'|3- Changement de  photo';
		string s100='6- GestionCompteUI'+'|0- Demande de réédition de carte'+'|4- Changement de nom';
		string s101='6- GestionCompteUI'+'|0- Demande de réédition de carte'+'|5- Carte perdue / volée prélèvement';
		string s102='6- GestionCompteUI'+'|0- Demande de réédition de carte'+'|6- Réedition sans frais';

        string s103='6- GestionCompteUI'+'|1- Réédition de carte gratuite'+'|1- Carte démagnétisée du fait d’UGC';
		string s104='6- GestionCompteUI'+'|1- Réédition de carte gratuite'+'|2- Carte défectueuse du fait du client';
		string s105='6- GestionCompteUI'+'|1- Réédition de carte gratuite'+'|3- Changement de  photo';
		string s106='6- GestionCompteUI'+'|1- Réédition de carte gratuite'+'|4- Changement de nom';
		string s107='6- GestionCompteUI'+'|1- Réédition de carte gratuite'+'|5- Carte défectueuse du fait d’UGC- Photo illisible';
		string s108='6- GestionCompteUI'+'|1- Réédition de carte gratuite'+'|6- Réedition sans frais';
		string s109='6- GestionCompteUI'+'|1- Réédition de carte gratuite'+'|7- Réédition suite doublon';
		 phrase.add(s76);
         phrase.add(s77);
         phrase.add(s78);
         phrase.add(s79);
         phrase.add(s80);
         phrase.add(s81);
         phrase.add(s82);
         phrase.add(s83);
         phrase.add(s84);
         phrase.add(s85);
         phrase.add(s86); 
         phrase.add(s87);
         phrase.add(s88);
         phrase.add(s89);
         phrase.add(s90);
         phrase.add(s91);
         phrase.add(s92);
         phrase.add(s93);
         phrase.add(s94);
         phrase.add(s95);
         phrase.add(s96);
         phrase.add(s97);
         phrase.add(s98);
         phrase.add(s99);
         phrase.add(s100); 
         phrase.add(s101);
         phrase.add(s102);
         phrase.add(s103);
         phrase.add(s104);
         phrase.add(s105);
         phrase.add(s106);
         phrase.add(s107);
         phrase.add(s108);
         phrase.add(s109);
         
       	string s110='6- GestionCompteUI'+'|2- Demande de frais'+'|1- Carte perdue/volée -prélèvement/dom';
		string s111='6- GestionCompteUI'+'|2- Demande de frais'+'|20- Relance - Carte défectueuse du fait du client -prélèvement/dom';
		string s112='6- GestionCompteUI'+'|2- Demande de frais'+'|2- Carte défectueuse du fait du client -prélèvement/dom';
		string s113='6- GestionCompteUI'+'|2- Demande de frais'+'|3- Carte perdue / volée virement';
		string s114='6- GestionCompteUI'+'|2- Demande de frais'+'|40- Relance - Carte défectueuse du fait du client - Virement';
		string s115='6- GestionCompteUI'+'|2- Demande de frais'+'|4- Carte défectueuse du fait du client - Virement';
		string s116='6- GestionCompteUI'+'|2- Demande de frais'+'|5- Carte perdue/volée -chèque';
		string s117='6- GestionCompteUI'+'|2- Demande de frais'+'|60- Relance - Carte défectueuse du fait du client –chèque';
		string s118='6- GestionCompteUI'+'|2- Demande de frais'+'|6- Carte défectueuse du fait du client –chèque';

		string s119='6- GestionCompteUI'+'|3- Réédition de carte payante'+'|1- Envoi nouvelle carte';
		string s120='6- GestionCompteUI'+'|3- Réédition de carte payante'+'|2- Envoi carte UI  (abo en ligne et/ou suite migration depuis UI2)';
		string s121='6- GestionCompteUI'+'|3- Réédition de carte payante'+'|3- Envoi carte UI2 ( abo en ligne et/ou suite migration depuis UI)';
		string s122='6- GestionCompteUI'+'|3- Réédition de carte payante'+'|54- Relance - dossier incomplet : demande de chèque lisible, payeur # porteur';


		string s123='6- GestionCompteUI'+'|4- Mise à jour des coordonnées'+'|1- Adresse';
		string s124='6- GestionCompteUI'+'|4- Mise à jour des coordonnées'+'|1- Carte défectueuse du fait du client';
        string s389='6- GestionCompteUI'+'|4- Mise à jour des coordonnées'+'|2- Banque';    
		string s125='6- GestionCompteUI'+'|4- Mise à jour des coordonnées'+'|3- NPAI adresse';
		string s126='6- GestionCompteUI'+'|4- Mise à jour des coordonnées'+'|4- NPAI mail';
		string s127='6- GestionCompteUI'+'|4- Mise à jour des coordonnées'+'|5- Faux numéro téléphone fixe';
		string s128='6- GestionCompteUI'+'|4- Mise à jour des coordonnées'+'|6- Faux numéro téléphone mobile';
		string s129='6- GestionCompteUI'+'|4- Mise à jour des coordonnées'+'|7- Mise à jour SEPA par Courriel';

		string s130='6- GestionCompteUI'+'|5- Désactivation'+'|1- Carte défectueuse du fait du client';
		string s131='6- GestionCompteUI'+'|5- Désactivation'+'|20- Relance - Coordonnées bancaires incorrectes';
		string s132='6- GestionCompteUI'+'|5- Désactivation'+'|2- Coordonnées bancaires incorrectes';
		string s133='6- GestionCompteUI'+'|5- Désactivation'+'|3- Insuffisance de provisions';
		string s134='6- GestionCompteUI'+'|5- Désactivation'+'|4- Rejet décès payeur';
		string s135='6- GestionCompteUI'+'|5- Désactivation'+'|5- Rejet chèque';
		string s136='6- GestionCompteUI'+'|5- Désactivation'+'|6- Chèque à retourner';
		string s137='6- GestionCompteUI'+'|5- Désactivation'+'|70- Relance - Mandat de prélèvement non signé';
		string s138='6- GestionCompteUI'+'|5- Désactivation'+'|7- Mandat de prélèvement non signé';


        string s139='6- GestionCompteUI'+'|6- Réactivation'+'|11- envoi de nouvelle carte sans frais suite à réactivation du contrat';
		string s140='6- GestionCompteUI'+'|6- Réactivation'+'|12- envoi de nouvelle carte avec frais suite à réactivation du contrat';
		string s141='6- GestionCompteUI'+'|6- Réactivation'+'|21- réactivation de la carte sans frais';
		string s142='6- GestionCompteUI'+'|6- Réactivation'+'|22- réactivation de la carte avec frais';
		string s143='6- GestionCompteUI'+'|6- Réactivation'+'|31- Retour du règlemernt au client';
		string s144='6- GestionCompteUI'+'|6- Réactivation'+'|33- Régul post abo règlement reçu';
		string s145='6- GestionCompteUI'+'|6- Réactivation'+'|3- Règlement impayé - réédition - sans reprise des pvts';
		string s146='6- GestionCompteUI'+'|6- Réactivation'+'|41- Règlement Impayé avec réactivation';
		string s147='6- GestionCompteUI'+'|6- Réactivation'+'|4- Règlement Impayé - réédition - avec reprise des pvt';
		string s148='6- GestionCompteUI'+'|6- Réactivation'+'|5- Post recouvrement mandat de prélèvement';
		string s149='6- GestionCompteUI'+'|6- Réactivation'+'|6- Réactivation Refusée : réclamer DNE';
		string s150='6- GestionCompteUI'+'|6- Réactivation'+'|7- Réactivation Refusée : Réclamer DNE+FR';
		string s151='6- GestionCompteUI'+'|6- Réactivation'+'|8- Réactivation refusée - Réclamer DNE+FR (Montant < DE+FR)';
		string s152='6- GestionCompteUI'+'|6- Réactivation'+'|9- Réactivation refusée : réclamer DNE + FR DE (montant<DE)';



        string s153='6- GestionCompteUI'+'|7- Résiliation / Désabonnement'+'|1- Désabonnement exceptionnel- comptant';
		string s154='6- GestionCompteUI'+'|7- Résiliation / Désabonnement'+'|21- Désabonnement standard + retour carte à l\'abonné';
		string s155='6- GestionCompteUI'+'|7- Résiliation / Désabonnement'+'|22- Désabonnement Standard - proposition rétention';
		string s156='6- GestionCompteUI'+'|7- Résiliation / Désabonnement'+'|23- Désabonnement Standard - rétention augmentation';
		string s157='6- GestionCompteUI'+'|7- Résiliation / Désabonnement'+'|25- Désabonnement standard passage UI->UI2';
		string s158='6- GestionCompteUI'+'|7- Résiliation / Désabonnement'+'|26- Désabonnement standard passage U2->UI';
		string s159='6- GestionCompteUI'+'|7- Résiliation / Désabonnement'+'|27- Désabonnement standard + proposition rétention + retour carte à l\'abonné';
		string s160='6- GestionCompteUI'+'|7- Résiliation / Désabonnement'+'|28- Désabonnement standard passage UI -26a vers UI2';
		string s161='6- GestionCompteUI'+'|7- Résiliation / Désabonnement'+'|2- Désabonnement standard';
		string s162='6- GestionCompteUI'+'|7- Résiliation / Désabonnement'+'|30- Résiliation M1';
		string s163='6- GestionCompteUI'+'|7- Résiliation / Désabonnement'+'|31- Résiliation M2';
		string s164='6- GestionCompteUI'+'|7- Résiliation / Désabonnement'+'|32- Résiliation M3';
		string s165='6- GestionCompteUI'+'|7- Résiliation / Désabonnement'+'|33- Résiliation M4';
		string s166='6- GestionCompteUI'+'|7- Résiliation / Désabonnement'+'|34- Résiliation M5';
		string s167='6- GestionCompteUI'+'|7- Résiliation / Désabonnement'+'|35- Résiliation M6';
		string s168='6- GestionCompteUI'+'|7- Résiliation / Désabonnement'+'|36- Résiliation M7';
		string s169='6- GestionCompteUI'+'|7- Résiliation / Désabonnement'+'|37- Résiliation M8';
		string s170='6- GestionCompteUI'+'|7- Résiliation / Désabonnement'+'|38- Résiliation M9';
		string s171='6- GestionCompteUI'+'|7- Résiliation / Désabonnement'+'|39- Résiliation M10';
		string s172='6- GestionCompteUI'+'|7- Résiliation / Désabonnement'+'|40- Relance - 2ème rejet';
		string s173='6- GestionCompteUI'+'|7- Résiliation / Désabonnement'+'|4- 2ème rejet';
		string s174='6- GestionCompteUI'+'|7- Résiliation / Désabonnement'+'|5- NRP Banque';
		string s175='6- GestionCompteUI'+'|7- Résiliation / Désabonnement'+'|6- Refus réabonnement';
		string s176='6- GestionCompteUI'+'|7- Résiliation / Désabonnement'+'|8- Désabonnement exceptionnel- Domiciliation';
		string s177='6- GestionCompteUI'+'|7- Résiliation / Désabonnement'+'|9- Désabonnement exceptionnel- prélèvement';
		
         phrase.add(s110);
         phrase.add(s111);
         phrase.add(s112);
         phrase.add(s113);
         phrase.add(s114);
         phrase.add(s115);
         phrase.add(s116);
         phrase.add(s117);
         phrase.add(s118);
         phrase.add(s119);
         phrase.add(s120); 
         phrase.add(s121);
         phrase.add(s122);
         phrase.add(s123);
         phrase.add(s124);
         phrase.add(s125);
         phrase.add(s126);
         phrase.add(s127);
         phrase.add(s128);
         phrase.add(s129);
         phrase.add(s130);
         phrase.add(s131);
         phrase.add(s132);
         phrase.add(s133);
         phrase.add(s134); 
         phrase.add(s135);
         phrase.add(s136);
         phrase.add(s137);
         phrase.add(s138);
         phrase.add(s139);
         phrase.add(s140);
         phrase.add(s141);
         phrase.add(s142);
         phrase.add(s143);
         phrase.add(s144);
         phrase.add(s145);
         phrase.add(s146);
         phrase.add(s147);
         phrase.add(s148); 
         phrase.add(s149);
         phrase.add(s150);
         phrase.add(s151);
         phrase.add(s152);
         phrase.add(s153);
         phrase.add(s154);
         phrase.add(s155);
         phrase.add(s156);
         phrase.add(s157);
         phrase.add(s158);
         phrase.add(s159);
         phrase.add(s160);
         phrase.add(s161);
         phrase.add(s162); 
         phrase.add(s163);
         phrase.add(s164);
         phrase.add(s165);
         phrase.add(s166);
         phrase.add(s167);
         phrase.add(s168);
         phrase.add(s169);
         phrase.add(s170);
         phrase.add(s171);
         phrase.add(s172);
         phrase.add(s173);
         phrase.add(s174);
         phrase.add(s175);
         phrase.add(s389);

       	string s178='6- GestionCompteUI'+'|8- Avertissement'+'|10- Gestion des événements  salleM1';
		string s179='6- GestionCompteUI'+'|8- Avertissement'+'|11- Gestion des événements  salleM2'; 
		string s180='6- GestionCompteUI'+'|8- Avertissement'+'|12- Gestion des événements  salleM3'; 
		string s181='6- GestionCompteUI'+'|8- Avertissement'+'|13- Gestion des événements  salleM4'; 
		string s182='6- GestionCompteUI'+'|8- Avertissement'+'|14- Gestion des événements  salleM5'; 
		string s183='6- GestionCompteUI'+'|8- Avertissement'+'|15- Gestion des événements  salleM6'; 
		string s184='6- GestionCompteUI'+'|8- Avertissement'+'|17- Gestion des événements  salleM8'; 
		string s185='6- GestionCompteUI'+'|8- Avertissement'+'|18- Gestion des événements  salleM9'; 
		string s186='6- GestionCompteUI'+'|8- Avertissement'+'|19- Gestion des événements  salle M10'; 
		
		string s187='6- GestionCompteUI'+'|9- Réédition de carte autres paiements'+'|1- Envoi nouvelle carte';
            
		string s188='5- Abonnement en attente'+'|1- Abonnement par correspondance'+'|11- dossier incomplet : demande de RIB, payeur = porteur';  
		string s189='5- Abonnement en attente'+'|1- Abonnement par correspondance'+'|12- dossier incomplet : demande de RIB, payeur # porteur';  // EN attente de UGC pour verifier Famille/motif/Sous Motif
		string s190='5- Abonnement en attente'+'|1- Abonnement par correspondance'+'|13- Relance - dossier incomplet : demande de RIB, payeur = porteur'; 
		string s191='5- Abonnement en attente'+'|1- Abonnement par correspondance'+'|14- Relance - dossier incomplet : demande de RIB, payeur # porteur'; 
		string s192='5- Abonnement en attente'+'|1- Abonnement par correspondance'+'|15- Relance - Photo manquante'; 
		string s193='5- Abonnement en attente'+'|1- Abonnement par correspondance'+'|1- Photo manquante'; 
		string s194='5- Abonnement en attente'+'|1- Abonnement par correspondance'+'|20- Chèque manquant'; 
		string s195='5- Abonnement en attente'+'|1- Abonnement par correspondance'+'|21- dossier incomplet : demande de chèque manquant, payeur = porteur'; 
		string s196='5- Abonnement en attente'+'|1- Abonnement par correspondance'+'|22- dossier incomplet : demande de chèque manquant, payeur # porteur'; 
		string s197='5- Abonnement en attente'+'|1- Abonnement par correspondance'+'|23- Relance - dossier incomplet : demande de chèque manquant, payeur = porteur'; 
		string s198='5- Abonnement en attente'+'|1- Abonnement par correspondance'+'|24- Relance - dossier incomplet : demande de chèque manquant, payeur # porteur'; 
		string s199='5- Abonnement en attente'+'|1- Abonnement par correspondance'+'|26- dossier incomplet : demande de chèque pro-rata'; 
		string s200='5- Abonnement en attente'+'|1- Abonnement par correspondance'+'|2- Photo mauvaise qualité'; 
		string s201='5- Abonnement en attente'+'|1- Abonnement par correspondance'+'|41- dossier incomplet : demande de signer le chèque, payeur = porteur'; 
		string s202='5- Abonnement en attente'+'|1- Abonnement par correspondance'+'|42- dossier incomplet : demande de signer le chèque, payeur # porteur'; 
		string s203='5- Abonnement en attente'+'|1- Abonnement par correspondance'+'|43- Relance - dossier incomplet : demande de signer le chèque, payeur = porteur'; 
		string s204='5- Abonnement en attente'+'|1- Abonnement par correspondance'+'|44- Relance - dossier incomplet : demande de signer le chèque, payeur # porteur'; 
		string s205='5- Abonnement en attente'+'|1- Abonnement par correspondance'+'|45- Relance - Formulaire illisible'; 
		string s206='5- Abonnement en attente'+'|1- Abonnement par correspondance'+'|4- Formulaire illisible';
		string s207='5- Abonnement en attente'+'|1- Abonnement par correspondance'+'|51- dossier incomplet : demande de chèque lisible, payeur = porteur'; 
		string s208='5- Abonnement en attente'+'|1- Abonnement par correspondance'+'|52- dossier incomplet : demande de chèque lisible, payeur # porteur'; 
		string s209='5- Abonnement en attente'+'|1- Abonnement par correspondance'+'|53- Relance - dossier incomplet : demande de chèque lisible, payeur = porteur'; 
		string s210='5- Abonnement en attente'+'|1- Abonnement par correspondance'+'|54- Relance - dossier incomplet : demande de chèque lisible, payeur # porteur'; 
		string s211='5- Abonnement en attente'+'|1- Abonnement par correspondance'+'|556- Relance - Formulaire incomplet'; 
		string s212='5- Abonnement en attente'+'|1- Abonnement par correspondance'+'|5- Formulaire incomplet'; 
		string s213='5- Abonnement en attente'+'|1- Abonnement par correspondance'+'|60- RIB inexploitable'; 
		string s214='5- Abonnement en attente'+'|1- Abonnement par correspondance'+'|61- Relance - RIB inexploitable';
		string s215='5- Abonnement en attente'+'|1- Abonnement par correspondance'+'|62- Relance - Formulaire périmé'; 
		string s216='5- Abonnement en attente'+'|1- Abonnement par correspondance'+'|6- Formulaire périmé'; 
		string s217='5- Abonnement en attente'+'|1- Abonnement par correspondance'+'|9- Formulaire absent'; 
		
         phrase.add(s176);
         phrase.add(s177);
         phrase.add(s178);
         phrase.add(s179);
         phrase.add(s180);
         phrase.add(s181);
         phrase.add(s182);
         phrase.add(s183);
         phrase.add(s184);
         phrase.add(s185);
         phrase.add(s186);
         phrase.add(s187); 
         phrase.add(s188);
         phrase.add(s189);
         phrase.add(s190);
         phrase.add(s191);
         phrase.add(s192);
         phrase.add(s193);
         phrase.add(s194);
         phrase.add(s195);
         phrase.add(s196);
         phrase.add(s197);
         phrase.add(s198);
         phrase.add(s199);
         phrase.add(s200);
         phrase.add(s201);
         phrase.add(s202);
         phrase.add(s203);
         phrase.add(s204);
         phrase.add(s205);
         phrase.add(s206);
         phrase.add(s207);
         phrase.add(s208);
         phrase.add(s209);
         phrase.add(s210);
         phrase.add(s211);
         phrase.add(s212);
         phrase.add(s213);
         phrase.add(s214);
         phrase.add(s215);
         phrase.add(s216);
         phrase.add(s217);
           
            
		string s218='5- Abonnement en attente'+'|2- Abonnement par stand'+'|11- Abonnement UI/UU (chargement automatique)';
		string s219='5- Abonnement en attente'+'|2- Abonnement par stand'+'|1- Abonnement UI/UU (chargement manuel)';
		string s220='5- Abonnement en attente'+'|2- Abonnement par stand'+'|1- Formulaire incomplet';
		string s221='5- Abonnement en attente'+'|2- Abonnement par stand'+'|21- demande d\'abo stand refusée M pour un abo payé par prélèvement/dom';
		string s222='5- Abonnement en attente'+'|2- Abonnement par stand'+'|22- demande d\'abo stand refusée M pour un abo payé par CB ou espèces';
		string s223='5- Abonnement en attente'+'|2- Abonnement par stand'+'|23- demande d\'abo stand refusée M pour un abo payé par chèque (mensualités) avec retour du chèque';
		string s224='5- Abonnement en attente'+'|2- Abonnement par stand'+'|2- Dossier refusé M';
		string s225='5- Abonnement en attente'+'|2- Abonnement par stand'+'|31- demande d\'abo stand refusée X pour un abo payé par prélèvement/dom/ payeur = porteur';
		string s226='5- Abonnement en attente'+'|2- Abonnement par stand'+'|32- demande d\'abo stand refusée X pour un abo payé par prélèvement/dom/ payeur # porteur';
		string s227='5- Abonnement en attente'+'|2- Abonnement par stand'+'|33- demande d\'abo par stand refusée X pour un abo payé comptant';
		string s228='5- Abonnement en attente'+'|2- Abonnement par stand'+'|3- Dossier refusé X';
		string s229='5- Abonnement en attente'+'|2- Abonnement par stand'+'|4- Réédition suite doublon';
		string s230='5- Abonnement en attente'+'|2- Abonnement par stand'+'|5- Dossier annulé';
            
        
		string s231='4- Abonnement Carte UGC'+'|1- Abonnement par correspondance'+'|11- dossier incomplet : demande de RIB, payeur = porteur';  
		string s232='4- Abonnement Carte UGC'+'|1- Abonnement par correspondance'+'|12- dossier incomplet : demande de RIB, payeur # porteur'; 
		string s233='4- Abonnement Carte UGC'+'|1- Abonnement par correspondance'+'|13- Relance - dossier incomplet : demande de RIB, payeur = porteur'; 
		string s234='4- Abonnement Carte UGC'+'|1- Abonnement par correspondance'+'|14- Relance - dossier incomplet : demande de RIB, payeur # porteur'; 
		string s235='4- Abonnement Carte UGC'+'|1- Abonnement par correspondance'+'|15- Relance - Photo manquante'; 
		string s236='4- Abonnement Carte UGC'+'|1- Abonnement par correspondance'+'|1- Photo manquante'; 
		string s237='4- Abonnement Carte UGC'+'|1- Abonnement par correspondance'+'|20- Chèque manquant'; 
        string s238='4- Abonnement Carte UGC'+'|1- Abonnement par correspondance'+'|21- dossier incomplet : demande de chèque manquant, payeur = porteur'; 
		string s239='4- Abonnement Carte UGC'+'|1- Abonnement par correspondance'+'|22- dossier incomplet : demande de chèque manquant, payeur # porteur'; 
		string s240='4- Abonnement Carte UGC'+'|1- Abonnement par correspondance'+'|23- Relance - dossier incomplet : demande de chèque manquant, payeur = porteur'; 
		string s241='4- Abonnement Carte UGC'+'|1- Abonnement par correspondance'+'|24- Relance - dossier incomplet : demande de chèque manquant, payeur # porteur'; 
		string s242='4- Abonnement Carte UGC'+'|1- Abonnement par correspondance'+'|26- dossier incomplet : demande de chèque pro-rata'; 
		string s243='4- Abonnement Carte UGC'+'|1- Abonnement par correspondance'+'|2- Photo mauvaise qualité'; 
		string s244='4- Abonnement Carte UGC'+'|1- Abonnement par correspondance'+'|41- dossier incomplet : demande de signer le chèque, payeur = porteur'; 
		string s245='4- Abonnement Carte UGC'+'|1- Abonnement par correspondance'+'|42- dossier incomplet : demande de signer le chèque, payeur # porteur'; 
		string s246='4- Abonnement Carte UGC'+'|1- Abonnement par correspondance'+'|43- Relance - dossier incomplet : demande de signer le chèque, payeur = porteur'; 
		string s247='4- Abonnement Carte UGC'+'|1- Abonnement par correspondance'+'|44- Relance - dossier incomplet : demande de signer le chèque, payeur # porteur'; 
		string s248='4- Abonnement Carte UGC'+'|1- Abonnement par correspondance'+'|45- Relance - Formulaire illisible'; 
		string s249='4- Abonnement Carte UGC'+'|1- Abonnement par correspondance'+'|4- Formulaire illisible';
		string s250='4- Abonnement Carte UGC'+'|1- Abonnement par correspondance'+'|51- dossier incomplet : demande de chèque lisible, payeur = porteur'; 
		string s251='4- Abonnement Carte UGC'+'|1- Abonnement par correspondance'+'|52- dossier incomplet : demande de chèque lisible, payeur # porteur'; 
		string s252='4- Abonnement Carte UGC'+'|1- Abonnement par correspondance'+'|53- Relance - dossier incomplet : demande de chèque lisible, payeur = porteur'; 
		string s253='4- Abonnement Carte UGC'+'|1- Abonnement par correspondance'+'|54- Relance - dossier incomplet : demande de chèque lisible, payeur # porteur'; 
		string s254='4- Abonnement Carte UGC'+'|1- Abonnement par correspondance'+'|556- Relance - Formulaire incomplet'; 
		string s255='4- Abonnement Carte UGC'+'|1- Abonnement par correspondance'+'|5- Formulaire incomplet'; 
		string s256='4- Abonnement Carte UGC'+'|1- Abonnement par correspondance'+'|60- RIB inexploitable'; 
		string s257='4- Abonnement Carte UGC'+'|1- Abonnement par correspondance'+'|61- Relance - RIB inexploitable';
		string s258='4- Abonnement Carte UGC'+'|1- Abonnement par correspondance'+'|62- Relance - Formulaire périmé'; 
		string s259='4- Abonnement Carte UGC'+'|1- Abonnement par correspondance'+'|6- Formulaire périmé'; 
		string s260='4- Abonnement Carte UGC'+'|1- Abonnement par correspondance'+'|9- Formulaire absent';		


		string s261='4- Abonnement Carte UGC'+'|2- Abonnement par stand'+'|11- Abonnement UI/UU (chargement automatique)';
		string s262='4- Abonnement Carte UGC'+'|2- Abonnement par stand'+'|1- Abonnement UI/UU (chargement manuel)';
		string s263='4- Abonnement Carte UGC'+'|2- Abonnement par stand'+'|1- Formulaire incomplet';
		string s264='4- Abonnement Carte UGC'+'|2- Abonnement par stand'+'|21- demande d\'abo stand refusée M pour un abo payé par prélèvement/dom';
		string s265='4- Abonnement Carte UGC'+'|2- Abonnement par stand'+'|22- demande d\'abo stand refusée M pour un abo payé par CB ou espèces';
		string s266='4- Abonnement Carte UGC'+'|2- Abonnement par stand'+'|23- demande d\'abo stand refusée M pour un abo payé par chèque (mensualités) avec retour du chèque';
		string s267='4- Abonnement Carte UGC'+'|2- Abonnement par stand'+'|2- Dossier refusé M';
		string s268='4- Abonnement Carte UGC'+'|2- Abonnement par stand'+'|31- demande d\'abo stand refusée X pour un abo payé par prélèvement/dom/ payeur = porteur';
		string s269='4- Abonnement Carte UGC'+'|2- Abonnement par stand'+'|32- demande d\'abo stand refusée X pour un abo payé par prélèvement/dom/ payeur # porteur';
		string s270='4- Abonnement Carte UGC'+'|2- Abonnement par stand'+'|33- demande d\'abo par stand refusée X pour un abo payé comptant';
		string s271='4- Abonnement Carte UGC'+'|2- Abonnement par stand'+'|3- Dossier refusé X';
		string s272='4- Abonnement Carte UGC'+'|2- Abonnement par stand'+'|4- Réédition suite doublon';
		string s273='4- Abonnement Carte UGC'+'|2- Abonnement par stand'+'|5- Dossier annulé';

        string s274='4- Abonnement Carte UGC'+'|3- Réabonnement'+'|0- Proposition réabonnement grand public';
		string s275='4- Abonnement Carte UGC'+'|3- Réabonnement'+'|11- Relance - Proposition réabonnement grand public';
		string s276='4- Abonnement Carte UGC'+'|3- Réabonnement'+'|12- paiement intégral + retour carte';
		string s277='4- Abonnement Carte UGC'+'|3- Réabonnement'+'|1- paiement intégral';
		string s278='4- Abonnement Carte UGC'+'|3- Réabonnement'+'|21- mandat de prélèvement + retour carte';
		string s279='4- Abonnement Carte UGC'+'|3- Réabonnement'+'|2- mandat de prélèvement';
		string s280='4- Abonnement Carte UGC'+'|3- Réabonnement'+'|30- Relance - Proposition réabonnement B2B';
		string s281='4- Abonnement Carte UGC'+'|3- Réabonnement'+'|3- Proposition réabonnement B2B';
		
         phrase.add(s218);
		 phrase.add(s219);
         phrase.add(s220);
         phrase.add(S221);
         phrase.add(s222);
         phrase.add(s223);
         phrase.add(s224);
         phrase.add(s225);
         phrase.add(s226);
         phrase.add(s227);
         phrase.add(s228);
         phrase.add(s229); 
         phrase.add(s230);
         phrase.add(s231);
         phrase.add(s232);
         phrase.add(s233);
         phrase.add(s234);
         phrase.add(s235);
         phrase.add(s236);
         phrase.add(s237);
         phrase.add(s238);
         phrase.add(s239);
         phrase.add(s240);
         phrase.add(s241);
         phrase.add(s242);
         phrase.add(s243);
         phrase.add(s244);
         phrase.add(s245);
         phrase.add(s246);
         phrase.add(s247);
         phrase.add(s248);
         phrase.add(s249);
         phrase.add(s250);
         phrase.add(s251);
         phrase.add(s252);
         phrase.add(s253);
         phrase.add(s254);
         phrase.add(s255);
         phrase.add(s256);
         phrase.add(s257);
         phrase.add(s258);
         phrase.add(s259);
         phrase.add(s260);
         phrase.add(s261);
         phrase.add(S262);
         phrase.add(s263);
         phrase.add(s264);
         phrase.add(s265);
         phrase.add(s266);
         phrase.add(s267);
         phrase.add(s268);
         phrase.add(s269); 
         phrase.add(s270);
         phrase.add(s271);
         phrase.add(s272);
         phrase.add(s273);
         phrase.add(s274);
         phrase.add(s275);
         phrase.add(s276);
         phrase.add(s277);
         phrase.add(s278);
         phrase.add(s279);
         phrase.add(s280);
         phrase.add(s281);
            
		string s282='4- Abonnement Carte UGC'+'|4- Transformation B2B'+'|0- Prolongation B2B sur B2B';
		string s283='4- Abonnement Carte UGC'+'|4- Transformation B2B'+'|1- Prolongation GP plvmts sur B2B';
		string s284='4- Abonnement Carte UGC'+'|4- Transformation B2B'+'|2- Prolongation GP cptant sur B2B';
		
        string s285='4- Abonnement Carte UGC'+'|5- Abonnement en ligne'+'|13- Changement de formule vers UI2';
        string s286='4- Abonnement Carte UGC'+'|5- Abonnement en ligne'+'|1- Abonnement en ligne UI/UU';
		string s287='4- Abonnement Carte UGC'+'|5- Abonnement en ligne'+'|23- Changement de formule vers UI';
		string s288='4- Abonnement Carte UGC'+'|5- Abonnement en ligne'+'|2- Abonnement en ligne UI2';

        string s289='3- Autres demandes d\'informations'+'|1- Divers'+'|1- Coordonnées/contacts siège';  
		string s290='3- Autres demandes d\'informations'+'|1- Divers'+'|2- Ressources humaines';
        string s291='3- Autres demandes d\'informations'+'|1- Divers'+'|31- Demande de remboursement Viva l\'opera!';  
		string s292='3- Autres demandes d\'informations'+'|1- Divers'+'|3- Info Viva L\'Opera!';
        string s293='3- Autres demandes d\'informations'+'|1- Divers'+'|41- Informations sur les droits CNIL';   
		string s294='3- Autres demandes d\'informations'+'|1- Divers'+'|4- CNIL/Comité de la Vie Privée';
        string s295='3- Autres demandes d\'informations'+'|1- Divers'+'|5- Informations sur films';  
		string s296='3- Autres demandes d\'informations'+'|1- Divers'+'|6- Autres';
        string s297='3- Autres demandes d\'informations'+'|1- Divers'+'|7- Geste Commercial';             

        string s298='2- Demande d\'infos generales'+'|1- Autres produits et services'+'|11- E-cartes 5/5+';
		string s299='2- Demande d\'infos generales'+'|1- Autres produits et services'+'|1- Cartes 5/5+'; 
		string s300='2- Demande d\'infos generales'+'|1- Autres produits et services'+'|21- Réservation tarifs spéciaux (réduits/ Cinedays…)'; 
		string s301='2- Demande d\'infos generales'+'|1- Autres produits et services'+'|2- Réservation mode d’emploi';
		string s302='2- Demande d\'infos generales'+'|1- Autres produits et services'+'|3- Autres';
		string s303='2- Demande d\'infos generales'+'|1- Autres produits et services'+'|4- UGC Blue'; 
		string s304='2- Demande d\'infos generales'+'|1- Autres produits et services'+'|5- UGC Solo'; 

        String s305 = '2- Demande d\'infos generales'+'|2- Cinémas UGC'+'|1- Compliments/remerciements';
		String s306 = '2- Demande d\'infos generales'+'|2- Cinémas UGC'+'|2- Infos générales';
		String s307 = '2- Demande d\'infos generales'+'|2- Cinémas UGC'+'|3-objets perdus/trouvés';
		String s308 = '2- Demande d\'infos generales'+'|2- Cinémas UGC'+'|4- PMR (Accès/ programmation…)';
		
         phrase.add(s282);
         phrase.add(s283);
         phrase.add(s284);
         phrase.add(s285);
         phrase.add(s286);
         phrase.add(s287);
         phrase.add(s288);
         phrase.add(s289);
         phrase.add(s290);
         phrase.add(s291);
         phrase.add(s292);
         phrase.add(s293);
         phrase.add(s294);
         phrase.add(s295);
         phrase.add(s296);
         phrase.add(s297);
         phrase.add(s298);
         phrase.add(s299);
         phrase.add(s300);
         phrase.add(s301);
         phrase.add(S302);
         phrase.add(s303);
         phrase.add(s304);
         phrase.add(s305);
         phrase.add(s306);
         phrase.add(s307);
         phrase.add(s308);
          
            
            
		string s309='1- Demandes d\'info UI'+'|1- Réédition de carte'+'|11- Carte défectueuse à faire contrôler en salle';
		string s310='1- Demandes d\'info UI'+'|1- Réédition de carte'+'|21- Demande de frais et photo pour réédition de carte changement de photo';
		string s311='1- Demandes d\'info UI'+'|1- Réédition de carte'+'|2- Changement de photo';
		string s312='1- Demandes d\'info UI'+'|1- Réédition de carte'+'|31- Demande de frais et nouveau nom pour réédition de carte changement de nom';
		string s313='1- Demandes d\'info UI'+'|1- Réédition de carte'+'|3- Changement de nom';
		string s314='1- Demandes d\'info UI'+'|1- Réédition de carte'+'|41- Demande de photo pour une réédition de carte démagnétisée (sans frais) suite à réclamation client';
		string s315='1- Demandes d\'info UI'+'|1- Réédition de carte'+'|42- Demande de photo pour une réédition de carte UI2 démagnétisée (sans frais) suite à réclamation client';
		string s316='1- Demandes d\'info UI'+'|1- Réédition de carte'+'|4- Carte démagnétisée';
		string s317='1- Demandes d\'info UI'+'|1- Réédition de carte'+'|51- Demande de photo pour une réédition de carte abîmée (sans frais)';
		string s318='1- Demandes d\'info UI'+'|1- Réédition de carte'+'|5- Carte abîmée';
		string s319='1- Demandes d\'info UI'+'|1- Réédition de carte'+'|61- Demande de photo pour une réédition de carte démagnétisée (sans frais) suite à constat UGC';
		string s320='1- Demandes d\'info UI'+'|1- Réédition de carte'+'|6- Carte démagnétisée – demande photo';
		string s321='1- Demandes d\'info UI'+'|1- Réédition de carte'+'|6- Réedition sans frais';
		string s322='1- Demandes d\'info UI'+'|1- Réédition de carte'+'|71- Demande de photo pour une réédition de carte photo illisible (sans frais) suite à constat UGC';
		string s323='1- Demandes d\'info UI'+'|1- Réédition de carte'+'|7- Photo illisible – demande photo';
		string s324='1- Demandes d\'info UI'+'|1- Réédition de carte'+'|8- Réédition sans frais';
		

		string s325='1- Demandes d\'info UI'+'|2- Changement de banque'+'|1- Demande de validation adresse';
		string s326='1- Demandes d\'info UI'+'|2- Changement de banque'+'|20- Relance - Envoi formulaire';
		string s327='1- Demandes d\'info UI'+'|2- Changement de banque'+'|2- Envoi formulaire';

        string s328='1- Demandes d\'info UI'+'|3- Abonnement'+'|10- Relance - Envoi formulaire courrier';
		string s329='1- Demandes d\'info UI'+'|3- Abonnement'+'|1- Envoi formulaire courrier';
		string s330='1- Demandes d\'info UI'+'|3- Abonnement'+'|2- Envoi guide pratique';

		string s331='1- Demandes d\'info UI'+'|4- Désabonnement standard'+'|11- Changement tarif/ mandat de prélèvement';
		string s332='1- Demandes d\'info UI'+'|4- Désabonnement standard'+'|1- 1 mois gratuit';
		string s333='1- Demandes d\'info UI'+'|4- Désabonnement standard'+'|12- Changement tarif/ comptant';
		string s334='1- Demandes d\'info UI'+'|4- Désabonnement standard'+'|2- Offre refusée';
		string s335='1- Demandes d\'info UI'+'|4- Désabonnement standard'+'|3- Sans offre de rétention';
		string s336='1- Demandes d\'info UI'+'|4- Désabonnement standard'+'|4- Immédiat : 1 mois gratuit + bonus';
		string s337='1- Demandes d\'info UI'+'|4- Désabonnement standard'+'|51- 2 mois gratuits + bonus';
		string s338='1- Demandes d\'info UI'+'|4- Désabonnement standard'+'|5- 1 mois gratuit + bonus';
		string s339='1- Demandes d\'info UI'+'|4- Désabonnement standard'+'|52- desabonnement standard -offre courrier  1 500 points +DVD (<3/8)';
		string s340='1- Demandes d\'info UI'+'|4- Désabonnement standard'+'|61- Immédiat offre 1 500 POINTS + DVD cadeau (< 3/8)';
		string s341='1- Demandes d\'info UI'+'|4- Désabonnement standard'+'|6- 2 mois gratuits';
		string s342='1- Demandes d\'info UI'+'|4- Désabonnement standard'+'|7- Immédiat : 1 mois gratuit';
		string s343='1- Demandes d\'info UI'+'|4- Désabonnement standard'+'|8- Immédiat : 2 mois gratuits';
		string s344='1- Demandes d\'info UI'+'|4- Désabonnement standard'+'|91- Rétention paiement au comptant';
		string s345='1- Demandes d\'info UI'+'|4- Désabonnement standard'+'|92- Confirmation prise en compte rétention';
		string s346='1- Demandes d\'info UI'+'|4- Désabonnement standard'+'|9- Immédiat : 2 mois gratuits + bonus pvt/dom';

        string s347='1- Demandes d\'info UI'+'|5- Désabonnement exceptionnel'+'|1- Résiliation refusée';
		string s348='1- Demandes d\'info UI'+'|5- Désabonnement exceptionnel'+'|2- Attente de justificatifs';
		string s349='1- Demandes d\'info UI'+'|5- Désabonnement exceptionnel'+'|2- Offre refusée';
		string s350='1- Demandes d\'info UI'+'|5- Désabonnement exceptionnel'+'|3- Annulation de passage vers une autre formule UI';
		string s351='1- Demandes d\'info UI'+'|5- Désabonnement exceptionnel'+'|3- Sans offre de rétention';
		string s352='1- Demandes d\'info UI'+'|5- Désabonnement exceptionnel'+'|4- Immédiat : 1 mois gratuit + bonus';
		string s353='1- Demandes d\'info UI'+'|5- Désabonnement exceptionnel'+'|61- Immédiat offre 1 500 POINTS + DVD cadeau (< 3/8)';
		string s354='1- Demandes d\'info UI'+'|5- Désabonnement exceptionnel'+'|7- Immédiat : 1 mois gratuit';
		string s355='1- Demandes d\'info UI'+'|5- Désabonnement exceptionnel'+'|8- Immédiat : 2 mois gratuits';
		string s356='1- Demandes d\'info UI'+'|5- Désabonnement exceptionnel'+'|91- Rétention paiement au comptant';
		string s357='1- Demandes d\'info UI'+'|5- Désabonnement exceptionnel'+'|9- Immédiat : 2 mois gratuits + bonus pvt/dom';
		 phrase.add(S309);		
         phrase.add(s310);
         phrase.add(s311);
         phrase.add(S312);
         phrase.add(s313);
         phrase.add(s314);
         phrase.add(s315);
         phrase.add(s316);
         phrase.add(s317);
         phrase.add(s318);
         phrase.add(s319);
         phrase.add(s320);
         phrase.add(s321);
         phrase.add(S322);
         phrase.add(s323);
         phrase.add(s324);
         phrase.add(s325);
         phrase.add(s326);
         phrase.add(s327);
         phrase.add(s328);
         phrase.add(s329);
         phrase.add(s330);
         phrase.add(s331);
         phrase.add(S332);
         phrase.add(s333);
         phrase.add(s334);
         phrase.add(s335);
         phrase.add(s336);
         phrase.add(s337);
         phrase.add(s338);
         phrase.add(s339);
         phrase.add(s340);
         phrase.add(s341);
         phrase.add(S342);
         phrase.add(s343);
         phrase.add(s344);
         phrase.add(s345);
         phrase.add(s346);
         phrase.add(s347);
         phrase.add(s348);
         phrase.add(s349); 
         phrase.add(s350);
         phrase.add(s351);
         phrase.add(S352);
         phrase.add(s353);
         phrase.add(s354);
         phrase.add(s355);
         phrase.add(s356);
         phrase.add(s357);


        string s358='1- Demandes d\'info UI'+'|7- Informations compte UI'+'|10- Autres';
		string s359='1- Demandes d\'info UI'+'|7- Informations compte UI'+'|11- FACTURE DEPUIS LE DEBUT DU CONTRAT';
		string s360='1- Demandes d\'info UI'+'|7- Informations compte UI'+'|12- FACTURE DE DATE A DATE';
		string s361='1- Demandes d\'info UI'+'|7- Informations compte UI'+'|13- FACTURE GLOBALE DU COMPTE';
		string s362='1- Demandes d\'info UI'+'|7- Informations compte UI'+'|14- FACTURE PRORATA';
		string s363='1- Demandes d\'info UI'+'|7- Informations compte UI'+'|15- REFUS ATTEST PAIEMENT (PRELEVEMENT)';
		string s364='1- Demandes d\'info UI'+'|7- Informations compte UI'+'|17- Info Commission de surendettement';
		string s365='1- Demandes d\'info UI'+'|7- Informations compte UI'+'|18- Parrainage';
		string s366='1- Demandes d\'info UI'+'|7- Informations compte UI'+'|19- Changement tarifaire';
		string s367='1- Demandes d\'info UI'+'|7- Informations compte UI'+'|1- Fonctionnement du compte';
		string s368='1- Demandes d\'info UI'+'|7- Informations compte UI'+'|20- Passage UI +26ans vers UI2';
		string s369='1- Demandes d\'info UI'+'|7- Informations compte UI'+'|21- Info sur / Demande Annulation passage vers autre formule UI';
		 string s370='1- Demandes d\'info UI'+'|7- Informations compte UI'+'|22- Passage UI - 26 vers UI2';
		string s371='1- Demandes d\'info UI'+'|7- Informations compte UI'+'|23- Passage UI2 vers UI +26ans';
		string s372='1- Demandes d\'info UI'+'|7- Informations compte UI'+'|24- Passage UI2 vers UI -26ans';
		string s373='1- Demandes d\'info UI'+'|7- Informations compte UI'+'|2- Continuation contrat / réabo';
		string s374='1- Demandes d\'info UI'+'|7- Informations compte UI'+'|3- Changement mode de paiement';
		string s375='1- Demandes d\'info UI'+'|7- Informations compte UI'+'|4- Coordonnées personnelles';
		string s376='1- Demandes d\'info UI'+'|7- Informations compte UI'+'|5- Conditions de désabonnement';
		string s377='1- Demandes d\'info UI'+'|7- Informations compte UI'+'|5- Opérations marketing';
		string s378='1- Demandes d\'info UI'+'|7- Informations compte UI'+'|6- Perte/vol';
		string s379='1- Demandes d\'info UI'+'|7- Informations compte UI'+'|7- Retour carte';
		string s380='1- Demandes d\'info UI'+'|7- Informations compte UI'+'|8- Information Impayés';
		string s381='1- Demandes d\'info UI'+'|7- Informations compte UI'+'|91- Compliments/remerciements';
		string s382='1- Demandes d\'info UI'+'|7- Informations compte UI'+'|9- Rétention';

		string s383='1- Demandes d\'info UI'+'|8- Informations commerciales UI/UU (émanant de non abonnés)'+'|1- Demande Infos UI (prospects)';
		string s384='1- Demandes d\'info UI'+'|8- Informations commerciales UI/UU (émanant de non abonnés)'+'|2- Demande Information B2B UI';
		string s385='1- Demandes d\'info UI'+'|8- Informations commerciales UI/UU (émanant de non abonnés)'+'|5- Opérations marketing';
		string s386='1- Demandes d\'info UI'+'|8- Informations commerciales UI/UU (émanant de non abonnés)'+'|6- Autres';
		string s387='1- Demandes d\'info UI'+'|8- Informations commerciales UI/UU (émanant de non abonnés)'+'|7- Dde infos passage autre form';
		string s388='1- Demandes d\'info UI'+'|8- Informations commerciales UI/UU (émanant de non abonnés)'+'|8- Demande Info tarif - 26 ans UI';

         phrase.add(s358);
         phrase.add(s359); 
         phrase.add(s360);
         phrase.add(s361);
         phrase.add(S362);
         phrase.add(s363);
         phrase.add(s364);
         phrase.add(s365);
         phrase.add(s366);
         phrase.add(s367);
         phrase.add(s368);
         phrase.add(s369); 
         phrase.add(s370);
         phrase.add(s371);
         phrase.add(S372);
         phrase.add(s373);
         phrase.add(s374);
         phrase.add(s375);
         phrase.add(s376);
         phrase.add(s377);
         phrase.add(s378);
         phrase.add(s379);
         phrase.add(s380);
         phrase.add(s381);
         phrase.add(S382);
         phrase.add(s383);
         phrase.add(s384);
         phrase.add(s385);
         phrase.add(s386);
         phrase.add(s387);
         phrase.add(s388);
  
  
		return phrase;
    	} 
    
    
    
    private static String changeDateFormat(String oldDate) {
        if(oldDate == null) {
            return null;
        }
        String [] dateSplite = oldDate.split('-');
        Integer annee = Integer.valueOf(dateSplite[0]);
        Integer mois = Integer.valueOf(dateSplite[1]);
        Integer jour = Integer.valueOf(dateSplite[2]);
        Datetime newDate = datetime.newInstanceGMT(annee, mois, jour);
        return newDate.format('yyyy-MM-dd\'T\'hh:mm:ss\'z\''); 
    } 

    private static String changeDateFormat2(String oldDate) {
        if(oldDate == null) {
            return null;
        }
        String [] dateSplite = oldDate.split('-');
        Integer annee = Integer.valueOf(dateSplite[0]);
        Integer mois = Integer.valueOf(dateSplite[1]);
        Integer jour = Integer.valueOf(dateSplite[2]);
        Datetime newDate = datetime.newInstanceGMT(annee, mois, jour);
        return newDate.addDays(1).format('yyyy-MM-dd\'T\'hh:mm:ss\'z\''); 
    } 
    
    private static String supplementWhereClause(String prefix, String dateOuverture, String dateCloture, String carte, String produit) {
        String clause = '';
        if(prefix == null || prefix == '') {
            prefix = '';
        } else {
            prefix += '.';
        }
        String newDateOuvertureToString = changeDateFormat(dateOuverture);
        String newDateClotureToString = changeDateFormat2(dateCloture);
        
        if(newDateOuvertureToString != null){
            clause += ' AND ' + prefix + 'CreatedDate >= ' + newDateOuvertureToString;
        }
        if(newDateClotureToString != null){
            clause += ' AND ' + prefix + 'ClosedDate < ' + newDateClotureToString;
        }
        if(carte != null && carte == 'Oui'){
            clause += ' AND ' + prefix + 'Account.NoCarteUI__c != null';
        }
        if(carte != null && carte == 'Non'){
            clause += ' AND ' + prefix + 'Account.NoCarteUI__c = null';
        }
        if(produit != null && produit == 'Français'){
            clause += ' AND ' + prefix + 'Account.ProduitUGC__c  = \'français\'';
        }
        if(produit != null && produit == 'Belge'){
            clause += ' AND ' + prefix + 'Account.ProduitUGC__c  = \'belge\'';
        }
       
        return clause;
    }
    
    @AuraEnabled
    public static list<String[]> fetchCasesContactsEntrants(String dateOuverture, String dateCloture, String carte, String produit){
       
        
        String query = 'SELECT TECH_FamilleMatrice__c, TECH_MotifMatrice__c, TECH_SousMotifMatrice__c, SUM(NbCourriersEntrants__c) courrierEntrant, COUNT(Id) nbCases, ' 
            + ' SUM(NbEmailsEntrants__c) emailEntrant, SUM(NbAppelsEntrants__c) appelEntrant, SUM(NbFormulaireContact__c) formulaireContact, SUM(NbFacebook__c) facebook, SUM(NbTwitter__c) twitter, SUM(NbCritizr__c) critizr';
        query += ' FROM Case WHERE Origin != \'Interne\' AND  TECH_FamilleMatrice__c != null AND  TECH_MotifMatrice__c != null AND TECH_SousMotifMatrice__c != null ';
       
        
        query += supplementWhereClause(null, dateOuverture, dateCloture, carte, produit);
        
        query += ' GROUP BY TECH_FamilleMatrice__c, TECH_MotifMatrice__c, TECH_SousMotifMatrice__c';
        query += ' ORDER BY TECH_FamilleMatrice__c, TECH_MotifMatrice__c, TECH_SousMotifMatrice__c ';
        
      
        AggregateResult[] aggs = Database.query(query);
    
        
        List<String[]> listeElements = new List<String[]>();
  		map<String,List<String>> myMap = new Map<String,List<String>>();
        for(AggregateResult agr : aggs){
             Double numVal6; 
             Double numVal7;
             Double numVal8;
             Double numVal1 = (Double)agr.get('courrierEntrant');
             Double numVal2 = (Double)agr.get('emailEntrant');
             Double numVal3 = (Double)agr.get('appelEntrant'); 
             Double numVal4 = (Double)agr.get('formulaireContact');
            if((Double)agr.get('facebook') == null){  numVal6 = 0;}
            else{ numVal6 = (Double)agr.get('facebook');}
            if((Double)agr.get('twitter') == null){ numVal7 = 0;}
            else { numVal7 = (Double)agr.get('twitter');}
            if((Double)agr.get('critizr') == null){ numVal8 = 0;}
            else{ numVal8 = (Double)agr.get('critizr');}
           
            Double numVal5 = numVal1 + numVal2 + numVal3+ numVal4 + numVal6 + numVal7 + numVal8;
           string mys = ((String) agr.get('TECH_FamilleMatrice__c')) + ((String) agr.get('TECH_MotifMatrice__c')) + ((String) agr.get('TECH_SousMotifMatrice__c'));
   		   List<String> myList = new List<String>();
              if(numVal5 != null) {
               myList.add(String.valueOf(numVal5.longValue()));
            } else {
                myList.add('0');
            }
            if(numVal1 != null) {
               myList.add(String.valueOf(numVal1.longValue()));
            } else {
               myList.add('0');
            }
            if(numVal2 != null) {
			    myList.add(String.valueOf(numVal2.longValue()));
            } else {
               myList.add('0');
            }
            if(numVal3 != null) {
                myList.add(String.valueOf(numVal3.longValue()));
            } else {
                myList.add('0');
            }
            if(numVal4 != null) {
                 myList.add(String.valueOf(numVal4.longValue()));
            } else {
               myList.add('0');
            }
            
             if(numVal6 != null) {
                 myList.add(String.valueOf(numVal6.longValue()));
            } else {
                myList.add('0');
            }
            if(numVal7 != null) {
                 myList.add(String.valueOf(numVal7.longValue()));
            } else {
               myList.add('0');
            }
            if(numVal8 != null) {
                myList.add(String.valueOf(numVal8.longValue()));
            } else {
                 myList.add('0');
            }
           myMap.put(mys,myList);
        }
		List<String> contacts = tableau();
        
            for(String ct : contacts){
                String[] line= new List<String>();
            	String[] sp = ct.split('\\|');
                string s ='';
                for(integer i = 0; i<sp.size(); i++ ){
                s = s + sp[i];
                line.add(sp[i]);
                }
                if(myMap.containsKey(s)){
                    for(String ss: mymap.get(s)){
                       line.add(ss);  
                    }    
                }else{
                line.add('0');
                line.add('0');
                line.add('0');
                line.add('0');
                line.add('0');
                line.add('0');
                line.add('0');
                line.add('0');
                }
                listeElements.add(line);
            }
        return listeElements;
    }
        
    @AuraEnabled
    public static list<String[]> fetchCasesContactsSortants(String dateOuverture, String dateCloture, String carte, String produit){
       
        
        String quer = 'SELECT TECH_FamilleMatrice__c, TECH_MotifMatrice__c, TECH_SousMotifMatrice__c, COUNT(Id) nbCases, '
            + 'SUM(NbCourriersSortants__c) courrierSortant, SUM(NbEmailsSortants__c) emailSortant, SUM(NbAppelsSortants__c) appelSortant';
        quer += ' FROM Case WHERE Origin != \'Interne\' AND  TECH_FamilleMatrice__c != null AND  TECH_MotifMatrice__c != null AND TECH_SousMotifMatrice__c != null ';
        
   
        
        quer += supplementWhereClause(null, dateOuverture, dateCloture, carte, produit);
        
        quer += ' GROUP BY TECH_FamilleMatrice__c, TECH_MotifMatrice__c, TECH_SousMotifMatrice__c';
        quer += ' ORDER BY TECH_FamilleMatrice__c, TECH_MotifMatrice__c, TECH_SousMotifMatrice__c';
        
      
        AggregateResult[] cases = Database.query(quer);
     
       map<String,List<String>> myMap = new Map<String,List<String>>();
        List<String[]> listeElement = new List<String[]>(); 
        
        for(AggregateResult agr : cases) {
            
            Double numVal1 = (Double)agr.get('courrierSortant');
            Double numVal2 = (Double)agr.get('emailSortant');
            Double numVal3 = (Double)agr.get('appelSortant');
            Double numVal5 = numVal1 + numVal2+numVal3;
        
           String mys = ((String) agr.get('TECH_FamilleMatrice__c')) + ((String) agr.get('TECH_MotifMatrice__c')) + ((String) agr.get('TECH_SousMotifMatrice__c'));
           List<String> myList = new List<String>();
            if(numVal5 != null) {
                myList.add(String.valueOf(numVal5.longValue()));
            } else {
                myList.add('0');
            }
            if(numVal1 != null) {
                myList.add(String.valueOf(numVal1.longValue()));
            } else {
                myList.add('0');
            }
            if(numVal2 != null) {
                myList.add(String.valueOf(numVal2.longValue()));
            } else {
                myList.add('0');
            }
            if(numVal3 != null) {
                myList.add( String.valueOf(numVal3.longValue()) );
            } else {
                myList.add('0');
            }
            mymap.put(mys,myList);
        }
			List<String> contacts = tableau();
            for(String ct : contacts){
                String[] line= new List<String>();
            	String[] sp = ct.split('\\|');
                 string s ='';
                for(integer i = 0; i<sp.size(); i++ ){
                s = s + sp[i];
                line.add(sp[i]);
                }
                if(myMap.containsKey(s)){
                    for(String ss: mymap.get(s)){
                       line.add(ss);  
                    }    
                }else{
                line.add('0');
                line.add('0');
                line.add('0');
                line.add('0');}
                listeElement.add(line);
            }
        
        return listeElement;
    }
    
    @AuraEnabled
    public static list<String[]> fetchCasesFluxInternes(String dateOuverture, String dateCloture, String carte, String produit) {
      
		List<Case> cases;
        
        String [] dateSplite = dateOuverture.split('-');
        Integer annee = Integer.valueOf(dateSplite[0]);
        Integer mois = Integer.valueOf(dateSplite[1]);
        Integer jour = Integer.valueOf(dateSplite[2]);
        
        String [] dateSplite1 = dateCloture.split('-');
        Integer annee1 = Integer.valueOf(dateSplite1[0]);
        Integer mois1 = Integer.valueOf(dateSplite1[1]);
        Integer jour1 = Integer.valueOf(dateSplite1[2]);
        
         Date newDateOuverture = date.newInstance(annee, mois, jour);
        Date newDateCloture = date.newInstance(annee1,mois1,jour1);
        
        if(carte == null && produit== null){ cases = [Select id from case where CreatedDate >=: newDateOuverture AND CreatedDate <=: newDateCloture];}
        if(carte == null && produit!= null){ cases = [Select id from case where CreatedDate >=: newDateOuverture AND CreatedDate <=: newDateCloture and Account.ProduitUGC__c =:produit];}
        if(carte != null && produit== null){ cases = [Select id from case where CreatedDate >=: newDateOuverture AND CreatedDate <=: newDateCloture and NoCarteUI__c =:carte];}
        if(carte != null && produit!= null){ cases = [Select id from case where CreatedDate >=: newDateOuverture AND CreatedDate <=: newDateCloture and NoCarteUI__c =:carte and Account.ProduitUGC__c =:produit];}
        List<AggregateResult> mesC = [SELECT TECH_FamilleMatrice__c, TECH_MotifMatrice__c, TECH_SousMotifMatrice__c, COUNT(Id) nbCases  FROM Case WHERE id in :cases and Origin='Salle' AND  TECH_FamilleMatrice__c != null AND  TECH_MotifMatrice__c != null AND TECH_SousMotifMatrice__c != null GROUP BY TECH_FamilleMatrice__c, TECH_MotifMatrice__c, TECH_SousMotifMatrice__c];
     	
        map<String,List<String>> myMap = new Map<String,List<String>>();
        List<String[]> listeElements = new List<String[]>();
        for(AggregateResult agr : mesC){
            
            Double numVal1 = (Double)agr.get('nbCases');
        	string mys = ((String) agr.get('TECH_FamilleMatrice__c')) + ((String) agr.get('TECH_MotifMatrice__c')) + ((String) agr.get('TECH_SousMotifMatrice__c'));
   		   	List<String> myList = new List<String>();
              if(numVal1 != null) {
               myList.add(String.valueOf(numVal1.longValue()));
            } else {
                myList.add('0');
            } 
           mymap.put(mys,myList);
        }
        
		List<String> contacts = tableau();
            for(String ct : contacts){
                String[] line= new List<String>();
            	String[] sp = ct.split('\\|');
                 string s ='';
                for(integer i = 0; i<sp.size(); i++ ){
                s = s + sp[i];
                line.add(sp[i]);
                }
                if(myMap.containsKey(s)){
                    for(String ss: mymap.get(s)){
                       line.add(ss);  
                    }    
                }else{
                line.add('0');
                }
                listeElements.add(line);
            }
        
        return listeElements;
    }
    
    public static set<String> getParamManquants(Set<String> paramExistants){
        List<String> contacts = tableau();
        
		set<String> paramManquants = new set<String>();
        for(String str : contacts){
            	String[] sp = str.split('\\|');
            	string s ='';
                for(integer i = 0; i<sp.size(); i++ ){
                s = s + sp[i].substring(0, 1);
                }
            if(!paramExistants.contains(s)){
                paramManquants.add(str);
            }
        }
        
        return paramManquants;
    } 
    
    
  @AuraEnabled
    public static List<String[]> fetchCourriersAutoSortants(String dateOuverture, String dateCloture, String carte, String produit){
        System.debug('IN fetchCourriersAutoSortants // Variable : Date O = ' + dateOuverture + ' Date C = ' + dateCloture + ' carte = ' + carte + '');
      
        String query = 'SELECT SDOC__SDoc__r.SDOC__SDTemplate__r.Name template,  SDOC__SDoc__r.SDOC__SDTemplate__r.SDOC__Template_Format__c format, count(Id) nb'; 
        query += ' FROM SDOC__SDRelationship__c WHERE SDOC__SDoc__r.SDOC__SDTemplate__r.Name != null';
        
        System.debug('QUERY = ' + query);
        
        query += supplementWhereClause('SDOC__Case__r', dateOuverture, dateCloture, carte, produit);
        
        query += ' GROUP BY  SDOC__SDoc__r.SDOC__SDTemplate__r.SDOC__Template_Format__c, SDOC__SDoc__r.SDOC__SDTemplate__r.Name';
        query += ' ORDER BY SDOC__SDoc__r.SDOC__SDTemplate__r.SDOC__Template_Format__c';
        
        System.debug('QUERY FINALE= ' + query);
        List<AggregateResult> aggs = Database.query(query);
        System.debug('LISTE Aggs = ' + aggs.size());
        
        integer pdf =0;
        integer html =0;
        integer doc =0;
       	integer i = 0;
       List<String[]> res = new List<String[]>(); 
       List<String> line1= new List<String>();
       List<String> line2= new List<String>();
       List<String> line3= new List<String>();
       List<String> line4= new List<String>();
       List<SDOC__SDTemplate__c> templates = [select Name from SDOC__SDTemplate__c order by name asc];
       Map<String, String> formats =new Map<String,String>();
        List <String> l1 =new List<String>();
        List <String> l2 =new List<String>();
        List <String> l3 =new List<String>();

       for(SDOC__SDTemplate__c ag: templates) {
		   formats.put(ag.name.toUpperCase()+' DOC','0');
           formats.put(ag.name.toUpperCase()+' HTML','0');
           formats.put(ag.name.toUpperCase()+' PDF','0');
        }
        Set<String> malistes= formats.KeySet();
         for(AggregateResult agg: aggs) {
             String s = ((String)agg.get('template') +' '+(String)agg.get('format')).toUpperCase();
             if(malistes.contains(s)){
             system.debug('nots'+s);
             formats.put(s,String.valueOf(agg.get('nb')));}
            if((String)agg.get('format')=='PDF'){pdf=pdf+ integer.valueOf(agg.get('nb'));}
            if((String)agg.get('format')=='HTML'){html = html+ integer.valueOf(agg.get('nb'));}
            if((String)agg.get('format')=='DOC'){doc = doc+ integer.valueOf(agg.get('nb'));} 
               
        }
        for(String ss : malistes){
          List<String> line= new List<String>();
            line.add(ss.toLowerCase());
            line.add(formats.get(ss));
            line.add( ' ');
			res.add(line);  
        }
        				
        
       		line3.add(' ');
            line4.add(' ');
        	res.add(line3);
        	res.add(line4);
       		line1.add('Total');
            line1.add('PDF');
           	line1.add( 'HTML');
        	line1.add( 'DOC');
            res.add(line1);
       		line2.add(''+(pdf+html+doc));
            line2.add(''+pdf);
           	line2.add(''+html);
        	line2.add(''+doc);
            res.add(line2);

    return res;
    }

    
    @AuraEnabled
    public static List<String[]> fetchExport(String dateOuverture, String dateCloture, String carte, String produit) {
        String newDateOuvertureToString = changeDateFormat(dateOuverture);
        String newDateClotureToString = changeDateFormat(dateCloture);
        
        String query = 'SELECT ID, SousMotif__c, TECHIdStatut__c, Account.ProduitUGC__c, Account.PNDADRESSE__c FROM Case ';
        query += ' WHERE Famille__c != null AND  Motif__c != null AND SousMotif__c != null AND TECHIdStatut__c != null ';
        System.debug('QUERY = ' + query);
        
        query += supplementWhereClause(null, dateOuverture, dateCloture, carte, produit);
        System.debug('QUERY FINALE= ' + query);
        List<Case> cases = Database.query(query);
        
        Map<Id, Case> mapIdCase = new Map<Id, Case>();
        for(Case oCase: cases) {
            mapIdCase.put(oCase.Id, oCase);
        }
        
        List<Task> tasks = [SELECT Id, WhatId, Origine__c FROM Task WHERE What.Type = 'Case' AND Origine__c != null 
                            AND WhatId IN :mapIdCase.keySet()];
        Map<ExportKey, Integer> counts = new Map<ExportKey, Integer>();
        for(Task task: tasks) {
            incrCount(counts, getKey(task, mapIdCase.get(task.WhatId)));
        }
        
        List<ExportKey> keys = new List<ExportKey>(counts.keySet());
        keys.sort();
        
        List<String[]> lignes = new List<String[]>(); 
        // Impossible d'avoir les champs de CASE à partir de TASK
        for(ExportKey key: keys) {
            List<String> ligne = new List<String>();
            ligne.add(counts.get(key).format());
            ligne.add(key.description);
            ligne.add(key.id_media_type);
            ligne.add(key.id_statut);
            ligne.add(key.direction);
            ligne.add('');
            ligne.add(key.base);
            ligne.add(key.pnd);
            lignes.add(ligne);
        }
        return lignes;
    }
    
    private static ExportKey getKey(Task task, Case oCase) {
        ExportKey key = new ExportKey();
        key.description = oCase.SousMotif__c;
        key.id_media_type = task.Origine__c;
        key.id_statut = oCase.TECHIdStatut__c;
        if(task.Origine__c.endsWith('entrant')) {
            key.direction = 'Entrant';
        } else if(task.Origine__c.endsWith('sortant')) {
            key.direction = 'Sortant';
        } else {
            key.direction = '';
        }
        if(oCase.Account.ProduitUGC__c  == 'français') {
            key.base = 'NonUI_fr';
        } else if(oCase.Account.ProduitUGC__c  == 'belge') {
            key.base = 'NonUI_be';
        } else {
            key.base = '';
        }
        if(oCase.Account.PNDADRESSE__c) {
            key.pnd = 'Oui';
        } else {
            key.pnd = 'Non';
        }
        return key;
    }
    
    private static void incrCount(Map<ExportKey, Integer> counts, ExportKey key) {
        if(counts.get(key) == null) {
            counts.put(key, 1);
        } else {
            counts.put(key, counts.get(key) + 1);
        }
    }
    
    private class ExportKey implements Comparable {
        public String description;
        public String id_media_type;
        public String id_statut;
        public String direction;
        public String base;
        public String pnd;
        
        public Boolean equals(Object obj) {
            if (obj instanceof ExportKey) {
                ExportKey p = (ExportKey)obj;
                return (description==p.description) && (id_media_type==p.id_media_type) 
                    && (id_statut == p.id_statut) && (direction == p.direction)
                    && (base == p.base) && (pnd == p.pnd);
            }
            return false;
        }
        
        public Integer hashCode() {
            Integer res = 0;
            if(description != null) {
                res = (31 * res) ^ description.hashCode();
            }
            if(id_media_type != null) {
                res = (31 * res) ^ id_media_type.hashCode();
            }
            if(id_statut != null) {
                res = (31 * res) ^ id_statut.hashCode();
            }
            if(direction != null) {
                res = (31 * res) ^ direction.hashCode();
            }
            if(base != null) {
                res = (31 * res) ^ base.hashCode();
            }
            if(pnd != null) {
                res = (31 * res) ^ pnd.hashCode();
            }
            
            return res;
        }
        
        private Integer compareStrings(String s1, String s2) {
            if(s1 == null && s2 == null) {
                return 0;
            }
            if(s2 == null) {
                return -1;
            }
            if(s1 == null ) {
                return 1;
            }
            return s1.compareTo(s2);
            
        }
        
        public Integer compareTo(Object compareTo) {
            if(compareTo == null) {
                return -1;
            }
            ExportKey key = (ExportKey) compareTo;
            if(compareStrings(id_statut, key.id_statut) != 0) {
                return compareStrings(id_statut, key.id_statut);
            }
            if(compareStrings(direction, key.direction) != 0) {
                return compareStrings(direction, key.direction);
            }
            if(compareStrings(id_media_type, key.id_media_type) != 0) {
                return compareStrings(id_media_type, key.id_media_type);
            }
            if(compareStrings(base, key.base) != 0) {
                return compareStrings(base, key.base);
            }
            if(compareStrings(pnd, key.pnd) != 0) {
                return compareStrings(pnd, key.pnd);
            }
            return 0;
            
        }
    }
    
    @AuraEnabled
    public static List<String[]> fetchCompteursPrime(String dateOuverture, String dateCloture, String produit) {
        Date dateDebut = Date.valueOf(dateOuverture);
        Date dateFin = Date.valueOf(dateCloture);
        List<String> names =  new List<String>();
       
        CalculPrimes.tallyBelgianCounters();
        CalculPrimes.tallyFrenchCounters();
        
        BusinessHours bh;
        List<Group> groupes = [SELECT DeveloperNAME FROM Group WHERE Type='Queue'];
       
        if(produit == 'Belge') {
            for(Group g :groupes){
                if(g.DeveloperNAME.substring(0, 3) == 'BE_' || g.DeveloperNAME.substring(0, 3) == 'be_' || g.DeveloperNAME.substring(0, 3) == 'Be_' || g.DeveloperNAME.substring(0, 3) == 'bE_'){names.add(g.DeveloperNAME);}
            } bh = [SELECT Id, name FROM BusinessHours WHERE name='Belgique'];
        }
        else{
            for(Group g :groupes){
                if(g.DeveloperNAME.substring(0, 3) != 'BE_' && g.DeveloperNAME.substring(0, 3) != 'be_' && g.DeveloperNAME.substring(0, 3) != 'Be_' && g.DeveloperNAME.substring(0, 3) != 'bE_'){names.add(g.DeveloperNAME);}
            } bh = [SELECT Id, name FROM BusinessHours WHERE name='France'];
        }
       
        System.debug(names.size());
        List<Group> queues = [SELECT Id, DeveloperNAME, Name 
                              FROM Group 
                              WHERE Type = 'Queue'
                              AND DeveloperNAME IN :names 
                              ORDER BY Name];

        List<String> labels = new List<String>();
        Map<String, String> nameMap = new Map<String, String>();
        
        for(Group queue: queues) {
            labels.add(queue.Name);
            nameMap.put(queue.Name, queue.DeveloperNAME);
        }
       System.debug(labels.size());
        List<Date> dates =  getJoursOuvres(bh, dateDebut, dateFin);
        
        List<Compteur_Prime__c> compteurs = [SELECT id, Queue_Name__c, Date_du_jour__c, Date_Demande__c, Delai__c
                                             FROM Compteur_Prime__c
                                             WHERE Date_du_jour__c >= :dateDebut AND Date_du_jour__c <= :dateFin
                                             AND Queue_Name__c IN :names 
                                             ORDER BY Queue_Name__c];
        
        Map<String, Map<Date, Compteur_Prime__c>> mapQueueCompteurs = new Map<String, Map<Date, Compteur_Prime__c>>();
        for(Compteur_Prime__c cpt: compteurs) {
            if(mapQueueCompteurs.get(cpt.Queue_Name__c) == null) {
                mapQueueCompteurs.put(cpt.Queue_Name__c, new Map<Date, Compteur_Prime__c>());
            }
            mapQueueCompteurs.get(cpt.Queue_Name__c).put(cpt.Date_du_jour__c, cpt);
        }
        List<String[]> lines = new List<String[]>();
        addHeaderLines(lines, dates);
        
        for(String label: labels) {
            String name = nameMap.get(label);
            String[] line = new List<String>();
            
            line.add(label);
            Map<Date, Compteur_Prime__c> mapDateCpt = mapQueueCompteurs.get(name);
            if(mapDateCpt != null) {
                Decimal delaiTotal = 0;
                Decimal  moy = 0;
                for(Date d: dates) {
                    Compteur_Prime__c cpt = mapDateCpt.get(d);
                    if(cpt != null) {
                        DateTime dt = DateTime.newInstance(cpt.Date_Demande__c, Time.newInstance(0, 0, 0, 0));
                        
                        line.add(dt.format('dd-MMM'));
                        line.add(String.valueOf(cpt.Delai__c));
                        delaiTotal += cpt.Delai__c;
                        moy = moy +1;
                    } else {
                        line.add('N/A');
                        line.add('N/A');
                    }
                }
                if(dates.size() > 0) {
                    Decimal avg = delaiTotal / moy;
                    line.add(String.valueOf(avg.setScale(2)));
                } else {
                    line.add('N/A');
                }
            } else {
                for(Date d: dates) {
                    line.add('N/A');
                    line.add('N/A');
                }
                line.add('N/A');
            }
            lines.add(line);
        }
        return lines;
    }
    
    private static List<Date> getJoursOuvres(BusinessHours bh, Date dateDebut, Date dateFin) {
        List<Date> dates = new List<Date>();
        for(Date d = dateDebut; d <= dateFin; d = d.addDays(1)) {
            if(BusinessHours.isWithin(bh.Id, d)) {
                dates.add(d);
            }
        }
        system.debug('CsvGeneratorCtrl ## dates ouvrées: ' + dates);
        return dates;
    }
    
    private static void addHeaderLines(List<String[]> lines, List<Date> dates) {
        if(dates.size() == 0) {
            return;
        }
        String[] line = new List<String>();
        line.add('ANNEE ' + dates.get(0).year());
        for(Date d : dates) {
            DateTime dt = DateTime.newInstance(d, Time.newInstance(0, 0, 0, 0));
            line.add(dt.format('dd-MMM'));
            line.add('');
        }
        line.add('Moyenne délai de');
        lines.add(line);
        
        line = new List<String>();
        line.add('Traitement en jours ouvrés');
        for(Date d : dates) {
            line.add('J+1');
            line.add('');
        }
        line.add('traitement en jours');
        lines.add(line);
    }
    
    public static List<String[]> sortElements(List<String[]> elements){
        System.debug('--#### Trie de la liste d\'élements.');
        Map<String, String[]> elementsMap = new Map<String, String[]>();
        List<String[]> elementsOrder = new List<String[]>();
        
        for(String[] strTab : elements){
            String key = strTab[0]+'-'+strTab[1]+'-'+strTab[2];
            elementsMap.put(key, strTab);
        }
        
        List<String> keysOrder = new List<String>();
        keysOrder.addAll(elementsMap.keySet());
        keysOrder.sort();
        for(String strKey : keysOrder){
            elementsOrder.add(elementsMap.get(strKey));
        }
        return elementsOrder;
        
    }
    
    
    }