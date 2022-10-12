({
    doInit : function(c, e, h) {
        h.request(c, 'getRecordName', {recordId: c.get("v.recordId")}, function(r){
            console.log('RES = ',r);
            c.set('v.recordName', r.recordName);
            c.set('v.status', r.status);
            c.set('v.recordTypeName', r.recordTypeName);
            c.set('v.hasFactoringDetails',r.hasFactoringDetails);
        });
    },
    cancel : function(c, e, h) {
        $A.get("e.force:closeQuickAction").fire();	
    },
    onCreateInvoicePO : function(c, e, h) {
        if(c.get('v.status') != 'Approved' && c.get('v.status') != 'Shipped'){
            h.error({ message: ('Please submit Brand Quote for Approval and try again to create Purchase Order.') });        
            $A.get("e.force:closeQuickAction").fire();	
        } else {
            h.request(c, 'createInvoicePO', {recordId: c.get("v.recordId")}, function(r){
                console.log('createInvoicePO:',r);
                if(r.Error){
                    h.error({ message: r.Error});        
                }else if(r.Warning){
                    h.error({ message: r.Warning });        
                }else{
                    h.navigateToRecord(c, r.recordIds,'detail')
                }
            });
        }
    },
    onCreateFactoringPO : function(c, e, h) {
        if(c.get('v.status') != 'Approved' && c.get('v.status') != 'Shipped'){
            h.error({ message: ('Please submit Brand Quote for Approval and try again to create Purchase Order.') });        
            $A.get("e.force:closeQuickAction").fire();	
        }else if(c.get('v.hasFactoringDetails') == false){
            h.error({ message: ('You cannot create Factoring PO if Factoring Assignee and Factoring Rate is blank.') });        
            $A.get("e.force:closeQuickAction").fire();	
        } else {
            h.request(c, 'createFactoringPO', {recordId: c.get("v.recordId")}, function(r){
                console.log('createFactoringPO:',r);
                if(r.Error){
                    h.error({ message: r.Error });        
                }else if(r.Warning){
                    h.error({ message: r.Warning });        
                }else{   
                    h.navigateToRecord(c, r.recordIds,'detail')
                }             
            });
        }        
    },
    onCreateProductPO : function(c, e, h) {
        
        if(c.get('v.status') != 'Approved' && c.get('v.status') != 'Shipped'){
            h.error({ message: ('Please submit Brand Quote for Approval and try again to create Purchase Order.') });        
            $A.get("e.force:closeQuickAction").fire();	
        } else {
            var evt = $A.get("e.force:navigateToComponent");
            evt.setParams({
                componentDef : "c:BrandQuoteCreatePO",
                componentAttributes: {
                    recordId : c.get("v.recordId")
                }
            });
            evt.fire();  
            

        }
    },
    
})