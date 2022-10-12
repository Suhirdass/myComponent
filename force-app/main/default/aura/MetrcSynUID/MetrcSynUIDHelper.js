({
	synUidData : function(component, event, helper){
         
        var action = component.get("c.synData");
        action.setParams({
            'recordId' : component.get("v.recordId")
        });
        
        action.setCallback(this,function(response) {
           var state = response.getState();
            var result =  response.getReturnValue();
            if (state === "SUCCESS") {
                var dismissActionPanel = $A.get("e.force:closeQuickAction"); 
                dismissActionPanel.fire();
                if(result ==='NOT FOUND'){
                    var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Error!",
                    "message": "404: UID is not found.",
                     "type" : "error"
                });
                toastEvent.fire();
                }else{
                    var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "message": "Data Synchronized successfully.",
                     "type" : "success"
                });
                toastEvent.fire();
                }
                
            } 
            $A.get('e.force:refreshView').fire();
        });
        $A.enqueueAction(action);
    },
})