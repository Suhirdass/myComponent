({
    onInit: function (c, e, h) {
        var action = c.get('c.isCommunityPlusUser');
        action.setCallback(this, function (a) {
            var r = a.getReturnValue();
            console.log('isCommunityPlusUser::', r);
            c.set('v.AccountType', r.data.AccountType);
            c.set('v.navigationConfig', r.data.navigationConfig);
            c.set('v.isCommunityPlusUser', r.data.isCommunityPlusUser);
            c.set('v.isBrand', r.data.isBrand);
            c.set('v.isLimited', r.data.isLimited);
            c.set('v.DiscardItem_CommPlus_Users',r.data.DiscardItem_CommPlus_Users);
            c.set('v.DiscardItem_Brand_Users',r.data.DiscardItem_Brand_Users);
            c.set('v.DiscardItem_CommPlus_And_Brand_Users',r.data.DiscardItem_CommPlus_And_Brand_Users);
            c.set('v.DiscardItem_Except_CommPlus_And_Brand_Users',r.data.DiscardItem_Except_CommPlus_And_Brand_Users);
            c.set('v.DiscardItem_Limited_Access',r.data.DiscardItem_Limited_Access);
            console.log(r.data.isBrand,'r.data.isBrand');
            c.set('v.hideFAQ', r.data.FAQs == 0);    
            if (!r.data.hasAcceptedTerms) {
                $A.createComponents(
                    [
                        [
                            'c:termsAndConditions',
                            { 
                                termsAndConditions: r.data.termsAndConditions
                            },
                        ]
					],
                    function (contents, status) {
                        if (status === 'SUCCESS') {
                            c.find('overlay').showCustomModal({
                                body: contents[0],
                                showCloseButton: false,
                                cssClass: 'cUtility slds-modal_medium',
                            });
                        }
                    }
				);
			}
            c.set('v.isDataLoaded',true);            
		});
        $A.enqueueAction(action);
    },
    navigate: function (c, e, h) {
        h.navigate(c, e);
    },
    updateCartTotal: function (c, e, h) {
        try {
            var cartTotal = e.getParam('cartTotal');
            console.log('updateCartTotal calling...', cartTotal);
            
            c.set('v.cartTotal', cartTotal);
        } catch (er) {
            console.log('updateCartTotal Error :', er);
        }
    },
    navigateToCart: function (c, e, h) {
        var isBrand = c.get('v.isBrand');
        $A.get('e.force:navigateToURL')
        .setParams({
            url: isBrand ? '/newbrandorder' : '/cart',
            isredirect: true,
        })
        .fire();
    },
    onRenderMenuItems: function (c, e, h) {
        var renderMenuItems = c.get('v.renderMenuItems');
                        console.log('renderMenuItems::',renderMenuItems);
        if (renderMenuItems.length) {
            var menusMap = [];
            renderMenuItems.forEach(item => {
                    console.log('item::',JSON.stringify(item));
                const label = item.label === 'Retail Delivery Orders' ? 'Orders' : item.label;
                if (item.subMenu) {
                    item.subMenu.forEach(si =>menusMap.push({ text: si.label, label: 'Home > ' + label + ' > ' + si.label, value: '0 > ' + item.id + ' > ' + si.id}));
                } else {
                    menusMap.push({text: label,label: (label !== 'Home'?'Home > ':'') + label,value: '0 > ' + item.id});
                }
        	});
        	if (menusMap.length) {
                menusMap.push({text: 'Global Search',label: 'Home > ' + 'Global Search',value: '0 > ' + '-1'});
                menusMap.push({text: 'Cart',label: 'Home > ' + 'Cart',value: '0 > ' + '-1'});
                console.log('menusMap:',menusMap);
                sessionStorage.setItem('AllBreadCrumb', JSON.stringify(menusMap));
    		}
		}
	},
    onMenuItemChange: function (c, e, h) {
            if(!c.get('v.isDataLoaded')){
                return;
            }
        var menuItems = c.get('v.menuItems');
        var isCommunityPlusUser = c.get('v.isCommunityPlusUser');
        var isBrand = c.get('v.isBrand');
            var isLimited = c.get('v.isLimited');
        var renderMenuItems = [];
        var discardItems = [];
        
        if (menuItems.length) {
            console.log('isCommunityPlusUser ', isCommunityPlusUser);
            console.log('isBrand ', isBrand);
            
            if(isLimited){
                console.log('Limited:',c.get('v.DiscardItem_Limited_Access'));
                let disArr = c.get('v.DiscardItem_Limited_Access').split(',');
                discardItems = disArr
            }else if (isCommunityPlusUser && isBrand) {
                let disArr = c.get('v.DiscardItem_CommPlus_And_Brand_Users').split(',');
                discardItems = disArr //'Brands',
            } else if (isCommunityPlusUser) {
                let disArr = c.get('v.DiscardItem_CommPlus_Users').split(',');
                discardItems = disArr //'Brands',
            } else if (isBrand) {
                let disArr = c.get('v.DiscardItem_Brand_Users').split(',');
                discardItems = disArr //'Brands',
            } else {
                let disArr = c.get('v.DiscardItem_Except_CommPlus_And_Brand_Users').split(',');
                discardItems = disArr //'Brands',
            }
            if (c.get('v.hideFAQ') == true) {
                console.log('Hide FAQ');
                discardItems.push('FAQ');
            }
            if(c.get('v.AccountType') != 'Financial Interest - NL'){
                discardItems.push('Program Analysis');
            }
            console.log('discardItems:',discardItems);
            if (discardItems.length) {
                menuItems.forEach(function (menuItem) {
                    if(menuItem.subMenu != undefined){
                        let submenus = [];
                        menuItem.subMenu.forEach(function (subItem) {
                            if (discardItems.indexOf(subItem.label) === -1) {
                                submenus.push(subItem);
                            }
                        });
                        menuItem.subMenu = submenus;
                    }
                    if (discardItems.indexOf(menuItem.label) === -1) {
                        renderMenuItems.push(menuItem);
                    }
                });
            }
            let navigationConfig = c.get('v.navigationConfig');
            renderMenuItems.forEach(item => {
                const label = item.label === 'Retail Delivery Orders' ? 'Orders' : item.label;
                const menuConfig = navigationConfig[label];
                
                if (menuConfig) {
                	item.icon = '/filigreenb2b/resource/BrigadeResources/assets/icons/white/' +menuConfig.Icon__c;
            	}
            });
            console.log('renderMenuItems::',renderMenuItems);
            c.set('v.renderMenuItems', renderMenuItems);
        }
            
    },
        handleMenuClick: function (c, e, h) {
            /*var menuList = c.get('v.menuList');
    var target = e.target

    c.set("v.menuList", menuList.map(function(item) {
      var el = document.querySelector(`[data-id="${item.label}"]`)

      if (el && el.contains(target)) {
        item.isOpened = !item.isOpened
      }

      return item
    }))*/
            try{
      var menuList = c.get('v.renderMenuItems');
      var target = e.target;
      
      c.set(
          'v.renderMenuItems',
          menuList.map(function (item) {
              var el = document.querySelector(`[data-id="${item.label}"]`);
              
              if (el && el.contains(target)) {
                  item.isOpened = !item.isOpened;
              } else {
                  item.isOpened = false;
              }
              
              return item;
          })
      );
            }catch(error){
                console.log('Error:',error);
            }
  },
});