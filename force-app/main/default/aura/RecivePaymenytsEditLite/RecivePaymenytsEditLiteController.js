({
	navigateEdit : function(c, e, h) {
        var evt = $A.get("e.force:navigateToComponent");
        evt.setParams({
            componentDef :"c:RecivePaymentsEdits",
            componentAttributes: {
                recordId : c.get("v.recordId")
            }
        });
        evt.fire();
    }
})