({
  onInit: function (c, e, h) {
	const userAgent = navigator.userAgent.toLowerCase();
        c.set('v.isTablet',/(ipad|tablet|(android(?!.*mobile))|(windows(?!.*phone)(.*touch))|kindle|playbook|silk|(puffin(?!.*(IP|AP|WP))))/.test(userAgent));
  },
  onRetailerClick: function (c, e, h) {
	var retailer = c.get('v.retailer');
      sessionStorage.setItem('retailerId', retailer.id);
      var brd = sessionStorage.getItem('breadCrumb');
      if(brd){
          brd = JSON.parse(brd);
          brd.breadCrumbString += ' > '+retailer.retailerName;
          brd.breadCrumbIds+=' > ';
          sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}));
          $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}).fire();
      }
      h.redirect('/retailer', true);   
    
  },
  onRetailerDetails: function (c, e, h) {
    var retailer = c.get('v.retailer');
    sessionStorage.setItem('retailerId', retailer.id);
    h.redirect('/retailer', true);
  }
})