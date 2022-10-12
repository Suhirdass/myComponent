({
    doInit : function(c, e, h) {
        h.request(c, 'initCreatePO', {recordId: c.get("v.recordId")}, function(r){
            if(r.Error != null || r.Error != undefined){
                window.location.href = '/' + c.get('v.recordId');
                h.error({ message: r.Error });
            } else {
                
                console.log('##Line : ',JSON.stringify(r.lines));
                c.set('v.isPermit',true);
                c.set('v.quoteItems', r.records);
                c.set('v.items', r.items);
                c.set('v.lines', r.lines);
                c.set('v.hasLines', r.hasLines);
                
                var quoteItems2 = c.get("v.lines");
                
            }	
        });
        
    },
    
    closeModel : function(c, e, h) {
        c.set('v.isPermit',false);
        try{
            window.location.href = '/' + c.get('v.recordId'); 
        } catch(ex){
        }
    },
    
    selectAllCheckboxes : function(c, e, h) {
        var getID = c.get("v.lines");
        var checkvalue = c.find("selectAll").get("v.value");
        var checkContact = c.find("checkContact");
        if(checkContact.length){
            for(var i=0; i<checkContact.length; i++){
                checkContact[i].set("v.value",checkvalue);
                var bqlChild = c.find("checkProduct"); 
                for(var j=0; j<bqlChild.length; j++){
                    bqlChild[j].set("v.checked",checkvalue);
                } 
            } 
        } else{
            checkContact.set("v.value",checkvalue); 
            var bqlChild = c.find("checkProduct"); 
            for(var j=0; j<bqlChild.length; j++){
                bqlChild[j].set("v.checked",checkvalue);
            } 
        }
        var quoteItems2 = c.get("v.lines");
        var JSONStr2 = JSON.stringify(quoteItems2);
        for(var i=0;i<quoteItems2.length;i++){
            var newQtyToBill='';
            var qtyToBills = c.find("qtyToBill"); 
            if(quoteItems2[i].isSelected && (quoteItems2[i].qtyToBill == 0 || quoteItems2[i].qtyToBill == null))
            {
                newQtyToBill= quoteItems2[i].isSelected?(quoteItems2[i].quoteLine.Billed_Quantity__c != null ?(quoteItems2[i].quoteLine.Line_Total_Qty__c - quoteItems2[i].quoteLine.Billed_Quantity__c):quoteItems2[i].quoteLine.Line_Total_Qty__c):0;                    
                
                if(quoteItems2.length > 1)
                {
                    qtyToBills[i].set('v.value',newQtyToBill);  
                }
                else
                {
                    
                    qtyToBills.set('v.value',newQtyToBill);   
                }
                
            }
            else if(!quoteItems2[i].isSelected) {
                if(quoteItems2.length > 1)
                {
                    qtyToBills[i].set('v.value',0);
                }
                else
                {
                    qtyToBills.set('v.value',0);   
                }
            }
        }
        
    },
    
    cancelBtn : function(c, e, h) {
        try{
            window.location.href = '/' + c.get('v.recordId'); 
        } catch(ex){
            
        }
    },
    
    updateQtyToBillForSelectedProducer : function(c, e, h) {
        var productId = e.currentTarget.dataset.id;
        var checkValue = e.currentTarget.dataset.info;
        var bqlChild = c.find("checkProduct"); 
        
        
        for(var i=0; i<bqlChild.length; i++){
            if(bqlChild[i].get('v.name') === productId){
                if(checkValue == 'true'){
                    bqlChild[i].set("v.value",true);
                } else {
                    bqlChild[i].set("v.value",false);
                }
            }
        } 
        
        
        var quoteItems2 = c.get("v.lines");
        var JSONStr2 = JSON.stringify(quoteItems2);
        var newQtyToBill='';
        var qtyToBills = c.find("qtyToBill"); 
        for(var i=0;i<quoteItems2.length;i++){
            
            if(quoteItems2[i].producerId == productId)
            {
                newQtyToBill= quoteItems2[i].isSelected?(quoteItems2[i].quoteLine.Billed_Quantity__c != null ?(quoteItems2[i].quoteLine.Line_Total_Qty__c - quoteItems2[i].quoteLine.Billed_Quantity__c):quoteItems2[i].quoteLine.Line_Total_Qty__c):0;                    
                
                if(quoteItems2.length > 1)
                {
                    qtyToBills[i].set('v.value',newQtyToBill);  
                }
                else
                {
                    
                    qtyToBills.set('v.value',newQtyToBill);   
                }
                
            }
            else if(!quoteItems2[i].isSelected) {
                qtyToBills[i].set('v.value',0);
            }
        }
        
    },
    
    updateQtyToBill : function(c, e, h) {
        var quoteItems = c.get("v.lines");
        for(var i=0;i<quoteItems.length;i++){
            var newQtyToBill='';
            var qtyToBills = c.find("qtyToBill"); 
            if(quoteItems[i].isSelected && (quoteItems[i].qtyToBill == 0 || quoteItems[i].qtyToBill == null))
            {
                newQtyToBill= quoteItems[i].isSelected?(quoteItems[i].quoteLine.Billed_Quantity__c != null ?(quoteItems[i].quoteLine.Line_Total_Qty__c - quoteItems[i].quoteLine.Billed_Quantity__c):quoteItems[i].quoteLine.Line_Total_Qty__c):0;                    
                
                if(quoteItems.length > 1)
                {
                    qtyToBills[i].set('v.value',newQtyToBill);  
                }
                else
                {
                    
                    qtyToBills.set('v.value',newQtyToBill);   
                }
                
            }
            else if(!quoteItems[i].isSelected) {
                if(quoteItems.length > 1)
                {
                    qtyToBills[i].set('v.value',0);
                }
                else
                {
                    qtyToBills.set('v.value',0);   
                }
            }
        }
    },
    
    createQuote : function(c, e, h) {
        var quoteItems = c.get("v.quoteItems.items.isSelected");
        var quoteItems1 = c.get("v.lines");
        var selectedRec = c.get('v.quoteItems.items');
        var inputCheckBoxSelected=false;
        for(var i=0; i<quoteItems1.length; i++){
            if(quoteItems1[i].isSelected){
                inputCheckBoxSelected = true;
            }    
        }
        for(var i=0; i<selectedRec.length; i++){
            if(selectedRec[i].isSelected){
                inputCheckBoxSelected = true;
            }    
        }
        if(inputCheckBoxSelected == false ){
            
            h.warning({ message: ('Please select a Brand Quote Line to create Purchase Order. ') });    
        } 
        else
        {
            var JSONStr1 = JSON.stringify(c.get("v.lines"));
            var isMulti = c.get("v.quoteItems.isMulti");
            
            h.request(c, 'createOrderOne', {qt: c.get("v.quoteItems.quote"), json1 : JSONStr1, multi :isMulti,recordId: c.get("v.recordId")}, function(r){
                if(r.Warning != null || r.Warning != undefined){
                    
                    h.error({ message: r.Error });
                }else if(r.Error != null || r.Error != undefined){
                    
                    h.error({ message: r.Error });
                    window.setTimeout(
                        $A.getCallback(function() {
                            window.location.reload();
                        }), 4000);
                    
                }else {
                    try{
                        window.location.href = '/' + r.recordIds;
                    } catch(ex){
                    }
                }
            });    
        }
    },
    
    validateQtyToBill:function(c, e, h) {
        var indexed = e.getSource();
        var indexvar = e.getSource().get("v.name");
        var value = indexed.get("v.value");
        if(value==0 || value==''){
            e.getSource().set("v.value",0);
        }
        
    },
    
})