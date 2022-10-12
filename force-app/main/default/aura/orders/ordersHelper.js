({
    getIds: function (c, filters) {
        var h = this;
        h.request(c, 'getOrdersIds', { filters: filters }, function (r) {
            c.set('v.allIds', r.ids);
            h.initPagination(c, r.ids, filters);
            /*console.log("r.ids Length:",r.ids.length);
            c.set('v.ids', r.ids);
            h.reset(c);
            h.fetchPage(c);*/
        }, { storable: true });
    },
    getRecords: function(c, ids) {
        var h = this;
        h.request(c, 'getOrders', {ids: ids, filters: c.get('v.filters')}, function(r){
            window.setTimeout($A.getCallback(function(){
                var records = r.records;
                c.set('v.disableExport',records.length == 0);
                /*var records = c.get('v.records');
                records = records.concat(r.records);
                console.log("records::",records);*/
                c.set('v.records', records);
            }),100);
        }, {storable: true});
        
    },
    
    getRecordsForFile: function(c, ids) {
        var h = this;
        var action = c.get('c.getOrders');
        action.setParams({
            ids: ids, filters: c.get('v.filters') 
        });
        action.setCallback(this, function(a){
            var state = a.getState(); // get the response state
            console.log('state:',state);
            if(state == 'SUCCESS') {
                var records = a.getReturnValue();
                var csv = this.convertArrayOfObjectsToCSV(c,records.data.records);   
                if (csv == null){return;} 
                // ####--code for create a temp. <a> html tag [link tag] for download the CSV file--####     
                var hiddenElement = document.createElement('a');
                hiddenElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(csv);
                hiddenElement.target = '_self'; // 
                hiddenElement.download = 'Orders.csv';  // CSV file Name* you can change it.[only name not .csv] 
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
        keys = ['name','orderDate','requestShipDate','items','lineSubTotal','exciseTotal','cartTotal','status'];
        var keys1 = ['Order Number','Order Date','Requested Ship date','Total Line Items','Sub Total','Excise Tax','Total Amount','Status'];
        
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
                
                if(skey == 'licensePremiseAddress'){
                    csvStringResult += '"'+ objectRecords[i][skey].replace('#','')+'"';           
                }else if(skey == 'requestShipDate' || skey == 'orderDate'){
                    let strDate = String(objectRecords[i][skey]);
                    if(skey == 'orderDate'){
                        let splitWithT = strDate.split('T');
                        let splitDate = splitWithT[0].split('-');
                        let newReqDate = splitDate[1]+'/'+splitDate[2]+'/'+splitDate[0];
                        csvStringResult += '"'+ newReqDate+'"'; 
                    } else {
                        let splitDate = strDate.split('-');
                        let newReqDate = splitDate[1]+'/'+splitDate[2]+'/'+splitDate[0];
                        csvStringResult += '"'+ newReqDate+'"'; 
                    }
                } else if(skey == 'cartTotal' || skey == 'exciseTotal' || skey == 'lineSubTotal'){
                    let curFormat = '';
                    if(String(objectRecords[i][skey]) == 0){
                        curFormat = '$0.00';
                    } else {
                        curFormat = '$'+parseFloat(String(objectRecords[i][skey])).toFixed(2);
                    }
                    csvStringResult += '"'+ curFormat+'"'; 
                }else if(skey == 'items'){
                    csvStringResult += '"'+ objectRecords[i][skey].length+'"';
                }else{
                    csvStringResult += '"'+ objectRecords[i][skey]+'"';       
                }
                
                counter++;
                
            } // inner for loop close 
            csvStringResult += lineDivider;
        }
        return csvStringResult;        
    }
})