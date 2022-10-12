({
    onInit: function(c, e, h) {
        
    },
    onRetailerDetails: function(c, e, h){
        var retailer = c.get('v.retailer');
        sessionStorage.setItem('retailerId', retailer.id);
        h.redirect('/retailer', true);   
    }
})