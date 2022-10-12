({
	init : function(c, e, h) {
        h.request(c, 'miscReceiptLightningLoad', {recId: c.get("v.recordId")}, function(r){
            
        	c.set('v.prod', r.prod);
            c.set('v.totalInventory', r.totalInventory);
            c.set('v.invPositionRec', r.invPositionRec);
            c.set('v.invPerAdj', r.invPerAdj);
            c.set('v.typeOptions', r.typeOptions);
        });
	},
    
    onCancel : function(c, e, h) {
       var evt = $A.get("e.force:navigateToComponent");
        evt.setParams({
            componentDef : "c:inventoryDetails",
            componentAttributes: {
                recordId : c.get("v.recordId")
            }
        });
        evt.fire(); 
        
    },
    
    onSave : function(c, e, h) {
    	var check = c.find('a_opt1').get('v.validity').valueMissing;
        var check2 = c.find('a_opt2').get('v.validity').valueMissing;
        var check3 = c.find('a_opt3').get('v.validity').valueMissing;
        
        c.find('a_opt1').showHelpMessageIfInvalid();
        c.find('a_opt2').showHelpMessageIfInvalid();
        c.find('a_opt3').showHelpMessageIfInvalid();
        
        if(c.get('v.invPositionRec.Ownership__c') == null || c.get('v.invPositionRec.Site__c') == null){
                h.warning({ message: ('Please fill all fields.') });
        }else if(c.get('v.invPositionRec.Qty_On_Hand__c') <= 0 ){
            h.warning({ message: ('Qty cannot be zero or empty') });
        } else {
            
            if(check == check2 == check3 == false){
            if(c.get('v.invPositionRec.Site__c') != null || c.get('v.invPositionRec.Site__c') != undefined 
              || c.get('v.invPositionRec.Ownership__c') != null || c.get('v.invPositionRec.Ownership__c') != undefined ){
                h.request(c, 'saveRecordLightning', {recordID: c.get("v.recordId"),invPositionRec : c.get("v.invPositionRec"),invPerAdj : c.get("v.invPerAdj")}, function(r){
                    var evt = $A.get("e.force:navigateToComponent");
                    evt.setParams({
                        componentDef : "c:inventoryDetails",
                        componentAttributes: {
                            recordId : c.get("v.recordId")
                        }
                    });
                    evt.fire();     
                });    
            }
        }
        }
                
    }
})