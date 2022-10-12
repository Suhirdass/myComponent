({
  onInit: function (c, e, h) {
    h.request(c, 'getMostPopularProducts', {}, function (r) {
        console.log("getMostPopularProducts::",r);
      c.set('v.isBrand', r.isBrand);
      c.set('v.products', r.products);
    });
  },
  onProductClick: function (c, e, h) {
    var index = parseInt(e.currentTarget.dataset.index, 10);
    var products = c.get('v.products');
    var product = products[index];
    $A.createComponent('c:productDetails', { product: product, isBrand: c.get('v.isBrand') }, function (content, status) {
      if (status === 'SUCCESS') {
        c.find('overlay').showCustomModal({
          header: product.name,
          body: content,
          showCloseButton: true,
          cssClass: 'cUtility fix-close-button'
        })
      }
    });
  },
  onViewAll: function (c, e, h) {
    h.redirect('/products', true);
  },
  scrollLeft: function (c, e, h) {
    h.scroll(c, -250);
  },
  scrollRight: function (c, e, h) {
    h.scroll(c, 250);
  }
})