({
  onInit: function (c, e, h) {
    h.request(c, 'getRecentProducts', {}, function (r) {
      c.set('v.isBrand', r.isBrand);
      c.set('v.products', r.products);
      c.set('v.warehouseTotalOrderedMap', r.warehouseTotalOrderedMap);
      var warehouseTotalOrderedMap = r.warehouseTotalOrderedMap;
      var warehouseMap;
      var products = r.products;
      products.forEach((product) => {  
            var availableInventories = product.availableInventories || [];
      		var totalOrderedQty = 0;
          	var totalWarehourseInventory = 0;
          	var warehouseInventoryDetails = '<ul>';
      		availableInventories.forEach((item) => {           
                if(product.id){
                    var key = item.id +'-'+product.id;
                    totalOrderedQty = warehouseTotalOrderedMap[key] || 0;
                }
                if(item.name != undefined){
                    var itemName = item.name.split(',')[0];
                    var itemNameList = itemName.split(' ');
                    var itemNm = '';
                    itemNameList.forEach((nm) => {
                        itemNm += nm.substring(0,1);    
                    });
                    var totalInventry = item.availableInventory - totalOrderedQty;
                    if(product.MOQ > 0)
                    	totalInventry = totalInventry / product.MOQ; 
                    totalWarehourseInventory = totalWarehourseInventory + totalInventry;
                    if(totalInventry % 1 != 0)
                    	totalInventry = totalInventry.toFixed(2);
                    warehouseInventoryDetails = warehouseInventoryDetails + '<li>' + itemNm +': '+ totalInventry +' Cases </li>';
                }
        	});
            product.warehouseInventoryDetails = warehouseInventoryDetails + '</ul>';
            if(totalWarehourseInventory % 1 != 0)
				totalWarehourseInventory = totalWarehourseInventory.toFixed(2);
			product.totalWarehourseInventory = totalWarehourseInventory;
        });                        
		c.set('v.products', products);
        console.log("r.products::",products);
    });
  },
  onProductClick: function (c, e, h) {
    var index = parseInt(e.currentTarget.dataset.index, 10);
    var products = c.get('v.products');
    var product = products[index];
      $A.createComponent('c:productDetails', { product: product, isBrand: c.get('v.isBrand'), warehouseTotalOrderedMap: c.get('v.warehouseTotalOrderedMap') }, function (content, status) {
      if (status === 'SUCCESS') {
        c.find('overlay').showCustomModal({
          header: product.name,
          body: content,
          showCloseButton: true,
          cssClass: 'cUtility fix-close-button'
        })
      }
    });
  },
  onViewAll: function (c, e, h) {
    h.redirect('/products', true);
  },
  scrollLeft: function (c, e, h) {
    h.scroll(c, -250);
  },
  scrollRight: function (c, e, h) {
    h.scroll(c, 250);
  }
})