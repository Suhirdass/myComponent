({
    doInit: function(c, e, h){
        console.log('##shipConfirmConsoleInternal recordId ',c.get('v.recordId'));
        var sParameterValue = c.get('v.recordId');
        var errormsg ='';
        h.request(c, 'getSmLines', {recordId: c.get("v.recordId")}, function(r){
            c.set('v.setSM', r.setSM);
			 c.set('v.SMLI_Rejection_Reason_Validation_Config',r.SMLI_Rejection_Reason_Validation_Config);
            if(r.setSM.RecordType.Name!='Cash Collection')
            {
                 c.set('v.soId',r.setSM.Sales_Order__r.Id);
            }
            
         
            var checkInvoice = r.invoiceDt;
            if(checkInvoice){
                  c.set('v.invoiceCheck',true);
            }else{
                  c.set('v.invoiceCheck',false);
            }
            
            c.set('v.setRsmLines', r.setRsmLines);
            c.set('v.hasServiceInvoice', r.hasServiceInvoice);
            window.setTimeout(
                $A.getCallback(function() {
                    
                    // Set received QTY
                    var recQty = c.find("recQty"); 
                    var qtyValue =c.find("passQty");
                    
                    if(recQty){
                        if(qtyValue.length==undefined)
                        {
                            recQty.set("v.value",qtyValue.get('v.value'))
                        }
                        for(var i=0; i<recQty.length; i++){
                            
                            recQty[i].set("v.value",qtyValue[i].get('v.value'));
                        }
                    }
                    
                }), 2000
            );
        
        });
        
    },
    
    onShipConfirm: function(c, e, h){
        var smLinesstatus = 'true';
        var setRsmLines  = c.get("v.setRsmLines"); 
        var recordId = c.get("v.recordId"); 
        // Rsm lines client side validation
        var d=0;
        var smlineError ='';
        for(var d=0;d<setRsmLines.length;d++){
            if(setRsmLines[d].rsmlinesIL.Shipment_Qty__c < setRsmLines[d].rsmlinesIL.Qty_Received__c)
            {
                smlineError += setRsmLines[d].rsmlinesIL.Name+' Qty To Receive cannot be greater than Shipment Qty \n';
                smLinesstatus = false;
            }else if(setRsmLines[d].rsmlinesIL.Qty_Received__c < 0){
                smlineError += setRsmLines[d].rsmlinesIL.Name+' Qty To Receive must be positive value \n';
                smLinesstatus = false;
            }else if(setRsmLines[d].rsmlinesIL.Qty_Received__c==''){
                smlineError += setRsmLines[d].rsmlinesIL.Name+' Qty To Receive must not be empty \n';
                smLinesstatus = false;
            }else if(setRsmLines[d].rsmlinesIL.Shipment_Qty__c != setRsmLines[d].rsmlinesIL.Qty_Received__c && setRsmLines[d].rsmlinesIL.Rejection_Reason__c =='None'){
                smlineError += c.get('v.SMLI_Rejection_Reason_Validation_Config').replace('{0}', setRsmLines[d].rsmlinesIL.Name) +'\n';
                smLinesstatus = false;
            }
            
        }
        if(smLinesstatus == false){
            h.error({message: smlineError});
        } else {
            h.request(c, 'updateShipmentConfirm', 
                      { 
                          
                          setRsmLines: c.get("v.setRsmLines"),
                          smRtypeName:c.find("smRtypeName").get("v.value"),
                          recordId:recordId
                      }, function(r){ 
                          
                          c.set('v.message',r.message);
                          if(r.message){
                              h.error({ message:c.get('v.message') });  
                              
                          }else{
                              h.success({ message:'Ship confirmed successfully' });  
                              
                             var ckInvoice =c.get("v.invoiceCheck");
                              if(ckInvoice)
                              {
                                  window.setTimeout(function(){
                                      c.set('v.openCreateInvoicePopup',true);
                                  }, 3000); 
                              }else{
                                  window.setTimeout(function(){
                                      /*
                                              var salesOrderId = c.get("v.soId");
                                       alert(salesOrderId);
                                      if(salesOrderId)
                                          h.request(c, 'updateBqAndOrderLineItems', {soId:salesOrderId}, function(r){
                                              
                                              window.setTimeout(
                                                  $A.getCallback(function() {
                                                      c.set("v.soId",'');
                                                  }), 5000
                                              );
                                              
                                          }); 
                                      */
                                      window.setTimeout(function(){ $A.get('e.force:refreshView').fire(); }, 3000); 
                                      window.location.href = "/" + c.get("v.recordId"); 
                                      
                                      
                                  }, 3000); 
                              }
                           
                              
                              
                             /* var urlEvent = $A.get("e.force:navigateToURL");
                              urlEvent.setParams({
                                  "url": "/apex/InvoicePDFshipManifest?id=" +  c.get('v.recordId'),
                                  redirect:true
                                  
                              });
                              urlEvent.fire();
                              */
                              
                             // window.setTimeout(function(){ $A.get('e.force:refreshView').fire(); }, 3000); 
                              //window.location.href = "/" + c.get("v.recordId"); 
                          }
                          
                      });
        }
    },
    
    onReturn: function(c, e, h) {
        var url = window.location.href; 
        var value = url.substr(0,url.lastIndexOf('/') + 1);
        window.history.back();
        return false;
    },
      createInvoicePdf: function(c, e, h) {
          
                  
        var salesOrderId = c.get("v.soId");
        if(salesOrderId)
            h.request(c, 'updateBqAndOrderLineItems', {soId:salesOrderId}, function(r){
                
                window.setTimeout(
                    $A.getCallback(function() {
                        c.set("v.soId",'');
                    }), 5000
                );
                
            });
          
                       var urlEvent = $A.get("e.force:navigateToURL");
                              urlEvent.setParams({
                                  "url": "/apex/InvoicePDFshipManifest?id=" +  c.get('v.recordId'),
                                  redirect:true
                                  
                              });
                              urlEvent.fire();
    },  closeDialog: function(c, e, h) {
        c.set('v.openCreateInvoicePopup',false);
          c.set('v.noInvoicePopup',false);
        window.setTimeout(function(){ $A.get('e.force:refreshView').fire(); }, 3000); 
        window.location.href = "/" + c.get("v.recordId"); 
    }
})