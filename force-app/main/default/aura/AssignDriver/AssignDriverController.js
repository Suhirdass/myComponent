({
   
  updateColumnSorting: function (cmp, event, helper) {
        var fieldName = event.getParam('fieldName');
        var sortDirection = event.getParam('sortDirection');
        cmp.set("v.sortedBy", fieldName);
        cmp.set("v.sortedDirection", sortDirection);
        helper.sortData(cmp, fieldName, sortDirection);
    },
  updateColumnSortingtsm: function (cmp, event, helper) {
        var fieldName = event.getParam('fieldName');
        var sortDirection = event.getParam('sortDirection');
        cmp.set("v.sortedBy", fieldName);
        cmp.set("v.sortedDirection", sortDirection);
        helper.sortData1(cmp, fieldName, sortDirection);
    },
      
    
    
   
     doInit : function(c, e, h) {
        h.request(c, 'assignDriverToOrder', {recordId: c.get('v.recordId')}, function(r){
            c.set('v.rsmList', r.rsmList);    
            c.set('v.tsmList', r.tsmList);
            c.set('v.driverObj', r.driverObj);
            c.set('v.tsmObj',r.tsmObj);
             c.set('v.totalProduct',r.totalProduct);
            
            
           if(r.tsmObj.Driver__c){
                c.set('v.selectedDriver',{label:r.tsmObj.Driver__r.Name,value:r.tsmObj.Driver__c});
            }
        });
	},  
    onCancel : function(c, e, h) {
        h.navigateToRecord(c, c.get('v.recordId'));
    },    
    
   assignDriverValues : function(c, e, h) {
    	h.request(c, 'assignDriver', {order: c.get('v.tsmObj')}, function(r){
             if((c.get('v.selectedDriver') == ''))
       {
         var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Error',
            message:'Please Select Driver Name',
            duration:' 5000',
            key: 'info_alt',
            type: 'error',
            mode: 'pester'
        });
        toastEvent.fire();   
       }     
        if((c.get('v.selectedDriver') !== ''))
       {   
      h.navigateToRecord(c, c.get('v.recordId'));
       var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Success',
            message: 'Assigned Driver successfully',
            duration:' 5000',
            key: 'info_alt',
            type: 'success',
            mode: 'pester'
        });
        toastEvent.fire();
       }
        });    
    },
          
  
