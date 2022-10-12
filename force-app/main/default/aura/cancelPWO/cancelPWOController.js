({
	doInit : function(component, event, helper) {
		var action = component.get("c.getPWO");
        action.setParams({ PWOId : component.get("v.recordId") });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log("From server: " + response.getReturnValue());
				component.set("v.recordName", response.getReturnValue());
                component.set("v.isDataLoaded",true);
            }
        });
        $A.enqueueAction(action);
	},
    onScriptsLoaded : function(component, event, helper) {
        helper.showPopup(component);
        
	},
    cancel : function(component, event, helper) {
		$A.get("e.force:closeQuickAction").fire();
	}
})