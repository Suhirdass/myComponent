({
	doInit : function(c, e, h) {
        h.request(c,'syncTotalMiles', {recordId: c.get("v.recordId")}, function(r){
        	h.navigateToRecord(c, c.get('v.recordId'));    
        })
	}
})