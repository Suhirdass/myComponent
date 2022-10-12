({
	
    createCTI : function(c, e, h) {
        h.request(c, 'createServiceInvoice', { recordId: c.get('v.recordId'),isOBCreated :false }, function (r) {
            console.log("createServiceInvoice:",r);
            if(r.invoiceId){
                h.navigateToRecord(c,r.invoiceId,'detail');
                $A.get("e.force:closeQuickAction").fire();
            }
        });   
    },
    createInvoice : function(c, e, h) {
        h.request(c, 'createServiceInvoice', { recordId: c.get('v.recordId') ,isOBCreated : c.get('v.isOBCreated')}, function (r) {
            console.log("createServiceInvoice:",r);
            c.set('v.isOBCreated',fasle);
            if(r.invoiceId){
                h.navigateToRecord(c,r.invoiceId,'detail');
                $A.get("e.force:closeQuickAction").fire();
            }
        });   
    },
    cancel : function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
    },
    doInit : function(c, e, h) {
        try{
        console.log("doInit");
        console.log(c.get("v.recordId"));
        
        h.getData(c, e);
        
        h.request(c, 'createServiceInvoice', { recordId: c.get('v.recordId'),isOBCreated :false }, function (r) {
            console.log("createServiceInvoice:",r);
            if(r.isOBCreated){
                c.set('v.isOBCreated',r.isOBCreated);
                c.set('v.ErrorMsg',r.ErrorMsg);
            }else{
                if(r.invoiceId){
                    h.navigateToRecord(c,r.invoiceId,'detail');
                    $A.get("e.force:closeQuickAction").fire();
                }
            }
        }); 
        }catch(error){
            console.log('##Error : ',error);
                     }
    },
})