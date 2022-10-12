({
	inProgress: null,
    getIds: function(c, filters) {
        var h = this;
        h.request(c, 'getBrandIds', {filters: filters}, function(r){
            //h.reset(c);
            c.set('v.ids', r.ids);
            h.initPagination(c, r.ids, filters);
            //h.fetchPage(c);
        }, {storable: true});
    },
    getRecords: function(c, ids) {
        var h = this;
        h.request(c, 'getBrands', {ids: ids, filters: c.get('v.filters')}, function(r){
            c.set('v.isBrand', r.isBrand);
            var records = c.get('v.records');
            //records = records.concat(r.records);
            c.set('v.records', r.records);
            console.log('r.records',r.records);
        }, {storable: true});
        
    },
    /*fetchPage: function (c) {
        var h = this;
        var currentPage = c.get('v.currentPage');
        c.set('v.currentPage', ++currentPage);
        
        var perPage = c.get('v.perPage');
        var ids = c.get('v.ids');
        
        var startIndex = ((currentPage - 1) * perPage);
        var endIndex = (currentPage * perPage);
        var pageIds = ids.slice(startIndex, endIndex);
        h.getBrandsDetails(c, pageIds);
    },
    getTopHeight: function (c) {
        window.setTimeout($A.getCallback(function () {
            try {
                var brandsInfiniteLoading = c.find('brandsInfiniteLoading');
                var bounds = brandsInfiniteLoading.getElement().getBoundingClientRect();
                c.set('v.topHeight', (bounds.top + 'px'));
            } catch (e) { }
        }), 250);
    },
    initScroller: function (c) {
        var h = this;
        
        try {
            var retailersInfiniteLoading = c.find('brandsInfiniteLoading');
            var el = retailersInfiniteLoading.getElement();
            console.log("el",el);
            var ps = new PerfectScrollbar(el, {
                wheelSpeed: 2,
                wheelPropagation: true
            });
            
            el.addEventListener('ps-y-reach-end', $A.getCallback(function () {
                h.fetchPage(c);
            }));
            el.addEventListener('ps-scroll-down', $A.getCallback(function () {
                console.log('scroll-down');
                if (ps.containerHeight < ps.lastScrollTop) {
                    c.set('v.showScrollToTop', true);
                }
            }));
        } catch (e) {
            console.log(e.message)
        }
    }*/
})