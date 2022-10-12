({
    onInit: function (c, e, h) {
        c.set('v.perPage',10);
        var filters = { orderByField: 'Order__r.Retailer__r.DBA__c', isASC: false };
        c.set('v.filters', filters);
        h.getIds(c, filters);
    },
    onScriptsLoaded: function (c, e, h) {},
    
    fetchColdAccounts: function (c, e, h) {
        var ids = e.getParam('ids');
        h.getRecords(c, ids);
    },
    
    onSortOrders: function (c, e, h) {
        var dataset = e.currentTarget.dataset;
        var sortfield = dataset.sortfield;
        
        var filters = c.get('v.filters');
        if (filters.orderByField.toLowerCase() === sortfield.toLowerCase()) {
            filters["orderByField"] =  sortfield;
            filters["isASC"] =  (!filters.isASC);
        } else {
            filters["orderByField"] =  sortfield;
            filters["isASC"] =  true;
        }
        c.set('v.filters', filters);
        h.getIds(c, filters);
    },
    scrollToTop: function (c, e, h) {
        h.scrollToTop(c);
    },
    onViewAccount:function(c,e,h){
        var recordId = e.currentTarget.dataset.id;
        var topbuyingretailername = e.currentTarget.dataset.retailername;
        sessionStorage.setItem('retailerId', recordId);
        var brd = sessionStorage.getItem('breadCrumb');
        if(brd){
            brd = JSON.parse(brd);            
            brd.breadCrumbString += ' > '+topbuyingretailername;
            brd.breadCrumbIds+=' > ';
            sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}));
            $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}).fire();
        }
         h.redirect('/retailer', true);
    },
    onPrintSelect: function (c, e, h) {
        var selectedFormat = e.getSource().get("v.value");
        console.log('selectedFormat:',selectedFormat);
        if(selectedFormat == 'csv'){
            h.fetchPageForFile(c);
        }else if(selectedFormat == 'pdf'){
            var currentUrl = window.location.href;
            currentUrl = currentUrl.replace('/s/coldaccounts','/apex/printColdAccounts?filters='+JSON.stringify(c.get('v.filters')));
            window.open(currentUrl,'_blank');
        }
    }
})