({
	doInit : function(c, event, h) {
        c.set('v.searchString','');
        h.request(c, 'getRecords', {}, function(r){
            console.log('getRecords:',JSON.stringify(r));
            
            c.set('v.records',r.records);
        }); 
    },
})