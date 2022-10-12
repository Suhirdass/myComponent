({
    onInit: function (c, e, h) {
        try {
            c.set('v.sortOrder', 'ASC');
            c.set('v.sortField', 'brandName');
            c.set('v.recordId', sessionStorage.getItem('retaildeliveryticketId'));
        } catch (err) {}
        
        h.request(c,'getRetailDeliveryTicket',{ recordId: c.get('v.recordId') },function (r) {
            console.log('getRetailDeliveryTicket:', r);
            var retailDeliveryTicket = r.retailDeliveryTicket;
            var add = retailDeliveryTicket.stateLicenseName;
            var addList = add.split("-");
            if(addList.length > 2)
                c.set('v.shippingAddress', addList[2]);
            c.set('v.retailDeliveryTicket', retailDeliveryTicket);
            c.set('v.retailDeliveryTicketLineItems',r.retailDeliveryTicketLineItems);
            c.set('v.Transfer_Order_Delete_Confirm_Message',r.Transfer_Order_Delete_Confirm_Message);
            c.set('v.Transfer_Order_Deleted_Message',r.Transfer_Order_Deleted_Message);
            c.set('v.allRetailDeliveryTicketLineItems',r.retailDeliveryTicketLineItems);
            var retailDeliveryTicketLineItems =  r.retailDeliveryTicketLineItems
            
            let grandTotal = 0;
            let subTotal = 0;
            let totalExciseTax = 0;
            let totalPickPack = 0;
            let totalQAReview = 0;
            var warehouseAvailableInventoryMap = r.warehouseAvailableInventoryMap;
            var warehouseTotalOrderedMap = r.warehouseTotalOrderedMap;
            retailDeliveryTicketLineItems.forEach(function (entry, index, object) {
                if (entry.Product) {
                    subTotal += entry.MOQ * entry.orderQty * entry.salesPrice;
                    if(!retailDeliveryTicket.excludeExciseTax){
                        if (!entry.isSample && entry.applyExciseTax != 'No') {
                            //totalExciseTax += parseFloat(entry.salesPrice * entry.orderQty * entry.MOQ, 10) * 1.8 * 0.15;
                            totalExciseTax += entry.isDiscountProduct? parseFloat(((entry.salesPrice * -1) * (1.8) * (0.15)),10).toFixed(2) * entry.orderQty * entry.MOQ : parseFloat((entry.salesPrice * (1.8) * (0.15)),10).toFixed(2) * entry.orderQty * entry.MOQ;
                        }
                    }
                }
                if(entry.pickPackFee != undefined && entry.pickPackFee != null){
                    totalPickPack += parseFloat(entry.pickPackFee,10);
                }
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
                		totalInventry = totalInventry || 0;
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
            
            grandTotal = subTotal + totalExciseTax;
            subTotal = subTotal.toFixed(2);
            totalExciseTax = totalExciseTax.toFixed(2);
            
            c.set('v.totalExcisetax', totalExciseTax);
            c.set('v.grandTotal', grandTotal.toFixed(2));
            c.set('v.subTotal', subTotal);
        	var orderProcessingFee = totalPickPack + totalQAReview + r.retailDeliveryTicket.orderBookingFee + r.retailDeliveryTicket.stageManifestFee + r.retailDeliveryTicket.packOutFee; 
        	let shippingFee = r.retailDeliveryTicket.scheduleDispatchFee + r.retailDeliveryTicket.totalMileageFee + r.retailDeliveryTicket.totalWeightFee;
            let totalServicesfee = orderProcessingFee + shippingFee;
            c.set('v.totalServicesfee',totalServicesfee.toFixed(2));
           	c.set('v.shippingFee',shippingFee);
            let distribution = totalServicesfee/parseFloat(subTotal);
            distribution = distribution * 100;
        	c.set('v.orderProcessingFee',orderProcessingFee.toFixed(2));
            c.set('v.distribution',distribution.toFixed(1));
        	c.set('v.shippingToolTip', r.shippingToolTip);
        	c.set('v.distributionToolTip', r.distributionToolTip);
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
	},
    
	onEdit: function (c, e, h) {
		var recordId = e.getSource().get('v.value');
		sessionStorage.setItem('retailDeliveryTicketId', recordId);
		h.redirect('/newretaildeliveryticket', true);
	},
    
    onChangeSearchProduct: function (c, e, h) {
        h.searchData(c, e, h);
    },
    
	onCancel: function (c, e, h) {
		h.redirect('/outboundtransfers', true);
	},
	onViewBrand:function(c,e,h){
		var brandId = e.currentTarget.dataset.id;
        sessionStorage.setItem('brandId', brandId);
        h.redirect('/brand', true);
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
    handleConfirmEvent :function(c,e,h){
        var isConfirm = e.getParam("isConfirm");
        if(isConfirm){
                h.request(c, 'deleteOrder', {recordId: c.get('v.orderIdForDelete')}, function (r) {
                    const modal = document.getElementById('confirm-modal');
                    if (modal) modal.classList.remove('is-active');
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Success',
                        message: c.get('v.Transfer_Order_Deleted_Message'),
                        type: 'success'
                    });
                     toastEvent.fire();
                    c.set('v.orderIdForDelete','');
                    c.set('v.isShowConfirm',false);
                    setTimeout( function() {
                        h.redirect('/outboundtransfers', true);
                       //h.getIds(c, c.get('v.filters'));
                    }, 1000);
                });
        }
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
	printDetails: function (c, e, h) {
    	var currentUrl = window.location.href;
        currentUrl = currentUrl.replace('/s/viewoutboundtransfer','/apex/printOutboundTransferDetailsPDF?recordId='+c.get('v.recordId')+'&fromOrder=false&ExportWithFees=true');
        console.log('currentUrl::',currentUrl);
        window.open(currentUrl,'_blank');        
	}
});