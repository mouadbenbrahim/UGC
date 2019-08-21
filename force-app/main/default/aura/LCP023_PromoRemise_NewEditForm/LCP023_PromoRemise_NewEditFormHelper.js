({
    getPromoRemiseRTid: function(component){
        // var promoId = component.get("v.rec.fields.Id.value");
        // var promoRT = component.get("v.promo.recordTypeInfo.name");
        var promoId = component.get("v.promoId");
        console.log("MBEN: promoId" + promoId);

        var action = component.get("c.getPromoRemiseRTid");
        action.setParams({
             promoId : promoId
            })
        action.setCallback(this, function(response, component) {
        var functionResult = response.getReturnValue();
        component.set("v.promoRemiseRTid",functionResult);
                //$A.get("e.force:closeQuickAction").fire();
            });
        $A.enqueueAction(action);
    },

    showHide: function(component){

        $A.util.addClass(component.find("rType"), "slds-hide");
        $A.util.removeClass(component.find("rMontant"), "slds-hide");
        $A.util.removeClass(component.find("rNombremensu"), "slds-hide");
        $A.util.removeClass(component.find("rDebutexmois"), "slds-hide");

        var chargeId = component.find("chargeLkp").get("v.value");
        var action = component.get("c.getCharge");
        // var chargeId = component.get("v.charge");


        console.log('MBEN 4: ' + chargeId);
        action.setParams({
        	// chargeId : 'a1F0E000000YX8oUAG'
        	chargeId : chargeId
        	})
        action.setCallback(this, function(response, component) {
        var functionResult = response.getReturnValue();
        		    //$A.get("e.force:closeQuickAction").fire();
                console.log('MBEN 5:' + JSON.stringify(functionResult));
                console.log('MBEN 6:' + functionResult.Reference__c);



            switch(functionResult.Reference__c) {
              case 'REMMENS':
                // code block
                $A.util.toggleClass(component.find("rMontant"), "slds-hide");
                // rMontant, rNombremensu,rDebutexmois
                break;
              case 'REMMONTANNUAL':
                $A.util.toggleClass(component.find("rNombremensu"), "slds-hide");
                $A.util.toggleClass(component.find("rDebutexmois"), "slds-hide");
                break;
              case 'REMMONT':
                // code block
                break;
              case 'REMFRAISDOS':
                $A.util.toggleClass(component.find("rMontant"), "slds-hide");
                $A.util.toggleClass(component.find("rNombremensu"), "slds-hide");
                $A.util.toggleClass(component.find("rDebutexmois"), "slds-hide");
                break;
              case 'REMFRAISDOSRED':
                $A.util.toggleClass(component.find("rNombremensu"), "slds-hide");
                $A.util.toggleClass(component.find("rDebutexmois"), "slds-hide");
                    // slds-form-element
                break;
              default:
                $A.util.addClass(component.find("rMontant"), "slds-hide");
                $A.util.addClass(component.find("rNombremensu"), "slds-hide");
                $A.util.addClass(component.find("rDebutexmois"), "slds-hide");
            }
                /*if ((['REMFRAIDOS','REMMENS'].indexOf(functionResult.Reference__c) >= 0))
                {
                    var champ = component.find("rType");
                    $A.util.toggleClass(champ, "slds-hide");
                }*/
        	});
        $A.enqueueAction(action);
    },

    //TODO: corriger navBack: abandonne avec la mise en place du QA au lieu du Form (override standard action)
   navBack: function(){
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt .setParams({
            "recordId": "a1C0E0000026NQVUA2"
            //"recordId": component.get("v.recordId")
            // a1C0E0000026NQVUA2
        });
        navEvt.fire();
   }

})