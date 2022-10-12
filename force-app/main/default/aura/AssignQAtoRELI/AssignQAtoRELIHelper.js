({
	getRecords: function(c,h){
		h.request(c, 'getPOandRELIsDeatils', {poId: c.get('v.recordId')}, function(r){ 
            c.set('v.poData', r.poData);
            c.set('v.ReceivingLines',r.receivingLines);
        });
        
	}
})