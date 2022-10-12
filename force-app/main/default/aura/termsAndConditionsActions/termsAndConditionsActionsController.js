({
  onAccept: function (c, e, h) {
    h.request(c, 'hasAccepted', {}, function (r) {
      h.success({message: 'Accepted terms and conditions!'});
      c.find('overlay').notifyClose();
    });
  }
})