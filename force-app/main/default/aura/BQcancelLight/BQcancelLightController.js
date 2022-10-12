({
   doInit : function(c, e, h) {
        h.getData(c, e);
    },

cancelBQ : function(c, e, h) {
	h.request(c, 'cancelBQLight', {recordId: c.get("v.recordId")}, function(r){
        c.set('v.BQerror',r.BQerror);
        
      
         if((c.get('v.BQerror') == 'Error1') )
            {    
                h.navigateToRecord(c, c.get('v.recordId'));
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Warning',
                    message:'Brand Quote already in cancelled status.',
                    duration:' 5000',
                    key: 'info_alt',
                    type: 'Warning',
                    mode: 'pester'
                });
                toastEvent.fire();   
            
            } else if((c.get('v.BQerror') == 'Error2') )
      			{ 
                console.log('inside Error2') ;   
                h.navigateToRecord(c, c.get('v.recordId'));
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                title : 'Warning',
                message:'Brand Quote can be cancelled only for open Sales Order.',
                duration:' 5000',
                key: 'info_alt',
                type: 'Warning',
                mode: 'pester'
            });
            toastEvent.fire();   
        	}
             else if((c.get('v.BQerror') == 'Error3') )
      			{ 
                console.log('inside Error3') ;   
                h.navigateToRecord(c, c.get('v.recordId'));
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                title : 'Warning',
                message:'Brand Quote can be cancelled only for open Purchase Order.',
                duration:' 5000',
                key: 'info_alt',
                type: 'Warning',
                mode: 'pester'
            });
            toastEvent.fire();   
        	}  
         else if((c.get('v.BQerror') == 'Error4') )
      			{ 
                console.log('inside Error3') ;   
                h.navigateToRecord(c, c.get('v.recordId'));
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                title : 'Error',
                message:'Sales order created. Cannot cancel '+c.get('v.recordName'),
                duration:' 5000',
                key: 'info_alt',
                type: 'Error',
                mode: 'pester'
            });
            toastEvent.fire();   
        	} 
             else if((c.get('v.BQerror') == 'Error5') )
             { 
                 console.log('inside Error3') ;   
                 h.navigateToRecord(c, c.get('v.recordId'));
                 var toastEvent = $A.get("e.force:showToast");
                 toastEvent.setParams({
                     title : 'Error',
                     message:'Purchase Order created. Cannot cancel '+c.get('v.recordName'),
                     duration:' 5000',
                     key: 'info_alt',
                     type: 'Error',
                     mode: 'pester'
                 });
                 toastEvent.fire();   
             } 
            else {
                
                h.navigateToRecord(c, c.get('v.recordId'));
                var toastEvent = $A.get("e.force:showToast");
          			toastEvent.setParams({
                        title : 'Success!',
                        message : 'Brand Quote has been cancelled',
                        duration:' 5000',
                        type: 'success'
                    });
                    toastEvent.fire();
            } 
        
      });
	},
    cancel : function(component, event, helper) {
		$A.get("e.force:closeQuickAction").fire();
	}
})