({
	 CreateInvoice : function(c, e, h) {
		console.log(c.get("v.recordId"));
         h.request(c, 'SyncInvoiceWithQuickBooks', {recordId: c.get('v.recordId')}, function(r){
              var dismissActionPanel = $A.get("e.force:closeQuickAction"); 
                dismissActionPanel.fire();
           c.set('v.status', r.message);
             console.log('///',r.update);
             if(r.product !=null){
              var dismissActionPanel = $A.get("e.force:closeQuickAction"); 
                dismissActionPanel.fire();
                  
                 var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Error',
                        message: r.product,
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'Error',
                        mode: 'pester'
                    });
                    toastEvent.fire();   
             }
          else  if(r.DuplicateInvoice !=null){
              var dismissActionPanel = $A.get("e.force:closeQuickAction"); 
                dismissActionPanel.fire();
                  
                 var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Error',
                        message: r.DuplicateInvoice,
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'Error',
                        mode: 'pester'
                    });
                    toastEvent.fire();   
             }else  if(r.Update !=null){
                   var dismissActionPanel = $A.get("e.force:closeQuickAction"); 
                dismissActionPanel.fire();
                  
                 var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Success',
                        message: r.Update,
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'Success',
                        mode: 'pester'
                    });
                    toastEvent.fire();
              }else  if(r.validation !=null){
                   var dismissActionPanel = $A.get("e.force:closeQuickAction"); 
                dismissActionPanel.fire();
                  
                 var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Error',
                        message: r.validation,
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'Error',
                        mode: 'pester'
                    });
                    toastEvent.fire();
              }
            else  if(r.message =='error'){
                   var dismissActionPanel = $A.get("e.force:closeQuickAction"); 
                dismissActionPanel.fire();
                  
                 var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Error',
                        message: 'sync Receiver to Quickbook',
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
                        message: 'invoice sync successfully done.',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'Success',
                        mode: 'pester'
                    });
                    toastEvent.fire();                 
                 } 
              });
        //  $A.get('e.force:refreshView').fire();  
    },
    cancel : function(component, event, helper) {
		$A.get("e.force:closeQuickAction").fire();
	},
    doInit : function(c, e, h) {
   h.request(c, 'checkRecordsContact', {recordId: c.get('v.recordId')}, function(r){
      
       if(r.messageactive == true)
       {
          c.set('v.messexist', 'Contact already exists in QB. Do you want to overwrite?');  
       }else{
          c.set('v.messexist', 'Do you want to sync the contact in QB?');  
       }
       console.log('v.messages',r.messageactive)
});
       // helper.getData(component, event);
      //  component.set('v.message', 'Cancel Sales Order. Are you sure?');   
	},
})