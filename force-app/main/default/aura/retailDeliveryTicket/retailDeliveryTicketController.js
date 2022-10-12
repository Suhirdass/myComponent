({
    recordIdChanges: function (c, e, h) {
        c.set('v.RDTRecordId', c.get('v.recordId'));
    },    
    onInit: function (c, e, h) {
        try {
            const userAgent = navigator.userAgent.toLowerCase();
            c.set('v.isTablet',/(ipad|tablet|(android(?!.*mobile))|(windows(?!.*phone)(.*touch))|kindle|playbook|silk|(puffin(?!.*(IP|AP|WP))))/.test(userAgent));
            c.set('v.recordId', sessionStorage.getItem('retailDeliveryTicketId'));
            console.log('Record Id:', c.get('v.recordId')); 
            var isClone=sessionStorage.getItem('isCloneOrder');
            var retailDeliveryTicketClone ='';
            var retailDeliveryTicketLineItemsClone ='';
            if(isClone == 'True'){
                c.set('v.isClone','True');
            	console.log(isClone,'##retailDeliveryTicket 11 :',sessionStorage.getItem('retailDeliveryTicket'));
                retailDeliveryTicketClone =sessionStorage.getItem('retailDeliveryTicket');
                retailDeliveryTicketLineItemsClone =sessionStorage.getItem('retailDeliveryTicketLineItems');
                console.log('##retailDeliveryTicketLineItemsClone 11 :',retailDeliveryTicketLineItemsClone);
                sessionStorage.setItem('isCloneOrder', 'False');
            }else{
               isClone='False' ;
            }
            // UI
            c.set('v.activeTab', 'all'); // Toggled with setActiveTab. Can be 'all' or 'active'            
            // Data binding
            h.request(c, 'init', { recordId: c.get('v.recordId'),"fromTransferOrders":false,retailDeliveryTicketData:retailDeliveryTicketClone,retailDeliveryTicketLineItemsData:retailDeliveryTicketLineItemsClone,isClone:isClone }, function (r) {
                var disableExcludeExciseTax = true;
                c.set(
                    'v.Additional_Brand_Contact_Help_Text',
                    r.Additional_Brand_Contact_Help_Text
                );
                console.log('SampleOrderFamilyMap', r.SampleOrderFamilyMap);
                
                c.set('v.Sample_Limitation_Error_Msg',r.Sample_Limitation_Error_Msg);
                
                var SampleOrderParentFamilyMap = r.SampleOrderParentFamilyMap;
                c.set('v.SampleOrderParentFamilyMap',SampleOrderParentFamilyMap);
                var SampleOrderFamilyMap = r.SampleOrderFamilyMap;
                c.set('v.SampleOrderFamilyMap',SampleOrderFamilyMap);
                
                var warehouseAvailableInventoryMap = r.warehouseAvailableInventoryMap
                c.set('v.warehouseAvailableInventoryMap',warehouseAvailableInventoryMap);
                var warehouseTotalOrderedMap = r.warehouseTotalOrderedMap;
                c.set('v.warehouseTotalOrderedMap', warehouseTotalOrderedMap);
                //c.set('v.licenses', r.licenses);                
                if(r.licenses != undefined){
                    let licenses = r.licenses;
                    let retailersDetailMap = r.retailersDetail;
                    let retailersDetail = retailersDetailMap[r.retailDeliveryTicket.retailer];
                    for(let i = 0;i<licenses.length;i++){
                        let s = licenses[i].address;
                        let lastIndex = s.lastIndexOf("-");
                        let s2 = s.substring(0,lastIndex);
                        let types = retailersDetail.typeMap;
                        for(let j = 0;j<types.length;j++){
                            if(licenses[i].id == types[j].id){
                                s2 += ' - ';
                                s2 += types[j].type;
                            }
                        }
                        licenses[i].address = s;
                        licenses[i].name = s;
                    }
                    c.set('v.licenses', licenses);
                }
                c.set('v.Sample_Products_tooltip',r.Sample_Products_tooltip);
                c.set('v.Msg_Exclude_Excise_Tax_Tooltip',r.Msg_Exclude_Excise_Tax_Tooltip);
                c.set('v.Msg_for_isSample_Tooltip',r.Msg_for_isSample_Tooltip);
                c.set('v.EARLIEST_DELIVERY_TIME',r.EARLIEST_DELIVERY_TIME);
            	c.set('v.LATEST_DELIVERY_TIME',r.LATEST_DELIVERY_TIME);
                c.set('v.Msg_for_Preapproved_Tooltip',r.Msg_for_Preapproved_Tooltip);
                c.set('v.Msg_for_isPromo_Tooltip',r.Msg_for_isPromo_Tooltip);
                c.set('v.Err_Msg_of_OLI_is_Promo',r.Err_Msg_of_OLI_is_Promo);
                c.set('v.Max_Discount_Value',r.MaxDiscountAmt);
                c.set('v.Warning_Message_Of_Minimum_Order_Value',r.Warning_Message_Of_Minimum_Order_Value);
                c.set('v.bulkProductErrorToolTip',r.bulkProductErrorToolTip);
                c.set('v.Total_product_amount_tooltip',r.Total_product_amount_tooltip);
                c.set('v.Err_Msg_Add_Atleat_One_OLI',r.ERR_MSG_ADD_ONE_OLI);
                c.set('v.Factoring_Contact_Required_For_Order',r.Factoring_Contact_Required_For_Order);
                c.set('v.Factoring_Terms_Required_For_Order',r.Factoring_Terms_Required_For_Order);
                c.set('v.ERR_MSG_ORDER_QTY_GT_AVAILABLE_QTY',r.ERR_MSG_ORDER_QTY_GT_AVAILABLE_QTY);
                c.set('v.Err_Msg_all_line_items_as_isSample',r.Err_Msg_all_line_items_as_isSample);
                c.set('v.statelicenses', r.statelicenses);
                c.set('v.commSetting', r.commSetting);
                r.paymentTerms.forEach((fa) => {
                    fa.id = fa.value;
                    fa.name = fa.label;
                });
                    c.set('v.paymentTerms', r.paymentTerms);
                    c.set('v.excludeExciseTaxTypes', r.excludeExciseTaxTypes);
                    c.set('v.excludeExciseTaxTypesText',r.excludeExciseTaxTypes.join(', '));
                    var products = r.products;
                    products.forEach((product) => {
                    let warehouseInventoryDetails = '';
                    let warehouseDetails = warehouseAvailableInventoryMap[product.id]||[];
                    warehouseDetails.forEach((item) => {
                    let key = item.id +'-'+product.id;
                    let totalOrderedQty = warehouseTotalOrderedMap[key] || 0;
                    if(item.name != undefined){
                    var itemName = item.name.split(',')[0];
                    var itemNameList = itemName.split(' ');
                    var itemNm = '';
                    itemNameList.forEach((nm) => {
                    itemNm += nm.substring(0,1);    
                });
                    let totalInventry = item.availableInventory - totalOrderedQty;
                    if(product.MOQ > 0)
                    totalInventry = totalInventry / product.MOQ; 
                    if(totalInventry % 1 != 0)
                    totalInventry = totalInventry.toFixed(4);                    
                    warehouseInventoryDetails = warehouseInventoryDetails + itemNm + ': ' + totalInventry + ' Cases<br>';
                }
                });
                    product.warehouseInventoryDetails = warehouseInventoryDetails;
                });
                    products = h.sortAllProducts(c, e, h,products,'ASC');
                    c.set('v.products', products);
                    console.log('product product',products);
                    c.set('v.allProducts', products);
                    c.set('v.completeProducts', products);                    
                    //c.set('v.contacts', r.brandContacts);
                    c.set('v.brandContacts', r.brandContacts);
                    c.set('v.salesReps', r.salesReps);
                    c.set('v.retailersDetail', r.retailersDetail);
                    c.set('v.Orders_Requiring_Third_Party_Scheduler',r.Orders_Requiring_Third_Party_Scheduler);
                    /*c.set('v.Orders_Requiring_TPS_and_or_QR_Code',r.Orders_Requiring_TPS_and_or_QR_Code);
                    c.set('v.Orders_Requiring_TPS_and_or_Bar_Code',r.Orders_Requiring_TPS_and_or_Bar_Code);
                    c.set('v.Orders_Requiring_TPS_and_Bar_Code_and_QR',r.Orders_Requiring_TPS_and_Bar_Code_and_QR);*/
                    c.set('v.Orders_Requiring_QR_Codes',r.Orders_Requiring_QR_Codes);
                    c.set('v.Orders_Requiring_Bar_Codes',r.Orders_Requiring_Bar_Codes);
                    c.set('v.Orders_Requiring_BarCodes_and_or_QR_Code',r.Orders_Requiring_BarCodes_and_or_QR_Code);
                    c.set('v.otherReletecContactIds', r.relatedContacts || []);
                    c.set('v.retailers', r.retailers);
                    c.set('v.newRDT', r.tmpRetailDeliveryTicketLineItem);
                    c.set('v.newRetailDeliveryTicket', r.retailDeliveryTicket);
                    c.set('v.productOrderedQtyMap', r.productOrderedQtyMap);
                    c.set('v.routeMiles', r.retailDeliveryTicket.Route_Miles);
                    c.set('v.cutOffTime', r.cutOffTime);
                    c.set('v.holidayList', r.holidayList);
                    c.set('v.learnMoreUrl', r.learnMoreUrl);
                    c.set('v.shippingToolTip', r.shippingToolTip);
                    c.set('v.distributionToolTip', r.distributionToolTip);
                    c.set('v.factoringDiscountToolTip', r.factoringDiscountToolTip);
                    c.set('v.factoringRelationships', r.factoringRelationships);
                    console.log('#####3 ',r.factoringRelationships);
                    c.set('v.factoringRelationshipContactsMap', r.factoringRelationshipContactsMap);
                    c.set('v.factoringRate',r.retailDeliveryTicket.factoringRate);
                    c.set('v.cliRegularProductWithSamplePrice',r.cliRegularProductWithSamplePrice);
                    var relatedContacts = r.relatedContacts || [];
                    var selectedContactIds = relatedContacts.length
                    ? r.retailDeliveryTicket.retailerContact + ';' + relatedContacts.join(';')
                    : r.retailDeliveryTicket.retailerContact;                    
                    c.set('v.selectedContactIds', selectedContactIds);
                    console.log('Data', c.get('v.selectedContactIds'));
                    console.log('Data2', r.retailDeliveryTicket);
                    var contactsOptions = [];
                    if (r.contacts && r.contacts.length) {
                    for (var i = 0; i < r.contacts.length; i++) {
                    contactsOptions.push({
                    label: r.contacts[i].name,
                    value: r.contacts[i].id,
                });
            }
                      }                      
                      c.set('v.contactsOptions', contactsOptions);
            if (r.retailDeliveryTicket.stateLicense && r.statelicenses[r.retailDeliveryTicket.stateLicense]) {
                var statelicense = r.statelicenses[r.retailDeliveryTicket.stateLicense].License_Type__c;
				//let addr = [r.retailDeliveryTicket.stateLicense];
				  
                let add = '';
                for(let i = 0; i< r.addresses.length ; i++){
                    console.log('KD ',r.addresses[i]);
                    if(r.addresses[i].id === r.retailDeliveryTicket.stateLicense){
                    	add = r.addresses[i].address;
                        break;
                    }
                }
                let rdt = r.retailDeliveryTicket;
                rdt.stateLicenseName = r.retailDeliveryTicket.stateLicenseName + ' | '+add;
                c.set('v.selectedWarehouse',r.statelicenses[r.retailDeliveryTicket.stateLicense].Default_Warehouse__c);
                c.set('v.retailDeliveryTicket', rdt);                
                var excludeExciseTaxTypes = c.get('v.excludeExciseTaxTypes');
                if (statelicense && excludeExciseTaxTypes.indexOf(statelicense) != -1) {
                    disableExcludeExciseTax = false;
                } else {
                    disableExcludeExciseTax = true;
                }
                c.set('v.disableExcludeExciseTax', disableExcludeExciseTax);
            }
            console.log('###newRetailDeliveryTicketLineItems :',r.retailDeliveryTicketLineItems.length);
            c.set('v.newRetailDeliveryTicketLineItems', r.retailDeliveryTicketLineItems);            
            var retailDeliveryTicket = r.retailDeliveryTicket;
            const factoringRate = retailDeliveryTicket.factoringRate||0;
            let grandTotal = 0;
            let totalExciseTax = 0;
            let subTotal = r.retailDeliveryTicketLineItems.reduce(
                (currentValue, item) => {
                    if (!retailDeliveryTicket.excludeExciseTax) {
                        if (!item.isSample && item.applyExciseTax != 'No') {
                            //totalExciseTax += parseFloat(item.salesPrice * item.orderQty * item.MOQ, 10) * 1.8 * 0.15;
                    totalExciseTax += item.isDiscountProduct?  parseFloat(((item.salesPrice * -1) * (1.8) * (0.15)),10).toFixed(3) * item.orderQty * item.MOQ : parseFloat((item.salesPrice * (1.8) * (0.15)),10).toFixed(3) * item.orderQty * item.MOQ;
                        }
                    }
                const tPrice = item.isDiscountProduct? -1 * parseFloat(item.salesPrice * item.orderQty * item.MOQ, 10) : parseFloat(item.salesPrice * item.orderQty * item.MOQ, 10)
                
                return (parseFloat(currentValue, 10) + tPrice);
            grandTotal = subTotal + totalExciseTax;
        },0.0
        );
        subTotal = subTotal.toFixed(2);
        /*if(subTotal == 0){
            totalExciseTax =0;
        }*/
        totalExciseTax = totalExciseTax.toFixed(3);
        var factoringDiscount  = (parseFloat(subTotal) + parseFloat(totalExciseTax)) * factoringRate / 100;    
        //grandTotal = parseFloat(subTotal) + parseFloat(totalExciseTax) - factoringDiscount;
        grandTotal = parseFloat(subTotal) + parseFloat(totalExciseTax);        
        console.log('##factoringDiscount::',factoringDiscount);
        c.set('v.factoringDiscount',factoringDiscount);
        c.set('v.grandTotal', grandTotal.toFixed(2));
        c.set('v.grandTotalDiscount', grandTotal);
        c.set('v.totalExcisetax', totalExciseTax);
        c.set('v.subTotal',subTotal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));        
        var retailDeliveryTicketLineItems = r.retailDeliveryTicketLineItems;
        var brandRetailDeliveryOrderItems = Object.keys(r.brandRetailDeliveryOrderItems);
        console.log('brandRetailDeliveryOrderItems::',brandRetailDeliveryOrderItems.length)
        if (brandRetailDeliveryOrderItems && brandRetailDeliveryOrderItems.length > 0) {
            retailDeliveryTicketLineItems = [];
            brandRetailDeliveryOrderItems.forEach(function (productId) {
                retailDeliveryTicketLineItems.push({
                    Product: productId.split('-')[0],
                    orderQty: r.brandRetailDeliveryOrderItems[productId].quantity,
                    imageUrl: r.brandRetailDeliveryOrderItems[productId].imageUrl,
                    description: r.brandRetailDeliveryOrderItems[productId].shortDesc,
                    productName: r.brandRetailDeliveryOrderItems[productId].name,
                    salesPrice: r.brandRetailDeliveryOrderItems[productId].unitPrice,
                    MOQ: r.brandRetailDeliveryOrderItems[productId].MOQ,
                    availableQty: r.brandRetailDeliveryOrderItems[productId].availableQty,
                    brandName: r.brandRetailDeliveryOrderItems[productId].brandName,
                    brandId: r.brandRetailDeliveryOrderItems[productId].brandId,
                    priceBookid: r.brandRetailDeliveryOrderItems[productId].priceBookId,
                    ProductBookEntryId: r.brandRetailDeliveryOrderItems[productId].priceBookId,
                    shortDescription: r.brandRetailDeliveryOrderItems[productId].shortDesc,
                    availableQty: r.brandRetailDeliveryOrderItems[productId].availableQty,
                    isSample: r.brandRetailDeliveryOrderItems[productId].isSample,
                    isPromo: r.brandRetailDeliveryOrderItems[productId].isPromo,
                    productRecordTypeName :r.brandRetailDeliveryOrderItems[productId].productRecordTypeName,
                    isProductSample: r.brandRetailDeliveryOrderItems[productId].isProductSample,
                    applyExciseTax: r.brandRetailDeliveryOrderItems[productId].applyExciseTax,
                    isDiscountProduct:r.brandRetailDeliveryOrderItems[productId].isDiscountProduct,
                    isBulkProduct:r.brandRetailDeliveryOrderItems[productId].isBulkProduct,
                    productFamily:r.brandRetailDeliveryOrderItems[productId].productFamily,
                });
            });
            console.log('retailDeliveryTicketLineItems',JSON.stringify(retailDeliveryTicketLineItems));
        }        
        retailDeliveryTicketLineItems.forEach(function (entry, index, object) {
            let warehouseInventoryDetails = '';
            let warehouseDetails = warehouseAvailableInventoryMap[entry.Product]||[];
            warehouseDetails.forEach((item) => {
                let key = item.id +'-'+entry.Product;
                let totalOrderedQty = warehouseTotalOrderedMap[key] || 0;
                if(item.name != undefined){
                var itemName = item.name.split(',')[0];
                var itemNameList = itemName.split(' ');
                var itemNm = '';
                itemNameList.forEach((nm) => {
                itemNm += nm.substring(0,1); 
            });
            let totalInventry = item.availableInventory - totalOrderedQty;
            if(entry.MOQ > 0)
                totalInventry = totalInventry / entry.MOQ; 
            if(totalInventry % 1 != 0)
                totalInventry = totalInventry.toFixed(4);
            warehouseInventoryDetails = warehouseInventoryDetails + itemNm + ': ' + totalInventry + ' Cases <br/>';
        }
                                              });
        entry.warehouseInventoryDetails = warehouseInventoryDetails;
    });
    c.set('v.newRetailDeliveryTicketLineItems',retailDeliveryTicketLineItems);
    if(retailDeliveryTicketLineItems.length > 0){
        let setOfIds = [];
        retailDeliveryTicketLineItems.forEach((itemRec) => {
            setOfIds.push(itemRec.Product);
        });
        let arr = [];
        let products = c.get('v.products');
        products.forEach((item) => {
            //if(!setOfIds.includes(item.id)){
            	arr.push(item);
        	//}
        });
		c.set('v.products',arr);   
	}
h.setPagination(c,e,h,true);
c.set('v.allNewRetailDeliveryTicketLineItems',retailDeliveryTicketLineItems);
c.set('v.completeRDTLineItems',retailDeliveryTicketLineItems);
h.calculateTotals(c);
if ((c.get('v.recordId') != '' && c.get('v.recordId') != undefined) || c.get('v.isClone') == 'True') {
    c.set('v.requestDateTimeHide',c.get('v.newRetailDeliveryTicket').requestShipDate);
            console.log('##isThird_Party_Scheduler : ',r.isThird_Party_Scheduler);
            var newRetailDeliveryTicket2 = c.get('v.newRetailDeliveryTicket') ; 
            if(r.isThird_Party_Scheduler){
            newRetailDeliveryTicket2.isSample = false;
            newRetailDeliveryTicket2.isPreapproved = false;
            
            c.set('v.isThird_Party_Scheduler',true);
            c.set('v.requestDateTime','');
            c.set('v.newRetailDeliveryTicket',newRetailDeliveryTicket2);
        }
             console.log('##isThird_Party_Scheduler : ',newRetailDeliveryTicket2.requestShipDate);
            if(c.get('v.isClone') != 'True' && !r.isThird_Party_Scheduler && newRetailDeliveryTicket2.requestShipDate != null){
            var reqDate = newRetailDeliveryTicket2.requestShipDate;
            var datearray = reqDate.split("-");
            reqDate = datearray[2] + '-' + datearray[0] + '-' + datearray[1];
            c.set('v.reqTempDate',reqDate);
            c.set('v.requestDateTime',reqDate);
        }
    
    c.set('v.Minimum_Order_Value',r.Minimum_Order_Value);
    h.processCalculations(c, false);
    h.populateFactoringAssignees(c);
    h.searchData(c, e);
    h.setPagination(c,e,h,false);
           
    if(r.retailDeliveryTicket.factoringAssigneeId){
        h.populateFactoringContacts(c,r.retailDeliveryTicket.factoringAssigneeId);
        h.populateFactoringTerms(c,r.retailDeliveryTicket.factoringAssigneeId);
        h.populateChangeValues(c,e,h);
    }
    
    c.set('v.isClone','False');
}
if(r.retailDeliveryTicket.retailer != '' && r.retailDeliveryTicket.retailer != undefined){    
    let retailersDetailMap = c.get('v.retailersDetail');
    let retailersDetail = retailersDetailMap[r.retailDeliveryTicket.retailer];
    let contacts = retailersDetail.contacts;
    console.log('retailersDetail = ',retailersDetail);
    c.set('v.contacts',contacts);
    h.setMsgValue(c, retailersDetail.retailer);    
} 
c.set('v.isDataLoaded',true);
window.setTimeout($A.getCallback(function(){
    c.set('v.initializationCompleted',true);
}),1000)
});
}catch (err) {
    console.log('Error:', err);
}	
},    
    onViewBrand:function(c,e,h){
        var brandId = e.currentTarget.dataset.id;
        sessionStorage.setItem('brandId', brandId);
        h.redirect('/brand', true);
    },        
        onProductDetail :function(c,e,h){
            var priceId = e.currentTarget.dataset.id; 
            console.log('priceId = ',priceId);
            /*sessionStorage.setItem('pricebookEntry', priceId);
            window.open('https://dev-filigreen.cs165.force.com/filigreenb2b/s/product?id='+priceId,'_blank');*/
            //https://dev-filigreen.cs165.force.com/filigreenb2b/s/product?id='+product.price.id
            //h.redirect('/product', true);
            /*let tabName = c.get('v.activeTab'); 
            var product ;
            if(tabName == 'all' ){ 
                let products = c.get('v.products');
                products.forEach((p) => {
                    if(p.price.id == priceId){
                    	product = p;
                	}
                });
            }else{
                let allNewRetailDeliveryTicketLineItems = c.get('v.newRetailDeliveryTicketLineItems');
                allNewRetailDeliveryTicketLineItems.forEach((p) => {
                    if(p.priceBookid == priceId){
                    	product = p;
                	}
                });
            }
         
        console.log("product:", JSON.stringify(product, null, 2))*/
        $A.createComponent('c:productDetails', {
            priceId: priceId,
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
            onSalesPriceBlur:function(c,e,h){
                var recordId = e.getSource().get("v.label");
				console.log("recordId:::", recordId);
                let tabName = c.get('v.activeTab'); 
                if(tabName == 'all' ){ 
                    let products = c.get('v.products');
                    let productsData = [];
                    products.forEach((p) => {
                        if(p.id == recordId){
                            if(p.actualSalesPrice > p.salePrice && p.isPromo != true && !p.isDiscountProduct){
                            	p.isLIPromo = true;
                        	}else{
                               p.isLIPromo = false;
                              } 
                        }
                                     productsData.push(p);
                    });
                    c.set('v.products',productsData);
                window.setTimeout(
                        $A.getCallback(function() {
                            h.setProductsIsLIPromo(c,productsData,false);
                        }), 2000
                    );
                }else{
                    var allNewRetailDeliveryTicketLineItems = c.get('v.newRetailDeliveryTicketLineItems');
            		let NewRetailDeliveryTicketLineItemsData = [];
            		let products = c.get('v.allProducts');
            		var product = [];
                        products.forEach((p) => {
            				if(p.id == recordId){
                        		product.push(p);
        					}
                   		 });
            		
                    allNewRetailDeliveryTicketLineItems.forEach((item) => {
                            if(item.Product == recordId){
                                if(product[0].actualSalesPrice > item.salesPrice && item.isPromo != true && !item.isDiscountProduct){
                                	item.isLIPromo = true;
                            	}else{
                                     item.isLIPromo = false;
                                }
                            }
                       NewRetailDeliveryTicketLineItemsData.push(item);
        			 });
					
                        c.set('v.newRetailDeliveryTicketLineItems',NewRetailDeliveryTicketLineItemsData);
                    //c.set('v.allNewRetailDeliveryTicketLineItems',NewRetailDeliveryTicketLineItemsData);
               		  window.setTimeout(
                        $A.getCallback(function() {
                            h.setProductsIsLIPromo(c,NewRetailDeliveryTicketLineItemsData,true);
                        }), 2000
                    );
                }
            },
            onSalesPriceChange: function (c, e, h) {
                h.calculateTotals(c);       
            },                
                onScriptsLoaded: function (c, e, h) {
                    
                    console.log('onScriptsLoaded...');
                    h.applyDate(c);
                   
                },                    
                    calculateExcludeTex: function (c, e, h) {
                        var response = e.getSource().get('v.checked');
                        var allNewRetailDeliveryTicketLineItems = c.get('v.allNewRetailDeliveryTicketLineItems');        
                        var newRDT = c.get('v.newRetailDeliveryTicket');
                        newRDT.excludeExciseTax = response;
                        c.set('v.newRetailDeliveryTicket',newRDT);        
                        let grandTotal = 0;
                        let subTotal = 0;
                        let totalExciseTax = 0;
                        allNewRetailDeliveryTicketLineItems.forEach(function (entry, index, object) {
                            if (entry.Product) {
                                if(entry.isDiscountProduct){
                                    subTotal -= entry.MOQ * entry.orderQty * entry.salesPrice ;
                                }else{
                                    subTotal += entry.MOQ * entry.orderQty * entry.salesPrice ;
                                }
                                //subTotal += entry.MOQ * entry.orderQty * entry.salesPrice;
                                if (!response) {
                                    if (!entry.isSample && entry.applyExciseTax != 'No') {
                                        //totalExciseTax += parseFloat(entry.salesPrice * entry.orderQty * entry.MOQ, 10) * 1.8 * 0.15;
                                        //totalExciseTax += parseFloat((entry.salesPrice * (1.8) * (0.15)),10).toFixed(2) * entry.orderQty * entry.MOQ;
                                        totalExciseTax += entry.isDiscountProduct? parseFloat(((entry.salesPrice * -1) * (1.8) * (0.15)),10).toFixed(3) * entry.orderQty * entry.MOQ : parseFloat((entry.salesPrice * (1.8) * (0.15)),10).toFixed(3) * entry.orderQty * entry.MOQ;
                                    }
                                }
                            }
                        });                        
                        grandTotal = subTotal + totalExciseTax;
                        /*if(subTotal == 0){
            totalExciseTax =0;
        }*/
                        subTotal = subTotal.toFixed(2);
                        totalExciseTax = totalExciseTax.toFixed(3);
                        //subTotal = subTotal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',').toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');                        
                        c.set('v.totalExcisetax', totalExciseTax);
                        c.set('v.grandTotal', grandTotal.toFixed(2));
                        c.set('v.subTotal', subTotal);
                        h.calculateTotals(c);
                    },                        
                        showDatePicker: function (c, e, h) {
                            //$("#datepickerId").show();
                            $('#datepickerId').datepicker('show');
                        },                            
                            calculateServiceFee: function (c, e, h) {
                                h.processCalculations(c, true);
                            },                                
                                updateSubTotal: function (c, e, h) {
                                    console.log('updateSubTotal...');
                                    c.set('v.isEnable', false);
                                    var allNewRetailDeliveryTicketLineItems = c.get(
                                        'v.allNewRetailDeliveryTicketLineItems'
                                    );
                                    var newRetailDeliveryTicket = c.get('v.newRetailDeliveryTicket');        
                                    let subTotal = 0;
                                    let grandTotal = 0;
                                    let totalExciseTax = 0;
                                    allNewRetailDeliveryTicketLineItems.forEach(function (entry, index, object) {
                                        if (entry.Product) {
                                            if(entry.isDiscountProduct){
                                                subTotal -= entry.MOQ * entry.orderQty * entry.salesPrice ;
                                            }else{
                                                subTotal += entry.MOQ * entry.orderQty * entry.salesPrice ;
                                            }
                                            if (!newRetailDeliveryTicket.excludeExciseTax) {
                                                if (!entry.isSample && entry.applyExciseTax != 'No') {
                                                    console.log('OLI:', entry);
                                                    /*totalExciseTax +=
							parseFloat(entry.salesPrice * entry.orderQty * entry.MOQ, 10) *
							1.8 *
							0.15;*/
                        //totalExciseTax += parseFloat((entry.salesPrice * (1.8) * (0.15)),10).toFixed(2) * entry.orderQty * entry.MOQ;
                        totalExciseTax += entry.isDiscountProduct? parseFloat(((entry.salesPrice * -1) * (1.8) * (0.15)),10).toFixed(3) * entry.orderQty * entry.MOQ : parseFloat((entry.salesPrice * (1.8) * (0.15)),10).toFixed(3) * entry.orderQty * entry.MOQ;
                    }
                }
            }
        });
        /*let subTotal = newRetailDeliveryTicketLineItems.reduce((currentValue,item) => {
            return parseFloat(currentValue,10) + parseFloat((item.salesPrice * item.orderQty*item.MOQ),10)
				},0.00)*/
        grandTotal = subTotal + totalExciseTax;
        subTotal = subTotal.toFixed(2);
                                    /*if(subTotal == 0){
            totalExciseTax =0;
        }*/
        totalExciseTax = totalExciseTax.toFixed(3);
        /*subTotal = subTotal
			.toString()
			.replace(/\B(?=(\d{3})+(?!\d))/g, ',')
			.toString()
			.replace(/\B(?=(\d{3})+(?!\d))/g, ',');*/        
        c.set('v.totalExcisetax', totalExciseTax);
        c.set('v.grandTotal', grandTotal.toFixed(2));
        c.set('v.subTotal', subTotal);
    },        
        onAddRow: function (c, e, h) {
            console.log('Record Id:', c.get('v.recordId'));            
            var newRetailDeliveryTicketLineItems = c.get('v.newRetailDeliveryTicketLineItems');            
            newRetailDeliveryTicketLineItems.push(Object.assign({}, c.get('v.newRDTLI')));            
            c.set('v.newRetailDeliveryTicketLineItems', newRetailDeliveryTicketLineItems);
        },            
            updateTicketLineItem: function (c, e, h) {
                var item = e.getParam('retailDeliveryTicketLineItem');
                var indexVal = e.getParam('indexVal');
                var rdlitems = c.get('v.allNewRetailDeliveryTicketLineItems');
                rdlitems[indexVal] = item;
                c.set('v.allNewRetailDeliveryTicketLineItems', rdlitems);
            },                
                onLicenseChange: function (c, e, h) {
                    //var licenseId = e.getSource().get('v.value');
                    var disableExcludeExciseTax = true;                    
                    let newrdtClean = c.get('v.newRetailDeliveryTicket');
                    var licenseId = newrdtClean.stateLicense;
                    newrdtClean.shippingAddress = '';
                    console.log('onLicenseChange....', licenseId);
                    c.set('v.newRetailDeliveryTicket', newrdtClean);                    
                    if (licenseId) {
                        console.log('onLicenseChange', licenseId);
                        var statelicenses = c.get('v.statelicenses');
                        var statelicense = statelicenses[licenseId].License_Type__c;
                        c.set('v.selectedWarehouse',statelicenses[licenseId].Default_Warehouse__c);
                        console.log(statelicenses[licenseId].License_Address__c);
                        var excludeExciseTaxTypes = c.get('v.excludeExciseTaxTypes');
                        if (statelicense && excludeExciseTaxTypes.indexOf(statelicense) != -1) {
                            /*(statelicense == 'Type 11' || statelicense == 'Type 12' ||statelicense == 'Type 13')*/
                            disableExcludeExciseTax = false;
                        } else {
                            disableExcludeExciseTax = true;
                        }
                        if (disableExcludeExciseTax) {
                            var newRetailDeliveryTicket = c.get('v.newRetailDeliveryTicket');
                            newRetailDeliveryTicket.excludeExciseTax = false;
                            c.set('v.newRetailDeliveryTicket', newRetailDeliveryTicket);
                        }
                        c.set('v.disableExcludeExciseTax', disableExcludeExciseTax);                        
                        let newrdt = c.get('v.newRetailDeliveryTicket');
                        let retailersDetailMap = c.get('v.retailersDetail');
                        let retailersDetail = retailersDetailMap[newrdt.retailer];
                        console.log('retailersDetail:', retailersDetail);
                        let licenses = retailersDetail.licenses;                        
                        var lAddress = retailersDetail.statelicenses[licenseId].License_Address__c;                        
                        if(retailersDetail.statelicenses[licenseId].License_City__c != undefined){
                            lAddress+= ', ' + retailersDetail.statelicenses[licenseId].License_City__c;
                        }
                        if(retailersDetail.statelicenses[licenseId].License_State__c != undefined){
                            lAddress+= ', ' + retailersDetail.statelicenses[licenseId].License_State__c;
                        }
                        if(retailersDetail.statelicenses[licenseId].License_Country__c != undefined){
                            lAddress+= ', ' + retailersDetail.statelicenses[licenseId].License_Country__c;
                        }
                        if(retailersDetail.statelicenses[licenseId].License_Zip__c != undefined){
                            lAddress+= ', ' + retailersDetail.statelicenses[licenseId].License_Zip__c;
                        }                        
                        console.log('retailersDetail:', lAddress);
                        newrdt.shippingAddress = lAddress;
                        c.set('v.newRetailDeliveryTicket', newrdt);
                        h.processCalculations(c,true);
                    }
                },                    
                    onRetailerChange: function (c, e, h) {
                        try{
                            c.set('v.isEnable', false);
                            //var retailerId = e.getSource().get('v.value');
                            var newRetailDeliveryTicket = c.get('v.newRetailDeliveryTicket');
                            var retailerId = newRetailDeliveryTicket.retailer;
                            console.log('retailerId::', retailerId);
                            let licenses = [];
                            let contacts = [];
                            let types = [];
                            let statelicenses = {};
                            //var typeMap =[];                            
                            let newrdtClean = c.get('v.newRetailDeliveryTicket');
                            newrdtClean.shippingAddress = '';
                            newrdtClean.stateLicense = '';
                            newrdtClean.stateLicenseName = '';
                            newrdtClean.retailerContact = '';
                            newrdtClean.retailerContactName = '';
                            newrdtClean.salesPersonName ='';
                            newrdtClean.salesPersonIds ='';
                            newrdtClean.factoringAssigneeId = '';
                            newrdtClean.factoringAssigneeName = '';
                            newrdtClean.factoringContactId = '';
                            newrdtClean.factoringContactName = '';
                            newrdtClean.factoringTerms = '';
                            newrdtClean.factoringRate = 0;
                            c.set('v.newRetailDeliveryTicket', newrdtClean);                            
                            if (retailerId) {
                                let retailersDetailMap = c.get('v.retailersDetail');
                                let retailersDetail = retailersDetailMap[retailerId];
                                licenses = retailersDetail.licenses;
                                
                                for(let i = 0;i<licenses.length;i++){
                                    let s = licenses[i].address;
                                    let lastIndex = s.lastIndexOf("-");
                                    let s2 = s.substring(0,lastIndex);
                                    types = retailersDetail.typeMap;
                                    for(let j = 0;j<types.length;j++){
                                        if(licenses[i].id == types[j].id){
                                            s2 += ' - ';
                                            s2 += types[j].type;
                                        }
                                    }
                                    licenses[i].address = s;
                                    licenses[i].name = s;
                                    console.log('s2 ',s);
                                }                                
                                statelicenses = retailersDetail.statelicenses;
                                console.log('statelicenses:',statelicenses);
                                
                                var MSLinesSL = c.find('multiSelect');
                                [].concat(MSLinesSL).forEach((item)=>{
                                    if(item.get('v.mslabel') == 'Shipping Address'){
                                    item.set('v.stateLicenseName','Select');
                                    item.set('v.stateLicense','');
                                    item.onChange();
                                }
                                                             })
                                
                                contacts = retailersDetail.contacts;
                                contacts.forEach((c) => c.selected = false );  
                                var MSLinesCon = c.find('multiSelect');
                                [].concat(MSLinesCon).forEach((item)=>{
                                    if(item.get('v.mslabel') == 'Retail Contact'){
                                    item.set('v.retailerContactName','Select');
                                    item.set('v.retailerContact','');
                                    item.onChange();
                                }
                                                              })
                                //typeMap = retailersDetail.typeMap;
                                console.log('###SalesRep = ', newRetailDeliveryTicket.stateLicense);
                                if (retailersDetail.salesRep.Sales_Person__c != undefined) {                                    
                                    newRetailDeliveryTicket.salesPersonName = retailersDetail.salesRep.Sales_Person__r.Name;
                                    newRetailDeliveryTicket.salesPersonIds = retailersDetail.salesRep.Sales_Person__c;                                    
                                    var MSLines = c.find('multiSelect');
                                    [].concat(MSLines).forEach((item)=>{
                                        if(item.get('v.mslabel') == 'Sales Rep'){
                                        item.set('v.selectedValuesId',retailersDetail.salesRep.Sales_Person__c);
                                        item.onChange();
                                    }
                                                               })
                                } else {                                    
                                    newRetailDeliveryTicket.salesPersonName = '';
                                    newRetailDeliveryTicket.salesPersonIds = '';
                                    var SR = c.get('v.salesReps');
                                    SR.forEach((s) => s.selected = false );
                                    c.set('v.salesReps', SR);
                                }
                                
                                
                                var contactsOptions = [];
                                for (var i = 0; i < contacts.length; i++) {
                                    contactsOptions.push({
                                        label: contacts[i].name,
                                        value: contacts[i].id,
                                    });
                                }
                                c.set('v.contactsOptions', contactsOptions);
                                var retailer = retailersDetail.retailer;
                                h.setMsgValue(c, retailer);
                                newRetailDeliveryTicket.paymentTerms = retailersDetail.paymentTerm; //retailer.Payment_Terms__c;
                                console.log('retailer details ::', retailersDetail.paymentTerm);
                                
                                
                            } else {
                                //newRetailDeliveryTicket.paymentTerms = '';
                            }                            
                            c.set('v.newRetailDeliveryTicket', newRetailDeliveryTicket);
                            c.set('v.statelicenses', statelicenses);
                            console.log('statelicenses::',JSON.stringify(c.get('v.statelicenses')));
                            console.log('licenses = ',licenses); 
                            
                            c.set('v.licenses', licenses);
                            c.set('v.contacts', contacts);
                            h.populateFactoringAssignees(c);                            
                            var contactsOptions = [];
                            for (var i = 0; i < contacts.length; i++) {
                                contactsOptions.push({ label: contacts[i].name, value: contacts[i].id });
                            }
                            c.set('v.contactsOptions', contactsOptions);                            
                            var PT = c.get('v.paymentTerms');
                            window.setTimeout($A.getCallback(function(){
                                PT.forEach((p) => p.selected = p.id == newRetailDeliveryTicket.paymentTerms)     
                                c.set('v.paymentTerms', PT);
                            }),100)
                            var SR = c.get('v.salesReps');
                            window.setTimeout($A.getCallback(function(){
                                SR.forEach((s) => s.selected = s.id == newRetailDeliveryTicket.salesPersonIds)     
                                c.set('v.salesReps', SR);
                            }),100)   
                            var allNewRetailDeliveryTicketLineItems = c.get('v.allNewRetailDeliveryTicketLineItems');
                           var newRetailDeliveryTicket2 = c.get('v.newRetailDeliveryTicket');
                            h.request(c, 'getProductsByRetailerId', { recordId: retailerId,"fromTransferOrders":false}, function (r) {
                                var warehouseAvailableInventoryMap = r.warehouseAvailableInventoryMap;
                                c.set('v.warehouseAvailableInventoryMap',warehouseAvailableInventoryMap);
                                var warehouseTotalOrderedMap = r.warehouseTotalOrderedMap;
                                c.set('v.warehouseTotalOrderedMap', warehouseTotalOrderedMap);
                                c.set('v.Minimum_Order_Value',r.Minimum_Order_Value);
                                if(r.isThird_Party_Scheduler){
                                    newRetailDeliveryTicket2.isSample = false;
                                    newRetailDeliveryTicket2.isPreapproved = false;
                                    c.set('v.newRetailDeliveryTicket',newRetailDeliveryTicket2);
                                }
                                c.set('v.isThird_Party_Scheduler',r.isThird_Party_Scheduler);
                                
                                var products = r.products;
                                 let arr = [];
                                let setOfIds = [];
                                let arr2 = [];
                                products.forEach((product) => {
                                    
                                    
                                    let warehouseInventoryDetails = '';
                                    let warehouseDetails = warehouseAvailableInventoryMap[product.id]||[];
                                    warehouseDetails.forEach((item) => {
                                    let key = item.id +'-'+product.id;
                                    let totalOrderedQty = warehouseTotalOrderedMap[key] || 0;
                                    if(item.name != undefined){
                                    var itemName = item.name.split(',')[0];
                                    var itemNameList = itemName.split(' ');
                                    var itemNm = '';
                                    itemNameList.forEach((nm) => {
                                    itemNm += nm.substring(0,1);    
                                });
                                let totalInventry = item.availableInventory - totalOrderedQty;
                                if(product.MOQ > 0)
                                    totalInventry = totalInventry / product.MOQ; 
                                if(totalInventry % 1 != 0)
                                    totalInventry = totalInventry.toFixed(4);                    
                                warehouseInventoryDetails = warehouseInventoryDetails + itemNm + ': ' + totalInventry + ' Cases<br>';
                                
                            }
                                      });
                            product.warehouseInventoryDetails = warehouseInventoryDetails;
                            //if(!setOfIds.includes(product.id)){
                            arr.push(product.id);
                        //}
                            if(allNewRetailDeliveryTicketLineItems.length >0){
                            for (var i = 0; i < allNewRetailDeliveryTicketLineItems.length; i++) {
                                    	if(product.id == allNewRetailDeliveryTicketLineItems[i].Product){
                                            var retailDeliveryTicketLineItem = Object.assign({}, allNewRetailDeliveryTicketLineItems[i]);
                                            //alert(product.price.unitPrice);
                                            retailDeliveryTicketLineItem.listPrice = product.price.unitPrice;
                                            retailDeliveryTicketLineItem.MOQ = product.MOQ;
                                            retailDeliveryTicketLineItem.ProductBookEntryId = product.price.id;
                                            retailDeliveryTicketLineItem.priceBookid = product.price.id;
                                            retailDeliveryTicketLineItem.salesPrice = product.salePrice; 
                                            retailDeliveryTicketLineItem.applyExciseTax = product.applyExciseTax;
                                    		arr2.push(retailDeliveryTicketLineItem);
                               			 }
                                	}
                            c.set('v.allNewRetailDeliveryTicketLineItems', arr2);
                                c.set('v.newRetailDeliveryTicketLineItems',arr2);
                                //c.set('v.activeTab', 'active');
                                    
                            }
                        });
                        c.set('v.searchString','');
                        h.searchData(c, e);
                        h.setPagination(c,e,h,false);
                        console.log('#$# :',products.length);
                        products = h.sortAllProducts(c, e, h,products,'ASC');
                        c.set('v.products', products);
                        c.set('v.allProducts', products);
                        c.set('v.completeProducts', products); 
                         c.set('v.productOrderedQtyMap', r.productOrderedQtyMap);
                        var filters = { orderByField: 'product.name', isASC: true };
                        c.set('v.filters', filters);
                        h.initPagination(c, arr, filters);
                        h.calculateTotals(c);
                    });
                            
                            
                            
                        }catch(err){
                            console.log('Error:',err);
                        }
                    },                        
                        onChangeSearchProduct: function (c, e, h) {
                            c.set('v.isProcessing',true);
                            window.setTimeout($A.getCallback(function(){                                
                                var searchInput = c.find('searchRec');
                                var searchText = searchInput.getElement().value;
                                c.set('v.searchString',searchText)                                
                                h.searchData(c,e);
                                var filters = { orderByField: 'product.name', isASC: true };
                                c.set('v.filters', filters);
                                let products = c.get('v.products');
                                let newRetailDeliveryTicketLineItems = c.get('v.newRetailDeliveryTicketLineItems');
                                let arr = [];
                                let tabName = c.get('v.activeTab');
                                if(tabName == 'all'){
                                    let setOfIds = [];
                                    newRetailDeliveryTicketLineItems.forEach((itemRec) => {
                                        setOfIds.push(itemRec.Product);
                                    });
                                        products.forEach((item) => {
                                        //if(!setOfIds.includes(item.id)){
                                        arr.push(item.id);
                                    //}
                                    });
                                        h.initPagination(c, arr, filters);
                                    } else {
                                        newRetailDeliveryTicketLineItems.forEach((item) => {
                                        arr.push(item.Product);
                                    });
                                        console.log('arr = ',arr);    
                                        h.initPagination(c, arr, filters,'paginatorActive');    
                                    }
                                    }),100);
                                    },                                          
                                        sortProducts: function (c, e, h) {
                                            var sortType = c.get('v.sortType');
                                            if(sortType == 'ASC')
                                                sortType = 'DESC';
                                            else
                                                sortType = 'ASC';
                                            c.set('v.sortType',sortType); 
                                            var allProducts = c.get('v.allProducts'); 
                                            allProducts = h.sortAllProducts(c, e, h,allProducts,sortType);
                                            c.set('v.allProducts',allProducts); 
                                            h.searchData(c, e);
                                            var filters = { orderByField: 'product.name', isASC: true };
                                            c.set('v.filters', filters);        
                                            let arr = [];
                                            let rdtLineItems = c.get('v.newRetailDeliveryTicketLineItems');
                                            let setOfIds = [];
                                            rdtLineItems.forEach((itemRec) => {
                                                setOfIds.push(itemRec.Product);
                                            });
                                                let tabName = c.get('v.activeTab'); 
                                                if(tabName == 'all'){
                                                let products = c.get('v.products');
                                                products.forEach((item) => {
                                                //if(!setOfIds.includes(item.id)){
                                                arr.push(item.id);
                                            //}
                                            });
                                                h.initPagination(c, arr, filters);
                                            } else {
                                                h.initPagination(c, setOfIds, filters,'paginatorActive');
                                            }
                                            },         
                                                handleMultiSelectEvent  :  function (c, e, h) {
                                                    var selectedIds = e.getParam("selectedIds");
                                                    var fieldName = e.getParam("fieldName"); 
                                                    console.log('fieldName = ',fieldName);
                                                    console.log('selectedIds = ',selectedIds);                                                    
                                                    var newRetailDeliveryTicket = c.get('v.newRetailDeliveryTicket');                                                    
                                                    if(fieldName == 'Ship To'){
                                                        let retailerId = selectedIds.slice(0, -1);
                                                        newRetailDeliveryTicket.retailer = retailerId;
                                                        c.set('v.newRetailDeliveryTicket',newRetailDeliveryTicket);
                                                        if(c.get('v.initializationCompleted')){
                                                            var a = c.get('c.onRetailerChange');
                                                            $A.enqueueAction(a);
                                                        }
                                                    }else if(fieldName == 'Sales Rep'){
                                                        let salesPersonId = selectedIds.slice(0, -1);
                                                        newRetailDeliveryTicket.salesPersonIds = salesPersonId;
                                                        c.set('v.newRetailDeliveryTicket',newRetailDeliveryTicket);
                                                    } else if(fieldName == 'Shipping Address'){
                                                        let licenseId = selectedIds.slice(0, -1);
                                                        console.log('##licenses',licenseId);
                                                        newRetailDeliveryTicket.stateLicense = licenseId;
                                                        c.set('v.newRetailDeliveryTicket',newRetailDeliveryTicket);
                                                        if(c.get('v.initializationCompleted')){
                                                            var a = c.get('c.onLicenseChange');
                                                            $A.enqueueAction(a);
                                                        }
                                                    } else if(fieldName == 'Factoring Assignee'){
                                                        let assigneeId = selectedIds.slice(0, -1);
                                                        newRetailDeliveryTicket.factoringAssigneeId = assigneeId;
                                                        console.log('AssigneeId = ',assigneeId);            
                                                        c.set('v.newRetailDeliveryTicket',newRetailDeliveryTicket);
                                                        if(c.get('v.initializationCompleted')){
                                                            newRetailDeliveryTicket.factoringContactId = '';
                                                            newRetailDeliveryTicket.factoringContactName = '';
                                                            newRetailDeliveryTicket.factoringTerms = '';
                                                            newRetailDeliveryTicket.factoringRate = 0;
                                                            c.set('v.factoringDiscount',0.00);
                                                            c.set('v.newRetailDeliveryTicket',newRetailDeliveryTicket);
                                                            h.populateFactoringContacts(c,assigneeId);
                                                            if(assigneeId != '')
                                                                h.populateFactoringTerms(c,assigneeId); 
                                                        }
                                                    } else if(fieldName == 'Factoring Contact'){
                                                        let contactId = selectedIds.slice(0, -1);
                                                        newRetailDeliveryTicket.factoringContactId = contactId;
                                                        c.set('v.newRetailDeliveryTicket',newRetailDeliveryTicket);
                                                    } else if(fieldName == 'Payment Terms'){
                                                        let payTerms = selectedIds.slice(0, -1);
                                                        newRetailDeliveryTicket.paymentTerms = payTerms;
                                                        c.set('v.newRetailDeliveryTicket',newRetailDeliveryTicket);
                                                        if(c.get('v.initializationCompleted')){
                                                            var a = c.get('c.onPaymentTermsChange');
                                                            $A.enqueueAction(a);
                                                        }
                                                    } else if(fieldName == 'Factoring Terms'){
                                                        let payTermsF = selectedIds.slice(0, -1);
                                                        newRetailDeliveryTicket.factoringTerms = payTermsF;
                                                        c.set('v.newRetailDeliveryTicket',newRetailDeliveryTicket);
                                                        if(c.get('v.initializationCompleted')){
                                                            var a = c.get('c.onFactoringTermsChange');
                                                            $A.enqueueAction(a);
                                                        }
                                                    } else if(fieldName == 'Retail Contact'){
                                                        let retailerContact = selectedIds.slice(0, -1);
                                                        newRetailDeliveryTicket.retailerContact = retailerContact;
                                                        c.set('v.newRetailDeliveryTicket',newRetailDeliveryTicket);
                                                    } 
                                                },                                                      
                                                handleNumberEvent :  function (c, e, h) {
                                                    var listSelectedItems = c.get("v.lstSelectedRecords");
                                                    var recordId = e.getParam("recordId");
                                                    var currentValue = e.getParam("currentValue");
                                                    var index = parseInt(e.getParam("index"),10);                                                    
                                                    if(c.get('v.newRetailDeliveryTicket').stateLicense == null || c.get('v.newRetailDeliveryTicket').stateLicense == '' || c.get('v.newRetailDeliveryTicket').stateLicense == undefined){
                                                        h.warning({ message: 'Please add State license to change the case quantity.',});
                                                    } else {
                                                        if(c.get('v.activeTab') != 'all'){
                                                            let rdtLineItems = c.get('v.newRetailDeliveryTicketLineItems');
                                                            rdtLineItems.forEach((item,indx) => {
                                                                if(item.Product == recordId && indx == index){
                                                                item.orderQty = currentValue;
                                                            }
                                                                                 });
                                                            c.set('v.newRetailDeliveryTicketLineItems',rdtLineItems);
                                                            let allNewRetailDeliveryTicketLineItems = c.get('v.allNewRetailDeliveryTicketLineItems');
                                                            allNewRetailDeliveryTicketLineItems.forEach((item,indx) => {
                                                                if(item.Product == recordId && indx == index){
                                                                item.orderQty = currentValue;
                                                            }                                                                                                        });
                                                            c.set('v.allNewRetailDeliveryTicketLineItems',allNewRetailDeliveryTicketLineItems);
                                                            h.processCalculations(c,true);
                                                        } else{
                                                            let products = c.get('v.products');
                                                            products.forEach((item,indx) => {
                                                                if(item.id == recordId && indx == index){
                                                                item.quantity = currentValue;
                                                            }
                                                                             });
                                                            c.set('v.products',products);
                                                        }
                                                        h.calculateTotals(c);
                                                    }       
                                                }, 
                                                onRemoveRow: function (c, e, h) {
                                                    c.set('v.isEnable', false);
                                                    //var rowIndex = e.getSource().get('v.value');                                                    
                                                    var ctarget = e.currentTarget;
                                                    var rowIndex = ctarget.dataset.index;
                                                    var prodId = ctarget.dataset.productid;                                                    
                                                    var allNewRetailDeliveryTicketLineItems = c.get('v.allNewRetailDeliveryTicketLineItems');
                                                     var newRetailDeliveryTicketLineItems = c.get('v.newRetailDeliveryTicketLineItems');
                                                    if(allNewRetailDeliveryTicketLineItems.length == 1){
                                                        h.warning({ message: c.get('v.Err_Msg_Add_Atleat_One_OLI')});
                                                    }
                                                    for (var i = 0; i < allNewRetailDeliveryTicketLineItems.length; i++) {console.log(allNewRetailDeliveryTicketLineItems[i].Product,'--',allNewRetailDeliveryTicketLineItems[i].isSample,'--', allNewRetailDeliveryTicketLineItems[rowIndex].isSample,'--prodId = ',allNewRetailDeliveryTicketLineItems[i].isSample ? prodId+'-true' : prodId+'-false');
                                                        if (allNewRetailDeliveryTicketLineItems[i].Product == prodId && allNewRetailDeliveryTicketLineItems[i].isSample == newRetailDeliveryTicketLineItems[rowIndex].isSample && allNewRetailDeliveryTicketLineItems[i].salesPrice == newRetailDeliveryTicketLineItems[rowIndex].salesPrice) {
                                                            prodId = allNewRetailDeliveryTicketLineItems[i].isSample ? prodId+'-true-'+allNewRetailDeliveryTicketLineItems[i].salesPrice : prodId+'-false-'+allNewRetailDeliveryTicketLineItems[i].salesPrice;
                                                            allNewRetailDeliveryTicketLineItems.splice(i, 1); 
                                                            
                                                        } 
                                                    }
                                                    c.set('v.allNewRetailDeliveryTicketLineItems',allNewRetailDeliveryTicketLineItems);                                                    
                                                   
                                                    
                                                    console.log('newRetailDeliveryTicketLineItems = ',newRetailDeliveryTicketLineItems.length);                                                    
                                                    var products = c.get('v.products');
                                                    var allProducts = c.get('v.allProducts');
                                                    /*var removeProducts = c.get('v.removeProducts');
                                                    for (var i = 0; i < removeProducts.length; i++) {
                                                        if (removeProducts[i].id == prodId) {
                                                            allProducts.push(removeProducts[i]);
                                                            products.push(removeProducts[i]);
                                                            removeProducts.splice(i, 1);
                                                            break;
                                                        }
                                                    }*/
                                                    var sortType = c.get('v.sortType');
                                                    allProducts = h.sortAllProducts(c, e, h,allProducts,sortType);
                                                    c.set('v.products',products);
                                                    c.set('v.allProducts',allProducts);
                                                    //c.set('v.removeProducts',removeProducts);                                                    
                                                    var tmp = newRetailDeliveryTicketLineItems[rowIndex];                                                    
                                                    console.log('ST License = ',c.get('v.newRetailDeliveryTicket').stateLicense);                                                    
                                                    if(newRetailDeliveryTicketLineItems.length == 1){
                                                        
                                                        h.request(c, 'removeProduct', { productId: prodId}, function (r) {
                                                            if (r.isBrand) {
                                                                $A.get('e.c:updateCartTotalEvt').setParams({ cartTotal: r.quantity }).fire();
                                                            }
                                                        }, { showSpinner: false });
                                                        newRetailDeliveryTicketLineItems.splice(rowIndex, 1);
                                                        c.set('v.newRetailDeliveryTicketLineItems',newRetailDeliveryTicketLineItems);
                                                        h.calculateTotals(c); 
                                                    } else if(c.get('v.newRetailDeliveryTicket').stateLicense == null || c.get('v.newRetailDeliveryTicket').stateLicense == '' || c.get('v.newRetailDeliveryTicket').stateLicense == undefined){
                                                        //h.warning({ message: 'To remove please select State license.',});
                                                        h.request(c, 'removeProduct', { productId: prodId}, function (r) {
                                                            if (r.isBrand) {
                                                                $A.get('e.c:updateCartTotalEvt').setParams({ cartTotal: r.quantity }).fire();
                                                            }
                                                        }, { showSpinner: false });
                                                        
                                                        newRetailDeliveryTicketLineItems.splice(rowIndex, 1);
                                                        c.set('v.newRetailDeliveryTicketLineItems',newRetailDeliveryTicketLineItems);
                                                        h.calculateTotals(c); 
                                                    } else if (newRetailDeliveryTicketLineItems.length > 0) {
                                                        h.request(c, 'removeProduct', { productId: prodId}, function (r) {
                                                            if (r.isBrand) {
                                                                $A.get('e.c:updateCartTotalEvt').setParams({ cartTotal: r.quantity }).fire();
                                                            }
                                                        }, { showSpinner: false });
                                                        
                                                        newRetailDeliveryTicketLineItems.splice(rowIndex, 1);
                                                        
                                                        c.set('v.newRetailDeliveryTicketLineItems',newRetailDeliveryTicketLineItems);
                                                        
                                                        h.calculateTotals(c);           
                                                        h.processCalculations(c,true);
                                                        $A.get('e.c:updateCartTotalEvt').setParams({cartTotal: allNewRetailDeliveryTicketLineItems.length}).fire();
                                                    } else {
                                                        h.warning({
                                                            message: c.get('v.Err_Msg_Add_Atleat_One_OLI'),
                                                        });
                                                        h.calculateTotals(c); 
                                                    }
                                                    h.setPagination(c,e,h,false);
                                                    /*if (tmp.Product) {
            h.request(c,'removeProduct',{ productId: tmp.Product },function (r) {
                if (r.isBrand) {
                    $A.get('e.c:updateCartTotalEvt').setParams({ cartTotal: r.quantity }).fire();
                }
            },{ showSpinner: false });
		}*/
    },
     handleTimePickerEvent: function(c, e, h) {
        let selectedTime = e.getParam("selectedTime");
        let fieldName = e.getParam("fieldName");
        console.log('selectedTime = ',selectedTime);
        console.log('fieldName = ',fieldName);
        c.set('v.'+fieldName,selectedTime);
    },                                
            onSave: function (c, e, h) {
                try {
                    let buttonStatus = e.getSource().getLocalId();
                    //console.log('newRetailDeliveryTicket:', JSON.stringify(c.get('v.newRetailDeliveryTicket')));        
                    c.set('v.buttonStatus',buttonStatus);
                    
                    if (c.get('v.recordId') != '' && c.get('v.recordId') != undefined) 
                        c.set('v.successMsgTitle', 'Order updated successfully!');
                    else
                        c.set('v.successMsgTitle', 'Order submitted successfully!');
                    
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
                    var salesRep = document.getElementById("Sales Rep").innerHTML ;
                    var addBrandContact = document.getElementById("Additional Brand Contact").innerHTML ;
                    var addRetailContact = document.getElementById("Retail Contact").innerHTML;
                    const siteId = c.get('v.selectedWarehouse');
                    console.log('salesRep = ',salesRep);
                    console.log('addBrandContact = ',addBrandContact);
                    console.log('addRetailContact = ',addRetailContact);            
                    if(salesRep == undefined)
                        salesRep = '';
                    if(addBrandContact == undefined)
                        addBrandContact = '';            
                    var newRetailDeliveryTicket = c.get('v.newRetailDeliveryTicket');
                    console.log('retailerContact = ',newRetailDeliveryTicket.stateLicense);                    
                    if(addRetailContact != '' && addRetailContact != undefined){ 
                        var a = addRetailContact.split(',')[0];
                        newRetailDeliveryTicket.retailerContact = a;
                        addRetailContact = addRetailContact.replace(a+',','');
                        if(addRetailContact == null || addRetailContact == undefined)
                            addRetailContact = ''; 
                    }else{
                        h.error({ message: 'Please select atleast one retailer contact.',});
                        return;
                    }
                    if(c.get('v.newRetailDeliveryTicket.factoringAssigneeId') != '' && c.get('v.newRetailDeliveryTicket.factoringContactId') == ''){
                        h.error({ message: c.get('v.Factoring_Contact_Required_For_Order'),});
                        return;
                    }
                    if(c.get('v.newRetailDeliveryTicket.factoringAssigneeId') != '' && c.get('v.newRetailDeliveryTicket.factoringTerms') == ''){
                        h.error({ message: c.get('v.Factoring_Terms_Required_For_Order'),});
                        return;
                    }
                    if(c.get('v.allNewRetailDeliveryTicketLineItems').length <=0){
                        h.error({ message: c.get('v.Err_Msg_Add_Atleat_One_OLI'),}); 
                        //h.showToast('error','','Please add atleast one Retail Delivery Ticket Line Item');   
                        return;    
                    }
                    if(c.get('v.subTotal') < 0.0){
                        h.error({ message: c.get('v.Total_product_amount_tooltip'),}); 
                        return;
                    }
                    
                    if(newRetailDeliveryTicket.isPreapproved && newRetailDeliveryTicket.isSample){
                        h.error({ message: 'If Sample Order is selected, Preapproved cannot be selected.',}); 
                        return;
                    }
                    if(newRetailDeliveryTicket.isPreapproved){
                        
                        if((c.get('v.requestDateTime') == ''  || c.get('v.requestDateTime') == null) || c.get('v.requestDateTime') == undefined){
                            c.set('v.hasDateError',true);
                            return;
                        }
                        let earTime = newRetailDeliveryTicket.EarTime;
                        let strEarTime;
                        let strLetTime;
                        if(earTime != ''){
                            c.set('v.hasLatestTimeError',false);
                            strEarTime = earTime.split(':');
                            console.log('##strEarTime',strEarTime[0],' - ',strEarTime[1]);
                            if(strEarTime.length == 0){
                                c.set('v.hasLatestTimeError',true);
                                return;
                            }
                            let letestTime = newRetailDeliveryTicket.LatTime;
                            if(letestTime != ''){
                                c.set('v.hasLatestTimeError',false);
                                strLetTime = letestTime.split(':');
                                console.log('##strLetTime',strLetTime[0],' - ',strLetTime[1]);
                                if(strLetTime.length == 0){
                                    c.set('v.hasLatestTimeError',true);
                                    return;    
                                }
                                if(strLetTime[1].indexOf('PM') > -1 && parseInt(strLetTime[0]) != 12){
                                    strLetTime[0] = parseInt(strLetTime[0]) + 12;
                                }
                                if(strEarTime[1].indexOf('PM') > -1 && parseInt(strEarTime[0]) != 12){
                                    strEarTime[0] =parseInt(strEarTime[0]) + 12;
                                }
                                console.log('##Date : '+parseInt(strLetTime[0]) , ' < ',parseInt(strEarTime[0]));
                                if(parseInt(strLetTime[0]) < parseInt(strEarTime[0]) ){
                                    c.set('v.latesDateAfterEarliestDateError',true);
                                    h.error({ message: 'Delivery Latest Time cannot be before  Delivery Earliest Time.',});
                                    return;    
                                }else{
                                    c.set('v.latesDateAfterEarliestDateError',false);   
                                }
                            }
                        }else{
                            c.set('v.hasLatestTimeError',true);
                            return; 
                        }
                    }
                    
                    const warehouseAvailableInventoryMap = c.get('v.warehouseAvailableInventoryMap');
                    const warehouseTotalOrderedMap = c.get('v.warehouseTotalOrderedMap');
                    
                    var allNewRetailDeliveryTicketLineItems = c.get('v.allNewRetailDeliveryTicketLineItems');
                    var validToSave = true;
                    var validToSave1 = true;
                    var validToSave2 = true;
                    var validToSave3 = true;
                    var validToSave4 = true;
                    var isBulkProd = false;
                    var validToSave5 = true;
                    var Sample_Limitation_Error = '';
                    var isErrorOfSalesPrice = false;
                    var isCheckMaxDiscountAmtValid = false;
                    let products = c.get('v.allProducts');
                    var licenseId = newRetailDeliveryTicket.stateLicense;
                    var statelicense ='';
                    var statelicenses = c.get('v.statelicenses');
                    if (licenseId && statelicenses[licenseId]) {
                        
                        statelicense = statelicenses[licenseId].License_Type__c;
                        //alert(statelicense);
                    }
                    var chkAllIsSample =true;
                    var totalPriceForMiniOdrVal =0;
                    var MaxDiscountAmt = 0;
                    let NewRetailDeliveryTicketLineItemsData = [];
                    allNewRetailDeliveryTicketLineItems.forEach((item) => {
                        console.log('RDT::',item);
                        const SampleOrderFamilyMap = c.get('v.SampleOrderFamilyMap');
                         var SampleOrderFamilyDetail = SampleOrderFamilyMap[item.productFamily]||null;
                        
                        var warehouseDetails = warehouseAvailableInventoryMap[item.Product]||[];
                        let totalOrderedQty = 0;
                        let totalInventry = 0;
                        
                        warehouseDetails.forEach((site) => {
                            var key = site.id +'-'+item.Product;
                            if(siteId == site.id){
                                totalOrderedQty = warehouseTotalOrderedMap[key] || 0;
                                totalInventry = site.availableInventory - totalOrderedQty;
                                if(item.MOQ > 0)
                                totalInventry = totalInventry / item.MOQ; 
                                if(totalInventry % 1 != 0)
                                totalInventry = totalInventry.toFixed(4);
                                totalInventry = parseFloat(totalInventry)
                            }                                                                
                        });
                        
                        var countSameOdrQty = 0
                        for (var i = 0; i < allNewRetailDeliveryTicketLineItems.length; i++) {
                            if (allNewRetailDeliveryTicketLineItems[i].Product == item.Product){
                            countSameOdrQty += parseFloat(allNewRetailDeliveryTicketLineItems[i].orderQty);
                            }
                        
                    	}
                        
                        if(item.isSample && SampleOrderFamilyDetail != null ){
                            if(countSameOdrQty > SampleOrderFamilyDetail.Qty_Limit_Per_Order_Line__c){
                            var errMsg = c.get('v.Sample_Limitation_Error_Msg');
                            Sample_Limitation_Error = errMsg.replace('{0}', SampleOrderFamilyDetail.Name__c);
                            Sample_Limitation_Error = Sample_Limitation_Error.replace('{1}', SampleOrderFamilyDetail.Qty_Limit_Per_Order_Line__c);
                        }
                    }
                        
                        //countSameOdrQty += qty;
                        if(countSameOdrQty>totalInventry && item.isDiscountProduct != true){
                        	validToSave1 = false;
                    	}
                        if(item.isBulkProduct && (statelicense == 'Type 10' || statelicense == 'Type 9'))
                            isBulkProd = true;
                        if(item.cases == undefined){
                            let totalInv = item.availableQty/item.MOQ;
                            if(totalInv % 1 != 0) totalInv = totalInv.toFixed(4);
                            item.cases = totalInv;
                        }
                    
                        if(item.orderQty <= 0 ){
                            validToSave = false; 
                        }
                                           
                        const decimalPart =  item.orderQty % 1;
                        console.log('QTY:',item.orderQty);
                        console.log('totalInventry:',totalInventry ,'--',item.isDiscountProduct,'---',decimalPart);
                        if(((decimalPart > 0 && item.orderQty != totalInventry) || item.orderQty > totalInventry ) && item.isDiscountProduct != true){
                            validToSave1= false;
                        }
                       /* products.forEach((p) => {
                            if(p.id == item.Product){
                        	console.log('#actualSalesPrice ',p.actualSalesPrice ,' > ', item.salesPrice,' = ',item.isPromo);
                                    if(item.isLIPromo){
                                    item.isLIPromo = false;
                                }
                            	if(p.actualSalesPrice > item.salesPrice && item.isPromo != true){
                        			item.isLIPromo = true;
                            		isErrorOfSalesPrice = true;
                          		}
                        
                    }
                    	});*/
                        
                        
                        if(item.isDiscountProduct != true){
                            totalPriceForMiniOdrVal += item.salesPrice * item.orderQty * item.MOQ;
                    }else{
                        MaxDiscountAmt += item.salesPrice * item.orderQty * item.MOQ;
                    }
                         
                        if(c.get('v.Max_Discount_Value') < MaxDiscountAmt && c.get('v.Max_Discount_Value') > 0 && item.isDiscountProduct){
                        isCheckMaxDiscountAmtValid = true;
                    }
                     	if(!item.isSample && !item.isDiscountProduct){
                        	chkAllIsSample =false;
                    	}  
                    
                        if(item.salesPrice <= 0){
                            validToSave3 = false;
                        }
                        //NewRetailDeliveryTicketLineItemsData.push(item);
        		});
                        
                        //h.setProductsIsLIPromo(c,allNewRetailDeliveryTicketLineItems,true);
                        
                        /*if(isErrorOfSalesPrice){
                        console.log('#NewRetailDeliveryTicketLineItemsData :',NewRetailDeliveryTicketLineItemsData)
                        c.set('v.newRetailDeliveryTicketLineItems',NewRetailDeliveryTicketLineItemsData);
                        c.set('v.allNewRetailDeliveryTicketLineItems',NewRetailDeliveryTicketLineItemsData);
                        window.setTimeout(
                        $A.getCallback(function() {
                            h.setProductsIsLIPromo(c,NewRetailDeliveryTicketLineItemsData,true);
                        }), 5000
                    );
                        //h.error({ message: c.get('v.Err_Msg_of_OLI_is_Promo'),});       
                        return; 
                    }*/
                     if(Sample_Limitation_Error != ''){
                    h.error({ message: Sample_Limitation_Error ,});
                    return;  
                }
                if(chkAllIsSample){
                	h.error({ message: c.get('v.Sample_Products_tooltip'),});       
            		return;	        
                }        
         if(c.get('v.Minimum_Order_Value') > totalPriceForMiniOdrVal && !chkAllIsSample && c.get('v.Minimum_Order_Value') > 0 && buttonStatus != 'Draft'){
            h.error({ message: c.get('v.Warning_Message_Of_Minimum_Order_Value')/*'Order Qty (Cases) is greater than Available Qty.'*/,});       
            return;    
         }
                if(isCheckMaxDiscountAmtValid){
                    h.error({ message: 'Discount(s) exceeds maximum order limit of $'+c.get('v.Max_Discount_Value')+', please adjust discount to allowable limit.',});       
                    return;    
                }
        if(!validToSave4){
            c.set('v.uPriceSample',true);
            return;   
        }
        if(!validToSave3){
            c.set('v.uPriceTooLow',true);
            return;   
        }
        if(!validToSave){
            c.set('v.qtyTooLow',true);
            return;    
        }
        if(!validToSave2){
            h.error({ message: 'Quantity is not valid.',});       
            return; 
        }
        if(!validToSave1){
            h.error({ message: c.get('v.ERR_MSG_ORDER_QTY_GT_AVAILABLE_QTY')/*'Order Qty (Cases) is greater than Available Qty.'*/,});       
            return;    
        } 
         if(isBulkProd){
            h.error({ message: c.get('v.bulkProductErrorToolTip'),});       
            return;    
         }        
        
        var recordId = sessionStorage.getItem('retailDeliveryTicketId'); //c.get('v.recordId');
        console.log('recordId::', recordId);
        var isParentValid = h.isValid(c);
        console.log('isParentValid::', isParentValid);        
        var retailDeliveryTicketLineItems = c.find('retailDeliveryTicketLineItem');
        var isValid;
        isValid = []
        .concat(newRetailDeliveryTicket)
        .reduce(function (validSoFar, newRetailDeliveryTicket) {
            return validSoFar;
        }, true);        
        /*var newRDTLineItem = c.get('v.newRetailDeliveryTicketLineItems');
        newRDTLineItem.forEach(function(entry, index, object) {
			console.log('newRDTLineItem = ',newRDTLineItem);
			if(!entry.isSample){
				if(entry.productRecordTypeName == 'Product' && entry.salesPrice == 0.01 && (entry.parentProduct == undefined || entry.parentProduct == '')){
					//h.error({ message: 'Sale Price should not be $0.01 for regular products.'});
					isValid = false;
				}
			}
		}); */
        if (!isParentValid || !isValid) {
            return false;
        }        
        var newRetailDeliveryTicket = c.get('v.newRetailDeliveryTicket');
        if (!c.get('v.isDateChanged')) {
            var reqDate = c.get('v.reqTempDate');
            newRetailDeliveryTicket.requestShipDate = reqDate;
        } else {
            var reqDate = c.get('v.requestDateTimeHide');
            newRetailDeliveryTicket.requestShipDate = reqDate;
        }
        if(newRetailDeliveryTicket.requestShipDate == '' || !newRetailDeliveryTicket.isPreapproved){
                newRetailDeliveryTicket.requestShipDate=null;
            if(!newRetailDeliveryTicket.isPreapproved){
                newRetailDeliveryTicket.EarTime = '';
                newRetailDeliveryTicket.LatTime = '';
            }
         }
           //newRetailDeliveryTicket.Total_Excise_Tax_Amount =c.get('v.totalExcisetax');
        newRetailDeliveryTicket.factoringDiscount = c.get('v.factoringDiscount');
        c.set('v.newRetailDeliveryTicket', newRetailDeliveryTicket);        
        console.log('Items:', c.get('v.allNewRetailDeliveryTicketLineItems'));
        c.set('v.isShowSuccess',true);
        console.log('newRetailDeliveryTicket:', JSON.stringify(c.get('v.newRetailDeliveryTicket')));        
        h.request(c,'saveRetailDeliveryTicket',{
            recordId: recordId,
            retailDeliveryTicketData: JSON.stringify(c.get('v.newRetailDeliveryTicket')),
            retailDeliveryTicketLineItemsData: JSON.stringify(c.get('v.allNewRetailDeliveryTicketLineItems')),
            "salesRep":salesRep,"addBrandContact":addBrandContact,"addRetailContact":addRetailContact,
            "fromTransferOrders": false, "draftStatus": buttonStatus
        }, function (r) {
            $A.get('e.c:updateCartTotalEvt').setParams({ cartTotal: 0 }).fire();
            const modal = document.getElementById('success-modal');
            if (modal) modal.classList.add('is-active');
        }
                 );
    } catch (error) {
            console.log('Error:', error);
        }
                             },                             
onSelectChange: function (c, e, h) {
            var selectedContactIds = c.get('v.selectedContactIds');
            selectedContactIds = selectedContactIds.split(';');
            var newRetailDeliveryTicket = c.get('v.newRetailDeliveryTicket');
            newRetailDeliveryTicket.retailerContact = selectedContactIds[0];
            c.set('v.newRetailDeliveryTicket', newRetailDeliveryTicket);
            var otherReletecContactIds = [];
            for (var i = 1; i < selectedContactIds.length; i++) {
                otherReletecContactIds.push(selectedContactIds[i]);
            }
            c.set('v.otherReletecContactIds', otherReletecContactIds);
            console.log('Selected Contacts::', c.get('v.selectedContactIds'));
        },
            
            onCancel: function (c, e, h) {
                
                window.setTimeout($A.getCallback(function(){
                    var AllBreadCrumb = sessionStorage.getItem('AllBreadCrumb');
                    if(AllBreadCrumb){
                        AllBreadCrumb = JSON.parse(AllBreadCrumb);
                    }
                    
                    var screenName = 'View My Orders';
                    var matchedMenu = AllBreadCrumb.find((menu) => {
                        return menu.text == screenName;
                    });
                    console.log('screenName::',matchedMenu);
                    if(matchedMenu){
                        sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: matchedMenu.label, breadCrumbIds : matchedMenu.value}));
                        $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: matchedMenu.label, breadCrumbIds : matchedMenu.value}).fire();
                    }
                    var removeIdsFromCache = e.currentTarget.dataset.removeIdsFromCache;
                    console.log('removeIdsFromCache:',removeIdsFromCache);
                    if(removeIdsFromCache){
                        var Ids = removeIdsFromCache.split(',');
                        if(Ids.length){
                            Ids.forEach((id) => {
                                sessionStorage.removeItem(id);
                            });
                            }
                            }
                            }),100);
                                
                                var recordId = c.get('v.recordId');
                                if (recordId == '') {
                                $A.get('e.c:updateCartTotalEvt').setParams({ cartTotal: 0 }).fire();
                            h.request(c, 'removeProducts', {}, function (r) {}, {
                                showSpinner: false,
                                background: true,
                            });
                        }                  
                        
                        h.redirect('/brandorders', true);
                    },
                        
                        onPOBlur: function (c, e, h) {
                            var newRetailDeliveryTicket = c.get('v.newRetailDeliveryTicket');
                            console.log('onPOBlur:', newRetailDeliveryTicket.retailerPO.trim().length);
                            
                            newRetailDeliveryTicket.retailerPO = newRetailDeliveryTicket.retailerPO
                            ? newRetailDeliveryTicket.retailerPO.trim()
                            : '';
                            c.set('v.newRetailDeliveryTicket', newRetailDeliveryTicket);
                            e.getSource().set('v.validity', { valid: false, badInput: true });
                            e.getSource().showHelpMessageIfInvalid();
                        },
                            
                            showSuccessModal: function (c, e, h) {
                                const modal = document.getElementById('success-modal');
                                if (modal) modal.classList.add('is-active');
                            },
                                
                                setActiveTab: function (c, e,h) {
                                    var tab = e.getSource().getLocalId();
                                    c.set('v.activeTab', tab);
                                    c.set('v.searchString','');
                                    h.searchData(c, e);
                                    h.setPagination(c,e,h,false);
                                },
                                    
                                    onFactoringAssigneeChange: function (c, e, h) {
                                        console.log('onFactoringAssigneeChange:');
                                        //c.set('v.isEnable',false);
                                        var factoringAssigneeId = e.getSource().get('v.value');
                                        h.populateFactoringContacts(c,factoringAssigneeId);
                                        h.populateFactoringTerms(c,factoringAssigneeId);
                                    },
                                        
                                        onFactoringTermsChange: function (c, e, h) {
                                            h.populateChangeValues(c,e,h);
                                        },    
                                            
                                            onPaymentTermsChange: function (c, e, h) {
                                                //h.populateFactoringAssignees(c);
                                            },
                                                
                                                fetchProducts: function (c, e, h) {
                                                    var ids = e.getParam('ids');
                                                    console.log('fetchProducts ids::',ids);
                                                    let recSize = c.get('v.perPage');
                                                    let products = c.get('v.completeProducts');
                                                    let rdtLineItem = c.get('v.allNewRetailDeliveryTicketLineItems');
                                                    var arr = [];
                                                    
                                                    let tabName = c.get('v.activeTab'); 
                                                    if(tabName == 'all'){
                                                        for(let i = 0; i< products.length; i++){
                                                            if(ids.includes(products[i].id)){
                                                                arr.push(products[i]);
                                                            }
                                                        }
                                                        c.set('v.products',arr);
                                                    } else{
                                                        for(let i = 0; i< rdtLineItem.length; i++){
                                                            if(ids.includes(rdtLineItem[i].Product)){
                                                                arr.push(rdtLineItem[i]);
                                                            }
                                                        }
                                                        c.set('v.newRetailDeliveryTicketLineItems',arr);
                                                    }
                                                    //h.getProducts(c, ids);
                                                },
                                                    
                                                    onProductChange: function (c, e, h) {
                                                        c.set('v.qtyTooLow',false);
                                                        c.set('v.uPriceTooLow',false);
                                                        var dataset = e.currentTarget.dataset;
                                                        var productId = dataset.productid;
                                                        let qty = 1;
                                                        var isError = false;
                                                        var isErrorOfSalesPrice = false;
                                                        var isBulkProd =false;
                                                        var isSample = false;
                                                        var Sample_Limitation_Error='';
                                                        var isCheckMaxDiscountAmtValid = false;
                                                        let products = c.get('v.products');
                                                        let uPrice = 1;
                                                        let product;
                                                        const siteId = c.get('v.selectedWarehouse');
                                                        console.log('siteId:',siteId);
                                                        let totalInventry = 0;
                                                        products.forEach((item) => {
                                                            if(item.id == productId){
                                                            product = item;
                                                            return;
                                                        }
                                                                         })
                                                        try{
                                                            const warehouseAvailableInventoryMap = c.get('v.warehouseAvailableInventoryMap');
                                                            const warehouseTotalOrderedMap = c.get('v.warehouseTotalOrderedMap');
                                                            var warehouseDetails = warehouseAvailableInventoryMap[productId]||[];
                                                            let warehouseInventoryDetails = '';
                                                            let totalOrderedQty = 0;
                                                            warehouseDetails.forEach((item) => {
                                                                var key = item.id +'-'+productId;
                                                                
                                                                if(siteId == item.id){
                                                                totalOrderedQty = warehouseTotalOrderedMap[key] || 0;
                                                                totalInventry = item.availableInventory - totalOrderedQty;
                                                                if(product.MOQ > 0)
                                                                totalInventry = totalInventry / product.MOQ; 
                                                                if(totalInventry % 1 != 0)
                                                                totalInventry = totalInventry.toFixed(4);
                                                                totalInventry = parseFloat(totalInventry);
                                                            }
                                                                                     
                                                                                     });
                                                            
                                                            
                                                        }catch(error){
                                                            console.log('Error:',error);
                                                        }
                                                        
                                                        let newrdtClean = c.get('v.newRetailDeliveryTicket');
                                                        var licenseId = newrdtClean.stateLicense;
                                                        var statelicense ='';
                                                        if (licenseId) {
                                                            var statelicenses = c.get('v.statelicenses');
                                                            statelicense = statelicenses[licenseId].License_Type__c;
                                                            //alert(statelicense);
                                                        }
                                                        var allNewRetailDeliveryTicketLineItems = c.get('v.allNewRetailDeliveryTicketLineItems');
                                                        var countSameOdrQty = 0
                                                        for (var i = 0; i < allNewRetailDeliveryTicketLineItems.length; i++) {
                                                            if (allNewRetailDeliveryTicketLineItems[i].Product == productId){
                                                                countSameOdrQty += parseFloat(allNewRetailDeliveryTicketLineItems[i].orderQty);
                                                            }
                                                            
                                                        }
                                                        const SampleOrderFamilyMap = c.get('v.SampleOrderFamilyMap');
                                                        console.log('###SampleOrderFamilyMap :',SampleOrderFamilyMap);
                                                            var SampleOrderFamilyDetail = SampleOrderFamilyMap[product.productFamily]||null;
                                                        console.log('###SampleOrderFamilyDetail :',product.productFamily,' :: ',SampleOrderFamilyDetail);
                                                        let productsData = [];
                                                        products.forEach((item) => {
                                                            if(item.id == productId){
                                                            console.log('item = ',item);
                                                            qty = parseFloat(item.quantity);
                                                            isSample = item.isSample;
                                                            uPrice = item.salePrice;
                                                            const decimalPart =  qty % 1;
                                                            countSameOdrQty += qty;
                                                            console.log('decimalPart:',decimalPart);
                                                            console.log('QTY:',qty);
                                                            console.log('totalInventry:',totalInventry);
                                                            
                        									var MaxDiscountAmt = 0;
                                                            if(item.isDiscountProduct){
                                                            MaxDiscountAmt += item.salePrice * item.quantity * item.MOQ;
                                                        }
                                                        /*                 console.log('#1 : ',item.actualSalesPrice,'>',item.salePrice,'&&',item.isPromo);
                                                        if(item.actualSalesPrice > item.salePrice && item.isPromo != true){
                                                            item.isLIPromo = true;
                                                            console.log('item.isLIPromo',item.isLIPromo);
                                                            isErrorOfSalesPrice = true;
                                                        }else{
                                                            item.isLIPromo = false;
                                                        }*/
                											console.log('##SampleOrderFamilyDetail : ',item.isSample,SampleOrderFamilyDetail);
                                                        if(item.isSample && SampleOrderFamilyDetail != null ){
                                                            if(countSameOdrQty > SampleOrderFamilyDetail.Qty_Limit_Per_Order_Line__c){
                                                                var errMsg = c.get('v.Sample_Limitation_Error_Msg');
                                                                Sample_Limitation_Error = errMsg.replace('{0}', SampleOrderFamilyDetail.Name__c);
                                                                Sample_Limitation_Error = Sample_Limitation_Error.replace('{1}', SampleOrderFamilyDetail.Qty_Limit_Per_Order_Line__c);
                                                            }
                                                    }
                                                        
                                                            if(c.get('v.Max_Discount_Value') < MaxDiscountAmt && c.get('v.Max_Discount_Value') > 0 && item.isDiscountProduct){
                                                            
                                                            isCheckMaxDiscountAmtValid = true;
                                                        	}
                                                            
                                                            if(item.isBulkProduct && (statelicense == 'Type 10' || statelicense == 'Type 9')){
                                                            isBulkProd = true;
                                                        }
                                                            //alert(countSameOdrQty+'->-'+totalInventry);             
                                                            if(((decimalPart > 0 && qty != totalInventry) || qty > totalInventry ) && item.isDiscountProduct != true){
                                                            
                                                            isError= true;
                                                        }else if(qty > item.availableQty && item.isDiscountProduct != true){
                                                            isError= true;	
                                                        }else if(countSameOdrQty>totalInventry && item.isDiscountProduct != true){
                                                            isError= true;	
                                                        }
                                                        
                                                    }
                    //productsData.push(item);
                });       
                                   h.setProductsIsLIPromo(c,products,false);
                                 // c.set('v.products',productsData); 
                /*if(isErrorOfSalesPrice){
                    window.setTimeout(
                        $A.getCallback(function() {
                            h.setProductsIsLIPromo(c,productsData,false);
                        }), 5000
                    );
                    //h.error({ message: c.get('v.Err_Msg_of_OLI_is_Promo'),});       
                    return; 
                }*/
                console.log('##Sample_Limitation_Error : ',Sample_Limitation_Error);
                if(Sample_Limitation_Error != ''){
                    h.error({ message: Sample_Limitation_Error ,});
                    return;  
                }
                                  console.log('qty = ',uPrice);
                console.log('isError = ',isError);
                //uPriceTooLow
                if(isCheckMaxDiscountAmtValid){
                    h.error({ message: 'Discount(s) exceeds maximum order limit of $'+c.get('v.Max_Discount_Value')+', please adjust discount to allowable limit.',});       
                    return;   
                }
                
                if(uPrice <= 0){
                    c.set('v.uPriceTooLow',true);
                }/* else if(uPrice == 0.01 && !isSample){
            c.set('v.uPriceSample',true);
        } */else if(qty <= 0){
            c.set('v.qtyTooLow',true);
        }else if(isError){
            h.error({ message: c.get('v.ERR_MSG_ORDER_QTY_GT_AVAILABLE_QTY')/*'Order Qty (Cases) is greater than Available Qty'*/,});
            //h.showToast('error','','Order Qty (Cases) is greater than Available Qty');       
        }else if(isBulkProd){
            h.error({ message: c.get('v.bulkProductErrorToolTip'),});
        } /*else if(String(qty).indexOf('\.') >= 0){
            h.error({ message: 'Quantity is not valid.',});
        } */else {
            h.setProductDetails(c, productId, qty,true,h);
            h.processCalculations(c,true);
            //h.setPagination(c,e,h,false);
            h.calculateTotals(c);
            var allNewRDTLineItems = c.get('v.allNewRetailDeliveryTicketLineItems');
            
            $A.get('e.c:updateCartTotalEvt').setParams({cartTotal: allNewRDTLineItems.length}).fire();
        }
            }    
    });