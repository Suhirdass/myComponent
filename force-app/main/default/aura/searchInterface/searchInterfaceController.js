({
  onInit: function (c, e, h) {

  },
  onSearch: function (c, e, h) {
    var keyCode = e.which || e.keyCode || 0;
    switch (keyCode) {
      case h.keyCode.ENTER:
        h.onSearch(c);
        break;

      default:
        break;
    }
  },
  expandSearch: function(c, e, h) {
    c.set('v.isSearchExpanded', true);
    e.preventDefault()

    setTimeout(function() {
      c.find('searchBox').focus()
    })
  },
  onContactSupport:function(c,e,h){
    h.redirect('/cases', true);
  },
  onSearchClick: function (c, e, h) {
    h.onSearch(c);
  }
})