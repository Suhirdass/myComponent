({
	navigate : function(c, e, h) {
        
        h.request(c, 'getStatus', { picklistId: c.get("v.recordId") }, function (r) {
            if(r.pickListStatus == 'QA Confirm' || r.pickListStatus == 'Confirmed' || r.pickListStatus == 'Cancelled' ||
              r.pickListStatus == 'Rejected'){
            	//h.error({ message: r.pickListName+' has been '+r.pickListStatus }); 
            	h.error({ message: 'Assign Pack-out UID is allowed only if Picklist status is "Open or "QA Review"' }); 
                $A.get("e.force:closeQuickAction").fire();
            } else {
                var evt = $A.get("e.force:navigateToComponent");
                evt.setParams({
                    componentDef : "c:assignPackoutUID",
                    componentAttributes: {
                        recordId : c.get("v.recordId")
                    }
                });
                evt.fire();    
            }    
        });
    }
})