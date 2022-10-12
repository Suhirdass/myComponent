({
    getIds: function (c, filters) {
        var h = this;
        h.request(c, 'getIds', { filters: filters,showTransferOrders: true }, function (r) {
            //c.set('v.ids', r.ids);
            /*h.reset(c);
            h.fetchPage(c);*/
            h.initPagination(c, r.ids, filters);
            c.set('v.allIds', r.ids);
            c.set('v.Delete_Outbound_Transfer_Tooltip',r.Delete_Outbound_Transfer_Tooltip);
        }, { storable: false });
    },
    getRecords: function (c, ids) {
        try{
        var h = this;
        h.request(c, 'getRetailDeliveryTickets', { ids: ids, filters: c.get('v.filters') }, function (r) {
            console.log('getRetailDeliveryTickets',r);
            c.set('v.Order_Recall_Confirm_Message',r.Transfer_Order_Recall_Confirm_Message);
            c.set('v.Transfer_Order_Delete_Confirm_Message',r.Transfer_Order_Delete_Confirm_Message);
            c.set('v.Transfer_Order_Deleted_Message',r.Transfer_Order_Deleted_Message);
            //c.set('v.isBrand', r.isBrand);
            window.setTimeout($A.getCallback(function(){
                var records = r.retailDeliveryTickets;
                c.set('v.disableExport',records.length == 0)
                
                records.forEach((records) => {
                    if(records.deliveredDate != undefined && records.deliveredDate != null && records.deliveredDate != ''){
                    	let splitDate = records.deliveredDate.split('-');
                    	records.deliveredDate = splitDate[1]+'/'+splitDate[2]+'/'+splitDate[0];
                	}
                });
                
                c.set('v.records', records);
                console.log('records = ',r.retailDeliveryTickets);
            }),100)
            
            //c.set('v.allRecords', r.retailDeliveryTickets);
        }, { storable: false });
        }catch(error){}
    },
    
    getRecordsForFile: function(c, ids) {
        var h = this;
        var action = c.get('c.getRetailDeliveryTickets');
        action.setParams({
            ids: ids, filters: c.get('v.filters') 
        });
        action.setCallback(this, function(a){
            var state = a.getState(); // get the response state
            console.log('state:',state);
            if(state == 'SUCCESS') {
                var records = a.getReturnValue();
                var csv = this.convertArrayOfObjectsToCSV(c,records.data.retailDeliveryTickets);   
                if (csv == null){return;} 
                // ####--code for create a temp. <a> html tag [link tag] for download the CSV file--####     
                var hiddenElement = document.createElement('a');
                hiddenElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(csv);
                hiddenElement.target = '_self'; // 
                hiddenElement.download = 'OutboundTransfers.csv';  // CSV file Name* you can change it.[only name not .csv] 
                document.body.appendChild(hiddenElement); // Required for FireFox browser
                hiddenElement.click();
            }
        });
        $A.enqueueAction(action);
    },
    /*exportToCSV: function (c) {
        var objectRecords = c.get('v.records');
        var csv = this.convertArrayOfObjectsToCSV(c,objectRecords);  
        if (csv == null){return;}  
        var hiddenElement = document.createElement('a');
        hiddenElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(csv);
        hiddenElement.target = '_self'; // 
        hiddenElement.download = 'OutboundTransfersData.csv';  // CSV file Name* you can change it.[only name not .csv] 
        document.body.appendChild(hiddenElement); // Required for FireFox browser
        hiddenElement.click();
    },*/
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
        keys = ['name','retailerDBA','deliveredDate','status','totalLineItems','total'];
        var keys1 = ['Transfer Number','Receiver Name','Transferred Date','Status','Products','Transfer Total'];
        
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
                
                if(skey == 'licensePremiseAddress'){
                    csvStringResult += '"'+ objectRecords[i][skey].replace('#','')+'"';           
                }else if(skey == 'deliveredDate'){
                    if(objectRecords[i][skey] != undefined){
                        let strDate = String(objectRecords[i][skey]);
                        let splitDate = strDate.split('-');
                        let newReqDate = splitDate[1]+'/'+splitDate[2]+'/'+splitDate[0];
                        csvStringResult += '"'+ newReqDate+'"';
                    } else {
                        csvStringResult += '""';
                    }
                } else if(skey == 'total'){
                    let curFormat = '';
                    if(String(objectRecords[i][skey]) == 0){
                        curFormat = '$0.00';
                    } else {                        
                        curFormat = '$'+parseFloat(String(objectRecords[i][skey])).toFixed(2);
                    }
                    csvStringResult += '"'+ curFormat+'"'; 
                }else{
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