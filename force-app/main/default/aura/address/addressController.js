({
  onInit: function (c, e, h) {
    h.setAddress(c);
    h.request(c, 'getAddresses', {}, function (r) {
      if (r.isCartEmpty) {
        h.info({ message: 'Cart is empty, Continue shopping!' });
        h.redirect('/products', true);
        return;
      }
      c.set('v.existingAddresses', r.existingAddresses);
      c.set('v.baseUrl', r.baseUrl);
    });
  },
  setAddress: function (c, e, h) {
    e.preventDefault();
    var index = -1;
    try {
      index = parseInt(e.getSource().get('v.name'), 10);
    } catch (err) {
      index = -1;
    }
    c.set('v.selectedAddress', index);
    var existingAddresses = c.get('v.existingAddresses');
    if (index > -1) {
      c.set('v.address', Object.assign({ isShippingSameAsBilling: false }, existingAddresses[index]));
    } else {
      h.setAddress(c);
    }
    c.set('v.isEditing', true);
  },
  onDeleteAddress: function (c, e, h) {
    var index = parseInt(e.getSource().get('v.name'), 10);
    var existingAddresses = c.get('v.existingAddresses');
    if (index > -1) {
      var address = existingAddresses[index];
      existingAddresses.splice(index, 1);
      h.request(c, 'deleteAddress', { recordId: address.id }, function (r) {
        c.set('v.selectedAddress', -1);
        c.set('v.existingAddresses', existingAddresses);
        h.success({ message: 'Address deleted successfully!' });
      });
    }
  },
  cancelAddress: function (c, e, h) {
    c.set('v.isEditing', false);
  },
  setShippingAddress: function (c, e, h) {
    var address = c.get('v.address');
    if (address.isShippingSameAsBilling) {
      address.shipping = Object.assign({}, address.billing);
      c.set('v.address', address);
    }
  },
  onContinueShopping: function (c, e, h) {
    h.redirect('/products', true);
  },
  onSelect: function (c, e, h) {
    var index = parseInt(e.getSource().get('v.name'), 10);
    var existingAddresses = c.get('v.existingAddresses');
    if (index > -1) {
      h.proceedToCheckout(c, existingAddresses[index]);
    }
  },
  onSaveAndOrder: function (c, e, h) {
    var address = c.get('v.address');
    if (address.isShippingSameAsBilling) {
      address.shipping = Object.assign({}, address.billing);
    }
    h.request(c, 'saveAddress', { addressData: JSON.stringify(address) }, function (r) {
      h.success({ message: 'Address saved successfully.' });
      h.proceedToCheckout(c, r.address);
    });
  },
  onCancel: function (c, e, h) {
    c.set('v.address', {});
    c.set('v.selectedAddress', -1);
    c.set('v.isEditing', false);
  }
})