({    
    calculateTotals: function(c){
        var h = this;
        c.set('v.isEnable',false);
        var newRetailDeliveryTicketLineItems = c.get('v.allNewRetailDeliveryTicketLineItems');//newRetailDeliveryTicketLineItems
        var newRetailDeliveryTicket = c.get('v.newRetailDeliveryTicket');
        const factoringRate = c.get('v.factoringRate');
        console.log('factoringRate::',factoringRate);
        let factoringDiscount = 0.00;
        let subTotal = 0;
        let grandTotal = 0;
        let totalExciseTax = 0;
        console.log('##length :',newRetailDeliveryTicketLineItems.length);
        newRetailDeliveryTicketLineItems.forEach(function(entry, index, object) {
            if(entry.Product){
                if(entry.isDiscountProduct){
                    subTotal -= entry.MOQ * entry.orderQty * entry.salesPrice ;
                }else{
                    subTotal += entry.MOQ * entry.orderQty * entry.salesPrice ;
                }
                
                if(!newRetailDeliveryTicket.excludeExciseTax){
                    if(!entry.isSample && entry.applyExciseTax != 'No'){
                        console.log('OLI:',entry); 
                        //totalExciseTax += parseFloat((entry.salesPrice * entry.orderQty * entry.MOQ),10) * (1.8) * (0.15);
                        //totalExciseTax += entry.isDiscountProduct? parseFloat(((entry.salesPrice * -1) * (1.8) * (0.15)),10).toFixed(2) * entry.orderQty * entry.MOQ : parseFloat((entry.salesPrice * (1.8) * (0.15)),10).toFixed(2) * entry.orderQty * entry.MOQ;
                        totalExciseTax += entry.isDiscountProduct? parseFloat(((entry.salesPrice * -1) * (1.8) * (0.15)),10).toFixed(3) * entry.orderQty * entry.MOQ : parseFloat((entry.salesPrice * (1.8) * (0.15)),10).toFixed(3) * entry.orderQty * entry.MOQ;
                        
                    }    
                }
            }
        });
        console.log('##subTotal::',subTotal);
        console.log('##totalExciseTax::',totalExciseTax);
        subTotal =  subTotal.toFixed(2);
        /*if(subTotal == 0){
            totalExciseTax =0;
        }*/
        totalExciseTax = totalExciseTax.toFixed(3);
        factoringDiscount  = (parseFloat(subTotal) + parseFloat(totalExciseTax)) * (factoringRate || 0) / 100;
        factoringDiscount = factoringDiscount.toFixed(2);
        console.log('##factoringDiscount::',factoringDiscount);
        //grandTotal = parseFloat(subTotal)  +parseFloat(totalExciseTax)  - factoringDiscount;
        grandTotal = parseFloat(subTotal)  +parseFloat(totalExciseTax);
        //subTotal = subTotal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",").toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")
        
        c.set('v.totalExcisetax',totalExciseTax);
        c.set('v.grandTotal',grandTotal.toFixed(2));
        c.set('v.subTotal',subTotal);
        c.set('v.factoringDiscount',factoringDiscount);
    },
    roundUp : function (c,num, precision) {
        
        precision = Math.pow(10, precision);
        return Math.ceil(num * precision) 
    }, 
    checkThirdParty : function (c) {
        if(c.get('v.recordId') != '' && c.get('v.recordId') != undefined){
            var newRetailDeliveryTicket2 = c.get('v.newRetailDeliveryTicket');
        h.request(c, 'getProductsByRetailerId', { recordId: c.get('v.recordId'),"fromTransferOrders":false}, function (r) {
            if(r.isThird_Party_Scheduler){
                newRetailDeliveryTicket2.isSample = false;
                newRetailDeliveryTicket2.isPreapproved = false;
                c.set('v.newRetailDeliveryTicket',newRetailDeliveryTicket2);
            }
            c.set('v.isThird_Party_Scheduler',r.isThird_Party_Scheduler);
        });
        }
        
    },
    processCalculations:function(c,isFromButton){
        var h = this;
        try{
            var newRetailDeliveryTicket = c.get('v.newRetailDeliveryTicket');
            if(isFromButton){
                if(!c.get('v.isDateChanged')){
                    var reqDate = c.get('v.reqTempDate');
                    newRetailDeliveryTicket.requestShipDate = reqDate;   	    
                } else {
                    var reqDate = c.get('v.requestDateTimeHide');
                    newRetailDeliveryTicket.requestShipDate = reqDate;    
                }    
            }
            if(c.get('v.reqTempDate') == ''){
                newRetailDeliveryTicket.requestShipDate = null;
            }
            console.log('RDT = ',JSON.stringify(newRetailDeliveryTicket));
            var selectedStateLicenseId = c.get('v.newRetailDeliveryTicket').stateLicense;
            h.request(c, 'calculateOrderProcessingFee', { satateLicenseId: selectedStateLicenseId,siteId:'',itemsJSON: JSON.stringify(c.get('v.allNewRetailDeliveryTicketLineItems')),orderJSON: JSON.stringify(newRetailDeliveryTicket),productJSON:JSON.stringify(c.get('v.completeProducts'))}, function (r) {
                try{
                    console.log('calculateOrderProcessingFee = ',r);
                    c.set('v.pickPackfee',r.totalPickPack.toFixed(2));
                    c.set('v.QAFee',r.totalQAReview.toFixed(2)); 
                    c.set('v.orderBookingFee',r.retailDeliveryTicket.orderBookingFee.toFixed(2));
                    c.set('v.stageAndManifestFee',r.retailDeliveryTicket.stageManifestFee.toFixed(2));
                    var packOutFee = r.retailDeliveryTicket.packOutFee;
                    var orderProcessingFee = r.totalPickPack + r.totalQAReview + r.retailDeliveryTicket.orderBookingFee + r.retailDeliveryTicket.stageManifestFee + r.retailDeliveryTicket.packOutFee;
                    var shippingFee = r.retailDeliveryTicket.scheduleDispatchFee + r.retailDeliveryTicket.totalMileageFee + r.retailDeliveryTicket.totalWeightFee;
                    var totalServicesfee = orderProcessingFee + shippingFee;
                    c.set('v.shippingFee',shippingFee.toFixed(2));
                    c.set('v.orderProcessingFee',orderProcessingFee.toFixed(2));
                    c.set('v.totalServicesfee',totalServicesfee.toFixed(2));
                    var subTotal = c.get('v.subTotal');
                    //subTotal = subTotal.replace(/,/g, "");
                    if(subTotal > 0){
                        var distribution = totalServicesfee/parseFloat(subTotal);
                        distribution = distribution * 100;
                        c.set('v.distribution',distribution.toFixed(1));
                    }
                    
                    var orderInfo = '<table>';
                    orderInfo += '<tr><td style="text-align:right">Order Booking: &nbsp;</td><td> $'+r.retailDeliveryTicket.orderBookingFee.toFixed(2)+'</td></tr>';
                    orderInfo += '<tr><td style="text-align:right">Pack Out Fee: &nbsp;</td><td> $'+r.retailDeliveryTicket.packOutFee.toFixed(2)+'</td></tr>';
                    orderInfo += '<tr><td style="text-align:right">Pick & Pack: &nbsp;</td><td> $'+r.totalPickPack.toFixed(2)+'</td></tr>';
                    orderInfo += '<tr><td style="text-align:right">QA Review: &nbsp;</td><td> $'+r.totalQAReview.toFixed(2)+'</td></tr>';
                    orderInfo += '<tr><td style="text-align:right">Stage & Manifest: &nbsp;</td><td> $'+r.retailDeliveryTicket.stageManifestFee.toFixed(2)+'</td></tr>';
                    orderInfo += '</table>';
                    c.set('v.orderInfo',orderInfo);
                    c.set('v.newRetailDeliveryTicket',r.retailDeliveryTicket);
                    c.set('v.allNewRetailDeliveryTicketLineItems',r.retailDeliveryTicketLineItems);
                    
                    let newrdt = c.get('v.newRetailDeliveryTicket');
                    let retailersDetailMap = c.get('v.retailersDetail');
                    let retailersDetail = retailersDetailMap[newrdt.retailer];
                    console.log('retailersDetail:', retailersDetail);
                    let licenseId = newrdt.stateLicense;
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
                    newrdt.factoringRate = c.get('v.factoringRate');
                    newrdt.factoringDiscount = c.get('v.factoringDiscount');
                    c.set('v.newRetailDeliveryTicket', newrdt);
                    
                    window.setTimeout($A.getCallback(function(){
                        c.set('v.isEnable',true);
                    }),500)
                }catch(err){
                    console.log('err:',err);
                }
            });
            
        }catch(err){
            console.log('Error:',err);
        }
    },    
    calculateMiles : function(c,sourceAddress,destination){
        /*console.log('sourceAddress ',sourceAddress);
        console.log('destination ',destination);
        this.request(c, 'getDistance', { sAddress: sourceAddress,dAddress: destination}, function (r) {
            try{
            console.log('getDistance:',r);
            
            if(r.miles)c.set('v.routeMiles',r.miles);
            var routeMiles = c.get('v.routeMiles');
            var newRetailDeliveryTicket = c.get('v.newRetailDeliveryTicket');
            newRetailDeliveryTicket.Route_Miles = routeMiles;
            console.log('routeMiles:',routeMiles);
            c.set('v.newRetailDeliveryTicket',newRetailDeliveryTicket);
            }catch(err){console.log('Error:',err);}
        });*/
    },    
    applyDate : function(c) {
        var h = this;
        try{            
            var recordId = c.get('v.recordId');
            var isDataLoaded = c.get('v.isDataLoaded');
            console.log('applyDate...',isDataLoaded);
            
            if(isDataLoaded ){                
                var cutOffTime = c.get('v.cutOffTime');
                var date = new Date();
                //var date = new Date('2021-10-26 11:47:00');
                var hours = date.getHours();
                var minutes = date.getMinutes();                
                console.log('dATE = ',date);   
                console.log('cutOffTime...',cutOffTime);
                console.log('date.getDay()...',date.getDay());
                if(cutOffTime != '' && cutOffTime != undefined && cutOffTime != null){
                    var timeSlot = cutOffTime.split(" ");
                    var tFormat = timeSlot[0].substring(timeSlot[0].length - 2);
                    var ttime = timeSlot[0].substring(0,timeSlot[0].length - 2);                    
                    var tminutes;
                    
                    if(tFormat == 'PM'){
                        if(ttime.includes(":")){
                            let timeS = ttime.split(":"); 
                            ttime = +timeS[0] + 12;
                            tminutes = timeS[1];
                            //ttime = ttime + ':'+timeS[1];
                        } else{
                            ttime = +ttime + 12;  
                        }	    
                    } else {
                        if(ttime.includes(":")){
                            let timeS = ttime.split(":"); 
                            tminutes = timeS[1];
                            ttime = +timeS[0];    
                        }    
                    }
                    if(date.getDay() == 5){
                        if(hours > ttime){
                            date.setDate(date.getDate() + 5);       
                        } else if(hours == ttime){
                            if(minutes > tminutes) date.setDate(date.getDate() + 5);
                            else date.setDate(date.getDate() + 4);
                        } else {
                            date.setDate(date.getDate() + 4);    
                        }
                    } else if(date.getDay() == 6 || date.getDay() == 0){
                        if(date.getDay() == 6) date.setDate(date.getDate() + 4);
                        if(date.getDay() == 0) date.setDate(date.getDate() + 3);
                    } else {
                        console.log('hours...',hours);
                        console.log('ttime...',ttime);
                        if(hours <= ttime && minutes <= tminutes){
                            date.setDate(date.getDate() + 2);
                            console.log('date.getDay() ',date.getDay());
                        } else if(hours > ttime){
                            date.setDate(date.getDate() + 3);
                            console.log('date.getDay() ',date.getDay());
                        } else if(hours == ttime){
                            if(minutes > tminutes) date.setDate(date.getDate() + 5);
                            else date.setDate(date.getDate() + 4);
                        } else {
                            date.setDate(date.getDate() + 2); 
                        }
                    }    
                } else {
                    if(date.getDay() == 5){
                        date.setDate(date.getDate() + 5);      
                    } else {
                        date.setDate(date.getDate() + 2);      
                    }    
                }         
                
                if(c.get('v.newRetailDeliveryTicket').requestShipDate != undefined && c.get('v.newRetailDeliveryTicket').requestShipDate != null){
                    
                    var requestShipDate = c.get('v.newRetailDeliveryTicket').requestShipDate;
                    console.log('requestShipDate'+requestShipDate);
                    var datearray = requestShipDate.split("-");
                    var newdate = datearray[1] + '-' + datearray[2] + '-' + datearray[0];
                    
                    c.set('v.requestDateTime',newdate); 
                    var newRetailDeliveryTicket = c.get('v.newRetailDeliveryTicket');
                    c.set('v.reqTempDate',newRetailDeliveryTicket.requestShipDate);
                    newRetailDeliveryTicket.requestShipDate = newdate;
                    c.set('v.newRetailDeliveryTicket',newRetailDeliveryTicket);
                }
                var disableDates = c.get('v.holidayList');
                if((recordId != '' && recordId != undefined ) || c.get('v.isClone') == 'True'){
                    var minDates = c.get('v.newRetailDeliveryTicket').requestShipDate;
                    
                    console.log('minDates = '+minDates);
                    $('#datepickerId').datepicker({
                        dateFormat: 'mm-dd-yy',
                        defaultDate : minDates,
                        minDate: date,
                        beforeShowDay: function(mdate){
                            var dmy = (mdate.getMonth() + 1) + "-" + mdate.getDate() + "-" + mdate.getFullYear();
                            console.log('dmy:',dmy);
                            if(mdate.getDay() == 0 || mdate.getDay()== 6){
                                return [false, '', ''];    
                            }
                            if(disableDates.indexOf(dmy) != -1){
                                return [false, '', ''];//return false;
                            }
                            else{
                                return [true,'',''];
                            }
                        } 
                    }); 
                    
                    $('#datepickerId').datepicker("setDate",minDates);
                } else {
                    $('#datepickerId').datepicker({
                        dateFormat: 'mm-dd-yy',
                        minDate: date,
                        beforeShowDay: function(mdate){
                            var dmy = (mdate.getMonth() + 1) + "-" + mdate.getDate() + "-" + mdate.getFullYear();
                            console.log('dmy:',dmy);
                            if(mdate.getDay() == 0 || mdate.getDay()== 6){
                                return [false, '', ''];    
                            }
                            if(disableDates.indexOf(dmy) != -1){
                                return [false, '', ''];//return false;
                            }
                            else{
                                return [true,'',''];
                            }
                        }
                    });    
                }                                
                $("#datepickerId").change(function(){
                    if($('#datepickerId').val() != ''){
                        var reqDate = c.get('v.requestDateTime');
                        reqDate = $('#datepickerId').val();
                        c.set('v.requestDateTime',reqDate);
                        console.log('reqDate = ',reqDate)
                        var datearray = reqDate.split("-");
                        reqDate = datearray[2] + '-' + datearray[0] + '-' + datearray[1];                        
                        console.log('reqDate = ',reqDate);
                        c.set('v.requestDateTimeHide',reqDate);
                        c.set('v.isDateChanged',true);                        
                        /*var newRetailDeliveryTicket = c.get('v.newRetailDeliveryTicket');
                    	newRetailDeliveryTicket.requestShipDate = reqDate;
                    	c.set('v.newRetailDeliveryTicket',newRetailDeliveryTicket);*/
                    }else{
                        c.set('v.requestDateTime','');
                    }
                });                
            }else{
                
                window.setTimeout($A.getCallback(function(){
                    h.applyDate(c);
                }),100);
                
            }
        }catch(err){console.log('Error:',err)}
    },    
    setPagination : function(c,e,h,fromInit){
        var filters = { orderByField: 'product.name', isASC: true };
        c.set('v.filters', filters);
        let products = c.get('v.completeProducts');
        let rdtLineItems = c.get('v.allNewRetailDeliveryTicketLineItems');
        let setOfIds = [];
        rdtLineItems.forEach((itemRec) => {
            setOfIds.push(itemRec.Product);
        });            
		let arr = [];
		let tabName = c.get('v.activeTab'); 
		if(tabName == 'all'){
            if(fromInit){
            	products.forEach((item) => {
            		arr.push(item.id);
        		});
        	} else {
            	products.forEach((item) => {
            		//if(!setOfIds.includes(item.id)){
            			arr.push(item.id);
        			//}
        		});
        	}
            h.initPagination(c, arr, filters);
        } else {
            h.initPagination(c, setOfIds, filters,'paginatorActive');
        }  
	},            
	searchData: function (c, e) {
		let searchText = c.get('v.searchString');
		c.set('v.isSearchCalled',true);                
		let tabName = c.get('v.activeTab');
		let allData = [];                
		if(tabName != 'active')
			allData = c.get('v.allProducts');
		else
			allData = c.get('v.allNewRetailDeliveryTicketLineItems');  
        console.log('searchedData::',allData);
        //h.setProductsIsLIPromo(c,allData,(tabName != 'active' ? false : true));
		let searchedData = [];
		for(var i=0; i<allData.length; i++){                
			if(searchText != ''){
				var a ;                        
                if(tabName != 'active')
                    a = ''+allData[i].salePrice;
                else 
                    a = ''+allData[i].salesPrice;
                
                var b = ''+searchText;                        
                if(allData[i].shortDescription != undefined && allData[i].shortDescription.toLowerCase().includes(searchText.toLowerCase())){
                    searchedData.push(allData[i]);
                }else if(allData[i].name != undefined && allData[i].name.toLowerCase().includes(searchText.toLowerCase())){
                    searchedData.push(allData[i]);
                }/*else if(allData[i].productFamily != undefined && allData[i].productFamily.toLowerCase().includes(searchText.toLowerCase())){
                    searchedData.push(allData[i]);
                }*/else if(a != undefined && a.includes(b)){
                    searchedData.push(allData[i]);
                }
			}else{
				searchedData.push(allData[i]);   
			}
		}
        
        if(tabName != 'active'){
            c.set('v.products',searchedData);
        } else {
            c.set('v.newRetailDeliveryTicketLineItems',searchedData);  
        }
        c.set('v.isProcessing',false);
    },            
	setProductDetails: function(c, productId, quantity,productChanged,h){
        const newRetailDeliveryTicket = c.get('v.newRetailDeliveryTicket');
        var product = undefined;
        var products = c.get('v.products');
        var allProducts = c.get('v.allProducts');
        //var removeProducts = c.get('v.removeProducts');
        var a = c.get('v.newRetailDeliveryTicketLineItems');
        var retailDeliveryTicketLineItem = Object.assign({}, c.get('v.newRDTLI'));   
        console.log('##allProducts ',allProducts.length);
        /*for (var i = 0; i < allProducts.length; i++) {
            if (allProducts[i].id == productId) {
                //allProducts.splice(i, 1);
                break;
            }
        } */
        for (var i = 0; i < products.length; i++) {
            if (products[i].id == productId) {
                product = products[i];
                //removeProducts.push(products[i]);
                //products.splice(i, 1);
                break;
            }
        }
        c.set('v.products',products);
        c.set('v.allProducts',allProducts);
        //c.set('v.removeProducts',removeProducts);  
        let uPrice =product.salePrice;
        if(product.isSample){
            uPrice = 0.01;
        }
        console.log('product.isSample::',product.isSample)
        console.log('##product.isDiscountProduct ',product.isSample ,'--',product.salePrice);
        var addToCartData = {productId: product.id,
                             pricebookId: product.price.id,
                             quantity:  quantity,
                             MOQ: product.MOQ,
                             unitPrice: uPrice,
                             isUpdate: false,
                             isSample: product.isSample,
                             isPromo: product.isPromo,
                             isDiscountProduct:product.isDiscountProduct,
                             isBulkProduct:product.isBulkProduct,
                             retailerId:newRetailDeliveryTicket.retailer};                
        h.request(c, 'addToCart', {addToCartData: JSON.stringify(addToCartData)}, function(r){
            console.log('quantity=');
        });          
        
        var warehouseAvailableInventoryMap = c.get('v.warehouseAvailableInventoryMap');
        var warehouseTotalOrderedMap = c.get('v.warehouseTotalOrderedMap');
        var warehouseDetails = [];
        var flag = false;
        if(product.isSample == undefined){
            product.isSample = false;
        }
        retailDeliveryTicketLineItem.isDiscountProduct =product.isDiscountProduct;
        retailDeliveryTicketLineItem.listPrice = product.price.unitPrice;
        retailDeliveryTicketLineItem.isBulkProduct = product.isBulkProduct;
        if(product.isSample){
            retailDeliveryTicketLineItem.originalSalesPrice = 0.01; 
            retailDeliveryTicketLineItem.salesPrice = 0.01;    
            retailDeliveryTicketLineItem.hasSampleChild = true;
            retailDeliveryTicketLineItem.isSample=true;
        } else {
            retailDeliveryTicketLineItem.originalSalesPrice = product.salePrice; 
            console.log('Assigning Sales Price:',product.salePrice);
            if(productChanged || retailDeliveryTicketLineItem.salesPrice == undefined || retailDeliveryTicketLineItem.originalSalesPrice == retailDeliveryTicketLineItem.salesPrice ){
                retailDeliveryTicketLineItem.salesPrice = product.salePrice; 
            }                    
            retailDeliveryTicketLineItem.hasSampleChild = false;
            retailDeliveryTicketLineItem.isSample=false;
        }
        retailDeliveryTicketLineItem.Product = product.id;
        warehouseDetails = warehouseAvailableInventoryMap[product.id]||[];
        retailDeliveryTicketLineItem.MOQ = product.MOQ;
        if(product.maxOrderAllowed != undefined)
            retailDeliveryTicketLineItem.maxOrderAllowed = product.maxOrderAllowed / product.MOQ;
        else
            retailDeliveryTicketLineItem.maxOrderAllowed = 0;
        retailDeliveryTicketLineItem.orderQty = quantity;
        retailDeliveryTicketLineItem.actualSalesPrice = product.actualSalesPrice;
        retailDeliveryTicketLineItem.availableInventory = product.availableInventory;
        retailDeliveryTicketLineItem.productRecordTypeName = product.recordTypeName;
        retailDeliveryTicketLineItem.parentProduct = product.parentProductId;
        retailDeliveryTicketLineItem.availableQty = product.availableQty||0;
        retailDeliveryTicketLineItem.ProductBookEntryId = product.price.id;
        retailDeliveryTicketLineItem.isSample = product.isSample;
        retailDeliveryTicketLineItem.isProductSample = product.isProductSample;
        retailDeliveryTicketLineItem.productFamily = product.productFamily;
        retailDeliveryTicketLineItem.name = product.name;
        retailDeliveryTicketLineItem.productName = product.name;
        retailDeliveryTicketLineItem.applyExciseTax = product.applyExciseTax;
        retailDeliveryTicketLineItem.brandName = product.brandName;
        retailDeliveryTicketLineItem.brandId = product.brandId;
        retailDeliveryTicketLineItem.imageUrl = product.imageUrl;
        retailDeliveryTicketLineItem.priceBookid = product.price.id;
        retailDeliveryTicketLineItem.shortDescription = product.shortDescription;
        retailDeliveryTicketLineItem.isPromo = product.isPromo;
        var totalInventory = retailDeliveryTicketLineItem.availableQty/retailDeliveryTicketLineItem.MOQ;
        if(totalInventory % 1 != 0)
            totalInventory = totalInventory.toFixed(4);
        retailDeliveryTicketLineItem.cases = totalInventory;
        retailDeliveryTicketLineItem.description = product.description;        
        let warehouseInventoryDetails = '';
        let lineBreak = '';                
        warehouseDetails.forEach((item) => {
            console.log('item::',item);            
            var totalOrderedQty = 0;
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
                if(product.MOQ > 0)
                    totalInventry = totalInventry / product.MOQ; 
                if(totalInventry % 1 != 0)
                    totalInventry = totalInventry.toFixed(4);
                console.log('Total Ordered Qty:',totalOrderedQty);
                //warehouseInventoryDetails = warehouseInventoryDetails +lineBreak + item.name+' - Available Qty : '+(item.availableInventory - totalOrderedQty)+' ';//+lineBreak;
                warehouseInventoryDetails = warehouseInventoryDetails +lineBreak + itemNm +': '+ totalInventry +' Cases ';//+lineBreak;
                lineBreak = '<br/>';
            }
        });
		c.set('v.warehouseInventoryDetails',warehouseInventoryDetails);    
		c.set('v.warehouseDetails',warehouseDetails);
		retailDeliveryTicketLineItem.warehouseInventoryDetails = warehouseInventoryDetails; 
        
		a.push(retailDeliveryTicketLineItem);
		c.set('v.newRetailDeliveryTicketLineItems',a);
		var b = c.get('v.allNewRetailDeliveryTicketLineItems');
        var isSameProduct=false;
        for (var i = 0; i < b.length; i++) {
            console.log('##SameProduct',product.salePrice,'----',product.isSample,'---',b[i].isSample);
         	if(b[i].Product == product.id && (b[i].salesPrice == product.salePrice || b[i].salesPrice == 0.01 ) && b[i].isSample == product.isSample){
            	 b[i].orderQty += quantity;
            	isSameProduct=true;
        	} 
        }
        if(!isSameProduct)
			b.push(retailDeliveryTicketLineItem);
		c.set('v.allNewRetailDeliveryTicketLineItems',b);  
            
            
		var retailDeliveryTicket = c.get('v.newRetailDeliveryTicket');
		let grandTotal = 0;
		let totalExciseTax = 0;
		let subTotal = 0;
		subTotal += a.reduce(
			(currentValue, item) => {
				if (!retailDeliveryTicket.excludeExciseTax) {
					if (!item.isSample && item.applyExciseTax != 'No') {
						/*totalExciseTax += parseFloat(item.salesPrice * item.orderQty * item.MOQ, 10) * 1.8 * 0.15;*/
						//totalExciseTax += parseFloat((item.salesPrice * (1.8) * (0.15)),10).toFixed(2) * item.orderQty * item.MOQ;
						totalExciseTax += item.isDiscountProduct?  parseFloat(((item.salesPrice * -1) * (1.8) * (0.15)),10).toFixed(3) * item.orderQty * item.MOQ : parseFloat((item.salesPrice * (1.8) * (0.15)),10).toFixed(3) * item.orderQty * item.MOQ;
					}
				}
				return (
                    parseFloat(currentValue, 10) +
                    parseFloat(item.salesPrice * item.orderQty * item.MOQ, 10)
            	);
            	grandTotal += subTotal + totalExciseTax;
        	},
            0.0
		);
		subTotal = subTotal.toFixed(2);
            /*if(subTotal == 0){
            totalExciseTax =0;
        }*/
		totalExciseTax = totalExciseTax.toFixed(3);
         
		c.set('v.grandTotal', grandTotal.toFixed(2));
		c.set('v.grandTotalDiscount', grandTotal);
		c.set('v.totalExcisetax', totalExciseTax);
		//c.set('v.subTotal',subTotal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));  
		c.set('v.subTotal',subTotal);              
		$A.get('e.c:updateRDTSubTotal').fire();
	},                    
	populateFactoringAssignees : function(c){
        //debugger;
        const newRetailDeliveryTicket = c.get('v.newRetailDeliveryTicket');
        let retailerFactoringAssignees = [];
        const factoringRelationships = c.get('v.factoringRelationships');
        console.log('#####1, ',factoringRelationships);
        retailerFactoringAssignees = factoringRelationships.filter((fr) => {
            return fr.Buyer_Account__c === newRetailDeliveryTicket.retailer;
        });
        console.log('retailerFactoringAssignees = ',retailerFactoringAssignees);
        retailerFactoringAssignees.forEach((fa) => {
            fa.id = fa.Factoring_Assignee__c;
            fa.name = fa.Factoring_Assignee__r.DBA__c;
        });                            
		/*retailerFactoringAssignees.forEach((fa) => {
            let fAssigneeRates = fa.Factoring_Rates__r ||[];
            console.log('#####2, ',fAssigneeRates);
            fAssigneeRates = fAssigneeRates.filter((fr) => {
                return fr.Payment_Terms__c === newRetailDeliveryTicket.paymentTerms;
            });
        	fa.factoringRate = fAssigneeRates.length ? fAssigneeRates[0].Factoring_Rate__c.toFixed(2):0.00;
    	});
    	retailerFactoringAssignees = retailerFactoringAssignees.filter((fr) => {
    		return fr.factoringRate !== undefined;
        });*/
		c.set('v.factoringAssignees', retailerFactoringAssignees);
	},                    
	populateFactoringContacts : function(c,factoringAssigneeId){
        var factoringRelationshipContactsMap = c.get('v.factoringRelationshipContactsMap');
        console.log('factoringRelationshipContactsMap:',factoringRelationshipContactsMap)
        var contacts = factoringRelationshipContactsMap ? factoringRelationshipContactsMap[factoringAssigneeId] : undefined;                        
        if(contacts != undefined){
            contacts.forEach((fa) => {
                fa.id = fa.Id;
                fa.name = fa.Name;
                fa.selected = false;
            });
		}
		console.log('contacts::',contacts);                                
		var newRetailDeliveryTicket = c.get('v.newRetailDeliveryTicket');                                
		var factoringAssignees = c.get('v.factoringAssignees');
		const selectedFA = factoringAssignees.find((fa) => {
			if(fa.Factoring_Assignee__c == factoringAssigneeId){
                newRetailDeliveryTicket.factoringAssigneeName = fa.Factoring_Assignee__r.DBA__c;
            }        
			return fa.Factoring_Assignee__c == factoringAssigneeId;
		});
		console.log('selectedFA::',JSON.stringify(selectedFA));
		c.set('v.factoringRate',selectedFA ?selectedFA.factoringRate : 0.00);                                
		newRetailDeliveryTicket.factoringAssigneeId  = factoringAssigneeId;
		c.set('v.newRetailDeliveryTicket',newRetailDeliveryTicket);
		c.set('v.factoringRelationshipContacts',contacts);                                
		if(factoringAssigneeId == ''){
			c.set('v.factoringDiscount',0.00);
		}
	},                                              
	populateFactoringTerms : function(c,factoringAssigneeId){
		var factoringAssignees = c.get('v.factoringAssignees');
		var a = [];
		factoringAssignees.find((fa) => {
            if(fa.Factoring_Assignee__c == factoringAssigneeId){
            	console.log('fa.Factoring_Rates__r = ',fa.Factoring_Rates__r);
            	a = fa.Factoring_Rates__r;
            	a.forEach((far) => {
            		far.id = far.Payment_Terms__c;
            		far.name = far.Payment_Terms__c +' - '+far.Factoring_Rate__c + '%';
            		far.selected = false;
        		});
                //c.set('v.factoringRelationshipTerms',a);
            }
        });
        c.set('v.factoringRelationshipTerms',a);
    },                     
	populateChangeValues : function (c, e, h) {                        
        let factoringRelationshipTerms = c.get('v.factoringRelationshipTerms');
        let newRetailDeliveryTicket = c.get('v.newRetailDeliveryTicket');
        let factoringAssignees = c.get('v.factoringAssignees');
        console.log('factoringTerms = ',newRetailDeliveryTicket.factoringTerms);
        factoringAssignees.forEach((fa) => {
            if(fa.Factoring_Assignee__c === newRetailDeliveryTicket.factoringAssigneeId){
                let fAssigneeRates = [];	
                fAssigneeRates = factoringRelationshipTerms.filter((frt) => {
                	return frt.Payment_Terms__c === newRetailDeliveryTicket.factoringTerms;
        		});                        
        		fa.factoringRate = fAssigneeRates.length ? fAssigneeRates[0].Factoring_Rate__c.toFixed(2):0.00;
        		c.set('v.factoringRate',fa.factoringRate);
        		newRetailDeliveryTicket.factoringRate = fa.factoringRate;
        		//newRetailDeliveryTicket.factoringTerms = newRetailDeliveryTicket.factoringTerms +' - '+fa.factoringRate + '%';
    		}
        });
        factoringAssignees = factoringAssignees.filter((fr) => {
            return fr.factoringRate !== undefined;
        });
        c.set('v.factoringAssignees', factoringAssignees);
        c.set('v.newRetailDeliveryTicket',newRetailDeliveryTicket);
        h.calculateTotals(c);
    },         
	sortAllProducts : function(c,e,h,allProducts,sortType){
        allProducts.sort(function (a, b) {
            const bandA = a.brandName.toUpperCase();
            const bandB = b.brandName.toUpperCase();            
            let comparison = 0;
            if (bandA > bandB) {
                comparison = 1;
            } else if (bandA < bandB) {
                comparison = -1;
            }
            if(sortType == 'ASC')
                return comparison;
            else
                return comparison * -1;
        }) 
		return allProducts;
    },
	setMsgValue : function(c, retailer){
        
    	if(retailer.QR_Code__c && !retailer.Bar_Code__c ){
            c.set('v.BarCodeORQRCodeMSG', c.get('v.Orders_Requiring_QR_Codes'));    
        }else if(!retailer.QR_Code__c && retailer.Bar_Code__c ){
            c.set('v.BarCodeORQRCodeMSG', c.get('v.Orders_Requiring_Bar_Codes'));        
        }else if(retailer.QR_Code__c && retailer.Bar_Code__c ){
            c.set('v.BarCodeORQRCodeMSG', c.get('v.Orders_Requiring_BarCodes_and_or_QR_Code'));        
        }/*else if(retailer.QR_Code__c && !retailer.Bar_Code__c && retailer.Third_Party_Scheduler__c){
            c.set('v.BarCodeORQRCodeMSG', c.get('v.Orders_Requiring_TPS_and_or_QR_Code'));        
        }else if(!retailer.QR_Code__c && retailer.Bar_Code__c && retailer.Third_Party_Scheduler__c){
            c.set('v.BarCodeORQRCodeMSG', c.get('v.Orders_Requiring_TPS_and_or_Bar_Code'));        
        }else if(retailer.QR_Code__c && retailer.Bar_Code__c && retailer.Third_Party_Scheduler__c){
            c.set('v.BarCodeORQRCodeMSG', c.get('v.Orders_Requiring_TPS_and_Bar_Code_and_QR'));        
        }*/else{
        	c.set('v.BarCodeORQRCodeMSG', '');            
        } 
        if(retailer.Third_Party_Scheduler__c){
            c.set('v.ThirdPartySchedulerMSG', c.get('v.Orders_Requiring_Third_Party_Scheduler'));        
        }else{
            c.set('v.ThirdPartySchedulerMSG', ''); 
        }
	},
            setProductsIsLIPromo: function(c, products,isRDTLIs){
                let p = [];
                products.forEach((item) => {
                    item.isLIPromo = false;
                    p.push(item);
                });
                    if(isRDTLIs){
                    c.set('v.newRetailDeliveryTicketLineItems',p);
                        //c.set('v.allNewRetailDeliveryTicketLineItems',p);
                }else{
                    c.set('v.products',p);
                }
            }
})