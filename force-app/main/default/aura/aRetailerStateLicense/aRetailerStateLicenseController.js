({
	onInit : function(c, e, h) {
		var filters = { orderByField: 'License_Address__c', isASC: false };
        c.set('v.filters', filters);
        h.getIds(c, filters);	
	},
    fetchBrandLicense: function (c, e, h) {
        var ids = e.getParam('ids');
        h.getRecords(c, ids);
    },
    onLicenseClick: function (c, e, h) {
        var dataset = e.currentTarget.dataset;
        h.navigateToRecord(c,dataset.id, "detail");
    },
    sortLicense: function (c, e, h) {
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