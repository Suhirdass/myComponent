({
	onInit: function (c, e, h) {
        try {
            c.set('v.recordId', sessionStorage.getItem('RMAId'));
        } catch (err) { }
        
        h.request(c, 'RMAInit', { recordId: c.get('v.recordId') }, function (r) {
            console.log("RMAInit:",r);
            c.set('v.RMA', r.RMA);
            c.set('v.returnCode',r.returnCode);
        });
    },
    onCancel: function (c, e, h) {
        sessionStorage.setItem('RMAId', e.getSource().get('v.value'));
        h.redirect('/rmadetails', true);
    },
    onRMACancel:function (c, e, h) {
        
        h.request(c, 'cancelRMA', { recordId: e.getSource().get('v.value') }, function (r) {
            console.log("cancelRMA:",r);
            c.set('v.RMA', r.RMA);
        });
    },
    onSaveRMA:function(c, e, h){
        var RMA = c.get('v.RMA');
        var newRMALineItems = c.find('RMALineItem');
        var isValid;
        isValid = [].concat(newRMALineItems).reduce(function (validSoFar, newRMALineItem) {
            return validSoFar && newRMALineItem.validate();
        }, true);
        if (!isValid) {
            return false;
        }
        /*var selectedItems = [];
        for(var i=0;i<RMA.items.length;i++){
            if(RMA.items[i].isSelected){
                selectedItems.push(RMA.items[i]);
            }
        }
        if(!selectedItems.length){
            h.error({message:'Please selected at least one item to return.'});
            return false;
        }*/
        h.request(c, 'updateRMA', {recordId:c.get('v.recordId'),
                                                  RMALineItemsData: JSON.stringify(RMA.items) }, function (r) {
        h.success({ message: 'New RMA update successfully.'});
        h.redirect('/orders', true);
      });
    }
})