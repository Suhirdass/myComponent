({
  getCases: function (c, filters) {
      console.log('getCases');
    var h = this;
      c.set('v.records',[]);
      h.request(c, 'getCases', { filters: filters }, function (r) {
      c.set('v.allIds', r.ids);
          h.initPagination(c, r.ids, filters);
      
      c.set('v.disableExport',r.ids.length == 0)
      //h.fetchPage(c);
    }, { storable: true });
  },
   /* getCaseIds: function (c, filters) {
        var h = this;
        h.request(c, 'getCaseIds', { filters: filters }, function (r) {
            c.set('v.allIds', r.ids);
            h.initPagination(c, r.ids, filters);
            
        }, { storable: true });
	},*/
  getIds: function (c, filters) {
		var h = this;
        console.log('filters',filters);
		h.request(
			c, 'getCases',{ filters: filters }, function (r) {
				console.log('getCaseRequestIds::', r);
				c.set('v.ids', r.ids);
                c.set('v.allIds', r.ids);
                h.initPagination(c, r.ids, filters);
                c.set('v.disableExport',r.ids.length == 0)
			},
			{ storable: true }
		);
	},
    getRecords: function(c, ids) {
        var h = this;
        h.request(c, 'getCaseDetails', {ids: ids, filters: c.get('v.filters')}, function(r){
            c.set('v.isBrand', r.isBrand);
            var records = c.get('v.records');
            records = records.concat(r.records);
            //c.set('v.records', records);
            c.set('v.disableExport',records.length == 0)
        }, {storable: true});
        
    },
  getCaseDetails: function (c, ids) {
      console.log('getCaseDetails');
    var h = this;
    h.request(c, 'getCaseDetails', { ids: ids, filters: c.get('v.filters') }, function (r) {
      c.set('v.isBrand', r.isBrand);
      c.set('v.records', r.records);
    }, { storable: true });
  },
  getRecordsForFile: function(c, ids) {
        var h = this;
        var action = c.get('c.getCaseDetails');
      console.log('getRecordsForFile. ids:',ids);
        action.setParams({
            ids: ids, filters: c.get('v.filters') 
            //ids: ids, filters: c.get('v.filters') 
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
                hiddenElement.download = 'CasesData.csv';  // CSV file Name* you can change it.[only name not .csv] 
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
        keys = ['CaseNumber','Subject','CreatedDate','Status','Priority','Contact_Preference__c'];
        var keys1 = ['Case Number','Subject','Created Date','Status','Priority','Contact Preference'];
        
        
        csvStringResult = '';
        csvStringResult += keys1.join(columnDivider);
        csvStringResult += lineDivider;
        
        for(var i=0; i < objectRecords.length; i++){   
            counter = 0;
            
            for(var sTempkey in keys) {
                var skey = keys[sTempkey] ;  
                if(counter > 0){ 
                    csvStringResult += columnDivider; 
                }
                if(skey == 'CreatedDate'){
                    let strDate = String(objectRecords[i][skey]);
                    let strDateNew = strDate.slice(0, 10);
                    let splitDate = strDateNew.split('-');
                    let newDate = splitDate[1]+'/'+splitDate[2]+'/'+splitDate[0];
                    csvStringResult += '"'+ newDate+'"'; 
                }else{
                     csvStringResult += (objectRecords[i][skey] == 'undefined' || objectRecords[i][skey] == undefined)?'"'+'"':'"'+objectRecords[i][skey]+'"';
                }
                counter++;
            } // inner for loop close 
            csvStringResult += lineDivider;
        }
        return csvStringResult;        
    }
})