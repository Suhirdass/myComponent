({
     onScriptsLoaded : function(c, e, h) {
        c.set('v.isScriptsLoaded',true);
        h.applyDataTable(c,e);
    },
    doInit : function(c, e, h) {
        h.request(c, 'receivePaymentEditOverride',{recordId: c.get('v.recordId'),invoiceId: c.get("v.invoiceId"),recordTypesId: c.get('v.recordTypeId'),billId : c.get('v.billId')}, function(r){
            //  h.applyDataTable(c,e);
            c.set('v.isDataLoaded',true);
          
            
            if(r.lstinvoice.length > 0){
                if(r.lstinvoice[0].IsLocked__c){
                    c.set("v.isInvLocked",true);
                    h.error({ message: r.Validation_Msg_for_insert_update_RecePay });
                }
            }
            c.set("v.invoiceObj",r.lstinvoice);
            if(r.RPCreditMemo == true){
                c.set("v.rpcreditrec", true);
                
            }
            
            if(r.invRPCreditMemo == true){
                c.set("v.creditrec", r.invRPCreditMemo);
                
                c.set("v.InvoiceName", c.get("v.invoiceObj[0].Name"));
                
            }else{
                c.set("v.creditrec", r.invRPCreditMemo);
                c.set("v.rpcreditrec3", true);
                c.set("v.InvoiceName", null);
                c.set("v.selectedInvoice", null);
                
                
            }
            
            
            c.set("v.receivePaymentObj",r.records);
            if(r.records.Invoice__c){
                c.set("v.receivePaymentObj.Invoice__c",r.records.Invoice__c);   
            }else{
                c.set("v.receivePaymentObj.Invoice__c",'');
            }
            c.set("v.associatedBank",r.associatedBank);
               console.log(r.associatedBank);
            c.set("v.bankDetails",r.bankDetails);
            c.set("v.selectedBankRegisterId",r.selectedBankRegisterId);
            c.set("v.rpPrefix",r.rpPrefix);
            
            if(r.records.Invoice__c){
                c.set('v.selectedInvoice',{label:r.records.Invoice__r.Name,value:r.records.Invoice__c});
            }
            if(c.get('v.receivePaymentObj.Payment_Received_Date__c') == null)
            {
                var today = $A.localizationService.formatDate(new Date(), "YYYY-MM-DD");
                c.set('v.receivePaymentObj.Payment_Received_Date__c', today);    
            }
            
            
            c.set('v.receivePaymentObj.RecordTypeId', c.get("v.recordTypeId"));
            var selectValue= c.find('Payvalidate').get('v.value');
            if(selectValue == 'Credit Card' || selectValue == 'Debit Card'|| selectValue == 'Wire' ){
                c.set("v.showdiv", true);
                c.set("v.showdivBank", true);
                
                
            }else if(selectValue == 'Check' || selectValue == 'ACH'||selectValue == 'Wire' )
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
            
            
           /* for(var key in resultPay){
                paymentForm.push({key: resultPay[key].label, value: resultPay[key].value});
            }*/
            for(var key in resultBank){
                banks.push({key: resultBank[key].label, value: resultBank[key].value});
            }
            for(var key in resultMonth){
                months.push({key: resultMonth[key].label, value: resultMonth[key].value});
            }
            for(var key in resulyear){
                year.push({key: resulyear[key].label, value: resulyear[key].value});
            }
           // c.set("v.paymentForms", paymentForm);
            c.set("v.bankNames", banks);
            c.set("v.validMonths", months);
            c.set("v.validyear", year);
        });	
        
        
        
    },
    
    handleRadioClick : function(c, e, h) {
        var whichOne = e.currentTarget.dataset.value;
        c.set("v.selectedBankRegisterId",whichOne);
    },
    
    onCancel : function(c, e, h) {
     
        var ctarget = c.get('v.receivePaymentObj');
        
        console.log(c.get('v.selectedInvoice'));
        var cancelURL;
                
          var rpPrefix = c.get('v.rpPrefix');
            if(c.get('v.receivePaymentObj.Invoice__c') == null || c.get('v.receivePaymentObj.Invoice__c') =="" )
            {
                  window.location ='/a0s/o';        
            } else if(c.get('v.receivePaymentObj.Invoice__c') != null){
              cancelURL = c.get('v.receivePaymentObj.Invoice__c');
                h.navigateToRecord(c, cancelURL);
                  
            }
        else 
            {
                window.location ='/a0s/o';    
            }
      
    },	
    
    //based on selction we show that  div values in UI
    mySelectPayform: function(component,helper,event){
        var selectValue= component.find('Payvalidate').get('v.value');
        if(selectValue == 'Credit Card' || selectValue == 'Debit Card' ){
            component.set("v.showdiv", true);
            component.set("v.showdivBank",true);
            
            
        }else if(selectValue == 'Check' || selectValue == 'ACH'|| selectValue == 'Wire' )
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
        
       
        
        
    
     

        var validatebankvalidate = c.find('bankvalidate');
        var isValid5 = true;
        if (validatebankvalidate) {
            isValid5 = [].concat(validatebankvalidate).reduce(function (validSoFar5, input5) {
                var allValid5 = true;
                if(input5){
                    input5.showHelpMessageIfInvalid();
                    var validity5 = input5.get('v.validity');
                    if(validity5)
                        allValid5 = validity5.valid;
                }
                return validSoFar5 && allValid5;
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
      
        if(!isValid5)
            return false;
        c.set("v.loaded",true); 
        if(!isValidAmount)
            return false;
        c.set("v.loaded",true); 
        
        var errorFlag = 'false';
        c.set("v.validation", false); 
     var invrec= c.get("v.invoiceId")
      
        
      var Payform = c.find("Payvalidate").get("v.value");
           if(Payform == null ||  Payform ==undefined || Payform =="" )
            {
                errorFlag = 'true';
                            h.error({ message: ('Please select Payment Form. ') });    
            } 
            else {
                
                c.set("v.payError", '');
            }
        
  
        if(Payform == 'Check' || Payform == 'ACH' || Payform == 'Credit Card' ||  Payform == 'Debit Card' || Payform == 'Wire' ) 
        {
            var Bank = c.find("bankvalidate").get("v.value");
            
            if(Bank == null ||  Bank ==undefined || Bank =="" )
            {
                errorFlag = 'true';
                c.set("v.validation", true);
                c.set("v.nameError", 'Complete this field');
            } 
            else {
                
                c.set("v.nameError", '');
            }
        }
            console.log('r.selectedInvoice>>',c.get('v.selectedInvoice'));
         if(c.get('v.selectedInvoice') ==null || c.get('v.selectedInvoice') ==""){
           errorFlag = 'true';
                            h.error({ message: ('Please select Invoice. ') });      
         }
                     console.log('r.records>>',c.get('v.selectedSB'));

       
        if(errorFlag == 'false')
        { 
                      
            h.request(c, 'doSaveActionLight', {receivePaymentObj: c.get('v.receivePaymentObj'),selectedBankRegisterId :c.get('v.selectedBankRegisterId')},   function(r){

                // 
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
                        
                    } else {
                        var selObj = c.get('v.receivePaymentObj');
                        
                        var evt = $A.get("e.force:navigateToComponent");
                        evt.setParams({
                            componentDef : "c:receivePaymentEditOverride",
                            componentAttributes: {
                               
                            }
                        });
                        evt.fire();
                     
                    }
                }  
            });
        }            
    },
    
})