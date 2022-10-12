({

    doInit: function(c, e, h){
        h.request(c, 'checkPicklistExist', {recordId: c.get('v.recordId')}, function(r){
        	let isPicklistExist = r.isPicklistExist;
            if(isPicklistExist){
                let dismissActionPanel = $A.get("e.force:closeQuickAction"); 
                dismissActionPanel.fire();
                h.error({ message: 'Picklist record already exist.',}); 
            } else {
                let reverseAllocate = c.get('c.reverseAllocate');
                $A.enqueueAction(reverseAllocate);
            }
        });
    },
    cancel : function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
    },
    
    reverseAllocate : function(c, e, h) {
        h.request(c, 'updateSOLinesAndInventoryPositionslight', {recordId: c.get('v.recordId')}, function(r){
            var dismissActionPanel = $A.get("e.force:closeQuickAction"); 
            dismissActionPanel.fire();
            var message = r.messagelightning;
            c.set('v.messagelightning',r.messagelightning);
            if(message){
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Error',
                    message: c.get('v.messagelightning'),
                    duration:'5000',
                    key: 'info_alt',
                    type: 'Error',
                    mode: 'pester'
                });
                toastEvent.fire();
            }
            else{
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Success',
                    message: 'Reverse Allocate done successfully',
                    duration:'5000',
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