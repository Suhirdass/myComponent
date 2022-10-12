({
    onInit: function (c, e, h) {
        //debugger;
        var retailDeliveryTicketLineItem = c.get('v.retailDeliveryTicketLineItem');
        var retailDeliveryTicketLineItemOld = Object.assign({},retailDeliveryTicketLineItem);
        c.set('v.retailDeliveryTicketLineItemOld',retailDeliveryTicketLineItemOld);
        if (retailDeliveryTicketLineItem.Product !== '') {
            h.setProductDetails(c, retailDeliveryTicketLineItem.Product, (retailDeliveryTicketLineItem.orderQty || 1),false);
        }
    },
    validate: function (c, e, h) {
        /*var retailDeliveryTicketLineItem = c.get('v.retailDeliveryTicketLineItem');
        if(retailDeliveryTicketLineItem.availableQty<=0){
            h.error({message:'Available Qty must be grater than 0.'});
        }
        if(retailDeliveryTicketLineItem.cases < retailDeliveryTicketLineItem.orderQty){
            h.error({message:'Order Qty (Cases) is greater than Available Qty.'});
        }
        return (retailDeliveryTicketLineItem.availableQty>0 && retailDeliveryTicketLineItem.cases >= retailDeliveryTicketLineItem.orderQty && h.isValid(c));*/
        var retailDeliveryTicketLineItem = c.get('v.retailDeliveryTicketLineItem');
        var retailDeliveryTicketLineItemOld = c.get('v.retailDeliveryTicketLineItemOld');
        console.log('old:',retailDeliveryTicketLineItemOld.orderQty ,'==>new:', retailDeliveryTicketLineItem.orderQty);
        if(((retailDeliveryTicketLineItem.id && retailDeliveryTicketLineItemOld.orderQty != retailDeliveryTicketLineItem.orderQty && retailDeliveryTicketLineItem.orderQty > retailDeliveryTicketLineItemOld.orderQty)
          || !retailDeliveryTicketLineItem.id) && retailDeliveryTicketLineItem.availableQty<=0){
            h.error({message:'Available Qty must be grater than 0.'});
        }
        if(((retailDeliveryTicketLineItem.id && retailDeliveryTicketLineItemOld.orderQty != retailDeliveryTicketLineItem.orderQty && retailDeliveryTicketLineItem.orderQty > retailDeliveryTicketLineItemOld.orderQty)
          || !retailDeliveryTicketLineItem.id) && retailDeliveryTicketLineItem.cases < retailDeliveryTicketLineItem.orderQty){
            h.error({message:'Order Qty (Cases) is greater than Available Qty.'});
        }
        /*if(retailDeliveryTicketLineItem.id && retailDeliveryTicketLineItemOld.orderQty != retailDeliveryTicketLineItem.orderQty && retailDeliveryTicketLineItem.cases < retailDeliveryTicketLineItem.orderQty){
            h.error({message:'Order Qty (Cases) is greater than Available Qty.'});
        }*/
        
        var isValidItem = true;
        console.log('id:',(retailDeliveryTicketLineItem.id && retailDeliveryTicketLineItemOld.orderQty != retailDeliveryTicketLineItem.orderQty &&  retailDeliveryTicketLineItem.orderQty > retailDeliveryTicketLineItemOld.orderQty));
        if(retailDeliveryTicketLineItem.id && retailDeliveryTicketLineItemOld.orderQty != retailDeliveryTicketLineItem.orderQty &&  retailDeliveryTicketLineItem.orderQty > retailDeliveryTicketLineItemOld.orderQty){
            console.log('-->',retailDeliveryTicketLineItem.availableQty>0 && retailDeliveryTicketLineItem.cases >= retailDeliveryTicketLineItem.orderQty && h.isValid(c));
            return (retailDeliveryTicketLineItem.availableQty>0 && retailDeliveryTicketLineItem.cases >= retailDeliveryTicketLineItem.orderQty && h.isValid(c));
        }else if(!retailDeliveryTicketLineItem.id){
            return (retailDeliveryTicketLineItem.availableQty>0 && retailDeliveryTicketLineItem.cases >= retailDeliveryTicketLineItem.orderQty && h.isValid(c));
        }
        
        isValidItem = h.isValid(c);
        
        //return (retailDeliveryTicketLineItem.availableQty>0 && retailDeliveryTicketLineItem.cases >= retailDeliveryTicketLineItem.orderQty && h.isValid(c));
        return isValidItem;
    },
    onSubtotalChange:function(c,e,h){
        console.log('onSubtotalChange...');
        $A.get('e.c:updateRDTSubTotal').fire();
    },
    onProductChange: function (c, e, h) {
        var productId = e.getSource().get('v.value');
        h.setProductDetails(c, productId, 1,true);
    },
    inputBlur: function(c,e,h){
        var retailDeliveryTicketLineItem = c.get('v.retailDeliveryTicketLineItem');
        console.log('retailDeliveryTicketLineItem',retailDeliveryTicketLineItem.salesPrice);
        
        var val = c.get('v.commSetting');
        if(retailDeliveryTicketLineItem.salesPrice < val.Minimum_Sample_Sales_Price__c){
            Swal.fire({
                title: $A.get("$Label.c.Is_it_a_Sample"),
                text: "",
                type: "",
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#3c3636',
                confirmButtonText: 'Yes',
                cancelButtonText: 'No',
            }).then((result) => {
                var retailDeliveryTicketLineItem = JSON.parse(JSON.stringify(c.get('v.retailDeliveryTicketLineItem',true)));
                if (result.value) {
                	retailDeliveryTicketLineItem.isSample = true;
            	}else{
                    retailDeliveryTicketLineItem.isSample = false;
                }
                    retailDeliveryTicketLineItem.salesPriceChanged = true;
                    c.set('v.retailDeliveryTicketLineItem', retailDeliveryTicketLineItem);
            var evt = c.getEvent('retailDeliveryTicketLineEvt');
            evt.setParams({
                retailDeliveryTicketLineItem : retailDeliveryTicketLineItem,
                indexVal : c.get('v.indexVal')
            });
            evt.fire();
        });
    }
    
}
 })