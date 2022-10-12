({
    getIds: function (c, filters) {
        var h = this;
        h.request(c, 'getAllColdAccountIds', { filters: filters }, function (r) {
            c.set('v.allIds', r.ids);
            console.log('r.ids= ',r.ids);
            h.initPagination(c, r.ids, filters);
        }, { storable: true });
    },
    getRecords: function (c, ids) {
        try{
            var h = this;
            h.request(c, 'getAllColdAccounts', { ids: ids, filters: c.get('v.filters') }, function (r) {
                console.log('getAllColdAccounts',r);
                var records = r.coldAccountsList;
                c.set('v.disableExport',records.length == 0);
                c.set('v.coldAccountList', records);
                console.log('records = ',r.coldAccountsList);                
            }, { storable: true });
        }catch(error){}
    },
    getRecordsForFile: function(c, ids) {
        var h = this;
        var action = c.get('c.getAllColdAccounts');
        action.setParams({
            ids: ids, filters: c.get('v.filters') 
        });
        action.setCallback(this, function(a){
            var state = a.getState(); // get the response state
            console.log('state:',state);
            if(state == 'SUCCESS') {
                var records = a.getReturnValue();
                var csv = this.convertArrayOfObjectsToCSV(c,records.data.coldAccountsList);   
                if (csv == null){return;} 
                // ####--code for create a temp. <a> html tag [link tag] for download the CSV file--####     
                var hiddenElement = document.createElement('a');
                hiddenElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(csv);
                hiddenElement.target = '_self'; // 
                hiddenElement.download = 'ColdAccounts.csv';  // CSV file Name* you can change it.[only name not .csv] 
                document.body.appendChild(hiddenElement); // Required for FireFox browser
                hiddenElement.click();
            }
        });
        $A.enqueueAction(action);
    },
    convertArrayOfObjectsToCSV : function(component,objectRecords){
        // declare variables
        var csvStringResult, counter, keys, columnDivider, lineDivider;
        // check if "objectRecords" parameter is null, then return from function
        if (objectRecords == null || !objectRecords.length) {
            return null;
        }
        // store ,[comma] in columnDivider variabel for sparate CSV values and 
        // for start next line use '\n' [new line] in lineDivider varaible  
        columnDivider = ',';
        lineDivider =  '\n';
        // in the keys valirable store fields API Names as a key 
        // this labels use in CSV file header  
        keys = ['Retailer__r.DBA__c','Retailer__r.BillingCity','Order_Date__c','Total_Product_Price__c'];
        var keys1 = ['Retailer DBA','City','Ship Date','Total Product Price'];
        csvStringResult = '';
        csvStringResult += keys1.join(columnDivider);
        csvStringResult += lineDivider;
        for(var i=0; i < objectRecords.length; i++){  
            counter = 0;
            for(var sTempkey in keys) {
                var skey = keys[sTempkey] ;  
                // add , [comma] after every String value,. [except first]
                if(counter > 0){ 
                    csvStringResult += columnDivider; 
                } 
                if(skey == 'Retailer__r.DBA__c' || skey == 'Retailer__r.BillingCity'){
                    if(objectRecords[i]['Retailer__c'] != null && objectRecords[i]['Retailer__c'] != undefined && objectRecords[i]['Retailer__c'] != ''){
                    	if(skey == 'Retailer__r.DBA__c')
                        	csvStringResult += '"'+ objectRecords[i]['Retailer__r']['DBA__c']+'"';    
                        if(skey == 'Retailer__r.BillingCity' && objectRecords[i]['Retailer__r']['BillingCity'] != undefined)
                            csvStringResult += '"'+objectRecords[i]['Retailer__r']['BillingCity']+'"';          
                        else
	                    	csvStringResult += '';              
                    }else{
                    	csvStringResult += '';              
                    }
                }else if(skey == 'Order_Date__c'){
                    let strDate = String(objectRecords[i][skey]);
                    if(strDate != undefined && strDate != null && strDate != ''){
                        let splitDate = strDate.split('T')[0].split('-');
                        let newReqDate = splitDate[1]+'/'+splitDate[2]+'/'+splitDate[0];
                        csvStringResult += '"'+ newReqDate+'"';    
                    }else{
                    	csvStringResult += '';              
                    } 
                }
                else{
                	csvStringResult += '"'+ objectRecords[i][skey]+'"';          
                }                
                counter++;
                
            } // inner for loop close 
            csvStringResult += lineDivider;
        }// outer main for loop close 
        
        // return the CSV formate String 
        return csvStringResult;        
    }
})