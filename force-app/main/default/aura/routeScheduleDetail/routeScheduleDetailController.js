({

    doInit: function(c, e, h){
        
       // alert(c.get("v.recordId"));
        h.request(c, 'getDataLight', {recordId: c.get("v.recordId")}, function(r){
            c.set('v.setRouteSchedule', r.setRouteSchedule);
                        console.log('setRouteSchedul>>', r.setRouteSchedule.Vehicle__c);
             if(r.setRouteSchedule.Vehicle__c){
                c.set('v.selectedVehicle',{label:r.setRouteSchedule.Vehicle__r.Name,value:r.setRouteSchedule.Vehicle__c});
            } 
            if(r.setRouteSchedule.Driver__c){
                c.set('v.selectedDriver',{label:r.setRouteSchedule.Driver__r.Name,value:r.setRouteSchedule.Driver__c});
           }
              c.set('v.setRsmLines', r.setRsmLines);
            var getSizeOfRouteItem = r.setRsmLines;
          
             c.set('v.rowsCount', getSizeOfRouteItem.length);
            
                window.setTimeout(function(){
                    
               myFunction();
                    
                    
                    
                   
                    
            }, 2000);

                                               
         });
        
       
        
        function myFunction() {
  const previousRow = {};
  const colsChanged = {};
  let dark = false;
            var strr;

  Array.from(document.querySelectorAll('tbody tr')).forEach((tr, rowIdx) => {
    Array.from(tr.children).forEach((td, colIdx) => {
    
      if (rowIdx > 0 && previousRow[colIdx].text === td.innerText) {
       strr = previousRow[5].text;
      //alert(strr)
     // alert(previousRow[colIdx].text);
        previousRow[colIdx].elem.setAttribute('rowspan', ++previousRow[colIdx].span);
        colsChanged[colIdx] = false;
        td.remove();
      } else {
        previousRow[colIdx] = { span: 1, text: td.innerText, elem: td, dark };
        colsChanged[colIdx] = true;
      }
    });
    const rowChanged = Object.values(colsChanged).every(Boolean);
    dark = rowChanged && rowIdx > 0 ? !dark : dark;
    if (dark) {
      tr.classList.add('dark');
    }
  });
} 
        
      

      
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
      //  h.applyDataTable(c,e);
    },onSave: function(c, e, h){
        
        console.log(c.get("v.recordId"));
        
             var selectedOption = e.getSource().get("v.label");
         

        var noError = 'True';
             if((c.get('v.selectedDriver') == '')){
            h.error({message: 'Driver name is required.'}); 
             noError = 'False';
        }
        if((c.get('v.selectedVehicle') === '')){
            h.error({message: 'vehicle name is required.'});
            noError = 'False';
        }
   //alert(noError);
      // alert( c.find("shmainDate").get("v.value") );
        var selectedDate = c.find("shmainDate").get("v.value");
        if( noError == 'True'){
            
                h.request(c, 'assignDriverVehicle', 
                          {  recordId:  c.get("v.recordId"),driverId: c.find("dname").get("v.value"),vehicleId:c.find("vName").get("v.value"),rDate:selectedDate,selectedOption:selectedOption  }, function(r){ 
            
                              console.log('>>>>',r);
                              if(r){
                                  var savedVal = true;
                                  if(r.errorMessage=='driverExists')
                                  {
                                      savedVal = false;
                                      var toastEvent = $A.get("e.force:showToast");
                                      toastEvent.setParams({
                                          title : 'Error',
                                          message: 'Driver already assigned.',
                                          duration:' 5000',
                                          key: 'info_alt',
                                          type: 'Error',
                                          mode: 'pester'
                                      });
                                      toastEvent.fire();    
                                  }
                              if(r.errorMessage=='vehicleExists')
                                  {
                                      savedVal= false;
                                      var toastEvent = $A.get("e.force:showToast");
                                      toastEvent.setParams({
                                          title : 'Error',
                                          message: 'Vehicle already assigned.',
                                          duration:' 5000',
                                          key: 'info_alt',
                                          type: 'Error',
                                          mode: 'pester'
                                      });
                                      toastEvent.fire();    
                                  }
                                  if(savedVal == true)
                                  {
                                      if(selectedOption =='Save'){
                                           h.success({ message:'Driver and Vehicle assigned successfully' });
                                      }else{
                                            h.success({ message:'Route published successfully' });
                                      }
                                         
                                      
                                     
                                  }
                             
                                  
                              }
                              /*
                                       if(r.message =='Inactive'){
                              var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Error',
                        message: 'Product in inactive state in QB',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'Error',
                        mode: 'pester'
                    });
                    toastEvent.fire();    
                 
                 
            }
               */               
                              
                              
                             
     
            });
        }
        
        
        
    },
    onPublish: function(c, e, h){
        
         var selectedDate= e.getSource().get("v.label");
        alert(selectedDate);
        
        console.log(c.get("v.recordId"));

        var noError = 'True';
             if((c.get('v.selectedDriver') == '')){
            h.error({message: 'Driver name is required.'}); 
             noError = 'False';
        }
        if((c.get('v.selectedVehicle') === '')){
            h.error({message: 'vehicle name is required.'});
            noError = 'False';
        }
   
       
        if( noError == 'True'){
            
                h.request(c, 'publishRoute', 
                               {  recordId:  c.get("v.recordId") }, function(r){ 
               h.success({ message:'Route published successfully' });
     
            });
        }
        
        
        
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
            }
            
        }
        
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
                                      c.set('v.openCreateInvoicePopup',true);
                                  }, 3000); 
                              }else{
                                window.setTimeout(
                                           $A.getCallback(function() {
                                               var navigateEvent = $A.get("event.force:navigateToComponent");
                                               navigateEvent.setParams({
                                                   componentDef: "c:ShipConfirmRsmTsm",
                                                   componentAttributes :{ 
                                                       shredirectDate:shmainDate 
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
                           
                                       /*window.setTimeout(
                                           $A.getCallback(function() {
                                               var navigateEvent = $A.get("event.force:navigateToComponent");
                                               navigateEvent.setParams({
                                                   componentDef: "c:ShipConfirmRsmTsm",
                                                   componentAttributes :{ 
                                                       shredirectDate:shmainDate 
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
                                       */
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
    onCancel : function(c, e, h) {
     
        var shmainDate = c.find("shmainDate").get("v.value");
        var navigateEvent = $A.get("e.force:navigateToComponent");
        navigateEvent.setParams({
            componentDef: "c:routeScheduleList",
            isredirect: true,
            //You can pass attribute value from Component2 to Component1
            componentAttributes :{ 
                shredirectDate:c.find("shmainDate").get("v.value"),
                isredirect: true
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
   onChangeRcName:function (c, e, h) {
        
        var rcontactName= e.getSource().get("v.value");
        c.find("actReceivername").set("v.value",rcontactName);
    },
  
    createInvoicePdf: function(c, e, h) {
        var urlEvent = $A.get("e.force:navigateToURL");
        var rcId = c.get("v.recordId");
        urlEvent.setParams({
            "url": "/apex/InvoicePDFshipManifest?id="+rcId+"&page=DriverScreen",
            redirect:true
        });
        urlEvent.fire();
    }
        
})