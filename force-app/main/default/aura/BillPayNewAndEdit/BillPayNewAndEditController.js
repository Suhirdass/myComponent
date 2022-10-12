({
     onScriptsLoaded : function(c, e, h) {
        c.set('v.isScriptsLoaded',true);
        h.applyDataTable(c,e);
    },
	  doInit : function(c, e, h) {
        h.request(c, 'billPayNewAndEdit',{recordId: c.get('v.recordId'),SBIds: c.get("v.SupplierId")}, function(r){
               c.set('v.isDataLoaded',true);
           c.set("v.SBObj",r.lstinvoice);
            c.set("v.SBObjName", c.get("v.SBObj[0].Name"));
                        c.set("v.POObjName", c.get("v.SBObj[0].Purchase_Order__r.Name"));

            c.set("v.billPayObj",r.records);
           
            if(r.records.Supplier_Bill__c){
             c.set("v.billPayObj.Supplier_Bill__c",r.records.Supplier_Bill__c);   
            }else{
                c.set("v.billPayObj.Supplier_Bill__c",'');
            }
             if(r.records.Purchase_Order__c){
             c.set("v.billPayObj.Purchase_Order__c",r.records.Purchase_Order__c);   
            }else{
                c.set("v.billPayObj.Purchase_Order__c",'');
            }
            c.set("v.associatedBank",r.associatedBank);
                          console.log('r.bankDetails>>',r.associatedBank);

            c.set("v.bankDetails",r.bankDetails);
            c.set("v.selectedBankRegisterId",r.selectedBankRegisterId);
            c.set("v.rpPrefix",r.rpPrefix);
          
            if(r.records.Invoice__c){
                c.set('v.selectedBill',{label:r.records.Supplier_Bill__r.Name,value:r.records.Supplier_Bill__c});
            }
            if(c.get('v.billPayObj.Payment_Date__c') == null)
            {
              var today = $A.localizationService.formatDate(new Date(), "YYYY-MM-DD");
            c.set('v.billPayObj.Payment_Date__c', today);    
            }
             var Payvalidate = c.find('Payvalidate');
            if(Payvalidate)
            var selectValue= c.find('Payvalidate').get('v.value');
            if(selectValue == 'Credit Card' || selectValue == 'Debit Card' ){
                c.set("v.showdiv", true);
                c.set("v.showdivBank", true);
                
                
            }else if(selectValue == 'Check' || selectValue == 'ACH' )
            {
                c.set("v.showdiv", false);
                c.set("v.showdivBank", true);   
            }
                else{
                    c.set("v.showdiv", false);
                    c.set("v.showdivBank", false);
                }
      
            var id = c.get("v.associatedBank.Account_Number__c");
            if(id != null && id != undefined){
                var str = id.toString();
                str = str.substring(str.length - 4);
                c.set("v.accName",'XXXXXXXX'+str);
            }
            var resultPay = r.paymentForm; var paymentForm = [];
            var resultBank = r.bankNames; var banks = [];
            var resultMonth = r.validMonths; var months = [];
            var resulyear = r.validyear; var year = [];
            
            paymentForm.push({key: '', value: '--None--'});
            banks.push({key: '', value: '--None--'});
            months.push({key: '', value: '--None--'});
            year.push({key: '', value: '--None--'});
          	var result = r.paymentForm;
           	var paymentForms = [];
                for(var key in result){
                    paymentForms.push({key: key, value: result[key]});
                }
           c.set("v.paymentForms", paymentForms);
            
            for(var key in resultBank){
                banks.push({key: resultBank[key].label, value: resultBank[key].value});
            }
            for(var key in resultMonth){
                months.push({key: resultMonth[key].label, value: resultMonth[key].value});
            }
            for(var key in resulyear){
                year.push({key: resulyear[key].label, value: resulyear[key].value});
            }
          //  c.set("v.paymentForms", paymentForm);
            c.set("v.bankNames", banks);
            c.set("v.validMonths", months);
            c.set("v.validyear", year);
        });	
        

    },
        //based on selction we show that  div values in UI
    mySelectPayform: function(component,helper,event){
        var selectValue= component.find('Payvalidate').get('v.value');
        if(selectValue == 'Credit Card' || selectValue == 'Debit Card' ){
            component.set("v.showdiv", true);
            component.set("v.showdivBank", true);
            
            
        }else if(selectValue == 'Check' || selectValue == 'ACH' )
        {
            component.set("v.showdiv", false);
            component.set("v.showdivBank", true);   
        }
            else{
                component.set("v.showdiv", false);
                component.set("v.showdivBank", false);
            }
    },
    
     doSaveAction : function(c, e, h) {
              var validateAmount = c.find('amounts');
        var isValidAmount = true;
        if (validateAmount) {
            isValidAmount = [].concat(validateAmount).reduce(function (validSoFarValidAmount, inputValidAmount) {
                var allValidAmount = true;
                if(inputValidAmount){
                    inputValidAmount.showHelpMessageIfInvalid();
                    var validity = inputValidAmount.get('v.validity');
                    if(validity)
                        allValidAmount = validity.valid;
                }
                return validSoFarValidAmount && allValidAmount;
            }, true);
        } 
        

        var validatedates = c.find('dates');
        var isValid6 = true;
        if (validatedates) {
            isValid6 = [].concat(validatedates).reduce(function (validSoFar6, input6) {
                var allValid6= true;
                if(input6){
                    input6.showHelpMessageIfInvalid();
                    var validity6 = input6.get('v.validity');
                    if(validity6)
                        allValid6 = validity6.valid;
                }
                return validSoFar6 && allValid6;
            }, true);
        }
      
       
        if(!isValidAmount)
            return false;
        c.set("v.loaded",true); 
        
        var errorFlag = 'false';
        c.set("v.validation", false); 
      
      
        
        var Payform = c.find("Payvalidate").get("v.value");
          if(Payform == null ||  Payform ==undefined || Payform =="" )
            {
                errorFlag = 'true';
                            h.error({ message: ('Please select Payment Form. ') });    
            } 
            else {
                
                c.set("v.payError", '');
            }
            console.log('r.SBObjName>>',c.get('v.SBObjName'));
         if(c.get('v.selectedSB') =="" && c.get('v.SBObjName') ==null){
           errorFlag = 'true';
                            h.error({ message: ('Please select Supplier Bill. ') });      
         }
                     console.log('r.records>>',c.get('v.selectedSB'));

         
        
  
        
        if(errorFlag == 'false')
        { 
       
            h.request(c, 'doSaveActionLight', {billPayObj: c.get('v.billPayObj'),selectedBankRegisterId :c.get('v.selectedBankRegisterId')}, function(r){
            console.log('r.records>>',c.get('v.selectedBankRegisterId'));
                var whichOne = e.getSource().getLocalId();
                if(r.Error != null && r.Error != undefined && r.Error != ''){
                    h.error({ message: r.Error });
                } else {
                    if(whichOne == 'Save'){
                        var navEvt = $A.get("e.force:navigateToSObject");
                        navEvt.setParams({
                            "recordId": r.record.Id,
                            "slideDevName": "detail"
                            
                        });
                        navEvt.fire(); 
                        window.parent.location = '/' + r.record.Id;
                        
                    }  else {
                        var selObj = c.get('v.billPayObj');
                        
                        var evt = $A.get("e.force:navigateToComponent");
                        evt.setParams({
                            componentDef : "c:BillPayNewAndEdit",
                            componentAttributes: {
                               
                            }
                        });
                        evt.fire();
                        
                     
                    }
                }  
            });
        }              
    },
     handleRadioClick : function(c, e, h) {
        var whichOne = e.currentTarget.dataset.value;
        c.set("v.selectedBankRegisterId",whichOne);
         console.log(c.get('v.selectedBankRegisterId'));
    },
    onCancel : function(c, e, h) {
     var cancelURL;
        
           if(c.get('v.billPayObj.Supplier_Bill__c') == null || c.get('v.billPayObj.Supplier_Bill__c') =="" )
            {
                                  window.location ='/a1X/o';  
     
            } else if(c.get('v.billPayObj.Supplier_Bill__c') != null){
              cancelURL = c.get('v.billPayObj.Supplier_Bill__c');
                h.navigateToRecord(c, cancelURL);
                  
            }
        else 
            {
                 window.location ='/a1X/o';  
            }
        
        
        
         /* if(c.get('v.billPayObj.Supplier_Bill__c') != null)
            {
                 cancelURL = c.get('v.billPayObj.Supplier_Bill__c');
                h.navigateToRecord(c, cancelURL);
               
            }else 
            {
             window.location ='/a1X/o';   
            }*/
        
        
       /* var ctarget = c.get('v.billPayObj');
          var rpPrefix = c.get('v.rpPrefix');
            if(ctarget.Id == null)
            {
             window.location ='/a1X/o';   
            }
        else if(ctarget.Id != null && ctarget.Id != undefined)
            {
                h.navigateToRecord(c, ctarget.Id);      
            }
        else if(ctarget.Bill_Pay__c != null && ctarget.Bill_Pay__c != undefined)
            {
                 var cancelURL;
            cancelURL = ctarget.Bill_Pay__c;
                h.navigateToRecord(c, cancelURL);     
            }*/
    },
    searchTable: function (cmp, event, helper) {
        var allRecords = cmp.get("v.bankDetails");
         console.log('allRecords',allRecords);
        var searchFilter = event.getSource().get("v.value").toUpperCase();
         if(searchFilter != undefined){
             
         
        var tempArray =[];
        var i;
        for(i=0; i<allRecords.length; i++){
            if((allRecords[i].bankRegisterSO.Account__r.Name && allRecords[i].bankRegisterSO.Account__r.Name.toUpperCase().indexOf(searchFilter) != -1) || 
               (allRecords[i].bankRegisterSO.Bank_Name__c && allRecords[i].bankRegisterSO.Bank_Name__c.toUpperCase().indexOf(searchFilter) != -1) || 
              (allRecords[i].bankRegisterSO.Account_Number__c && allRecords[i].bankRegisterSO.Account_Number__c.toUpperCase().indexOf(searchFilter) != -1)){
                
                tempArray.push(allRecords[i]);
            }
           
        }
              cmp.set("v.bankDetails",tempArray);
         }else{
          cmp.set("v.bankDetails",cmp.get("v.bankDetails"));    
         }   
    }
   
})