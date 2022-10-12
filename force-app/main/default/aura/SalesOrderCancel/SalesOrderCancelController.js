({
	doInit : function(component, event, helper) {
        helper.getData(component, event);
        component.set('v.message', 'Cancel Sales Order. Are you sure?');   
	},
    cancelSO : function(component, event, helper) {
		helper.cancelSalesOrder(component, event);
	},
    cancel : function(component, event, helper) {
		$A.get("e.force:closeQuickAction").fire();
	},
     CancelSOLight : function(c, e, h) {
		console.log(c.get("v.recordId"));
         h.request(c, 'CancelSorder', {recordId: c.get('v.recordId'), isConfirmed: c.get('v.isConfirmed')}, function(r){
            c.set('v.status',r.status);

             if(r.message =='Picklist of SO is already Ship Confimed. If you still need to Cancel SO, Please click Yes'){
                 c.set('v.message', r.message);
                 c.set('v.isConfirmed', 'true');
                 
             }else if(r.message){
                 var dismissActionPanel = $A.get("e.force:closeQuickAction"); 
                dismissActionPanel.fire();
                 var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Error',
                        message: r.message,
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'Error',
                        mode: 'pester'
                    });
                    toastEvent.fire();
             }else{
                 var dismissActionPanel = $A.get("e.force:closeQuickAction"); 
                dismissActionPanel.fire();
                 var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Success',
                        message: 'Sales Order cancelled successfully',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'Success',
                        mode: 'pester'
                    });
                    toastEvent.fire();
                 
             }
			 $A.get('e.force:refreshView').fire();  
            
              });    
    },
         
             
})