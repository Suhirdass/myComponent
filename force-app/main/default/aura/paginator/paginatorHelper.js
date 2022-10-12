({
  fetchPage: function (c, pageNo) {
    c.set('v.currentPage', pageNo);

    var perPage = c.get('v.perPage');
    var ids = c.get('v.ids');

    var startIndex = ((pageNo - 1) * perPage);
    var endIndex = (pageNo * perPage);
    var pageIds = ids.slice(startIndex, endIndex);
      console.log('fetchPage :',pageIds);
    c.getEvent('paginatorChangeEvt').setParams({ ids: pageIds }).fire();
  },
    calculatePages: function (c, targetPageNo) {
        var h = this;
        var perPage = c.get('v.perPage');
        var ids = c.get('v.ids');
        var totalPages = (Math.ceil(ids.length / perPage) || 1);
        c.set('v.totalPages', totalPages);
        
        var displayPages = c.get('v.displayPages');
        var reqdPageNo = --targetPageNo;
        var startPageNumber = (reqdPageNo - (targetPageNo % displayPages) + 1) || 1;
        
        console.log('targetPageNo: '+ targetPageNo +' startPageNumber ' + startPageNumber );
        
        var strtRec = targetPageNo * perPage + 1;
        var endRec = parseInt(targetPageNo * perPage + +perPage,10);
        
        console.log('strtRec: '+ strtRec +' endRec ' + endRec );
        
        if(endRec > ids.length){
            endRec -= (endRec - ids.length);
        }
        
        let recordsCount = strtRec + " to " + endRec+" ";
        c.set('v.recordsCount',recordsCount);
        
        
        
        var endPageNumber = startPageNumber + displayPages - 1;
        endPageNumber = Math.min(endPageNumber, totalPages);
        var pageNumbers = [];
        for (var i = startPageNumber; i <= endPageNumber; i++) {
            pageNumbers.push(i);
        }
        c.set('v.pageNumbers', pageNumbers);
        h.fetchPage(c, 1);
    }
})