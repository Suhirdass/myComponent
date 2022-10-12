({
    sortData: function (cmp,event,data) {
        var fieldName = event.getParam('fieldName');
        var sortDirection = event.getParam('sortDirection');
        cmp.set("v.sortedBy", fieldName);
        cmp.set("v.sortedDirection", sortDirection);
        var reverse = sortDirection !== 'asc';
        data.sort(this.sortBy(fieldName, reverse)); 
        return data;
    },
    sortBy: function (field, reverse, primer) {
        var key = primer ? function(x) {return primer(x[field])} : function(x) {return x[field]};
        reverse = !reverse ? 1 : -1;
        return function (a, b) {
            return a = key(a), b = key(b), reverse * ((a > b) - (b > a));
        }
    },     
    setValues: function (c, r) {
        var h = this;
        c.set('v.rsmObj', r.rsmObj);    
        c.set('v.driverObj', r.driverObj);
        c.set('v.vehicleObj',r.vehicleObj);  
        c.set('v.Err_Msg_Select_Vehicle_Name', r.Err_Msg_Select_Vehicle_Name);
        c.set('v.Err_Msg_Select_Driver_Name', r.Err_Msg_Select_Driver_Name);
        c.set('v.Err_Msg_Select_Planned_Transfer_Date', r.Err_Msg_Select_Planned_Transfer_Date);
        c.set('v.Err_Msg_Select_Planned_Ship_Date', r.Err_Msg_Select_Planned_Ship_Date);
        c.set('v.Success_Msg_Assigned_Driver_Vehicle', r.Success_Msg_Assigned_Driver_Vehicle);
       
        
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
                record.linkNameVehicle = '/'+record.Driver__c;
            }else{
                record.Driver__c=null;
            } 
            if(record.Sales_Order__r != undefined){
                record.SO = '/'+record.Sales_Order__c;                        
                record.Sales_Order__c = record.Sales_Order__r.Name;
            }else{
                record.Sales_Order__c=null;
            }
            if(record.Receiver_License__r != undefined)
                record.RC = record.Receiver_License__r.License_City__c;
            else
                record.RC = null;
            
            for (var key in rsmTotalCVMap){
                if(key == record.Id){
                    record.totalCV = rsmTotalCVMap[key];
                    break;
                }
                else
                    record.totalCV = 0 ;
            }
        }); 
        c.set("v.rsmList", recordsrsmList);
        var tsmTotalCVMap = r.tsmTotalCVMap;            
        var tsmLists =r.tsmList;
        console.log('tsmLists ',tsmLists);
        console.log('recordsrsmList ',recordsrsmList);
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
                record.linkNameVehicle = null;
            }
            if(record.Purchase_Order__r != undefined){
                record.PO = '/'+record.Purchase_Order__c;
                record.Purchase_Order__c = record.Purchase_Order__r.Name;
            }else{
                record.Purchase_Order__c=null;
            }
            if(record.Supplier_License__r != undefined)
                record.SC = record.Supplier_License__r.License_City__c;
            else
                record.SC = null;
            
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
        c.set('v.totalCubicVolumePer',r.totalCubicVolumePer);
        c.set('v.totalOrderCubicVolumeCapacityPer',r.totalOrderCubicVolumeCapacityPer);
        c.set('v.estimatedVehiclUtilizedPer',r.estimatedVehiclUtilizedPer);
        c.set('v.dataLoaded',true);
    },
    setTableColumns: function (c) {
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
            /*{
                label : 'Actual Departure Date & Time',
                sortable : true,
                fieldName : 'Actual_Departure_Date_Time__c',
                type : 'date', typeAttributes:{
                    year: "numeric",
                    month: "numeric",
                    day: "numeric",
                    hour: "numeric",
                    minute: "numeric"
                }
            },*/
            {
                label : 'Receiver DBA',
                fieldName : 'Receiver_DBA__c',
                sortable : true,
                type : 'text'
            },
            {
                label :'Receiver City',
                fieldName : 'RC',
                sortable : true,
                type : 'text'
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
            			fieldName: 'Name',target: '_blank' 
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
                type : 'text'
            },
            /*{
                label : 'Actual Departure Date & Time',
                sortable : true,
                fieldName : 'Actual_Departure_Date_Time__c',
                type : 'date', typeAttributes:{
                    year: "numeric",
                    month: "numeric",
                    day: "numeric",
                    hour: "numeric",
                    minute: "numeric"
            	}
            },  */  
            {
                label : 'Supplier DBA',
                fieldName : 'Supplier_DBA__c',
                sortable : true,
                type : 'text'
            },
            {
                label :'Supplier City',
                fieldName : 'SC',
                sortable : true,
                type : 'text'
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
    showErrorMsg: function(title, type, msg){
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : title,
            message: msg,
            duration:' 5000',
            key: 'info_alt',
            type: type,
            mode: 'pester'
        });
        toastEvent.fire();
    }
})