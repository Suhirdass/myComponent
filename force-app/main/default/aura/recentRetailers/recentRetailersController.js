({
  onInit: function (c, e, h) {
    h.request(c, 'getRecentRetailers', {}, function (r) {
      c.set('v.isBrand', r.isBrand);
      c.set('v.retailers', r.retailers);
    });
  },
  onRetailerClick: function (c, e, h) {
    var index = parseInt(e.currentTarget.dataset.index, 10);
    var retailers = c.get('v.retailers');
    var retailer = retailers[index];
      sessionStorage.setItem('retailerId', retailer.id);
        h.redirect('/retailer', true);   
    /*$A.createComponent('c:retailerDetails', { retailer: retailer, isBrand: c.get('v.isBrand') }, function (content, status) {
      if (status === 'SUCCESS') {
        c.find('overlay').showCustomModal({
          body: content,
          showCloseButton: true,
          cssClass: 'cUtility fix-close-button slds-modal_medium'
        })
      }
    });*/
  },
  onViewAll: function (c, e, h) {
    h.redirect('/retailers', true);
  },
  scrollLeft: function (c, e, h) {
    h.scroll(c, -250);
  },
  scrollRight: function (c, e, h) {
    h.scroll(c, 250);
  }
})