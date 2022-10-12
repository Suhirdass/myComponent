({
    doInit : function(c, e, h) {
        h.request(c,'convertServiceTickets', {recordId: c.get("v.recordId")}, function(r){
            
            c.set('v.Opp', r.Opp);
            console.log(r.Opp);
            
            c.set('v.newOpps',r.newOpps);
            console.log(r.newOpps);
            
            if((c.get('v.Opp') != null))
            {
                h.navigateToRecord(c, c.get('v.recordId'));
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Error',
                    message:'Service Ticket is already converted to Opportunity',
                    duration:' 5000',
                    key: 'info_alt',
                    type: 'error',
                    mode: 'pester'
                });
                toastEvent.fire();   
            }  
            
            
            if((c.get('v.newOpps') != null))
            {
                h.navigateToRecord(c, c.get('v.recordId'));
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Success',
                    message: 'Service Ticket Line converted successfully',
                    duration:' 5000',
                    key: 'info_alt',
                    type: 'Success',
                    mode: 'pester'
                });
                toastEvent.fire();   
            }     
            
            
        });
    }
    
    
    
    
})