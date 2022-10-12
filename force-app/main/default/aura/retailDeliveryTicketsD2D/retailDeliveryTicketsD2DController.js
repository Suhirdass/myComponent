({
    onInit: function (c, e, h) {
        c.set('v.perPage',10);
        sessionStorage.setItem('retailDeliveryTicketId', '');
        
        var filters = { orderByField: 'Name', isASC: false };
        c.set('v.filters', filters);
        h.getIds(c, filters);
    },
    onScriptsLoaded: function (c, e, h) {
       // h.initScroller(c);
    },
    onRecall:function (c, e, h) {
        var recordId = e.getSource().get('v.value');
        c.set('v.orderIdForRecall',recordId);
        c.set('v.orderNameForDelete',e.getSource().get('v.alternativeText'));
        c.set('v.isShowRecallConfirm',true);
        window.setTimeout($A.getCallback(function(){
            const modal = document.getElementById('confirm-modal');
        	if (modal) modal.classList.add('is-active');
        }),100);
    },
    changeOrder: function (c, e, h) {
        var STStatus = e.getSource().get("v.label");
        c.set('v.selectedStatus',STStatus);
        var filters = c.get('v.filters');
        filters['status'] = STStatus;
        c.set('v.filters', filters);
        h.getIds(c, c.get('v.filters'));
    },
    
    onPrintSelect: function (c, e, h) {
        var selectedFormat = e.getSource().get("v.value");
        console.log('selectedFormat:',selectedFormat);
        if(selectedFormat == 'csv'){
            //h.exportToCSV(c);
            h.fetchPageForFile(c);
        }else if(selectedFormat == 'pdf'){
            var currentUrl = window.location.href;
            currentUrl = currentUrl.replace('/s/outboundtransfers','/apex/printOutboundTransfersPdf?showTransferOrders=true&filters='+JSON.stringify(c.get('v.filters')));
            console.log('currentUrl::',currentUrl);
            window.open(currentUrl,'_blank');
        }
    },
    
    onChangeSearchProduct: function (c, e, h) {
        var searchRec = c.find('searchRec');
        var searchTerm = searchRec.getElement().value;
        window.setTimeout($A.getCallback(function(){
            //searchTerm = c.find('searchRec').get('v.value');
            console.log('searchTerm:',searchTerm);
            var filters = c.get('v.filters');
            filters['searchTerm'] = searchTerm;
            c.set('v.filters', filters);
            //h.reset(c);
            h.getIds(c, filters);
        }),100);
        
    },
    
    fetchRetailDeliveryTickets: function (c, e, h) {
        var ids = e.getParam('ids');
        h.getRecords(c, ids);
    },
    onNewRetailDeliveryTicket: function (c, e, h) {
        window.setTimeout($A.getCallback(function(){
            var AllBreadCrumb = sessionStorage.getItem('AllBreadCrumb');
        if(AllBreadCrumb){
            AllBreadCrumb = JSON.parse(AllBreadCrumb);
        }
		var screenName = 'Create Outbound Transfer';
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
        h.redirect('/newoutboundtransfer', true);
    },
    onDelete: function (c, e, h) {
        var recordId = e.getSource().get('v.value');
        c.set('v.orderIdForDelete',recordId);
        c.set('v.orderNameForDelete',e.getSource().get('v.alternativeText'));
        c.set('v.isShowConfirm',true);
        window.setTimeout($A.getCallback(function(){
            const modal = document.getElementById('confirm-modal');
        	if (modal) modal.classList.add('is-active');
        }),100);
         
    },
    handleConfirmEvent :function(c,e,h){
        var isConfirm = e.getParam("isConfirm");
        if(isConfirm){
            if(c.get('v.isShowConfirm')){
                h.request(c, 'deleteOrder', {recordId: c.get('v.orderIdForDelete')}, function (r) {
                    const modal = document.getElementById('confirm-modal');
                    if (modal) modal.classList.remove('is-active');
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Success',
                        message: c.get('v.Transfer_Order_Deleted_Message'),
                        type: 'success'
                    });
                     toastEvent.fire();
                    c.set('v.orderIdForDelete','');
                    c.set('v.orderNameForDelete','');
                    c.set('v.isShowConfirm',false);
                    window.setTimeout($A.getCallback(function() {
                        //window.location.reload();
                       h.getIds(c, c.get('v.filters'));
                    }), 1000);
                });
            } else {
                h.request(c, 'recallOrder', {recordId: c.get('v.orderIdForRecall')}, function (r) {
                    const modal = document.getElementById('confirm-modal');
                    if (modal) modal.classList.remove('is-active');
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Success',
                        message: 'Outbound Transfer recalled successfully',
                        type: 'success'
                    });
                    toastEvent.fire();
                    c.set('v.orderIdForRecall','');
                    c.set('v.orderNameForDelete','');
                    c.set('v.isShowRecallConfirm',false);
                    window.setTimeout($A.getCallback(function() {
                        c.set('v.allIds',[]);
                        c.set('v.records', []);
                       h.getIds(c, c.get('v.filters'));
                    }), 100);
                });
            }
        }
    },
    
    onEdit: function (c, e, h) {
        //var dataset = e.currentTarget.dataset;
        //var recordId = dataset.productid;
        var recordId = e.getSource().get('v.value');
        var ticketnumber = e.getSource().get('v.alternativeText');
        sessionStorage.setItem('retailDeliveryTicketId', recordId);
        var brd = sessionStorage.getItem('breadCrumb');
        if(brd){
            brd = JSON.parse(brd);
            brd.breadCrumbString += ' > '+ticketnumber;
            brd.breadCrumbIds+=' > ';
            sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}));
            $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}).fire();
        }
        h.redirect('/newoutboundtransfer', true);
    },
    onViewTicket: function (c, e, h) {
        var recordId = e.currentTarget.dataset.id;
        var orderName = e.currentTarget.dataset.ordername;
        sessionStorage.setItem('retaildeliveryticketId', recordId);
        var brd = sessionStorage.getItem('breadCrumb');
        if(brd){
            brd = JSON.parse(brd);
            brd.breadCrumbString += ' > '+orderName;
            brd.breadCrumbIds+=' > ';
            sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}));
            $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}).fire();
        }
        h.redirect('/viewoutboundtransfer', true);
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
    }
})