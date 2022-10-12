({
	cancelPurchaseOrder : function(component, event) {
		console.log('In cancelSalesOrder');
        console.log(component.get("v.recordId"));
        var action = component.get("c.cancelPurchaseOrder");
        action.setParams({ recordId : component.get("v.recordId") });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log("From server: " + response.getReturnValue());
                if(response.getReturnValue()){
                    
                    $A.get("e.force:closeQuickAction").fire();
                    // Option 1
                    $A.get('e.force:refreshView').fire();
                    // Option 2
                    var urlEvent = $A.get("e.force:navigateToURL");
                    urlEvent.setParams({
                        "url": "/" + component.get("v.recordId")
                        
                    });
                    urlEvent.fire();
                    
                }else{
                    alert('Error - you cannot cancel the PO as related PO lines are having received qty !');
                    $A.get("e.force:closeQuickAction").fire();
                }
                
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                    errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
	},
    getData : function(component, event) {
        var action = component.get("c.getRecordName");
        action.setParams({ recordId : component.get("v.recordId") });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log("From server: " + response.getReturnValue());
				component.set("v.recordName", response.getReturnValue());
                
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    }
})