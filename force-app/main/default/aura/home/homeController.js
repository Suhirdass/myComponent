({
	onInit: function (c, e, h) {  
		try {
            h.request(c,'getHomePageData',{},function (r) {
                console.log('getHomePageData:',r);
				c.set('v.recentOrdersList', r.recentOrdersList);
                c.set('v.newProductsList', r.newProductsList);
                c.set('v.newAccountOrdersList', r.newAccountOrdersList);
                c.set('v.coldAccountsList', r.coldAccountsList);
                c.set('v.isBrand', r.isBrand);
                c.set('v.isLimited', r.isLimited);
                c.set('v.baseUrl', r.baseUrl);
                c.set('v.INVESTOR_DASHBOARD_ID', r.INVESTOR_DASHBOARD_ID);
                c.set('v.hasNewsAndAnnouncemnets', r.hasNewsAndAnnouncemnets);
            	c.set('v.newsAndAnnouncemnets', r.newsAndAnnouncemnets);
                c.set('v.topBuyingRetailers', r.topBuyingRetailers);
                c.set('v.topSellingProducts', r.topSellingProductList); 
                c.set('v.isDataLoad', true);  
                if (r.hasNewsAndAnnouncemnets) {
					$A.createComponents(
                        [
                        	[
                        		'c:newsAndAnnouncement',
                        		{ newsAndAnnouncement: r.newsAndAnnouncemnets },
                    		]
                    	],
                    	function (contents, status) {
                    		if (status === 'SUCCESS') {
                        		c.find('overlay').showCustomModal({
                            		body: contents[0],
                            		showCloseButton: false,
                            		cssClass: 'cUtility slds-modal_medium',
                        		});
                    		}
                		}
                	);
            	}
                if(r.isBrand){ 
					h.drawBarChart(c, e, h,r.monthNameList,r.MGMData,'MGMChart',r.hasValues);                  	      
					//h.drawStakedBarChart(c, e, h,r.monthNameSet,r.MGMData,r.MGMColorCodeList,'MGMChart',true);                  	      
					h.drawStakedBarChart(c, e, h,r.agedBucketList,r.agingInventoryData,r.agingColorCodeList,'AgingChart',false);                  	      
                            
				}
            });
		} catch (err) {
			console.log('Error:', err);		
		}
    },
	showNewsAndAnnouncement: function (c, e, h) {
    	if (c.get('v.hasNewsAndAnnouncemnets')) {
			$A.createComponents(
				[
					[
						'c:newsAndAnnouncement',
						{ newsAndAnnouncement: c.get('v.newsAndAnnouncemnets') },
					]
				],
				function (contents, status) {
					if (status === 'SUCCESS') {
						c.find('overlay').showCustomModal({
							body: contents[0],
                            showCloseButton: false,
                            cssClass: 'cUtility slds-modal_medium',
                        });
                    }
				}
			);
		}    
    },
	onViewOrder:function(c,e,h){
        var recordId = e.currentTarget.dataset.id;
        var orderName = e.currentTarget.dataset.ordername;
        sessionStorage.setItem('retailerId', recordId);
        sessionStorage.setItem('selectedFilter', 'My Retailers');
        var brd = sessionStorage.getItem('breadCrumb');
        if(brd){
            brd = JSON.parse(brd);
            brd.breadCrumbString += ' > '+orderName;
            brd.breadCrumbIds+=' > ';
            sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}));
            $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}).fire();
        }
        h.redirect('/retailer', true);
    },
    onProductDetail :function(c,e,h){
        var priceId = e.currentTarget.dataset.id; 
        var productName = e.currentTarget.dataset.name;  
        sessionStorage.setItem('pricebookEntry', priceId);
        var brd = sessionStorage.getItem('breadCrumb');
        if(brd){
            brd = JSON.parse(brd);
            brd.breadCrumbString += ' > '+productName;
            brd.breadCrumbIds+=' > ';
            sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}));
            $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}).fire();
        }
        h.redirect('/product', true);
    },
    onInboundTransfer: function (c, e, h) {
        var recordId = e.currentTarget.dataset.id;
        var ticketnumber = e.currentTarget.dataset.ticketnumber;
        sessionStorage.setItem('serviceTicketId', recordId);
        var brd = sessionStorage.getItem('breadCrumb');
        if(brd){
            brd = JSON.parse(brd);
            brd.breadCrumbString += ' > '+ticketnumber;
            brd.breadCrumbIds+=' > ';
            sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}));
            $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}).fire();
        }
        h.redirect('/inboundtransferview', true);
    },
    onViewOT: function (c, e, h) {
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
    onViewTicket: function (c, e, h) {
        var recordId = e.currentTarget.dataset.id;
        var ticketnumber = e.currentTarget.dataset.ticketnumber;
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
	onViewtopBuyingRetailer:function(c,e,h){
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
	onViewtopSellingProduct:function(c,e,h){
        var recordId = e.currentTarget.dataset.id;
        var topSellingProductname = e.currentTarget.dataset.topsellingproductname;
        console.log('--------->'+recordId);
        var brd = sessionStorage.getItem('breadCrumb');
        if(brd){
            brd = JSON.parse(brd);
            brd.breadCrumbString += ' > '+topSellingProductname;
            brd.breadCrumbIds+=' > ';
            sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}));
            $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}).fire();
        }
        sessionStorage.setItem('pricebookEntry', recordId);
         h.redirect('/product', true);
    },
    onAllColdAccounts :function(c,e,h){
        var brd = sessionStorage.getItem('breadCrumb');
        if(brd){
            brd = JSON.parse(brd);
            brd.breadCrumbString += ' > Cold Accounts ';
            sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}));
            $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}).fire();
        }
        h.redirect('/coldaccounts', true);
    }
})