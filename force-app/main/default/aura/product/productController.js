({
    onInit : function(c, e, h) {
        //console.log('bbb :',c.get('v.warehouseTotalOrderedMap')['a0e6A0000033X2sQAE-01t3s0000051pgYAAQ']);

        var product = c.get('v.product');
        var availableInventories = product.availableInventories || [];
        var warehouseTotalOrderedMap = c.get('v.warehouseTotalOrderedMap');
        //console.log('warehouseTotalOrderedMap ',warehouseTotalOrderedMap)
        var totalOrderedQty = 0;
        var totalWarehourseInventory = 0;
        var warehouseInventoryDetails = '';
         const mapOfLAUnits = new Map();
        console.log('product Name:',product.name);
        availableInventories.forEach((item) => {
            if(product && product.id){
            	var key = item.id +'-'+product.id;
            	totalOrderedQty = warehouseTotalOrderedMap[key] || 0;
            console.log('totalOrderedQty::',totalOrderedQty);
        	}
            if(item.name != undefined){
            	var itemName = item.name.split(',')[0];
            	var itemNameList = itemName.split(' ');
            	var itemNm = '';
            	itemNameList.forEach((nm) => {
                	itemNm += nm.substring(0,1);
                });
                var totalInventry = item.availableInventory - totalOrderedQty;
                var isSamePrd =false;
                    if(totalInventry < 0 && totalInventry != 0){
                    	var tempTotalInventry = totalInventry;
                    	totalInventry =0;
                    	mapOfLAUnits.set(product.id, tempTotalInventry);
                    isSamePrd=true;
                	}
                    if(!isSamePrd && mapOfLAUnits.has(product.id) && totalInventry > 0){
                    	totalInventry = totalInventry + mapOfLAUnits.get(product.id);
                    	mapOfLAUnits.delete(product.id);
                	}
                 totalInventry = totalInventry ;/// product.MOQ;
                    console.log('totalInventry:',totalInventry);
                if(product.MOQ > 0)
                	totalWarehourseInventory = totalWarehourseInventory + (totalInventry/ product.MOQ);
                else
                    totalWarehourseInventory = (totalWarehourseInventory + totalInventry)
                if(totalInventry % 1 != 0)
                	totalInventry = totalInventry.toFixed(2);
                    
                    console.log('totalWarehourseInventory:',totalWarehourseInventory);
                warehouseInventoryDetails = warehouseInventoryDetails + '<div class="text__x-small text__grey uppercase"><span class="text__bold">' + totalInventry.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") +'</span> '+itemNm  +'</div>';
        	}
        });
		product.warehouseInventoryDetails = warehouseInventoryDetails + '';
        if(totalWarehourseInventory % 1 != 0)
			totalWarehourseInventory = totalWarehourseInventory.toFixed(2);
        product.totalWarehourseInventory = totalWarehourseInventory;
		
		c.set('v.product',product);
	},
    onProductClick: function(c, e, h){
        var product = c.get('v.product');

        console.log("product:", JSON.stringify(product, null, 2))
        console.log('isBrand:',c.get('v.isBrand'));
        $A.createComponent('c:productDetails', {
            product: product,
            brandId:c.get('v.brandId'),
            isBrand: c.get('v.isBrand'),
            isPublic:c.get('v.isPublic'),
            selectedCategory: c.get('v.selectedCategory'),
            fromPublicProducts: c.get('v.fromPublicProducts'),
            isModalDisplay: true
        }, function(content, status) {
            if (status === 'SUCCESS') {
                c.find('overlay').showCustomModal({
                    // header: product.name,
                    body: content,
                    showCloseButton: true,
                    cssClass: 'cUtility fix-close-button productDetailsModal'
                });
            }
        });
    },
    onProductDetails: function(c, e, h){
        var preview = c.find('preview').getElement()
        var compliance = c.find('compliance').getElement()
        var addcard = c.find('addcard').getElement()

        if (
            preview.contains(e.target) ||
            compliance.contains(e.target) ||
            addcard.contains(e.target)
        ) return

        console.log('isPublic::',c.get('v.isPublic'));
        var product = c.get('v.product');
        var brd = sessionStorage.getItem('breadCrumb');
        console.log('brd:',brd);
        if(brd){
            brd = JSON.parse(brd);
            brd.breadCrumbString += ' > '+product.shortDescrption;
            brd.breadCrumbIds+=' > ';
            sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}));
            $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}).fire();
        }
        sessionStorage.setItem('pricebookEntry', product.price.id);
        if(c.get('v.isPublic')){
            h.redirect('/filigreenproduct', true);
        }else{
            let fromPublicProducts = c.get('v.fromPublicProducts');
            if(fromPublicProducts){
                h.redirect('/brandProduct?id='+product.encryptPriceBookId+'&brandId='+c.get('v.brandId'), false);    
            } else {
				h.redirect('/product', true);                
            }
        }
    },
    onViewCompliance:function(c,e,h){
        var product = c.get('v.product');
        if(product.complianceFileId){
            try{
                var complianceFileIds = product.complianceFileId.split(',');
                console.log('complianceFileIds = '+complianceFileIds.slice(0, -1));
                $A.get('e.lightning:openFiles').fire({
                    recordIds: complianceFileIds.slice(0, -1)
                });
            } catch(error){
                console.log('Error = '+complianceFileIds);
            }
        }
    }
})