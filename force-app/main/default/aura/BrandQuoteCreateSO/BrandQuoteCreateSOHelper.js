({
	createSalesOrder : function(component, event) {
		console.log('In createSalesOrder');
        console.log(component.get("v.recordId"));
        
        let status = component.get("v.recordStatus");
        if(status != 'Approved'){
            component.set('v.isCancelled',true);
            component.set('v.error', component.get("v.recordName") + ' in '+status+' status. '+'Please submit '+component.get("v.recordName")+' for review/approval.');
        } else {
            let urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
                "url": "/apex/CreateSO?id=" + component.get("v.recordId")
                
            });
            urlEvent.fire();
        }
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