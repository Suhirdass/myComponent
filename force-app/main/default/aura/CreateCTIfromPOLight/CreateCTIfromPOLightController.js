({
    doInit : function(component, event, helper) {
        console.log("doInit");
		console.log(component.get("v.recordId"));
                helper.getData(component, event);

        //helper.getData(component, event);
	},
    
		createCTI : function(c, e, h) {
        h.request(c, 'createCTILight', {recordId: c.get("v.recordId")}, function(r){
            console.log('PO recordId = ',c.get("v.recordId"));
             //debugger;
               c.set('v.statusPOerror',r.statusPOerror);
            //c.set('v.invoiceId',r.invoiceId);
            c.set('v.setInvoice',r.setInvoice);
            console.log('Invoice ID = '+r.setInvoice);
            console.log(r.statusSO);
            
            if((c.get('v.statusPOerror') == 'Error1') )
            { 
                console.log('inside Error1') ;   
                h.navigateToRecord(c, c.get('v.recordId'));
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Warning',
                    message:'Please submit PO for Approval and try again to create Cultivation Tax Invoice.',
                    duration:' 5000',
                    key: 'info_alt',
                    type: 'Warning',
                    mode: 'pester'
                });
                toastEvent.fire();   
            
            } else if((c.get('v.statusPOerror') == 'Error2') )
      			{ 
                console.log('inside Error2') ;   
                h.navigateToRecord(c, c.get('v.recordId'));
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                title : 'Warning',
                message:'Cannot create Cultivation Tax Invoice on Cancelled PO.',
                duration:' 5000',
                key: 'info_alt',
                type: 'Warning',
                mode: 'pester'
            });
            toastEvent.fire();   
        	}
             else if((c.get('v.statusPOerror') == 'Error3') )
      			{ 
                console.log('inside Error3') ;   
                h.navigateToRecord(c, c.get('v.recordId'));
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                title : 'Warning',
                message:'CTI has already been created',
                duration:' 5000',
                key: 'info_alt',
                type: 'Warning',
                mode: 'pester'
            });
            toastEvent.fire();   
        	}  
            else {
                
                h.navigateToRecord(c, c.get('v.setInvoice'));
                console.log('Invoice ID in Success block = ',c.get('v.setInvoice'));
                var toastEvent = $A.get("e.force:showToast");
          			toastEvent.setParams({
                        title : 'Success!',
                        message : 'Cultivation Tax Invoice has been created',
                        duration:' 5000',
                        type: 'success'
                    });
                    toastEvent.fire();
            } 
        });
	},
     cancel : function(component, event, helper) {
		$A.get("e.force:closeQuickAction").fire();
	}
})