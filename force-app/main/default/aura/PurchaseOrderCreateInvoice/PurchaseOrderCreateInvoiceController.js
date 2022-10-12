({
	doInit : function(c, e, h) {
        
        h.request(c, 'getRecordName', { recordId: c.get('v.recordId') }, function (r) {
            c.set("v.recordName", r.name);
        });
	},
    
    cancel : function(component, event, helper) {
		$A.get("e.force:closeQuickAction").fire();
	},
    
    onCreateCTI : function(c, e, h) {
		c.set("v.isCreateCTI", true);
	},
    
    onCreateInvoice : function(c, e, h) {
		c.set("v.isServiceInvoice", true);
	},
    
    onCreateCTIRecord : function(c, event, helper) {
        helper.request(c, 'createCTI', { recordId: c.get('v.recordId') }, function (r) {
            c.set('v.setInvoice',r.setInvoice);
            c.set('v.statusPOerror',r.statusPOerror);
            console.log('Invoice ID = '+r);
            console.log('Invoice ID = '+r.setInvoice);
            
            if((c.get('v.statusPOerror') == 'Error1') ) { 
                console.log('inside Error1') ;   
                helper.navigateToRecord(c, c.get('v.recordId'));
                helper.warning({ message: 'Please submit PO for Approval and try again to create Cultivation Tax Invoice.' });            
            } else if((c.get('v.statusPOerror') == 'Error2') ){ 
                console.log('inside Error2') ;   
                helper.navigateToRecord(c, c.get('v.recordId'));
                helper.warning({ message: 'Cannot create Cultivation Tax Invoice on Cancelled PO.' });
        	} else if((c.get('v.statusPOerror') == 'Error3') ){ 
                console.log('inside Error3') ;   
                helper.navigateToRecord(c, c.get('v.recordId'));
                helper.warning({ message: 'CTI has already been created' });  
        	} else {                
                helper.navigateToRecord(c, c.get('v.setInvoice'));
                console.log('Invoice ID in Success block = ',c.get('v.setInvoice'));
                helper.success({ message: 'Cultivation Tax Invoice has been created' });
            }
        });
    },
    noOB : function(c, e, h) {
        c.set('v.isOBCreated',false);
        $A.get("e.force:closeQuickAction").fire();
    },
    yesOB :function(c, e, h) {
        console.log('##yesOB');
        h.request(c, 'createInvoice', {
            recordId: c.get('v.recordId'),isOBCreated :true
        }, function(r){
            console.log('##createInvoice : ',r,r.error );
            if(r.invoiceId != undefined && r.invoiceId != null && r.invoiceId != ''){
                c.set('v.isOBCreated',false);
                            var navEvt = $A.get("e.force:navigateToSObject");
                navEvt.setParams({
                  "recordId": r.invoiceId,
                  "slideDevName": "detail"
                });
                navEvt.fire();
            } else if(r.error != undefined && r.error != null && r.error != ''){
                h.error({ message: r.error });
                c.set('v.isOBCreated',false);
                $A.get("e.force:closeQuickAction").fire();
            }
        });
       
    },
    newInvoice : function(c, event, helper) {
        helper.request(c, 'createInvoice', { recordId: c.get('v.recordId'),isOBCreated : c.get('v.isOBCreated') }, function (r) {
            if(r.ErrorMsg != undefined && r.ErrorMsg != null && r.ErrorMsg != ''){
                c.set('v.ErrorMsg',r.ErrorMsg);
                c.set('v.isOBCreated',r.isOBCreated);
            }else{
                if(r.invoiceId != undefined && r.invoiceId != null && r.invoiceId != ''){
                            var navEvt = $A.get("e.force:navigateToSObject");
                navEvt.setParams({
                  "recordId": r.invoiceId,
                  "slideDevName": "detail"
                });
                navEvt.fire();
            } else if(r.error != undefined && r.error != null && r.error != ''){
                helper.error({ message: r.error });
            }
            }
            
        });
	},
})