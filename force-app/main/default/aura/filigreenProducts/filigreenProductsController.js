({
    onInit: function (c, e, h) {
        var searchTerm = '';
        if (sessionStorage.getItem('initSearch')) {
            sessionStorage.removeItem('initSearch');
            searchTerm = sessionStorage.getItem('searchTerm');
        }
        console.log("category::",sessionStorage.getItem('category'));
        var filters = { orderByField: 'Product2.Name', isASC: true, searchTerm: searchTerm,includeOutStock:c.get('v.includeOutStock') };
        c.set('v.selectedFilter', 'Product2.Name ASC');
        
        var category = sessionStorage.getItem('category');
        var categoryName = sessionStorage.getItem('categoryName');
        if(category){
            sessionStorage.removeItem('category');
            sessionStorage.setItem('categoryName','All');
            filters.families = category;
        }
        console.log("filters::",filters);
        c.set('v.filters', filters);
        h.getIds(c, filters);
        h.getCategories(c);
    },
    onScriptsLoaded: function (c, e, h) {
        h.initScroller(c);
    },
    onIncludeOutOfStock:function (c, e, h) {
        var filters = c.get('v.filters');
        filters['includeOutStock'] = c.get('v.includeOutStock');
        c.set('v.filters', filters);
        h.getIds(c, filters);
    },
    handleSearch: function (c, e, h) {
        var searchTerm = e.getParam('searchTerm');
        
        var filters = c.get('v.filters');
        filters['searchTerm'] = searchTerm;
        c.set('v.filters', filters);
        h.getIds(c, filters);
    },
    onOrderChange: function (c, e, h) {
        var selectedFilter = e.getParam('value');
        var fieldAndOrder = selectedFilter.split(' ');
        var filters = c.get('v.filters');
        filters.orderByField = fieldAndOrder[0];
        filters.isASC = (fieldAndOrder[1] === 'ASC');
        c.set('v.selectedFilter', selectedFilter);
        h.getIds(c, filters);
    },
    fetchProducts: function (c, e, h) {
        var ids = e.getParam('ids');
        h.getProducts(c, ids);
    },
    onSearchFiltersChange: function (c, e, h) {
        var filters = c.get('v.filters');
        filters.searchTerm = e.getParam('searchTerm');
        h.getIds(c, filters);
    },
    toggleFilter: function (c, e, h) {
        c.set('v.hasFilter', !c.get('v.hasFilter'));
    },
    setGrid: function (c, e, h) {
        c.set('v.isList', false);
    },
    setList: function (c, e, h) {
        c.set('v.isList', true);
    },
    onCategoryClick: function (c, e, h) {
        console.log("Categories:", e.srcElement.dataset.category);
        var category = e.srcElement.dataset.category;
        var categoryName = e.srcElement.dataset.categoryName;
        console.log("categoryName:",categoryName);
        c.set('v.selectedCategory',categoryName);
        sessionStorage.setItem('category',category);
        sessionStorage.setItem('categoryName',categoryName);
        var filters = c.get('v.filters');
        filters.families = category;
        h.getIds(c, filters);
    },
    applyFilters: function (c, e, h) {
        var selectedFamilies = e.getParam('value');
        var filters = c.get('v.filters');
        filters.families = selectedFamilies.join(',');
        h.getIds(c, filters);
    },
    scrollToTop: function (c, e, h) {
        h.scrollToTop(c);
    }
})