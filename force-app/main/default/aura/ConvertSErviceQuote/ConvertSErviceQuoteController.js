({
    doInit : function(c, e, h) {
        h.request(c,'convertServiceQuote', {recordId: c.get("v.recordId")}, function(r){
            
            c.set('v.BQsService', r.BQsService);
            c.set('v.data', r.data);
            c.set('v.exc', r.Exceptionmessage);
            
            c.set('v.stlSEobj', r.stlSEobj);
            
            if((c.get('v.exc') != null))
            {
                h.navigateToRecord(c, c.get('v.recordId'));
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Error',
                    message:r.Exceptionmessage,
                    duration:' 5000',
                    key: 'info_alt',
                    type: 'error',
                    mode: 'pester'
                });
                toastEvent.fire();   
            }     
            if((c.get('v.BQsService') >= 1))
            {
                h.navigateToRecord(c, c.get('v.recordId'));
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Error',
                    message:'Already Converted Service Ticket Line',
                    duration:' 5000',
                    key: 'info_alt',
                    type: 'error',
                    mode: 'pester'
                });
                toastEvent.fire();   
            }     
        
            if((c.get('v.stlSEobj') != undefined) )
            {
                h.navigateToRecord(c, c.get('v.recordId'));
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Success',
                    message: 'Service Ticket Line converted successfully',
                    duration:' 5000',
                    key: 'info_alt',
                    type: 'success',
                    mode: 'pester'
                });
                toastEvent.fire();   
            } 
            
        });
    },
    
    
})