({

    doInit: function(c, e, h){
      
        h.request(c, 'getDataLight', {recordId: c.get("v.recordId")}, function(r){
            c.set('v.setSM', r.setSM);
             c.set('v.SMLI_Rejection_Reason_Validation_Config',r.SMLI_Rejection_Reason_Validation_Config);
            c.set('v.setOpenInvoiceLines', r.setOpenInvoiceLines);
            c.set('v.setPendingInvoiceLines', r.setPendingInvoiceLines);
            c.set('v.setRsmLines', r.setRsmLines);
            c.set('v.isDataLoaded',true);
            c.set('v.ccDate',r.curDatetime);
            c.set('v.getReceiverContacts',r.getReceiverContacts);
            c.set('v.getRcPaymentformStatusData', r.getPaymentStatusData);
            var checkInvoice = r.invoiceDt;
            if(checkInvoice){
                  c.set('v.invoiceCheck',true);
            }else{
                  c.set('v.invoiceCheck',false);
            }
            
            var result = c.get('v.getRcPaymentformStatusData');
            var rcMap = [];
            for(var key in result){
                rcMap.push({key: key, value: result[key]});
            }
            c.set("v.rcpaymentData", rcMap);
            var canvas=c.find('can').getElement();
            var ctx = canvas.getContext("2d");
            var w = canvas.width;
            var h = canvas.height;
            ctx.clearRect(0, 0, w, h);
              window.setTimeout(
            $A.getCallback(function() {
                c.get('v.ccDate');
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
                /*
                if(c.find("smRtypeName").get("v.value")=="Product TSM")
                {
                    var today = $A.localizationService.formatDate(new Date(), "YYYY-MM-DD");
                    var todaytime = $A.localizationService.formatDate(new Date(), "yyyy-MM-ddTHH:mm:ss");
                    var rAC = c.find("RAD").get('v.value');
                    var  actAATime = c.find("actAATime").set('v.value', todaytime);
                    if(!rAC){
                        c.find("RAD").set('v.value', todaytime);  
                    }
                    if(actAATime && actAATime==''){
                        c.find("actAATime").set('v.value', todaytime);  
                    }
                   
                }
                */
                var rconName = c.find("actReceivername").get("v.value");
                if ( typeof(rconName) !== "undefined" && rconName !== null ) {
                    c.find("rcSelect").set("v.value",rconName);
                }
                
               
                
            }), 2000
        );
        
             var element_btnSec = document.getElementsByClassName("btnSec");
                element_btnSec[0].style.display = 'none';
                var element_fltright = document.getElementsByClassName("fltright");
                element_fltright[0].style.display = 'none'; 
            
        window.setTimeout(
            $A.getCallback(function() {
                
                 var element_btnSec = document.getElementsByClassName("btnSec");
                element_btnSec[0].style.display = 'block';
                var element_fltright = document.getElementsByClassName("fltright");
                element_fltright[0].style.display = 'block';
            }), 1500
        );
        
            
        });
        
      
    },
    testRedirect:function (c, e,h){
         var address = component.find("address").get("v.value");

        var urlEvent = $A.get("e.force:navigateToURL");
        var recordID = c.get("v.recordId");
        urlEvent.setParams({
          "url": 'https://wovn--dev.lightning.force.com/apex/InvoicePDFshipManifest?id=' + recordID,
          "isredirect": "true"
        });
        urlEvent.fire();
    },
    onScriptsLoaded : function(c, e, h) {
        c.set('v.isScriptsLoaded',true);
        h.applyDataTable(c,e);
    },
    onShipConfirm: function(c, e, h){
        var currentInvoice = 'true';
        var pendingInvoice = 'true';
        var smLinesstatus = 'true';
        var currentInvoiceLines = c.get("v.setOpenInvoiceLines");
        var pendingInvoiceLines = c.get("v.setPendingInvoiceLines");
        var checkSignPad = c.get("v.signPad");
        var setRsmLines  = c.get("v.setRsmLines"); 
        
        function addZeroes(num) {
            // Cast as number
            var num = Number(num);
            // If not a number, return 0
            if (isNaN(num)) {
                return 0;
            }
            // If there is no decimal, or the decimal is less than 2 digits, toFixed
            if (String(num).split(".").length < 2 || String(num).split(".")[1].length<=2 ){
                num = num.toFixed(2);
            }
            // Return the number
            return num;
        }
        
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
            if(setRsmLines[d].rsmlinesIL.Shipment_Qty__c == setRsmLines[d].rsmlinesIL.Qty_Received__c && (setRsmLines[d].rsmlinesIL.Rejection_Reason__c ==null || setRsmLines[d].rsmlinesIL.Rejection_Reason__c ==undefined)){
                setRsmLines[d].rsmlinesIL.Rejection_Reason__c = 'None'
            }
        }
         c.set('v.setRsmLines',setRsmLines);
         // Current Invoice client side validation    
        var k=0;
        var cinvoiceError ='';
        for(  var k=0;k<currentInvoiceLines.length;k++){
            
            if(currentInvoiceLines[k].prodAmt!=0){
                if(currentInvoiceLines[k].allInvoices.Product_Balance__c >= currentInvoiceLines[k].productAmount)
                {
                    
                }else{
                    cinvoiceError +=currentInvoiceLines[k].allInvoices.Name+' Product Amount $'+addZeroes(currentInvoiceLines[k].productAmount)+' cannot be greater than Product Balance $'+addZeroes(currentInvoiceLines[k].allInvoices.Product_Balance__c)+' \n ';
                    currentInvoice = false;
                }
            }
            
            if((currentInvoiceLines[k].productAmount!=0 || currentInvoiceLines[k].exciseTax!=0 ) && currentInvoiceLines[k].paymentForm == '' ){
                cinvoiceError +=currentInvoiceLines[k].allInvoices.Name+' Payment form is required to receive payment \n';
                currentInvoice = false;
            }
            
            if(currentInvoiceLines[k].exciseTax!=0){
                if(currentInvoiceLines[k].allInvoices.Excise_Tax_Balance__c >= currentInvoiceLines[k].exciseTax)
                {
                    
                }else{
                    
                    cinvoiceError +=currentInvoiceLines[k].allInvoices.Name+' Tax Amount  $'+addZeroes(currentInvoiceLines[k].exciseTax)+' cannot be greater than Excise Tax Balance $'+addZeroes(currentInvoiceLines[k].allInvoices.Excise_Tax_Balance__c)+'\n ';
                    currentInvoice = false;
                }
            }
        }
        
        // Pending Invoice client side validation
        var j=0;
        var pinvoiceError ='';
        
        for(var j=0;j<pendingInvoiceLines.length;j++){
            
            if(pendingInvoiceLines[j].productAmount!=0){
                if(pendingInvoiceLines[j].allInvoices.Product_Balance__c >= pendingInvoiceLines[j].productAmount)
                {
                  
                }else{
                    pinvoiceError +=pendingInvoiceLines[j].allInvoices.Name+' Product Amount $'+addZeroes(pendingInvoiceLines[j].productAmount)+' cannot be greater than Product Balance $'+addZeroes(pendingInvoiceLines[j].allInvoices.Product_Balance__c)+' \n';
                    pendingInvoice = false;
                }
            }
            
            if((pendingInvoiceLines[j].productAmount!=0 || pendingInvoiceLines[j].exciseTax!=0 ) && pendingInvoiceLines[j].paymentForm== '' ){
                pinvoiceError +=pendingInvoiceLines[j].allInvoices.Name+' Payment form is required to receive payment \n';
                pendingInvoice = false;
            }
            
            
            if(pendingInvoiceLines[j].exciseTax!=0){
                if(pendingInvoiceLines[j].allInvoices.Excise_Tax_Balance__c >= pendingInvoiceLines[j].exciseTax)
                {
                  
                }else{
                    
                    pinvoiceError +=pendingInvoiceLines[j].allInvoices.Name+' Tax Amount  $'+addZeroes(pendingInvoiceLines[j].exciseTax)+' cannot be greater than Excise Tax Balance $'+addZeroes(pendingInvoiceLines[j].allInvoices.Excise_Tax_Balance__c)+' \n';
                    pendingInvoice = false;
                }
            }
        }

       
        if(smLinesstatus == false){
            h.error({message: smlineError});
        } else 
            if(currentInvoice == false){
                h.error({message: cinvoiceError});
            } 
            else if(pendingInvoice == false){
                h.error({message: pinvoiceError});
                
            }else if(checkSignPad == false){
                
                h.error({message: 'e-Signature is required'});
            } else {
                
                var canvas, ctx;
                canvas=c.find('can').getElement();
                ctx = canvas.getContext("2d");
                var metricId = c.find("metricId").get("v.value");
                var rcAcptDt='';
                var actReceivername ;
                var  dateString = c.find("rcAcptDate").get("v.value");
                rcAcptDt  = c.get('v.ccDate');
                actReceivername = ctx.fillText(c.find("actReceivername").get("v.value"), 180, 120); 
                ctx.font="12px Arial";
                ctx.fillStyle = "black";
                ctx.fillText(c.find("smName").get("v.value"), 10,20);
                if(metricId){
                     ctx.fillText(metricId, 180,20);
                }
                if(actReceivername){
                    ctx.fillText(actReceivername, 180, 120); 
                }
                ctx.fillText(rcAcptDt, 150, 140);
                ctx.globalCompositeOperation = 'destination-over';
                ctx.fillStyle = "#ffffff";
                ctx.fillRect(0, 0, canvas.width, canvas.height);
                ctx.restore();
                var vSplit=document.getElementById("can").toDataURL().split(',')[1]; 
                var recordId = c.get("v.recordId");     
                console.log('setRsmLines123>>',c.get("v.setRsmLines"));
                h.request(c, 'updateShipmentConfirm', 
                               { 
                                   setInvoiceLines: c.get("v.setOpenInvoiceLines"),
                                   setOpInvoiceLines: c.get("v.setPendingInvoiceLines"),
                                   setRsmLines: c.get("v.setRsmLines"),
                                   setSlackNotesSM: c.get("v.setSM"),
                                   setReceiverName:c.find("actReceivername").get("v.value"),
                                   smRtypeName:c.find("smRtypeName").get("v.value"),
                                   base64Data:encodeURIComponent(vSplit),
                                   contentType:'image/jpg',
                                   recordId:recordId
                               }, function(r){ 
                                   
                                   
                                   h.eraseHelper(c, e, h);
                                   c.set('v.message',r.message);
                                   if(r.message){
                                       h.error({ message:c.get('v.message') });  
                                       
                                   }else{
                                       var element_btnSec = document.getElementsByClassName("btnSec");
                                       element_btnSec[0].style.display = 'none';
                                       var element_fltright = document.getElementsByClassName("fltright");
                                       element_fltright[0].style.display = 'none';
                                       h.success({ message:'Ship confirmed successfully' });  
                                       
                                       var shmainDate = c.find("shmainDate").get("v.value");
                                      var ckInvoice =c.get("v.invoiceCheck");
                              if(ckInvoice)
                              {
                                  window.setTimeout(function(){
                                            var a = c.get('c.createInvoicePdf');
                                            $A.enqueueAction(a);
                                   //   c.set('v.openCreateInvoicePopup',true);
                                  }, 3000); 
                              }else{
                                window.setTimeout(
                                           $A.getCallback(function() {
                                               var navigateEvent = $A.get("event.force:navigateToComponent");
                                               navigateEvent.setParams({
                                                   componentDef: "c:ShipConfirmRsmTsm",
                                                   componentAttributes :{ 
                                                       shredirectDate:shmainDate ,
                                                       soId:c.get("v.soId"),
                                                   }
                                               });
                                               navigateEvent.fire();
                                           }), 3000
                                       );  
                                       
                                       window.setTimeout(
                                           $A.getCallback(function() {
                                               location.reload()
                                           }), 3500
                                       );
                              }
                           
                                   
                                   }
                               });
            }
    },
    countChar: function(c, e, h) {
        var slacknotes= e.getSource().get("v.value");
         var len = slacknotes.length;
        if (len >= 100) {
            h.error({ message:'Slack Notes: Reached max char limit (100)' });  
        } 
        
       
    },
    onInvocieCancel : function(c, e, h) {
        
        var salesOrderId = c.get("v.soId"); alert(salesOrderId);
        if(salesOrderId)
            h.request(c, 'updateBqAndOrderLineItems', {soId:salesOrderId}, function(r){
                
                window.setTimeout(
                    $A.getCallback(function() {
                        c.set("v.soId",'');
                    }), 5000
                );
                
            });
        
        var shmainDate = c.find("shmainDate").get("v.value");
        var navigateEvent = $A.get("e.force:navigateToComponent");
        navigateEvent.setParams({
            componentDef: "c:ShipConfirmRsmTsm",
            isredirect: true,
            //You can pass attribute value from Component2 to Component1
            componentAttributes :{ 
                shredirectDate:shmainDate,
                isredirect: true,
                soId:''
            }
        });
        navigateEvent.fire();
    },
    showSpinner: function(c, e, h) {
        // make Spinner attribute true for display loading spinner 
        c.set("v.Spinner", true); 
    },
    hideSpinner : function(c,e,h){
        // make Spinner attribute to false for hide loading spinner    
        c.set("v.Spinner", false);
    },
    Init : function(c, e, h) {
        h.loadSigpad(c, e, h);
    },
    onErase:function(c, e, h){
        
        h.eraseHelper(c, e, h);
        h.loadSigpad(c, e, h);
        
    },onChangeRcName:function (c, e, h) {
        
        var rcontactName= e.getSource().get("v.value");
        c.find("actReceivername").set("v.value",rcontactName);
    },
    onCancel : function(c, e, h) {
       
        var shmainDate = c.find("shmainDate").get("v.value");
        var navigateEvent = $A.get("e.force:navigateToComponent");
        navigateEvent.setParams({
            componentDef: "c:ShipConfirmRsmTsm",
            isredirect: true,
            //You can pass attribute value from Component2 to Component1
            componentAttributes :{ 
                shredirectDate:shmainDate,
                isredirect: true,
                  soId:'',
            }
        });
        navigateEvent.fire();
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
        var rcId = c.get("v.recordId");
        urlEvent.setParams({
            "url": "/apex/InvoicePDFshipManifest?id="+rcId+"&page=DriverScreen",
            redirect:true,
            
        });
        urlEvent.fire();
    }
        
})