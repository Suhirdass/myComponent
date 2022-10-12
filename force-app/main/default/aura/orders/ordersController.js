({
    onInit: function (c, e, h) {
        c.set('v.perPage',10);
        var filters = { orderByField: 'Order_Date__c', isASC: false };
        c.set('v.filters', filters);
        h.getIds(c, filters);
    },
    changeOrder:function(c,e,h){
        var STStatus = e.getSource().get("v.label");
        c.set('v.selectedStatus',STStatus);
        var filters = c.get('v.filters');
        filters['status'] = STStatus;
        c.set('v.filters', filters);
        h.getIds(c, c.get('v.filters'));
    },
    onChangeSearchProduct: function(c,e,h){
        var searchRec = c.find('searchRec');
        var searchTerm = searchRec.getElement().value;
        window.setTimeout($A.getCallback(function(){
            console.log('searchTerm:',searchTerm);
            var filters = c.get('v.filters');
            filters['searchTerm'] = searchTerm;
            c.set('v.filters', filters);
            h.getIds(c, filters);
        }),100);
    },
    onViewOrder:function(c,e,h){
        var recordId = e.currentTarget.dataset.id;
        var orderName = e.currentTarget.dataset.ordername;
        sessionStorage.setItem('retailorderId', recordId);
        var brd = sessionStorage.getItem('breadCrumb');
        if(brd){
            brd = JSON.parse(brd);
            brd.breadCrumbString += ' > '+orderName;
            brd.breadCrumbIds+=' > ';
            sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}));
            $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}).fire();
        }
        h.redirect('/viewretailorder', true);
    },
    fetchOrders: function (c, e, h) {
        var ids = e.getParam('ids');
        h.getRecords(c, ids);
    },
    onScriptsLoaded: function (c, e, h) {
        //h.initScroller(c);
    },
    onOrderCancel: function (c, e, h) {
        var orderId = e.getSource().get('v.value');
        if (confirm("Are you sure, you want to Cancel Order?")) {
            h.request(c, 'cancelOrder', { orderId: orderId }, function (r) {
                h.success({ message: 'Order cancelled successfully.' });
                h.request(c, 'getOrders', {}, function (r) {
                    c.set('v.orders', r.orders);
                });
            });
        }
    },
    onProductClick: function (c, e, h) {
        var dataset = e.currentTarget.dataset;
        sessionStorage.setItem('pricebookEntry', dataset.id);
        h.redirect('/product', true);
    },
    onContinueShopping: function (c, e, h) {
        h.redirect('/products', true);
    },
    onViewCompliance:function(c,e,h){
        var value = e.getSource().get('v.value');
        var orderId = value.split('-')[0]
        var productId = value.split('-')[1]
        console.log("orderId:",orderId);
        h.request(c, 'getComplianceFiles', {orderId:orderId,productId:productId}, function (r) {
            //c.set('v.orders', r.docIds);
            console.log("docIds::",r);
            if(r.docIds){
                var docIds = r.docIds.split(',');
                $A.get('e.lightning:openFiles').fire({
                    recordIds: docIds
                })
            }else{
                h.info({ message: 'No Compliance Images found.' });
            }
        });
        /*$A.get('e.lightning:openFiles').fire({
		    recordIds: ['069c0000000pI3UAAU']
		});*/
        
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
    
    onPrintSelect: function (c, e, h) {
        var selectedFormat = e.getSource().get("v.value");
        console.log('selectedFormat:',selectedFormat);
        if(selectedFormat == 'csv'){
            //h.exportToCSV(c);
            h.fetchPageForFile(c);
        }else if(selectedFormat == 'pdf'){
            var currentUrl = window.location.href;
            currentUrl = currentUrl.replace('/s/orders','/apex/printRetailOrdersPdf?filters='+JSON.stringify(c.get('v.filters')));
            console.log('currentUrl::',currentUrl);
            window.open(currentUrl,'_blank');
        }
    },
})