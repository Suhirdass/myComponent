({
    onInit: function (c, e, h) {
        c.set('v.perPage',10);
        sessionStorage.setItem('serviceTicketId', '');
        var filters = { orderByField: 'Name', isASC: false };
        c.set('v.filters', filters);
        h.getIds(c, c.get('v.filters'));
        console.log('AllBreadCrumb::',sessionStorage.getItem('AllBreadCrumb'));
    },
    validateKeys: function (c, e, h) {
        if(e.keyCode == 13){
            e.preventDefault();
            return false;
        }
    },
    fetchTickets: function (c, e, h) {
        var ids = e.getParam('ids');
        console.log('fetchTickets ids::',ids);
        h.getRecords(c, ids);
    },
    onSearchTickets: function (c, e, h) {
        var searchRec = c.find('ticketSearch');
        var searchTerm = searchRec.getElement().value;
        window.setTimeout($A.getCallback(function(){
            console.log('searchTerm:',searchTerm);
            var filters = c.get('v.filters');
            filters['searchTerm'] = searchTerm;
            c.set('v.filters', filters);
            h.getIds(c, filters);
        }),10);
        
       /* window.setTimeout($A.getCallback(function(){
            var searchTerm = c.find('ticketSearch').get('v.value');
            var filters = c.get('v.filters');
            filters['searchTerm'] = searchTerm;
            c.set('v.filters', filters);
            //h.reset(c);
            h.getIds(c, filters);
        }),100);*/
        
    },
    onPrintSelect: function (c, e, h) {
        var selectedFormat = e.getSource().get("v.value");
        console.log('selectedFormat:',selectedFormat);
        if(selectedFormat == 'csv'){
            h.fetchPageForFile(c);
        }else if(selectedFormat == 'pdf'){
            var currentUrl = window.location.href;
            currentUrl = currentUrl.replace('/s/servicetickets','/apex/printTicketsPdf?filters='+JSON.stringify(c.get('v.filters')));
            console.log('currentUrl::',currentUrl);
            window.open(currentUrl,'_blank');
        }
    },
    changeServiceTickets: function (c, e, h) {
        var STStatus = e.getSource().get("v.label");
        c.set('v.selectedStatus',STStatus);
        var filters = c.get('v.filters');
        filters['status'] = STStatus;
        c.set('v.filters', filters);
        h.getIds(c, c.get('v.filters'));
    },
    onScriptsLoaded: function (c, e, h) {
        //h.initScroller(c);
    },
    handleSearch: function (c, e, h) {
        var searchTerm = e.getParam('searchTerm');
        var filters = { searchTerm: searchTerm };
        
        h.getIds(c, filters);
    },
    onNewServiceTicket: function (c, e, h) {
        window.setTimeout($A.getCallback(function(){
            var AllBreadCrumb = sessionStorage.getItem('AllBreadCrumb');
        if(AllBreadCrumb){
            AllBreadCrumb = JSON.parse(AllBreadCrumb);
        }
        
        var screenName = 'Create Service Ticket';
        var matchedMenu = AllBreadCrumb.find((menu) => {
            return menu.text == screenName;
        })
        console.log('screenName::',matchedMenu);
        if(matchedMenu){
            sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: matchedMenu.label, breadCrumbIds : matchedMenu.value}));
            $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: matchedMenu.label, breadCrumbIds : matchedMenu.value}).fire();
        }
        var removeIdsFromCache = e.currentTarget.dataset.removeIdsFromCache;
        console.log('removeIdsFromCache:',removeIdsFromCache);
        if(removeIdsFromCache){
            var Ids = removeIdsFromCache.split(',');
            if(Ids.length){
                Ids.forEach((id) => {
                    sessionStorage.removeItem(id);
                })
                }
                }
        }),100);
        h.redirect('/newserviceticket', true);
    },
    onEdit: function (c, e, h) {
        var recordId = e.getSource().get('v.value');
        var ticketnumber = e.getSource().get('v.alternativeText');
        sessionStorage.setItem('serviceTicketId', recordId);
        var brd = sessionStorage.getItem('breadCrumb');
        if(brd){
            brd = JSON.parse(brd);
            brd.breadCrumbString += ' > '+ticketnumber;
            brd.breadCrumbIds+=' > ';
            sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}));
            $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}).fire();
        }
        /*window.setTimeout($A.getCallback(function(){
            var AllBreadCrumb = sessionStorage.getItem('AllBreadCrumb');
            if(AllBreadCrumb){
                AllBreadCrumb = JSON.parse(AllBreadCrumb);
            }
            
            var screenName = 'Create Service Ticket';
            var matchedMenu = AllBreadCrumb.find((menu) => {
                return menu.text == screenName;
            })
            console.log('screenName::',matchedMenu);
            if(matchedMenu){
                sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: matchedMenu.label, breadCrumbIds : matchedMenu.value}));
                $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: matchedMenu.label, breadCrumbIds : matchedMenu.value}).fire();
            }
        }),100);*/
        h.redirect('/newserviceticket', true);
    },
    onViewTicket: function (c, e, h) {
        var recordId = e.currentTarget.dataset.id;
        var ticketnumber = e.currentTarget.dataset.ticketnumber;
        console.log("recordId:", recordId);
        sessionStorage.setItem('serviceTicketId', recordId);
        var brd = sessionStorage.getItem('breadCrumb');
        if(brd){
            brd = JSON.parse(brd);
            brd.breadCrumbString += ' > '+ticketnumber;
            brd.breadCrumbIds+=' > ';
            sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}));
            $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}).fire();
        }
        h.redirect('/viewserviceticket', true);
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
    downloadPDF : function(component, event, helper) {
        //debugger;
        
        var action = component.get('c.downloadPDFFile');
        /*action.setParams({
            "entityType" : component.get('v.componentString') 
        });*/
        action.setCallback(this, function(a){
            var state = a.getState(); // get the response state
            if(state == 'SUCCESS') {
                // component.set('v.sObjList', a.getReturnValue());
                var hiddenElement = document.createElement('a');
                hiddenElement.href = 'data:text/pdf;charset=utf-8,' + a.getReturnValue();
                hiddenElement.target = '_blank';
                hiddenElement.download = 'fileTitle'+'.pdf'; 
                hiddenElement.click();
            }
        });
        $A.enqueueAction(action);
    }
})