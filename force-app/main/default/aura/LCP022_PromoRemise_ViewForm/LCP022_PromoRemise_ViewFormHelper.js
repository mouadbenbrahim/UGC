({

    showHide: function(component){

        $A.util.removeClass(component.find("rMontant"), "slds-hide");
        $A.util.removeClass(component.find("rNombremensu"), "slds-hide");
        $A.util.removeClass(component.find("rDebutexmois"), "slds-hide");


           //var chargeId = component.find("chargeLkp").get("v.value");
           var promoRemiseId = component.get("v.recordId");
            var action = component.get("c.getCharge");
            // var chargeId = component.get("v.charge");
            console.log('MBEN promoRemiseId: ' + promoRemiseId);
            action.setParams({
            	// chargeId : 'a1F0E000000YX8oUAG'
            	promoRemiseId : promoRemiseId
            	})

            action.setCallback(this, function(response, component) {
            var functionResult = response.getReturnValue();
            	    //$A.get("e.force:closeQuickAction").fire();
                    console.log('MBEN 5:' + JSON.stringify(functionResult));
                    console.log('MBEN 6:' + functionResult["Charge__r"].Reference__c);
                    console.log('MBEN 7:' + functionResult.Charge__r.Reference__c);
                    var reference = functionResult.Charge__r.Reference__c
                    console.log ("MBEN 9 reference: " + reference);


                  switch(reference) {
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
                      console.log ("MBEN 10 REMFRAISDOS: " + reference);
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


            });
            $A.enqueueAction(action);

    }



})