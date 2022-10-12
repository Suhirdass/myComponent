({
	onInit: function (c, e, h) {
        c.set('v.perPage',10);
        console.log("Brands onInit");
        var searchTerm = '';
        var filters = { orderByField: 'DBA__c', isASC: true, searchTerm: searchTerm, brandType:'All' };
        c.set('v.filters', filters);
        h.getIds(c, filters);
        //h.getTopHeight(c);
    },
    onScriptsLoaded: function (c, e, h) {
        //h.initScroller(c);
    },
    changeBrands: function (c, e, h) {
        var selectedType = e.getSource().get("v.label");
        c.set('v.selectedType',selectedType);
        var filters = c.get('v.filters');
        filters['brandType'] = selectedType;
        c.set('v.filters', filters);
        h.getIds(c, c.get('v.filters'));        
    },
    handleSearch: function (c, e, h) {
        var searchRec = c.find('searchRec');
        var searchTerm = searchRec.getElement().value;
       	var filters = c.get('v.filters');
        filters['searchTerm'] = searchTerm;
        c.set('v.filters', filters);
        h.getIds(c, c.get('v.filters'));
    },
    onOrderChange: function (c, e, h) {
        var fieldAndOrder = (e.getSource().get('v.value')).split(' ');
        var filters = c.get('v.filters');
        filters.orderByField = fieldAndOrder[0];
        filters.isASC = (fieldAndOrder[1] === 'ASC');
        h.getIds(c, filters);
    },
    fetchBrands: function (c, e, h) {
        var ids = e.getParam('ids');
        h.getRecords(c, ids);
    },
    onSearchFiltersChange: function (c, e, h) {
        var filters = c.get('v.filters');
        filters.searchTerm = e.getParam('searchTerm');
        h.getIds(c, filters);
    },
    handleKeyUp: function (c, e,h) {
        try{
            window.clearTimeout(h.inProgress);
        }catch(err){}
        
        h.inProgress = window.setTimeout($A.getCallback(function(){
            /*var searchTerm = c.find('retailerSearch').get('v.value');
            console.log('Searched for "' + searchTerm + '"!');*/
            var filters = { orderByField: 'DBA__c', isASC: true, searchTerm: c.get('v.searchTerm') };
            c.set('v.filters', filters);
            h.getIds(c, filters);
        }), 750);
    },
  scrollToTop: function (c, e, h) {
    h.scrollToTop(c);
  }
})