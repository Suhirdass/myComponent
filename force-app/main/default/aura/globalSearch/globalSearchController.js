({
	onInit: function (c, e, h) {
        
        h.prepareBreadCrumb(c,'Global Search');
        var searchTerm = decodeURIComponent(c.get('v.searchTerm'));
        console.log('searchTerm:',searchTerm);
        //searchTerm = searchTerm.substring(1);
        console.log('Search Term:',searchTerm);
        if(searchTerm == '' || searchTerm == "undefined" || searchTerm == undefined || searchTerm == null){
            searchTerm = sessionStorage.getItem('globalSearchTerm');
            c.get('v.searchTerm',searchTerm);
            console.log('searchTerm::',searchTerm);
        }
        if(searchTerm != '' && searchTerm != undefined && searchTerm != null){
            h.request(c, 'globalSearch', { str: searchTerm}, function (r) {
                console.log("searchList::",r.searchList);
                c.set('v.orders', r.searchList[0]);
                c.set('v.brandQuote', r.searchList[1]);
                c.set('v.salesOrder', r.searchList[2]);
                c.set('v.invoices', r.searchList[3]);
                c.set('v.purOrders', r.searchList[4]);
                c.set('v.shipManifests', r.searchList[5]);
                c.set('v.retailers',r.searchList[6]);
                c.set('v.products',r.records);
                c.set('v.contactRTId',r.contactRTId);
                c.set('v.isBrand',r.isBrand);
                c.set('v.brands',r.brands);
            }, {});
        }
    },
    changeRecords : function(c,e,h){
        var STStatus = e.getSource().get("v.value");
        c.set('v.selectedStatus',STStatus);
    },
    onProductRecClick : function (c, e, h) {
        try{
            var dataset = e.currentTarget.dataset;
            var productPriceId = dataset.id;
            var ticketnumber = e.currentTarget.dataset.name;
            var brd = sessionStorage.getItem('breadCrumb');
            if(brd){
                brd = JSON.parse(brd);
                brd.breadCrumbString += ' > '+ticketnumber;
                brd.breadCrumbIds+=' > ';
                sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}));
                $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}).fire();
            }
            sessionStorage.setItem('pricebookEntry', productPriceId);
            h.redirect('/product', true);
        }catch(err){
            console.log('Error:',err);
        }
    },
    onMenuClick: function (c, e, h) {
        var href = e.currentTarget.dataset.href;
        console.log('href:',href);
        $('.tab-pane').removeClass('active');
        $(href).addClass('active');
    },
    navigateToRecord : function(c, e, h) {
        var dataset = e.currentTarget.dataset;
        var SMId = dataset.id;
        var ticketnumber = e.currentTarget.dataset.name;
        var brd = sessionStorage.getItem('breadCrumb');
        if(brd){
            brd = JSON.parse(brd);
            brd.breadCrumbString += ' > '+ticketnumber;
            brd.breadCrumbIds+=' > ';
            sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}));
            $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}).fire();
        }
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": SMId
        });
        navEvt.fire(); 
    },
    onView:function(c,e,h){
		var retailerId = e.currentTarget.dataset.id;  
        var ticketnumber = e.currentTarget.dataset.name;
        var type = e.currentTarget.dataset.type;
        var brd = sessionStorage.getItem('breadCrumb');
        if(brd){
            brd = JSON.parse(brd);
            brd.breadCrumbString += ' > '+ticketnumber;
            brd.breadCrumbIds+=' > ';
            sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}));
            $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}).fire();
        }
        console.log('retailerId',retailerId);
        console.log('contactRTId',c.get('v.contactRTId'));
        if(type == 'retailer'){
            sessionStorage.setItem('retailerId', retailerId);
            h.redirect('/retailer', true);
        }else{
            sessionStorage.setItem('brandId', retailerId);
            h.redirect('/brand', true);
        }
        
       	sessionStorage.setItem('contactRTId', c.get('v.contactRTId'));
        
    },
    onViewTicket: function (c, e, h) {
        e.preventDefault();
        var recordId = e.currentTarget.dataset.id;
        console.log('Is Brand:',c.get('v.isBrand'));
        var ticketnumber = e.currentTarget.dataset.name;
        var brd = sessionStorage.getItem('breadCrumb');
        if(brd){
            brd = JSON.parse(brd);
            brd.breadCrumbString += ' > '+ticketnumber;
            brd.breadCrumbIds+=' > ';
            sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}));
            $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}).fire();
        }
        if(c.get('v.isBrand')){
            sessionStorage.setItem('retaildeliveryticketId', recordId);
            h.redirect('/viewbrandorder', true);
        }else{
            sessionStorage.setItem('retailorderId', recordId);
            h.redirect('/viewretailorder', true);
        }
        
    },
})