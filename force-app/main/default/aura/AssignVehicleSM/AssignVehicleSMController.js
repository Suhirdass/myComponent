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
            c.set('v.refProductCount',r.refProductCount);
            c.set('v.totalCubicVolume',r.totalCubicVolume);
            c.set('v.totalOrderCubicVolumeCapacity',r.totalOrderCubicVolumeCapacity);
            c.set('v.estimatedVehiclUtilized',r.estimatedVehiclUtilized);
            c.set('v.assignedVehicleId',r.assignedVehicleId);
            c.set('v.assignedVehicleDate',r.assignedVehicleDate);
            c.set('v.isProductTSM',r.isProductTSM);
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
        h.request(c, 'retrieveVehicleAndRelatedRSMs', {order: c.get('v.rsmObj'),assignedVehicleId: c.get('v.assignedVehicleId'),assignedVehicleDateStr: c.get('v.assignedVehicleDate')}, function(r){
            console.log(r);
            c.set('v.rsmObj', r.rsmObj);    
            c.set('v.rsmList', r.rsmList);
            c.set('v.tsmList', r.tsmList);
            c.set('v.vehicleObj',r.vehicleObj);            
            var recordsrsmList = r.rsmList;
            var rsmTotalCVMap = r.rsmTotalCVMap;
            recordsrsmList.forEach(function(record){
                record.linkName = '/'+record.Id;
                if(record.Planned_Ship_Transfer_Date__c != undefined && record.Planned_Ship_Transfer_Date__c != null){
                	const dtList = record.Planned_Ship_Transfer_Date__c.split('-');
                    record.Planned_Ship_Transfer_Date__c = dtList[1] + '/' + dtList[2] + '/' + dtList[0];
                }
                if(record.Driver__r != undefined){
                    record.VM = '/'+record.Driver__c;
                    record.Driver__c = record.Driver__r.Name;
                }
                else{
                    record.Driver__c=null;
                }
                if(record.Sales_Order__r != undefined){
                    record.SO = '/'+record.Sales_Order__c;                        
                    record.Sales_Order__c = record.Sales_Order__r.Name;
                }
                else{
                    record.Sales_Order__c=null;
                }
                for (let key in rsmTotalCVMap){
                    if(key == record.Id){
                    	record.totalCV = rsmTotalCVMap[key];   
                        break;
                    }else                        
                    	record.totalCV = 0 ;    
                }
            }); 
            c.set("v.rsmList", recordsrsmList);          
            var tsmTotalCVMap = r.tsmTotalCVMap;
            var tsmLists =r.tsmList;
            tsmLists.forEach(function(record){
                record.linkName = '/'+record.Id;
                if(record.Planned_Ship_Transfer_Date__c != undefined && record.Planned_Ship_Transfer_Date__c != null){
                	const dtList = record.Planned_Ship_Transfer_Date__c.split('-');
                    record.Planned_Ship_Transfer_Date__c = dtList[1] + '/' + dtList[2] + '/' + dtList[0];
                }
                if(record.Driver__r != undefined){
                	record.Driver__c = record.Driver__r.Name;  
                    record.linkNameVehicle = '/'+record.Driver__c;
                }else{
                	record.Driver__c=null;   
                }
                if(record.Purchase_Order__r != undefined){
                    record.PO = '/'+record.Purchase_Order__c;
                    record.Purchase_Order__c = record.Purchase_Order__r.Name;
                }else
                    record.Purchase_Order__c=null;
                for (var key in tsmTotalCVMap){
                    if(key == record.Id){
                    	record.totalCV = tsmTotalCVMap[key];
                    	break;   
                    }
                    else
                        record.totalCV = 0 ;
                }
            });                          
            c.set("v.tsmList",tsmLists);
            c.set('v.totalCubicVolume',r.totalCubicVolume);
            c.set('v.totalOrderCubicVolumeCapacity',r.totalOrderCubicVolumeCapacity);
            c.set('v.estimatedVehiclUtilized',r.estimatedVehiclUtilized);            
        });        
        c.set("v.rsmColumns",[            
            {
                label : 'Sales Order',   
                type : 'url',
                sortable : true,    
                fieldName: 'SO',
                typeAttributes: {
                    label: { 
                        fieldName: 'Sales_Order__c',
                        target: '_blank' 
                    },
                    tooltip: {
                        fieldName: 'Sales_Order__c'
                    }
                } 
            },
            {
                label : 'Shipping Manifest',   
                type : 'url',
                sortable : true,    
                fieldName: 'linkName',
                typeAttributes: {
                    label: { 
                        fieldName: 'Name',
                        target: '_blank' 
                    },
                    tooltip: {
                        fieldName: 'Name'
                    }
                }                
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
                type : 'text',
            },             
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
                label : 'Total Lines',
                fieldName : 'Total_Line_Items__c',
                sortable : true,
                type : 'Integer'
            },                                 
            {
                label : 'Driver',
                type : 'url',
                sortable : true,
                fieldName: 'VM',
                typeAttributes: {
                    label: { 
                        fieldName: 'Driver__c',
                        target: '_blank' 
                    },
                    tooltip: {
                        fieldName: 'Driver__c'
                    }
                }                
            },
            {
                label : 'Route Miles',                
                fieldName : 'Total_Route_Miles__c',
                type : 'number',
                sortable : true
            },
            {
                label : 'Total CV',                
                fieldName : 'totalCV',
                type : 'number',
                sortable : true
            },            
        ]);            
		c.set("v.tsmColumns",[            
            {
            label : 'Purchase Order',   
                type : 'url',
                sortable : true,    
                fieldName: 'PO',
                typeAttributes: {
            		label: { 
            			fieldName: 'Purchase_Order__c',
            			target: '_blank' 
            		},
                	tooltip: {
            			fieldName: 'Purchase_Order__c'
            		}
            	}             
            },
            {
                label : 'Shipping Manifest',   
                type : 'url',
                sortable : true,    
                fieldName: 'linkName',
                typeAttributes: {
                    label: { 
                        fieldName: 'Name',
                        target: '_blank' 
                    },
                    tooltip: {
                    	fieldName: 'Name'
                    }
                }             
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
                type : 'text',
            },             
            {
                label : 'Actual Departure Date & Time',
                sortable : true,
                fieldName : 'Actual_Departure_Date_Time__c',
                type : 'date', 
                typeAttributes:{
                    year: "numeric",
                    month: "numeric",
                    day: "numeric",
                    hour: "numeric",
                    minute: "numeric"
                }
            },            
            {
                label : 'Total Lines',
                fieldName : 'Total_Line_Items__c',
                sortable : true,
                type : 'Integer'
            },            
            {
                label : 'Driver',
                type : 'url',
                sortable : true,
                fieldName: 'linkNameVehicle',
                typeAttributes: {
            		label: { 
            			fieldName: 'Driver__c',
            			target: '_blank' 
            		},
                	tooltip: {
            			fieldName: 'Driver__c'
            		}
                }            
            },
            {
                label : 'Route Miles',            
                fieldName : 'Total_Route_Miles__c',
                type : 'number',
                sortable : true
            },
            {
                label : 'Total CV',            
                fieldName : 'totalCV',
                type : 'number',
                sortable : true
            },            
        ]);        
    }, 
    onShippingManifestClick: function (c, e, h) {
        var id = e.currentTarget.dataset.id;
        window.open('/' + id);
    },
})