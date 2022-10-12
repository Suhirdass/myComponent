({
    doInit : function(c, e, h) {
        h.request(c, 'getPicklistLineItems', {recordId: c.get('v.recordId')}, function(r){
            c.set('v.picklistLineItems', r.picklistLineItems);
            c.set('v.pickedPicklistLineItems', r.pickedPicklistLineItems);
            
            c.set('v.statusBQ',r.statusBQ);
            const test = Math.random().toString(36).substring(2);
            h.createCookie("username", test, 1);
            let xCok = document.cookie;
            if((c.get('v.statusBQ') == 'QA Review') )
            {
                c.set("v.isToasterOpen", true);
                c.set('v.errMessage', 'Already Pick Confirmed. Picklist in '+c.get('v.statusBQ')+' status'); 
                window.setTimeout(
                    $A.getCallback(function() {
                        c.set("v.isToasterOpen", false);
                        var action = c.get('c.doAction');
                        $A.enqueueAction(action);
                    }), 5000);
                
                
                
            }else if ((c.get('v.statusBQ') == 'QA Confirm') )
            {
                c.set("v.isToasterOpen", true);
                c.set('v.errMessage', 'This picklist is already in QA Confirm status'); 
                window.setTimeout(
                    $A.getCallback(function() {
                        c.set("v.isToasterOpen", false);
                        var action = c.get('c.doAction');
                        $A.enqueueAction(action);
                    }), 5000);
                
                
                
            }else if ((c.get('v.statusBQ') == 'Cancelled') )
            {
                c.set("v.isToasterOpen", true);
                c.set('v.errMessage', 'Pick Confirm not allowed for Cancelled Picklist'); 
                window.setTimeout(
                    $A.getCallback(function() {
                        c.set("v.isToasterOpen", false);
                        var action = c.get('c.doAction');
                        $A.enqueueAction(action);
                    }), 5000);
                
                
            }    
            c.set('v.manualScan', false);
        }); 
    },
    doAction : function(c, e, h) {
        var msg = 'Return';
        var msgMethod = c.get("v.vfMsgMethod");
        msgMethod(msg, function(){ });
        
    },
    displayCookie : function(c, e, h) {
        let x = h.getCookie("username");
        
    },
    pickConfirms  : function(c, e,h) {
        console.log('inside pick confirm');
        h.request(c,'pickConfirm', {recordId: c.get("v.recordId")}, function(r){
            c.set('v.statusBQ',r.statusBQ);
            c.set('v.statuspick',r.statuspick);
            c.set('v.errorMsg',r.errorMsg);
            
            if((c.get('v.statusBQ') == 'QA Review') )
            {
                c.set("v.isToasterOpen", true);
                c.set('v.errMessage', 'Already Pick Confirmed. Picklist in '+c.get('v.statusBQ')+' status'); 
                window.setTimeout(
                    $A.getCallback(function() {
                        c.set("v.isToasterOpen", false);
                        $A.get("e.force:closeQuickAction").fire();
                    }), 5000);
                
                
            }else if ((c.get('v.statusBQ') == 'QA Confirm') )
            {
                c.set("v.isToasterOpen", true);
                c.set('v.errMessage', 'This picklist is already in QA Confirm status'); 
                window.setTimeout(
                    $A.getCallback(function() {
                        c.set("v.isToasterOpen", false);
                        $A.get("e.force:closeQuickAction").fire();
                    }), 5000);
                
                
            }else if (c.get('v.errorMsg')){
                var message = c.get('v.errorMsg');	
                c.set("v.isToasterOpen", true);
                c.set('v.errMessage', message); 
                window.setTimeout(
                    $A.getCallback(function() {
                        c.set("v.isToasterOpen", false);
                        $A.get("e.force:closeQuickAction").fire();
                    }), 5000);
                
            }
            
            if((c.get('v.statusBQ') != 'QA Review') && (c.get('v.statusBQ') == 'QA Confirm') )
            {
                
                var action = c.get('c.doAction');
                $A.enqueueAction(action);
            }
            if((c.get('v.statuspick') == 'QA Review') )
            {
                
                var action = c.get('c.doAction');
                $A.enqueueAction(action);
                
            }
        })
    },
    closeModel: function(c, e, h) {
        c.set('v.manualScan', false);
    },
    manualScanAction : function(c,e,h){
        var pklId = c.get('v.manScanId');
        var pklLineItems = c.get('v.picklistLineItems');
        var newlst =[];
        pklLineItems.forEach(function (pkli, index){
            
            if(!pkli.Item_Picked__c){
                newlst.push(pkli.Item_Picked__c); 
            }
        });
        
        h.request(c, 'updatePicklistLineItems', { pklId : pklId, picklistLineItems: c.get('v.picklistLineItems')}, function(r){
            var action = c.get('c.doInit');
            $A.enqueueAction(action);
            if(newlst.length <= 1){
                var action = c.get('c.pickConfirms');
                $A.enqueueAction(action);
            }
        });
    },
    handleConfirm : function(c,e,h){
        var pklId = e.currentTarget.dataset.id;
        var pklLineItems = c.get('v.picklistLineItems');
        var isEmpty = false;
        var isGreater = false;
        var isConfirmed = false;
        var manToast = false;
        var newlst =[];
        pklLineItems.forEach(function (pkli, index){
            
            var scVal;
            var elements = document.getElementById("vl"+index);
            scVal= elements.innerHTML;
            
            if(pkli.Id == pklId){
                if(pkli.Qty_Picked__c == null || pkli.Qty_Picked__c == '' || pkli.Qty_Picked__c <= 0){
                    isEmpty = true;
                }
                
                if(pkli.Qty_Picked__c > pkli.Qty_to_Pick__c){
                    isGreater = true;
                }
                
                if(pkli.Item_Picked__c){
                    isConfirmed = true;
                }
                
                if(scVal=='')
                { 
                    manToast = true;
                    c.set("v.manScanName", pkli.Name);
                }
                
            }
            
            if(!pkli.Item_Picked__c){
                newlst.push(pkli.Item_Picked__c); 
            }
        });
        
        
        if(isConfirmed){
            c.set("v.isToasterOpen", true);
            c.set("v.errMessage", 'Picklist Line has already been Confirmed');
            window.setTimeout(
                $A.getCallback(function() {
                    c.set("v.isToasterOpen", false);
                }), 3000);
        } 
        else if(isGreater){
            c.set("v.isToasterOpen", true);
            c.set("v.errMessage", 'Qty Picked cannot be greater than Qty to Pick');
            window.setTimeout(
                $A.getCallback(function() {
                    c.set("v.isToasterOpen", false);
                }), 3000);
        } 
            else if(isEmpty){
                c.set("v.isToasterOpen", true);
                c.set('v.errMessage', 'Please enter a value greater than 0 for Qty to Pick'); 
                window.setTimeout(
                    $A.getCallback(function() {
                        c.set("v.isToasterOpen", false);
                    }), 3000);
            }
                else if(manToast){
                    
                    c.set("v.manualScan", true);
                    c.set("v.manScanId", pklId);
                }
                    else{
                        
                        h.request(c, 'updatePicklistLineItems', { pklId : pklId, picklistLineItems: c.get('v.picklistLineItems')}, function(r){
                            
                            var action = c.get('c.doInit');
                            $A.enqueueAction(action);
                            if(newlst.length <= 1){
                                
                                var action = c.get('c.pickConfirms');
                                $A.enqueueAction(action);
                            }
                        });
                    }
        
        
    }
    
    
    
    
})