({
	onInit : function(c, e, h) {
		var filters = { orderByField: 'Brand_Quote__r.Opportunity_Name__r.Order__r.Name', isASC: false };
        c.set('v.filters', filters);
        h.getIds(c, filters);	
	},
    onViewTicket: function (c, e, h) {
        var recordId = e.currentTarget.dataset.id;
        sessionStorage.setItem('retaildeliveryticketId', recordId);
        h.redirect('/viewbrandorder', true);
    },
    gotoDetails : function(c, e, h) {
        var SOId = e.currentTarget.id;
        console.log('SOId:',SOId);
        h.navigateToRecord(c,e.target.id, "detail");
    },
    fetchBrandOrders: function (c, e, h) {
        var ids = e.getParam('ids');
        h.getRecords(c, ids);
    },
    sortOrder: function (c, e, h) {
        var sortfield = e.currentTarget.dataset.field;
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