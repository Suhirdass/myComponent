({
	getIds: function (c, filters) {
		var h = this;
        console.log('filters',filters);
		h.request(
			c,
			'getNewProductRequestIds',
			{ filters: filters },
			function (r) {
				console.log('getNewProductRequestIds::', r);
				c.set('v.ids', r.ids);
				/*h.reset(c);
				h.fetchPage(c);*/
                c.set('v.allIds', r.ids);
                h.initPagination(c, r.ids, filters);
			},
			{ storable: true }
		);
	},
	getRecords: function (c, ids) {
		var h = this;
        console.log('ids '+ids);
        console.log('filters',c.get('v.filters'));
		h.request(
			c,
			'getNewProductRequests',
			{ ids: ids, filters: c.get('v.filters') },
			function (r) {
				console.log('getNewProductRequests::', r);
				c.set('v.isBrand', r.isBrand);
				var records = r.records;//c.get('v.records');
                c.set('v.disableExport',records.length == 0)
				//records = records.concat(r.records);
				c.set('v.records', records);
			},
			{ storable: true }
		);
	},
    getRecordsForFile: function(c) {
        var h = this;
        console.log('SIZE = ',c.get('v.allIds'));
        var action = c.get('c.getNewProductRequests');
        action.setParams({
            ids: c.get('v.allIds'), filters: c.get('v.filters') 
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
                hiddenElement.download = 'ProductsData.csv';  // CSV file Name* you can change it.[only name not .csv] 
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
        keys = ['Product_Short_Description__c','Status__c','Brand_Name__c','Family','Strain_Type__c'];
        var keys1 = ['Product Name','Status','Brand','Product Family','Strain-Type'];
        
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
                if(skey == 'Strain_Type__c'){
                    var strain = 'Strain__c';
                    var strainNameValue = '';
                    if(objectRecords[i][strain] != 'undefined' && objectRecords[i][strain] != undefined && objectRecords[i][strain] != null && objectRecords[i][strain] != ''){
                        var strainR = 'Strain__r';
                        var strainName = 'Name';
                        strainNameValue = objectRecords[i][strainR][strainName] ;
                    }
                    var strainType = 'Strain_Type__c';
                    var strainTypeValue = '';
                    if(objectRecords[i][strainType] != 'undefined' && objectRecords[i][strainType] != undefined && objectRecords[i][strainType] != null && objectRecords[i][strainType] != ''){
                    	strainTypeValue = objectRecords[i][strainType]; 
                    }
                    if(strainNameValue != '')
                        csvStringResult += strainNameValue;
                    
                    if(strainNameValue != '' && strainTypeValue != '')
                        csvStringResult += '-';
                    
                    if(strainTypeValue != '')
                        csvStringResult += strainTypeValue;
                    
                    //csvStringResult += '"-"';
                    
                    //csvStringResult += ( == 'undefined' || objectRecords[i][strainType] == undefined)?'"'+'"':'"'+objectRecords[i][strainType]+'"';      
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
});