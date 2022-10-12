({
    setSiteAddesss:function(c,h){
    	let siteMap = c.get('v.siteMap');
        console.log('dsdsdsds',c.get('v.newRetailDeliveryTicket').siteId);
        let siteDetail = siteMap[c.get('v.newRetailDeliveryTicket').siteId];
        console.log('dsdsdsds1',siteDetail);
        if(siteDetail){
            let rdt = c.get('v.newRetailDeliveryTicket');
            let lAddress = '';
            /*if(siteDetail.License_ID__c == c.get('v.newRetailDeliveryTicket').stateLicense){
                h.error({message:c.get('v.Err_Msg_of_Ship_To_and_Origin_Site')});  
                rdt.siteAddress = lAddress;
                c.set('v.newRetailDeliveryTicket',rdt);
            	return;
            }*/
            if(siteDetail.License_ID__c){
                lAddress = siteDetail.License_ID__r.License_Number__c + ' | ';
                if(siteDetail.License_ID__r.License_Address__c != undefined){
                    lAddress += siteDetail.License_ID__r.License_Address__c;
                }
                if(siteDetail.License_ID__r.License_City__c != undefined){
                    lAddress+= ', ' + siteDetail.License_ID__r.License_City__c;
                }
                if(siteDetail.License_ID__r.License_State__c != undefined){
                    lAddress+= ', ' + siteDetail.License_ID__r.License_State__c;
                }
                if(siteDetail.License_ID__r.License_Country__c != undefined){
                    lAddress+= ', ' + siteDetail.License_ID__r.License_Country__c;
                }
                if(siteDetail.License_ID__r.License_Zip__c != undefined){
                    lAddress+= ', ' + siteDetail.License_ID__r.License_Zip__c;
                }
            }
            //let rdt = c.get('v.newRetailDeliveryTicket');
            rdt.siteAddress = lAddress;
            c.set('v.newRetailDeliveryTicket',rdt);
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
            console.log('Site:',newRetailDeliveryTicket.siteId);
            var selectedStateLicenseId = c.get('v.newRetailDeliveryTicket').stateLicense;
            h.request(c, 'calculateOrderProcessingFee', { satateLicenseId: selectedStateLicenseId,siteId:newRetailDeliveryTicket.siteId,itemsJSON: JSON.stringify(c.get('v.allNewRetailDeliveryTicketLineItems')),orderJSON: JSON.stringify(newRetailDeliveryTicket),productJSON:JSON.stringify(c.get('v.completeProductsList')),fromTransfer:true}, function (r) {
                try{
                    console.log('calculateOrderProcessingFee:',r);
                    c.set('v.pickPackfee',r.totalPickPack.toFixed(2));
                    c.set('v.QAFee',r.totalQAReview.toFixed(2)); 
                    c.set('v.orderBookingFee',r.retailDeliveryTicket.orderBookingFee.toFixed(2));
                    c.set('v.stageAndManifestFee',r.retailDeliveryTicket.stageManifestFee.toFixed(2));
                    var packOutFee = r.retailDeliveryTicket.packOutFee;
                    var orderProcessingFee = r.totalPickPack + r.totalQAReview + r.retailDeliveryTicket.orderBookingFee + r.retailDeliveryTicket.stageManifestFee + r.retailDeliveryTicket.packOutFee;
                    let brandPlatformLevel = c.get('v.brandPlatformLevel');
                    var shippingFee = r.retailDeliveryTicket.scheduleDispatchFee + r.retailDeliveryTicket.totalMileageFee + r.retailDeliveryTicket.totalWeightFee;
                    var totalServicesfee = orderProcessingFee + shippingFee;
                    c.set('v.shippingFee',shippingFee.toFixed(2));
                    c.set('v.orderProcessingFee',orderProcessingFee.toFixed(2));
                    c.set('v.totalServicesfee',totalServicesfee.toFixed(2));
                    var subTotal = c.get('v.subTotal');
                    var distribution = totalServicesfee/parseFloat(subTotal);
                    distribution = distribution * 100;
                    c.set('v.distribution',distribution.toFixed(1));
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
                    h.setShippingAdd(c,selectedStateLicenseId);   
                    h.setSiteAddesss(c);
                    window.setTimeout($A.getCallback(function(){
                    }),500)
                }catch(err){
                    console.log('err:',err);
                }
            });            
        }catch(err){
            console.log('Error:',err);
        }
    },
    setShippingAdd:function(c,licenseId){
    	let newrdt = c.get('v.newRetailDeliveryTicket');
        let retailersDetailMap = c.get('v.retailersDetail');
        let retailersDetail = retailersDetailMap[newrdt.retailer];
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
        newrdt.shippingAddress = lAddress;
        c.set('v.newRetailDeliveryTicket', newrdt);
	},
    calculateMiles : function(c,sourceAddress,destination){},    
    applyDate : function(c) {
        var h = this;
        try{            
        	var recordId = c.get('v.recordId');
        	var isDataLoaded = c.get('v.isDataLoaded');
        	if(isDataLoaded){            
            	var cutOffTime = c.get('v.cutOffTime');
            	var date = new Date();
            	var hours = date.getHours();
            	var minutes = date.getMinutes();
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
                    var datearray = requestShipDate.split("-");
                    var newdate = datearray[1] + '-' + datearray[2] + '-' + datearray[0];
                    c.set('v.requestDateTime',newdate); 
                    var newRetailDeliveryTicket = c.get('v.newRetailDeliveryTicket');
                    c.set('v.reqTempDate',newRetailDeliveryTicket.requestShipDate);
                    newRetailDeliveryTicket.requestShipDate = newdate;
                    c.set('v.newRetailDeliveryTicket',newRetailDeliveryTicket);
                }
            	var disableDates = c.get('v.holidayList');
            	if(recordId != '' && recordId != undefined){
                	var minDates = c.get('v.newRetailDeliveryTicket').requestShipDate;
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
                        var datearray = reqDate.split("-");
                        reqDate = datearray[2] + '-' + datearray[0] + '-' + datearray[1];
                        c.set('v.requestDateTimeHide',reqDate);
                        c.set('v.isDateChanged',true);
                    }
                });            
        	}else{
            	window.setTimeout($A.getCallback(function(){
                	h.applyDate(c);
            	}),100);
        	}
        }catch(err){console.log('Error:',err)}
	},
    setProductDetails: function(c, productId, quantity,productChanged){
        var product = undefined;
        var products = c.get('v.products');
        var allProducts = c.get('v.allProducts');
        var removeProducts = c.get('v.removeProducts');
        var a = c.get('v.newRetailDeliveryTicketLineItems');
        var retailDeliveryTicketLineItem = Object.assign({}, c.get('v.newRDTLI'));
        for (var i = 0; i < allProducts.length; i++) {
            if (allProducts[i].id == productId) {
                allProducts.splice(i, 1);
                break;
            }
        }
        for (var i = 0; i < products.length; i++) {
            if (products[i].id == productId) {
                product = products[i];
                removeProducts.push(products[i]);
                products.splice(i, 1);
                break;
            }
        }
        c.set('v.products',products);
        c.set('v.allProducts',allProducts);
        c.set('v.removeProducts',removeProducts);
        if(product.isSample == undefined){
            product.isSample = false;
        }
        retailDeliveryTicketLineItem.isDiscountProduct = product.isDiscountProduct;
        retailDeliveryTicketLineItem.listPrice = product.price.unitPrice;
        if(product.isSample){
            retailDeliveryTicketLineItem.originalSalesPrice = 0.01; 
            retailDeliveryTicketLineItem.salesPrice = 0.01;    
            retailDeliveryTicketLineItem.hasSampleChild = true;
            retailDeliveryTicketLineItem.isSample=true;
        } else {
            retailDeliveryTicketLineItem.originalSalesPrice = product.salePrice; 
            if(productChanged || retailDeliveryTicketLineItem.salesPrice == undefined || retailDeliveryTicketLineItem.originalSalesPrice == retailDeliveryTicketLineItem.salesPrice ){
                retailDeliveryTicketLineItem.salesPrice = product.salePrice; 
            }            
            retailDeliveryTicketLineItem.hasSampleChild = false;
            retailDeliveryTicketLineItem.isSample=false;
        }
        retailDeliveryTicketLineItem.Product = product.id;
        retailDeliveryTicketLineItem.MOQ = product.MOQ;
        if(product.maxOrderAllowed != undefined)
            retailDeliveryTicketLineItem.maxOrderAllowed = product.maxOrderAllowed / product.MOQ;
        else
            retailDeliveryTicketLineItem.maxOrderAllowed = 0;
        retailDeliveryTicketLineItem.orderQty = quantity;
        retailDeliveryTicketLineItem.availableInventory = product.availableInventory;
        retailDeliveryTicketLineItem.productRecordTypeName = product.recordTypeName;
        retailDeliveryTicketLineItem.parentProduct = product.parentProductId;
        retailDeliveryTicketLineItem.availableQty = product.availableQty||0;
        retailDeliveryTicketLineItem.ProductBookEntryId = product.price.id;
        retailDeliveryTicketLineItem.isSmaple = product.isSample;
        retailDeliveryTicketLineItem.productFamily = product.productFamily;
        retailDeliveryTicketLineItem.ProductName = product.name;
        retailDeliveryTicketLineItem.brandName = product.brandName;
        retailDeliveryTicketLineItem.brandId = product.brandId;
        retailDeliveryTicketLineItem.imageUrl = product.imageUrl;
        retailDeliveryTicketLineItem.priceBookid = product.price.id;
        retailDeliveryTicketLineItem.warehouseInventoryDetails = product.warehouseInventoryDetails;
        var totalInventory = retailDeliveryTicketLineItem.availableQty/retailDeliveryTicketLineItem.MOQ;
        if(totalInventory % 1 != 0)
            totalInventory = totalInventory.toFixed(4);
        retailDeliveryTicketLineItem.cases = totalInventory;
        retailDeliveryTicketLineItem.description = product.description;
        retailDeliveryTicketLineItem.shortDescription = product.shortDescription;
        a.push(retailDeliveryTicketLineItem);
        c.set('v.newRetailDeliveryTicketLineItems',a);
        var b = c.get('v.allNewRetailDeliveryTicketLineItems');
        b.push(retailDeliveryTicketLineItem);
        c.set('v.allNewRetailDeliveryTicketLineItems',b);
        this.calculateTotals(c); 
        this.processCalculations(c,true); 
        //$A.get('e.c:updateRDTSubTotal').fire();
    },
	searchData: function (c, e) {  
        var searchInput = c.find('searchRec');
        var searchText = searchInput.getElement().value;
        var tabName = c.get('v.activeTab');
        var allData = [];        
        if(tabName != 'active')
            allData = c.get('v.allProducts');
        else
            allData = c.get('v.allNewRetailDeliveryTicketLineItems');      
        var searchedData = [];
        for(var i=0; i<allData.length; i++){    
            if(searchText != undefined && searchText != ''){
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
                }else if(allData[i].productFamily != undefined && allData[i].productFamily.toLowerCase().includes(searchText.toLowerCase())){
                    searchedData.push(allData[i]);
                }else if(a != undefined && a.includes(b)){
                    searchedData.push(allData[i]);
                }
            }else{
                searchedData.push(allData[i]);   
            }
        }
        if(tabName != 'active')
            c.set('v.products',searchedData);
        else
            c.set('v.newRetailDeliveryTicketLineItems',searchedData);  
        c.set('v.isProcessing',false);
    },
    calculateTotals: function(c){
        var allNewRetailDeliveryTicketLineItems = c.get('v.allNewRetailDeliveryTicketLineItems');
        var newRetailDeliveryTicket = c.get('v.newRetailDeliveryTicket');
        let subTotal = 0;
        let grandTotal = 0;
        let totalExciseTax = 0;
        allNewRetailDeliveryTicketLineItems.forEach(function(entry, index, object) {
            if(entry.Product){
                subTotal += entry.MOQ * entry.orderQty * entry.salesPrice ;
                if(!newRetailDeliveryTicket.excludeExciseTax){
                    if(!entry.isSample && entry.applyExciseTax != 'No'){
                        //totalExciseTax += parseFloat((entry.salesPrice * entry.orderQty*entry.MOQ),10) * (1.8) * (0.15);
                        totalExciseTax += entry.isDiscountProduct? parseFloat(((entry.salesPrice * -1) * (1.8) * (0.15)),10).toFixed(2) * entry.orderQty * entry.MOQ : parseFloat((entry.salesPrice * (1.8) * (0.15)),10).toFixed(2) * entry.orderQty * entry.MOQ;
                    }    
                }
            }
        });
        subTotal =  subTotal.toFixed(2);
        totalExciseTax = totalExciseTax.toFixed(2);
        grandTotal = parseFloat(subTotal)  +parseFloat(totalExciseTax) ;
        c.set('v.totalExcisetax',totalExciseTax);
        c.set('v.grandTotal',grandTotal.toFixed(2));
        c.set('v.subTotal',subTotal);
    },
    setPagination : function(c,e,h,fromInit){
        var filters = { orderByField: 'product.name', isASC: true };
        c.set('v.filters', filters);
        let products = c.get('v.allProducts');
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
                    if(!setOfIds.includes(item.id)){
                        arr.push(item.id);
                    }
        		});
        	}
            h.initPagination(c, arr, filters);
        } else {
            h.initPagination(c, setOfIds, filters,'paginatorActive');
        }
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
	saveOrder: function (c, e, h,buttonStatus) {
        try {
            c.set('v.qtyTooLow',false);
            let siteMap = c.get('v.siteMap');
            let siteDetail = siteMap[c.get('v.newRetailDeliveryTicket').siteId];
            
            if(siteDetail && siteDetail.License_ID__c == c.get('v.newRetailDeliveryTicket').stateLicense){
                h.error({message:c.get('v.Err_Msg_of_Ship_To_and_Origin_Site')});   
            	return;
            }
            /*let siteValidate = c.find('siteCustomLookup');
            let isSiteValid = true;
            if(siteValidate){
                isSiteValid = siteValidate.validate();
            }*/
            
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
            
        	//var salesRep = document.getElementById("Sales Rep").innerHTML ;
        	var addBrandContact = document.getElementById("Brand Contact").innerHTML ;
        	var addRetailContact = document.getElementById("Receiver Contact").innerHTML ;
        	//if(salesRep == undefined)
            var	salesRep = '';
        	if(addBrandContact == undefined)
            	addBrandContact = '';
        	var newRetailDeliveryTicket = c.get('v.newRetailDeliveryTicket');
        	if(addRetailContact != '' && addRetailContact != undefined){ 
            	var a = addRetailContact.split(',')[0];
            	newRetailDeliveryTicket.retailerContact = a;
            	addRetailContact = addRetailContact.replace(a+',','');
            	if(addRetailContact == null || addRetailContact == undefined)
                	addRetailContact = ''; 
			}else{
                h.error({message:'Please select atleast one retailer contact'});   
            	return;
        	}  
            if(c.get('v.allNewRetailDeliveryTicketLineItems').length <=0){
                h.error({message: c.get('v.Err_Msg_Add_Atleat_One_OLI')}); 
                //h.showToast('error','','Please add atleast one Retail Delivery Ticket Line Item');   
            	return;    
            }
            var allNewRetailDeliveryTicketLineItems = c.get('v.allNewRetailDeliveryTicketLineItems');
            var validToSave = true;
            var validToSave1 = true;
            var validToSave2 = true;
            var validToSave3 = true;
            var validToSave4 = true;
            
            const warehouseAvailableInventoryMap = c.get('v.warehouseAvailableInventoryMap');
                    const warehouseTotalOrderedMap = c.get('v.warehouseTotalOrderedMap');
            
            allNewRetailDeliveryTicketLineItems.forEach((item) => {
                if(item.orderQty <= 0)
                	validToSave = false;
                
                var warehouseDetails = warehouseAvailableInventoryMap[item.Product]||[];
                        let totalOrderedQty = 0;
                        let totalInventry = 0;
                        warehouseDetails.forEach((site) => {
                        var key = site.id +'-'+item.Product;
                        if(newRetailDeliveryTicket.siteId == site.id){
                        totalOrderedQty = warehouseTotalOrderedMap[key] || 0;
                        totalInventry = site.availableInventory - totalOrderedQty;
                        if(item.MOQ > 0)
                        totalInventry = totalInventry / item.MOQ; 
                        if(totalInventry % 1 != 0)
                        totalInventry = totalInventry.toFixed(4);
                        totalInventry = parseFloat(totalInventry)
                    }                                                                
                                                                });
            	 if(item.cases == undefined){
                        let totalInv = item.availableQty/item.MOQ;
                        if(totalInv % 1 != 0) totalInv = totalInv.toFixed(4);
                        item.cases = totalInv;
                    }
            	
                const decimalPart =  item.orderQty % 1;
            	if((decimalPart > 0 && item.orderQty != totalInventry) || item.orderQty > totalInventry ){
                        validToSave1= false;
                    }
                /*if(item.orderQty > item.availableQty){
                		validToSave1= false;	
				}*?
				/*if(String(item.orderQty).indexOf('\.') >= 0 ){
                	validToSave2 = false;
            	}*/
            	if(item.salesPrice <= 0){
                    validToSave3 = false;
                }
            	/*if(!item.isSample && item.salesPrice == 0.01){
                    validToSave4 = false;
                }*/
        	});
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
            if(!validToSave1){
                h.error({message:'Order Qty (Cases) is greater than Available Qty'});       
                return;    
            }
        	/*if(!validToSave2){
                h.error({message:'Quantity is not valid'});       
                return;    
            }*/
			var recordId = sessionStorage.getItem('retailDeliveryTicketId'); //c.get('v.recordId');
			var isParentValid = h.isValid(c);
			var retailDeliveryTicketLineItems = c.find('retailDeliveryTicketLineItem');
			var isValid = [].concat(newRetailDeliveryTicket).reduce(function (validSoFar, newRetailDeliveryTicket) {
					return validSoFar;
            }, true);
			if (!isParentValid || !isValid) {
				return false;
			}
			if (!c.get('v.isDateChanged')) {
				var reqDate = c.get('v.reqTempDate');
				newRetailDeliveryTicket.requestShipDate = reqDate;
			} else {
				var reqDate = c.get('v.requestDateTimeHide');
				newRetailDeliveryTicket.requestShipDate = reqDate;
			}
        	if(c.get('v.reqTempDate') == ''){
                newRetailDeliveryTicket.requestShipDate = null;
            }
			c.set('v.newRetailDeliveryTicket', newRetailDeliveryTicket);
            //c.set('v.isShowSuccess',true);
			h.request(c, 'saveRetailDeliveryTicket', { recordId: recordId,
                                                      retailDeliveryTicketData: JSON.stringify(c.get('v.newRetailDeliveryTicket')),
                                                      retailDeliveryTicketLineItemsData: JSON.stringify(c.get('v.allNewRetailDeliveryTicketLineItems')),"salesRep":salesRep,"addBrandContact":addBrandContact,"addRetailContact":addRetailContact,"fromTransferOrders":true, "draftStatus": buttonStatus }, function (r) {
                                                          //$A.get('e.c:updateCartTotalEvt').setParams({ cartTotal: 0 }).fire();
                                                          c.set('v.isShowSuccess',true);
                                                          window.setTimeout($A.getCallback(function(){
                                                              const modal = document.getElementById('success-modal');
                                                       	  if (modal) modal.classList.add('is-active');
                                                          }),100);
                                                      });
		} catch (error) {
			console.log('Error:', error);
		}
	},
})