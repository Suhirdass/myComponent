({
	doInit :function(c, e, h) {
        h.request(c, 'checkInvoice', { recordId: c.get('v.recordId') ,isUpdateInv : false}, function (r) {
            console.log('##invoice :',r.Invoice)
            if(r.error){
                h.error({message:r.error});
                $A.get("e.force:closeQuickAction").fire();
            }else if(r.success){
                c.set('v.Invoice',r.Invoice);
                c.set('v.showAlert',true);
            }
        });
		
	},
    onYes :function(c, e, h) {
        h.request(c, 'checkInvoice', { recordId: c.get('v.recordId') ,isUpdateInv : true}, function (r) {
            console.log('##invoice :',r.Invoice)
            h.navigateToComponent('c:AdminEditInvoiceScreen',{Invoice:r.Invoice},true);
        });
        
    },
    onCancel : function(c,e,h){
        $A.get("e.force:closeQuickAction").fire();
    }
})