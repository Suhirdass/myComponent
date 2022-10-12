({
    onInit: function(c, e, h) {
        
    },
    onBrandDetails: function(c, e, h){
        var brand = c.get('v.brand');
        sessionStorage.setItem('brandId', brand.id);
        h.redirect('/brand', true);   
    }
})