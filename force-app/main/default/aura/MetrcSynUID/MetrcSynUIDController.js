({
	synConfirm : function(component, event, helper) {
        helper.synUidData(component, event, helper);
		
	},
    cancel : function(component, event, helper) {
		$A.get("e.force:closeQuickAction").fire();
	},
})