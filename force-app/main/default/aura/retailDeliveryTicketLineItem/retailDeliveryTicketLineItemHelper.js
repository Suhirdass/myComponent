({
    setProductDetails: function(c, productId, quantity,productChanged){
        var product = undefined;
        var products = c.get('v.products');
        for (var i = 0; i < products.length; i++) {
            if (products[i].id == productId) {
                product = products[i];
                break;
            }
        }
        var retailDeliveryTicketLineItem = c.get('v.retailDeliveryTicketLineItem');
        var warehouseAvailableInventoryMap = c.get('v.warehouseAvailableInventoryMap');
        var warehouseTotalOrderedMap = c.get('v.warehouseTotalOrderedMap');
        var warehouseDetails = [];
        //debugger;
        var flag = retailDeliveryTicketLineItem.salesPriceChanged;
        flag = flag || false;
        console.log('flag::',flag);
        if(productChanged){
            flag = false;
            c.set('v.recordId','')
            retailDeliveryTicketLineItem.salesPriceChanged = false;
        }
        var recordId = c.get('v.recordId');
        console.log('product::',product);
        //debugger;
        if (product != undefined) {
            if(product.isSample == undefined){
                product.isSample = false;
            }
            retailDeliveryTicketLineItem.listPrice = product.price.unitPrice;
            if(!flag && (recordId == '' || recordId == null)){
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
            }
            retailDeliveryTicketLineItem.Product = product.id;
			warehouseDetails = warehouseAvailableInventoryMap[product.id]||[];
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
            var totalInventory = retailDeliveryTicketLineItem.availableQty/retailDeliveryTicketLineItem.MOQ;
            if(totalInventory % 1 != 0)
            	totalInventory = totalInventory.toFixed(2);
            retailDeliveryTicketLineItem.cases = totalInventory;
            retailDeliveryTicketLineItem.description = product.description;
        } else {
            retailDeliveryTicketLineItem.listPrice = 0;
            retailDeliveryTicketLineItem.salesPrice = 0;
            retailDeliveryTicketLineItem.originalSalesPrice = 0;
            retailDeliveryTicketLineItem.MOQ = 0;
            retailDeliveryTicketLineItem.MaxOrderAllowed = 0;
            retailDeliveryTicketLineItem.orderQty = 0;
            retailDeliveryTicketLineItem.availableInventory = 0;
            retailDeliveryTicketLineItem.availableQty = 0;
            retailDeliveryTicketLineItem.isSmaple = false;
            retailDeliveryTicketLineItem.cases = 0;
            retailDeliveryTicketLineItem.description = '';
        }
        console.log('retailDeliveryTicketLineItem::',retailDeliveryTicketLineItem);
        c.set('v.retailDeliveryTicketLineItem', retailDeliveryTicketLineItem);
        var warehouseInventoryDetails = '';
        var lineBreak = '';
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
                	totalInventry = totalInventry.toFixed(2);
            	console.log('Total Ordered Qty:',totalOrderedQty);
                //warehouseInventoryDetails = warehouseInventoryDetails +lineBreak + item.name+' - Available Qty : '+(item.availableInventory - totalOrderedQty)+' ';//+lineBreak;
            	warehouseInventoryDetails = warehouseInventoryDetails +lineBreak + itemNm +': '+ totalInventry +' Cases ';//+lineBreak;
                lineBreak = '<br/>';
        	}
        });
        c.set('v.warehouseInventoryDetails',warehouseInventoryDetails);    
        c.set('v.warehouseDetails',warehouseDetails);
        $A.get('e.c:updateRDTSubTotal').fire();
    }
})