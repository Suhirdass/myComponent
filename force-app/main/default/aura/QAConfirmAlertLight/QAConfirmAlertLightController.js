({
	    qaConfirms  : function(c, e,h) {
            c.set('v.isDisableYesBtn',true);
            h.request(c,'QAConfirm', {recordId: c.get("v.recordId")}, function(r){
                c.set('v.statusBQ',r.statusBQ);
                c.set('v.statuspick',r.statuspick);
                c.set('v.errorMsg',r.errorMsg);
                c.set('v.rsmId',r.rsmId);
                   c.set('v.errormsguid',r.errormsguid);
                 c.set('v.errormsgSite',r.errormsgSite);
                console.log(r.errormsguid);
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
                 if (c.get('v.errormsguid')){
                    h.navigateToRecord(c, c.get('v.recordId'));
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Warning',
                        message:c.get('v.errormsguid'),
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'Warning',
                        mode: 'pester'
                    });
                    toastEvent.fire();
                
			}  
                if (c.get('v.errorMsg')){
                    h.navigateToRecord(c, c.get('v.recordId'));
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Error',
                        message:c.get('v.errorMsg'),
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'Error',
                        mode: 'pester'
                    });
                    toastEvent.fire();
                
			}  
                
                if((c.get('v.statusBQ') =='QA Confirm') )
                {
                    h.navigateToRecord(c, c.get('v.recordId'));
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Warning',
                        message:'This picklist is already in QA Confirm status',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'Warning',
                        mode: 'pester'
                    });
                    toastEvent.fire();   
                } 
                
                if((c.get('v.statuspick') == 'QA Confirm') )
                {
                    h.navigateToRecord(c, c.get('v.rsmId'));
                }
                
            })
            
        },
     cancel : function(c, e, h) {
        h.navigateToRecord(c, c.get('v.recordId'));
    },
    
})