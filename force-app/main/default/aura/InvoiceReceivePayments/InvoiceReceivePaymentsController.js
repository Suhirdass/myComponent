({
    
    handleChange: function (c, event) {
        var changeValue = event.getParam("value");
       if(changeValue == 'invoices')
       {
         c.set("v.invoice", true);   
          c.set("v.SuppliersBill", false);  
             console.log('sss',c.get('v.setinvoice').length);
         c.set("v.setinvoice", 0);  
       //   $A.get('e.force:refreshView').fire();   
       }else if(changeValue == 'SuppliersBills'){
           c.set("v.SuppliersBill", true);  
            c.set("v.invoice", false);
            c.set("v.setBilPays",0);  
           
           
       }
       //
    },
	
   
    SearchBillPay : function(c, e, h) {
        var searchInput = c.find("searchKnowledgeInputSB").get("v.value");
          var Rectypes = c.find("PORecTypes").get("v.value");
        h.request(c, 'BillPaysdetails', {searchText: searchInput,Recordstypes :Rectypes}, function(r){ 
            c.set('v.poData', r.BillPayData);
            c.set('v.setBilPays', r.setBilPays);
            console.log('r.setBilPays',r.setBilPays);
            c.set('v.getLabStatusData', r.getLabStatusData);
           	var result = c.get('v.getLabStatusData');
           	var labTestMap = [];
                for(var key in result){
                    labTestMap.push({key: key, value: result[key]});
                }
           c.set("v.labTestMap", labTestMap); 

        });
       
    },
      FetchRP : function(c, e, h) {
        var searchInput = c.find("searchKnowledgeInput").get("v.value");
          var Rectypes = c.find("warehouse").get("v.value");
        h.request(c, 'RPdetails', {searchText: searchInput,Recordstypes :Rectypes}, function(r){ 
               c.set("v.loaded",false);
            c.set('v.RPDatas', r.RPData);
            c.set('v.setinvoice', r.setinvoice);
            console.log('r.setinvoice',r.setinvoice);
            c.set('v.getLabStatusDataRP', r.getLabStatusDataRP);
           	var result = c.get('v.getLabStatusDataRP');
           	var labTestMap = [];
                for(var key in result){
                    labTestMap.push({key: key, value: result[key]});
                }
           c.set("v.labTestMap", labTestMap); 

        });
    },
   CreateBilpays: function(c, e, h) {
        h.request(c, 'CreatebillPays', { setPurchaseOrderLines: c.get("v.setBilPays") }, function(r){
         
        }); 
    },  
    CreateRPinv: function(c, e, h) {
        h.request(c, 'CreateRP', { setrpdatas: c.get("v.setinvoice") }, function(r){
         
        }); 
    }
   
    
    
    
    
    
    
    
    
    	
})