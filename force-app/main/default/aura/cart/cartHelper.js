({
    
    updateBreadCrumb : function(c,screenName) {
        try{
            var AllBreadCrumb = sessionStorage.getItem('AllBreadCrumb');
            if(AllBreadCrumb){
                AllBreadCrumb = JSON.parse(AllBreadCrumb);
            }
            var matchedMenu = AllBreadCrumb.find((menu) => {
                return menu.text == screenName;
            })
            console.log('screenName::',matchedMenu);
            if(matchedMenu){
                sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: matchedMenu.label, breadCrumbIds : matchedMenu.value}));
                $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: matchedMenu.label, breadCrumbIds : matchedMenu.value}).fire();
            }
            
        }catch(error){
            console.log('error:',error);
        }
    },
    getIds: function (c, filters) {
        var h = this;
        h.request(c, 'getIds', { filters: filters }, function (r) {
            console.log('r.ids='+r.ids);
            let setOfIds = [];
            let pbIdsFinal = [];
            let pbIds = r.ids;
            let allItems = c.get('v.allItems');
            allItems.forEach((itemRec) => {
            	setOfIds.push(itemRec.price.id);
            });
            pbIds.forEach((itemId) => {
                //if(!setOfIds.includes(itemId)){
            		pbIdsFinal.push(itemId);
            	//}
            }); 
            c.set('v.allIds',r.ids);
            h.initPagination(c, pbIdsFinal, filters);
        }, { storable: true });
    },
    
    setPagination : function(c,e,h){
        var filters = { orderByField: 'Product2.Name', isASC: true };
        c.set('v.filters', filters);
        let tabName = c.get('v.activeTab');
        let setOfIds = [];
        if(tabName == 'all'){
            let allIds = c.get('v.allIds');
            let setOfIds = [];
            let pbIdsFinal = [];
            let allItems = c.get('v.allItems');
            allItems.forEach((itemRec) => {
            	setOfIds.push(itemRec.price.id);
            });
            allIds.forEach((itemId) => {
                //if(!setOfIds.includes(itemId)){
            		pbIdsFinal.push(itemId);
            	//}
            }); 
            h.initPagination(c, pbIdsFinal, filters);
        } else {
            let items = c.get('v.allItems');
            items.forEach((itemRec) => {
            	setOfIds.push(itemRec.price.id);
            });
            h.initPagination(c, setOfIds, filters,'paginatorActive');
        }
    },
    
    getProducts: function(c, ids) {
        this.getRecords(c, ids);        
    },
    getRecords: function (c, ids) {
        var h = this;
        h.request(c, 'getProducts', { ids: ids, filters: c.get('v.filters') }, function (r) {
            c.set('v.isBrand', r.isBrand);
            var records = c.get('v.records');
            //records = records.concat(r.records);
            var warehouseTotalOrderedMap = r.warehouseTotalOrderedMap;
            var warehouseAvailableInventory = r.warehouseAvailableInventory;
            var items =  r.records;
            
            items.forEach((product) => { 
                product.quantity = 1;
                var availableInventories =  warehouseAvailableInventory[product.id] || [];
                var totalOrderedQty = 0;
                var totalWarehourseInventory = 0;
                var warehouseInventoryDetails = '<ul>';
                const mapOfLAUnits = new Map();
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
                		console.log('##totalInventry ',totalInventry);
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
                        if(product.MOQ > 0){
                            totalInventry = totalInventry / product.MOQ; 
                            totalWarehourseInventory = totalWarehourseInventory + totalInventry;
                            if(totalInventry % 1 != 0)
                                totalInventry = totalInventry.toFixed(2);
                        }
                            warehouseInventoryDetails = warehouseInventoryDetails + '<li>' + itemNm +': '+ totalInventry +' Cases </li>';
                	}
                });
				product.warehouseInventoryDetails = warehouseInventoryDetails + '</ul>';
				if(totalWarehourseInventory % 1 != 0)
					totalWarehourseInventory = totalWarehourseInventory.toFixed(2);
				product.totalWarehourseInventory = totalWarehourseInventory;
			});
			c.set('v.records', items);
        }, { storable: true });
    },
    
    setData: function(c, r){
        try{
            console.log("v.updated:",c.get('v.updated'));
            var h = this;
            
            c.set('v.EARLIEST_DELIVERY_TIME',r.EARLIEST_DELIVERY_TIME);
            c.set('v.LATEST_DELIVERY_TIME',r.LATEST_DELIVERY_TIME);
            $A.get('e.c:updateCartTotalEvt').setParams({cartTotal: r.quantity}).fire();
            c.set('v.total', r.total);
            c.set('v.termsAndConditions',r.termsAndConditions);
            c.set('v.acceptTerms',r.hasAcceptedTerms);
            c.set('v.cartTotal', r.cartTotal); 
            c.set('v.exciseTax', r.exciseTax);
            c.set('v.subTotal', r.subTotal);
            c.set('v.isBrand', r.isBrand);
            c.set('v.isHybrid', r.isHybrid);
            if(!r.items.length){
                h.info({message: 'Cart is empty, Continue shopping!'});
                h.redirect('/products', true);
                return;
            }
            var warehouseTotalOrderedMap = r.warehouseTotalOrderedMap;
            var warehouseAvailableInventory = r.warehouseAvailableInventory;
            var items =  r.items;
            let setOfIds = [];
            items.forEach((product) => {
                setOfIds.push(product.price.id);
                
                var availableInventories =  warehouseAvailableInventory[product.id] || [];
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
                        if(product.MOQ > 0){
                            totalInventry = totalInventry / product.MOQ; 
                            totalWarehourseInventory = totalWarehourseInventory + totalInventry;
                            if(totalInventry % 1 != 0)
                                totalInventry = totalInventry.toFixed(2);
                        }
                            warehouseInventoryDetails = warehouseInventoryDetails + '<li>' + itemNm +': '+ totalInventry +' Cases </li>';
                	}
                });
				product.warehouseInventoryDetails = warehouseInventoryDetails + '</ul>';
				if(totalWarehourseInventory % 1 != 0)
					totalWarehourseInventory = totalWarehourseInventory.toFixed(2);
				product.totalWarehourseInventory = totalWarehourseInventory;
			});
			//c.set('v.items',items);
            c.set('v.allItems',items);   
			if(!r.isHybrid){
				c.set('v.existingAddresses', r.existingAddresses);
            }
                    
                    c.set('v.baseUrl', r.baseUrl);
                    c.set('v.retailers', r.retailers);
                    c.set('v.retailersDetail', r.retailersDetail);
                    console.log('r.cutOffTime '+r.cutOffTime);
                    c.set('v.cutOffTime',r.cutOffTime);
                    c.set('v.holidayList', r.holidayList);
                    c.set('v.isDataLoaded',true);
                    
                }catch(er){
                    console.log('Set Data Error:',er);
                }
                    
                },
                    oncheckout: function(c,address,buttonStatus){
                        console.log('Date = '+c.get('v.requestShipDate'));
                        var h = this;
                        try{
                            var acceptTerms = c.get('v.acceptTerms');
                            var shipEarliestTime = c.get('v.requestShipEarliestTime');
                            var shipLatestTime = c.get('v.requestShipLatestTime');
                            c.set('v.isShowSuccess',true);
                            if(acceptTerms){
                                h.request(c, 'hasAccepted', {}, function (res) {
                                    h.request(c, 'checkout', {retailerId:c.get('v.selectedRetailerId'),contactId:c.get('v.selectedRetailerContactId'),requestShipDate:c.get('v.requestShipDate'), addressId: address.id,excludeExciseTax:c.get('v.excludeExciseTax'),requestShipEarliestTime:shipEarliestTime,requestShipLatestTime:shipLatestTime,recStatus: buttonStatus }, function (r) {
                                        //h.success({ message: 'Order received successfully.' });
                                        h.updateTotal(c, 0);
                                        c.set('v.isCartEmpty', true);
                                        c.set('v.orderId', r.order.Name);
                                        const modal = document.getElementById('success-modal');
                                        if (modal) modal.classList.add('is-active');
                                    });
                                });
                            }else{
                                h.error({ message: 'Select Terms & Conditions before placing order.' });
                            }
                            
                        }catch(err){
                            console.log("Error:",err);
                        }
                        
                    },
                    updateTotal: function(c, total) {
                        $A.get('e.c:updateCartTotalEvt').setParams({cartTotal: total}).fire();
                    },
                    
                    applyDate : function(c) {
                        var h = this;
                        try{
                            var isDataLoaded = c.get('v.isDataLoaded');
                            if(isDataLoaded){
                                var cutOffTime = c.get('v.cutOffTime');
                                var date = new Date();
                                //var date = new Date('2020-05-07 10:29:00');
                                var hours = date.getHours();
                                var minutes = date.getMinutes();
                                
                                console.log('dATE = ',minutes);
                                
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
                                var disableDates = c.get('v.holidayList');
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
                                
                                $("#datepickerId").change(function(){
                                    if($('#datepickerId').val() != ''){
                                        
                                        var reqDate = $('#datepickerId').val();
                                        
                                        var datearray = reqDate.split("-");
                                        reqDate = datearray[2] + '-' + datearray[0] + '-' + datearray[1];
                                        console.log('reqDate = '+reqDate);
                                        c.set('v.requestShipDate',reqDate);
                                        
                                    }
                                });
                            }else{
                                window.setTimeout($A.getCallback(function(){
                                    h.applyDate(c);
                                }),100);
                            }
                        }catch(err){console.log('Error:',err)}
                    },
                })