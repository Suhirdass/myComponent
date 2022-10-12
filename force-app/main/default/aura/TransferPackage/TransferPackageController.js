({
	synConfirm : function(component, event, helper) {
        console.log('recordid', component.get("v.recordId"));
		 helper.request(component, 'TransferShipmanifest', {recordId: component.get("v.recordId")}, function(r){
             var dismissActionPanel = $A.get("e.force:closeQuickAction"); 
                dismissActionPanel.fire();
             if( r.errorMessage){
                 helper.error({ message: r.errorMessage });
             }
              $A.get('e.force:refreshView').fire(); 
        });
 
	},
    cancel : function(component, event, helper){
          var dismissActionPanel = $A.get("e.force:closeQuickAction"); 
                dismissActionPanel.fire();
    },
    getData : function(component, event,helper) {
        helper.request(component, 'getRecordName', {recordId: component.get("v.recordId")}, function(r){
            component.set("v.recordName", r.name);
              
        });
    }
})