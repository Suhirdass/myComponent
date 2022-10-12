({
	onInit : function(c, e, h) {
		var filters = { orderByField: 'Brand_Quote__r.Opportunity_Name__r.Order__r.Name', isASC: false };
        c.set('v.filters', filters);
        h.getIds(c, filters);	
	},
    fetchBrandOrders: function (c, e, h) {
        var ids = e.getParam('ids');
        h.getRecords(c, ids);
    },
    onRecordClick: function (c, e, h) {
        var dataset = e.currentTarget.dataset;
        h.navigateToRecord(c,dataset.id, "detail");
    },
    onOrderClick: function (c, e, h) {
        var recordId = e.currentTarget.dataset.id;
        sessionStorage.setItem('retaildeliveryticketId', recordId);
        h.redirect('/viewbrandorder', true);
    },
    sortOrder: function (c, e, h) {
        
        var sortfield = e.currentTarget.dataset.field;
        console.log('---enter---'+sortfield);
        var filters = c.get('v.filters');
        if (filters.orderByField.toLowerCase() === sortfield.toLowerCase()) {
            filters["orderByField"] =  sortfield;
            filters["isASC"] =  (!filters.isASC);
        } else {
            filters["orderByField"] =  sortfield;
            filters["isASC"] =  true;
        }
        c.set('v.filters', filters);
        h.getIds(c, filters); 
    }
})