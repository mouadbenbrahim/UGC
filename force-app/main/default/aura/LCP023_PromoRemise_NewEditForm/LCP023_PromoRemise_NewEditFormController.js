({
        doInit: function(component, event, helper) {

           helper.getPromoRemiseRTid(component);

        },

        handleSubmit: function(component, event, helper) {

            // Si on souhaite predefaulter des valeurs
            if ( component.get("v.operation") == 'nouveauRecord' ){
                event.preventDefault();       // stop the form from submitting
                var fields = event.getParam('fields');
                fields.Promo__c =  component.get("v.promoId");
                component.find('myForm').submit(fields);
            }

/*                    fields.DebuteXmois__c = 5;
            console.log("MBEN fields: " + JSON.stringify(event.getParams(fields)));
            console.log("MBEN change event handleSubmit: " + JSON.stringify(event.getParams()));
            helper.handleSubmit(component);*/

        },

        handleSuccess: function(component, event, helper) {
            // Quand le record est sauvegarder
            var updatedRecord = JSON.parse(JSON.stringify(event.getParams()));
            // console.log('onsuccess: ', updatedRecord.id);
            console.log('MBEN onsuccess: ', updatedRecord);
            $A.get("e.force:closeQuickAction").fire();
            $A.get('e.force:refreshView').fire();
            // helper.navBack();
        },

        handleOnload: function(component, event, helper){

            // helper.init(component);

            var bttnOperation = component.get("v.operation");
            if ( component.get("v.operation") == 'modifRecord' ){
                console.log("MBEN: modifrecord IF " +  bttnOperation);
                helper.showHide(component);
            }

            //console.log("MBEN: operation 2" +  bttnOperation);
            // Quand le bloc est chargé
            /*
            $A.util.addClass(component.find("rMontant"), "slds-hide");
            $A.util.addClass(component.find("rNombremensu"), "slds-hide");
            $A.util.addClass(component.find("rDebutexmois"), "slds-hide");
            */
            // if (component.get("v.operation") == helper.showHide(component);
        },

        handleChargeChange: function(component, event, helper){

            // Mise a vide des champs
            component.find("rMontant").set("v.value","");
            component.find("rNombremensu").set("v.value","");
            component.find("rDebutexmois").set("v.value","");


            // Afficher/Cacher des champs.
            var chargeLkp = component.find("chargeLkp").get("v.value");
            console.log("MBEN chargeLkp:" + chargeLkp + ":");
            if (chargeLkp != null && chargeLkp != "" ){
                helper.showHide(component);
            }


           //console.log("MBEN change event handleChargeChange: " + event.getSource().get("v.value")); // Id
           //console.log("MBEN change event handleChargeChange: " + event.getParam("value")); // Id
           //console.log("MBEN change event handleChargeChange: " + JSON.stringify(event.getParams())); // {"value":["a1F0E000000YdNUUA0"]}

           //component.set("v.charge",event.getParam("value").toString()); // OK
           // component.set("v.charge2.Id",event.getParam("value")); // KO
           //component.set("v.charge","a1F0E000000YX8oUAG");
           // component.set("",null);

            /*var rMontant = component.find("rMontant");
            rMontant.set("v.value","0");*/

            //console.log("MBEN: myForm" + component.find("myForm").fields);
            //component.find("myForm").set("v.value","");

           },

          handleCancel: function(component, event, helper){
               //helper.navBack();
               $A.get("e.force:closeQuickAction").fire();
          }

})