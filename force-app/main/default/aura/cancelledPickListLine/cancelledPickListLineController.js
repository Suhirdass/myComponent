({
    doInit : function(c, e, h) {
        h.request(c, 'getPickListLineItems', {recId: c.get("v.recordId")}, function(r){
            c.set('v.pickLines',r.records);	
            c.set('v.picRecord',r.picRecords);
            c.set('v.hasServiceInvoice',r.hasServiceInvoice);
            console.log('r.records',r.records);
            var recCheck = c.get("v.pickLines");
            var count = 0 ;
            for(var i=0; i<recCheck.length; i++){
                if((recCheck[i].wrp.picklistLineObj.Status__c) == 'Cancelled'){
                    count++;   
                }
            }
            if(count == recCheck.length){
                c.set('v.masterDisabled',true);    
            }
        });
    },
    
    selectAllCheckboxes : function(c, e, h) {
        var checkvalue = c.find("selectAll").get("v.value");
        var checkRec = c.find("checkRec"); 
        console.log('Hello',checkRec);
        if(checkRec.length){
            for(var i=0; i<checkRec.length; i++){
                checkRec[i].set("v.value",checkvalue);
            } 
        } else{
            checkRec.set("v.value",checkvalue);    
        }
        
    },
    
    onCancel : function(c, e, h) {
        try{
            h.navigateToRecord(c, c.get('v.recordId'));
        } catch(ex){
            console.log(ex);
        }
        $A.get('e.force:refreshView').fire();
    },
    closeModel: function(component, event, helper) {
        component.set("v.isOpen", false);
        component.set("v.isShowButtons", false);
    },
    openModel: function(component, event, helper) {
        let checkVal = component.get('v.pickLines');
        let isAllow = false;
        let cancelledCount = 0;
        console.log('hasServiceInvoice',component.get('v.hasServiceInvoice'));
        for(var i =0 ; i< checkVal.length; i++){
            if(checkVal[i].isSelect){
                isAllow = true;
            }
            if(component.get('v.hasServiceInvoice')){
                if(checkVal[i].wrp.picklistLineObj.Status__c == 'Cancelled' || checkVal[i].isSelect){
                    cancelledCount++;
                }
            }
        }
        
        if(cancelledCount == checkVal.length){
            component.set('v.isShowButtons',true); 
        } else if(isAllow){
            component.set('v.isOpen',true); 
        }
        else {
            helper.warning({ message: ('Please select Picklist Line Items to cancel. ') });
        }
    },
    onCancelOnlyMileage: function(c, event, h) {
        c.set("v.isShowButtons", false);
        h.onCancelPickLines(c, true, h);
    },    
    onSave : function(c, e, h) {
        c.set("v.isOpen", false); 
        h.onCancelPickLines(c, false, h);
    }
})