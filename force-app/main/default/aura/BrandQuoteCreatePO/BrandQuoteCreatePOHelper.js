({
    BrandQuotecreatePO : function(c, e,h) {
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": "/apex/SplitPOByProducerName?id=" + c.get("v.recordId")
        });
        urlEvent.fire();
    },
    getData : function(component, event) {
        var action = component.get("c.getRecordName");
        action.setParams({ recordId : component.get("v.recordId") });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.recordName", response.getReturnValue());
                
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                    }
                } else {
                }
            }
        });
        $A.enqueueAction(action);
    }
})