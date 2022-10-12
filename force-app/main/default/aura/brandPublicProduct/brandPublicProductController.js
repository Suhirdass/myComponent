({
    onInit: function (c, e, h) {
        console.log("onInit:",c.get('v.isBrand'));
        
        var fromBrandProduct = sessionStorage.getItem('fromBrandProduct');
        fromBrandProduct = fromBrandProduct != null && fromBrandProduct != undefined ? fromBrandProduct : 'false';
        c.set('v.fromBrandProduct',fromBrandProduct);
        
        var query = location.search.substr(1);
        console.log('query'+query);
        var result = {};
        query.split("&").forEach(function(part) {
            var item = part.split("=");
            result[item[0]] = decodeURIComponent(item[1]);
        });
		console.log('doInit::',result.id);
        
        h.request(c, 'getProductAndReviews', { id: result.id, brndId: result.brandId, reviewsLimit: 5}, function (r) {
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
            c.set('v.isDataLoaded',true);   
            window.setTimeout($A.getCallback(function(){
            	$('#myimage').zoom();
            }),100);
        });
	},
	zoomIn: function (c, e, h) {
        console.log("zoomIn");
        var element = document.getElementById("myresult");
        element.style.display = "inline-block";
        element = document.getElementById("img-zoom-lens");
        element.style.display = "inline-block";
        h.imageZoom('myimage','myresult');
        /*var img = document.getElementById("imgZoom").getBoundingClientRect() ;
        console.log("e.offsetX",e.offsetX);
        console.log("e.offsetY",e.offsetY);
        var posX =  e.pageX - img.left;
        var posY = e.pageY - img.top;
        console.log("posX:posY",posX,':',posY);
        element.style.backgroundPosition = (-posX *4) + "px " + (-posY * 4) + "px";*/
    },
	zoomOut: function (c, e, h) {
        e.stopPropagation();
        console.log("zoomOut",e.srcElement.id);
        if(e.srcElement.id !== 'myimage'){
            var element = document.getElementById("myresult");
            element.style.display = "none";
            element = document.getElementById("img-zoom-lens");
            element.style.display = "none";
        }
	},
	onScriptsLoaded: function (c, e, h) {
        console.log("applying Zoom");
        try{
            window.setTimeout($A.getCallback(function(){
                $('#myimage').zoom();
            }),100);
        }catch(error){
            console.log("Zoom error");
        }
    },
    onProductDetails: function(c, e, h) {
        e.preventDefault();
        var product = c.get('v.product');
        sessionStorage.setItem('pricebookEntry', product.price.id);

        if(c.get('v.isPublic')){
            h.redirect('/filigreenproduct', true);
        }else{
            h.redirect('/product', true);
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