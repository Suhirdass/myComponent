({
	saveProduct : function(c,status) {
        var h = this;
		try {
            var successTitle = (status == 'Draft'?'saved':'submitted');
            c.set('v.successTitle',successTitle);
			var product = c.get('v.product');
            var isParentValid = true;
            console.log('product:',product);
            if(!product.isActive && product.status != 'Pending'){
            	isParentValid = h.isValid(c); 
                
                var MSLines = c.find('multiSelect');
                console.log('MSLines::',MSLines);
                var isMSValid;
                isMSValid = [].concat(MSLines).reduce(function (validSoFar, MS) {
                    const isV = MS.validate();
                    return validSoFar && isV;
                }, true);
                if(!isMSValid){
                    return false;
                }
            }
            
            
            if(c.get('v.applyCultivationTaxToggle')){
                if(product.isFlowers && product.isLeaves && product.isFresh){
                    h.error({ message: 'Cultivation Tax combination not allowed.' });
                    isParentValid  = false;
                }else if(!product.isFlowers && !product.isLeaves && !product.isFresh){
                    h.error({ message: 'Atleast one Cultivation Tax type should be selected.' });
                    isParentValid  = false;
                } else {
                    if(product.isFresh && product.isLeaves){
                        h.error({ message: 'Cultivation Tax combination not allowed.' });
                        isParentValid  = false;                    
                    } else if(product.isFresh && product.isFlowers){
                        h.error({ message: 'Cultivation Tax combination not allowed.' });
                        isParentValid  = false;                    
                    } else if(product.isFlowers && product.isLeaves){
                        product.cannabisCategory1 = 'Flower';
                        product.unitCannabisWeight1 = product.flowersGrams;
                        product.cannabisRatio1 = 50;
                        product.cannabisCategory2 = 'Leaves';
                        product.unitCannabisWeight2 = product.leavesGrams;
                        product.cannabisRatio2 = 50;
                        product.freshGrams = null;
                    } else if(product.isFlowers){
                        product.cannabisCategory1 = 'Flower';
                        product.cannabisRatio1 = 100;
                        product.unitCannabisWeight1 = product.flowersGrams;
                        product.leavesGrams = null;
                        product.freshGrams = null;
                    } else if(product.isLeaves){
                        product.cannabisCategory1 = 'Leaves';
                        product.cannabisRatio1 = 100;
                        product.unitCannabisWeight1 = product.leavesGrams;
                        product.flowersGrams = null;
                        product.freshGrams = null;
                    } else if(product.isFresh){
                        product.cannabisCategory1 = 'Fresh';
                        product.cannabisRatio1 = 100;
                        product.unitCannabisWeight1 = product.freshGrams;
                        product.flowersGrams = null;
                        product.leavesGrams = null;
                    }
                    product.cannabisWeightUOM = 'GM';
                }
            }
            
			console.log('Product::', JSON.stringify(c.get('v.product')));
            
			var accountCustomLookup = c.find('accountCustomLookup');
			var strainCustomLookup = c.find('strainCustomLookup');
			console.log('accountCustomLookup::', JSON.stringify(accountCustomLookup));
			console.log('strainCustomLookup::', JSON.stringify(strainCustomLookup));
			/*isValid = [].concat(customLookups).reduce(function (validSoFar, customLookup) {
                console.log("customLookups::",JSON.stringify(customLookup));
                console.log("Valid::",validSoFar && customLookup.validate());
                return validSoFar && customLookup.validate();
            }, true);*/
			if (product.producerId === undefined || product.producerId === '') {
				h.error({ message: 'Producer Name is required field.' });
				return false;
			}
			if (product.strainId === undefined || product.strainId === '') {
				h.error({ message: 'Strain is required field.' });
				return false;
			}
			if (!isParentValid) {
				return false;
			}
            var product = c.get('v.product');
            product.status = status;
            
            if(product.safetyStockMedium == ''){
                product.safetyStockMedium = null;
            }
            if(product.safetyStockLow == ''){
                product.safetyStockLow = null;
            }
            
            
            product.applyCultivationTax = c.get('v.applyCultivationTaxToggle')?'Yes':'No';
            h.request(c,'saveNewProduct',{recordId: c.get('v.recordId'),newProductData: JSON.stringify(product),},function (r) {
                console.log('saveNewProduct:::', r);
                c.set('v.isSuccess',true);
                window.setTimeout($A.getCallback(function(){
                    const modal = document.getElementById('success-modal');
                    if (modal) modal.classList.add('is-active');
                }),100)
                //h.success({ message: 'New Product Request ' + (c.get('v.recordId') ? 'updated ' : 'created') + ' successfully.',});
                //h.redirect('/product-list', true);
            },{handleErrors:false,error:function(err){
                var message = err[0].message;
                console.log(message);
                message = message.substr(message.indexOf('Product'))
                const recordId = message.substr(message.indexOf('<a href=')+9,18);
                const htmlText = message.substr(message.indexOf(' in record'));
                let finalText = message.replace(htmlText,'')
                h.error({message:finalText});
            }});
        } catch (error) {
            console.log('Error:', error);
        }
	}
})