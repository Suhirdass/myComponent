({
    getIds: function (c, filters) {
        console.log('filters:',filters);
        var h = this;
        h.request(c, 'getIds', { filters: filters, fromService: 'false' }, function (r) {
            console.log("r.ids::",r.ids);
            /*h.reset(c);
            c.set('v.ids', r.ids);
            h.fetchPage(c);*/
            c.set('v.allIds', r.ids);
            h.initPagination(c, r.ids, filters);
        }, { storable: true });
    },
    getRecords: function (c, ids) {
        var h = this;
        h.request(c, 'getServiceTickets', { ids: ids, filters: c.get('v.filters') }, function (r) {
            c.set('v.isBrand', r.isBrand);
            var records = c.get('v.records');
            records = r.records;//records.concat(r.records);
            c.set('v.disableExport',records.length == 0)
            console.log("records::",records);
            c.set('v.records', records);
        }, { storable: true });
    },
    getRecordsForFile: function(c, ids) {
        var h = this;
        var action = c.get('c.getServiceTicketsFile');
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
                hiddenElement.download = 'InboundTransfersData.csv';  // CSV file Name* you can change it.[only name not .csv] 
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
        keys = ['ticketNumber','status','transferMethod','createdDate','transferDateString','brandContact','totalServiceLines','totalCompletedServiceLines'];
        var keys1 = ['Transfer Number','Status','Transfer Method','Date Created','Transfer Date','Brand Contact','Services','Progress'];
        
        //keys = ['ticketNumber','createdDate','brandName','brandContact','transferMethod','totalServiceLines','status',''];
        //var keys1 = ['Ticket Number','Created Date','Brand Name','Brand Contact','Transfer Method','Total Service Lines','Status','Licensed Premise'];
        
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
                console.log('skey::',skey,'value=>',objectRecords[i][skey]);
                if(skey == 'licensePremiseAddress'){
                    csvStringResult += '"'+ objectRecords[i][skey].replace('#','')+'"';           
                }else{
                    csvStringResult += (objectRecords[i][skey] == 'undefined' || objectRecords[i][skey] == undefined)?'"'+'"':'"'+objectRecords[i][skey]+'"';      
                }
                
                counter++;
                
            } // inner for loop close 
            csvStringResult += lineDivider;
        }// outer main for loop close 
        
        // return the CSV formate String 
        return csvStringResult;        
    }
})