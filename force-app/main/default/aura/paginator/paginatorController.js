({
  onInit: function (c, e, h) {

  },
  setIds: function (c, e, h) {
    var params = e.getParam('arguments');
    c.set('v.noData', 'No Product Found.');
    c.set('v.ids', params.ids);
    h.calculatePages(c, 1);
  },
  onPerPageChange: function (c, e, h) {
    h.calculatePages(c, 1);
  },
  onPreviousPage: function (c, e, h) {
    var currentPage = c.get('v.currentPage');
    h.calculatePages(c, (currentPage - 1));
    h.fetchPage(c, (currentPage - 1));
  },
  onPageChange: function (c, e, h) {
    var pageNo = parseInt(e.getSource().get('v.value'), 10);
    if (pageNo !== c.get('v.currentPage')) {
      h.calculatePages(c, pageNo);
      h.fetchPage(c, pageNo);
    }
  },
  onNextPage: function (c, e, h) {
    var currentPage = c.get('v.currentPage');
    h.calculatePages(c, (currentPage + 1));
    h.fetchPage(c, (currentPage + 1));
  }
})