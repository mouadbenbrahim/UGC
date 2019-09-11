/**
 * @File Name          : SM_Impaye.cls
 * @Description        : 
 * @Author             : mouad
 * @Group              : 
 * @Last Modified By   : mouad
 * @Last Modified On   : 09/09/2019 à 05:37:02
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    06/09/2019   mouad     Initial Version
**/
public with sharing class SM_Impaye {
    public SM_Impaye() {

    }

    public Static void reglerImpaye(String zSubId){

        // 1.Paiement par CB de l impaye: fait par Hermes

        // 2.Reactivation du contrat: delete du cancel
        // WSZ.SubOut resultat = SM_Subscription.deleteSub(subId, zEntityId) 

        // 3.Ajout Frais de gestion  
        ZUC.ActionAmendRequest lc1 = new ZUC.ActionAmendRequest();
        ZUC.AmendRequest c1 = new ZUC.AmendRequest();
        // lc1.requests.add(c1);
        c1.previewOptions.enablePreviewMode=false;
        c1.amendOptions.generateInvoice=true;
        // c1.amendOptions.processPayments=false;
        c1.amendOptions.invoiceProcessingOptions.invoiceDate=Date.newInstance(2019, 09, 08);
        c1.amendOptions.invoiceProcessingOptions.invoiceTargetDate=Date.newInstance(2019, 09, 08);
        ZUC.Amendment amend1 = new ZUC.Amendment();        
        amend1.contractEffectiveDate=Date.newInstance(2019, 09, 08);
        amend1.effectiveDate=Date.newInstance(2019, 09, 08);
        amend1.name='Frais de gestion';
        amend1.status='Completed';
        amend1.subscriptionId='8adc9dee6ce30c61016cf7ee5f7e444c';
        amend1.r_type='NewProduct';
        amend1.description='Ajout charge Frais de gestion';                        
        amend1.ratePlanData.ratePlan.productRatePlanId='8adc8f996ab537c9016ab64cac9736c4';                
        ZUC.RatePlanChargeDataInRatePlanData rpc = new ZUC.RatePlanChargeDataInRatePlanData();
        rpc.price = 20;
        rpc.productRatePlanChargeId = '8adc8f996ab537c9016ab64cacae36c6';                
        amend1.ratePlanData.ratePlanChargeData.add(rpc);                        
        c1.amendments.add(amend1);
        lc1.requests.add(c1);
        
        //Call Zuora
        String access_token = WS001_CallZuora.oauthLogin();
        String zEntityId = WS001_CallZuora.getZuoraEntityId('FR');
        //String wsIn = (String) JSON.serialize(lc1);
        ZUC.AmendResult amendResult = new ZUC.AmendResult();               
        amendResult = (ZUC.AmendResult) WS001_CallZuora.sendRequest2(access_token, '/v1/action/amend', zEntityId, 'POST', lc1, 
        ZUC.AmendRequest.class, ZUC.AmendResult.class, null);
        System.debug(amendResult);


        // Creation paiement Zuora 

        // Cancel du contrat 

        // Mise a jour contrat 

        // Mise a jour compte 

        // Mise a jour facture 

    }
}