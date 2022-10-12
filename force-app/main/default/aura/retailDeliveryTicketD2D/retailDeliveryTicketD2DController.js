({
    recordIdChanges: function (c, e, h) {
        c.set('v.RDTRecordId',c.get('v.recordId'));
    },
    onInit: function (c, e, h) {
        try {
            c.set('v.recordId', sessionStorage.getItem('retailDeliveryTicketId'));
            //console.log('Record Id:',sessionStorage.getItem('retailDeliveryTicketId'));
            console.log('Record Id:',c.get('v.recordId'));
            
            h.request(c, 'init', { recordId: c.get('v.recordId'),"fromTransferOrders":true }, function (r) {
                var disableExcludeExciseTax = true;
                c.set('v.Additional_Brand_Contact_Help_Text',r.Additional_Brand_Contact_Help_Text);
                console.log("retailDeliveryTicket response:", r);
                c.set('v.warehouseAvailableInventoryMap', r.warehouseAvailableInventoryMap);
                c.set('v.warehouseTotalOrderedMap', r.warehouseTotalOrderedMap);
                c.set('v.licenses', r.licenses);
                c.set('v.statelicenses', r.statelicenses);
                c.set('v.commSetting',r.commSetting);
                c.set('v.paymentTerms', r.paymentTerms);
                c.set('v.excludeExciseTaxTypes', r.excludeExciseTaxTypes);
                c.set('v.excludeExciseTaxTypesText',r.excludeExciseTaxTypes.join(', '));
                c.set('v.products', r.products);
                c.set('v.contacts', r.brandContacts);
                c.set('v.brandContacts', r.brandContacts);
                c.set('v.salesReps', r.salesReps);
                c.set('v.retailersDetail', r.retailersDetail);
                c.set('v.otherReletecContactIds',r.relatedContacts||[]);
                c.set('v.retailers', r.retailers);
                c.set('v.newRDT', r.tmpRetailDeliveryTicketLineItem);
                c.set('v.newRetailDeliveryTicket', r.retailDeliveryTicket);
                c.set('v.productOrderedQtyMap', r.productOrderedQtyMap);
                c.set('v.routeMiles', r.retailDeliveryTicket.Route_Miles);
                c.set('v.cutOffTime',r.cutOffTime);
                c.set('v.holidayList', r.holidayList);
                c.set('v.isDataLoaded',true);
                var relatedContacts = r.relatedContacts || [];
                var selectedContactIds = (relatedContacts.length?r.retailDeliveryTicket.retailerContact+';'+relatedContacts.join(';'):r.retailDeliveryTicket.retailerContact);
                
                c.set('v.selectedContactIds',selectedContactIds);
                console.log('Data',c.get('v.selectedContactIds'));
                var contactsOptions = [];
                if(r.contacts && r.contacts.length){
                    for(var i=0;i<r.contacts.length;i++){
                        contactsOptions.push({label: r.contacts[i].name, value: r.contacts[i].id});
                    }
                }
                
                c.set('v.contactsOptions',contactsOptions);
                if(r.retailDeliveryTicket.stateLicense){
                    var statelicense = r.statelicenses[r.retailDeliveryTicket.stateLicense].License_Type__c;
                    console.log(statelicense);
                    var excludeExciseTaxTypes = c.get('v.excludeExciseTaxTypes');
                    if(statelicense && excludeExciseTaxTypes.indexOf(statelicense) != -1){/*(statelicense == 'Type 11' || statelicense == 'Type 12' ||statelicense == 'Type 13')*/
                        disableExcludeExciseTax = false;
                    }else{
                        disableExcludeExciseTax = true;
                    }
                    c.set('v.disableExcludeExciseTax',disableExcludeExciseTax);
                }
                c.set('v.newRetailDeliveryTicketLineItems', r.retailDeliveryTicketLineItems);
                
                var retailDeliveryTicket = r.retailDeliveryTicket;
                
                let grandTotal = 0;
                let totalExciseTax = 0;
                let subTotal = r.retailDeliveryTicketLineItems.reduce((currentValue,item) => {
                    if(!retailDeliveryTicket.excludeExciseTax){
                        if(!item.isSample && item.applyExciseTax != 'No'){
                        	totalExciseTax += parseFloat((item.salesPrice * item.orderQty*item.MOQ),10) * (1.8) * (0.15);
                    	}
                	}
                    return parseFloat(currentValue,10) + parseFloat((item.salesPrice * item.orderQty*item.MOQ),10)
                },0.00)
                subTotal =  subTotal.toFixed(2);
                totalExciseTax = totalExciseTax.toFixed(2);
            	grandTotal = subTotal + totalExciseTax;
                c.set('v.grandTotal',grandTotal);
                c.set('v.grandTotalDiscount',grandTotal);
                c.set('v.totalExcisetax',totalExciseTax);
                c.set('v.subTotal',subTotal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
                var retailDeliveryTicketLineItems = r.retailDeliveryTicketLineItems;
                var brandRetailDeliveryOrderItems = Object.keys(r.brandRetailDeliveryOrderItems);
                if (brandRetailDeliveryOrderItems && brandRetailDeliveryOrderItems.length > 0) {
                    retailDeliveryTicketLineItems = [];
                    brandRetailDeliveryOrderItems.forEach(function (productId) {
                        retailDeliveryTicketLineItems.push({ Product: productId, orderQty: r.brandRetailDeliveryOrderItems[productId].quantity });
                    });
                    console.log('retailDeliveryTicketLineItems', JSON.stringify(retailDeliveryTicketLineItems));
                }
                c.set('v.newRetailDeliveryTicketLineItems', retailDeliveryTicketLineItems);
            if(c.get('v.recordId') != '' && c.get('v.recordId') != undefined){
                c.set('v.requestDateTimeHide',c.get('v.newRetailDeliveryTicket').requestShipDate);
                h.processCalculations(c,false);
            }
            });
        } catch (err) { console.log('Error:',err);}
    },
 	onScriptsLoaded: function(c, e, h) {
        console.log('onScriptsLoaded...');
        h.applyDate(c);
    },
        calculateExcludeTex : function (c, e, h){
        	var response = e.getSource().get("v.checked");
            var newRetailDeliveryTicketLineItems = c.get('v.newRetailDeliveryTicketLineItems');
            
            let subTotal = 0;
            let grandTotal = 0;
            let totalExciseTax = 0;
            newRetailDeliveryTicketLineItems.forEach(function(entry, index, object) {
                if(entry.Product){
                    subTotal += entry.MOQ * entry.orderQty * entry.salesPrice ;
                    if(!response){
                        if(!entry.isSample && entry.applyExciseTax != 'No'){
                            totalExciseTax += parseFloat((entry.salesPrice * entry.orderQty*entry.MOQ),10) * (1.8) * (0.15);
                        }    
                    }
                }
            });
            
            subTotal =  subTotal.toFixed(2)
            totalExciseTax = totalExciseTax.toFixed(2);
            grandTotal = parseFloat(subTotal)  +parseFloat(totalExciseTax);
            subTotal = subTotal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",").toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")
            
            c.set('v.totalExcisetax',totalExciseTax);
            c.set('v.grandTotal',grandTotal.toFixed(2));
            c.set('v.subTotal',subTotal);
        },   
        
        showDatePicker: function(c, e, h) {
            //$("#datepickerId").show(); 
            $("#datepickerId").datepicker("show");
        },
    calculateServiceFee :   function (c, e, h) {     
        h.processCalculations(c,true);
    },
    updateSubTotal: function (c, e, h) {
        console.log('updateSubTotal...');
        c.set('v.isEnable',false);
        var newRetailDeliveryTicketLineItems = c.get('v.newRetailDeliveryTicketLineItems');
        var newRetailDeliveryTicket = c.get('v.newRetailDeliveryTicket');
        
        let subTotal = 0;
        let grandTotal = 0;
        let totalExciseTax = 0;
        newRetailDeliveryTicketLineItems.forEach(function(entry, index, object) {
            if(entry.Product){
                subTotal += entry.MOQ * entry.orderQty * entry.salesPrice ;
                if(!newRetailDeliveryTicket.excludeExciseTax){
                    if(!entry.isSample && entry.applyExciseTax != 'No'){
                        console.log('OLI:',entry);
                        totalExciseTax += parseFloat((entry.salesPrice * entry.orderQty*entry.MOQ),10) * (1.8) * (0.15);
                    }    
                }
            }
        });
        /*let subTotal = newRetailDeliveryTicketLineItems.reduce((currentValue,item) => {
            return parseFloat(currentValue,10) + parseFloat((item.salesPrice * item.orderQty*item.MOQ),10)
        },0.00)*/
        subTotal =  subTotal.toFixed(2)
        totalExciseTax = totalExciseTax.toFixed(2);
        grandTotal = parseFloat(subTotal)  +parseFloat(totalExciseTax);
        subTotal = subTotal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",").toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")
        
        c.set('v.totalExcisetax',totalExciseTax);
        c.set('v.grandTotal',grandTotal.toFixed(2));
        c.set('v.subTotal',subTotal);
    },
    onAddRow: function (c, e, h) {
        console.log('Record Id:',c.get('v.recordId'));
        var newRetailDeliveryTicketLineItems = c.get('v.newRetailDeliveryTicketLineItems');
        newRetailDeliveryTicketLineItems.push(Object.assign({}, c.get('v.newRDTLI')));
        c.set('v.newRetailDeliveryTicketLineItems', newRetailDeliveryTicketLineItems);
    },
    updateTicketLineItem :function(c,e,h){
        var item = e.getParam('retailDeliveryTicketLineItem');
        var indexVal = e.getParam('indexVal');
        var rdlitems = c.get('v.newRetailDeliveryTicketLineItems');
        rdlitems[indexVal] = item;
        c.set('v.newRetailDeliveryTicketLineItems',rdlitems);
    },
        onRetailerChange: function (c, e, h) {
        c.set('v.isEnable',false);
        var retailerId = e.getSource().get('v.value');
        var newRetailDeliveryTicket = c.get('v.newRetailDeliveryTicket');
        console.log("retailerId::", retailerId);
        var licenses = [];
        var contacts = [];
        var statelicenses = {};
        var typeMap =[];
        if (retailerId) {
            var retailersDetailMap = c.get('v.retailersDetail');
            var retailersDetail = retailersDetailMap[retailerId];
            console.log("retailersDetail:",retailersDetail);
            licenses = retailersDetail.licenses;
            statelicenses = retailersDetail.statelicenses;
            contacts = retailersDetail.contacts;    
            typeMap = retailersDetail.typeMap;
            console.log('SalesRep = ',retailersDetail.salesRep.Sales_Person__c);
            if(retailersDetail.salesRep.Sales_Person__c != undefined){
            	newRetailDeliveryTicket.salesPerson = retailersDetail.salesRep.Sales_Person__r.Name;
                newRetailDeliveryTicket.salesPersonId = retailersDetail.salesRep.Sales_Person__c;
            } else {
                newRetailDeliveryTicket.salesPerson = ''; 
                newRetailDeliveryTicket.salesPersonId = ''; 
            }            
            var contactsOptions = [];
            for(var i=0;i<contacts.length;i++){
                contactsOptions.push({label: contacts[i].name, value: contacts[i].id});
            }
            c.set('v.contactsOptions',contactsOptions);
            var retailer = retailersDetail.retailer;
            newRetailDeliveryTicket.paymentTerms = retailersDetail.paymentTerm;//retailer.Payment_Terms__c;            
        } else {
            newRetailDeliveryTicket.paymentTerms = '';
        }
        
        
        c.set('v.newRetailDeliveryTicket', newRetailDeliveryTicket);
        c.set('v.licenses', licenses);
        c.set('v.contacts', contacts);
        var contactsOptions = [];
        for(var i=0;i<contacts.length;i++){
            contactsOptions.push({label: contacts[i].name, value: contacts[i].id});
        }
        c.set('v.contactsOptions',contactsOptions);
        c.set('v.statelicenses', statelicenses);      
        
        console.log("retailer details ::", JSON.stringify(retailersDetail));
    },
    onRemoveRow: function (c, e, h) {
        c.set('v.isEnable',false);
        var rowIndex = e.getSource().get('v.value');
        var newRetailDeliveryTicketLineItems = c.get('v.newRetailDeliveryTicketLineItems');
        var tmp = newRetailDeliveryTicketLineItems[rowIndex];
        newRetailDeliveryTicketLineItems.splice(rowIndex, 1);
        if (newRetailDeliveryTicketLineItems.length > 0) {
            let subTotal = newRetailDeliveryTicketLineItems.reduce((currentValue,item) => {
                return parseFloat(currentValue,10) + parseFloat((item.salesPrice * item.orderQty*item.MOQ),10)
            },0.00)
            subTotal =  subTotal.toFixed(2);
            subTotal = subTotal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",").toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")
            c.set('v.subTotal',subTotal);
            c.set('v.newRetailDeliveryTicketLineItems', newRetailDeliveryTicketLineItems);
        } else {
            h.warning({ message: 'Atleast a Retail Delivery Ticket Line Item is required.' });
        }
        if (tmp.Product) {
            h.request(c, 'removeProduct', { productId: tmp.Product }, function (r) {
                if (r.isBrand) {
                    $A.get('e.c:updateCartTotalEvt').setParams({ cartTotal: r.quantity }).fire();
                }
            }, { showSpinner: false });
        }
    },
    onSave: function (c, e, h) {
        try {
            var recordId = sessionStorage.getItem('retailDeliveryTicketId');//c.get('v.recordId');
            console.log('recordId::',recordId);
            var isParentValid = h.isValid(c);
            console.log("isParentValid::", isParentValid);
            var selectedIds = c.get('v.selectedContactIds');
            if(selectedIds == ''){
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : '',
                    message:'Please select atleast one retailer contact',
                    messageTemplate: '',
                    duration:' 4000',
                    key: 'info_alt',
                    type: 'error',
                    mode: 'pester'
                });
                toastEvent.fire();
                return;
            }
            var retailDeliveryTicketLineItems = c.find('retailDeliveryTicketLineItem');
            var isValid;
            isValid = [].concat(retailDeliveryTicketLineItems).reduce(function (validSoFar, retailDeliveryTicketLineItem) {
                return validSoFar && retailDeliveryTicketLineItem.validate();
            }, true);
            if (!isParentValid || !isValid) {
                return false;
            }
            
            var newRetailDeliveryTicket = c.get('v.newRetailDeliveryTicket');
            if(!c.get('v.isDateChanged')){
                var reqDate = c.get('v.reqTempDate');
            	newRetailDeliveryTicket.requestShipDate = reqDate;   	    
            } else {
            	var reqDate = c.get('v.requestDateTimeHide');
            	newRetailDeliveryTicket.requestShipDate = reqDate;    
            }
            
            c.set('v.newRetailDeliveryTicket',newRetailDeliveryTicket);
            
            console.log('Items:',c.get('v.newRetailDeliveryTicketLineItems'));
            h.request(c, 'saveRetailDeliveryTicket', { recordId: recordId,
                                                      retailDeliveryTicketData: JSON.stringify(c.get('v.newRetailDeliveryTicket')),
                                                      retailDeliveryTicketLineItemsData: JSON.stringify(c.get('v.newRetailDeliveryTicketLineItems')),
                                                      "otherReletecContactIds":JSON.stringify(c.get('v.otherReletecContactIds')),"fromTransferOrders":true }, function (r) {
                                                          $A.get('e.c:updateCartTotalEvt').setParams({ cartTotal: 0 }).fire();
                                                          h.success({ message: ('Outbound Order ' + (recordId ? 'updated ' : 'created') + ' successfully.') });
                                                          h.redirect('/retaildeliveryticketsd2d', true);
                                                      });
        } catch (error) {
            console.log("Error:", error);
        }
    },
    onSelectChange: function (c, e, h) {
        
        var selectedContactIds = c.get('v.selectedContactIds');
        selectedContactIds = selectedContactIds.split(';');
        var newRetailDeliveryTicket = c.get('v.newRetailDeliveryTicket');
        newRetailDeliveryTicket.retailerContact = selectedContactIds[0];
        c.set('v.newRetailDeliveryTicket',newRetailDeliveryTicket);
        var otherReletecContactIds = [];
        for(var i=1;i<selectedContactIds.length;i++){
            otherReletecContactIds.push(selectedContactIds[i]);
        }
        c.set("v.otherReletecContactIds",otherReletecContactIds);
        console.log("Selected Contacts::",c.get('v.selectedContactIds'));
    },
    onCancel: function (c, e, h) {
        var recordId = c.get('v.recordId');
        if(recordId == ''){
            $A.get('e.c:updateCartTotalEvt').setParams({ cartTotal: 0 }).fire();
            h.request(c, 'removeProducts', {}, function (r) { }, { showSpinner: false, background: true });
        }
        
        
        h.redirect('/retaildeliveryticketsd2d', true);
    },
    onPOBlur:function (c, e, h) {
        var newRetailDeliveryTicket = c.get('v.newRetailDeliveryTicket');
        console.log('onPOBlur:',newRetailDeliveryTicket.retailerPO.trim().length);
        
        newRetailDeliveryTicket.retailerPO = (newRetailDeliveryTicket.retailerPO?newRetailDeliveryTicket.retailerPO.trim():'');
        c.set('v.newRetailDeliveryTicket',newRetailDeliveryTicket);
        e.getSource().set('v.validity', {valid:false, badInput :true});
        e.getSource().showHelpMessageIfInvalid();
    }
})