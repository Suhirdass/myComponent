({
  onInit: function (c, e, h) {
    h.request(c, 'init', {}, function (r) {
        console.log('User options:',r);
      c.set('v.user', r.user);
      c.set('v.baseUrl', r.baseUrl);
      c.set('v.isBrand', r.isBrand);
        c.set('v.isLimited', r.isLimited);
      $A.get('e.c:updateCartTotalEvt').setParams({ cartTotal: r.quantity }).fire();

      var initials = r.user.name.split(' ').map(function(name) { return name[0] }).join('')
      c.set('v.initials', initials)
    })
  },
  navigateToSettings: function (c, e, h) {
      var AllBreadCrumb = sessionStorage.getItem('AllBreadCrumb');
      if(AllBreadCrumb){
          AllBreadCrumb = JSON.parse(AllBreadCrumb);
      }
      
      var screenName = 'Home';
      var matchedMenu = AllBreadCrumb.find((menu) => {
          return menu.text == screenName;
      })
      console.log('screenName::',matchedMenu);
      if(matchedMenu){
          //console.log('BreadCrumb:',JSON.stringify({breadCrumbString: matchedMenu.label+' > '+'Settings', breadCrumbIds : matchedMenu.value+' > '}));
          //
          sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: matchedMenu.label.replace(' > Home',' > Settings'), breadCrumbIds : matchedMenu.value}));
          $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: matchedMenu.label.replace(' > Home',' > Settings'), breadCrumbIds : matchedMenu.value}).fire();
      }
      var removeIdsFromCache = 'serviceTicketId,retailDeliveryTicketId,newProductRequestId,isViewProductRequest';
      console.log('removeIdsFromCache:',removeIdsFromCache);
      if(removeIdsFromCache){
          var Ids = removeIdsFromCache.split(',');
          if(Ids.length){
              Ids.forEach((id) => sessionStorage.removeItem(id));
          }
      }
    h.redirect('/settings');
  },
  navigateToOrdersHistory: function (c, e, h) {
    h.redirect('/orders');
  },
  navigateToWishLists: function (c, e, h) {
    h.redirect('/wish-lists');
  },
    navigateToCases : function(c, e, h) {
        h.redirect('/cases');
    },
  logout: function (c, e, h) {
    var baseUrl = c.get('v.baseUrl');
      sessionStorage.removeItem('breadCrumb');
    window.location.href = baseUrl + '/secur/logout.jsp';
  },
  onUsernameChange: function (c, e, h) {
    var user = c.get('v.user');
    user.name = e.getParam('username');

    c.set('v.user', user);
  }
})