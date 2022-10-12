({
	getIds: function (c, filters) {
        var h = this;
        h.request(c, 'getBrandOrderIds', { brandId: c.get('v.brandId'),filters: filters}, function (r) {
            console.log('getBrandOrderIds::',r);
            h.initPagination(c, r.ids, filters,'orderpaginator');
            c.set('v.allIds', r.ids);
        }, { storable: true });
    },
    getRecords: function (c, ids) {
        try{
        var h = this;
        h.request(c, 'getBrandRetailerOrders', { ids: ids,filters: c.get('v.filters') }, function (r) {
            window.setTimeout($A.getCallback(function(){
                var salesOrders = r.salesOrders;
                c.set('v.salesOrders', salesOrders);
            }),100)
        }, { storable: true });
        }catch(error){}
    },
})