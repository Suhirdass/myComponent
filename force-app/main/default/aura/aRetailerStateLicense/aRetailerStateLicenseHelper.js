({
	getIds: function (c, filters) {
        var h = this;
        h.request(c, 'getBrandLicenseIds', { brandId: c.get('v.retailerId'),filters: filters}, function (r) {
            h.initPagination(c, r.ids, filters,'licensespaginator');
            c.set('v.allIds', r.ids);
        }, { storable: true });
    },
    getRecords: function (c, ids) {
        try{
        var h = this;
        h.request(c, 'getBrandLicense', { ids: ids,filters: c.get('v.filters') }, function (r) {
            window.setTimeout($A.getCallback(function(){
                var stateLicenses = r.stateLicenses;
                c.set('v.stateLicenses', stateLicenses);
            }),100)
        }, { storable: true });
        }catch(error){}
    },
})