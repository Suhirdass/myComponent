({
	navigate : function(c, e, h) {
        
        h.request(c, 'recalculateServiceInvoice', { soId: c.get("v.recordId") }, function (r) {
            //$A.get("e.force:closeQuickAction").fire();  
            if(r.errMsg != '' && r.errMsg != null && r.errMsg != undefined){
                h.warning({ message: r.errMsg}); 
            	$A.get("e.force:closeQuickAction").fire();     
            } else {
             	 window.location.reload();   
            }
        });
    }
})