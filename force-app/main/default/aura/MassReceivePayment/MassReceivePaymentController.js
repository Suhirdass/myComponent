({
   
    handleChange: function (c, event) {
        var changeValue = event.getParam("value");
        if(changeValue == 'invoices')
        {
            c.set("v.invoice", true);   
            c.set("v.SuppliersBill", false);  
            c.set("v.setinvoice", 0);  
            c.set("v.invlength", false); 
            c.set("v.tableerror", false);  
            
            
        }else if(changeValue == 'SuppliersBills'){
            c.set("v.SuppliersBill", true);  
            c.set("v.invoice", false);
            c.set("v.setBilPays",0);  
            c.set("v.billlength", false);   
            c.set("v.tableerror", false);           
            
        }
       
    },
    onSelectAllChange: function(c, e, h) {
        c.set('v.isDataLoaded',true);
        var checkvalue = c.find("selectAll").get("v.checked"); 
        console.log(checkvalue);
        var setInventoryPositions = c.get("v.setinvoice");
        if(checkvalue == true){
            for(var i=0; i < setInventoryPositions.length; i++){
                setInventoryPositions[i].isSelected = true;
            }    
        } else {
            for(var i=0; i < setInventoryPositions.length; i++){
                setInventoryPositions[i].isSelected = false;
            }    
        }
        c.set('v.setinvoice',setInventoryPositions);
    },
         onSelectAllChangesupplier: function(c, e, h) {
             var checkvalue = c.find("selectAll").get("v.checked"); 
             console.log(c.get("v.isAllSelected"));
             var setInventoryPositions = c.get("v.setBilPays");
             if(checkvalue == true){
                 for(var i=0; i < setInventoryPositions.length; i++){
                     setInventoryPositions[i].isSelected = true;
                 }    
             } else {
                 for(var i=0; i < setInventoryPositions.length; i++){
                     setInventoryPositions[i].isSelected = false;
                 }    
             }
             c.set('v.setBilPays',setInventoryPositions);
    },
	Cancel: function (c, event) {
       $A.get('e.force:refreshView').fire();  
    },
 
     invcpyclientbank: function(c, e, h) {
         var setPurchaseOrderLines = c.get('v.setinvoice');
         
         for(var i=0; i<setPurchaseOrderLines.length; i++){
             setPurchaseOrderLines[i].BankRegRP = setPurchaseOrderLines[0].BankRegRP;
             
         }
         
         c.set('v.setinvoice',setPurchaseOrderLines);
     },
     invcpymemo: function(c, e, h) {
         
         var setPurchaseOrderLines = c.get('v.setinvoice');
         for(var i=0; i<setPurchaseOrderLines.length; i++){
             setPurchaseOrderLines[i].Paymentmemo = setPurchaseOrderLines[0].Paymentmemo;
             
         }
         c.set('v.setinvoice',setPurchaseOrderLines);
     },
     invcpyForm: function(c, e, h) {
       var setPurchaseOrderLines = c.get('v.setinvoice');
        for(var i=0; i<setPurchaseOrderLines.length; i++){
            setPurchaseOrderLines[i].labTestStat = setPurchaseOrderLines[0].labTestStat;
        }
          c.set('v.setinvoice',setPurchaseOrderLines);
     },
   invcpyRef: function(c, e, h) {
       var setPurchaseOrderLines = c.get('v.setinvoice');
        for(var i=0; i<setPurchaseOrderLines.length; i++){
            setPurchaseOrderLines[i].Reference = setPurchaseOrderLines[0].Reference;
        }
       
          c.set('v.setinvoice',setPurchaseOrderLines);
    },  
    
      onPageSizeChange : function(c, e, h) {
          let page = c.get('v.page');
          console.log(c.find("selectPageSize").get("v.value"));
          // c.set('v.alldata',setPurchaseOrderLines); 
          var setPurchaseOrderLines = c.get('v.alldata');
          
          
          var pageSize = c.find("selectPageSize").get("v.value");
          
          c.set("v.totalPages", Math.ceil(c.get('v.alldata').length/pageSize));
          
          
          // get size of all the records and then hold into an attribute "totalRecords"
          c.set("v.totalRecords", c.get("v.alldata").length);
          // set star as 0
          c.set("v.startPage",0);
          
          c.set("v.endPage",pageSize-1);
          var PaginationList = [];
          for(var i=0; i< pageSize; i++){
              if(c.get("v.alldata").length> i)
                  PaginationList.push(setPurchaseOrderLines[i]);    
          }
          c.set('v.setinvoice', PaginationList);   
          c.set('v.page ',1);
       
    },
    
    
      onPageSizeChangePO : function(c, e, h) {
          let page = c.get('v.page');
          console.log(c.find("selectPageSize").get("v.value"));
          // c.set('v.alldata',setPurchaseOrderLines); 
          var setPurchaseOrderLines = c.get('v.alldataPO');
          
          
          var pageSize = c.find("selectPageSize").get("v.value");
          
          c.set("v.totalPages", Math.ceil(c.get('v.alldataPO').length/pageSize));
          
          
          // get size of all the records and then hold into an attribute "totalRecords"
          c.set("v.totalRecords", c.get("v.alldata").length);
          // set star as 0
          c.set("v.startPage",0);
          
          c.set("v.endPage",pageSize-1);
          var PaginationList = [];
          for(var i=0; i< pageSize; i++){
              if(c.get("v.alldata").length> i)
                  PaginationList.push(setPurchaseOrderLines[i]);    
          }
          c.set('v.setinvoice', PaginationList);   
          c.set('v.page ',1);
       
    },
    
  
  POcpybank: function(c, e, h) {
       var setbillpays = c.get('v.setBilPays');
       
        for(var i=0; i<setbillpays.length; i++){
            setbillpays[i].BankReg = setbillpays[0].BankReg;
           
        }
       
          c.set('v.setBilPays',setbillpays);
     },
     POcpymemo: function(c, e, h) {
       var setbillpays = c.get('v.setBilPays');
        for(var i=0; i<setbillpays.length; i++){
            setbillpays[i].Paymentmemo = setbillpays[0].Paymentmemo;
        }
          c.set('v.setBilPays',setbillpays);
     },
     POcpyForm: function(c, e, h) {
       var setbillpays = c.get('v.setBilPays');
        for(var i=0; i<setbillpays.length; i++){
            setbillpays[i].labTestStat = setbillpays[0].labTestStat;
        }
          c.set('v.setBilPays',setbillpays);
     },
   POcpyRef: function(c, e, h) {
       var setbillpays = c.get('v.setBilPays');
        for(var i=0; i<setbillpays.length; i++){
            setbillpays[i].ReconcilitionNotes = setbillpays[0].ReconcilitionNotes;
        }
       
          c.set('v.setBilPays',setbillpays);
    },  
  
    SearchBillPay : function(c, e, h) {
        var searchInput = c.find("searchKnowledgeInputSB").get("v.value");
          var Rectypes = c.find("PORecTypes").get("v.value");
            c.set('v.searchTextvalidation', searchInput);
         c.set('v.searchTextvalidationrectype', Rectypes);
         if (c.get("v.searchTextvalidationrectype")) {
              
         }else{
             var toastEvent = $A.get("e.force:showToast");
                 toastEvent.setParams({
                     title : 'Warning',
                     message: 'Please fill search values and RecordTypes',
                     duration:' 2000',
                     key: 'info_alt',
                     type: 'warning',
                     mode: 'pester'
                     
                 });
                 toastEvent.fire();
         }
         if (c.get("v.searchTextvalidation")) {
          }
          if (c.get("v.searchTextvalidation")) {
          }
        else{
        var toastEvent = $A.get("e.force:showToast");
                 toastEvent.setParams({
                     title : 'Warning',
                     message: 'Please fill search values and RecordTypes',
                     duration:' 2000',
                     key: 'info_alt',
                     type: 'warning',
                     mode: 'pester'
                     
                 });
                 toastEvent.fire();       
          }
             if(searchInput.length >= 3)
{ 
        h.request(c, 'BillPaysdetails', {searchText: searchInput,Recordstypes :Rectypes}, function(r){ 
         
             if(r.setBilPays.length >0)
            {
   c.set("v.billlength", true);   
                                c.set("v.tableerror", false); 
            }else{
                c.set("v.billlength", false); 
               c.set("v.tableerror", true);    
            }
            if(r.setBilPays == undefined ){
                var toastEvent = $A.get("e.force:showToast");
                 toastEvent.setParams({
                     title : 'Warning',
                     message: 'Please fill search values and RecordTypes',
                     duration:' 2000',
                     key: 'info_alt',
                     type: 'warning',
                     mode: 'pester'
                     
                 });
                 toastEvent.fire();   
          }
            
              c.set('v.getbank', r.getbank);

            console.log('r.getbank',r.getbank); 
            c.set('v.poData', r.BillPayData);
            c.set('v.setBilPays', r.setBilPays);
            console.log('r.setBilPays',r.setBilPays);
            c.set('v.getLabStatusData', r.getLabStatusData);
             
           	var result = c.get('v.getLabStatusData');
           	var labTestMap = [];
                for(var key in result){
                    labTestMap.push({key: key, value: result[key]});
                }
           c.set("v.labTestMap", labTestMap); 
   var resultrecs = c.get('v.getbank');
            console.log('resultrecs',resultrecs);
            var labTestMapbank = [];
            for(var key in resultrecs){
                labTestMapbank.push({key: key, value: resultrecs[key]});
            }
           c.set("v.labTestMapbank", labTestMapbank);
          var setPurchaseOrderLines = c.get('v.setBilPays');
            
              c.set('v.alldataPO',setPurchaseOrderLines);
                            var pageSize = c.get("v.pageSize");

                

                c.set("v.totalRecords", c.get("v.setBilPays").length);
                            c.set("v.totalPages", Math.ceil(c.get('v.alldataPO').length/c.get("v.pageSize")));

                c.set("v.startPage",0);
                 
                c.set("v.endPage",pageSize-1);
                var PaginationList = [];
                for(var i=0; i< pageSize; i++){
                    if(c.get("v.setBilPays").length> i)
                        PaginationList.push(setPurchaseOrderLines[i]);    
                }
                c.set('v.setBilPays', PaginationList);
            
              /*var setpo = c.get('v.setBilPays');
            
              c.set('v.alldataPO',setpo);
                            var pageSize = c.get("v.pageSize");

                

             // get size of all the records and then hold into an attribute "totalRecords"
                c.set("v.totalRecords", c.get("v.setinvoice").length);
                // set star as 0
                c.set("v.startPage",0);
                 
                c.set("v.endPage",pageSize-1);
                var PaginationList = [];
                for(var i=0; i< pageSize; i++){
                    if(c.get("v.setBilPays").length> i)
                        PaginationList.push(setpo[i]);    
                }
                c.set('v.setBilPays', PaginationList);   
                 c.set("v.totalPages", Math.ceil(c.get('v.alldataPO').length/c.get("v.pageSize")));*/

          var checkboxes = c.find("selectAll");
if(checkboxes && !checkboxes.length) { // is an object, not an Array
    checkboxes = [checkboxes]; // Make this an array
}
if(checkboxes) {
  // Uncheck all boxes //
    checkboxes.forEach(function(c){
        c.set("v.checked", false);
    });  
}   
            
            
 
        });
    
    
}  else{
     
}
    },
      FetchRP : function(c, e, h) {
        var searchInput = c.find("searchKnowledgeInput").get("v.value");
          var Rectypes = c.find("warehouse").get("v.value");
            c.set('v.searchTextvalidation', searchInput);
           c.set('v.searchTextvalidationrectype', Rectypes);
          
          
          
          
         if (c.get("v.searchTextvalidationrectype")) {
              
         }else{
             var toastEvent = $A.get("e.force:showToast");
                 toastEvent.setParams({
                     title : 'Warning',
                     message: 'Please fill search values and RecordTypes',
                     duration:' 2000',
                     key: 'info_alt',
                     type: 'warning',
                     mode: 'pester'
                     
                 });
                 toastEvent.fire();
         }
          if (c.get("v.searchTextvalidation")) {
          }else{
        var toastEvent = $A.get("e.force:showToast");
                 toastEvent.setParams({
                     title : 'Warning',
                     message: 'Please fill search values and RecordTypes',
                     duration:' 2000',
                     key: 'info_alt',
                     type: 'warning',
                     mode: 'pester'
                     
                 });
                 toastEvent.fire();       
          }
       
     if(searchInput.length >= 3)
{    
        h.request(c, 'RPdetails', {searchText: searchInput,Recordstypes :Rectypes}, function(r){ 
         
                c.set('v.BankRegister', r.contacts);
            
             console.log('contacts',r.contacts);
            
               if(r.setinvoice.length >0)
            {
   c.set("v.invlength", true);   
                c.set("v.tableerror", false); 
            }else{
                c.set("v.invlength", false); 
               c.set("v.tableerror", true);    
            }
              if(r.setinvoice == undefined ){
                var toastEvent = $A.get("e.force:showToast");
                 toastEvent.setParams({
                     title : 'Warning',
                     message: 'Please fill search values and RecordTypes',
                     duration:' 2000',
                     key: 'info_alt',
                     type: 'warning',
                     mode: 'pester'
                     
                 });
                 toastEvent.fire();  
          }
            c.set("v.loaded",false);
            c.set('v.RPDatas', r.RPData);
            c.set('v.setinvoice', r.setinvoice);
            console.log('r.setinvoice',r.setinvoice);
            c.set('v.getLabStatusDataRP', r.getLabStatusDataRP);
            c.set('v.getRecordTypesRP', r.getRecordTypesRP);
                        c.set('v.getbank', r.getbank);

            console.log('r.getbank',r.getbank);
            console.log(' r.getRecordTypesRP)', r.getRecordTypesRP);
            var result = c.get('v.getLabStatusDataRP');
            var labTestMap = [];
            for(var key in result){
                labTestMap.push({key: key, value: result[key]});
            }
            c.set("v.labTestMap", labTestMap); 
            
            var resultrec = c.get('v.getRecordTypesRP');
            var labTestMapRP = [];
            for(var key in resultrec){
                labTestMapRP.push({key: key, value: resultrec[key]});
            }
           c.set("v.labTestMapRP", labTestMapRP); 
            
            var resultrecs = c.get('v.getbank');
            console.log('resultrecs',resultrecs);
            var labTestMapbank = [];
            for(var key in resultrecs){
                labTestMapbank.push({key: key, value: resultrecs[key]});
            }
           c.set("v.labTestMapbank", labTestMapbank);
                var setPurchaseOrderLines = c.get('v.setinvoice');
            
              c.set('v.alldata',setPurchaseOrderLines);
                            var pageSize = c.get("v.pageSize");

                

                c.set("v.totalRecords", c.get("v.setinvoice").length);
                            c.set("v.totalPages", Math.ceil(c.get('v.alldata').length/c.get("v.pageSize")));

                c.set("v.startPage",0);
                 
                c.set("v.endPage",pageSize-1);
                var PaginationList = [];
                for(var i=0; i< pageSize; i++){
                    if(c.get("v.setinvoice").length> i)
                        PaginationList.push(setPurchaseOrderLines[i]);    
                }
                c.set('v.setinvoice', PaginationList);
             var checkboxes = c.find("selectAll");
if(checkboxes && !checkboxes.length) { // is an object, not an Array
    checkboxes = [checkboxes]; // Make this an array
}
if(checkboxes) {
  // Uncheck all boxes //
    checkboxes.forEach(function(c){
        c.set("v.checked", false);
    });  
}   
        });
}
    },
   next: function (component, event, helper) {
        var anyCheckSelected = 'false';
          var setPurchaseOrderLines = component.get('v.setinvoice');
       setPurchaseOrderLines.forEach(function (poli, index){
           if(poli.isSelected){
               anyCheckSelected = 'true';
           }
          
       });
         if(anyCheckSelected == 'true'){
                 var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
        title : 'Warning',
            message: 'previous selected  data wil lost ',
            duration:' 5000',
            key: 'info_alt',
            type: 'warning',
            mode: 'pester'
      
    });
    toastEvent.fire();  
         }else{
          helper.next(component, event);   
         }       
        
    },
    previous: function (component, event, helper) {
          var anyCheckSelected = 'false';
          var setPurchaseOrderLines = component.get('v.setinvoice');
       setPurchaseOrderLines.forEach(function (poli, index){
           if(poli.isSelected){
               anyCheckSelected = 'true';
           }
          
       });
         if(anyCheckSelected == 'true'){
                 var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
        title : 'Warning',
            message: 'previous selected  data wil lost ',
            duration:' 5000',
            key: 'info_alt',
            type: 'warning',
            mode: 'pester'
      
    });
    toastEvent.fire();  
         }else{
             helper.previous(component, event);
         }
    } ,
    
    nextPO: function (component, event, helper) {
          var anyCheckSelected = 'false';
          var setPurchaseOrderLines = component.get('v.setBilPays');
       setPurchaseOrderLines.forEach(function (poli, index){
           if(poli.isSelected){
               anyCheckSelected = 'true';
           }
          
       });
         if(anyCheckSelected == 'true'){
                 var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
        title : 'Warning',
            message: 'previous selected  data wil lost ',
            duration:' 5000',
            key: 'info_alt',
            type: 'warning',
            mode: 'pester'
      
    });
    toastEvent.fire();  
         }else{
        helper.nextPO(component, event);
         }
    },
    previousPO: function (component, event, helper) {
          var anyCheckSelected = 'false';
          var setPurchaseOrderLines = component.get('v.setBilPays');
       setPurchaseOrderLines.forEach(function (poli, index){
           if(poli.isSelected){
               anyCheckSelected = 'true';
           }
          
       });
         if(anyCheckSelected == 'true'){
                 var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
        title : 'Warning',
            message: 'previous selected  data wil lost ',
            duration:' 5000',
            key: 'info_alt',
            type: 'warning',
            mode: 'pester'
      
    });
    toastEvent.fire();  
         }else{
        helper.previousPO(component, event);
         }
    } ,
   
   CreateBilpays: function(c, e, h) {
       
       var anyCheckSelected = 'false';
       var payform = 'false';
       var amt = 'false';
       var PayMemo = 'false';
       var ref = 'false';
      var Amt = 'false';
       var bank = 'false';
       var setPurchaseOrderLines = c.get('v.setBilPays');
       setPurchaseOrderLines.forEach(function (poli, index){
           if(poli.isSelected){
               anyCheckSelected = 'true';
           }
           if(poli.labTestStat=="" && poli.isSelected){
               payform = 'true';   
           }if(poli.recQty==0 && poli.isSelected){
               amt = 'true';     
           }if(poli.Paymentmemo=="" && poli.isSelected){
               PayMemo = 'true';     
           }
        /* if( poli.recQty  > poli.	SB.Bill_Amount__c && poli.isSelected){
               highamt = 'true';     
           }*/
           if( poli.BankReg =="" && poli.isSelected){
               bank = 'true';     
           }if( poli.recQty =="" && poli.isSelected){
               Amt = 'true';     
           }
           
       });
       if(anyCheckSelected == 'false'){
           var toastEvent = $A.get("e.force:showToast");
           toastEvent.setParams({
               title : 'Warning',
               message: 'Please select PO to create Bill Pay.',
               duration:' 2000',
               key: 'info_alt',
               type: 'warning',
               mode: 'pester'
               
           });
           toastEvent.fire();   
       }else if(payform == 'true'){
           var toastEvent = $A.get("e.force:showToast");
           toastEvent.setParams({
               title : 'Warning',
               message: 'Please select Payment Form.',
               duration:' 2000',
               key: 'info_alt',
               type: 'warning',
               mode: 'pester'
               
           });
           toastEvent.fire();   
       }else if(amt== 'true'){
           var toastEvent = $A.get("e.force:showToast");
           toastEvent.setParams({
               title : 'Warning',
               message: 'Please enter amount.',
               duration:' 2000',
               key: 'info_alt',
               type: 'warning',
               mode: 'pester'
               
           });
           toastEvent.fire();      
       }else if(PayMemo== 'true'){
           var toastEvent = $A.get("e.force:showToast");
           toastEvent.setParams({
               title : 'Warning',
               message: 'Please enter Payment Memo.',
               duration:' 2000',
               key: 'info_alt',
               type: 'warning',
               mode: 'pester'
               
           });
           toastEvent.fire();      
       }else if(bank== 'true'){
           var toastEvent = $A.get("e.force:showToast");
           toastEvent.setParams({
               title : 'Warning',
               message: 'Please select Bank Register',
               duration:' 2000',
               key: 'info_alt',
               type: 'warning',
               mode: 'pester'
               
           });
           toastEvent.fire();      
       }else if(Amt=='true'){
             var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
        title : 'Warning',
            message: 'Please provide Amount',
            duration:' 5000',
            key: 'info_alt',
            type: 'warning',
            mode: 'pester'
      
    });
    toastEvent.fire();      
         }
           else{
               
               h.request(c, 'CreatebillPays', { setPurchaseOrderLines: c.get("v.setBilPays") }, function(r){
                   var toastEvent = $A.get("e.force:showToast");
                   
                   toastEvent.setParams({
                       title : 'Success',
                       message: 'BillPay Created Sucessfully.',
                       duration:' 2000',
                       key: 'info_alt',
                       type: 'success',
                       mode: 'pester'
                   });
                   
                   
                   toastEvent.fire();       
                   $A.get('e.force:refreshView').fire();
               });     
               
               
           }
       
    
       
      
    },  
    CreateRPinv: function(c, e, h) {
        
        var anyCheckSelected = 'false';
        var payform = 'false';
        var amt = 'false';
        var PayMemo = 'false';
        var ref = 'false';
       // var highamt = 'false';
        var bank = 'false';
        var RecType = 'false';
        var Amt = 'false';
        var setPurchaseOrderLines = c.get('v.setinvoice');
       setPurchaseOrderLines.forEach(function (poli, index){
           if(poli.isSelected){
               anyCheckSelected = 'true';
           }
           if(poli.labTestStat=="null" && poli.isSelected){
               payform = 'true';   
           }if(poli.recQty==0 && poli.isSelected){
               amt = 'true';     
           }if(poli.Paymentmemo=="" && poli.isSelected){
               PayMemo = 'true';     
           }if(poli.Reference=="" && poli.isSelected){
               ref = 'true';     
           }/*if( poli.recQty  > poli.inv.Invoice_Balance__c && poli.isSelected){
               highamt = 'true';     
           }*/if( (poli.BankRegRP =="" || poli.BankRegRP =='null') && poli.isSelected){
              bank = 'true';     
           }if( poli.RecordType =="" && poli.isSelected){
               RecType = 'true';     
           }if( poli.recQty =="" && poli.isSelected){
               Amt = 'true';     
           }
       });
         if(anyCheckSelected == 'false'){
                 var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
        title : 'Warning',
            message: 'Please select Invoice to create Receive Payment.',
            duration:' 5000',
            key: 'info_alt',
            type: 'warning',
            mode: 'pester'
      
    });
    toastEvent.fire();   
         }else if(payform == 'true'){
          var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
        title : 'Warning',
            message: 'Please select payment form',
            duration:' 5000',
            key: 'info_alt',
            type: 'warning',
            mode: 'pester'
      
    });
    toastEvent.fire();   
         }else if(PayMemo== 'true'){
             var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
        title : 'Warning',
            message: 'Please enter Payment Memo.',
            duration:' 5000',
            key: 'info_alt',
            type: 'warning',
            mode: 'pester'
      
    });
    toastEvent.fire();      
         }else if(ref== 'true'){
             var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
        title : 'Warning',
            message: 'Please enter Reference',
            duration:' 5000',
            key: 'info_alt',
            type: 'warning',
            mode: 'pester'
      
    });
    toastEvent.fire();      
         }else if(RecType== 'true'){
             var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
        title : 'Warning',
            message: 'Please Select Record Type',
            duration:' 5000',
            key: 'info_alt',
            type: 'warning',
            mode: 'pester'
      
    });
    toastEvent.fire();      
         }else if(bank=='true'){
             var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
        title : 'Warning',
            message: 'Please select Bank Register',
            duration:' 5000',
            key: 'info_alt',
            type: 'warning',
            mode: 'pester'
      
    });
    toastEvent.fire();      
         }else if(Amt=='true'){
             var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
        title : 'Warning',
            message: 'Please provide Amount',
            duration:' 5000',
            key: 'info_alt',
            type: 'warning',
            mode: 'pester'
      
    });
    toastEvent.fire();      
         }
       else{
              h.request(c, 'CreateRP', { setrpdatas: c.get("v.setinvoice") }, function(r){
                      var toastEvent = $A.get("e.force:showToast");
	//var selectedIds = e.getParam("selectedIds");
         toastEvent.setParams({
            title : 'Success',
            message: 'ReceivePayment Created Sucessfully.',
            duration:' 5000',
            key: 'info_alt',
            type: 'success',
            mode: 'pester'
        });
        
     
    toastEvent.fire();       
          $A.get('e.force:refreshView').fire();
        }); 
       }    
        
  
    },
    invoiceSorting: function(c, e, h) {
       //  c.set("v.spinner",true); 
               var id = e.currentTarget.dataset.id; //it will return thisDiv

          h.request(c, 'res',{}, function(r){
  c.set("v.loaded",false);
                     

        var n ;
        
        if(id=='firstRow'){
            n=1;
        }else  if(id=='fifthRow'){
            n=6;
        }
        
        //  var selectedDate= e.getSource().get("v.value");
        
        var table;
        table = document.getElementById("invoiceTable");
        var rows, i, x, y, count = 0;
        var switching = true;
        
        // Order is set as ascending
        var direction = "descending";
      
        // Run loop until no switching is needed
        while (switching) {
            switching = false;
            var rows = table.rows;
            
            //Loop to go through all rows
            for (i = 1; i < (rows.length - 1); i++) {
                var Switch = false;
                
                // Fetch 2 elements that need to be compared
                x = rows[i].getElementsByTagName("TD")[n];
                y = rows[i + 1].getElementsByTagName("TD")[n];
                // Check the direction of order
                if (direction == "ascending") {
                   c.set('v.direction','ASC');     
                    // Check if 2 rows need to be switched
                    if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase())
                    {
                        // If yes, mark Switch as needed and break loop
                        Switch = true;
                        break;
                    } 
                } else if (direction == "descending") {
                    // c.set("v.spiner",true);  
                    c.set('v.direction','DESC');  
                    
                    // Check direction
                    if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase())
                    {
                        // If yes, mark Switch as needed and break loop
                        Switch = true;
                        break;
                    }
                }
            }
            if (Switch) {
                // Function to switch rows and mark switch as completed
                rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                switching = true;
                
                // Increase count for each switch
                count++;
            } else {
                // Run while loop again for descending order
                if (count == 0 && direction == "ascending") {
                    direction = "descending";
                    switching = true;
                }
            }
        }
       });       
    },
     poSorting: function(c, e, h) {
       //  c.set("v.spinner",true); 
               var id = e.currentTarget.dataset.id; //it will return thisDiv

          h.request(c, 'res',{}, function(r){
  c.set("v.loaded",false);
                     

        var n ;
        
        if(id=='firstRow'){
            n=1;
        }else  if(id=='fourthRow'){
            n=5;
        }
        
        //  var selectedDate= e.getSource().get("v.value");
        
        var table;
        table = document.getElementById("poTable");
        var rows, i, x, y, count = 0;
        var switching = true;
        
        // Order is set as ascending
        var direction = "ascending";
        
        // Run loop until no switching is needed
        while (switching) {
            switching = false;
            var rows = table.rows;
            
            //Loop to go through all rows
            for (i = 1; i < (rows.length - 1); i++) {
                var Switch = false;
                
                // Fetch 2 elements that need to be compared
                x = rows[i].getElementsByTagName("TD")[n];
                y = rows[i + 1].getElementsByTagName("TD")[n];
                // Check the direction of order
                if (direction == "ascending") {
                   c.set('v.direction','ASC');     
                    // Check if 2 rows need to be switched
                    if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase())
                    {
                        // If yes, mark Switch as needed and break loop
                        Switch = true;
                        break;
                    } 
                } else if (direction == "descending") {
                    // c.set("v.spiner",true);  
                    c.set('v.direction','DESC');  
                    
                    // Check direction
                    if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase())
                    {
                        // If yes, mark Switch as needed and break loop
                        Switch = true;
                        break;
                    }
                }
            }
            if (Switch) {
                // Function to switch rows and mark switch as completed
                rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                switching = true;
                
                // Increase count for each switch
                count++;
            } else {
                // Run while loop again for descending order
                if (count == 0 && direction == "ascending") {
                    direction = "descending";
                    switching = true;
                }
            }
        }
       });       
    },

    
    
    
    
    	
})