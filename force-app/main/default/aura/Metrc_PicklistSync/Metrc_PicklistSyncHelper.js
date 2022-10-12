({
    checkUserMetrcAcsess : function(component, event, helper){
         console.log('------checkAcsess-----'+component.get("v.sObjectName"));
        var action = component.get("c.checkUserMetrcAcsess");
        action.setParams({
            'recID' : component.get("v.recordId")
        });
        action.setCallback(this,function(response) {
            var state = response.getState();
            var result =  response.getReturnValue();
            if (state === "SUCCESS") {
                if(result === true){
                    component.set('v.showDataSyncModal', true);
                }
                else{
                    component.set('v.showError', true);
                }
            } 
            else {
                var Error =response.getError();
                var ErrorMsg=Error[0].message;
                helper.showToast("",'ERROR',ErrorMsg , "Error",20000); 
            } 
        });
        $A.enqueueAction(action);
    },
    syncDataToMetrcHelper : function(component, event, helper){
         console.log('------syncDataToMetrcHelper-enter----');
        var action = component.get("c.syncDataToMetrcNew");
        action.setParams({
            'picklistID' : component.get("v.recordId"),
            'objName' : component.get("v.sObjectName"),
        });
        action.setCallback(this,function(response) {
               console.log('------syncDataToMetrcHelper-setCallback----');
            var state = response.getState();
            var result =  response.getReturnValue();
            var  varTyep = "success";
            if (state === "SUCCESS") {
                 console.log('---------result--'+result);
                
                var dismissActionPanel = $A.get("e.force:closeQuickAction"); 
                dismissActionPanel.fire();
                var sObectEvent = $A.get("e.force:navigateToSObject");
                sObectEvent .setParams({
                    "recordId": component.get("v.recordId"),
                    "slideDevName": "detail"
                });
                sObectEvent.fire();
                if(result.indexOf('Error') > -1){ varTyep= "error";}
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title" :"Sync Metrc Data",
                    "type": varTyep,
                    "message": result,
                    "mode": "sticky"
                });
                toastEvent.fire(); 
            
            } 
            else {
                console.log('------setCallback---failure--'+result);
            } 
        });
        $A.enqueueAction(action);
    },
    cancelModal : function(component, event, helper){
          var dismissActionPanel = $A.get("e.force:closeQuickAction"); 
                dismissActionPanel.fire();
    }
})