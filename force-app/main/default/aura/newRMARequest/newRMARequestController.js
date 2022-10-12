({
    onInit: function (c, e, h) {
        try {
            c.set('v.recordId', sessionStorage.getItem('retailRMAorderId'));
        } catch (err) { }
        
        h.request(c, 'getRetailOrderForReturn', { recordId: c.get('v.recordId') }, function (r) {
            console.log("getRetailOrder:",r);
            c.set('v.retailOrder', r.retailOrder);
            c.set('v.returnCode',r.returnCode);
        });
    },
    onCancel: function (c, e, h) {
        h.redirect('/viewretailorder', true);
    },
    onSave: function (c, e, h) {
        var retailOrder = c.get('v.retailOrder');
        console.log("retailOrder::",retailOrder);
        var newRMALineItems = c.find('newRMALineItem');
        var isValid;
        isValid = [].concat(newRMALineItems).reduce(function (validSoFar, newRMALineItem) {
            return validSoFar && newRMALineItem.validate();
        }, true);
        if (!isValid) {
            return false;
        }
        var selectedItems = [];
        for(var i=0;i<retailOrder.items.length;i++){
            if(retailOrder.items[i].isSelected){
                selectedItems.push(retailOrder.items[i]);
            }
        }
        if(!selectedItems.length){
            h.error({message:'Please selected at least one item to return.'});
            return false;
        }
        h.request(c, 'saveRMARequest', {orderId:retailOrder.id, SMId: retailOrder.SMId,
                                                  newRMARequestItmesData: JSON.stringify(selectedItems) }, function (r) {
        h.success({ message: 'New RMA Request created successfully.'});
        h.redirect('/orders', true);
      });
    }
})