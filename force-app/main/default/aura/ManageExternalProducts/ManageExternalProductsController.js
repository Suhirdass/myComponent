({
    initRecords: function(c, e, h) {
    	h.fetchData(c);
    },
    onSave:function(c,e,h){
        h.saveRecords(c);
    },
    onCancel:function(c,e,h){
        Swal.fire({
            //title: "Are you sure you want to reload the form ?",
            title: "Are you sure ?",
            text: "",
            type: "",
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#3c3636',
            confirmButtonText: 'Yes',
            cancelButtonText: 'No',
        }).then((result) => {
            if (result.value) {
            	h.fetchData(c);
            }
            var evt = c.getEvent('retailDeliveryTicketLineEvt');
            evt.setParams({
                retailDeliveryTicketLineItem : c.get('v.productList'),
                indexVal : 1
            });
            evt.fire();
        });
    },
    onScriptsLoaded: function (c, e, h) {
        h.initScroller(c);
    },
    onProductDetails: function (c, e, h) {
        var productId = e.currentTarget.dataset.id;
        var mapObject= c.get('v.productPriceBook');
        console.log('PriceBookEntry = ',mapObject[productId]);
        
        sessionStorage.setItem('pricebookEntry', mapObject[productId]);
        h.redirect('/product', true);
    },
})