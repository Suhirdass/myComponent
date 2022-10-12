({
	doInit : function(component, event, helper) {
        console.log("doInit");
		console.log(component.get("v.recordId"));
        helper.getData(component, event);
	},
    cancelPO : function(component, event, helper) {
		helper.cancelPurchaseOrder(component, event);
	},
    cancel : function(component, event, helper) {
		$A.get("e.force:closeQuickAction").fire();
	}
})