retrieveDriverAndRelatedRSMTSMs1 : function(c,e,h){
   h.request(c, 'retrieveDriverAndRelatedRSMs', {order: c.get('v.tsmObj')}, function(r){
    
c.set("v.rsmColumns",[
            {
             label : 'Shipping Manifest',   
          	type : 'url',
            sortable : true,    
            fieldName: 'shipName',
             typeAttributes: {label: { fieldName: 'Name',target: '_blank' },
                              tooltip: {fieldName: 'Name'}} 
               
            },
                
            
            {
                label : 'Status',
                fieldName : 'Status__c',
                type : 'text',
                sortable : true
            },
            {
                label : 'Planned Ship Date',
                fieldName : 'Planned_Ship_Transfer_Date__c',
                 sortable : true,
                type : 'date',typeAttributes:{day: 'numeric',  
                                                 month: 'numeric',  
                                                 year: 'numeric',  
                                                 }}, 
           
            {
                label : 'Actual Departure Date & Time',
                 sortable : true,
                fieldName : 'Actual_Departure_Date_Time__c',
               type : 'date', typeAttributes:{
                 year: "numeric",
                 month: "numeric",
                 day: "numeric",
                 hour: "numeric",
                 minute: "numeric"
             }}, 
                                                           
            
             {
                label : 'Receiver Acceptance Date',
                fieldName : 'Receiver_Acceptance_Date__c',
                 sortable : true,
                  sortable : true,
                type : 'date',typeAttributes:{day: 'numeric',  
                                                 month: 'numeric',  
                                                 year: 'numeric',
                                               hour: '2-digit',  
                                                minute: '2-digit',
                                                 }}, 
                                                                            
                
           
             {
                label : 'Route Miles',
                 	
                fieldName : 'Total_Route_Miles__c',
                type : 'number',
                sortable : true
            },
             {
                label : 'Vehicle',
                 type : 'url',
                sortable : true,
                  fieldName: 'linkNameVehicle',
             typeAttributes: {label: { fieldName: 'Vehicle__c',target: '_blank' },
                              tooltip: {fieldName: 'Vehicle__c'}}
    
            },
            
        ]);
                
  c.set("v.tsmColumns",[
            {
             label : 'Shipping Manifest',   
          	type : 'url',
            sortable : true,    
            fieldName: 'shipName',
             typeAttributes: {label: { fieldName: 'Name',target: '_blank' },
                              tooltip: {fieldName: 'Name'}} 
               
            },
                
            
            {
                label : 'Status',
                fieldName : 'Status__c',
                type : 'text',
                sortable : true
            },
            {
                label : 'Planned Transfer Date',
                fieldName : 'Planned_Ship_Transfer_Date__c',
                 sortable : true,
                type : 'date',typeAttributes:{day: 'numeric',  
                                                 month: 'numeric',  
                                                 year: 'numeric',  
                                                 }}, 
           
            {sortable : true,
                label : 'Actual Departure Date & Time',
     			sortable : true,
                fieldName : 'Actual_Departure_Date_Time__c',
               type : 'date',typeAttributes:{day: 'numeric',  
                                                 month: 'numeric',  
                                                 year: 'numeric', 
                                              hour: '2-digit',  
                                              minute: '2-digit',
                                                 }}, 
                                                           
            
             {
                label : 'Actual Arrival Date & Time',
                fieldName : 'Actual_Departure_Date_Time__c',
                 sortable : true,
                type : 'date',typeAttributes:{day: 'numeric',  
                                                 month: 'numeric',  
                                                 year: 'numeric',
                                               hour: '2-digit',  
                                                minute: '2-digit',
                                                 }}, 
                                                                            
                
           
             {
                label : 'Route Miles',
                 	
                fieldName : 'Total_Route_Miles__c',
                type : 'number',
                sortable : true
            },
             {
                label : 'Vehicle',
                 type : 'url',
                sortable : true,
                  fieldName: 'linkNameVehicle',
             typeAttributes: {label: { fieldName: 'Vehicle__c',target: '_blank' },
                              tooltip: {fieldName: 'Vehicle__c'}}
    
            },
            
        ]);
  
  console.log(r);
            c.set('v.rsmList', r.rsmList);    
          c.set('v.tsmList', r.tsmList);
            c.set('v.driverObj', r.driverObj);
            c.set('v.tsmObj',r.tsmObj);
       
         var recordstsmList = r.tsmList;
            recordstsmList.forEach(function(record){
                    record.linkName = '/'+record.Id;
             record.linkNameVehicle = '/'+record.Vehicle__c;
             c.set("v.rsmList", recordstsmList);
                });
       
        var recordsrsmList = r.rsmList;
            recordsrsmList.forEach(function(record){
                    record.linkName = '/'+record.Id;
             record.linkNameVehicles = '/'+record.Vehicle__c;
             c.set("v.rsmList", recordsrsmList);
                });
       
             
           var rsmLists =r.rsmList;
      				if(rsmLists.length > 0){
                        rsmLists.forEach(function(record){
                             record.shipName = '/'+record.Id;
                            if(record.Vehicle__r != undefined){
                                             record.linkNameVehicle = '/'+record.Vehicle__c;

                              //  record.Vehicle__c = ''+record.Vehicle__c;
                                record.Vehicle__c = record.Vehicle__r.Name;
                            }
                            else{
                                 record.Vehicle__c=null;
                            }
                        });
                        
                    }
                    c.set("v.rsmList",rsmLists);
       
       
        var tsmLists =r.tsmList;
                    if(tsmLists.length > 0){
                        tsmLists.forEach(function(record){
                             record.shipName = '/'+record.Id;
                            if(record.Vehicle__r != undefined){
                               // record.Vehicle__c = ''+record.Vehicle__c;
                                record.Vehicle__c = record.Vehicle__r.Name;
                            }
                             else{
                                 record.Vehicle__c=null;
                            }
                        });
                        
                    }
      
             c.set("v.tsmList",tsmLists);
           
        });
     },       
      
    
   })