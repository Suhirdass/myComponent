({
	recordIdChanges: function (c, e, h) {
		c.set('v.RDTRecordId', c.get('v.recordId'));
	},
	onInit: function (c, e, h) {
		try {
            const userAgent = navigator.userAgent.toLowerCase();
        	c.set('v.isTablet',/(ipad|tablet|(android(?!.*mobile))|(windows(?!.*phone)(.*touch))|kindle|playbook|silk|(puffin(?!.*(IP|AP|WP))))/.test(userAgent));
			c.set('v.recordId', sessionStorage.getItem('retailDeliveryTicketId'));
			c.set('v.activeTab', 'all'); // Toggled with setActiveTab. Can be 'all' or 'active'
            c.set('v.sortType', 'ASC');
			h.request(c, 'init', { recordId: c.get('v.recordId'),"fromTransferOrders":true,retailDeliveryTicketData:'',retailDeliveryTicketLineItemsData:'',isClone:'False'  }, function (r) {
                console.log('OT Init:',r);
                var disableExcludeExciseTax = true;
				c.set('v.Additional_Brand_Contact_Help_Text',r.Additional_Brand_Contact_Help_Text);				
                var warehouseAvailableInventoryMap = r.warehouseAvailableInventoryMap
				c.set('v.warehouseAvailableInventoryMap',warehouseAvailableInventoryMap);
                var warehouseTotalOrderedMap = r.warehouseTotalOrderedMap;
                c.set('v.Err_Msg_of_Ship_To_and_Origin_Site',r.Err_Msg_of_Ship_To_and_Origin_Site);
				c.set('v.warehouseTotalOrderedMap', warehouseTotalOrderedMap);
                c.set('v.licenses', r.licenses);
                c.set('v.Err_Msg_Add_Atleat_One_OLI',r.ERR_MSG_ADD_ONE_OTS);
                c.set('v.brandPlatformLevel',r.brandPlatformLevel);
                c.set('v.cliRegularProductWithSamplePrice',r.cliRegularProductWithSamplePrice);
				c.set('v.statelicenses', r.statelicenses);
				c.set('v.commSetting', r.commSetting);
                c.set('v.siteOptions', r.siteOptions);
                c.set('v.siteMap', r.activeSiteMap);
                r.paymentTerms.forEach((fa) => {
                    fa.id = fa.value;
                    fa.name = fa.label;
                });
				c.set('v.paymentTerms', r.paymentTerms);
				c.set('v.excludeExciseTaxTypes', r.excludeExciseTaxTypes);
				c.set('v.excludeExciseTaxTypesText',r.excludeExciseTaxTypes.join(', '));
                [].concat(r.transporterLicenses).forEach((l)=>{l.id=l.value;l.name=l.label});
                c.set('v.transportLicenses',r.transporterLicenses);    
                var products = r.products;
                products.forEach((product) => {
                    var warehouseInventoryDetails = '';
                    var warehouseDetails = warehouseAvailableInventoryMap[product.id]||[];
                    warehouseDetails.forEach((item) => {
                        var key = item.id +'-'+product.id;
                        var totalOrderedQty = warehouseTotalOrderedMap[key] || 0;
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
                			warehouseInventoryDetails = warehouseInventoryDetails + itemNm + ': ' + totalInventry + ' Cases <br/>';
                        }
        			});
                    product.warehouseInventoryDetails = warehouseInventoryDetails;
                });
        		products = h.sortAllProducts(c, e, h,products,'ASC');
				c.set('v.products', products);
                c.set('v.allProducts', products);
        		c.set('v.completeProductsList', products);
				c.set('v.contacts', r.contacts);
				c.set('v.brandContacts', r.brandContacts);
				c.set('v.salesReps', r.salesReps);
				c.set('v.retailersDetail', r.retailersDetail);
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
				var relatedContacts = r.relatedContacts || [];
				var selectedContactIds = relatedContacts.length ? r.retailDeliveryTicket.retailerContact + ';' + relatedContacts.join(';') : r.retailDeliveryTicket.retailerContact;
				c.set('v.selectedContactIds', selectedContactIds);
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
				if (r.retailDeliveryTicket.stateLicense) {
					var statelicense = r.statelicenses[r.retailDeliveryTicket.stateLicense].License_Type__c;
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
                    c.set('v.retailDeliveryTicket', rdt);
                    
					var excludeExciseTaxTypes = c.get('v.excludeExciseTaxTypes');
					if(statelicense && excludeExciseTaxTypes.indexOf(statelicense) != -1){
						disableExcludeExciseTax = false;
					}else{
						disableExcludeExciseTax = true;
					}
					c.set('v.disableExcludeExciseTax', disableExcludeExciseTax);
				}
				//c.set('v.newRetailDeliveryTicketLineItems',r.retailDeliveryTicketLineItems);
				var retailDeliveryTicketLineItems = r.retailDeliveryTicketLineItems;
				/*var brandRetailDeliveryOrderItems = Object.keys(
					r.brandRetailDeliveryOrderItems
				);
				if (brandRetailDeliveryOrderItems && brandRetailDeliveryOrderItems.length > 0){
					retailDeliveryTicketLineItems = [];
					brandRetailDeliveryOrderItems.forEach(function (productId) {
						retailDeliveryTicketLineItems.push({
							Product: productId,
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
						});
					});
				}*/
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
                        if(!setOfIds.includes(item.id)){
                            arr.push(item);
                        }
                    });
                    c.set('v.products',arr);    
                }
				h.setPagination(c,e,h,true);
            	c.set('v.allNewRetailDeliveryTicketLineItems',retailDeliveryTicketLineItems);
                h.calculateTotals(c);
				if (c.get('v.recordId') != '' && c.get('v.recordId') != undefined) {
                    var licenses = [];
                    licenses = r.licenses;
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
					c.set('v.requestDateTimeHide',c.get('v.newRetailDeliveryTicket').requestShipDate);
					
                    h.processCalculations(c, false);
					h.searchData(c, e);
        			h.setPagination(c,e,h,false);
				}
				c.set('v.isDataLoaded', true);
				window.setTimeout($A.getCallback(function(){
                    c.set('v.initializationCompleted',true);
                }),500)
			});
		} catch (err) {
			console.log('Error:', err);
		}
	},
	onScriptsLoaded: function (c, e, h) {
		h.applyDate(c);
	},
	showDatePicker: function (c, e, h) {
		$('#datepickerId').datepicker('show');
	},
	calculateServiceFee: function (c, e, h) {
		h.processCalculations(c, true);
	},
	updateSubTotal: function (c, e, h) {
		h.calculateTotals(c);
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
        }  else if(fieldName == 'Shipping Address'){
            let licenseId = selectedIds.slice(0, -1);
            newRetailDeliveryTicket.stateLicense = licenseId;
            c.set('v.newRetailDeliveryTicket',newRetailDeliveryTicket);
            if(c.get('v.initializationCompleted')){
                var a = c.get('c.onLicenseChange');
                $A.enqueueAction(a);
            }
        } else if(fieldName ==='Transporter'){
            let transId = selectedIds.slice(0, -1);
            newRetailDeliveryTicket.transportLicenseId = transId;
            c.set('v.newRetailDeliveryTicket',newRetailDeliveryTicket);
        } else if(fieldName == 'Payment Terms'){
            let payTerms = selectedIds.slice(0, -1);
            newRetailDeliveryTicket.paymentTerms = payTerms;
            c.set('v.newRetailDeliveryTicket',newRetailDeliveryTicket);
        } else if(fieldName == 'Receiver Contact'){
            let retailerContact = selectedIds.slice(0, -1);
            newRetailDeliveryTicket.retailerContact = retailerContact;
            c.set('v.newRetailDeliveryTicket',newRetailDeliveryTicket);
        } else if(fieldName == 'Origin Site'){
            let siteId = selectedIds.slice(0, -1);
            newRetailDeliveryTicket.siteId = siteId;
            c.set('v.newRetailDeliveryTicket',newRetailDeliveryTicket);
            const allNewRetailDeliveryTicketLineItems = c.get('v.allNewRetailDeliveryTicketLineItems');
            if(siteId){
                h.setSiteAddesss(c,h);
            } else {
                let rdt = c.get('v.newRetailDeliveryTicket');
                rdt.siteAddress = '';
                c.set('v.newRetailDeliveryTicket',rdt);
            }
            if(siteId && allNewRetailDeliveryTicketLineItems.length){
                h.processCalculations(c,false);
            }	
        } 
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
        let newrdtClean = c.get('v.newRetailDeliveryTicket');
        var licenseId = newrdtClean.stateLicense;
        newrdtClean.shippingAddress = '';
        c.set('v.newRetailDeliveryTicket', newrdtClean);
		if (licenseId) {
            h.setShippingAdd(c,licenseId);
		}
	},
	onRetailerChange: function (c, e, h) {
		//var retailerId = e.getSource().get('v.value');
		var newRetailDeliveryTicket = c.get('v.newRetailDeliveryTicket');
        var retailerId = newRetailDeliveryTicket.retailer;
        console.log('retailerId::', retailerId);
		var licenses = [];
		var contacts = [];
        let types = [];
		var statelicenses = {};
		let newrdtClean = c.get('v.newRetailDeliveryTicket');
        newrdtClean.shippingAddress = '';
        newrdtClean.stateLicense = '';
        newrdtClean.stateLicenseName = '';
        newrdtClean.retailerContactName = '';
        newrdtClean.retailerContact = '';
        newrdtClean.salesPersonName ='';
        newrdtClean.salesPersonIds ='';
        
        c.set('v.newRetailDeliveryTicket', newrdtClean);
		if (retailerId) {
			var retailersDetailMap = c.get('v.retailersDetail');
			var retailersDetail = retailersDetailMap[retailerId];
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
                licenses[i].address =s;
                licenses[i].name = s;
            }
			statelicenses = retailersDetail.statelicenses;
			contacts = retailersDetail.contacts;
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
			newRetailDeliveryTicket.paymentTerms = retailersDetail.paymentTerm; //retailer.Payment_Terms__c;
		} else {
			newRetailDeliveryTicket.paymentTerms = '';
		}
        newRetailDeliveryTicket.siteId = '';
        newRetailDeliveryTicket.siteWarehouseName = '';
		c.set('v.newRetailDeliveryTicket', newRetailDeliveryTicket);
        //Reset all Fee values
        c.set('v.pickPackfee',0.00);
        c.set('v.QAFee',0.00); 
        c.set('v.orderBookingFee',0.00);
        c.set('v.stageAndManifestFee',0.00);
        var packOutFee = 0.00;
        var orderProcessingFee = 0.00;
        var shippingFee = 0.00;
        var totalServicesfee = orderProcessingFee + shippingFee;
        c.set('v.shippingFee',0.00);
        c.set('v.orderProcessingFee',0.00);
        c.set('v.totalServicesfee',0.00);
        c.set('v.distribution',0.00);
        const siteOptions = c.get('v.siteOptions');
        c.set('v.siteOptions',[]);
        c.set('v.siteOptions',siteOptions);
		c.set('v.licenses', licenses);
		c.set('v.contacts', contacts);
        
		var contactsOptions = [];
		for (var i = 0; i < contacts.length; i++) {
			contactsOptions.push({ label: contacts[i].name, value: contacts[i].id });
		}
		c.set('v.contactsOptions', contactsOptions);
		c.set('v.statelicenses', statelicenses);
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
            
            h.request(c, 'getProductsByRetailerId', { recordId: retailerId,"fromTransferOrders":true}, function (r) {
                var warehouseAvailableInventoryMap = r.warehouseAvailableInventoryMap;
                c.set('v.warehouseAvailableInventoryMap',warehouseAvailableInventoryMap);
                var warehouseTotalOrderedMap = r.warehouseTotalOrderedMap;
                c.set('v.warehouseTotalOrderedMap', warehouseTotalOrderedMap);
                //var allNewRetailDeliveryTicketLineItems = c.get('v.allNewRetailDeliveryTicketLineItems');
                var products = r.products;
                let arr = [];
                let setOfIds = [];
                //let arr2 = [];
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
        					if(!setOfIds.includes(product.id)){
                            arr.push(product.id);
                        }
        				/*for (var i = 0; i < allNewRetailDeliveryTicketLineItems.length; i++) {
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
                            c.set('v.allNewRetailDeliveryTicketLineItems', arr2);*/
    				});
                        console.log('#$# :',products.length);
                        products = h.sortAllProducts(c, e, h,products,'ASC');
                        c.set('v.products', products);
                        c.set('v.allProducts', products);
                        c.set('v.completeProductsList', products); 
                        c.set('v.productOrderedQtyMap', r.productOrderedQtyMap);
                        var filters = { orderByField: 'product.name', isASC: true };
                        c.set('v.filters', filters);
                        h.initPagination(c, arr, filters);
                    });
	},
	onSave: function (c, e, h) {
        c.set('v.successMsgTitle', 'Outbound Transfer saved successfully!');
    	h.saveOrder(c, e, h,'Draft');    
    },
	onSubmit: function (c, e, h) {
        if (c.get('v.recordId') != '' && c.get('v.recordId') != undefined) 
        	c.set('v.successMsgTitle', 'Outbound Transfer updated successfully!');
        else
            c.set('v.successMsgTitle', 'Outbound Transfer submitted successfully!');
    	h.saveOrder(c, e, h,'Pending');        
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
	},
	onCancel: function (c, e, h) {
        window.setTimeout($A.getCallback(function(){
            var AllBreadCrumb = sessionStorage.getItem('AllBreadCrumb');
        if(AllBreadCrumb){
            AllBreadCrumb = JSON.parse(AllBreadCrumb);
        }
        
        var screenName = 'View Outbound Transfers';
        var matchedMenu = AllBreadCrumb.find((menu) => {
            return menu.text == screenName;
        })
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
                })
                }
                }
        }),100);
		var recordId = c.get('v.recordId');
		if (recordId == '') {
			//$A.get('e.c:updateCartTotalEvt').setParams({ cartTotal: 0 }).fire();
			h.request(c, 'removeProducts', {}, function (r) {}, {
				showSpinner: false,
				background: true,
			});
		}
		h.redirect('/outboundtransfers', true);
	},
	onPOBlur: function (c, e, h) {
		var newRetailDeliveryTicket = c.get('v.newRetailDeliveryTicket');
		newRetailDeliveryTicket.retailerPO = newRetailDeliveryTicket.retailerPO ? newRetailDeliveryTicket.retailerPO.trim() : '';
		c.set('v.newRetailDeliveryTicket', newRetailDeliveryTicket);
		e.getSource().set('v.validity', { valid: false, badInput: true });
		e.getSource().showHelpMessageIfInvalid();
	},
	setActiveTab: function (c, e, h) {
		var tab = e.getSource().getLocalId();
		c.set('v.activeTab', tab);
        document.getElementById("searchRec").value = '';
        h.searchData(c, e);
        h.setPagination(c,e,h,false);
	},
    onProductChange: function (c, e, h) {
        c.set('v.qtyTooLow',false);
        var selectedStateLicenseId = c.get('v.newRetailDeliveryTicket').stateLicense;
        if(selectedStateLicenseId == ''){
            h.error({message:'Please first select License'});   
        }else{
        	var dataset = e.currentTarget.dataset;
            var productId = dataset.productid;
            let qty = 1;
            var isError = false;
            var isSample = false;
            let products = c.get('v.products');
            let uPrice = 1;
                //console.log('##qty::',qty,'---',item.availableQty);
            const siteId = c.get('v.newRetailDeliveryTicket').siteId;
            let totalInventry = 0;
            let product;
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
            products.forEach((item) => {
                if(item.id == productId){
                    qty = parseFloat(item.quantity);
                	uPrice = item.salePrice;
                	isSample = item.isSample;
                	const decimalPart =  qty % 1;
                	console.log('decimalPart:',decimalPart);
                    console.log('QTY:',qty);
                    console.log('totalInventry:',totalInventry);
                    if((decimalPart > 0 && qty != totalInventry) || qty > totalInventry ){
                    	isError= true;
                	}
                	else if(qty > item.availableQty){
                		isError= true;	
            		}
                }
            });
            if(uPrice <= 0){
            	c.set('v.uPriceTooLow',true);
        	} /*else if(uPrice == 0.01 && !isSample){
            	c.set('v.uPriceSample',true);
        	}*/ else if(qty <= 0){
            	c.set('v.qtyTooLow',true);
            }else if(isError){
                h.error({message:'Order Qty (Cases) is greater than Available Qty'});       
            }/*else if(String(qty).indexOf('\.') >= 0 ){
                h.error({message:'Quantity is not valid.'});       
        	}*/else{
                h.setProductDetails(c, productId,qty,true);
                var allNewRetailDeliveryTicketLineItems = c.get('v.allNewRetailDeliveryTicketLineItems');
                if(allNewRetailDeliveryTicketLineItems.length > 0)
                    c.set('v.isLineItemAdded',false);
                else
                    c.set('v.isLineItemAdded',true);
                //h.setPagination(c,e,h,false);
                h.searchData(c, e);
                h.setPagination(c,e,h,false);
                //$A.get('e.c:updateCartTotalEvt').setParams({cartTotal: allNewRetailDeliveryTicketLineItems.length}).fire();
            }
        }
    },
	handleNumberEvent :  function (c, e, h) {
        var listSelectedItems = c.get("v.lstSelectedRecords");
        var recordId = e.getParam("recordId");
        var currentValue = e.getParam("currentValue");
        if(c.get('v.activeTab') != 'all'){
            let rdtLineItems = c.get('v.newRetailDeliveryTicketLineItems');
            rdtLineItems.forEach((item) => {
                if(item.Product == recordId){
                	item.orderQty = currentValue;
            	}
			});
            c.set('v.newRetailDeliveryTicketLineItems',rdtLineItems);
            let allNewRetailDeliveryTicketLineItems = c.get('v.allNewRetailDeliveryTicketLineItems');
            allNewRetailDeliveryTicketLineItems.forEach((item) => {
                if(item.Product == recordId){
                	item.orderQty = currentValue;
            	}
			});
            c.set('v.allNewRetailDeliveryTicketLineItems',allNewRetailDeliveryTicketLineItems);
            h.processCalculations(c,false);
        } else{
            let products = c.get('v.products');
            products.forEach((item) => {
                if(item.id == recordId){
                	item.quantity = currentValue;
            	}
			});
            c.set('v.products',products);
        }
        h.calculateTotals(c); 
    },
    onSalesPriceChange: function (c, e, h) {
		h.calculateTotals(c);       
	},
	removeItem: function (c, e, h) {
    	var dataset = e.currentTarget.dataset;
        var idx = dataset.idx;  
        var prodId = dataset.productid;
        var allNewRetailDeliveryTicketLineItems = c.get('v.allNewRetailDeliveryTicketLineItems');
        for (var i = 0; i < allNewRetailDeliveryTicketLineItems.length; i++) {
            if (allNewRetailDeliveryTicketLineItems[i].Product == prodId) {
            	allNewRetailDeliveryTicketLineItems.splice(i, 1);   
            } 
        }
        var newRetailDeliveryTicketLineItems = c.get('v.newRetailDeliveryTicketLineItems');
        var tmp = newRetailDeliveryTicketLineItems[idx];
        newRetailDeliveryTicketLineItems.splice(idx, 1); 
        c.set('v.newRetailDeliveryTicketLineItems',newRetailDeliveryTicketLineItems);
        if(allNewRetailDeliveryTicketLineItems.length > 0)
			c.set('v.isLineItemAdded',false);
		else
			c.set('v.isLineItemAdded',true);
        var products = c.get('v.products');
        var allProducts = c.get('v.allProducts');
        var removeProducts = c.get('v.removeProducts');
        for (var i = 0; i < removeProducts.length; i++) {
            if (removeProducts[i].id == prodId) {
                products.push(removeProducts[i]);
                allProducts.push(removeProducts[i]);
                removeProducts.splice(i, 1);
                break;
            }
        }
        var sortType = c.get('v.sortType');
        allProducts = h.sortAllProducts(c, e, h,allProducts,sortType);
        c.set('v.products',products);
        c.set('v.allProducts',allProducts);
        c.set('v.removeProducts',removeProducts);
        c.set('v.allNewRetailDeliveryTicketLineItems',allNewRetailDeliveryTicketLineItems);
        if(allNewRetailDeliveryTicketLineItems.length == 0){
        	c.set('v.grandTotal', '0.00');
            c.set('v.grandTotalDiscount', '0.00');
            c.set('v.totalExcisetax', '0.00');
            c.set('v.subTotal',	'0.00');
            c.set('v.distribution','0.00');
            c.set('v.shippingFee','0.00');
            c.set('v.orderProcessingFee','0.00');
            c.set('v.totalServicesfee','0.00');
            c.set('v.pickPackfee','0.00');
            c.set('v.QAFee','0.00'); 
            c.set('v.orderBookingFee','0.00');
            c.set('v.stageAndManifestFee','0.00');
        }else{
        	h.calculateTotals(c);
            h.processCalculations(c,true); 
    	}
		//$A.get('e.c:updateCartTotalEvt').setParams({cartTotal: allNewRetailDeliveryTicketLineItems.length}).fire();
		h.setPagination(c,e,h,false);
	},
	searchProduct: function (c, e, h) {
        c.set('v.isProcessing',true);
        window.setTimeout($A.getCallback(function(){
        h.searchData(c, e);
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
                if(!setOfIds.includes(item.id)){
            		arr.push(item.id);
            	}
        	});
        	h.initPagination(c, arr, filters);
        } else {
            newRetailDeliveryTicketLineItems.forEach((item) => {
            	arr.push(item.Product);
        	});
            console.log('arr = ',arr);    
        	h.initPagination(c, arr, filters,'paginatorActive');    
        }
                }),300);
	},
    fetchProducts: function (c, e, h) {
        var ids = e.getParam('ids');
        let recSize = c.get('v.perPage');
        let products = c.get('v.allProducts');        
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
            	if(!setOfIds.includes(item.id)){
                	arr.push(item.id);
        		}
            });
            h.initPagination(c, arr, filters);
        } else {
            h.initPagination(c, setOfIds, filters,'paginatorActive');
        }
    },
	onViewBrand:function(c,e,h){
		var brandId = e.currentTarget.dataset.id;
        sessionStorage.setItem('brandId', brandId);
        h.redirect('/brand', true);
    },    
    onProductDetail :function(c,e,h){
        var priceId = e.currentTarget.dataset.id;  
        /*sessionStorage.setItem('pricebookEntry', priceId);
        window.open('https://dev-filigreen.cs165.force.com/filigreenb2b/s/product?id='+priceId,'_blank');*/
        //h.redirect('/product', true);
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
     handleSelectedRecord: function (c, e, h) {
		var objectName = e.getParam('objectName');
		var selectedRecord = e.getParam('selectedRecord');
        console.log('selectedRecord = ',selectedRecord.value);
        console.log('objectName = ',objectName);
        
		if (objectName == 'Site__c') {
            c.set('v.selectedSite', selectedRecord);
            let rdt = c.get('v.newRetailDeliveryTicket');
            rdt.siteId = selectedRecord.value;
            c.set('v.newRetailDeliveryTicket',rdt);
		} 
	},
});