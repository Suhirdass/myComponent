({
	navigate : function(c, e, h) {
        
     
        var errormsg ='';
        h.request(c, 'getSmLines', {recordId: c.get("v.recordId")}, function(r){
            
        	c.set('v.setSM', r.setSM);
        	if(r.setSM.Status__c=='Cancelled'){
        		errormsg='Shipping Manifest status is already Canelled';
        	}else if(r.setSM.Status__c=='Rejected'){
        		errormsg='Shipping Manifest status is already Rejected';
        	}else if(r.setSM.Status__c=='Shipment Complete'){
        		errormsg='Shipping Manifest status is already Shipment Complete';
        	}else if(r.setSM.Status__c =='Draft' ||  r.setSM.Status__c =='Shipment Pending' ){
        		errormsg='Please complete Depart Confirm and try again to Ship Confirm';
        	}else if(r.setSM.Driver__c== null ){
        		errormsg='Please Select Driver.';
        	}
            else if( r.setSM.Vehicle__c==null ){
        		errormsg='Please Select Vehicle.';
            }else{
                var evt = $A.get("e.force:navigateToComponent");
                evt.setParams({
                    componentDef : "c:shipConfirmConsoleInternal",
                    componentAttributes: {
                        recordId : c.get("v.recordId")
                    }
                });
                evt.fire();
        
            }
            if(errormsg){
                var dismissActionPanel = $A.get("e.force:closeQuickAction"); 
                dismissActionPanel.fire();
                h.error({ message:errormsg });
            }
                  
    	});
    }
        
})