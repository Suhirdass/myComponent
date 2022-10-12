({
  init : function(component, event, helper) {
      
      var action = component.get("c.updatePLPickStart");
          action.setParams({
            recordId : component.get("v.recordId")  
        });
      // set call back 
        action.setCallback(this, function(response) {
            
            var state = response.getState();
            
            if (state === "SUCCESS") {
               var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Success',
                    message: 'Start Picking successfully.',
                    duration:' 5000',
                    key: 'info_alt',
                    type: 'Success',
                    mode: 'pester'
                });
                toastEvent.fire();
                $A.get("e.force:closeQuickAction").fire() ;
                $A.get('e.force:refreshView').fire();
            }
             else if (state === "INCOMPLETE") {
                console.log("From server: " ,response.getReturnValue());
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        // enqueue the action
        $A.enqueueAction(action);
      
   }
})