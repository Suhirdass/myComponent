({
    doInit : function(c, e, h) {
        
       //alert('11');
        h.request(c, 'departConfirmlt', {recordId: c.get('v.recordId')}, function(r){
            
            var dismissActionPanel = $A.get("e.force:closeQuickAction"); 
            dismissActionPanel.fire();
            var message = r.messagelightning;
            c.set('v.messagelightning',r.messagelightning);
            if(message){
                var dismissActionPanel = $A.get("e.force:closeQuickAction"); 
                dismissActionPanel.fire();
                h.error({ message:r.messagelightning });    
            }else {
                h.success({ message:'Depart confirmed successfully.' });    
            }
            $A.get('e.force:refreshView').fire();  
            
        });  
        
    }
    
})