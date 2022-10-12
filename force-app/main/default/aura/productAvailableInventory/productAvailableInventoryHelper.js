({
	getIds: function (c, filters) {
        var h = this;
        h.request(c, 'getAvailableInventoryIds', { filters: filters,productId: c.get('v.productId')}, function (r) {
            c.set('v.ids', r.ids);
            h.initPagination(c, r.ids, filters);
        }, { storable: true });
    },
    getRecords: function (c, ids) {
        try{
        	var h = this;
        	h.request(c, 'getAvailableInventory', { ids: ids, filters: c.get('v.filters') }, function (r) {
            	var records = r.availableInventoryList;
            	c.set('v.availableInventoryList', records);
        	}, { storable: true });
        }catch(error){}
    }
})