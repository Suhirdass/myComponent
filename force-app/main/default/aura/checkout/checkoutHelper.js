({
    updateTotal: function(c, total) {
        $A.get('e.c:updateCartTotalEvt').setParams({cartTotal: total}).fire();
    },
    addressNotSelected: function(c){
        var h = this;
        h.warning({message: 'Please select delivery address.'});
        h.redirect('/address', true);
    }
})