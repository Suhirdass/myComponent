({
	navigate : function(c, e, h) {
        var evt = $A.get("e.force:navigateToComponent");
        evt.setParams({
            componentDef : "c:ConvertServiceTickets",
            componentAttributes: {
                recordId : c.get("v.recordId")
            }
        });
        evt.fire();
    }
})