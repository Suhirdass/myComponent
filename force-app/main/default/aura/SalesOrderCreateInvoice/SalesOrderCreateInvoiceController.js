({
	doInit : function(component, event, helper) {
        console.log("doInit");
		console.log(component.get("v.recordId"));
        helper.getData(component, event);
        //helper.newSalesOrder(component, event);
	},
    new : function(component, event, helper) {
		helper.newSalesOrder(component, event);
	},
    cancel : function(component, event, helper) {
		$A.get("e.force:closeQuickAction").fire();
	}
})