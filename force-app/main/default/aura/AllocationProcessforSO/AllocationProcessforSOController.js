({
   cancel : function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
    },
    
    allocationProcess : function(component, event, helper) {
        helper.request(component, 'AllocationProcessLight', {soid: component.get('v.recordId')}, function(r){
            var dismissActionPanel = $A.get("e.force:closeQuickAction"); 
            dismissActionPanel.fire();
            	component.set('v.message',r.message);
            if(r.message){
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Error',
                    message: component.get('v.message'),
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
                        message: 'Sales Order allocated successfully',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'Success',
                        mode: 'pester'
                    });
                    toastEvent.fire();
            }
                

            $A.get('e.force:refreshView').fire();  
        }); 
        
    }
})