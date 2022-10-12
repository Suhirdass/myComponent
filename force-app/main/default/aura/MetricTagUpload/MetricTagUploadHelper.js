({
    parseCSV: function (c, files) {
        var h = this;
        
        var file = files[0];
        if (file.name.split('.').pop().toLowerCase() !== 'csv') {
            h.warning({ message: 'Please import only .csv files.' });
            return;
        }
        c.set('v.isProcessing', true);
          var payments = [];
        Papa.parse(file, {
            header: false,
            skipEmptyLines: 'greedy',
            dynamicTyping: true,
            complete: function (results, file) {
                var records = results.data;
                var datatableConfig = c.get('v.datatableConfig');
                var datatableConfigexist = c.get('v.datatableConfigexist');
                var headers = records.shift();
                datatableConfig.columnByType = {
                    Tag: 'text',
                    Active: Boolean,
                    IRRUID: 'text',
                    Status: 'text',
                };
                
                datatableConfigexist.columns = [
                    { label: 'Tags', fieldName: 'Tag2', type: 'url', editable: false, typeAttributes: { label: {  fieldName: 'Tags' },}  },  
                    { label: 'Active ', fieldName: 'ActiveUID', type: Boolean, editable: false },
                    { label: 'IRR UID', fieldName: 'IRRUID', type: 'text', editable: false },
                    { label: 'Status', fieldName: 'StatusUID', type: 'text', editable: false }
                    ];
                
                if (headers.indexOf('Tags') > -1) {
                    datatableConfig.columns = [
                        { label: 'Tags', fieldName: 'Tag', type: 'text', editable: true },
                        { label: 'Active ', fieldName: 'ActiveUID', type: Boolean, editable: false },
                        { label: 'IRR UID', fieldName: 'IRRUID', type: 'text', editable: false },
                        { label: 'Status', fieldName: 'StatusUID', type: 'text', editable: false }
                    ];
                }else
                {
                    h.warning({ message: 'Please cross-check the file and try again' });
                    c.set('v.payments', payments);
                    c.set('v.isProcessing', false);
                    return true;   
                }
                var selectPayments = [];
                records.forEach(function (record, paymentIndex) {
                    selectPayments.push('index' + paymentIndex);
                    var payment = { paymentIndex: ('index' + paymentIndex) };
                    datatableConfig.columns.forEach(function (column, index) {
                    var value = record[index];
                    if(value != null)
                        {
                            payment[column.fieldName] =(value + '').trim();
                        }
                        
                    });
                    payments.push(payment);
                });
              
                h.request(c, 'gettags', { paymentsData: JSON.stringify(payments) }, function (r) { 
                          var selectedPayments = c.get('v.selectedPayments');
                    c.set("v.allDataseparation", r.TagsItems);
                    var ExistUIDTags =[];
                    var Newtagsdata =[];
                    var  payments = c.get('v.allDataseparation'); 
                    payments.forEach(function (payment, paymentIndex) {
                        if(payment.StatusUID == 'UID already exist')
                        {
                            ExistUIDTags.push(payment);   
                        }else
                        {
                            Newtagsdata.push(payment);   
                        }
                    });
                    c.set("v.ExistUID", ExistUIDTags.length);
                    c.set("v.NewUID", Newtagsdata.length);  
                    c.set("v.totalPages", Math.ceil(Newtagsdata.length/c.get("v.pageSize")));
                    c.set("v.allData", Newtagsdata);
                    c.set("v.currentPageNumber",1);
                      c.set('v.datatableConfig', datatableConfig);
                    c.set('v.isProcessing', false);
                    c.set('v.selectPayments', selectPayments);
                    h.setPageDataAsPerPagination(c, h);
                    c.set('v.datatableConfig', datatableConfig);
                    c.set('v.isProcessing', false);
                    c.set("v.Existingpayments", ExistUIDTags);   
                    if(c.get('v.Existingpayments') != undefined )
                    {
                        c.set("v.Existingpaymentsdata",r.Id);
                        var recordsrsmListdata =  c.get('v.Existingpaymentsdata');
                        var recordsrsmList =  c.get('v.Existingpayments');
                        recordsrsmList.forEach(function(record){
                            recordsrsmListdata.forEach(function(record2){   
                                if(record.Tag == record2.Name){ 
                                    record.Tags = record2.Name; //Here define your value which you want to display
                                    record.Tag2 = '/' + record2.Id;
                                }
                            } );
                        } );
                        c.set('v.datatableConfigexist', datatableConfigexist);
                            c.set("v.totalPagesExist", Math.ceil(ExistUIDTags.length/c.get("v.pageSizeExist")));
                            c.set("v.allDataexist", ExistUIDTags);
                            c.set("v.currentPageNumberExist",1);
                            h.setPageDataAsPerPaginationExist(c, h);
                    }
                });  
            
            }
             
        });
    },
    
    setPageDataAsPerPagination : function(component, helper,event) {
       
        var data = [];
        var pageNumber = component.get("v.currentPageNumber");
        var pageSize = component.get("v.pageSize");
        var allData = component.get("v.allData");
        var x = (pageNumber-1)*pageSize;
        //creating data-table data
        for(; x< (pageNumber)*pageSize; x++){
            if(allData[x]){
                data.push(allData[x]);
            }
        }
       component.set('v.payments',[]);  
        component.set("v.payments", data);
        component.set('v.isButtonActive',false);
        helper.generatePageList(component, pageNumber);
    },   
    generatePageList : function(component, pageNumber){
        pageNumber = parseInt(pageNumber);
        var pageList = [];
        var totalPages = component.get("v.totalPages");
        if(totalPages > 1){
            if(totalPages <= 10){
                var counter = 2;
                for(; counter < (totalPages); counter++){
                    pageList.push(counter);
                } 
            } else{
                if(pageNumber < 5){
                    pageList.push(2, 3, 4, 5, 6);
                } else{
                    if(pageNumber>(totalPages-5)){
                        pageList.push(totalPages-5, totalPages-4, totalPages-3, totalPages-2, totalPages-1);
                    } else{
                        pageList.push(pageNumber-2, pageNumber-1, pageNumber, pageNumber+1, pageNumber+2);
                    }
                }
            }
        }
       
        component.set("v.pageList", pageList);

    },
    setPageDataAsPerPaginationExist : function(component, helper) {
        var data = [];
        var pageNumber = component.get("v.currentPageNumberExist");
        var pageSize = component.get("v.pageSizeExist");
        var allData = component.get("v.allDataexist");
        var x = (pageNumber-1)*pageSize;
        //creating data-table data
              
        for(; x<= (pageNumber) * pageSize; x++){
       
            if(allData[x]){
                data.push(allData[x]);
            }
           
        }
      
        component.set("v.Existingpayments", data);
        component.set('v.isButtonActive',false);
        helper.generatePageListExist(component, pageNumber);
    }, 
    generatePageListExist : function(component, pageNumber){
        pageNumber = parseInt(pageNumber);
        var pageList = [];
        var totalPages = component.get("v.totalPagesExist");
        if(totalPages > 1){
            if(totalPages <= 10){
                var counter = 2;
                for(; counter < (totalPages); counter++){
                    pageList.push(counter);
                } 
            } else{
                if(pageNumber < 5){
                    pageList.push(2, 3, 4, 5, 6);
                } else{
                    if(pageNumber>(totalPages-5)){
                        pageList.push(totalPages-5, totalPages-4, totalPages-3, totalPages-2, totalPages-1);
                    } else{
                        pageList.push(pageNumber-2, pageNumber-1, pageNumber, pageNumber+1, pageNumber+2);
                    }
                }
            }
        }
        component.set("v.pageListExist", pageList);
    }, 
    
})