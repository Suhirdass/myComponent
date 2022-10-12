({
	CreateCA : function(c, e, h) {
		console.log(c.get("v.recordId"));
         h.request(c, 'syncChartOfAccountWithQuickBooks', {recordId: c.get('v.recordId')}, function(r){
        c.set('v.status',r.status);
             console.log(r.status);
              var dismissActionPanel = $A.get("e.force:closeQuickAction"); 
                dismissActionPanel.fire();
                 var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Success',
                        message: 'ChartOfAccount Created successfully',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'Success',
                        mode: 'pester'
                    });
                    toastEvent.fire();
        
              });
          $A.get('e.force:refreshView').fire();  
    },
    cancel : function(component, event, helper) {
		$A.get("e.force:closeQuickAction").fire();
	},
})