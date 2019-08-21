({
    init: function(component){
        var couponId = component.get("v.rec.fields.Id.value");
        var recordType = component.get("v.rec.recordTypeInfo.name");
        var record = component.get("v.rec");
        //var couponId2 = component.get("v.myId");

        console.log("MBEN: " + JSON.stringify(record));
        console.log("MBEN: " + recordType);
        var action = component.get("c.initApexMethod");
        action.setCallback(this, function(response, component) {
            //fctResult = response.getReturnValue();
            //state = response.getState();
            $A.get("e.force:closeQuickAction").fire();

            var createRecordEvent = $A.get("e.force:createRecord");
                createRecordEvent.setParams({
                "entityApiName": "CouponItem__c",
            //TODO recordTypeId a remplacer pour que ca soit dynamique par environnement
                "recordTypeId": "0120E000000dnbAQAQ",
                "defaultFieldValues": {
                "Utilise__c" : true,
                "Coupon__c" : couponId,
                }
            });
            createRecordEvent.fire();

        }
        );
        $A.enqueueAction(action);
    }
})