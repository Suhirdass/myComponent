({
	navigate : function(c, e, h) {
        var evt = $A.get("e.force:navigateToComponent");
        evt.setParams({
            componentDef : "c:AssignDriverToSalesOrder",
            componentAttributes: {
                salesId : c.get("v.recordId")
            }
        });
        evt.fire();
    }
})