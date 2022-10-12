({
doInit : function(c, e, h) {
        h.request(c, 'createInvoice', {recordId: c.get("v.recordId")}, function(r){
            
                if(r.Error != null || r.Error != undefined){
                    h.error({ message: r.Error });
                    c.set('v.error',r.Error);
                    c.set('v.hasSalesOrderLines', True);
                    c.set('v.isOBCreate',fasle);
                } else {
                    debugger;
                   if(r.isOBCreated != null || r.isOBCreated != undefined){
                    c.set('v.OBCreatedMsg',r.isOBCreated);
                    c.set('v.isOBCreate',true);
                }
                    c.set('v.hasSalesOrderLines', r.hasSalesOrderLines);
                    c.set('v.salesOrderSO', r.salesOrderSO);
                    c.set('v.setSalesOrderLines', r.setSalesOrderLines);
                    c.set('v.salesOrderLines', r.salesOrderLines);
                    c.set('v.isDataLoaded',true);
                    c.set('v.invoiceData',r.invoiceData);
                    c.set('v.invoiceDataString',r.invoiceDataString);
                    c.set('v.statusSO',r.statusSO);
                    c.set('v.listSize',r.listSize);
                    c.set('v.allocatedSO',r.allocatedSO);
                    
                    if((c.get('v.statusSO') == 'Cancelled') )
                    { 
                        console.log('inside Cancelled') ;   
                        h.navigateToRecord(c, c.get('v.recordId'));
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            title : 'Warning',
                            message:'Invoice cannot be created for cancelled SO',
                            duration:' 5000',
                            key: 'info_alt',
                            type: 'Warning',
                            mode: 'pester'
                        });
                        toastEvent.fire();   
                    }
                    if((c.get('v.statusSO') == 'Rejected') )
                    { 
                        console.log('inside Cancelled') ;   
                        h.navigateToRecord(c, c.get('v.recordId'));
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            title : 'Warning',
                            message:'Invoice cannot be created for Rejected SO',
                            duration:' 5000',
                            key: 'info_alt',
                            type: 'Warning',
                            mode: 'pester'
                        });
                        toastEvent.fire();   
                    }         
                    
                }
            
            
        });
	},

    noOB : function(c, e, h) {
        c.set('v.isOBCreate',false);
        h.navigateToRecord(c,c.get("v.recordId"),'detail');
    },
    yesOB :function(c, e, h) {
        c.set('v.isOBCreate',false);
       
    },
onCancel : function(c, e, h) {
        h.navigateToRecord(c, c.get('v.recordId'));
    },
    
selectCheckbox : function(c, e, h) { 

    	var recQty = c.find("recQty"); 
        var qtyValue = c.find("passQty");
    	var checkContact = c.find("checkContact");
    
    if(checkContact.length){
            for(var i=0; i<checkContact.length; i++){
                var dis = checkContact[i].get('v.disabled');
                var disChk = checkContact[i].get('v.value');
                if(!dis && disChk){
                	recQty[i].set("v.value",qtyValue[i].get('v.value'));                
            }else{
                recQty[i].set("v.value",0);
            }
     }
    }

    },

selectAllCheckboxes : function(c, e, h) {
    	debugger;
        var checkvalue = c.find("selectAll").get("v.value");
        var checkContact = c.find("checkContact");
        var recQty = c.find("recQty"); 
        var qtyValue = c.find("passQty");
    
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
                	recQty[i].set("v.value",qtyValue[i].get('v.value'));
                }else if(!disTwo && checkvalue==false){
                    recQty[i].set("v.value",0);
                } 
            } 
        } else {
                var disTwo = recQty.get('v.disabled');
                if(!disTwo && checkvalue==true){
                	recQty.set("v.value",qtyValue.get('v.value'));
                }else if(!disTwo && checkvalue==false){
                    recQty.set("v.value",0);
                } 
        } 

    },
    
    
createInvoices : function(c, e, h) {

                var setSalesOrderLines = c.get('v.setSalesOrderLines');
            	
                var callController = 'true';
        		var anyCheckSelected = 'false';
        		setSalesOrderLines.forEach(function (soli, index){
            if((soli.qtyToBill == null || soli.qtyToBill == '') && soli.isSelected){
                callController = 'false';
            } 
            
            if(soli.isSelected){
                anyCheckSelected = 'true';
            } 

        });
        if(callController == 'false'){
            h.warning({message: 'Qty to bill must not be empty for product'});
        } 
        else if(anyCheckSelected == 'false'){
            h.warning({message: 'Please select Sales Order Line Items to create Invoice.'});
        } 
        else{
           h.request(c, 'createInvoiceAndLinesLight', 
                  {salesOrderSO: c.get("v.salesOrderSO"),  setSalesOrderLines: c.get("v.setSalesOrderLines") }, function(r){   

                              if(r.Error != null || r.Error != undefined){
                                  h.error({ message: r.Error });
                              } else {
                                c.set('v.errorQB',r.errorQB);

                                if((c.get('v.errorQB') == 'Error1'))
                                  { 
                                    var toastEvent = $A.get("e.force:showToast");
                                    toastEvent.setParams({
                                        title : 'Warning',
                                        message:'Qty to bill must be greater than 0 for product',
                                        duration:' 5000',
                                        key: 'info_alt',
                                        type: 'Warning',
                                        mode: 'pester'
                                    });
                                    toastEvent.fire();   
                                   } 
                              else if((c.get('v.errorQB') == 'Error2'))
                                  {  
                                    var toastEvent = $A.get("e.force:showToast");
                                    toastEvent.setParams({
                                        title : 'Warning',
                                        message:'Qty to Bill cannot be greater than balance qty to Invoice',
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
                                        message:'Please select sales order lines to create invoice',
                                        duration:' 5000',
                                        key: 'info_alt',
                                        type: 'Warning',
                                        mode: 'pester'
                                    });
                                    toastEvent.fire();   
                                  }else {
                                      h.navigateToRecord(c, c.get('v.recordId'));
                                  }          
                                        }           
                                    });           
        }
    },
})