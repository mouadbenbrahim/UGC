/**
 * @File Name          : ZUC_test.cls
 * @Description        : 
 * @Author             : mouad
 * @Group              : 
 * @Last Modified By   : mouad
 * @Last Modified On   : 08/09/2019 à 00:21:13
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    07/09/2019   mouad     Initial Version
**/

// ZUC.test1();
    ZUC.AmendRequest c1 = new ZUC.AmendRequest();
    c1.amendOptions.generateInvoice=false;
    c1.amendOptions.processPayments=false;
    c1.amendOptions.invoiceProcessingOptions.invoiceDate=null; // Date.newInstance(2000, 1, 23);
    c1.amendOptions.invoiceProcessingOptions.invoiceTargetDate=null;
    ZUC.Amendment amend1 = new ZUC.Amendment();
    c1.amendments.add(amend1);
    c1.amendments[0].contractEffectiveDate=Date.newInstance(2019, 09, 07);
    c1.amendments[0].description='Ajout charge reactivation';
    c1.amendments[0].name='Ajout charge reactivation';
    c1.amendments[0].status='Completed';
    c1.amendments[0].subscriptionId='';
    c1.amendments[0].r_type='NewProduct';
    c1.amendments[0].ratePlanData.ratePlan.productRatePlanId='';
    c1.previewOptions.enablePreviewMode=false;


// c1.AmendRequest_getExample();
// ZUC.AmendRequestPreviewOptions prev = new ZUC.AmendRequestPreviewOptions();
// prev.
// c1.amendments[0].autoRenew = true;