({
	getIds: function (c, filters) {
        var h = this;
        h.request(c, 'getBrandContactIds', { brandId: c.get('v.retailerId'),filters: filters}, function (r) {
            h.initPagination(c, r.ids, filters,'contactpaginator');
            c.set('v.allIds', r.ids);
        }, { storable: true });
    },
    getRecords: function (c, ids) {
        try{
        var h = this;
        h.request(c, 'getBrandContacts', { ids: ids,filters: c.get('v.filters') }, function (r) {
            window.setTimeout($A.getCallback(function(){
                var brandContacts = r.brandContacts;
                c.set('v.retailerContacts', brandContacts);
            }),100)
        }, { storable: true });
        }catch(error){}
    },
})