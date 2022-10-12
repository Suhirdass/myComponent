({
    doInit : function(c, e, h) {
        h.request(c, 'getRecordName', {recordId: c.get("v.recordId")}, function(r){
            c.set('v.status', r.status);
            c.set('v.recordName', r.name);
            if(c.get('v.status') == 'QA Review' || c.get('v.status') == 'Open'){
                if(c.get('v.status') == 'Open'){
                   c.set('v.isOpenStatus',true); 
                } else {
                    c.set('v.isQAReview',true);
                }
            } else {
                h.warning({ message: ('Only QA Review and Open status records are allowed for cancellation') }); 
                $A.get("e.force:closeQuickAction").fire();	
            }
        });
    },
    cancelOrderPickList : function(c, e, h){
        try{
            h.request(c, 'cancelOrder', {PLId: c.get("v.recordId")}, function(r){
                
                //window.parent.location = '/' + r.soID;
                    $A.get("e.force:closeQuickAction").fire();
                    setTimeout(
                        $A.getCallback(function() {
                            window.location.reload();
                        }), 2000
                    );
                	
            });
        }catch(error){
            console.log(error);
        }
        
    },
    /*calcelPicklist : function(c, e, h) {
        let evt = $A.get("e.force:navigateToComponent");
        evt.setParams({
            componentDef : "c:cancelledPickListLine",
            componentAttributes: {
                recordId : c.get("v.recordId")
            }
        });
        evt.fire();
    },*/
    
    deletePicklist : function(c, e, h) {
        h.request(c, 'deletePicklistAndLines', {recId: c.get("v.recordId")}, function(r){
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
                
   }  else{
              h.success({message: 'Picklist and picklist lines have been deleted.'});
       window.parent.location = '/' + r.soID;
     
   }
            
        });
    },
    
    calcelPicklistAndSOLines : function(c, e, h) {
        h.request(c, 'deletePicklistAndUpdateSO', {recId: c.get("v.recordId")}, function(r){
            //h.navigateToRecord(c, r.soID);
            window.parent.location = '/' + r.soID;
        });
    },
    
    closeModelBox: function(c, e, h) {
        c.set('v.isOpenStatus', false);
        c.set('v.isQAReview', false);
        $A.get("e.force:closeQuickAction").fire();
    }
})