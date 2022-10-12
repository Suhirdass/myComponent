({
  onInit: function (c, e, h) {
    h.initRating(c);
  },
  onProductReviews: function (c, e, h) {
    var product = c.get('v.product');
    sessionStorage.setItem('productId', product.price.id);
    h.redirect('/product-reviews', true);
  }
})