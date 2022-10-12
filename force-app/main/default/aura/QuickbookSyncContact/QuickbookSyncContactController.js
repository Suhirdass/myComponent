({
	 CreateCustomer : function(c, e, h) {
		console.log(c.get("v.recordId"));
         h.request(c, 'SyncAccountWithQuickBooksContact', {recordId: c.get('v.recordId')}, function(r){
             c.set('v.ACCCheck', r.NullQBIds);
             c.set('v.status', r.message);
             // c.set('v.ConCheck', r.ExistingCon);
             if(r.NullQBIds ==false){
                   var dismissActionPanel = $A.get("e.force:closeQuickAction"); 
                dismissActionPanel.fire();
                 var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Error',
                        message: 'Respective account does not exist in QB',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'Error',
                        mode: 'pester'
                    });
                    toastEvent.fire();
                 
             }  else if(r.message =='values missing in Salutation,FirstName,Email'){
                   var dismissActionPanel = $A.get("e.force:closeQuickAction"); 
                dismissActionPanel.fire();
                 var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Error',
                        message: 'Please check this fileds values are filled Salutation,FirstName,Email',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'Error',
                        mode: 'pester'
                    });
                    toastEvent.fire();
             }
               /*  else if(r.ExistingCon ==True){
                 var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Error',
                        message: 'account has contact details alredy',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'Error',
                        mode: 'pester'
                    });
                    toastEvent.fire();
             }*/
            else{
                  var dismissActionPanel = $A.get("e.force:closeQuickAction"); 
                dismissActionPanel.fire();
    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Success',
                        message: 'Contact created successfully.',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'Success',
                        mode: 'pester'
                    });
                    toastEvent.fire();                 
                
                
                
                
            }

             
              });
          $A.get('e.force:refreshView').fire();  
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