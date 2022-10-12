({
    onInit: function (c, e, h) {
        console.log("brandId:",sessionStorage.getItem('brandId'));
        c.set('v.recordId', sessionStorage.getItem('brandId'));
        h.request(c, 'getBrand', { id: sessionStorage.getItem('brandId') }, function (r) {
            console.log(r);
            c.set('v.brand', r.brand);
            try{
                c.set('v.mapMarkers', [
                    {
                        location: {
                            Street: r.brand.street,
                            City: r.brand.city,
                            State: r.brand.state,
                            Country: r.brand.country,
                            PostalCode: r.brand.postalCode,
                        },
                        title: r.brand.brandDBA,
                        description: ''
                    }
                ]);
            }catch(er){
                console.log("Error:",er);
            }
            c.set('v.stateLicenses', r.stateLicenses);
            c.set('v.salesOrders', r.salesOrders);
            c.set('v.brandContacts', r.brandContacts);
            c.set('v.isBrand', r.isBrand);
        });
    },
    showBrandProducts : function(c,e,h){
        console.log("showBrandProducts ...");
        try{
            var brand = c.get('v.brand');
            sessionStorage.setItem('initSearch', 1);
            sessionStorage.setItem('searchTerm', brand.DBA);
            h.redirect('/filigreenproducts', true);
            
        }catch(e){
            console.log("exception:",e);
        }
        
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
        h.navigateToRecord(e.target.id, "detail");
    }
})