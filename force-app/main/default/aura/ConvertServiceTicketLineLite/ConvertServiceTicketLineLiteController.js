({
    doInit : function(c, e, h) {
        h.request(c,'createBuyQuote', {recordId: c.get("v.recordId")}, function(r){
            c.set('v.stlobjfalse', r.stlobjfalse);
            c.set('v.statusBQ',r.statusBQ);
            console.log(status);
            console.log(r.statusBQ);
            c.set('v.stlobj',r.stlobj);
            console.log(r.stlobj);
            c.set('v.BQs', r.BQs);
            console.log(r.BQs);
            
            if((c.get('v.BQs') >= 1))
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
           
            if((c.get('v.statusBQ') == false) )
            {
                h.navigateToRecord(c, c.get('v.recordId'));
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Error',
                    message:'To Create Buy Quote Transfer of Custudy must be selected  ',
                    duration:' 5000',
                    key: 'info_alt',
                    type: 'error',
                    mode: 'pester'
                });
                toastEvent.fire();   
            }      
            
            if((c.get('v.stlobj') !=undefined) )
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