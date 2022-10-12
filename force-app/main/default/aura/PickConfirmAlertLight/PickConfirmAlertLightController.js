({
    
	cancel : function(component, event, helper) {
		$A.get("e.force:closeQuickAction").fire();
	},
    pickConfirms  : function(c, e,h) {
         h.request(c,'pickConfirm', {recordId: c.get("v.recordId")}, function(r){
             c.set('v.statusBQ',r.statusBQ);
             c.set('v.statuspick',r.statuspick);
             c.set('v.errorMsg',r.errorMsg);
                              c.set('v.errormsgSite',r.errormsgSite);
   if (c.get('v.errormsgSite')){
                    h.navigateToRecord(c, c.get('v.recordId'));
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Warning',
                        message:c.get('v.errormsgSite'),
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'Warning',
                        mode: 'pester'
                    });
                    toastEvent.fire();
                
			}  
             if((c.get('v.statusBQ') == 'QA Review') )
             {
                 var message = "This picklist is already in QA Review status";
                 var title = "Warning";
                 var type =  "Warning";
             }else if ((c.get('v.statusBQ') == 'QA Confirm') )
             {
                 var message = "This picklist is already in QA Confirm status";
                 var title = "Warning";
                 var type =  "Warning";
             }else if (c.get('v.errorMsg')){
                 var message = c.get('v.errorMsg');	
                 var title = "Error";
                 var type =  "Error";
			}
             
             h.navigateToRecord(c, c.get('v.recordId'));
             var toastEvent = $A.get("e.force:showToast");
             toastEvent.setParams({
                 title : title,
                 message:message,
                 duration:' 5000',
                 key: 'info_alt',
                 type: type,
                 mode: 'pester'
             });
             toastEvent.fire(); 
             
             if((c.get('v.statusBQ') != 'QA Review') && (c.get('v.statusBQ') == 'QA Confirm') )
             {
               ;   
                 h.navigateToRecord(c, c.get('v.recordId'));
                 
             }
             if((c.get('v.statuspick') == 'QA Review') )
             {
              
                 h.navigateToRecord(c, c.get('v.recordId'));
                 
             }
             $A.get('e.force:refreshView').fire();
             })
    
	},
    
        
    
})