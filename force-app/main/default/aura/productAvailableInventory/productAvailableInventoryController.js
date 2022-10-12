({
	onInit : function(c, e, h) {
		c.set('v.perPage',10);
        var filters = { orderByField: 'Name', isASC: false };
        c.set('v.filters', filters);
        h.getIds(c, filters);
	},
    fetchAvailableInventory: function (c, e, h) {
        var ids = e.getParam('ids');
        h.getRecords(c, ids);
    },
    onSortInventory: function (c, e, h) {
        var dataset = e.currentTarget.dataset;
        var sortfield = dataset.sortfield;        
        var filters = c.get('v.filters');
        filters["orderByField"] =  sortfield;
        if (filters.orderByField.toLowerCase() === sortfield.toLowerCase()) {            
            filters["isASC"] =  (!filters.isASC);
        } else {
            filters["isASC"] =  true;
        }
        c.set('v.filters', filters);
        h.getIds(c, filters);
    }
})