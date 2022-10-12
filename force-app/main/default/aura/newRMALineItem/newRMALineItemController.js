({
	onInit : function(c, e, h) {
		var retailOrderLineItem = c.get('v.retailOrderLineItem');
        retailOrderLineItem.rquantity = retailOrderLineItem.quantity - retailOrderLineItem.totalReturnQty;
        
        c.set('v.retailOrderLineItem',retailOrderLineItem);
	},
    validate: function (c, e, h) {
        return h.isValid(c);
    },
})