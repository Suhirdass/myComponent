({
	doInit :function(c, e, h) {
        console.log('id : ',c.get('v.recordId'));
        h.request(c, 'lockAndUnlockToInvoice', { recordId: c.get('v.recordId') ,isUpdateInv : false}, function (r) {
            //console.log('##invoice :',r.Invoice.IsLocked__c)
            if(r.Error){
                h.error({message:r.Error});
                $A.get("e.force:closeQuickAction").fire();
            }else if(r.success){
                c.set('v.Invoice',r.Invoice);
                c.set('v.isLock',r.Invoice.IsLocked__c);
            }
        });
		
	},
    onYes :function(c, e, h) {
        var msg = '';
        if(c.get('v.isLock')){
            msg = 'Invoice unlocked successfully. '
        }else{
            msg = 'Invoice locked successfully. '
        }
        h.request(c, 'lockAndUnlockToInvoice', { recordId: c.get('v.recordId') ,isUpdateInv : true}, function (r) {
            var toastEvent = $A.get("e.force:showToast");
                                    toastEvent.setParams({
                                        title : 'success',
                                        message:msg,
                                        duration:' 5000',
                                        key: 'info_alt',
                                        type: 'success',
                                        mode: 'pester'
                                    });
                                    toastEvent.fire(); 
            window.setTimeout(
                        $A.getCallback(function() {
                           window.location.reload();
                        }), 100
                    );
             
            $A.get("e.force:closeQuickAction").fire();
        });
        
    },
    onCancel : function(c,e,h){
        $A.get("e.force:closeQuickAction").fire();
    }
})