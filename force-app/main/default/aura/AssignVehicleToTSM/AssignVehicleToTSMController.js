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
		h.request(c, 'assignVehicleToOrder', {recordId: c.get('v.recordId')}, function(r){
            c.set('v.rsmObj', r.rsmObj);    
            c.set('v.rsmList', r.rsmList);
            c.set('v.tsmList', r.tsmList);
            c.set('v.vehicleObj',r.vehicleObj);
              c.set('v.totalProduct',r.totalProduct);
            if(r.rsmObj.Vehicle__c){
                c.set('v.selectedVehicle',{label:r.rsmObj.Vehicle__r.Name,value:r.rsmObj.Vehicle__c});
            }
        });	
	},   

  onCancel : function(c, e, h) {
        h.navigateToRecord(c, c.get('v.recordId'));
    },
      
    assignVehicleValues : function(c, e, h) {
    	h.request(c, 'assignVehicle', {order: c.get('v.rsmObj')}, function(r){
            if((c.get('v.selectedVehicle') == ''))
       {
         var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Error',
            message:'Please Select Vehicle Name',
            duration:' 5000',
            key: 'info_alt',
            type: 'error',
            mode: 'pester'
        });
        toastEvent.fire();   
       }     
        if((c.get('v.selectedVehicle') !== ''))
       {   
      h.navigateToRecord(c, c.get('v.recordId'));
       var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Success',
            message: 'Assigned Vehicle successfully',
            duration:' 5000',
            key: 'info_alt',
            type: 'success',
            mode: 'pester'
        });
        toastEvent.fire();
       }          
            
        });
    },
retrieveVehicleAndRelatedRSMTSMs1: function(c,e,h){
   h.request(c, 'retrieveVehicleAndRelatedRSMs', {order: c.get('v.rsmObj')}, function(r){
        console.log(r);
          c.set('v.rsmObj', r.rsmObj);    
            c.set('v.rsmList', r.rsmList);
           c.set('v.tsmList', r.tsmList);
            c.set('v.vehicleObj',r.vehicleObj);
       
       
           var recordstsmList = r.tsmList;
            recordstsmList.forEach(function(record){
                    record.linkName = '/'+record.Id;
             record.linkNameVehicle = '/'+record.Driver__c;
             c.set("v.rsmList", recordstsmList);
                });
       
        var recordsrsmList = r.rsmList;
            recordsrsmList.forEach(function(record){
                    record.linkName = '/'+record.Id;
             record.linkNameVehicles = '/'+record.Driver__c;
             c.set("v.rsmList", recordsrsmList);
                });
       
       
       
          
             var rsmLists =r.rsmList;
      				if(rsmLists.length > 0){
                        rsmLists.forEach(function(record){
                            record.id = ''+record.Name;
                            if(record.Driver__r != undefined){
                                record.Driver__c = ''+record.Driver__c;
                                record.Driver__c = record.Driver__r.Name;
                            }
                            else{
                                 record.Driver__c=null;
                            }
                        });
                        
                    }
                    c.set("v.rsmList",rsmLists);
       
                    var tsmLists =r.tsmList;
                    if(tsmLists.length > 0){
                        tsmLists.forEach(function(record){
                            record.Name = ''+record.Name;
                            if(record.Driver__r != undefined){
                                record.Driver__c = ''+record.Driver__c;
                                record.Driver__c = record.Driver__r.Name;
                            }
                             else{
                                 record.Driver__c=null;
                            }
                        });
                        
                    }
      
             c.set("v.tsmList",tsmLists);
           
  
        });
    
c.set("v.rsmColumns",[
            
           {
             label : 'Shipping Manifest',   
          	type : 'url',
            sortable : true,    
            fieldName: 'linkName',
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
                type : 'date',typeAttributes:{day: 'numeric',  
                                                 month: 'numeric',  
                                                 year: 'numeric',
                                               hour: 'numeric',  
                                                minute: 'numeric',
                                                 }}, 
                                                                            
                
           
              {
                label : 'Route Miles',
                 	
                fieldName : 'Total_Route_Miles__c',
                type : 'number',
                sortable : true
            },
             {
                label : 'Driver',
                 type : 'url',
                sortable : true,
                  fieldName: 'linkNameVehicles',
             typeAttributes: {label: { fieldName: 'Driver__c',target: '_blank' },
                              tooltip: {fieldName: 'Driver__c'}}
    
            },
            
        ]);
                       
 c.set("v.tsmColumns",[
             
           {
             label : 'Shipping Manifest',   
          	type : 'url',
            sortable : true,    
            fieldName: 'linkName',
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
                label : 'Actual Arrival Date & Time',
                fieldName : 'Actual_Arrival_Date_Time__c',
                 sortable : true,
                type : 'date',typeAttributes:{day: 'numeric',  
                                                 month: 'numeric',  
                                                 year: 'numeric',
                                               hour: 'numeric',  
                                                minute: 'numeric',
                                                 }}, 
                                                                            
            {
                label : 'Route Miles',
                 	
                fieldName : 'Total_Route_Miles__c',
                type : 'number',
                sortable : true
            },
            {
                label : 'Driver',
                 type : 'url',
                sortable : true,
                  fieldName: 'linkNameVehicle',
             typeAttributes: {label: { fieldName: 'Driver__c',target: '_blank' },
                              tooltip: {fieldName: 'Driver__c'}}
    
            },
            
            
        ]);
     },      
  	
 /* retrieveVehicleAndRelatedRSMTSMs: function(c,e,h){
   h.request(c, 'retrieveVehicleAndRelatedRSMs', {order: c.get('v.rsmObj')}, function(r){
    
     console.log(r);
          c.set('v.rsmObj', r.rsmObj);    
            c.set('v.rsmList', r.rsmList);
           c.set('v.tsmList', r.tsmList);
            c.set('v.vehicleObj',r.vehicleObj);
  
       
             var tsmLists =r.tsmList;
                    if(tsmLists.length > 0){
                        tsmLists.forEach(function(record){
                            record.Name = ''+record.Name;
                            if(record.Driver__r != undefined){
                                record.Driver__c = ''+record.Driver__c;
                                record.Driver__c = record.Driver__r.Name;
                            }
                             else{
                                 record.Driver__c=null;
                            }
                        });
                        
                    }
      
             c.set("v.tsmList",tsmLists);
           
   
        });
                
c.set("v.tsmColumns",[
             
           {
             label : 'Shipping Manifest',   
          	type : 'url',
            sortable : true,    
            fieldName: 'Name',
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
                label : 'Actual Arrival Date & Time',
                fieldName : 'Actual_Arrival_Date_Time__c',
                 sortable : true,
                type : 'date',typeAttributes:{day: 'numeric',  
                                                 month: 'numeric',  
                                                 year: 'numeric',
                                               hour: 'numeric',  
                                                minute: 'numeric',
                                                 }}, 
                                                                            
            {
                label : 'Route Miles',
                 	
                fieldName : 'Total_Route_Miles__c',
                type : 'number',
                sortable : true
            },
            {
                label : 'Driver',
                 type : 'url',
                sortable : true,
                  fieldName: 'Driver__c',
             typeAttributes: {label: { fieldName: 'Driver__c',target: '_blank' },
                              tooltip: {fieldName: 'Driver__c'}}
    
            },
            
            
        ]);
     }, */
    
})