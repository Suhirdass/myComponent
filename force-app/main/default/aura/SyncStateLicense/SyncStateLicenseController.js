({
	synConfirm : function(component, event, helper) {
		 helper.request(component, 'SyncStateLicenseDCA', {recordId: component.get("v.recordId")}, function(r){
             var dismissActionPanel = $A.get("e.force:closeQuickAction"); 
                dismissActionPanel.fire();
             if(r.responseMessage=="SUCCESS"){
                 helper.success({ message: 'Successfully updated' });
             }
             if(r.responseMessage!="SUCCESS"){
                 helper.error({ message: r.responseMessage });
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