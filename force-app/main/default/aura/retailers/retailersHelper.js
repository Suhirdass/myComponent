({
    inProgress: null,
    getIds: function(c, filters) {
        var h = this;
        h.request(c, 'getRetailerIds', {filters: filters}, function(r){
            console.log("getRetailerIds::",r);
            //h.reset(c);
            c.set('v.ids', r.ids);
            c.set('v.contactRTId',r.contactRTId);
            h.initPagination(c, r.ids, filters);
            //h.fetchPage(c);
        }, {storable: false});
    },
    getRecords: function(c, ids) {
        var selectedFilter = c.get('v.selectedFilter');
        var h = this;
        h.request(c, 'getRetailers', {ids: ids, filters: c.get('v.filters')}, function(r){
            c.set('v.isBrand', r.isBrand);
            var records = c.get('v.records');
            console.log("r.records::",r.records);
            //for(var i=0;i<r.records.length;i++){
                //console.log("Retailer::",r.records[i].isValid);
                //if(r.records[i].isValid == true){
                    //records.push(r.records[i]);
                //}
            //}
            //records = records.concat(r.records);
            c.set('v.records', r.records);
        }, {storable: false});
    },
    
})