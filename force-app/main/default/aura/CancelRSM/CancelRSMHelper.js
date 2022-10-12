({
    onCancelSM: function(component,isCancelWMFeeOnly,onlySM) {
        const h =this;
    	// create var for store record id's for selected checkboxes  
        var delId = [];
        // get all checkboxes 
        var getAllId = component.find("boxPack");
        // If the local ID is unique[in single record case], find() returns the component. not array
        if(! Array.isArray(getAllId)){
            if (getAllId.get("v.value") == true) {
                delId.push(getAllId.get("v.text"));
            }
        }else{
            // play a for loop and check every checkbox values 
            // if value is checked(true) then add those Id (store in Text attribute on checkbox) in delId var.
            for (var i = 0; i < getAllId.length; i++) {
                if (getAllId[i].get("v.value") == true) {
                  
                    delId.push(getAllId[i].get("v.text"));
                }
            }
        } 
        if(delId==''){
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : 'Warning',
                message: ' Please select SM line(s) to cancel.',
                duration:' 5000',
                key: 'info_alt',
                type: 'error',
                mode: 'pester'
            });
            toastEvent.fire();
        }else{
            
            var setRsmLines = component.get("v.setRsmLines");
            var smLinesstatus = 'true';
            var smlineError ='';
           
                
            for (var i = 0; i < getAllId.length; i++) {
              
                if (getAllId[i].get("v.value") == true) {
                  
                    if(setRsmLines[i].rsmlinesIL.Rejection_Reason__c=='None' || setRsmLines[i].rsmlinesIL.Rejection_Reason__c=='')
                    {
                        smlineError += setRsmLines[i].rsmlinesIL.Name+' Please select a Rejection Reason. \n';
                        smLinesstatus = false;
                    }
                    
                }
            }

            
            if(delId && getAllId.length < 0) {
                for (var i = 0; i < setRsmLines.length; i++) {
                    if(setRsmLines[i].rsmlinesIL.Id == delId){
                        if(setRsmLines[i].rsmlinesIL.Rejection_Reason__c=='None' || setRsmLines[i].rsmlinesIL.Rejection_Reason__c=='')
                        {
                            smlineError += setRsmLines[i].rsmlinesIL.Name+' Please select a Rejection Reason. \n';
                            smLinesstatus = false;
                        }
                    }
                }
            }      
            
            if(smLinesstatus == false){
                h.error({message: smlineError});
            }else{
            
            var sParameterValue = component.get('v.recordId');

            if(onlySM){
              
                h.request(component, 'updateSmLines', {lstRecordId:delId,recordId:sParameterValue,isIncludeServiceInvoices:false,setRsmLines:setRsmLines}, function(r){
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Success',
                        message: 'Selected SM Line(s) cancelled successfully.',
                        duration:'2000',
                        key: 'info_alt',
                        type: 'success',
                        mode: 'pester'
                    });
                    toastEvent.fire();
                    var url = window.location.href; 
                    var value = url.substr(0,url.lastIndexOf('/') + 1);
                    window.history.back();
                    setTimeout(
                        $A.getCallback(function() {
                            window.location.reload();
                        }), 3000
                    );
                });
            } else {

                   var setRsmLines = component.get("v.setRsmLines");
            
                h.request(component, 'updateSmLines', {lstRecordId:delId,recordId:sParameterValue,isIncludeServiceInvoices:!isCancelWMFeeOnly,setRsmLines:setRsmLines}, function(r){
                    if(isCancelWMFeeOnly){
                        h.onCancelOnlyWMFeeOnly(component);
                    }else{
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            title : 'Success',
                            message: 'Selected SM Line(s) cancelled successfully.',
                            duration:'2000',
                            key: 'info_alt',
                            type: 'success',
                            mode: 'pester'
                        });
                        toastEvent.fire();
                        var url = window.location.href; 
                        var value = url.substr(0,url.lastIndexOf('/') + 1);
                        window.history.back();
                        setTimeout(
                            $A.getCallback(function() {
                                window.location.reload();
                            }), 3000
                        );
                    }
                });
            }
        }
        }    
    },
    onCancelOnlyWMFeeOnly: function(component) {
        const h = this;
        var sParameterValue = component.get('v.recordId');
        h.request(component, 'updateOnlyServiceLine', {recordId:sParameterValue}, function(r){
            var toastEvent = $A.get("e.force:showToast");
            var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Success',
                    message: 'Selected SM Line(s) cancelled successfully.',
                    duration:'2000',
                    key: 'info_alt',
                    type: 'success',
                    mode: 'pester'
                });
                toastEvent.fire();
                var url = window.location.href; 
                var value = url.substr(0,url.lastIndexOf('/') + 1);
                window.history.back();
                setTimeout(
                    $A.getCallback(function() {
                      window.location.reload();
                    }), 3000
                );
            
        });   
    },
    
})