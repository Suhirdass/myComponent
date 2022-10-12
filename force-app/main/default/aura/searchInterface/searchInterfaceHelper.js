({
    inProgress: null,
    globalSearch: '/globalsearch?searchTerm=',
    onSearch: function (c) {
        var h = this;
        var searchTerm = c.get('v.searchTerm');
        sessionStorage.setItem('globalSearchTerm',searchTerm);
        if(searchTerm != ''){
            $A.get('e.force:navigateToURL').setParams({
                url: h.globalSearch+searchTerm,
                isredirect: true
            }).fire();
        }
        /*sessionStorage.setItem('initSearch', 1);
        sessionStorage.setItem('searchTerm', c.get('v.searchTerm'));
        var currentPage = '';
        if ( window.location.href.indexOf('/s/retailers') === -1 && window.location.href.indexOf('/s/brands') === -1 && window.location.href.indexOf('/s/products') === -1) {
          currentPage = 'products';
        } else if (window.location.href.indexOf('/s/retailers') !== -1 || window.location.href.indexOf('/s/brands') !== -1 || window.location.href.indexOf('/s/products') !== -1) {
          $A.get('e.c:searchFiltersEvt').setParams({ searchTerm: c.get('v.searchTerm') }).fire();
        }
    
        if (currentPage) {
          h.redirect('/products', true);
        }*/
  }
})