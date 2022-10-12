({
    setAddress: function(c){
        var address = {street: '', country: '', province: '', city: '', postalCode: null};
        c.set('v.addresses', {id: null, billing: address, shipping: address, isShippingSameAsBilling: false});
    },
    proceedToCheckout: function(c, address){
        sessionStorage.setItem('address', JSON.stringify(address));
        var baseUrl = c.get('v.baseUrl');
        window.location = baseUrl + '/s/checkout';
    }
})