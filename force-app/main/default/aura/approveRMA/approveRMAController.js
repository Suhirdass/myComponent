({
	doInit : function(c, e, h) {
        console.log("doInit:",c.get('v.recordId'));
        h.request(c, 'getRMADetails', { recordId: c.get('v.recordId') }, function (r) {
            console.log("getRMADetails:",r);
            c.set('v.recordName', r.RMA.name);
            c.set("v.isDataLoaded",true);
        });
	},
    onScriptsLoaded : function(c, e, h) {
        h.showPopup(c);
        
	},
    cancel : function(c, e, h) {
		$A.get("e.force:closeQuickAction").fire();
	}
})