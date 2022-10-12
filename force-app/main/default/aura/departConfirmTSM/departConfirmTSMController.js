({
    doInit : function(c, e, h) {
        
       
        h.request(c, 'DepartConfirmTSMControllertsmlt', {recordId: c.get('v.recordId')}, function(r){
            
            var dismissActionPanel = $A.get("e.force:closeQuickAction"); 
            dismissActionPanel.fire();
            var message = r.messagelightning;
             var messagevalidatelite = r.validatelite;
            c.set('v.messagelightning',r.messagelightning);
             if(messagevalidatelite)
            {
                  var dismissActionPanel = $A.get("e.force:closeQuickAction"); 
                dismissActionPanel.fire();
                   h.error({ message:r.validatelite });  
            }
            else if(message){
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