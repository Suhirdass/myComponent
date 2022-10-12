({
    onInit: function (c, e, h) {
        var today = new Date();
        c.set('v.today',today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate());
		var filters = { orderByField: 'Product2.Name', isASC: true};
        c.set('v.filters', filters);
        
        var LicenseAddress=sessionStorage.getItem('LicenseAddress');
        console.log('LicenseAddress',LicenseAddress);
        h.request(c, 'getCartItems', {}, function (r) {
            console.log("getCartItems::",r);
            h.setData(c, r);
            h.getIds(c, filters);
        	h.setPagination(c, e, h);
            if(LicenseAddress != 'undefined'){
                var existingAddresses = c.get('v.existingAddresses');
                var addressId = LicenseAddress; 
                
                for(var i =0; i<existingAddresses.length;i++){
                    if(addressId === existingAddresses[i].id){
                        existingAddresses[i].isSelected = true;
                    }else{
                        existingAddresses[i].isSelected = false;
                        existingAddresses[i].excludeExciseTax = false;
                    }
                }
        		c.set('v.existingAddresses',existingAddresses);
                sessionStorage.setItem('LicenseAddress', 'undefined');
            }
        });
    },
    handleTimePickerEvent: function(c, e, h) {
        let selectedTime = e.getParam("selectedTime");
        let fieldName = e.getParam("fieldName");
        console.log('selectedTime = ',selectedTime);
        console.log('fieldName = ',fieldName);
        c.set('v.'+fieldName,selectedTime);
    },
    onViewRetailer: function (c, e,h) {
        var retailerId = e.currentTarget.dataset.id;  
        console.log(retailerId);
        sessionStorage.setItem('retailerId', retailerId);
    },
    
    onChangeSearchProduct: function (c, e,h){
        var searchInput = c.find('searchRec');
        var searchText = searchInput.getElement().value;
        c.set('v.searchString',searchText);
        
        let tabName = c.get('v.activeTab');
        if(tabName == 'all'){
            var filters = { orderByField: 'Product2.Name', isASC: true, searchTerm: searchText};
            h.getIds(c,filters);
        } else {
            let items = c.get('v.allItems');
            var filters = { orderByField: 'Product2.Name', isASC: true };
            let setOfIds = [];
            items.forEach((itemRec) => {
                if(searchText != ''){
                	var a = ''+itemRec.price.unitPrice;
                	var b = ''+searchText;
                	if(itemRec.shortDescription != undefined && itemRec.shortDescription.toLowerCase().includes(searchText.toLowerCase())){
                        setOfIds.push(itemRec.price.id);
                    } else if(itemRec.name != undefined && itemRec.name.toLowerCase().includes(searchText.toLowerCase())){
                        setOfIds.push(itemRec.price.id);
                    } else if(a != undefined && a.includes(b)){
                        setOfIds.push(itemRec.price.id);
                    }
            	} else{
                	setOfIds.push(itemRec.price.id);
                }
            });
            h.initPagination(c, setOfIds, filters,'paginatorActive');
        }
    },
    
    setActiveTab: function (c, e,h) {
		var tab = e.getSource().getLocalId();
        console.log(tab);
		c.set('v.activeTab', tab);
        c.set('v.searchString','');
        if(tab == 'all'){
        	var filters = { orderByField: 'Product2.Name', isASC: true};
            h.getIds(c,filters);    
        } else {
            h.setPagination(c, e,h);
        }
	},
    
    fetchProducts: function (c, e, h) {
        var ids = e.getParam('ids');
        console.log('fetchProducts ids::',ids);
        let tabName = c.get('v.activeTab');
        var filters = { orderByField: 'Product2.Name', isASC: true };
        var arr = [];
        if(tabName == 'all'){
			h.getProducts(c, ids);            
        } else {
            let items = c.get('v.allItems');
            for(let i = 0; i< items.length; i++){
                if(items[i].price.id != undefined && ids.includes(items[i].price.id)){
                    arr.push(items[i]);
                }
            }
            c.set('v.items',arr);
            //h.setPagination(c, e, h);
            //h.initPagination(c, ids, filters,'paginatorActive');
        }
    },
    
    onExpendCollapse: function(c, e, h) {
        let isExpended = c.get('v.isExpended');
        if(isExpended){
            c.set('v.isExpended',false);
        } else {
            c.set('v.isExpended',true);
        }
    },
    onCancel: function (c, e, h) {
        window.setTimeout($A.getCallback(function(){
            h.updateBreadCrumb(c,'Home');
        }),100)
        
        h.redirect('/', true);
    },
    onScriptsLoaded: function(c, e, h) {
        console.log('onScriptsLoaded...');
        h.applyDate(c);
    },  
    showDatePicker: function(c, e, h) {
        //$("#datepickerId").show(); 
        $("#datepickerId").datepicker("show");
    },
    onProductRemove: function (c, e, h) {
        try{
            var dataset = e.currentTarget.dataset;
            console.log('Product Id:',dataset.id);
            h.request(c, 'removeProduct', { productId: dataset.id }, function (r) {
                console.log('Response:',r);
                h.setData(c, r);
                h.success({ message: 'Product removed successfully.' });
                h.setPagination(c, e, h);
            });
            
        }catch(err){
            console.log('Error:',err);
        }
    },
    onRetailerChange: function (c, e, h) {
        try{
            var retailerId = e.getSource().get('v.value');
            console.log("retailerId:",retailerId);
            var retailersDetailMap = c.get('v.retailersDetail');
            console.log("retailersDetailMap:",retailersDetailMap);
            var retailersDetail = retailersDetailMap[retailerId];
            console.log("retailersDetail:",retailersDetail);
            var licenses = [];
            var contacts = [];
            var statelicenses = {};
            licenses = retailersDetail.licenses;
            statelicenses = retailersDetail.statelicenses;
            contacts = retailersDetail.contacts;
            c.set('v.licenses', licenses);
            c.set('v.contacts', contacts);
            c.set('v.statelicenses', statelicenses);  
            c.set('v.existingAddresses', statelicenses);
        }catch(err){
            console.log("Error:",err);
        }
        
    },
    onProductClick: function (c, e, h) {
       var dataset = e.currentTarget.dataset;
        //sessionStorage.setItem('pricebookEntry', dataset.id);
        //h.redirect('/product', true);
        $A.createComponent('c:productDetails', {
            priceId: dataset.id,
            brandId:'',
            isBrand: true,
            isPublic:false,
            fromPublicProducts: false,
            fromOnClickProduct:true,
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
    onChangeExcludeExciseTax: function (c, e, h) {
        console.log("checked:",e.getSource().get('v.checked'));
        c.set('v.excludeExciseTax',e.getSource().get('v.checked'));
        var existingAddresses = c.get('v.existingAddresses');
        var addressId = e.getSource().get('v.value'); 
        	
        for(var i =0; i<existingAddresses.length;i++){
            if(addressId === existingAddresses[i].id){
                existingAddresses[i].isSelected = true;
            }else{
                existingAddresses[i].isSelected = false;
                existingAddresses[i].excludeExciseTax = false;
            }
        }
        c.set('v.existingAddresses',existingAddresses);
    },
    onAddressSelection: function (c, e, h) {
        var existingAddresses = c.get('v.existingAddresses');
        console.log("checked:",e.getSource().get('v.checked'));
        var addressId = e.getSource().get('v.value');
        for(var i =0; i<existingAddresses.length;i++){
            if(addressId === existingAddresses[i].id){
                existingAddresses[i].isSelected = true;
                console.log('existingAddresses[i]:',existingAddresses[i]);
            }else{
                existingAddresses[i].isSelected = false;
                existingAddresses[i].excludeExciseTax = false;
            }
        }
        console.log("Value:",addressId);
        c.set('v.existingAddresses',existingAddresses);
        c.set('v.excludeExciseTax',false);
        console.log("existingAddresses:",c.get('v.existingAddresses'));
    },
    
    onContinueShopping: function (c, e, h) {
        h.redirect('/products', true);
    },
    
    handleNumberEvent :  function (c, e, h) {
    	var listSelectedItems = c.get("v.lstSelectedRecords");
        var recordId = e.getParam("recordId");
        var currentValue = e.getParam("currentValue");
        if(c.get('v.activeTab') != 'all'){
            let items = c.get('v.items');
            items.forEach((item) => {
                if(item.id == recordId){
                	console.log('Item = ',item);
                	item.quantity = currentValue;
                    if(currentValue <= 0){
                        c.set('v.qtyTooLow',true);
                    }
                	var addToCartData = {productId: recordId,
                             pricebookId: item.pricebookId,
                             quantity:  currentValue,
                             MOQ: item.MOQ,
                             unitPrice: item.price.unitPrice,
                             isUpdate: true,
                             isSample: item.isSample};
                    h.request(c, 'addToCart', {addToCartData: JSON.stringify(addToCartData)}, function(r){
                        console.log('quantity='+r.quantity);
                		c.set('v.cartTotal', r.cartTotal); 
                        c.set('v.exciseTax', r.exciseTax);
                        c.set('v.subTotal', r.subTotal);
                		c.set('v.total', r.total);
                	});
            	}
            });
            c.set('v.items',items);
        } else {
            let products = c.get('v.records');
            products.forEach((item) => {
                if(item.id == recordId){
                    console.log('SFFFF');
                    item.quantity = currentValue;
                    if(currentValue <= 0){
                        c.set('v.qtyTooLow',true);
                    }
            	}
            });
            c.set('v.records',products);
        }
    },  
    
    addToProduct: function (c, e, h){
        c.set('v.qtyTooLow',false);
        var dataset = e.currentTarget.dataset;
        var productId = dataset.productid;
        let qty = 1;
        var isError = false;
        let products = c.get('v.records');
        products.forEach((item) => {
            if(item.id == productId){
            	qty = item.quantity;
            	if(qty > item.availableQty){
            		isError= true;	
        		}
             }
        });        
        console.log('qty = ',qty);
        console.log('isError = ',isError);
        
        if(isError){
            h.error({ message: 'Order Qty (Cases) is greater than Available Qty',});
        } else if(String(qty).indexOf('\.') >= 0){
            h.error({ message: 'Quantity is not valid.',});
        }else if(qty <= 0){
            c.set('v.qtyTooLow',true);
        }else {
            var product = undefined;
            for (var i = 0; i < products.length; i++) {
                if (products[i].id == productId) {
                    product = products[i];
                    break;
                }
            }
            console.log('product.isSample =',product.isSample);
            var addToCartData = {productId: product.id,
                                 pricebookId: product.price.id,
                                 quantity:  qty,
                                 MOQ: product.MOQ,
                                 unitPrice: product.price.unitPrice,
                                 isUpdate: false,
                                 isSample: false};
            
            h.request(c, 'addToCart', {addToCartData: JSON.stringify(addToCartData)}, function(r){
                console.log('quantity=');
                h.request(c, 'getCartItems', {}, function (r) {
                    console.log("getCartItems::",r);
                    h.setData(c, r);
                    let items = r.items;
                    let setOfIds = [];
                    items.forEach((itemRec) => {
            			setOfIds.push(itemRec.price.id);
            		});
                    let allIds = c.get('v.allIds');
                    let pbIdsFinal = [];    
                    allIds.forEach((itemId) => {
                        //if(!setOfIds.includes(itemId)){
                            pbIdsFinal.push(itemId);
                        //}
                    });
                    var filters = { orderByField: 'Product2.Name', isASC: true};    
                    //h.initPagination(c, pbIdsFinal, filters);
                });
            });
        }
    },
    
    onCheckout: function (c, e, h) {
        console.log("existingAddresses:",c.get('v.existingAddresses'));
        let buttonStatus = e.getSource().getLocalId();
        c.set('v.buttonStatus',buttonStatus);
        
        var existingAddresses = c.get('v.existingAddresses');
        var hasAddress = false;
        var address = {};
        for(var i =0; i<existingAddresses.length;i++){
            if(existingAddresses[i].isSelected){
                hasAddress = true;
                address = existingAddresses[i];
                break;
            }
        }
        if(!hasAddress){
            h.error({ message: 'Please select Site Address!' });
        }else{
            var shipDate = c.get('v.requestShipDate');
            var shipEarlistTime = c.get('v.requestShipEarliestTime');
            var shipLatestTime = c.get('v.requestShipLatestTime');
            if(shipDate == null || shipDate == '' || shipEarlistTime == null || shipEarlistTime == '' || shipLatestTime == null || shipLatestTime == ''){
                h.error({ message: 'Please select Request Ship Date and Time window.' });
            }else{
                console.log('shipLatestTime:',shipLatestTime,'==shipEarlistTime:',shipEarlistTime);
                const lastTimes = shipLatestTime.split(':');
                const earliestTimes = shipEarlistTime.split(':');
                if(parseInt(lastTimes[0]) < parseInt(earliestTimes[0])){
                    h.error({ message: 'Delivery Latest Time cannot be before  Delivery Earliest Time.' });
                }else{
                    h.request(c, 'verifyProductsAvailability', {siteId:address.siteId}, function (r) {
                        console.log("verifyProductsAvailability:::",r);
                        h.oncheckout(c,address,buttonStatus);
                    })
                }
                /*if(shipLatestTime <  shipEarlistTime){
                    h.error({ message: 'Delivery Latest Time cannot be before  Delivery Earliest Time.' });
                }else{
                    h.request(c, 'verifyProductsAvailability', {}, function (r) {
                        console.log("verifyProductsAvailability:::",r);
                        h.oncheckout(c,address,buttonStatus);
                    })
                }*/
            }
        }
        /*h.request(c, 'verifyProductsAvailability', {}, function (r) {
      h.redirect('/address', true);
    });*/
  },
    onTermsAndCondition:function(c,e,h){
        c.set('v.acceptTerms',true);
        $A.createComponents([['c:termsAndConditions', { termsAndConditions: c.get('v.termsAndConditions') }], ['c:termsAndConditionsActions', {}]], function (contents, status) {
            if (status === 'SUCCESS') {
                c.find('overlay').showCustomModal({
                    body: contents[0],
                    showCloseButton: false,
                    cssClass: 'cUtility slds-modal_medium'
                });
            }
        });
    }
})