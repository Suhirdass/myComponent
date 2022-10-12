({
  onInit: function (c, e, h) {
      console.log("onInit:",sessionStorage.getItem('categoryName'));
    c.set('v.recordId', sessionStorage.getItem('pricebookEntry'));
    h.request(c, 'getProductAndReviews', { id: sessionStorage.getItem('pricebookEntry'), reviewsLimit: 5 }, function (r) {
      c.set('v.isBrand', r.isBrand);
      c.set('v.product', r.product);
        console.log("product::",r.product);
      c.set('v.totalReviews', r.totalReviews);
      c.set('v.ratingsSummary', r.ratingsSummary);
      c.set('v.reviews', r.reviews);
    });
      c.set('v.selectedCategory',sessionStorage.getItem('categoryName'));
  },
  onScriptsLoaded: function (c, e, h) {
    console.log("onScriptsLoaded");
      
      h.applyZoom(c);
  },
    onCategoryClick:function(c,e,h){
        console.log("onCategoryClick:");
        h.redirect('/filigreenproducts', true);
        var categoryName = sessionStorage.getItem('categoryName');
        var categories = sessionStorage.getItem('categories');
    }
    ,
    onViewCompliance:function(c,e,h){
        var product = c.get('v.product');
        console.log("product::",product);
        if(product.complianceFileId){
            var complianceFileIds = product.complianceFileId.split(',');
            $A.get('e.lightning:openFiles').fire({
                recordIds: complianceFileIds
            });
        }
    }
})