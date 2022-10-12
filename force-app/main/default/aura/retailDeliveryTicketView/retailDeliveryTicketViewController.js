({
    onInit: function (c, e, h) {
        try {
            c.set('v.recordId', sessionStorage.getItem('retaildeliveryticketId'));
        
        var filters = { orderByField: 'Product__r.Brand_Name__c', isASC: false };
        c.set('v.filters', filters);
        
        h.request(c,'getRetailDeliveryTicket',{ recordId: c.get('v.recordId') },function (r) {
            
            console.log('getRetailDeliveryTicket:', r);
            c.set('v.retailDeliveryTicket', r.retailDeliveryTicket);
            
            c.set('v.retailDeliveryTicketLineItems',r.retailDeliveryTicketLineItems);
            c.set('v.allRetailDeliveryTicketLineItems',r.retailDeliveryTicketLineItems);
            c.set('v.shippingToolTip', r.shippingToolTip);
            c.set('v.distributionToolTip', r.distributionToolTip);
            c.set('v.factoringDiscountToolTip', r.factoringDiscountToolTip);
            c.set('v.Order_Delete_Confirm_Message',r.Order_Delete_Confirm_Message);
            c.set('v.Order_Deleted_Message',r.Order_Deleted_Message);
            c.set('v.BarCodeORQRCodeMSG',r.BarCodeORQRCodeMSG);
            c.set('v.ThirdPartySchedulerMSG',r.ThirdPartySchedulerMSG);
            for(let smlst in r.invoiceList){
                let oldDate = r.invoiceList[smlst].Ship_Confirmation_Date__c;
                if(oldDate != null && oldDate != undefined && oldDate != ''){
                    let dtSplit = oldDate.split('-');
                    let newDate = dtSplit[1] + '/' + dtSplit[2] + '/' + dtSplit[0];
                    console.log('Date = ',newDate);
                    r.invoiceList[smlst].Ship_Confirmation_Date__c = newDate;
                }
            }
            
            c.set('v.invoiceList',r.invoiceList);  
            var invFile = [];
            for(var key in r.invoiceFileIds){
                invFile.push({value:r.invoiceFileIds[key], key:key});
            }
            c.set('v.invoicesIdsList', invFile);
            
            for(let smlst in r.shipmenifestList){
                let oldDate = r.shipmenifestList[smlst].Ship_Confirmation_Date__c;
                if(oldDate != null && oldDate != undefined && oldDate != ''){
                    let dtSplit = oldDate.split('-');
                    let newDate = dtSplit[1] + '/' + dtSplit[2] + '/' + dtSplit[0];
                    console.log('Date = ',newDate);
                    r.shipmenifestList[smlst].Ship_Confirmation_Date__c = newDate;
                }
            }
            c.set('v.shipmenifestList',r.shipmenifestList);
            
            var smFile = [];
            for(var key in r.SMFileIds){
                smFile.push({value:r.SMFileIds[key], key:key});
            }
            c.set('v.smIdsList', smFile);
            
            
            var retailDeliveryTicketLineItems = c.get('v.retailDeliveryTicketLineItems');
            
            let grandTotal = 0;
            let subTotal = 0;
            let totalExciseTax = 0;
            let totalPickPack = 0;
            let totalQAReview = 0;
            var warehouseAvailableInventoryMap = r.warehouseAvailableInventoryMap;
            var warehouseTotalOrderedMap = r.warehouseTotalOrderedMap;
            
            retailDeliveryTicketLineItems.forEach(function (entry, index, object) {
                if (entry.Product) {
                    if(entry.isDiscountProduct){
                        subTotal -= entry.MOQ * entry.orderQty * entry.salesPrice ;
                    }else{
                        subTotal += entry.MOQ * entry.orderQty * entry.salesPrice ;
                    }
                    
                    if(!r.retailDeliveryTicket.excludeExciseTax){
                        if (!entry.isSample && entry.applyExciseTax != 'No') {
                            //totalExciseTax += parseFloat(entry.salesPrice * entry.orderQty * entry.MOQ, 10) * 1.8 * 0.15;
                            
                            totalExciseTax += entry.isDiscountProduct? parseFloat(((entry.salesPrice * -1) * (1.8) * (0.15)),10).toFixed(3) * entry.orderQty * entry.MOQ : parseFloat((entry.salesPrice * (1.8) * (0.15)),10).toFixed(3) * entry.orderQty * entry.MOQ;
                        }
                    }
                }
                if(entry.pickPackFee != undefined && entry.pickPackFee != null){
                    totalPickPack += parseFloat(entry.pickPackFee);
                }
                console.log('QAReviewFee = ',entry.QAReviewFee)
                if(entry.QAReviewFee != undefined && entry.QAReviewFee != null){
                    totalQAReview += parseFloat(entry.QAReviewFee);
                }
                var warehouseInventoryDetails = '';
                var warehouseDetails = warehouseAvailableInventoryMap[entry.Product]||[];
                warehouseDetails.forEach((item) => {
                    var key = item.id +'-'+entry.Product;
                    var totalOrderedQty = warehouseTotalOrderedMap[key] || 0;
                	if(item.name != undefined){
                        var itemName = item.name.split(',')[0];
                        var itemNameList = itemName.split(' ');
                        var itemNm = '';
                        itemNameList.forEach((nm) => {
                            itemNm += nm.substring(0,1); 
                        });
                        var totalInventry = item.availableInventory - totalOrderedQty;
                		totalInventry = totalInventry || 0
                        if(entry.MOQ > 0)
                            totalInventry = totalInventry / entry.MOQ; 
                        if(totalInventry % 1 != 0)
                            totalInventry = totalInventry.toFixed(2);
                        warehouseInventoryDetails = warehouseInventoryDetails + itemNm + ': ' + totalInventry + ' Cases <br/>';
                	}
                });
                entry.warehouseInventoryDetails = warehouseInventoryDetails;
            });
            
            var orderInfo = '<table>';
            orderInfo += '<tr><td style="text-align:right">Order Booking: &nbsp;</td><td> $'+(r.retailDeliveryTicket.orderBookingFee ? r.retailDeliveryTicket.orderBookingFee.toFixed(2) : '0.00')+'</td></tr>';
            orderInfo += '<tr><td style="text-align:right">Pack Out Fee: &nbsp;</td><td> $'+(r.retailDeliveryTicket.packOutFee ? r.retailDeliveryTicket.packOutFee.toFixed(2) : '0.00')+'</td></tr>';
            orderInfo += '<tr><td style="text-align:right">Pick & Pack: &nbsp;</td><td> $'+(totalPickPack ? totalPickPack.toFixed(2) : '0.00')+'</td></tr>';
            orderInfo += '<tr><td style="text-align:right">QA Review: &nbsp;</td><td> $'+(totalQAReview ? totalQAReview.toFixed(2) : '0.00')+'</td></tr>';
            orderInfo += '<tr><td style="text-align:right">Stage & Manifest: &nbsp;</td><td> $'+(r.retailDeliveryTicket.stageManifestFee ? r.retailDeliveryTicket.stageManifestFee.toFixed(2) : '0.00')+'</td></tr>';
            orderInfo += '</table>';
            c.set('v.orderInfo',orderInfo);
            
            
            console.log('subTotal ',subTotal);
            grandTotal = subTotal + totalExciseTax;
            subTotal = subTotal.toFixed(2);
        	let totalExTax = parseFloat(totalExciseTax.toFixed(3));
        	console.log('totalExTax ',totalExTax);
        	console.log('totalExTax ',totalExTax.toFixed(2));
        
            totalExciseTax = parseFloat(totalExciseTax).toFixed(3);
            
            c.set('v.totalExcisetax', totalExciseTax);
            c.set('v.grandTotal', grandTotal.toFixed(2));
            c.set('v.subTotal', subTotal);
        
        	retailDeliveryTicketLineItems.forEach((item) => {
            	item.orderQty = item.orderQty.toFixed(2);
            });
            c.set('v.retailDeliveryTicketLineItems',retailDeliveryTicketLineItems);
            
        	var orderProcessingFee = totalPickPack + totalQAReview + r.retailDeliveryTicket.orderBookingFee + r.retailDeliveryTicket.stageManifestFee + r.retailDeliveryTicket.packOutFee; 
        	let shippingFee = r.retailDeliveryTicket.scheduleDispatchFee + r.retailDeliveryTicket.totalMileageFee + r.retailDeliveryTicket.totalWeightFee;
            let totalServicesfee = orderProcessingFee + shippingFee;
            
            c.set('v.totalServicesfee',totalServicesfee.toFixed(2));
           	c.set('v.shippingFee',shippingFee);
            let distribution = subTotal > 0 ? totalServicesfee/parseFloat(subTotal) : 0 ;
            distribution = distribution * 100;
        	c.set('v.orderProcessingFee',orderProcessingFee.toFixed(2));
            c.set('v.distribution',distribution.toFixed(1));
            
        	const factoringRate = r.retailDeliveryTicket.factoringRate||0;
            var factoringDiscount  = (parseFloat(subTotal) + parseFloat(totalExciseTax)) * factoringRate / 100;    
            //grandTotal = parseFloat(subTotal) + parseFloat(totalExciseTax) - factoringDiscount;
            grandTotal = parseFloat(subTotal) + parseFloat(totalExciseTax);
            console.log('##totalServiceFee::',totalServicesfee/parseFloat(subTotal));
                console.log('##subtotal::',subTotal);
                console.log('##distribution::',distribution);
                console.log('##orderProcesssingFee::',orderProcessingFee);
                console.log('##shippingfee::',shippingFee);
            console.log('##factoringDiscount::',factoringDiscount);
            c.set('v.factoringDiscount',factoringDiscount);
        	c.set('v.grandTotal', grandTotal.toFixed(2));
        
        	h.setPagination(c,e,h,true);
            
            /*var relatedContacts = r.relatedContacts || [];
            var selectedContactIds = relatedContacts.length
            ? r.retailDeliveryTicket.retailerContact + ';' + relatedContacts.join(';')
            : r.retailDeliveryTicket.retailerContact;
            c.set('v.selectedContactIds', selectedContactIds);*/
            
            /*var contactsOptions = [];
            if (r.contacts && r.contacts.length) {
                for (var i = 0; i < r.contacts.length; i++) {
                    contactsOptions.push({
                        label: r.contacts[i].name,
                        value: r.contacts[i].id,
                    });
                }
            }
            c.set('v.contactsOptions', contactsOptions);*/
        });
                } catch (err) {
                console.log('error msg : ',err);
            }
	},
    
    onViewBrand:function(c,e,h){
		var brandId = e.currentTarget.dataset.id;
        sessionStorage.setItem('brandId', brandId);
        //alert(brandId);
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
    
	onEdit: function (c, e, h) {
		var recordId = e.getSource().get('v.value');
		sessionStorage.setItem('retailDeliveryTicketId', recordId);
		h.redirect('/newretaildeliveryticket', true);
	},
    
    fetchProducts: function (c, e, h) {
        var ids = e.getParam('ids');
        console.log('fetchProducts ids::',ids);
        let recSize = c.get('v.perPage');
        let products = c.get('v.allRetailDeliveryTicketLineItems');
        
        var arr = [];
        for(let i = 0; i< products.length; i++){
            if(ids.includes(products[i].Product)){
                arr.push(products[i]);
            }
        }
        c.set('v.retailDeliveryTicketLineItems',arr);
        //h.getProducts(c, ids);
    },
        
    sortProducts: function (c, e, h) {
    	var sortOrder = c.get('v.sortOrder');
        var sortField = c.get('v.sortField');
        var currentSortField = e.currentTarget.dataset.field;
        if(currentSortField == sortField){
        	if(sortOrder == 'ASC')
            	sortOrder = 'DESC';
        	else
            	sortOrder = 'ASC';    
        }else{
        	sortOrder = 'ASC';        
        }   
        c.set('v.sortOrder',sortOrder);
        c.set('v.sortField',currentSortField);
        var allRetailDeliveryTicketLineItems = c.get('v.allRetailDeliveryTicketLineItems'); 
        allRetailDeliveryTicketLineItems = h.sortAllProducts(c, e, h,allRetailDeliveryTicketLineItems,sortOrder,currentSortField);
        c.set('v.allRetailDeliveryTicketLineItems',allRetailDeliveryTicketLineItems); 
        h.searchData(c, e, h);
    },
            
    onChangeSearchProduct: function (c, e, h) {
        h.searchData(c, e, h);
    },
    
	onCancel: function (c, e, h) {
		h.redirect('/retaildeliverytickets', true);
	},
            
    printDetails: function (c, e, h) {
        var selectedMenuItemValue = e.getParam("value");
        var currentUrl = window.location.href;
        currentUrl = currentUrl.replace('/s/viewbrandorder','/apex/printOrderDetails?recordId='+c.get('v.recordId')+'&ExportWithFees='+(selectedMenuItemValue == 'ExportWithFees'));
        console.log('currentUrl::',currentUrl);
        window.open(currentUrl,'_blank');  
        
    	/*var currentUrl = window.location.href;
        currentUrl = currentUrl.replace('/s/viewbrandorder','/apex/printOrderDetails?recordId='+c.get('v.recordId'));
        console.log('currentUrl::',currentUrl);
        window.open(currentUrl,'_blank');     */   
	},
    onDelete: function (c, e, h) {
        var recordId = e.getSource().get('v.value');
        c.set('v.orderIdForDelete',recordId);
        
        c.set('v.isShowConfirm',true);
        window.setTimeout($A.getCallback(function(){
            const modal = document.getElementById('confirm-modal');
        	if (modal) modal.classList.add('is-active');
        }),100);
         
    },
    onClone: function (c,e,h){
         //alert('1');
         try{
             var newRDT = c.get('v.retailDeliveryTicket');
             newRDT.requestShipDate =  $A.localizationService.formatDate(new Date(), "YYYY-MM-DD");
             newRDT.brandContactIds =newRDT.brandContactIds != '' ? newRDT.brandContactIds :'';
             newRDT.retailerContact =newRDT.retailerContact != ''? newRDT.retailerContact:'';
             newRDT.salesPersonIds = newRDT.salesPersonIds !='' ? newRDT.salesPersonIds : '';
             var newRDTLineItem = c.get('v.allRetailDeliveryTicketLineItems');
            
             newRDTLineItem.forEach((item) => {
            	item.id = '';
                item.name='';
            });
             c.set('v.retailDeliveryTicket', newRDT); 
                 c.set('v.allRetailDeliveryTicketLineItems', newRDTLineItem); 
                    sessionStorage.setItem('retailDeliveryTicket', JSON.stringify(c.get('v.retailDeliveryTicket')));
                 	sessionStorage.setItem('retailDeliveryTicketLineItems', JSON.stringify(c.get('v.allRetailDeliveryTicketLineItems')));
                 	sessionStorage.setItem('isCloneOrder', 'True');
                     var brd = sessionStorage.getItem('breadCrumb');
                     if(brd){
                         brd = JSON.parse(brd);
                         brd.breadCrumbString += ' > '+'Create Order';
                         brd.breadCrumbIds+=' > ';
                         sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}));
                         $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}).fire();
                     }
        if(newRDT.total > 0)
                     h.redirect('/newbrandorder', true);
        else
            h.redirect('/create-sample-order', true);
         } catch (error) {
             console.log('Error:', error);
         }
      },   
    handleConfirmEvent :function(c,e,h){
        var isConfirm = e.getParam("isConfirm");
        if(isConfirm){
                h.request(c, 'deleteOrder', {recordId: c.get('v.orderIdForDelete')}, function (r) {
                    const modal = document.getElementById('confirm-modal');
                    if (modal) modal.classList.remove('is-active');
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Success',
                        message: c.get('v.Order_Deleted_Message'),
                        type: 'success'
                    });
                     toastEvent.fire();
                    c.set('v.orderIdForDelete','');
                    c.set('v.isShowConfirm',false);
                    setTimeout( function() {
                        h.redirect('/brandorders', true);
                       //h.getIds(c, c.get('v.filters'));
                    }, 1000);
                });
        }
    },
	recordDetail: function (c, e, h) {
        var dataset = e.currentTarget.dataset;
        h.navigateToRecord(c,dataset.id, "detail");
    },
	onViewInvoice : function(c,e,h){
        var dataset = e.currentTarget.dataset;
        try{
            var complianceFileIds = dataset.id.split(',');
            console.log('complianceFileIds = '+complianceFileIds.slice(0, -1));
            $A.get('e.lightning:openFiles').fire({
                recordIds: complianceFileIds.slice(0, -1)
            });
        } catch(error){
            console.log('Error = '+complianceFileIds);
        }
    }
});