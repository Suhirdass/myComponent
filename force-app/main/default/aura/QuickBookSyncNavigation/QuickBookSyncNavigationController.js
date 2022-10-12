({
	doInit : function(component, event, helper) {
       // helper.getData(component, event);
      //  component.set('v.message', 'Cancel Sales Order. Are you sure?');   
	},
    cancelSO : function(component, event, helper) {
		//helper.cancelSalesOrder(component, event);
	},
    cancel : function(component, event, helper) {
		$A.get("e.force:closeQuickAction").fire();
	},
     CreateCustomer : function(c, e, h) {
		console.log(c.get("v.recordId"));
         h.request(c, 'SyncAccountWithQuickBooksCutomer', {recordId: c.get('v.recordId')}, function(r){
             c.set('v.status', r.message);
             if(r.message =='Missing Billing Address'){
                 var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Error',
                        message: 'Please check the Billing Address details',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'Error',
                        mode: 'pester'
                    });
                    toastEvent.fire();
                 $A.get("e.force:closeQuickAction").fire();
             }else if(r.message =='Inactive'){
                              var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Error',
                        message: 'Customer is in Inactive state',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'Error',
                        mode: 'pester'
                    });
                    toastEvent.fire();    
                 $A.get("e.force:closeQuickAction").fire();
                 
             }
             
             else{
                 //console.log(r.status);
              var dismissActionPanel = $A.get("e.force:closeQuickAction"); 
                dismissActionPanel.fire();
                 var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Success',
                        message: 'Customer Created successfully',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'Success',
                        mode: 'pester'
                    });
                    toastEvent.fire(); 
                 $A.get("e.force:closeQuickAction").fire();
             }
            
             
              });
          $A.get('e.force:refreshView').fire();  
    },
    CreateVendor : function(c, e, h) {
		console.log(c.get("v.recordId"));
         h.request(c, 'SyncAccountWithQuickBooksVendor', {recordId: c.get('v.recordId')}, function(r){
             c.set('v.status', r.message);
             if(r.message =='Missing Billing Address'){
             
                 var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Error',
                        message: 'Please check the Billing Address details',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'Error',
                        mode: 'pester'
                    });
                    toastEvent.fire();
                 
             }else if(r.message =='Inactive'){
                              var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Error',
                        message: 'Vendor is in Inactive state',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'Error',
                        mode: 'pester'
                    });
                    toastEvent.fire();    
                 
                 
             }else{
                 //console.log(r.status);
             var dismissActionPanel = $A.get("e.force:closeQuickAction"); 
                dismissActionPanel.fire();
                 var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Success',
                        message: 'Vendor Created successfully',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'Success',
                        mode: 'pester'
                    });
                    toastEvent.fire();
            
             }
            
              });
          $A.get('e.force:refreshView').fire();  
    },
              
             
})