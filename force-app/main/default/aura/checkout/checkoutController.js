({
  onInit: function (c, e, h) {
    try {
      var emptyAddress = true;
      var address = sessionStorage.getItem('address');
      if (address) {
        address = JSON.parse(address);
        if (address.id) {
          emptyAddress = false;
          c.set('v.address', address);
          h.request(c, 'getCartItems', {}, function (r) {
            c.set('v.isCartEmpty', (!r.items.length));
            console.log("r.items::", r.items);
            c.set('v.items', r.items);
            c.set('v.total', r.total);
            c.set('v.cartTotal', r.cartTotal);
            c.set('v.exciseTax', r.exciseTax);
            c.set('v.subTotal', r.subTotal);
              $A.get('e.c:updateCartTotalEvt').setParams({cartTotal: r.items.length}).fire();
          });
        }
      }
    } catch (err) { }

    if (emptyAddress) {
      h.addressNotSelected(c);
    }
  },
  onProductClick: function (c, e, h) {
    var dataset = e.currentTarget.dataset;
    sessionStorage.setItem('pricebookEntry', dataset.id);
    h.redirect('/product', true);
  },
  onCheckout: function (c, e, h) {
    var address = c.get('v.address') || {};
    h.request(c, 'checkout', { addressId: address.id }, function (r) {
      h.success({ message: 'Order received successfully.' });
      h.updateTotal(c, 0);
      c.set('v.isCartEmpty', true);
      c.set('v.orderId', r.order.Name);
    });
  },
  onChangeAddress: function (c, e, h) {
    h.redirect('/address', true);
  },
  onContinueShopping: function (c, e, h) {
    h.redirect('/products', true);
  }
})