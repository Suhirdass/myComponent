({
	cancel : function(component, event, helper) {
		$A.get("e.force:closeQuickAction").fire();
	},
    pickConfirm : function(component, event) {
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": "/apex/PickConfirm?id=" + component.get("v.recordId")
            
        });
        urlEvent.fire();
	},
})