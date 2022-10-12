({
	getIds: function(c, filters) {
        var h = this;
        h.request(c, 'getRecentReportsIds', {filters: filters}, function(r){
            try{
            console.log("getReportsIds::",r);
            //h.reset(c);
            c.set('v.ids', r.ids);
            c.set('v.allIds', r.ids);
           // h.fetchPage(c);
            c.find('paginator').setIds(r.ids);
            }catch(err){
                console.log('Error:',err);
            }
        }, {storable: false});
    },
    getRecords: function(c, ids) {
        var h = this;
        h.request(c, 'getReports', {ids: ids, filters: c.get('v.filters')}, function(r){
            var records = r.records || [];//c.get('v.records');
            console.log("getReports::",r);
            c.set('v.disableExport',records.length == 0)
            c.set('v.records', records);
            c.set('v.isDataLoaded',true);
        }, {storable: false});
    },
    getRecordsForFile: function(c, ids) {
        var h = this;
        var action = c.get('c.getReports');
        action.setParams({
            ids: c.get('v.allIds'), filters: c.get('v.filters') 
        });
        action.setCallback(this, function(a){
            var state = a.getState(); // get the response state
            console.log('state:',state);
            if(state == 'SUCCESS') {
                var records = a.getReturnValue();
                var csv = this.convertArrayOfObjectsToCSV(c,c.get('v.records'));   
                if (csv == null){return;} 
                
                // ####--code for create a temp. <a> html tag [link tag] for download the CSV file--####     
                var hiddenElement = document.createElement('a');
                hiddenElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(csv);
                hiddenElement.target = '_self'; // 
                hiddenElement.download = 'Recent Reports.csv';  // CSV file Name* you can change it.[only name not .csv] 
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
        keys = ['name','description'];
        var keys1 = ['Report Name','Description'];
        
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
                
                 
                if(objectRecords[i][skey] == 'undefined' || objectRecords[i][skey] == undefined)
                	csvStringResult += '"'+'"';
                else{
                    var fldValue = objectRecords[i][skey].replaceAll("\"", "");
                	csvStringResult += '"'+fldValue+'"';   
                }      
                
                
                counter++;
                
            } // inner for loop close 
            csvStringResult += lineDivider;
        }// outer main for loop close 
        
        // return the CSV formate String 
        return csvStringResult;        
    }
})