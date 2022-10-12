({
	getIds: function (c, filters) {
        var h = this;
        h.request(c, 'getBrandProductIds', { brandId: c.get('v.brandId'),filters: filters}, function (r) {
            h.initPagination(c, r.ids, filters,'productpaginator');
            c.set('v.allIds', r.ids);
            c.set('v.isLCExist', r.lcExist);
            console.log('r.lcExist = ',r.lcExist);
        }, { storable: true });
    },
    getRecords: function (c, ids) {
        try{
        var h = this;
        h.request(c, 'getBrandProducts', { ids: ids,filters: c.get('v.filters') }, function (r) {
            window.setTimeout($A.getCallback(function(){
                var products = r.products;
                console.log('getBrandProducts:',products);
                c.set('v.products', products);
            }),100)
        }, { storable: true });
        }catch(error){}
    },
})