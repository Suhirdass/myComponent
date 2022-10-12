({
    onInit: function (c, e, h) {
        try {
            c.set('v.recordId', sessionStorage.getItem('RMAId'));
        } catch (err) { }
        
        h.request(c, 'getRMADetails', { recordId: c.get('v.recordId') }, function (r) {
            console.log("getRMADetails:",r);
            c.set('v.RMA', r.RMA);
        });
    },
    onSMClick: function (c, e, h) {
        var dataset = e.currentTarget.dataset;
        var SMId = dataset.id;
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": SMId
        });
        navEvt.fire();
    },
  onProductClick: function (c, e, h) {
    var dataset = e.currentTarget.dataset;
    sessionStorage.setItem('pricebookEntry', dataset.id);
    h.redirect('/product', true);
  },
    onRMACancel:function (c, e, h) {
        
        h.request(c, 'cancelRMA', { recordId: e.getSource().get('v.value') }, function (r) {
            console.log("cancelRMA:",r);
            c.set('v.RMA', r.RMA);
        });
    },
    onEdit: function (c, e, h) {
        
        sessionStorage.setItem('RMAId', e.getSource().get('v.value'));
        h.redirect('/rmaedit', true);
    },
    onOrderClick: function (c, e, h) {
        var recordId = e.currentTarget.dataset.id;
        sessionStorage.setItem('retailorderId', recordId);
        h.redirect('/viewretailorder', true);
    }
})