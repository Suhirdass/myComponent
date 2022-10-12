({
	bqDetail : function(c, e, h) {
        var evt = $A.get("e.force:navigateToComponent");
        evt.setParams({
            componentDef : "c:CreateBuyQuote",
            componentAttributes: {
                recordId : c.get("v.recordId")
            }
        });
        evt.fire();
    }
})