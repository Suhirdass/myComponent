({
    showToast: function (toastType, Msgtitle, params) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": Msgtitle,
            "message": params,
            "type": toastType
        });
        toastEvent.fire(); 
    },
    info: function (params) {
        this.showToast('info', 'Info!', params);
    },
    success: function (params) {
        this.showToast('success', 'Success!', params);
    },
    warning: function (params) {
        this.showToast('warning', 'Warning!', params);
    },
    error: function (params) {
        this.showToast('error', 'Error!', params);
    },
    escapeRegExp: function (string){
        return string.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
    },
    replaceAll:function(str, term, replacement) {
        var h =  this;
        return str.replace(new RegExp(h.escapeRegExp(term), 'g'), replacement);
    },
    navigateToRecord : function(c,recordId,type){
        console.log('recordId::',recordId);
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": recordId,
            "slideDevName":type
        });
        navEvt.fire();
    },
    convertArrayOfObjectsToCSV : function(component,objectRecords){
        var csvStringResult, counter, keys, columnDivider, lineDivider,headers;      
        if (objectRecords == null || !objectRecords.length)
            return null;
        columnDivider = ',';
        lineDivider =  '\n';
		headers = ['Business Name','Invoice','Order Number','Ship Confirmation Date','Invoice Amount','Product Balance','Excise Tax Balance','Invoice Balance','AR Status'] 
        keys = ['Receiver_Name__r.Name','Name','Brand_Quote__r.Opportunity_Name__r.Order__r.Name','Ship_Confirmation_Date__c','Total_Invoice_Amount__c','Product_Balance__c','Excise_Tax_Balance__c','Invoice_Balance__c','AR_Status__c' ];        
        csvStringResult = '';
        csvStringResult += headers.join(columnDivider);
        csvStringResult += lineDivider;        
        for(var i=0; i < objectRecords.length; i++){   
            counter = 0;            
            for(var sTempkey in keys) {
                var skey = keys[sTempkey] ;  
                
                if(counter > 0){ 
                    csvStringResult += columnDivider; 
                } 
                if(!skey.includes('.')){
                    if(skey == 'Total_Invoice_Amount__c' || skey == 'Product_Balance__c' || skey == 'Excise_Tax_Balance__c' || skey == 'Invoice_Balance__c')
                    	if(String(objectRecords[i][skey]) == 0)
                        	csvStringResult += '$0.00';
                    	else
                        	csvStringResult += '"$'+ parseFloat(String(objectRecords[i][skey])).toFixed(2)+'"';   
                    else if(skey == "Ship_Confirmation_Date__c" && (objectRecords[i][skey] != 'undefined' || objectRecords[i][skey] != undefined)){
                        let strDate = String(objectRecords[i][skey]);
                        if(strDate != 'undefined'){
                            let splitDate = strDate.split('-');
                            let newReqDate = splitDate[1]+'/'+splitDate[2]+'/'+splitDate[0];
                            csvStringResult += '"'+ newReqDate+'"'; 
                        }
                    }else
                        csvStringResult += '"'+ objectRecords[i][skey]+'"';                    		
                }else{
                    var fieldList = skey.split(".");
                    if(fieldList.length == 2){
                        var f0 = fieldList[0];
                        f0 = f0.replace('__r','__c');
                        if(objectRecords[i][f0] != undefined)
                    		csvStringResult += '"'+ objectRecords[i][fieldList[0]][fieldList[1]]+'"';     
                    }else if(fieldList.length == 4){
                        var f0 = fieldList[0];
                        f0 = f0.replace('__r','__c');
                        if(objectRecords[i][f0] != undefined){
                        	var f1 = fieldList[1];
                        	f1 = f1.replace('__r','__c'); 
                            if(objectRecords[i][fieldList[0]][f1] != undefined){
                            	var f2 = fieldList[2];
                                f2 = f2.replace('__r','__c'); 
                                if(objectRecords[i][fieldList[0]][fieldList[1]][f2] != undefined)
                                    csvStringResult += '"'+ objectRecords[i][fieldList[0]][fieldList[1]][fieldList[2]][fieldList[3]]+'"';
                            }
                        }
                    }    
                }
                counter++;                
            } 
            csvStringResult += lineDivider;
        }         
        return csvStringResult;        
    },
    
})