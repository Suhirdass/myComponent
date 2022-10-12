({
	cancel : function(component, event, helper) {
		$A.get("e.force:closeQuickAction").fire();
	},
    qaConfirm : function(component, event) {
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": "/apex/QAConfirm?id=" + component.get("v.recordId")
            
        });
        urlEvent.fire();
	},
})