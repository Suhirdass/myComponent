({
	doInit : function(c, e, h) {
        h.request(c, 'createInvoice', {recordId: c.get("v.recordId")}, function(r){
            if(r.Error != null || r.Error != undefined){
                h.error({ message: r.Error });
                h.navigateToRecord(c, r.InvoiceId);
                /*c.set('v.error',r.Error);
                c.set('v.hasInvoiceLines', True);*/
            } else {
                console.log('## invoice ',r.invoice)
                console.log('## setInvoiceLines ',r.setInvoiceLines)
                c.set('v.Err_Msg_Greater_than_0_Qty_to_Credit', r.Err_Msg_Greater_than_0_Qty_to_Credit);
                c.set('v.Err_Msg_greater_than_Invoice_Qty', r.Err_Msg_greater_than_Invoice_Qty);
             	c.set('v.hasInvoiceLines', r.hasInvoiceLines);
                c.set('v.invoice', r.invoice);
                c.set('v.setInvoiceLines', r.setInvoiceLines);
                c.set('v.InvoiceLines', r.InvoiceLines);
                c.set('v.isDataLoaded',true);
                  
            }
        });
	},
    onCancel : function(c, e, h) {
        h.navigateToRecord(c, c.get('v.recordId'));
    },
    onChangeInput : function(c,e,h) {
        var recQty = c.find("recQty"); 
        var avlQty = c.find("avlQty");
        var qtyValue = c.find("passQty");
        var fixQty = c.find("fixQty");
        var checkContact = c.find("checkContact"); 
        console.log(recQty);
        var i = e.getSource().get('v.name');
        if(i != undefined ){
            var InvQty = 0;
            var fixQtyValue = Array.isArray(avlQty) ? avlQty[i].get("v.value") : avlQty.get("v.value");
            var recQtyValue = Array.isArray(recQty) ? recQty[i].get("v.value") : recQty.get("v.value");
            InvQty = fixQtyValue - recQtyValue;
            console.log('InvQty : ',InvQty);
            if(Array.isArray(qtyValue)){
                qtyValue[i].set("v.value",InvQty);
                recQty[i].set("v.value",recQtyValue); 
            }else{
                qtyValue.set("v.value",InvQty);
                recQty.set("v.value",recQtyValue); 
            }  
        }
          
    },
    selectCheckbox : function(c, e, h) { 
        
        var recQty = c.find("recQty"); 
        var qtyValue = c.find("passQty");
        var fixQty = c.find("fixQty");
        var avlQty = c.find("avlQty");
        var checkContact = c.find("checkContact");
        if(checkContact.length){
            for(var i=0; i<checkContact.length; i++){
                var dis = checkContact[i].get('v.disabled');
                var disChk = checkContact[i].get('v.value');
                if(!dis && disChk){
                    var InvQty = 0;
                    InvQty = avlQty[i].get('v.value') - recQty[i].get('v.value');
                    console.log('InvQty : ',InvQty);
                    qtyValue[i].set("v.value",InvQty); 
                    recQty[i].set("v.value",recQty[i].get('v.value'));                
                }/*else{
                    qtyValue[i].set("v.value",fixQty[i].get('v.value')); 
                    recQty[i].set("v.value",recQty[i].get('v.value'));
                }*/
            }
        }
        
    },
    selectAllCheckboxes : function(c, e, h) {
    	
        var checkvalue = c.find("selectAll").get("v.value");
        var checkContact = c.find("checkContact");
        var recQty = c.find("recQty"); 
        var avlQty = c.find("avlQty");
        var qtyValue = c.find("passQty");
    	var fixQty = c.find("fixQty");
        
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

    
        if(recQty.length > 1){
            for(var i=0; i<recQty.length; i++){
                var disTwo = recQty[i].get('v.disabled');
                if(!disTwo && checkvalue==true){
                    var InvQty = 0;
                    var fixQtyValue = Array.isArray(avlQty) ? avlQty[i].get("v.value") : avlQty.get("v.value");
                    var recQtyValue = Array.isArray(recQty) ? recQty[i].get("v.value") : recQty.get("v.value");
                    InvQty = fixQtyValue - recQtyValue;
                    console.log('InvQty : ',InvQty);
                    if(Array.isArray(qtyValue)){
                        qtyValue[i].set("v.value",InvQty);
                        recQty[i].set("v.value",recQtyValue); 
                    }else{
                        qtyValue.set("v.value",InvQty);
                        recQty.set("v.value",recQtyValue); 
                    }  
                	/*var InvQty = 0;
                    InvQty = fixQty[i].get('v.value') - recQty[i].get('v.value');
                    qtyValue[i].set("v.value",InvQty); 
                    recQty[i].set("v.value",recQty[i].get('v.value'));  */ 
                }/*else if(!disTwo && checkvalue==false){
                    qtyValue[i].set("v.value",fixQty[i].get('v.value')); 
                    recQty[i].set("v.value",recQty[i].get('v.value'));
                } */
            } 
        } else {
                var disTwo = recQty.get('v.disabled');
                if(!disTwo && checkvalue==true){
                    var InvQty = 0;
                    var fixQtyValue = Array.isArray(avlQty) ? avlQty[i].get("v.value") : avlQty.get("v.value");
                    var recQtyValue = Array.isArray(recQty) ? recQty[i].get("v.value") : recQty.get("v.value");
                    InvQty = fixQtyValue - recQtyValue;
                    console.log('InvQty : ',InvQty);
                    if(Array.isArray(qtyValue)){
                        qtyValue[i].set("v.value",InvQty);
                        recQty[i].set("v.value",recQtyValue); 
                    }else{
                        qtyValue.set("v.value",InvQty);
                        recQty.set("v.value",recQtyValue); 
                    }  
                	/*var InvQty = 0;
                    InvQty = fixQty[i].get('v.value') - recQty[i].get('v.value');
                    qtyValue[i].set("v.value",InvQty); 
                    recQty[i].set("v.value",recQty[i].get('v.value'));*/   
                }/*else if(!disTwo && checkvalue==false){
                    qtyValue[i].set("v.value",fixQty[i].get('v.value')); 
                    recQty.set("v.value",recQty[i].get('v.value'));
                }*/
        } 

    },
    createInvoices : function(c, e, h) {
        
        var setInvoiceLines = c.get('v.setInvoiceLines');
        
        var callController = 'true';
        var anyCheckSelected = 'false';
        setInvoiceLines.forEach(function (il, index){
            if((il.qtyToCredit == null || il.qtyToCredit == '') && il.isSelected){
                callController = 'false';
            } 
            
            if(il.isSelected){
                anyCheckSelected = 'true';
            } 
            
        });
        if(callController == 'false'){
            h.warning({message: c.get('v.Err_Msg_Greater_than_0_Qty_to_Credit')/*'Qty to Credit must be greater than 0.'*/});
        } 
        else if(anyCheckSelected == 'false'){
            h.warning({message: 'Please select Invoice Line Items to create Credit Memo.'});
        } 
            else{
                console.log('setInvoiceLines :',c.get("v.setInvoiceLines"));
                h.request(c, 'createInvoiceAndLinesLight', 
                          {invoice: c.get("v.invoice"),  setInvoiceLines: c.get("v.setInvoiceLines") }, function(r){   
                              
                              if(r.Error != null || r.Error != undefined){
                                  h.error({ message: r.Error });
                              } else {
                                  
                                  c.set('v.errorQB',r.errorQB);
                                  
                                  if((c.get('v.errorQB') == 'Error1'))
                                  { 
                                      var toastEvent = $A.get("e.force:showToast");
                                      toastEvent.setParams({
                                          title : 'Warning',
                                          message:c.get('v.Err_Msg_greater_than_Invoice_Qty'),
                                          duration:' 5000',
                                          key: 'info_alt',
                                          type: 'Warning',
                                          mode: 'pester'
                                      });
                                      toastEvent.fire();   
                                  }else if((c.get('v.errorQB') == 'Error2'))
                                  {  
                                    var toastEvent = $A.get("e.force:showToast");
                                    toastEvent.setParams({
                                        title : 'Warning',
                                        message:c.get('v.Err_Msg_greater_than_Invoice_Qty'),
                                        duration:' 5000',
                                        key: 'info_alt',
                                        type: 'Warning',
                                        mode: 'pester'
                                    });
                                    toastEvent.fire();   
                                   } else if((c.get('v.errorQB') == 'Error3'))
                                   {  
                                       var toastEvent = $A.get("e.force:showToast");
                                       toastEvent.setParams({
                                           title : 'Warning',
                                           message:'Please select Invoice lines to create Credit Memo',
                                           duration:' 5000',
                                           key: 'info_alt',
                                           type: 'Warning',
                                           mode: 'pester'
                                       });
                                       toastEvent.fire();   
                                   }else {
                                       console.log('r.newInvoiceId',r.newInvoiceId);
                                       h.navigateToRecord(c, r.newInvoiceId);
                                   }          
                              }           
                  });           
        }
    },
})