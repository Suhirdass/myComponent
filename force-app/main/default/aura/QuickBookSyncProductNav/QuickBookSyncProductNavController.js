({
	doInit : function(c, e, h) {
   h.request(c, 'checkRecordsActive', {recordId: c.get('v.recordId')}, function(r){
        c.set('v.messages', r.messageactive);
       console.log('v.messages',r.messageactive)
});
       // helper.getData(component, event);
      //  component.set('v.message', 'Cancel Sales Order. Are you sure?');   
	},
    cancelSO : function(component, event, helper) {
		//helper.cancelSalesOrder(component, event);
	},
    cancel : function(component, event, helper) {
		$A.get("e.force:closeQuickAction").fire();
	},
     CreateProduct : function(c, e, h) {
		console.log(c.get("v.recordId"));
         h.request(c, 'SyncProductsWithQuickBooks', {recordId: c.get('v.recordId')}, function(r){
        c.set('v.status', r.message);
              var dismissActionPanel = $A.get("e.force:closeQuickAction"); 
                dismissActionPanel.fire();
             
            if(r.message =='Inactive'){
                              var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Error',
                        message: 'Product in inactive state in QB',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'Error',
                        mode: 'pester'
                    });
                    toastEvent.fire();    
                 
                 
            }else if(r.message =='Inactiveprice'){
               var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Error',
                        message: 'Standard Price Book is InActive State',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'Error',
                        mode: 'pester'
                    });
                    toastEvent.fire();   
                
                
            }else{
                
    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Success',
                        message: 'Product created successfully',
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