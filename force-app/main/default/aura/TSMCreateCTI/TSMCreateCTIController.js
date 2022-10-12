({
	doInit : function(component, event, helper) {
        console.log("doInit");
		console.log(component.get("v.recordId"));
        helper.getData(component, event);
	},
    createCTI : function(component, event, helper) {
		helper.TSMCreateCTI(component, event);
	},
    cancel : function(component, event, helper) {
		$A.get("e.force:closeQuickAction").fire();
	}
})