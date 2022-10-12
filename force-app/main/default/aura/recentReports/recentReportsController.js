({
	onInit: function (c, e, h) {
       try{
            var searchTerm = '';
            var filters = { orderByField: 'Name', isASC: true, searchTerm: searchTerm };
            c.set('v.filters', filters);
            h.getIds(c, filters);
        }catch(er){
            console.log('Error:',er);
        }
    },
    validateKeys: function (c, e, h) {
        if(e.keyCode == 13){
            e.preventDefault();
			return false;
        }
    },
    onSearchReports: function (c, e, h) {
        var searchInput = c.find('searchInput');
        var searchTerm = searchInput.getElement().value;
        window.setTimeout($A.getCallback(function(){
            /*if(searchTerm != ''){
                $A.util.addClass(searchInput, 'searchFullWidth');
            }else{
                $A.util.removeClass(searchInput, 'searchFullWidth');
            }*/
            var filters = c.get('v.filters');
            filters['searchTerm'] = searchTerm;
            c.set('v.filters', filters);
            h.getIds(c, filters);    
        }),100);
        //h.calculatePages(c, 1);
    },
    handleSearch: function (c, e, h) {
        var searchTerm = e.getParam('searchTerm');
        var filters = { searchTerm: searchTerm };
        
        h.getIds(c, filters);
    },
    fetchReports: function (c, e, h) {
        var ids = e.getParam('ids');
        h.getRecords(c, ids);
    },
    onGotoReport: function(c,e,h){
        var brd = sessionStorage.getItem('breadCrumb');
        var name = e.target.dataset.name;
        var reportId = e.target.id;
        if(brd){
            brd = JSON.parse(brd);
            brd.breadCrumbString += ' > '+name;
            brd.breadCrumbIds+=' > ';
            sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}));
            $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}).fire();
        }
        h.navigateToRecord(c,reportId, "detail");
    },
    onPrintSelect: function (c, e, h) {
        var selectedFormat = e.getSource().get("v.value");
        console.log('selectedFormat:',selectedFormat);
        if(selectedFormat == 'csv'){
           h.fetchPageForFile(c);
        }else if(selectedFormat == 'pdf'){
            var currentUrl = window.location.href;
            currentUrl = currentUrl.replace('/s/recentreports','/apex/printReportPdf?recentReport=true&filters='+JSON.stringify(c.get('v.filters')));
            console.log('currentUrl::',currentUrl);
            window.open(currentUrl,'_blank');
        }
    },
    onSortOrders: function (c, e, h) {
        try{
            var dataset = e.currentTarget.dataset;
            var sortfield = dataset.sortfield;
            
            var filters = c.get('v.filters');
            if (filters.orderByField.toLowerCase() === sortfield.toLowerCase()) {
                filters.orderByField =  sortfield;
                filters.isASC= (!filters.isASC);
            } else {
                filters.orderByField =  sortfield;
                filters.isASC= true;
            }
            
            console.log('filters::',JSON.stringify(filters));
            c.set('v.filters', filters);
            h.getIds(c, filters);
        }catch(err){
            console.log('Error:',err);
            
        }
    },
})