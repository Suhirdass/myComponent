({
	
/*	doInit : function(c, e, h) {
         helper.getData(c, e);
		h.request(c, 'createServiceInvoice', { recordId: c.get('v.recordId') }, function (r) {
            console.log("createServiceInvoice:",r);
            if(r.invoiceId){
                h.navigateToRecord(c,r.invoiceId,'detail');
                $A.get("e.force:closeQuickAction").fire();
            }else{
                $A.get("e.force:closeQuickAction").fire();
            }
        });
	},*/
    createCTI : function(c, e, h) {
     h.request(c, 'createServiceInvoice', { recordId: c.get('v.recordId') }, function (r) {
            console.log("createServiceInvoice:",r);
            if(r.invoiceId){
                h.navigateToRecord(c,r.invoiceId,'detail');
                $A.get("e.force:closeQuickAction").fire();
            }
        });   
    },
      cancel : function(component, event, helper) {
		$A.get("e.force:closeQuickAction").fire();
	},
     doInit : function(component, event, helper) {
        console.log("doInit");
		console.log(component.get("v.recordId"));
                helper.getData(component, event);

        //helper.getData(component, event);
	},
})