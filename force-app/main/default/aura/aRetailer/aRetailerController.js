({
    onInit: function (c, e, h) {
        c.set('v.recordId', sessionStorage.getItem('retailerId'));
        var selectedFilter=sessionStorage.getItem('selectedFilter');
        c.set('v.selectedFilter', selectedFilter);
       c.set('v.selectedTabId',selectedFilter == 'My Retailers' ? 'orders' : 'overview');
        
        h.request(c, 'getRetailer', { id: c.get('v.recordId') }, function (r) {
            console.log("r.retailer::",r.retailer);
            c.set('v.retailer', r.retailer);
            c.set('v.sortAsc',false);
            c.set('v.sortField','orderNumber');
            c.set('v.contactRTId',r.contactRTId);
            try{
                c.set('v.mapMarkers', [
                    {
                        location: {
                            Street: r.retailer.street,
                            City: r.retailer.city,
                            State: r.retailer.state,
                            Country: r.retailer.country,
                            PostalCode: r.retailer.postalCode,
                        },
                        title: r.retailer.retailerDBA,
                        description: ''
                    }
                ]);
            }catch(er){
                console.log("Error:",er);
            }
            c.set('v.stateLicenses', r.stateLicenses);
            c.set('v.salesOrders', r.salesOrders);
            c.set('v.linecards', r.linecards);
            c.set('v.retailerContacts', r.retailerContacts);
            c.set('v.insights',r.insights);
            c.set('v.isBrand', r.isBrand);
        });
    },
    onAddLinecard: function (c, e, h) {
        $A.createComponent('c:addToLineCard', { retailer: c.get('v.retailer'),isRetailer:true,recordId:c.get('v.retailer').lineCardId}, function (content, status) {
            if (status === 'SUCCESS') {
                c.find('overlay').showCustomModal({
                    body: content,
                    showCloseButton: true,
                    cssClass: 'cUtility fix-close-button slds-modal_medium'
                });
            }
        });
    },
    onNewInsight: function (c, e, h) {
        $A.createComponent('c:customerInsight', {lineCardId: c.get('v.retailer').lineCardId, retailerId: c.get('v.recordId'), isRetailer:true}, function (content, status) {
            if (status === 'SUCCESS') {
                c.find('overlay').showCustomModal({
                    body: content,
                    showCloseButton: true,
                    cssClass: 'cUtility fix-close-button slds-modal_medium'
                });
            }
        });
	},
    onEdit : function (c, e, h) {
        //alert('Hello');
        var insight = e.getSource().get('v.value');
        var insightDate;
        
        $A.createComponent('c:customerInsight', {lineCardId: c.get('v.retailer').lineCardId,retailerId: c.get('v.recordId'),customerInsight : insight,isRetailer:true,isUpdate:true}, function(content, status) {
            if (status === 'SUCCESS') {
                c.find('overlay').showCustomModal({
                    body: content,
                    showCloseButton: true,
                    cssClass: 'cUtility fix-close-button slds-modal_medium'
                });
            }                               
        }); 
    },
    
    onSortOrders: function (c, e, h) {
        var dataset = e.currentTarget.dataset;
        var sortfield = dataset.sortfield;
        var salesOrders = c.get('v.salesOrders');
        h.sortBy(c,sortfield,salesOrders);
        c.set('v.salesOrders',salesOrders);
    },
    onViewTicket: function (c, e, h) {
        var recordId = e.currentTarget.dataset.id;
        sessionStorage.setItem('retaildeliveryticketId', recordId);
        h.redirect('/viewretaildeliveryticket', true);
    },
    gotoDetails : function (c, e, h) {
        console.log(e);
        console.log(e.target);
        h.navigateToRecord(c,e.target.id, "detail");
    },
    printDetails: function (c, e, h) {
            var currentUrl = window.location.href;
            currentUrl = currentUrl.replace('/s/retailer','/apex/printRetailerPdf?id='+c.get('v.recordId'));
            console.log('currentUrl::',currentUrl);
            window.open(currentUrl,'_blank');
        } 
})