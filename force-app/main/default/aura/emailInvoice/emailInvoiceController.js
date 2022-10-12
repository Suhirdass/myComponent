({
    onView : function(c, e, h) {
        var recordId = e.currentTarget.dataset.id;
        h.navigateToRecord(c,recordId,'detail');
    },
    searchInvoice : function(c, e, h) {
        window.setTimeout($A.getCallback(function(){
            c.set("v.loaded",true); 
            var searchInput = c.find('searchInput');
            var searchText = searchInput.getElement().value;
            var action = c.get("c.fatchInvoice");
            action.setParams({ 
                "searchText" : searchText
            });
            action.setCallback(this, function(response) {
                c.set("v.loaded",false);
                var state = response.getState();
                c.set("v.invoiceList",response.getReturnValue());  
            });
            $A.enqueueAction(action);
        }),900);
    },
    reset : function(c, e, h) {
        var chk_arr =  document.getElementsByName("chk");        
        for(var k=0;k< chk_arr.length;k++){
            chk_arr[k].checked = false;
        }
        var invoiceList = [];
        c.set("v.invoiceList",invoiceList);  
        document.getElementById("searchInput").value = ''; 
    },
    openModel: function(c, e, h) {
        var selectedInvoiceIds = '';
        var chk_arr =  document.getElementsByName("chk");        
        for(var k=0;k< chk_arr.length;k++){
            if(chk_arr[k].checked){
                selectedInvoiceIds = selectedInvoiceIds + chk_arr[k].id + ',';
            } 
        }
        if(selectedInvoiceIds.length){
            var urlEvent = $A.get("e.force:navigateToURL");
            var pageUrl = "/apex/MultipleInvoiceEmail?invoiceIds="+selectedInvoiceIds+"&templateGroup=MultiInvoice";
            urlEvent.setParams({
                "url": pageUrl,
                "isredirect": "true"
            });
            urlEvent.fire();
        }else{
            h.error('Please select Invoice to Send Email');    
        }
    }, 
    exportPdf: function(c, e, h) {
        var invoiceList =  c.get("v.invoiceList");
        if(invoiceList.length > 0 ){
            var searchInput = c.find('searchInput');
            var searchText = searchInput.getElement().value;
            var url = '/apex/Export_Invoice?searchText='+searchText;
            window.open(url);
        }else{
            h.error('No Invoice records found to Export');    
        }
    },
    exportExcel: function(c, e, h) {
        var invoiceList =c.get("v.invoiceList");
        var csv = h.convertArrayOfObjectsToCSV(c,invoiceList);   
        if (csv == null){
            h.error('No Invoice records found to Export');
        }else{
            var hiddenElement = document.createElement('a');
            hiddenElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(csv);
            hiddenElement.target = '_self';  
            hiddenElement.download = 'Export Invoice.csv';  
            document.body.appendChild(hiddenElement);
            hiddenElement.click();
        }
    }
})