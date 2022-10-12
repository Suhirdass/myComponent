({
	setValues : function(c, e, h, r) {
		c.set('v.productInventoryWrapperList',r.records);
        c.set('v.totleProductInventoryWrapperList',r.totelRecords);
        c.set('v.productList',r.productList);
        c.set('v.totelPage',r.totelPage);
        c.set('v.cuurentPage',r.cuurentPage);
        c.set('v.pageSize',r.pageSize);
        c.set('v.startRec',r.startRec);
        c.set('v.endRec',r.endRec);
        c.set('v.totelRec',r.totelRec);
        c.set('v.isCommunityPlusUser',r.isCommunityPlusUser);
	},
    getProdcutInvtory : function(c, e, h, s,o,srchTxt,p) {
    	c.set('v.sortField',s);
        c.set('v.sortOrder',o);
        h.request(c, 'fetchInvenotry', {
            sortField:s,
            sortOrder:o,
            searchText:srchTxt,
            pageSize:p,
            fromReport:true
        }, function(r){
            h.setValues(c, event, h, r);
            var data = r.data;
            c.set('v.data',data);
            var pageNumbers = [];
            for (var i = 1; i <= r.totelPage; i++) {
                if(pageNumbers.length < 5)
            		pageNumbers.push(i);
        	}
            c.set('v.pageNumbers', pageNumbers);
        });    
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
        keys = ['name','retailerName','requestShipDate','status','totalLineItems','total'];
        var keys1 = ['Product Name: Product Name','Site','Total Inventory','Total in Receiving','Total Order Qty','Total OnHold','Total Allocated','Available to Sell','Sum of Qty On Hand'];
        
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
                }else if(skey == 'requestShipDate'){
                    let strDate = String(objectRecords[i][skey]);
                    let splitDate = strDate.split('-');
                    let newReqDate = splitDate[1]+'/'+splitDate[2]+'/'+splitDate[0];
                    csvStringResult += '"'+ newReqDate+'"'; 
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