({
	doInit : function(c, e, h) {
        console.log('doInit :',{recordId: c.get('v.recordId'),recordTypesId : c.get('v.recordTypeId'),invoiceId : c.get('v.invoiceId') ,billId : c.get('v.billId')}); 
		h.request(c, 'receivePaymentEditOverride', {recordId: c.get('v.recordId'),recordTypesId : c.get('v.recordTypeId'),invoiceId : c.get('v.invoiceId') ,billId : c.get('v.billId')}, function(r){
            console.log('Response:',r);
            c.set("v.receivePaymentObj",r.records);
            c.set("v.associatedBank",r.associatedBank);
            c.set("v.bankDetails",r.bankDetails);
            c.set("v.selectedBankRegisterId",r.selectedBankRegisterId); 
            c.set("v.rpPrefix",r.rpPrefix);
            
            if(r.records.Invoice__c){
                c.set('v.selectedInvoice',{label:r.records.Invoice__r.Name,value:r.records.Invoice__c});
            }
            if(r.records.Bill_Pay__c){
            	c.set('v.selectedBill',{label:r.records.Bill_Pay__r.Name,value:r.records.Bill_Pay__c});    
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

            for(var key in resultPay){
                paymentForm.push({key: resultPay[key].label, value: resultPay[key].value});
            }
            for(var key in resultBank){
                banks.push({key: resultBank[key].label, value: resultBank[key].value});
            }
            for(var key in resultMonth){
                months.push({key: resultMonth[key].label, value: resultMonth[key].value});
            }
            for(var key in resulyear){
                year.push({key: resulyear[key].label, value: resulyear[key].value});
            }
            c.set("v.paymentForms", paymentForm);
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
        if(ctarget.Id != null && ctarget.Id != undefined){
            h.navigateToRecord(c, ctarget.Id);              
        } else {
            var cancelURL;
            
            if(ctarget.Invoice__c != null && ctarget.Invoice__c != undefined){
                cancelURL = ctarget.Invoice__c;
            }else if(ctarget.Bill_Pay__c != null && ctarget.Bill_Pay__c != undefined){
                cancelURL = ctarget.Bill_Pay__c;
            } else {
                           //    window.location ='/a0s/o';

				cancelURL = c.get('v.rpPrefix');




            }
            h.navigateToRecord(c, cancelURL); 
        }
    },
    
    doSaveAction : function(c, e, h) {
        
        var validateFields = c.find('Creditnumvalidate');
        var isValid = true;
        if (validateFields) {
            isValid = [].concat(validateFields).reduce(function (validSoFar1, input1) {
                var allValid = true;
                if(input1){
                    input1.showHelpMessageIfInvalid();
                    var validity = input1.get('v.validity');
                    if(validity)
                        allValid = validity.valid;
                }
                return validSoFar1 && allValid;
            }, true);
        }
          
        
         var validateMonthvalidate = c.find('Monthvalidate');
        var isValid2 = true;
        if (validateMonthvalidate) {
            isValid2 = [].concat(validateMonthvalidate).reduce(function (validSoFar2, input2) {
                var allValid2 = true;
                if(input2){
                    input2.showHelpMessageIfInvalid();
                    var validity = input2.get('v.validity');
                    if(validity)
                        allValid2 = validity.valid;
                }
                return validSoFar2 && allValid2;
            }, true);
        }
        var validateyearvalidate= c.find('yearvalidate');
        var isValid3 = true;
        if (validateyearvalidate) {
            isValid3 = [].concat(validateyearvalidate).reduce(function (validSoFar3, input3) {
                var allValid3 = true;
                if(input3){
                    input3.showHelpMessageIfInvalid();
                    var validity3 = input3.get('v.validity');
                    if(validity3)
                        allValid3 = validity3.valid;
                }
                return validSoFar3 && allValid3;
            }, true);
        }
         var validatecodevalidate = c.find('codevalidate');
        var isValid4 = true;
        if (validatecodevalidate) {
            isValid = [].concat(validatecodevalidate).reduce(function (validSoFar4, input4) {
                var allValid4 = true;
                if(input4){
                    input4.showHelpMessageIfInvalid();
                    var validity4 = input4.get('v.validity');
                    if(validity4)
                        allValid4 = validity4.valid;
                }
                return validSoFar4 && allValid4;
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
         if(!isValid)
            return false;
        c.set("v.loaded",true);
        if(!isValid2)
            return false;
        c.set("v.loaded",true); 
         if(!isValid3)
            return false;
        c.set("v.loaded",true); 
         if(!isValid4)
            return false;
        c.set("v.loaded",true); 
         if(!isValid5)
            return false;
        c.set("v.loaded",true); 
         if(!isValid6)
            return false;
        c.set("v.loaded",true); 
         
  
        
        
        var errorFlag = 'false';
        c.set("v.validation", false); 
        
      
        
        var Payform = c.find("Payvalidate").get("v.value");
        
       

        if(Payform == 'Check' || Payform == 'ACH' || Payform == 'Credit Card' ||  Payform == 'Debit Card' ) 
        {
            var Bank = c.find("bankvalidate").get("v.value");
            
            if(Bank == null ||  Bank ==undefined || Bank =="" )
            {
            errorFlag = 'true';
            c.set("v.validation", true);
            c.set("v.nameError", 'Complete this field');
            } 
           else {
                //component.set("v.validation", false);  
                c.set("v.nameError", '');
            }
        }
        if(Payform  == 'Credit Card' || Payform == 'Debit Card'  ) 
        {
             var credit = c.find("Creditnumvalidate").get("v.value");
            var Month = c.find("Monthvalidate").get("v.value");
            var year = c.find("yearvalidate").get("v.value");
           var code = c.find("codevalidate").get("v.value");

         if(credit == null || credit == undefined || credit == "" )
            {
            errorFlag = 'true';
            c.set("v.validation", true);
            c.set("v.CreditError", '');
            }    
            else
            {
           c.set("v.CreditError", '');
    
                
            }
            if(Month == null || Month == undefined ||Month =="" )
            {
              errorFlag = 'true';
            c.set("v.validation", true);
            c.set("v.Montherror", '');   
            }
            else
            {
                       c.set("v.Montherror", '');
    
            }
             if(year == null || year == undefined ||year =="" )
            {
              errorFlag = 'true';
            c.set("v.validation", true);
            c.set("v.yearerror", 'Complete this field');   
            }
            else
            {
                       c.set("v.yearerror", '');
    
            }
             if(code == null || code == undefined ||code =="" )
            {
              errorFlag = 'true';
            c.set("v.validation", true);
            c.set("v.CodeError", '');   
            }
            else
            {
                       c.set("v.CodeError", '');
    
            }
             if(year == null || year == undefined ||year =="" )
            {
              errorFlag = 'true';
            c.set("v.validation", true);
            c.set("v.yearerror", '');   
            }
            else
            {
                       c.set("v.yearerror", '');
    
            }
        }
        
        
        var whichOne = e.getSource().getLocalId();

        h.request(c, 'doSaveActionLight', {receivePaymentObj: c.get('v.receivePaymentObj'),selectedBankRegisterId :c.get('v.selectedBankRegisterId')}, function(r){
        	if(r.Error != null && r.Error != undefined && r.Error != ''){
                h.error({ message: r.Error });
            } else {
                if(whichOne == 'Save'){
                    h.navigateToRecord(c, r.record.Id);
                } else {
                    var selObj = c.get('v.receivePaymentObj');
                    
                    var evt = $A.get("e.force:navigateToComponent");
                    evt.setParams({
                        componentDef : "c:RecivePaymentsEdits",
                        componentAttributes: {
                            recordTypeId : selObj.RecordTypeId,
                            invoiceId : selObj.Invoice__c,
                        }
                    });
                    evt.fire();
                    /*var selObj = c.get('v.receivePaymentObj');
                    var selId;
                    if(selObj.Invoice__c != null && selObj.Invoice__c != undefined){
                        var lbl = $A.get("$Label.c.Invoice_Field_Id_For_Receive_Payment");
                        selId = lbl+'='+selObj.Invoice__c;
                    } else {
                        var lbl = $A.get("$Label.c.PO_Field_Id_For_Receive_Payment");
                        selId = lbl+'='+selObj.Bill_Pay__c;;
                    }
                    selId = selId+'&RecordType=' + selObj.RecordTypeId +'&save_new=1&sfdc.override=1';
                    
                    window.location.href = '/apex/ReceivePaymentEditOverride?'+selId;*/
                }
            }  
        });
    },
})