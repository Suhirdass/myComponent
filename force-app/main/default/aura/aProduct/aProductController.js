({
    onProductClick: function (c, e, h) {
        var pricebookid = e.target.dataset.id;
        var name = e.target.dataset.name;
        var brd = sessionStorage.getItem('breadCrumb');
        console.log('brd:',brd);
        if(brd){
            brd = JSON.parse(brd);
            brd.breadCrumbString = brd.breadCrumbString.replace(brd.breadCrumbString.substr(brd.breadCrumbString.lastIndexOf('> ')+2,brd.breadCrumbString.length),name);
            console.log('brd.breadCrumbString:',brd.breadCrumbString);
            //brd.breadCrumbString += ' > '+name;
            //brd.breadCrumbIds+=' > ';
            sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}));
            $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}).fire();
        }
        sessionStorage.setItem('pricebookEntry', pricebookid);
        h.redirect('/product', true);
    },
    onInit: function (c, e, h) {
        console.log("onInit:");
        c.set('v.recordId', sessionStorage.getItem('pricebookEntry'));
         
        h.request(c, 'getProductAndReviews', { id: c.get('v.recordId'), reviewsLimit: 5 }, function (r) {
            var product = r.product;
            c.set('v.isBrand', r.isBrand);
            console.log('product = ',product);
            let isDisableProduct = true;
            
            r.productFamilies.forEach((family) => {
                if(family == product.productFamily){
                	isDisableProduct = false;
            	}  
            });
            product.isDisableProduct = isDisableProduct;
            console.log('isDisableProduct = ',isDisableProduct);
            
            var warehouseTotalOrderedMap = r.warehouseTotalOrderedMap;
            var availableInventories = product.availableInventories || [];
            var totalOrderedQty = 0;
            var totalWarehourseInventory = 0;
            var warehouseInventoryDetails = '';
            const mapOfLAUnits = new Map();
            
            availableInventories.forEach((item) => {                
                if(product && product.id){
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
                    totalInventry = totalInventry;// / product.MOQ; 
                    if(product.MOQ > 0)
                    	totalWarehourseInventory = totalWarehourseInventory + (totalInventry/ product.MOQ);
                    else
                    	totalWarehourseInventory = totalWarehourseInventory + totalInventry;
                    if(totalInventry % 1 != 0)
                    totalInventry = totalInventry.toFixed(2);
                    
                    warehouseInventoryDetails = warehouseInventoryDetails + '<div class="text__x-small text__grey uppercase"><span class="text__bold">' + totalInventry.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") +'</span> '+itemNm  +'</div>';
                }
                });
            product.warehouseInventoryDetails = warehouseInventoryDetails + '';
			if(totalWarehourseInventory % 1 != 0)
				totalWarehourseInventory = totalWarehourseInventory.toFixed(2);
            product.totalWarehourseInventory = totalWarehourseInventory;
            
                    c.set('v.product', product);
                    console.log("product::",r.product);
                    c.set('v.totalReviews', r.totalReviews);
                    c.set('v.ratingsSummary', r.ratingsSummary);
                    c.set('v.reviews', r.reviews);
                });
                    window.setTimeout($A.getCallback(function(){
                    var tab = c.getElement('description');
                    console.log('cc:',tab.clientHeight);
                    c.set('v.descriptionHeight',(tab.clientHeight-213-16)+'px');
                }),1000)
                    h.getFeatureProducts(c);
                },
                    onScriptsLoaded: function (c, e, h) {
                        console.log("onScriptsLoaded");
                        
                        h.applyZoom(c);
                    }
                    ,
                    onViewCompliance:function(c,e,h){
                        var product = c.get('v.product');
                        console.log("product::",product);
                        if(product.complianceFileId){
                            var complianceFileIds = product.complianceFileId.split(',');
                            $A.get('e.lightning:openFiles').fire({
                                recordIds: complianceFileIds.slice(0, -1)
                            });
                        }
                        /*c.find("navService").navigate({
            type: "standard__recordPage",
            attributes: {
                objectApiName: "Document",
                recordId: "015g0000000w4XjAAI",
                actionName: "view"
            }
        }, true);*/
                    },
                    onDuplicate: function (c, e, h) {
        var recordId = c.get('v.product');
         sessionStorage.setItem('isViewProductRequest',false);
        window.setTimeout($A.getCallback(function(){
            var AllBreadCrumb = sessionStorage.getItem('AllBreadCrumb');
        if(AllBreadCrumb){
            AllBreadCrumb = JSON.parse(AllBreadCrumb);
        }
        
        var screenName = 'Create New Product';
        var matchedMenu = AllBreadCrumb.find((menu) => {
            return menu.text == screenName;
        })
        console.log('screenName::',matchedMenu);
        if(matchedMenu){
            sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: matchedMenu.label, breadCrumbIds : matchedMenu.value}));
            $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: matchedMenu.label, breadCrumbIds : matchedMenu.value}).fire();
        }
        
        }),100);
                    sessionStorage.setItem('newProductRequestId', recordId.id);
        sessionStorage.setItem('isCloneProduct', 'True');
        h.redirect('/newproduct', true);
    },
                })