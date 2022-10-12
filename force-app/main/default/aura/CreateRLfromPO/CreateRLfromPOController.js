({
    doInit : function(c, e, h) {
        console.log('Record Id:',c.get('v.recordId'));
        h.request(c, 'purchaseOrderDeatils', {poId: c.get("v.poId")}, function(r){ 
            c.set('v.poData', r.poData);
            c.set('v.setPurchaseOrderLines', r.setPurchaseOrderLines);
            c.set('v.statusPO', r.statusPO); 
            c.set('v.getLabStatusData', r.getLabStatusData);
           	var result = c.get('v.getLabStatusData');
           	var labTestMap = [];
                for(var key in result){
                    labTestMap.push({key: key, value: result[key]});
                }
           c.set("v.labTestMap", labTestMap); 

            if(c.get('v.statusPO')) {  
             h.navigateToRecord(c, c.get('v.poId'));
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Warning',
                    message:'Invalid PO to create Receipts. Please select a Valid PO.',
                    duration:' 5000',
                    key: 'info_alt',
                    type: 'Warning',
                    mode: 'pester'
                });
                toastEvent.fire();   
              }
        });
    },
    
    
    createReceipts : function(c, e, h) {
        var setPurchaseOrderLines = c.get('v.setPurchaseOrderLines');
        var callController = 'true';
        var anyCheckSelected = 'false';
        var balChk = 'false';
        var uidChk = 'false';
        var bidChk = 'false';
        var checkUDVandCDV = 'false';
        var errorMsg = 'Receiving line {';
        
        setPurchaseOrderLines.forEach(function (poli, index){
            if((poli.recQty == null || poli.recQty == '' || poli.recQty == 0) && poli.isSelected){
                callController = 'false';
            } 
            if((poli.pOrderLineSO.UID_New__c == null || poli.pOrderLineSO.UID_New__c == '') && poli.isSelected){
                uidChk = 'true';
            } 
            if((poli.pOrderLineSO.Harvest_Batch_Code__c == null || poli.pOrderLineSO.Harvest_Batch_Code__c == '') && poli.isSelected){
                bidChk = 'true';
            } 
            if(poli.isSelected){
                anyCheckSelected = 'true';
            } 
            var a = parseInt(poli.recQty);
            if(a > poli.pOrderLineSO.Balance_Qty__c){
                balChk = 'true';
            } else if(a == poli.pOrderLineSO.Balance_Qty__c){balChk = 'false';}
            if(poli.isSelected && (poli.pOrderLineSO.Product_Name__r.Unit_DIMs_Verified__c == false || poli.pOrderLineSO.Product_Name__r.Case_DIMs_Verified__c == false)){
                if(!(poli.pOrderLineSO.Product_Name__r.Is_Sample__c && poli.pOrderLineSO.Product_Name__r.Parent_Product__c != null)){
                	checkUDVandCDV = 'true';
                    errorMsg += poli.pOrderLineSO.Product_Name__r.Name+', ';    
                }
            }
        });

        if(callController == 'false'){
            h.warning({message: 'Receiving Qty must not be empty for product'});
        } else if(anyCheckSelected == 'false'){
            h.warning({message: 'Please select Purchase Order Line Items to create Receiving.'});
        } else if(balChk == 'true'){
            h.warning({message: 'Receiving Qty must not be greater than Balance Quantity.'});
        } else if(uidChk == 'true'){
            h.warning({message: 'UID must not be empty for Purchase Order Line.'});
        } else if(bidChk == 'true'){
            h.warning({message: 'Batch ID must not be empty for Purchase Order Line.'});
        } else if(checkUDVandCDV == 'true'){
            errorMsg = errorMsg.substring(0, errorMsg.length-2);
            errorMsg += '} CDV/UDV is not verified.';
            c.set('v.errMsg',errorMsg);
            c.set('v.validateCDVUDV',true);
        } else {   
         h.request(c, 'CreateRecevings', 
             {poData: c.get("v.poData"),  setPurchaseOrderLines: c.get("v.setPurchaseOrderLines"),isDim: false }, function(r){
                 
                 c.set('v.hasBalQty', r.hasBalQty);
                   c.set('v.redRec', r.redRec);
                 c.set('v.pordNames', r.pordNames);
                 if(c.get('v.hasBalQty')) { 
                     
                 	h.warning({message: 'Receiving Qty must not be greater than Balance Quantity for '+c.get('v.pordNames')});
                     window.setTimeout( $A.getCallback(function() {window.location.reload();}), 1000);
                    
                 }else{
                     e.getSource().set("v.disabled", true);
                     window.location.href = '/' + c.get('v.redRec'); 
                 }   	
              }); 
            
        }
    },
      
    createReceiptYes: function(c, e, h) {
        h.request(c, 'CreateRecevings', {poData: c.get("v.poData"),  setPurchaseOrderLines: c.get("v.setPurchaseOrderLines"),isDim: true }, function(r){
            c.set('v.redRec', r.redRec);
            c.set('v.hasUID', r.hasUID);
            c.set('v.hasBalQty', r.hasBalQty);
            c.set('v.pordNames', r.pordNames);
            if(c.get('v.hasBalQty')) { 
                 	h.warning({message: 'Receiving Qty must not be greater than Balance Quantity for'+ c.get('v.pordNames')});
                	var action = c.get('c.closeModel');
                	$A.enqueueAction(action);
                 }else{
                     window.location.href = '/' + c.get('v.redRec'); 
                 }
        }); 
        e.getSource().set("v.disabled", true);
    },
    
    closeModel: function(c, e, h) {
        c.set('v.validateCDVUDV', false);
    },
    
    onCancel : function(c, e, h) {
        try{
            window.location.href = '/' + c.get('v.poId'); 
        } catch(ex){
            console.log('Exception '+ex);
        }
    }, 
    
    checkVal: function(c, e, h){
        var indexed = e.getSource();
        var indexvar = e.getSource().get("v.name");
        var value = indexed.get("v.value");
        if(value == 0.0 || value == '' || value <=0 || value == 0){
            var elem = c.find(indexvar);
            $A.util.addClass(indexed, "clrRed");  
        }else{
            $A.util.removeClass(indexed, 'clrRed');
        } 
    },

    
    selectAllCheckboxes : function(c, e, h) {
        debugger;
        var checkvalue = c.find("selectAll").get("v.value");
        var checkContact = c.find("checkContact");
        
        if(checkContact.length){
            for(var i=0; i<checkContact.length; i++){
                var dis = checkContact[i].get('v.disabled');
                if(!dis){
                    checkContact[i].set("v.value",checkvalue);
                }
            } 
        } else{
            var dis = checkContact.get('v.disabled');
            if(!dis){
                checkContact.set("v.value",checkvalue); 
            }
        }
    },
})