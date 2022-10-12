({
	doInit : function(c, e, h) {
        h.request(c, 'heatMapGenerator', {}, function(r){	
            c.set('v.sites',r.sites);
            c.set('v.locations',r.locations);
            console.log('JSON DATa = '+r.jsonData);
            h.setTableContent(c,r.jsonData);
        });
	},
    onSiteChange : function(c, e, h) {
    	let siteId = c.find("warehouse").get("v.value") ;
        h.request(c, 'getAllLocations', {siteId : siteId}, function(r){	
            c.set('v.locations',r.locations);
            h.setTableContent(c,r.jsonData);
        });
    },
    
    onLocationChange  : function(c, e, h) {
    	let locId = c.find("location").get("v.value") ;
        h.request(c, 'getProcessRackData', {locId : locId}, function(r){
        	h.setTableContent(c,r.jsonData);    
        });
    },
})