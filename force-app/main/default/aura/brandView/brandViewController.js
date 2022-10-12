({
    onInit : function(c,e,h){
        const userAgent = navigator.userAgent.toLowerCase();
        c.set('v.isTablet',/(ipad|tablet|(android(?!.*mobile))|(windows(?!.*phone)(.*touch))|kindle|playbook|silk|(puffin(?!.*(IP|AP|WP))))/.test(userAgent));
    },
	onBrandClick: function (c, e, h) {
		console.log('onBrandClick');
		var brand = c.get('v.brand');
        console.log('brand.id',brand.id);
		sessionStorage.setItem('brandId', brand.id);
		if (c.get('v.isPublic')) {
			//h.redirect('/filigreenbrand', true);
			sessionStorage.setItem('initSearch', 1);
			sessionStorage.setItem('searchTerm', brand.DBA);
			h.redirect('/filigreenproducts', true);
		} else {
            var brd = sessionStorage.getItem('breadCrumb');
            if(brd){
                brd = JSON.parse(brd);
                brd.breadCrumbString += ' > '+brand.name;
                brd.breadCrumbIds+=' > ';
                sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}));
                $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}).fire();
            }
			h.redirect('/brand', true);
		}

		/*$A.createComponent('c:brandDetails', { brand: brand, isBrand: c.get('v.isBrand') }, function (content, status) {
      if (status === 'SUCCESS') {
        c.find('overlay').showCustomModal({
          body: content,
          showCloseButton: true,
          cssClass: 'cUtility fix-close-button slds-modal_medium'
        });
      }
    });*/
	},
});