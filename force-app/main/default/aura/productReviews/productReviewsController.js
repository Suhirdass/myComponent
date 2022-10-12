({
  onInit: function (c, e, h) {
    var viewAll = c.get('v.viewAll');
    if (!viewAll) {
      c.set('v.recordId', sessionStorage.getItem('productId'));
      h.request(c, 'getProductAndReviews', { id: c.get('v.recordId'), reviewsLimit: 1000 }, function (r) {
        c.set('v.product', r.product);
        c.set('v.totalReviews', r.totalReviews);
        c.set('v.reviews', r.reviews);
        window.setTimeout($A.getCallback(function () {
          $('.nano').nanoScroller({
          });
        }), 500);
      });
    }
  },
  onViewAll: function (c, e, h) {
    var product = c.get('v.product');
    sessionStorage.setItem('productId', product.price.id);
    h.redirect('/product-reviews', true);
  },
  onProductDetails: function (c, e, h) {
    var product = c.get('v.product');
    sessionStorage.setItem('pricebookEntry', product.price.id);
    h.redirect('/product', true);
  }
})