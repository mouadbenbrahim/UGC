/**
 * @File Name          : SM_Impaye.cls
 * @Description        : 
 * @Author             : mouad
 * @Group              : 
 * @Last Modified By   : mouad
 * @Last Modified On   : 08/09/2019 à 19:34:27
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    06/09/2019   mouad     Initial Version
**/
public with sharing class SM_Impaye {
    public SM_Impaye() {

    }

    public Static void reglerImpaye(String zSubId){

        // Paiement par CB de l impaye: fait par Hermes

        // Reactivation du contrat: delete du cancel
        // WSZ.SubOut resultat = SM_Subscription.deleteSub(subId, zEntityId) 

        // Ajout Frais de gestion  
        ZUC.AmendRequest c1 = new ZUC.AmendRequest();
        c1.previewOptions.enablePreviewMode=false;
        c1.amendOptions.generateInvoice=true;
        // c1.amendOptions.processPayments=false;
        c1.amendOptions.invoiceProcessingOptions.invoiceDate=Date.newInstance(2019, 04, 05);
        c1.amendOptions.invoiceProcessingOptions.invoiceTargetDate=Date.newInstance(2019, 04, 05);
        ZUC.Amendment amend1 = new ZUC.Amendment();        
        amend1.contractEffectiveDate=Date.newInstance(2019, 04, 05);
        amend1.effectiveDate=Date.newInstance(2019, 04, 05);
        amend1.name='Frais de gestion';
        amend1.status='Completed';
        amend1.subscriptionId='xxxxx';
        amend1.r_type='NewProduct';
        amend1.description='Ajout charge Frais de gestion';                        
        amend1.ratePlanData.ratePlan.productRatePlanId='xxxxx';                
        ZUC.RatePlanChargeDataInRatePlanData rpc = new ZUC.RatePlanChargeDataInRatePlanData();
        rpc.price = 20;
        rpc.productRatePlanChargeId = 'xxx';                
        amend1.ratePlanData.ratePlanChargeData.add(rpc);                        
        c1.amendments.add(amend1);


        // Creation paiement Zuora 

        // Cancel du contrat 

        // Mise a jour contrat 

        // Mise a jour compte 

        // Mise a jour facture 

    }
}