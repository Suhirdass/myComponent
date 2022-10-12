({
    backToTopRef: null,
    reset:function(c){
        var h = this;
        c.set('v.currentPage',0);
        c.set('v.records',[]);
        //c.set('v.ids',[]);
        h.initScroller(c);
        h.scrollToTop(c);
    },
    initScroller: function (c, container) {
        console.log('initScroller...');
        var h = this;
        
        try {
            var infiniteLoading = c.find(container || 'psContainer');
            var el = infiniteLoading.getElement();
            window.setTimeout(
                $A.getCallback(function() {
                    var ps = new PerfectScrollbar(el, {
                        wheelSpeed: 2,
                        wheelPropagation: true
                    });
                }),1000);
            el.addEventListener('ps-y-reach-end', $A.getCallback(function () {
                h.fetchPage(c);
            }));
            
            el.addEventListener('ps-scroll-up', $A.getCallback(function () {
                h.toggleBackToTop(c, ps, true);
            }));
            el.addEventListener('ps-scroll-down', $A.getCallback(function () {
                
                h.toggleBackToTop(c, ps, false);
            }));
        } catch (e) {
            console.log(e.message);
        }
        h.getTopHeight(c, container);
    },
    toggleBackToTop: function (c, ps, isUp) {
        console.log('toggleBackToTop...',isUp);
        var h = this;
        try {
            window.clearTimeout(h.backToTopRef);
        } catch (err) { }
        
        h.backToTopRef = window.setTimeout($A.getCallback(function () {
            console.log("ps.lastScrollTop::",ps.lastScrollTop);
            if (isUp && ps.containerHeight > ps.lastScrollTop) {
                c.set('v.showScrollToTop', false);
            } else if (ps.lastScrollTop > 0) {
                c.set('v.showScrollToTop', true);
            }
        }), 100);
    },
    getTopHeight: function (c, container) {
        window.setTimeout($A.getCallback(function () {
            try {
                var infiniteLoading = c.find(container || 'psContainer');
                var bounds = infiniteLoading.getElement().getBoundingClientRect();
                c.set('v.topHeight', (bounds.top + 'px'));
            } catch (e) { }
        }), 250);
    },
    fetchPage: function (c) {
        var h = this;
        var currentPage = c.get('v.currentPage');
        c.set('v.currentPage', ++currentPage);
        
        var perPage = c.get('v.perPage');
        console.log("perPage::",perPage,"->currentPage::",currentPage);
        var ids = c.get('v.ids');
        console.log('ids length:',ids.length);
        console.log('ids='+ids)
        var startIndex = ((currentPage - 1) * perPage);
        var endIndex = (currentPage * perPage);
        console.log('startIndex:',startIndex,'->:',endIndex);
        var pageIds = ids.slice(startIndex, endIndex);
        console.log('pageIds:',pageIds);
        if (pageIds.length > 0) {
            h.getRecords(c, pageIds);
        }
    },
    scrollToTop: function (c, container) {
        try {
            var infiniteLoading = c.find(container || 'psContainer');
            infiniteLoading.getElement().scrollTop = 0;
            c.set('v.showScrollToTop', false);
        } catch (err) { }
    },
    fetchPageForFile: function (c) {
      //debugger;
      var h = this;
      var ids = c.get('v.allIds');
        console.log('fetchPageForFile - > ids::',ids);
      if (ids.length > 0) {
          h.getRecordsForFile(c, ids);
      }
  } 
})