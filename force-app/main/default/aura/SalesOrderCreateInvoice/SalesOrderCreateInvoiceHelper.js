({
	newSalesOrder : function(c, e,h) {
		console.log('In newSalesOrder');
        console.log(c.get("v.recordId"));
        var action = c.get("c.createARLighting");
       action.setParams({ soId : c.get("v.recordId") });
        action.setCallback(this, function(r) {
            
            var Data = r.getReturnValue();
            console.log('Error : ',Data.data);
            if(Data.data.error != null || Data.data.error != undefined){
                var toastEvent = $A.get("e.force:showToast");
                                    toastEvent.setParams({
                                        title : 'Error',
                                        message:Data.data.error,
                                        duration:' 5000',
                                        key: 'info_alt',
                                        type: 'Error',
                                        mode: 'pester'
                                    });
                                    toastEvent.fire(); 
                $A.get("e.force:closeQuickAction").fire();
            }
            if(Data.data.newInvocieId != null || Data.data.newInvocieId != undefined){
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url": "/" + Data.data.newInvocieId,
                    redirect:true
                    
                });
                urlEvent.fire();
            }
            
        });
        $A.enqueueAction(action);
        /*var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": "/apex/CreateInvFromSO?id=" + component.get("v.recordId"),
            redirect:true
            
        });
        urlEvent.fire();*/
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