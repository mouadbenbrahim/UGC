({

        init: function(component){
        var promoId = component.get("v.rec.fields.Id.value");
        var promoRT = component.get("v.rec.recordTypeInfo.name");

        var action = component.get("c.initApexMethod");
        action.setParams({
            promoRT : promoRT
        })
            action.setCallback(this, function(response, component) {
            var functionResult = response.getReturnValue();
            $A.get("e.force:closeQuickAction").fire();

            var createRecordEvent = $A.get("e.force:createRecord");
                createRecordEvent.setParams({
                "entityApiName": "PromoRemise__c",
                "recordTypeId": functionResult,
                "defaultFieldValues": {
                "Promo__c" : promoId
                }
                });
                createRecordEvent.fire();



        });
        $A.enqueueAction(action);

    }

})