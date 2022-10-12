({
    addToCart: function(c, isSample) {
        var h = this;
        var product = c.get('v.product');
        var quantity = c.get('v.quantity');
        var isBrand =c.get('v.isBrand');
        if(quantity < 1 && !isSample){
            h.error({message: 'Please provide quantity.'}); 
            return;
        }
        let productIdRec;
        let pricebookIdRec;
        if(isSample){
            quantity = 1; 
            /*if(isBrand){
                productIdRec = product.id;
                pricebookIdRec = product.price.id;
            }else{*/
                productIdRec = product.sampleProduct.id;
                pricebookIdRec = product.sampleProduct.price.id;
            //}
        } else {
        	productIdRec = product.id;
            pricebookIdRec = product.price.id;
        }
        
        var isUpdate = c.get('v.isUpdate');
        
        let uPrice = product.price.unitPrice;
        if(product.discount > 0){
            uPrice = product.salePrice;
        }
        console.log('uPrice = ',product.MOQ);
        console.log('uPrice = ',product.availableQty / product.MOQ);
        console.log('totalWarehourseInventory = ',product.totalWarehourseInventory);
        if(product.totalWarehourseInventory < quantity ||( product.availableQty < 0 ||product.availableQty == 0)){
                	h.error({ message: 'Order Qty (Cases) is greater than Available Qty.',});       
            		return;	        
                } 
        if(isSample)
            uPrice = 0.01;
        console.log('isDiscountProduct = ',product.isDiscountProduct);
        var addToCartData = {productId: productIdRec,
                             pricebookId: pricebookIdRec,
                             quantity:  quantity,
                             MOQ: product.MOQ,
                             unitPrice: uPrice,
                             isDiscountProduct:product.isDiscountProduct,
                             isBulkProduct:product.isBulkProduct,
                             isUpdate: isUpdate,
                             isSample: isSample,
                             isPromo: false};
        h.request(c, 'addToCart', {addToCartData: JSON.stringify(addToCartData)}, function(r){
            console.log('quantity='+r.quantity);
            h.success({message: ((isUpdate)? 'Product quantity updated successfully!': 'Product was successfully added to cart!')});
            c.set('v.updated', Date.now());
            $A.get('e.c:updateCartTotalEvt').setParams({cartTotal: r.quantity}).fire();
        });
	}
})