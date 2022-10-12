({
  onInit: function (c, e, h) {
    h.request(c, 'getRecentBrands', {}, function (r) {
      c.set('v.brands', r.brands);
      c.set('v.isBrand', r.isBrand);
    });
  },
  scrollLeft: function (c, e, h) {
    h.scroll(c, -250);
  },
  scrollRight: function (c, e, h) {
    h.scroll(c, 250);
  },
  onViewAll: function (c, e, h) {
      if(c.get('v.isPublic')){
          h.redirect('/filigreenbrands', true);
      }else{
          h.redirect('/brands', true);
      }
    
  },
  onBrandClick: function (c, e, h) {
    var index = parseInt(e.currentTarget.dataset.index, 10);
    var brands = c.get('v.brands');
    var brand = brands[index];
      sessionStorage.setItem('brandId', brand.id);
      if(c.get('v.isPublic')){
          h.redirect('/filigreenbrand', true);
      }else{
          h.redirect('/brand', true);
      }
        
      console.log('onBrandClick');
      console.log(brand);
    /*$A.createComponent('c:brandDetails', { brand: brand, isBrand: c.get('v.isBrand') }, function (content, status) {
      
        if (status === 'SUCCESS') {
        c.find('overlay').showCustomModal({
          body: content,
          showCloseButton: true,
          cssClass: 'cUtility fix-close-button slds-modal_medium'
        })
      }
    });*/
  }
})