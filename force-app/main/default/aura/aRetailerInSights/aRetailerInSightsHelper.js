({
	getIds: function (c, filters) {
        
        var h = this;
        h.request(c, 'getretailerInsightIds', { retailerId: c.get('v.retailerId'),filters: filters}, function (r) {
            h.initPagination(c, r.ids, filters,'productpaginator');
            c.set('v.allIds', r.ids);
        }, { storable: true });
    },
    getRecords: function (c, ids) {
        try{
        var h = this;
        h.request(c, 'getretailerInsights', { ids: ids,filters: c.get('v.filters') }, function (r) {
            console.log('getretailerInsights:',r);
            window.setTimeout($A.getCallback(function(){
                var insights = r.insights;
                c.set('v.inSights', insights);
            }),100)
        }, { storable: true });
        }catch(error){}
    },
})